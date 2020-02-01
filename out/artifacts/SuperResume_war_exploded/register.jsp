<%--
  Created by IntelliJ IDEA.
  User: danny
  Date: 2020/1/28
  Time: 20:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        request.setAttribute("path", basePath);
    %>
    <script src="${path}/mdui/js/mdui.min.js"></script>
    <link rel="stylesheet" href="${path}/mdui/css/mdui.css">
    <link rel="stylesheet" href="${path}/css/register-style.css">
</head>
<body>
<!-- 注册 -->
<div class="mdui-card mc-register mdui-shadow-24">
    <div class="mdui-dialog-title mdui-color-teal-800 mdui-text-color-white mc-dialog-banner mdui-clearfix">
        <br><br><br><br>
        <p>创建新账号</p>
    </div>
    <form class="login-form" method="post" action="user/insertUser">
        <div class="mdui-textfield mdui-textfield-floating-label mdui-textfield-has-bottom">
            <label class="mdui-textfield-label">用户名</label>
            <input class="mdui-textfield-input" name="username" type="text" required="">
        </div>
        <div class="mdui-textfield mdui-textfield-floating-label mdui-textfield-has-bottom">
            <label class="mdui-textfield-label">密码</label>
            <input class="mdui-textfield-input" name="password" type="password" required="">
        </div>
        <div class="actions mdui-clearfix">
            <button type="submit" class="mdui-btn mdui-btn-raised mdui-color-theme-accent mdui-float-right">注册</button>
        </div>
    </form>
</div>
</body>
</html>
