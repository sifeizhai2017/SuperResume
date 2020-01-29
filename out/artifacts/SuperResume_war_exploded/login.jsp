<%--
  Created by IntelliJ IDEA.
  User: danny
  Date: 2020/1/28
  Time: 20:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        request.setAttribute("path", basePath);
    %>
    <script src="${path}/mdui/js/mdui.min.js"></script>
    <link rel="stylesheet" href="${path}/mdui/css/mdui.css">
    <link rel="stylesheet" href="${path}/css/login-style.css">
</head>
<body>
<!-- 登陆 -->
<div class="mdui-card mc-login mdui-shadow-24">
    <div class="mdui-dialog-title mdui-color-indigo mc-dialog-banner">
        <br><br><br><br>
        <p>登录</p>
    </div>
    <form class="login-form" action="user/userLogin" method="post">
        <label>${sessionScope.msg}</label>
        <div class="mdui-textfield mdui-textfield-floating-label mdui-textfield-has-bottom mdui-textfield-invalid-html5">
            <label class="mdui-textfield-label">用户名或邮箱</label>
            <input class="mdui-textfield-input" name="username" type="text" required="">
            <div class="mdui-textfield-error">账号不能为空</div>
        </div>
        <div class="mdui-textfield mdui-textfield-floating-label mdui-textfield-has-bottom"><label
                class="mdui-textfield-label">密码</label>
            <input class="mdui-textfield-input" name="password" type="password" required="">
            <div class="mdui-textfield-error">密码不能为空</div>
        </div>
        <div class="actions mdui-clearfix">
            <button class="mdui-btn mdui-ripple more-option" type="button"
                    mdui-menu="{target: '#mc-login-menu', position: 'top', covered: true}">
                更多选项
            </button>
            <ul class="mdui-menu" id="mc-login-menu">
                <li class="mdui-menu-item"><a class="mdui-ripple mc-password-reset-trigger">忘记密码</a></li>
                <li class="mdui-menu-item"><a class="mdui-ripple mc-register-trigger">创建新账号</a></li>
            </ul>
            <button type="submit" class="mdui-btn mdui-btn-raised mdui-color-theme-accent mdui-float-right">登录</button>
        </div>
    </form>
</div>
</body>
</html>
