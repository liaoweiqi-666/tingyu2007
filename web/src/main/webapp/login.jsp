<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    //   http://localhost:8080/tingyu/
%>
<html>
<head>
    <title>Tingyu登录页面</title>
    <%--设置页面基础路径，以后页面的所有跳转和样式js的引入全部基于这个基础路径--%>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/icon.css">
    <script type="text/javascript" src="static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>


<form id="adminForm" method="post" action="admin/login.do">
    <div style="width: 402px;margin: auto;height: 100%;margin-top: 50px;">
        <div  class="easyui-panel" title="Ting域主持人系统后台登录页面" style="width: 400px;padding: 30px 50px">
            <span style="color: red;">${errorMsg}</span>
            <div style="width: 100%">
                <input required data-options="missingMessage:'账号不能为空'" style="height:40px;width: 100%" prompt="请输入登录账号" class="easyui-textbox" name="aname">
            </div>
            <div style="margin-top: 30px;width: 100%">
                <input required data-options="missingMessage:'密码不能为空'" style="height:40px;width: 100%" prompt="请输入密码" class="easyui-passwordbox" name="apwd">
            </div>
            <div style="margin-top: 30px;width: 100%">
                <a onclick="loginFun();" href="javascript:void(0)" style="height:40px;width: 100%" class="easyui-linkbutton" >登录</a>
            </div>
        </div>
    </div>
</form>

<script type="text/javascript">

    function loginFun() {

        var isValid = $("#adminForm").form('validate');

        if (isValid) {
            $("#adminForm").submit();
        }

    }

</script>
</body>
</html>
