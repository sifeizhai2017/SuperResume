<%@ page import="com.resume.pojo.Resume" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %><%--
  Created by IntelliJ IDEA.
  User: danny
  Date: 2020/2/3
  Time: 19:38
  Desc: 日程安排
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>日程管理</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        request.setAttribute("path", basePath);
    %>
    <script src="${path}/mdui/js/mdui.min.js"></script>
    <link rel="stylesheet" href="${path}/mdui/css/mdui.min.css">
    <link rel="stylesheet" href="${path}/css/schedule-style.css">
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
            <a href="javascript:">
                <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons">date_range</i>
                    <div class="mdui-list-item-content">日程管理</div>
                </li>
            </a>
            <a href="javascript:">
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
                <p>日程管理</p>
            </div>
        </div>
        <div class="schedule-form-section">
            <div class="title-section mdui-typo-display-1 mdui-text-color-pink">面试清单</div>
            <br>
            <div class="mdui-divider"></div>
            <br>
            <!-- 卡片 -->
            <form action="${path}/resume/listSchedule">
                <span></span>
                <label>起始日期：</label><input type="date" name="startDate" required>&nbsp;
                <label>结束日期：</label><input type="date" name="endDate" required>&nbsp;
                <button class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme-accent mdui-float-right"
                        type="submit">提交
                </button>
            </form>
            <br>
            <div class="mdui-table-fluid">
                <table class="mdui-table mdui-table-hoverable">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>公司</th>
                        <th>职位</th>
                        <th>面试时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- 显示信息 -->
                    <%
                        ArrayList<Resume> selectedResumes = (ArrayList<Resume>) session.getAttribute("selectedResumes");
                        if (selectedResumes != null) {
                            Iterator<Resume> resumeIterator = selectedResumes.iterator();
                            while (resumeIterator.hasNext()) {
                                Resume nextResume = resumeIterator.next();
                    %>
                        <tr>
                            <td><%=nextResume.getId()%></td>
                            <td><%=nextResume.getCompany()%></td>
                            <td><%=nextResume.getPosition()%></td>
                            <td><%=nextResume.getInterviewTime()%></td>
                        </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>

</html>
