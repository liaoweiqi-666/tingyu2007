<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <%--设置页面基础路径，以后页面的所有跳转和样式js的引入全部基于这个基础路径--%>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/icon.css">
    <link rel="stylesheet" href="static/ztree/css/metroStyle/metroStyle.css" type="text/css">
    <script type="text/javascript" src="static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="static/ztree/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="static/jquery.serializejson/jquery.serializejson.min.js"></script>
</head>
<body>

<table id="companyDataGrid"></table>


<%--新增修改婚庆公司窗口--%>
<div id="companyWindow" data-options="closed:true" class="easyui-window" style="width: 400px;padding: 30px 30px">
    <form id="companyForm" class="easyui-form" method="post" >
        <input name="cid" type="hidden">
        <div style="width: 100%">
            <input required data-options="label:'公司名称'" style="width: 100%" class="easyui-textbox" name="cname">
        </div>
        <div style="margin-top: 20px;width: 100%">
            <input required data-options="label:'公司法人'" style="width: 100%" class="easyui-textbox" name="ceo">
        </div>

        <div style="margin-top: 20px;width: 100%">
            <input id="cpwd" required data-options="label:'密码',showEye:false" style="width: 100%" class="easyui-passwordbox" name="cpwd">
        </div>
        <div style="margin-top: 20px;width: 100%">
            <input id="cpwd1" validType="equals['#cpwd']" required data-options="label:'确认密码',showEye:false"  style="width: 100%" class="easyui-passwordbox" name="cpwd1">
        </div>
        <div style="margin-top: 20px;width: 100%">
            <input required data-options="label:'邮箱',validType:'email'" style="width: 100%" class="easyui-textbox" name="cmail">
        </div>
        <div style="margin-top: 20px;width: 100%">
            <input required data-options="label:'手机'" style="width: 100%" class="easyui-textbox" name="cphone">
        </div>
        <div style="margin-top: 20px;width: 100%">
            <a onclick="saveOrUpdateCompany();" href="javascript:void(0)" style="width: 100%" class="easyui-linkbutton" >提交</a>
        </div>
    </form>
</div>


<%--搜索表单--%>
<div id="companyTb" style="padding:2px 5px;">
    <form id="companySearchForm" class="easyui-form" action="host/list.do" method="post">
        <input  name="cname" class="easyui-textbox" prompt="公司名称（可不填）" style="width:110px">
        <select data-options="editable:false," class="easyui-combobox" name="status" panelHeight="auto"  style="width:100px">
            <option value="">账号状态</option>
            <option value="0">未审核</option>
            <option value="1">正常</option>
            <option value="2">禁用</option>
        </select>
        <select data-options="editable:false" class="easyui-combobox" name="ordernumber" panelHeight="auto" style="width:120px">
            <option value="">订单排序</option>
            <option value="0">订单量降序</option>
            <option value="1">订单量升序</option>
        </select>
        <a href="javascript:void(0);"  onclick="companySearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        <a href="javascript:void(0);"  onclick="resetForm();" class="easyui-linkbutton" iconCls="icon-cancel">重置</a>
    </form>
</div>

<%--linkbutton--%>
<div id="tt">
    <a id="add"  href="javascript:void(0);" class="easyui-linkbutton"  data-options="{iconCls:'icon-add',plain:true}">添加</a>
    <a id="edit" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-edit',plain:true}">编辑</a>
    <a id="planner" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-tip',plain:true}">策划师列表</a>
    <a id="disable" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-clear',plain:true}">禁用启用账号</a>
    <a id="check" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-redo',plain:true}">账号审核</a>
</div>


<%--策划师列表窗口--%>
<div id="plannerWindow" data-options="closed:true"  data-options="modal:true" class="easyui-window" style="width: 80%;height: 60%">

    <%--策划师表格--%>
    <table id="plannerDatagrid" class="easyui-datagrid" data-options="pagination:true" style="width: 100%;height: 100%"></table>

</div>


<script type="text/javascript">


    $(function () {

        /*策划师列表按钮绑定函数*/
        $("#planner").click(function () {
            /*获取选中行的数据*/
            var rows = $("#companyDataGrid").datagrid("getChecked");
            if(rows.length == 0){
                $.messager.alert("温馨提示", "最少选中一个公司", 'warning');
                return false;
            }
            //获取公司
            var company = rows[0];
            //显示策划师列表window
            $("#plannerWindow").window({
                closed:false,
                title:company.cname+"策划师列表"
            })

            /*加载策划师列表的数据*/
            $("#plannerDatagrid").datagrid({
                pagination: true,
                checkOnSelect: false,
                selectOnCheck: true,
                singleSelect: true,
                pageList:[2,10,20,30,40,50],
                striped: true,
                url: 'planner/list.do?cid='+company.cid,


                columns: [[
                    {field: 'nid'},
                    {field: 'nname', title: '策划师姓名', width: 100},
                    {field: 'nphone', title: '策划师电话', width: 100},
                    {
                        field: 'addtime', title: '添加时间', width: 100, formatter: function (value, row, index) {
                            return value.year + "-" + value.monthValue + "-" + value.dayOfMonth;
                        }
                    },
                    {field: 'ordernumber', title: '订单数量', width: 100},
                    {
                        field: 'status', title: '状态', width: 100, formatter: function (value, row, index) {
                            return value == 0 ? " <span style='color:#ff0000'>禁用</span>" : " <span style='color:green'>启用</span>";
                        }
                    }
                ]]
            })


        })

        /*禁用启用按钮绑定函数*/
        $("#disable").click(function () {

            /*获取选中行的数据*/
            var rows = $("#companyDataGrid").datagrid("getChecked");
            if(rows.length == 0){
                $.messager.alert("温馨提示", "最少选中一个公司", 'warning');
                return false;
            }
            //获取公司
            var company = rows[0];

            $.messager.confirm('温馨提示', '亲，您确定要禁用启用此公司?', function(r){
                if (r){
                    $.post("company/changeStatus.do",{cid:company.cid,status:company.status},function (data) {
                        //1.刷新datagrid
                        $("#companyDataGrid").datagrid("reload");
                        //2.弹出消息框
                        $.messager.alert("温馨提示",data.msg,"info");
                    })
                }
            });
        })
        /*审核账号按钮绑定函数*/
        $("#check").click(function () {

            /*获取选中行的数据*/
            var rows = $("#companyDataGrid").datagrid("getChecked");
            if(rows.length == 0){
                $.messager.alert("温馨提示", "最少选中一个公司", 'warning');
                return false;
            }
            //获取公司
            var company = rows[0];
            if (company.status != 0){
                $.messager.alert("温馨提示", "此公司已经审核，不需要再次审核", 'warning');
                return false;
            }

            $.messager.confirm('温馨提示', '亲，您确定要审核通过此公司?', function(r){
                if (r){

                    $.post("company/changeStatus.do",{cid:company.cid,status:company.status},function (data) {
                        //1.刷新datagrid
                        $("#companyDataGrid").datagrid("reload");
                        //2.弹出消息框
                        $.messager.alert("温馨提示",data.msg,"info");
                    })

                }
            });

        })
        /*自定义校验规则，密码和确认密码必须相同*/
        $.extend($.fn.validatebox.defaults.rules, {
            equals: {
                validator: function(value,param){
                    return value == $(param[0]).val();
                },
                message: '两次密码不相同'
            }
        });

        /*添加婚庆公司按钮绑定函数*/
        $("#add").click(function () {

            /*显示编辑公司窗口*/
            $("#companyWindow").window({
                closed:false,
                title:"新增婚庆公司"
            })

        });
        /*修改婚庆公司按钮绑定函数*/
        $("#edit").click(function () {

            /*获取选中行的数据*/
            var rows = $("#companyDataGrid").datagrid("getChecked");
            if(rows.length == 0){
                $.messager.alert("温馨提示", "最少选中一个公司", 'warning');
                return false;
            }

            /*显示编辑公司窗口*/
            $("#companyWindow").window({
                closed:false,
                title:"修改婚庆公司"
            })

            /*获取公司信息*/
            var company = rows[0];
            //设置一个确认密码属性，回显的时候让确认密码也回显
            company.cpwd1=company.cpwd;

            /*回显表单*/
            $("#companyForm").form("load",company);


        })
    })


    /*新增或者修改婚庆公司*/
    function saveOrUpdateCompany() {

        $("#companyForm").form("submit",{
            url:"company/saveOrUpdate.do",
            onSubmit: function(){
                var isValid = $(this).form('validate');
                return isValid;
            },
            success: function(data){

                var json = JSON.parse(data);

                //1.重置表单
                $("#companyForm").form("reset");

                //2.关闭窗口
                $("#companyWindow").window("close");

                //3.刷新datagrid
                $("#companyDataGrid").datagrid("reload")

                //4.弹出消息框
                $.messager.alert("温馨提示",json.msg,"info");

            }
        })

    }



    /*重置表单函数*/
    function resetForm() {
        $("#companySearchForm").form("reset");
    }

    /*婚庆公司搜索表单提交按钮函数*/
    function companySearch(){

        //序列化表单
        var formData = $("#companySearchForm").serializeJSON();


        //调用datagrid 的 load方法

        $("#companyDataGrid").datagrid("load",formData);


    }


    $(function () {
        /*初始化datagrid*/
        $('#companyDataGrid').datagrid({
            pagination: true,
            checkOnSelect: false,
            selectOnCheck: true,
            singleSelect: true,
            striped: true,
            toolbar: "#tt",
            header: "#companyTb",
            url: 'company/list.do',


            columns: [[
                {field: 'cid', checkbox: true},
                {field: 'cname', title: '公司名称', width: 100},
                {field: 'ceo', title: '公司法人', width: 100},
                {field: 'cphone', title: '公司法人电话', width: 100},
                {field: 'cmail', title: '公司邮箱', width: 100},

                /**
                 * formatter 将列进行格式化
                 * 函数返回一个字符串，渲染到datagrid的列上，可以渲染解析html内容
                 *
                 * */
                {
                    field: 'starttime', title: '注册日期', width: 100, formatter: function (value, row, index) {
                        return value.year + "-" + value.monthValue + "-" + value.dayOfMonth;
                    }
                },
                {field: 'ordernumber', title: '订单数量', width: 100},
                {
                    field: 'status', title: '状态', width: 100, formatter: function (value, row, index) {

                        if (value == 0)
                            return "<span style='color:red'>未审核</span>";
                        else if (value == 1)
                            return "<span style='color:green'>正常</span>";
                        else if (value == 2)
                            return "<span style='color:red'>禁用</span>";
                    }
                }
            ]]
        });

    })


</script>

</body>
</html>
