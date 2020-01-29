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
    <link rel="stylesheet" href="${path}/css/user-style.css">
</head>
<body class="mdui-loaded mdui-drawer-body-left">
<div class="mdui-appbar-with-toolbar mdui-theme-accent-pink mdui-theme-primary-indigo">
    <div class="mdui-appbar mdui-appbar-fixed mdui-shadow-24">
        <div class="mdui-toolbar mdui-color-white mdui-color-theme">
            <button mdui-drawer="{target: '.mc-drawer', swipe: true}"
                    class="mdui-btn mdui-btn-icon mdui-ripple mdui-ripple-white"><i class="mdui-icon material-icons">menu</i>
            </button>
            <a class="mdui-typo-headline" href="${path}">超级简历</a>
            <div class="mdui-typo-title mdui-hidden-xs-down">首页</div>
            <div class="mdui-toolbar-spacer"></div>
            <img class="mdui-card-header-avatar" src="//www.mdui.org/docs/assets/docs/img/avatar1.jpg"/>
            <div class="mc-login-btn mdui-btn mdui-btn-dense mdui-ripple mdui-ripple-white">
                欢迎你！${sessionScope.username}
            </div>
        </div>
    </div>
    <div class="mc-drawer mdui-drawer mdui-drawer-open mdui-shadow-24">
        <img src="${path}/img/user-bg.jpg" alt="">
        <ul class="mdui-list">
            <li class="mdui-list-item mdui-ripple mdui-text-color-theme mdui-list-item-active">
                <i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-theme">home</i>
                <div class="mdui-list-item-content">首页</div>
            </li>
            <li class="mdui-list-item mdui-ripple">
                <i class="mdui-list-item-icon mdui-icon material-icons">account_balance</i>
                <div class="mdui-list-item-content">简历管理</div>
            </li>
            <li class="mdui-list-item mdui-ripple">
                <i class="mdui-list-item-icon mdui-icon material-icons">email</i>
                <div class="mdui-list-item-content">邮箱设置</div>
            </li>
            <li class="mdui-list-item mdui-ripple">
                <i class="mdui-list-item-icon mdui-icon material-icons">account_circle</i>
                <div class="mdui-list-item-content">其他设置</div>
            </li>
        </ul>
    </div>
    <!-- 主要部分 -->
    <div class="page-index">
        <div class="breadcrumb-section mdui-color-theme">
            <div class="mc-container mdui-container mdui-clearfix">
                <p class="title-chs">超级简历</p>
                <p class="title-eng">Super Resumé</p>
                <h4>一款强大的简历投递管理平台，低门槛开箱即用的简历管理解决方案</h4>
            </div>
        </div>
    </div>
</div>

</body>
</html>
