<%--
  Created by IntelliJ IDEA.
  User: danny
  Date: 2020/2/8
  Time: 09:16
  Desc: 创建成功，下载
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>创建成功</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        request.setAttribute("path", basePath);
    %>
    <script src="${path}/mdui/js/mdui.min.js"></script>
    <link rel="stylesheet" href="${path}/mdui/css/mdui.min.css">
    <link rel="stylesheet" href="${path}/css/guide-style.css">
</head>
<body class="mdui-loaded mdui-drawer-body-left">
<div class="mdui-appbar-with-toolbar mdui-theme-accent-pink mdui-theme-primary-indigo">
    <div class="mdui-appbar mdui-appbar-fixed mdui-shadow-24">
        <div class="mdui-toolbar mdui-color-white mdui-color-theme">
            <button mdui-drawer="{target: '.mc-drawer', swipe: true}"
                    class="mdui-btn mdui-btn-icon mdui-ripple mdui-ripple-white"><i class="mdui-icon material-icons">menu</i>
            </button>
            <a class="mdui-typo-headline" href="${path}">超级简历</a>
            <div class="mdui-typo-title mdui-hidden-xs-down">简历生成</div>
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
                <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons">home</i>
                    <div class="mdui-list-item-content">首页</div>
                </li>
            </a>
            <a href="../resume/updateInbox">
                <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons">account_balance</i>
                    <div class="mdui-list-item-content">邮件系统</div>

                </li>
            </a>
            <a href="${path}/views/schedule.jsp">
                <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons">date_range</i>
                    <div class="mdui-list-item-content">日程管理</div>
                </li>
            </a>
            <a href="${path}/views/guide.jsp">
                <li class="mdui-list-item mdui-ripple  mdui-text-color-theme mdui-list-item-active">
                    <i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-theme">web</i>
                    <div class="mdui-list-item-content">简历生成</div>
                </li>
            </a>
            <a href="../user/getUserFromSession">
                <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons">settings</i>
                    <div class="mdui-list-item-content">设置</div>
                </li>
            </a>
        </ul>
    </div>
    <div class="page-index">
        <div class="guide-container">
            <div class="mdui-typo-display-1 mdui-text-color-theme">生成成功</div>
            <br>
            <div class="mdui-divider"></div>
            <br>
            <div class="mdui-typo-subheading-opacity"><a href="../resume/testHttpMessageDown">点击此处</a>可以下载</div>
        </div>
        <br><br><br>
        <div class="advice-container">
            <div class="mdui-typo-display-1 mdui-text-color-pink">是否需要招聘网站？</div>
            <br>
            <div class="mdui-divider"></div>
            <br>
            <div class="mdui-row">
                <div class="mdui-col-lg-3">
                    <div class="mdui-card">
                        <div class="mdui-card-media">
                            <img src="../img/website-logo/shangzhao.png"/>
                            <div class="mdui-card-media-covered mdui-card-media-covered-gradient">
                            </div>
                        </div>
                        <div class="mdui-card-actions">
                            <button class="mdui-btn mdui-ripple">action 1</button>
                            <button class="mdui-btn mdui-ripple">action 2</button>
                        </div>
                    </div>
                </div>
                <div class="mdui-col-lg-3">
                    <div class="mdui-card">
                        <div class="mdui-card-media">
                            <img src="../img/website-logo/51job.jpg"/>
                            <div class="mdui-card-media-covered mdui-card-media-covered-gradient">
                            </div>
                        </div>
                        <div class="mdui-card-actions">
                            <button class="mdui-btn mdui-ripple">action 1</button>
                            <button class="mdui-btn mdui-ripple">action 2</button>
                        </div>
                    </div>
                </div>
                <div class="mdui-col-lg-3">
                    <div class="mdui-card">
                        <div class="mdui-card-media">
                            <img src="../img/website-logo/58tongcheng.jpg"/>
                            <div class="mdui-card-media-covered mdui-card-media-covered-gradient">
                            </div>
                        </div>
                        <div class="mdui-card-actions">
                            <button class="mdui-btn mdui-ripple">action 1</button>
                            <button class="mdui-btn mdui-ripple">action 2</button>
                        </div>
                    </div>
                </div>
                <div class="mdui-col-lg-3">
                    <div class="mdui-card">
                        <div class="mdui-card-media">
                            <img src="../img/website-logo/boss.png"/>
                            <div class="mdui-card-media-covered mdui-card-media-covered-gradient">
                            </div>
                        </div>
                        <div class="mdui-card-actions">
                            <button class="mdui-btn mdui-ripple">action 1</button>
                            <button class="mdui-btn mdui-ripple">action 2</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mdui-row">
                <div class="mdui-col-lg-3">
                    <div class="mdui-card">
                        <div class="mdui-card-media">
                            <img src="../img/website-logo/chinahr.jpg"/>
                            <div class="mdui-card-media-covered mdui-card-media-covered-gradient">
                            </div>
                        </div>
                        <div class="mdui-card-actions">
                            <button class="mdui-btn mdui-ripple">action 1</button>
                            <button class="mdui-btn mdui-ripple">action 2</button>
                        </div>
                    </div>
                </div>
                <div class="mdui-col-lg-3">
                    <div class="mdui-card">
                        <div class="mdui-card-media">
                            <img src="../img/website-logo/lagou.jpg"/>
                            <div class="mdui-card-media-covered mdui-card-media-covered-gradient">
                            </div>
                        </div>
                        <div class="mdui-card-actions">
                            <button class="mdui-btn mdui-ripple">action 1</button>
                            <button class="mdui-btn mdui-ripple">action 2</button>
                        </div>
                    </div>
                </div>
                <div class="mdui-col-lg-3">
                    <div class="mdui-card">
                        <div class="mdui-card-media">
                            <img src="../img/website-logo/zhilian.jpg"/>
                            <div class="mdui-card-media-covered mdui-card-media-covered-gradient">
                            </div>
                        </div>
                        <div class="mdui-card-actions">
                            <button class="mdui-btn mdui-ripple">action 1</button>
                            <button class="mdui-btn mdui-ripple">action 2</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>
