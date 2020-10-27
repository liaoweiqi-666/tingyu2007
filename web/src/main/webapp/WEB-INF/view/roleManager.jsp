<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    //   http://localhost:8080/tingyu/
%>
<html>
<head>
    <title>Ting域主持人后台管理</title>
    <%--设置页面基础路径，以后页面的所有跳转和样式js的引入全部基于这个基础路径--%>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/icon.css">
    <link rel="stylesheet" href="static/ztree/css/metroStyle/metroStyle.css" type="text/css">
    <script type="text/javascript" src="static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="static/ztree/js/jquery.ztree.all.js"></script>
    <script type="text/javascript" src="static/jquery.serializejson/jquery.serializejson.min.js"></script>
</head>


<body>


<%--新增修改角色窗口 window--%>
<div id="roleWindod" data-options="closed:true" class="easyui-window" style="width: 1000px;height: 500px">

    <div id="cc" class="easyui-layout" fit="true">
        <div data-options="region:'west',title:'角色基本信息',split:true" style="width:50%;padding: 50px">

            <form id="roleForm" class="easyui-form" method="post">
                <input name="rid" type="hidden">
                <div style="width: 100%">
                    <input required data-options="label:'角色名称'" style="width: 100%" class="easyui-textbox" name="rname">
                </div>
                <div style="margin-top: 20px;width: 100%">
                    <input required data-options="label:'角色描述'" style="width: 100%" class="easyui-textbox" name="rdesc">
                </div>

                <div style="margin-top: 20px;width: 100%">
                    <a onclick="saveOrUpdateRole();" href="javascript:void(0)" style="width: 100%" class="easyui-linkbutton" >提交</a>
                </div>
            </form>

        </div>
        <div data-options="region:'center',title:'当前系统菜单'" style="padding:5px;background:#eee;">


            <%--zTree ul--%>
            <ul id="menuTree" class="ztree"></ul>

        </div>
    </div>
</div>


<%--角色表格datagrid--%>
<table id="roleDataGrid"></table>

<%--linkbutton--%>
<div id="toolbar">
    <a id="add"  href="javascript:void(0);" class="easyui-linkbutton"  data-options="{iconCls:'icon-add',plain:true}">添加</a>
    <a id="update" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-edit',plain:true}">修改</a>
    <a id="delete" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-remove',plain:true}">删除</a>
</div>


<%--zTree相关js代码--%>
<script type="text/javascript">
    /*zTree的初始化设置对象*/
    var setting = {
        /*设置显示复选框*/
        check: {
            enable: true
        },
        data: {
            /*支持简单数据（列表）*/
            simpleData: {
                enable: true,
                /*设置zTree节点id的数据名称*/
                idKey: "mid",
                /*设置zTree节点父id的数据名称*/
                pIdKey: "pid",
            },
            key: {
                /*设置zTree的节点数据名称*/
                name: "mname",
                url: "xUrl"
            }
        },
        /*异步请求*/
        async: {
            enable: true,
            url:"menu/list.do",
            /*预处理加载数据*/
            dataFilter: filter
        }
    };

    /*预处理函数*/
    function filter(treeId, parentNode, childNodes) {
        if (!childNodes) return null;
        for (var i=0, l=childNodes.length; i<l; i++) {
            childNodes[i].open = true;
            //childNodes[i].icon = "static/ztree/css/zTreeStyle/img/diy/5.png";

            console.log(childNodes[i]);
        }
        return childNodes;
    }


    /*初始化zTree*/
    $(function () {
        $(document).ready(function(){
            $.fn.zTree.init($("#menuTree"), setting);
        });
    })

</script>

<script type="text/javascript">




    /*新增或者修改角色函数*/
    function saveOrUpdateRole(){

        //1.获取zTree选中的节点数据id值
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
        var nodes = treeObj.getCheckedNodes(true);

        if(nodes.length == 0){
            $.messager.alert("温馨提示","最少分配一个菜单","warning");
            return false;
        }

        //声明菜单id数据
        var mids = [];
        $.each(nodes,function (index,menu) {
            mids.push(menu.mid);
        })
        console.log(mids);


        $("#roleForm").form("submit",{
            url:"role/saveOrUpdate.do",
            onSubmit: function(param){
                /*额外添加一个菜单id*/
                param.mids = mids.toString();

                var isValid = $(this).form('validate');
                return isValid;
            },
            success: function(data){

                var json = JSON.parse(data);


                //1.重置表单
                $("#roleForm").form("reset");

                //2.关闭窗口
                $("#roleWindod").window("close");

                //3.刷新datagrid
                $("#roleDataGrid").datagrid("reload");

                //4.弹出消息框
                $.messager.alert("温馨提示",json.msg,"info");
            }
        })






    }



    $(function () {


        /*删除按钮绑定函数*/
        $("#delete").click(function () {
            var rows = $("#roleDataGrid").datagrid("getChecked");
            if (rows.length == 0) {
                $.messager.alert("温馨提示", "至少选中一行数据", 'warning');
                return false;
            }
            //获取选中数据
            var role = rows[0];

            //提示
            $.messager.confirm("温馨提示","您确定删除此角色？删除以后不可恢复！！！",function (r) {
                if(r){
                    $.post("role/deleteByIdRid.do",{rid:role.rid},function (data) {
                        //1.刷新datagrid
                        $("#roleDataGrid").datagrid("reload");

                        //2.弹出消息框
                        $.messager.alert("温馨提示",data.msg,"info");
                    })

                }
            })


        })



        /*修改按钮绑定函数*/
        $("#update").click(function () {

            var rows = $("#roleDataGrid").datagrid("getChecked");
            if (rows.length == 0) {
                $.messager.alert("温馨提示", "至少选中一行数据", 'warning');
                return false;
            }

            //获取选中数据
            var role = rows[0];

            //回显表单
            $("#roleForm").form("load",role);

            //打开窗口
            $("#roleWindod").window({
                closed: false,
                title:"修改 "+role.rname
            })

            /*发送ajax异步请求根据角色id查询出对应的菜单的id，并且回显到zTree树节点*/
            $.get("roleMenu/selectRoleMenuByRid.do",{rid:role.rid},function (data) {
                //[1, 5, 6, 7, 17, 18, 19, 20, 21, 2, 8, 3, 9, 10, 11, 12, 13, 4, 14, 15, 16]
                /**
                 *
                 * zTree回显思路
                 *
                 * 1，根据返回的数据找到对应的节点
                 *  根据节点的mid属性的值获对应的节点
                 *
                 * 2，让其选中
                 *
                 *
                 */
                console.log(data);
                //获取树对象
                var treeObj = $.fn.zTree.getZTreeObj("menuTree");

                 //循环数组获取每一个mid的值
                 $.each(data,function (index,mid) {
                    //获取mid对应的节点
                     var node = treeObj.getNodeByParam("mid", mid, null);
                     console.log(node);
                     //让其选中
                     treeObj.checkNode(node, true, false);

                 })


            })


        })


        /*新增按钮绑定函数*/
        $("#add").click(function () {
            /*重置zTree*/
            var treeObj = $.fn.zTree.getZTreeObj("menuTree");
            treeObj.reAsyncChildNodes(null, "refresh");

            /*重置表单*/
            $("#roleForm").form("reset");

            //显示窗口
            $("#roleWindod").window({
                title:"新增角色",
                closed:false
            })
        })



        /*初始化datagrid*/
        $('#roleDataGrid').datagrid({
            pagination: true,
            checkOnSelect: false,
            selectOnCheck: true,
            singleSelect: true,
            striped: true,
            toolbar: "#toolbar",
            url: 'role/list.do',

            columns: [[
                {field: 'rid', checkbox: true},
                {field: 'rname', title: '角色名称', width: 100},
                {field: 'rdesc', title: '角色描述', width: 200}
            ]]
        });

    })
</script>
</body>
</html>
