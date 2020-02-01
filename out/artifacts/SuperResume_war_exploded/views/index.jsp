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
            <img class="mdui-card-header-avatar mdui-img-circle" src="${path}/img/user-bg.jpg"/>
            <div class="mc-login-btn mdui-btn mdui-btn-dense mdui-ripple mdui-ripple-white">
                欢迎你！${sessionScope.username}
            </div>
        </div>
    </div>
    <div class="mc-drawer mdui-drawer mdui-drawer-open mdui-shadow-10">
        <img src="${path}/img/user-bg.png" alt="">
        <ul class="mdui-list">
            <a href="${path}/views/index.jsp">
                <li class="mdui-list-item mdui-ripple mdui-text-color-theme mdui-list-item-active">
                    <i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-theme">home</i>
                    <div class="mdui-list-item-content">首页</div>
                </li>
            </a>
            <a href="${path}/views/mailsystem.jsp">
                <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons">account_balance</i>
                    <div class="mdui-list-item-content">邮件系统</div>

                </li>
            </a>
            <a href="javascript:;">
                <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons">date_range</i>
                    <div class="mdui-list-item-content">日程管理</div>
                </li>
            </a>
            <a href="javascript:;">
                <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons">date_range</i>
                    <div class="mdui-list-item-content">简历生成</div>
                </li>
            </a>
            <a href="${path}/views/settings.jsp">
                <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons">settings</i>
                    <div class="mdui-list-item-content">设置</div>
                </li>
            </a>
        </ul>
    </div>
    <!-- 主要部分 -->
    <div class="page-index">
        <div class="header-section mdui-color-theme">
            <div class="mc-container mdui-container mdui-clearfix mdui-valign">
                <p>用户中心</p>
            </div>
        </div>
        <div class="info-list">
            <div class="index-source">
                <p class="article-title mdui-text-color-pink mdui-typo-display-1">简历管理</p>
                <div class="article-content">
                    <div><p class="mdui-typo-subheading-opacity">简历管理中包含一个简单的邮件系统，您能够在这里发送简历邮件并收到企业的回复</p></div>
                    <button class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme-accent">点击进入</button>
                </div>
                <br><br>
                <div class="mdui-divider"></div>
            </div>
            <div class="index-source">
                <p class="article-title mdui-text-color-pink mdui-typo-display-1">日程管理</p>
                <div class="article-content">
                    <div><p class="mdui-typo-subheading-opacity">日程管理记录您发出邮件以及企业的回复</p></div>
                    <button class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme-accent">点击进入</button>
                </div>
                <br><br>
                <div class="mdui-divider"></div>
            </div>
            <div class="index-source">
                <p class="article-title mdui-text-color-pink mdui-typo-display-1">简历生成</p>
                <div class="article-content">
                    <div><p class="mdui-typo-subheading-opacity">通过向导生成一个简洁的markdown简历</p></div>
                    <button class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme-accent">点击进入</button>
                </div>
                <br><br>
                <div class="mdui-divider"></div>
            </div>
        </div>
        <div class="footer-nav mdui-color-theme">
            <div class="mdui-container"></div>
        </div>
    </div>
    <!-- 没考虑好怎么用，先放在这里 -->
    <button class="mdui-fab mdui-fab-fixed mdui-ripple mdui-color-pink"><i class="mdui-icon material-icons">add</i>
    </button>
</div>
</body>
</html>
