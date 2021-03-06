<%--
  Created by IntelliJ IDEA.
  User: danny
  Date: 2020/1/29
  Time: 20:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户设置</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        request.setAttribute("path", basePath);
    %>
    <script src="${path}/mdui/js/mdui.min.js"></script>
    <link rel="stylesheet" href="${path}/mdui/css/mdui.min.css">
    <link rel="stylesheet" href="${path}/css/settings-style.css">
</head>
<body class="mdui-loaded mdui-drawer-body-left">
<div class="mdui-appbar-with-toolbar mdui-theme-accent-pink mdui-theme-primary-indigo">
    <div class="mdui-appbar mdui-appbar-fixed mdui-shadow-24">
        <div class="mdui-toolbar mdui-color-white mdui-color-theme">
            <button mdui-drawer="{target: '.mc-drawer', swipe: true}"
                    class="mdui-btn mdui-btn-icon mdui-ripple mdui-ripple-white"><i class="mdui-icon material-icons">menu</i>
            </button>
            <a class="mdui-typo-headline" href="${path}">超级简历</a>
            <div class="mdui-typo-title mdui-hidden-xs-down">设置</div>
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
            <a href="${path}/views/mailsystem.jsp">
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
                <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons">web</i>
                    <div class="mdui-list-item-content">简历生成</div>
                </li>
            </a>
            <a href="../user/getUserFromSession">
                <li class="mdui-list-item mdui-ripple mdui-text-color-theme mdui-list-item-active">
                    <i class="mdui-list-item-icon mdui-icon material-icons  mdui-text-color-theme">settings</i>
                    <div class="mdui-list-item-content">设置</div>
                </li>
            </a>
        </ul>
    </div>
    <div class="page-index">
        <div class="breadcrumb-section mdui-color-theme mdui-clearfix">
            <div class="mc-container mdui-container mdui-clearfix mdui-valign">
                <p class="title mdui-typo-display-2">修改资料</p>
            </div>
        </div>
        <div class="password-settings">
            <div class="mdui-container">
                <div class="mdui-row mdui-clearfix">
                    <!-- 账号信息显示 -->
                    <div class="account-info-section mdui-col-md-6 mdui-col-lg-6 mdui-col-xs-12">
                        <div class="mdui-card">
                            <div class="mdui-card-media">
                                <img src="../img/userinfo-bg.jpg"/>
                                <div class="mdui-card-media-covered">
                                    <div class="mdui-card-primary">
                                        <div class="mdui-card-primary-title">用户信息</div>
                                        <div class="mdui-card-primary-subtitle">User Info</div>
                                        <p>用户名：${sessionScope.username}</p>
                                        <p>邮箱地址：${requestScope.user.emailAddr}</p>
                                        <p>IMAP服务器：${requestScope.user.imapServer}</p>
                                        <p>SMTP服务器：${requestScope.user.smtpServer}</p>
                                        <p>POP3服务器：${requestScope.user.pop3Server}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="mdui-card-actions">
                                <a href="../user/getUserFromSession">
                                <button class="mdui-btn mdui-ripple">刷新</button>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- 账户设置 -->
                    <div class="account-section mdui-col-md-6 mdui-col-lg-6 mdui-col-xs-12">
                        <div class="mdui-card">
                            <div class="mdui-chip">
                                <span class="mdui-chip-icon mdui-color-indigo">M</span>
                                <span class="mdui-chip-title">密码修改</span>
                            </div>
                            ${requestScope.pwdMsg}
                            <form class="mdui-card-content" action="../user/updateUserPassword" method="post">
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">输入旧密码</label>
                                    <input class="mdui-textfield-input" type="password" name="oldPwd"/>
                                </div>
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">输入新密码</label>
                                    <input class="mdui-textfield-input" type="password" name="newPwd"/>
                                </div>
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">确认密码</label>
                                    <input class="mdui-textfield-input" type="password" name="confirmPwd"/>
                                </div>
                                <button class="mdui-btn mdui-btn-block mdui-color-theme-accent mdui-ripple"
                                        type="submit">提交
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <br>
                <div class="mdui-row second-row">
                    <!-- 邮箱服务器设置 -->
                    <div class="server-section">
                        <div class="mdui-card mdui-col-md-6 mdui-col-lg-6 mdui-col-xs-12 mdui-clearfix">
                            <div class="mdui-chip">
                                <span class="mdui-chip-icon mdui-color-indigo">A</span>
                                <span class="mdui-chip-title">邮箱服务器设置</span>
                            </div>
                            ${requestScope.svrMsg}
                            <form class="mdui-card-content">
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">IMAP服务器</label>
                                    <input class="mdui-textfield-input" type="text" name="imapServer"/>
                                </div>
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">POP3服务器</label>
                                    <input class="mdui-textfield-input" type="text" name="pop3Server"/>
                                </div>
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">SMTP服务器</label>
                                    <input class="mdui-textfield-input" type="text" name="smtpServer"/>
                                </div>
                                <button class="mdui-btn mdui-btn-block mdui-color-theme-accent mdui-ripple"
                                        type="submit">提交
                                </button>
                            </form>
                        </div>
                    </div>
                    <!-- 邮箱账户设置 -->
                    <div class="mail-account-section mdui-col-md-6 mdui-col-lg-6 mdui-col-xs-12 mdui-clearfix">
                        <div class="mdui-card">
                            <div class="mdui-chip">
                                <span class="mdui-chip-icon mdui-color-indigo">E</span>
                                <span class="mdui-chip-title">邮箱账户设置</span>
                            </div>
                            ${requestScope.emailMsg}
                            <form class="mdui-card-content" action="../user/updateEmail" method="post">
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">邮箱账号</label>
                                    <input class="mdui-textfield-input" type="email" name="emailAddr"/>
                                </div>
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">邮箱密码</label>
                                    <input class="mdui-textfield-input" type="password" name="emailPwd"/>
                                </div>
                                <button class="mdui-btn mdui-btn-block mdui-color-theme-accent mdui-ripple"
                                        type="submit">提交
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-nav mdui-color-theme">
        <div class="mdui-container">
        </div>
    </div>
</div>

</body>
</html>
