<%--
  Created by IntelliJ IDEA.
  User: danny
  Date: 2020/1/28
  Time: 18:51
  Desc: 登入后的页面
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户中心</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        request.setAttribute("path", basePath);
    %>
    <script src="${path}/mdui/js/mdui.min.js"></script>
    <link rel="stylesheet" href="${path}/mdui/css/mdui.min.css">
    <link rel="stylesheet" href="${path}/css/index-style.css">
</head>
<body class="mdui-loaded mdui-drawer-body-left">
<div class="mdui-appbar-with-toolbar mdui-theme-accent-pink mdui-theme-primary-indigo">
    <div class="mdui-appbar mdui-appbar-fixed">
        <div class="mdui-toolbar mdui-color-white mdui-color-theme">
            <button mdui-drawer="{target: '.mc-drawer', swipe: true}"
                    class="mdui-btn mdui-btn-icon mdui-ripple mdui-ripple-white"><i class="mdui-icon material-icons">menu</i>
            </button>
            <a class="mdui-typo-headline" href="/">超级简历</a>
            <div class="mdui-typo-title mdui-hidden-xs-down">首页</div>
            <div class="mdui-toolbar-spacer"></div>
            <div class="mc-login-btn mdui-btn mdui-btn-dense mdui-ripple mdui-ripple-white">
                欢迎你！${sessionScope.username}
            </div>
        </div>
    </div>
    <div class="mc-drawer mdui-drawer mdui-drawer-open">
        <ul class="mdui-list">
            <li class="mdui-list-item mdui-ripple">
                <i class="mdui-list-item-icon mdui-icon material-icons">person</i>
                <div class="mdui-list-item-content">简历管理</div>
            </li>
            <li class="mdui-list-item mdui-ripple">
                <i class="mdui-list-item-icon mdui-icon material-icons">group_add</i>
                <div class="mdui-list-item-content">邮箱设置</div>
            </li>
            <li class="mdui-list-item mdui-ripple">
                <i class="mdui-list-item-icon mdui-icon material-icons">group_add</i>
                <div class="mdui-list-item-content">其他设置</div>
            </li>
        </ul>
    </div>
</body>
</html>
