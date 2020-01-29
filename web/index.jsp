<%--
  Created by IntelliJ IDEA.
  User: kiser
  Date: 2020/1/27
  Time: 9:47
  Desc: 简介页面，有登陆按钮和注册按钮
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        request.setAttribute("path", basePath);
    %>
    <script src="${path}/mdui/js/mdui.min.js"></script>
    <link rel="stylesheet" href="${path}/mdui/css/mdui.min.css">
    <link rel="stylesheet" href="${path}/css/index-style.css">
<%--    <link rel="stylesheet"--%>
<%--          href="https://www.mdui.org/static/home/default/dist/css/app.0ffb3331a8eb5d052581c4b8cf5e1a70.css">--%>
<%--    <link rel="stylesheet"--%>
<%--          href="https://www.mdui.org//static/home/default/dist/css/vendor.57f492fe4d88c7538803b152fe84a7ca.css">--%>
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
                <a href="login.jsp">
                    登陆
                </a>
            </div>
            <div class="mc-register-btn mdui-btn mdui-btn-dense mdui-ripple mdui-ripple-white">
                <a href="register.jsp">
                    注册
                </a>
            </div>
        </div>
    </div>
    <div class="mc-drawer mdui-drawer mdui-drawer-open">
        <ul class="mdui-list">
            <li class="mdui-list-item mdui-ripple">
                <i class="mdui-list-item-icon mdui-icon material-icons">person</i>
                <div class="mdui-list-item-content">登陆</div>
            </li>
            <li class="mdui-list-item mdui-ripple">
                <i class="mdui-list-item-icon mdui-icon material-icons">group_add</i>
                <div class="mdui-list-item-content">注册</div>
            </li>
        </ul>
    </div>
    <div class="page-index">
        <!-- 大标题 -->
        <div class="main-section mdui-color-theme">
            <div class="mc-container mdui-container mdui-clearfix">
                <p class="title-chs">超级简历</p>
                <p class="title-eng">Super Resumé</p>
                <h4>一款强大的简历投递管理平台，低门槛开箱即用的简历管理解决方案</h4>
            </div>
        </div>
        <!-- 介绍卡片 -->
        <div class="card-section">
            <div class="mdui-container-fluid mc-card-container">
                <div class="mdui-row mc-card-row">
                    <div class="mdui-col-sm-6 mdui-col-md-4">
                        <div class="mdui-card">
                            <div class="mdui-card-media">
                                <img src="${path}/img/card-0.jpg"/>
                                <div class="mdui-card-media-covered mdui-card-media-covered-transparent">
                                    <div class="mdui-card-primary">
                                        <div class="mdui-card-primary-title">Title</div>
                                        <div class="mdui-card-primary-subtitle">Subtitle</div>
                                    </div>
                                </div>
                            </div>
                            <div class="mdui-card-content">子曰：「学而时习之，不亦说乎？有朋自远方来，不亦乐乎？人不知，而不愠，不亦君子乎？」</div>
                        </div>
                    </div>
                    <div class="mdui-col-sm-6 mdui-col-md-4">
                        <div class="mdui-card">
                            <div class="mdui-card-media">
                                <img src="${path}/img/card-1.jpg"/>
                                <div class="mdui-card-media-covered mdui-card-media-covered-transparent">
                                    <div class="mdui-card-primary">
                                        <div class="mdui-card-primary-title">Title</div>
                                        <div class="mdui-card-primary-subtitle">Subtitle</div>
                                    </div>
                                </div>
                            </div>
                            <div class="mdui-card-content">子曰：「学而时习之，不亦说乎？有朋自远方来，不亦乐乎？人不知，而不愠，不亦君子乎？」</div>
                        </div>
                    </div>
                    <div class="mdui-col-sm-6 mdui-col-md-4">
                        <div class="mdui-card">
                            <div class="mdui-card-media">
                                <img src="${path}/img/card-2.jpg"/>
                                <div class="mdui-card-media-covered mdui-card-media-covered-transparent">
                                    <div class="mdui-card-primary">
                                        <div class="mdui-card-primary-title">Title</div>
                                        <div class="mdui-card-primary-subtitle">Subtitle</div>
                                    </div>
                                </div>
                            </div>
                            <div class="mdui-card-content">子曰：「学而时习之，不亦说乎？有朋自远方来，不亦乐乎？人不知，而不愠，不亦君子乎？」</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<footer class="copyright-section">
    <div class="mdui-container copyright-container">
        <div class="mdui-row mc-footer-row">
            <div class="mdui-col-sm-12 mdui-col-xs-12">
                <ul>
                    <li><h4>超级简历</h4></li>
                    <li>超级简历贼牛，你可以通过捐赠的形式来帮助发展该项目。</li>
                </ul>
            </div>
        </div>
        <div class="mdui-divider-light footer-divider"></div>
        <div class="footer-copyright">Copyright © 2020 - 2020 <a href="./">resume.com</a> All rights reserved.</div>
    </div>
</footer>

</body>

</html>
