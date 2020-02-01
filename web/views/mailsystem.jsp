<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="com.resume.mail.ReceiveMailSSL" %>
<%@ page import="javax.mail.Flags" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeUtility" %>
<%--
  Created by IntelliJ IDEA.
  User: danny
  Date: 2020/1/30
  Time: 14:23
  Desc: markdown简历生成器
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
    <link rel="stylesheet" href="${path}/mdui/css/mdui.min.css">
    <link rel="stylesheet" href="${path}/css/mail-style.css">
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
            <li class="mdui-list-item mdui-ripple">
                <i class="mdui-list-item-icon mdui-icon material-icons">home</i>
                <div class="mdui-list-item-content"><a href="${path}/views/index.jsp">首页</a></div>
            </li>
            <li class="mdui-list-item mdui-ripple mdui-text-color-theme mdui-list-item-active">
                <i class="mdui-list-item-icon mdui-icon material-icons  mdui-text-color-theme">account_balance</i>
                <div class="mdui-list-item-content"><a href="${path}/views/mailsystem.jsp">邮件系统</a></div>
            </li>
            <li class="mdui-list-item mdui-ripple">
                <i class="mdui-list-item-icon mdui-icon material-icons">date_range</i>
                <div class="mdui-list-item-content">日程管理</div>
            </li>
            <li class="mdui-list-item mdui-ripple">
                <i class="mdui-list-item-icon mdui-icon material-icons">date_range</i>
                <div class="mdui-list-item-content">简历生成</div>
            </li>
            <li class="mdui-list-item mdui-ripple">
                <i class="mdui-list-item-icon mdui-icon material-icons">settings</i>
                <div class="mdui-list-item-content"><a href="${path}/views/settings.jsp">设置</a></div>
            </li>
        </ul>
    </div>
    <!-- 主要部分 -->
    <div class="page-index">
        <div class="tab-section mdui-color-theme mdui-shadow">
            <div class="mdui-container">
                <div class="mdui-tab mdui-color-theme mdui-tab-centered" mdui-tab>
                    <a href="#inbox" class="mdui-ripple mdui-ripple-white">
                        <i class="mdui-icon material-icons">inbox</i>
                        <label>收件箱</label>
                    </a>
                    <a href="#send" class="mdui-ripple mdui-ripple-white">
                        <i class="mdui-icon material-icons">send</i>
                        <label>发件箱</label>
                    </a>
                </div>
            </div>
        </div>
        <div id="inbox" class="mdui-clearfix">
            <div class="inbox-img-container">
                <div class="mdui-container ">
                    <!-- 文字标题 -->
                    <div class="mdui-typo-display-1 mdui-text-color-white-text inbox-title">收件箱</div>
                    <!-- 刷新按钮 -->
                    <a href="../resume/updateInbox">
                        <button class="mdui-fab mdui-color-theme-accent mdui-ripple inbox-fab-refresh"
                                mdui-tooltip="{content: '刷新', position: 'left'}">
                            <i class="mdui-icon material-icons">refresh</i>
                        </button>
                    </a>
                </div>
            </div>
            <div class="inbox-mail-container">
                <div class="mdui-container">
                    <div class="mdui-typo">
                        <blockquote>
                            <p>这里可以显示你的发出的简历的回复</p>
                        </blockquote>
                    </div>
                </div>
                <div class="mdui-container">
                    <div class="mdui-panel" mdui-panel>
                        <%
                            Message[] messages = (Message[]) request.getAttribute("messages");
                            if (messages != null) {
                                for (Message message : messages) {
                                    try {
                                        MimeMessage msg = (MimeMessage) message;
//                                        StringBuffer content = new StringBuffer(30);
//                                        ReceiveMailSSL.getMailTextContent(msg, content);
                        %>
                        <div class="mdui-panel-item">
                            <div class="mdui-panel-item-header">
                                <div class="mdui-panel-item-title">邮件主题</div>
                                <div class="mdui-panel-item-summary"><%=message.getSubject()%></div>
                                    <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                                </div>
                                <div class="mdui-panel-item-body">
                                    <p>
                                        <strong>发件人：</strong>
                                        <%
                                            String from = "";
                                            Address[] froms = msg.getFrom();
                                            if (froms.length < 1) {
                                                throw new MessagingException("没有发件人!");
                                            }

                                            InternetAddress address = (InternetAddress) froms[0];
                                            String person = address.getPersonal();
                                            if (person != null) {
                                                person = MimeUtility.decodeText(person) + " ";
                                            } else {
                                                person = "";
                                            }
                                            from = person + "<" + address.getAddress() + ">";

                                            out.println(from);
                                        %>
                                    </p>
                                    <p>
                                        <strong>收件人：</strong>
                                        <%
                                            StringBuilder receiveAddress = new StringBuilder();
                                            Address[] addresses = null;
                                            addresses = msg.getAllRecipients();

                                            if (addresses == null || addresses.length < 1) {
                                                throw new MessagingException("没有收件人!");
                                            }
                                            for (Address add : addresses) {
                                                InternetAddress internetAddress = (InternetAddress) add;
                                                receiveAddress.append(internetAddress.toUnicodeString()).append(",");
                                            }

                                            // 删除最后一个逗号
                                            receiveAddress.deleteCharAt(receiveAddress.length() - 1);

                                            out.println(receiveAddress);
                                        %>
                                    </p>
                                    <p><strong>发送时间：</strong><%=message.getSentDate()%></p>
                                    <p><strong>是否已读：</strong><%=message.getFlags().contains(Flags.Flag.SEEN)%></p>
                                </div>
                            </div>
                            <%
                                        } catch (MessagingException | IOException e) {
                                            e.printStackTrace();
                                        }
                                    }
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
            <div id="send" class="mdui-clearfix">
                <div class="inbox-img-container">
                    <div class="mdui-container ">
                        <!-- 文字标题 -->
                        <div class="mdui-typo-display-1 mdui-text-color-white-text inbox-title">发件箱</div>
                        <!-- 刷新按钮 -->
                        <button class="mdui-fab mdui-color-theme-accent mdui-ripple inbox-fab-refresh"
                                mdui-tooltip="{content: '刷新', position: 'left'}">
                            <i class="mdui-icon material-icons">refresh</i>
                        </button>
                    </div>
                </div>
                <div class="sent-mail-container">
                    <div class="mdui-container">
                        <div class="mdui-typo">
                            <blockquote>
                                <p>这里可以显示你的发出的简历的回复</p>
                            </blockquote>
                        </div>
                    </div>
                    <div class="mdui-container">
                        <div class="mdui-panel" mdui-panel>
                            <div class="mdui-panel-item">
                                <div class="mdui-panel-item-header">
                                    <div class="mdui-panel-item-title">邮件主题</div>
                                    <div class="mdui-panel-item-summary">Super Reusme really works</div>
                                    <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                                </div>
                                <div class="mdui-panel-item-body">
                                    <p>发件人</p>
                                    <p>收件人</p>
                                    <p>发送时间</p>
                                    <p>是否已读</p>
                                    <p>邮件优先级</p>
                                    <p>邮件内容</p>
                                </div>
                            </div>
                            <div class="mdui-panel-item">
                                <div class="mdui-panel-item-header">
                                    <div class="mdui-panel-item-title">Location</div>
                                    <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                                </div>
                                <div class="mdui-panel-item-body">
                                    <p>Second content</p>
                                    <p>Second content</p>
                                    <p>Second content</p>
                                    <p>Second content</p>
                                    <p>Second content</p>
                                    <p>Second content</p>
                                </div>
                            </div>
                            <div class="mdui-panel-item">
                                <div class="mdui-panel-item-header">
                                    <div class="mdui-panel-item-title">Start and end dates</div>
                                    <div class="mdui-panel-item-summary">Start date: Feb 29, 2016</div>
                                    <div class="mdui-panel-item-summary">End date: Not set</div>
                                    <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                                </div>
                                <div class="mdui-panel-item-body">
                                    <p>Third content</p>
                                    <p>Third content</p>
                                    <p>Third content</p>
                                    <p>Third content</p>
                                    <p>Third content</p>
                                    <p>Third content</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
