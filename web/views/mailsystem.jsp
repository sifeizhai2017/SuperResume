<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.Flags" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.internet.MimeUtility" %>
<%@ page import="java.io.IOException" %>
<%@ page import="static com.sun.org.apache.xml.internal.serializer.utils.Utils.messages" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
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
            <a href="${path}/views/index.jsp">
                <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons">home</i>
                    <div class="mdui-list-item-content">首页</div>
                </li>
            </a>
            <a href="${path}/views/mailsystem.jsp">
                <li class="mdui-list-item mdui-ripple mdui-text-color-theme mdui-list-item-active">
                    <i class="mdui-list-item-icon mdui-icon material-icons  mdui-text-color-theme">account_balance</i>
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
                                mdui-tooltip="{content: '刷新', position: 'left'}" mdui-dialog="{target: '#wait'}">
                            <i class="mdui-icon material-icons">refresh</i>
                        </button>
                    </a>
                </div>
            </div>
            <div class="inbox-mail-container">
                <div class="mdui-container">
                    <div class="mdui-typo">
                        <blockquote>
                            <p>这里可以显示你的发出的简历</p>
                        </blockquote>
                    </div>
                </div>
                <div class="mdui-container">
                    <div class="mdui-panel" mdui-panel>
                        <%
                            ArrayList<Message> inboxMessages = (ArrayList<Message>) session.getAttribute("inboxMessage");
                            if (inboxMessages != null) {
                                Iterator<Message> inboxMessagesIterator = inboxMessages.iterator();
                                while (inboxMessagesIterator.hasNext()) {
                                    Message inboxMessage = null;
                                    try {
                                        inboxMessage = inboxMessagesIterator.next();
                                        MimeMessage msg = (MimeMessage) inboxMessage;
                        %>
                        <div class="mdui-panel-item">
                            <div class="mdui-panel-item-header">
                                <div class="mdui-panel-item-title">邮件主题</div>
                                <div class="mdui-panel-item-summary"><%=inboxMessage.getSubject()%>
                                </div>
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
                                <p><strong>发送时间：</strong><%=inboxMessage.getSentDate()%>
                                </p>
                                <p><strong>是否已读：</strong><%=inboxMessage.getFlags().contains(Flags.Flag.SEEN)%>
                                </p>
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
                    <a href="../resume/updateSend">
                        <button class="mdui-fab mdui-color-theme-accent mdui-ripple inbox-fab-refresh"
                                mdui-tooltip="{content: '刷新', position: 'left'}" mdui-dialog="{target: '#wait'}">
                            <i class="mdui-icon material-icons">refresh</i>
                        </button>
                    </a>
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
                        <%
                            ArrayList<Message> sendMessages = (ArrayList<Message>) session.getAttribute("sendMessages");
                            if (sendMessages != null) {
                                Iterator<Message> sendMessagesIterator = sendMessages.iterator();
                                while (sendMessagesIterator.hasNext()) {
                                    Message sendMessage = null;
                                    try {
                                        sendMessage = sendMessagesIterator.next();
                                        MimeMessage msg = (MimeMessage) sendMessage;
                        %>
                        <div class="mdui-panel-item">
                            <div class="mdui-panel-item-header">
                                <div class="mdui-panel-item-title">邮件主题</div>
                                <div class="mdui-panel-item-summary"><%=sendMessage.getSubject()%>
                                </div>
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
                                <p><strong>发送时间：</strong><%=sendMessage.getSentDate()%>
                                </p>
                                <p><strong>是否已读：</strong><%=sendMessage.getFlags().contains(Flags.Flag.SEEN)%>
                                </p>
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
    </div>
</div>

<div class="mdui-dialog" id="wait">
    <div class="mdui-dialog-title">请稍等</div>
    <div class="mdui-dialog-content">
        <div class="mdui-progress">
            <div class="mdui-progress-indeterminate"></div>
        </div>
    </div>
</div>
</body>
</html>
