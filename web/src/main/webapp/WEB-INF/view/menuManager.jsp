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
<body class="easyui-layout">
<div data-options="region:'west'" title="操作" style="width:180px;text-align: center;padding-top: 50px;" >

    <a href="javascript:void(0)" onclick="addMenu()" style="width: 100px;margin-bottom: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增菜单</a><br>
    <a href="javascript:void(0)" onclick="editMenu()" style="width: 100px;margin-bottom: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑菜单</a><br>
    <a href="javascript:void(0)" onclick="deleteMenu()" style="width: 100px;margin-bottom: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除菜单</a><br>
    <a href="javascript:void(0)" onclick="reloadMenu()" style="width: 100px;margin-bottom: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">刷新菜单</a>

</div>


<div data-options="region:'center'" title="当前系统菜单" >


    <%--zTree ul--%>
        <ul id="menuTree" class="ztree"></ul>
</div>


<%--菜单操作窗口--%>
<div id="menuWindow" data-options="closed:true,modal:true" class="easyui-window" style="width: 400px;padding: 30px 30px">
    <form id="menuForm" method="post" >
        <%--修改菜单id--%>
        <input  name="mid" type="hidden">

        <div style="width: 100%;margin-top: 30px;">
            <input id="parentMenu" name="pid" class="easyui-combobox" style="width:100%;"  data-options="valueField:'mid',textField:'mname',label:'父菜单'" >
        </div>
        <div style="width: 100%;margin-top: 30px;">
            <input required data-options="label:'菜单名称'" style="width: 100%" class="easyui-textbox" name="mname">
        </div>
        <div style="margin-top: 30px;width: 100%">
            <input  data-options="label:'菜单地址'" style="width: 100%" class="easyui-textbox" name="url">
        </div>
        <div style="margin-top: 30px;width: 100%">
            <input required data-options="label:'菜单描述'" style="width: 100%" class="easyui-textbox" name="mdesc">
        </div>
        <div style="margin-top: 30px;width: 100%">
            <a onclick="saveOrUpdateMenu();" href="javascript:void(0)" style="width: 100%" class="easyui-linkbutton" >提交</a>
        </div>
    </form>
</div>


<script type="text/javascript">

    $(function () {
        $("#parentMenu").combobox({
            url:"menu/list.do",
            /*预处理数据*/
            loadFilter:function (data) {
                var parentData = {mid:0,mname:"顶级菜单"};
                //向返回数据最前面添加一个顶级菜单
                data.unshift(parentData);

                return data;
            }
        })
    })

    /*删除菜单按钮函数*/
    function deleteMenu() {

        //获取树对象
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
        //获取选中的节点
        var nodes = treeObj.getSelectedNodes();
        /*没有选中给出提示*/
        if(nodes.length == 0){
            $.messager.alert("温馨提示","请选择一个需要删除的菜单",'warning');
            return false;
        }

        $.messager.confirm("温馨提示","您确定删除此菜单?",function (r) {

            if(r){
                //获取选中节点对应菜单数据
                var menu = nodes[0];

                $.post("menu/delete.do",{mid:menu.mid},function (data) {

                    /*重新加载zTree*/
                    reloadMenu();

                    /*弹出提示消息框*/
                    $.messager.alert("温馨提示",data.msg,'info');

                })


            }

        })
    }

    /*新增和修改菜单函数*/
    function saveOrUpdateMenu() {

        $("#menuForm").form("submit",{
            url:"menu/saveOrUpdate.do",
            onSubmit: function(){
                var isValid = $(this).form('validate');
                return isValid;
            },
            success: function(data){

                var json = JSON.parse(data);

                //1.重置表单
                $("#menuForm").form("reset");

                //2.关闭窗口
                $("#menuWindow").window("close");

                //3.刷新ztree
                reloadMenu();

                //4.弹出消息框
                $.messager.alert("温馨提示",json.msg,"info");

            }
        })

    }


    /*编辑修改菜单按钮函数*/
    function editMenu() {
        /*重置表单*/
        $("#menuForm").form("reset");
        //获取树对象
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
        //获取选中的节点
        var nodes = treeObj.getSelectedNodes();
        /*没有选中给出提示*/
        if(nodes.length == 0){
            $.messager.alert("温馨提示","必须选择一个需要修改的菜单",'warning');
            return false;
        }

        //获取选中节点对应菜单数据
        var menu = nodes[0];

        /*表单回显数据*/
        $("#menuForm").form("load",menu);

        /*显示window*/
        $("#menuWindow").window({
            closed:false,
            title:"修改菜单"
        })





    }


    /*新增菜单按钮函数*/
    function addMenu() {

        $("#parentMenu").combobox("reload")


        /*重置表单*/
        $("#menuForm").form("reset");

        $("#menuWindow").window({
            closed:false,
            title:"新增菜单"
        })
    }

    /*刷新菜单按钮函数*/
    function reloadMenu() {
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
        treeObj.reAsyncChildNodes(null, "refresh");
    }

    /*zTree的初始化设置对象*/
    var setting = {
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

</body>
</html>
