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
    <script type="text/javascript" src="static/jquery.serializejson/jquery.serializejson.min.js"></script>
</head>
<body>

<%--datagrid--%>
<table id="marriedPersonDataGrid"></table>


<%--搜索表单--%>
<div id="marriedPersonHeader" style="padding:2px 5px;">
    <form id="marriedPersonSearchForm">
        <input  name="pname" class="easyui-textbox" prompt="新人姓名" style="width:110px">
        <input  name="phone" class="easyui-textbox" prompt="新人手机" style="width:110px">
        <a href="javascript:void(0);"  onclick="marriedPersonSearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
    </form>
</div>

<script type="text/javascript">

    /*新人搜索按钮函数*/
    function marriedPersonSearch(){

        //序列化表单
        var formData = $("#marriedPersonSearchForm").serializeJSON();

        //重新加载datagrid
        $("#marriedPersonDataGrid").datagrid("reload",formData);

    }




    $(function () {

        /*初始化datagrid*/
        $('#marriedPersonDataGrid').datagrid({
            pagination: true,
            checkOnSelect: false,
            selectOnCheck: true,
            singleSelect: true,
            striped: true,
            header: "#marriedPersonHeader",
            url: 'married/list.do',


            columns: [[
                {field: 'pid',checkbox: true},
                {field: 'pname', title: '新人名称', width: 100},
                {field: 'phone', title: '新人电话', width: 100},
                {field: 'pmail', title: '新人邮箱', width: 100},

                {
                    field: 'marrydate', title: '结婚日期', width: 100, formatter: function (value, row, index) {
                        return value.year + "-" + value.monthValue + "-" + value.dayOfMonth;
                    }
                },
                {
                    field: 'regdate', title: '注册日期', width: 100, formatter: function (value, row, index) {
                        return value.year + "-" + value.monthValue + "-" + value.dayOfMonth;
                    }
                },
                {
                    field: 'status', title: '状态', width: 100, formatter: function (value, row, index) {
                       if (value == 1)
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
