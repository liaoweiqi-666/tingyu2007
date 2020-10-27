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
    <script type="text/javascript" src="static/ztree/js/jquery.ztree.core.js"></script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',split:true" class="easyui-layout" style="height:100px;">

    <div data-options="region:'west',border:false" style="background:red;width:25%;height:100%;background-image:url('static/images/bg.png')">
        
        <img src="static/images/logo.png" style="margin-top: 30px">

    </div>
    <div data-options="region:'center',border:false" style="padding-top:30px;text-align: center;width:50%;height:100%;background-image:url('static/images/bg.png')">

        <span style="color: white;font-size: 25px;">Ting&nbsp;&nbsp;域&nbsp;&nbsp;主&nbsp;&nbsp;持&nbsp;&nbsp;人&nbsp;&nbsp;后&nbsp;&nbsp;台&nbsp;&nbsp;管&nbsp;&nbsp;理&nbsp;&nbsp;系&nbsp;&nbsp;统</span>

    </div>
    <%--子绝父相--%>
    <div data-options="region:'east',border:false" style="width:25%;height:100%;background-image:url('static/images/bg.png');position: relative">

        <div style="color:white;position: absolute;bottom: 10px;right: 20px">
            你好，${admin.aname} <a style="color: white" href="">退出</a>
        </div>

    </div>

</div>
<div data-options="region:'south',split:true" style="height:50px;text-align: center">
    Ting域主持人
</div>
<div data-options="region:'west',split:true" style="width:200px;">

    <ul id="menuTreee" class="ztree"></ul>


</div>

<%--中间编辑区域--%>
<div data-options="region:'center',split:true">
    <%--选项卡--%>
        <div id="tt" class="easyui-tabs" fit="true">
            <div title="欢迎页面" style="padding:20px;display:none;">
                欢迎使用Ting域主持人管理系统
            </div>

        </div>

</div>

<script type="text/javascript">
    /*zTree的设置对象，配置zTree的初始化信息*/
    var setting = {
        /*数据初始化配置*/
        data: {
            /*支持简单数据*/
            simpleData: {
                enable: true,
                idKey: "mid",
                pIdKey: "pid",
            },
            key: {
                /*设置节点名称*/
                name: "mname",
                /*设置节点跳转的url地址属性，如果有，点击节点就会跳转，如果没有就不会跳转*/
                url: "xUrl"
            }
        },
        /*异步加载数据*/
        async: {
            enable: true,
            url: "menu/selectMenuByLoginAdmin.do",
            /*预处理加载的数据*/
            dataFilter: ajaxDataFilter
        },
        /*各种事件回调*/
        callback: {
            /*菜单单机事件回调*/
            onClick: zTreeOnClick
        }
    };

    /*菜单数据单击回调函数*/
    function zTreeOnClick(event, treeId, treeNode) {
        /*判断选项卡是否有对应的标签，有选中，没有创建新的标签*/
        if($("#tt").tabs("exists",treeNode.mname)){
            $("#tt").tabs("select",treeNode.mname);
        }else{
            $('#tt').tabs('add',{
                title:treeNode.mname,
                content:"<iframe style='width:100%;height: 100%;border: 0' src='"+treeNode.url+"'>",
                closable:true,
            });
        }


    };

    /*预处理数据调用的函数，在此函数内部预处理数据*/
    function ajaxDataFilter(treeId, parentNode, responseData) {
        if (responseData) {
            for(var i =0; i < responseData.length; i++) {
                responseData[i].open = true;
            }
        }
        return responseData;
    };

    /*初始化zTree*/
    $(function () {
        $.fn.zTree.init($("#menuTreee"), setting);
    })

</script>
</body>
</html>
