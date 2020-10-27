<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    //   http://localhost:8080/tingyu/
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

<table id="hostDataGrid" fit="true"></table>


<%--顶部搜索框--%>
<div id="hostTb" style="padding:2px 5px;">
    <form id="hostSearchForm" action="host/list.do" method="post">
        <input class="easyui-textbox" name="hname" prompt="请输入姓名(可不写)" style="width:110px">
        <select data-options="editable:false," class="easyui-combobox" name="status" panelHeight="auto"
                style="width:100px">
            <option value="">状态</option>
            <option value="0">禁用</option>
            <option value="1">正常</option>
        </select>
        <select data-options="editable:false" class="easyui-combobox" name="strong" panelHeight="auto"
                style="width:100px">
            <option value="">权重</option>
            <option value="0">权重降序</option>
            <option value="1">权重升序</option>
        </select>
        <select data-options="editable:false" class="easyui-combobox" name="ordernumber" panelHeight="auto"
                style="width:120px">
            <option value="">订单排序</option>
            <option value="0">订单量降序</option>
            <option value="1">订单量升序</option>
        </select>
        <select data-options="editable:false" class="easyui-combobox" name="hpstar" panelHeight="auto"
                style="width:100px">
            <option value="">星推荐</option>
            <option value="1">是</option>
            <option value="0">否</option>
        </select>
        <select data-options="editable:false" class="easyui-combobox" name="hpdiscount" panelHeight="auto"
                style="width:100px">
            <option value="">折扣</option>
            <option value="9">9折</option>
            <option value="8">8折</option>
            <option value="7">7折</option>
            <option value="6">6折</option>
        </select>
        <a href="javascript:void(0);" onclick="hostSearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
    </form>
</div>

<%--定义操作头部按钮--%>
<div id="header">
    <a class="easyui-linkbutton" onclick="openHostWindow();" data-options="iconCls:'icon-add',plain:true">添加</a>
    <a class="easyui-linkbutton" onclick="settingPower()" data-options="iconCls:'icon-tip',plain:true">权限设置</a>
    <a class="easyui-linkbutton" onclick="chanageHostStatus()" data-options="iconCls:'icon-lock',plain:true">启用/禁用账号</a>
</div>


<%--主持人权限设置窗口--%>
<div id="hostPowerWindow" data-options="modal:true,closed:true" class="easyui-window" style="height: 500px;width: 500px;padding: 30px 30px">
    <form id="hostPowerForm" method="post" >
        <%--隐藏域，打开窗口将选中主持人id设置--%>
        <input id="hostids" type="hidden" name="hostids">

        <div style="width: 90%">
            <label style="margin-right: 20px">星推荐&nbsp;&nbsp;&nbsp;</label>
            <input class="easyui-radiobutton" data-options="labelWidth:40,labelPosition:'after'" name="hpstar" value="1" label="是">
            <input class="easyui-radiobutton" data-options="labelWidth:40,labelPosition:'after'" name="hpstar" value="0" label="否">
        </div>
        <div style="margin-top: 30px;width: 90%">
            <label style="margin-right: 20px">星推荐有效期</label>
            <input name="hpstartBegindate" class="easyui-datebox" style="width: 30%">-
            <input name="hpstarEnddate" class="easyui-datebox" style="width: 30%">
        </div>

        <div style="margin-top: 30px;width: 90%">
            <label style="margin-right: 20px">自添订单</label>
            <input class="easyui-radiobutton" data-options="labelWidth:60,labelPosition:'after'" name="hpOrderPower" value="1" label="允许">
            <input class="easyui-radiobutton" data-options="labelWidth:60,labelPosition:'after'" name="hpOrderPower" value="0" label="不允许">
        </div>
        <div style="margin-top: 30px;width: 90%">
            <label style="margin-right: 20px">星推荐有时间</label>
            <input data-options="showSeconds:true,min:'08:30:00',max:'18:00:00'" value="08:30:00"  name="hpstarBegintime"  class="easyui-timespinner" style="width: 30%">-
            <input data-options="showSeconds:true,max:'18:00:00'" value="18:00:00"  name="hpstarEndtime" class="easyui-timespinner" style="width: 30%">
        </div>
        <div style="margin-top: 30px;width: 90%">
            <input required data-options="label:'折扣'" style="width: 100%" class="easyui-textbox" name="hpdiscount">
        </div>
        <div style="margin-top: 30px;width: 90%">
            <label style="margin-right: 20px">折扣时间</label>
            <input name="hpDisStarttime" class="easyui-datebox" style="width: 30%">-
            <input name="hpDisEndtime" class="easyui-datebox" style="width: 30%">
        </div>
        <div style="margin-top: 30px;width: 90%">
            <input required data-options="label:'价格'" style="width: 100%" class="easyui-textbox" name="hpprice">
        </div>
        <div style="margin-top: 30px;width: 90%">
            <input required data-options="label:'管理费'" style="width: 100%" class="easyui-textbox" name="hpcosts">
        </div>

        <div style="margin-top: 30px;width: 90%">
            <a onclick="hostPowerSet();" href="javascript:void(0)" style="width: 100%" class="easyui-linkbutton" >提交</a>
        </div>
    </form>
</div>



<%--新增主持人对话框--%>
<div id="hostWindow" data-options="closed:true" title="新增主持人" class="easyui-window"
     style="width: 400px;padding: 30px 30px">
    <form class="easyui-form" id="hostForm" method="post">
        <div style="width: 100%">
            <input required data-options="label:'姓名'" style="width: 100%" class="easyui-textbox" name="hname">
        </div>
        <div style="margin-top: 30px;width: 100%">
            <input required data-options="label:'手机号'" style="width: 100%" class="easyui-textbox" name="hphone">
        </div>
        <%--<div style="margin-top: 30px;width: 100%">
            <input required data-options="label:'邮箱',validType:'email'" style="width: 100%" class="easyui-textbox" name="aname">
        </div>--%>
        <div style="margin-top: 30px;width: 100%">
            <input required data-options="label:'密码',showEye:false" style="width: 100%" class="easyui-passwordbox"
                   name="hpwd">
        </div>
        <div style="margin-top: 30px;width: 100%">
            <a onclick="insertHost();" href="javascript:void(0)" style="width: 100%" class="easyui-linkbutton">提交</a>
        </div>
    </form>
</div>

<script type="text/javascript">

    /*settingPower*/

    function settingPower(){
        //获取选中的行
        var rows = $("#hostDataGrid").datagrid("getChecked");

        if (rows.length == 0) {
            $.messager.alert("温馨提示", "至少选中一行数据", 'warning');
            return false;
        }



        //将选中列的主持人的名称设置为window的标题title

        //循环主持人
        var hnames = [];//封装主持人的名称显示 window标题
        var hids  = [];//封装主持人的id用于修改主持人提交给后台
        $.each(rows,function (index,host) {
            hnames.push(host.hname);
            hids.push(host.hid);
        })

        //将主持人id设置给 id=hostids隐藏域
        $("#hostids").val(hids.toString());


        //让修改主持人权限窗口显示
        $("#hostPowerWindow").window({
            title:hnames.toString()+"设置权限",
            closed:false
        });

    }

    /*提交主持人权限设置表单函数*/
    function hostPowerSet() {

        $('#hostPowerForm').form('submit', {
            url:"hostPower/hostPowerSet.do",
            onSubmit: function(){

                return $(this).form("validate");
            },
            success:function(data){
                var json = JSON.parse(data);


                //重置表单
                $("#hostPowerForm").form("reset");
                //关闭window窗口
                $("#hostPowerWindow").window("close")

                //刷新datagrid
                $("#hostDataGrid").datagrid("reload");

                //提示
                $.messager.alert("温馨提示",json.msg,'info');

            }
        });
    }

    /*改变主持人状态 启用，禁用*/
    function chanageHostStatus() {

        var rows = $("#hostDataGrid").datagrid("getChecked");
        if (rows.length == 0) {
            $.messager.alert("温馨提示", "至少选中一行数据", 'warning');
            return false;
        }
        if (rows.length > 1) {
            $.messager.alert("温馨提示", "每次操作一个主持人", 'warning');
            return false;
        }

        //获取主持人信息
        var host = rows[0];

        /*使用ajax异步修改主持人状态*/
        $.post("host/changeStatus.do", {hid: host.hid, status: host.status}, function (data) {
            $.messager.alert("温馨提示",data.msg,"info");
            //刷新datagrid
            $("#hostDataGrid").datagrid("reload");
        })


    }

    /*点击添加按钮弹出添加主持人对话框*/
    function openHostWindow() {
        $("#hostWindow").window("open");
    }

    /*新增主持人函数*/
    function insertHost() {
        $('#hostForm').form('submit', {
            url: "host/insert.do",
            onSubmit: function () {
                var isValid = $(this).form('validate');
                return isValid;
            },
            success: function (data) {
                var json = JSON.parse(data);
                if (json.code == 200) {
                    //弹出消息框
                    $.messager.alert("温馨提示", json.msg, 'info');

                    //重置表单
                    $("#hostForm").form("reset")
                    //关闭对话框
                    $("#hostWindow").window("close");

                    //刷新datagrid
                    $("#hostDataGrid").datagrid("reload");
                }
            }
        });
    }


    /*表单搜索函数*/
    function hostSearch() {

        //使用jquery.serializejson 序列化表单
        var formData = $("#hostSearchForm").serializeJSON();


        //执行datagrid的重新加载方法

        $('#hostDataGrid').datagrid('load', formData);

    }


    /*修改主持人权重*/
    function changeHostStrong(object,hid){
        //获取文本框的权重值
        var strong = $(object).val();

        /*使用ajax异步修改主持人状态*/
        $.post("host/changeStrong.do", {hid: hid, strong:strong}, function (data) {
            $.messager.alert("温馨提示",data.msg,"info");
            //刷新datagrid
            $("#hostDataGrid").datagrid("reload");
        })

    }



    $(function () {
        /*初始化datagrid*/
        $('#hostDataGrid').datagrid({
            pagination: true,
            checkOnSelect: false,
            selectOnCheck: false,
            singleSelect: true,
            striped: true,
            toolbar: "#header",/*设置顶部的搜索框工具条*/
            header: "#hostTb",
            url: 'host/list.do',


            columns: [[
                {field: 'hid', title: '选中', width: 100, checkbox: true},
                {
                    field: 'strong', title: '权重', width: 100, formatter: function (value, row, index) {
                        return '<input onchange="changeHostStrong(this,'+row.hid+');" style="width: 100%" value="' + value + '">';
                    }
                },
                {field: 'hname', title: '主持人姓名', width: 100},
                {field: 'hphone', title: '主持人电话', width: 100},

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
                {field: 'hprice', title: '价格', width: 100},
                {field: 'hpdiscount', title: '折扣', width: 100},
                {
                    field: 'hpstar', title: '星推荐', width: 100, formatter: function (value, row, index) {
                        return value == 1 ? "是" : "否";
                    }
                },
                {
                    field: 'status', title: '状态', width: 100, formatter: function (value, row, index) {
                        return value == 0 ? " <span style='color:red'>禁用</span>" : " <span style='color:green'>启用</span>";
                    }
                }
            ]]
        });

    })

</script>
</body>
</html>
