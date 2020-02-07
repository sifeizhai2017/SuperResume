<%--
  Created by IntelliJ IDEA.
  User: danny
  Date: 2020/2/6
  Time: 10:10
  Desc: 简历生成向导
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>简历生成</title>
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
    <!-- 主要部分 -->
    <div class="page-index">
        <div class="guide-container">
            <div class="mdui-typo-display-1 mdui-text-color-pink"><strong>简历生成</strong></div>
        </div>
        <div class="mdui-typo">
            <blockquote>
                <p>一个简易的简历生成表单</p>
            </blockquote>
        </div>
        <div class="mdui-typo">
            <hr/>
        </div>
        <div class="form-container">
            <form action="resume/resumeGuide">
                <div class="mdui-panel mdui-panel-gaplessY767Y8UYG" mdui-panel>
                    <div class="mdui-panel-item mdui-panel-item-open">
                        <div class="mdui-panel-item-header">
                            <strong>联系方式</strong>
                            <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                        </div>
                        <div class="mdui-panel-item-body">
                            <p>HR会打印你的简历，用于在面试的时候联系，所以联系方式放到最上边会比较方便</p>
                            <div class="mdui-textfield">
                                <i class="mdui-icon material-icons">email</i>
                                <input class="mdui-textfield-input" type="email" placeholder="Email"/>
                            </div>
                            <div class="mdui-textfield">
                                <i class="mdui-icon material-icons">phone_android</i>
                                <input class="mdui-textfield-input" type="text" placeholder="电话号码"/>
                            </div>
                            <div class="mdui-textfield">
                                <i class="mdui-icon material-icons">chat</i>
                                <input class="mdui-textfield-input" type="text" placeholder="QQ/微信"/>
                                <div class="mdui-textfield-helper">提供一个通过网络可以联系到你的方式</div>
                            </div>
                        </div>
                    </div>
                    <div class="mdui-panel-item">
                        <div class="mdui-panel-item-header">
                            <strong>个人信息</strong>
                            <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                        </div>
                        <div class="mdui-panel-item-body">
                            <!-- 姓名、年龄、性别 -->
                            <div class="mdui-row">
                                <div class="mdui-col-lg-4 mdui-col-xl-4">
                                    <div class="mdui-textfield">
                                        <i class="mdui-icon material-icons">person</i>
                                        <input class="mdui-textfield-input" name="name" type="text" placeholder="姓名"/>
                                    </div>
                                </div>
                                <div class="mdui-col-lg-4 mdui-col-xl-4">
                                    <div class="mdui-textfield">
                                        <i class="mdui-icon material-icons">wc</i>
                                        <input class="mdui-textfield-input" name="sex" type="text" placeholder="性别"/>
                                    </div>
                                </div>
                                <div class="mdui-col-lg-4 mdui-col-xl-4">
                                    <div class="mdui-textfield">
                                        <i class="mdui-icon material-icons">cake</i>
                                        <input class="mdui-textfield-input" name="birth" type="date" placeholder="出生年月"/>
                                    </div>
                                </div>
                            </div>
                            <!-- 学历 -->
                            <div class="mdui-row">
                                <div class="mdui-col-lg-6">
                                    <div class="mdui-textfield">
                                        <i class="mdui-icon material-icons">school</i>
                                        <input class="mdui-textfield-input" name="edu" type="text" placeholder="学历"/>
                                    </div>
                                </div>
                                <div class="mdui-col-lg-6">
                                    <div class="mdui-textfield">
                                        <i class="mdui-icon material-icons">school</i>
                                        <input class="mdui-textfield-input" name="school" type="text" placeholder="学校"/>
                                    </div>
                                </div>
                            </div>
                            <div class="mdui-textfield">
                                <i class="mdui-icon material-icons">work</i>
                                <input class="mdui-textfield-input" name="position" type="text" placeholder="期望职位"/>
                            </div>
                            <div class="mdui-textfield">
                                <i class="mdui-icon material-icons">attach_money</i>
                                <input class="mdui-textfield-input" name="salary" type="text" placeholder="期望薪资"/>
                            </div>
                        </div>
                    </div>
                    <div class="mdui-panel-item">
                        <div class="mdui-panel-item-header">
                            <strong>工作经历</strong>
                            <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                        </div>
                        <div class="mdui-panel-item-body">
                            <div class="mdui-row mdui-row-gapless">
                                <div class="mdui-col-lg-4">
                                    <div class="mdui-textfield">
                                        <i class="mdui-icon material-icons">business_center</i>
                                        <input class="mdui-textfield-input" name="companyA" type="text" placeholder="ABC公司"/>
                                    </div>
                                </div>
                                <div class="mdui-col-lg-8">
                                    <div class="mdui-textfield">
                                        <i class="mdui-icon material-icons">timelapse</i>
                                        <input class="mdui-textfield-input" name="timeA" type="text" placeholder="（2010.1~2012.2）"/>
                                    </div>
                                </div>
                            </div>
                            <div class="mdui-row">
                                <div class="mdui-textfield">
                                    <i class="mdui-icon material-icons">assignment</i>
                                    <input class="mdui-textfield-input" name="projectA" type="text" placeholder="DEF项目"/>
                                </div>
                            </div>
                            <div class="mdui-row">
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <i class="mdui-icon material-icons">text_fields</i>
                                    <label class="mdui-textfield-label">我在此项目负责了哪些工作，分别在哪些地方做得出色/和别人不一样/成长快，这个项目中，我最困难的问题是什么，我采取了什么措施，最后结果如何。这个项目中，我最自豪的技术细节是什么，为什么，实施前和实施后的数据对比如何，同事和领导对此的反应如何。</label>
                                    <textarea class="mdui-textfield-input" name="descA" maxlength="200"></textarea>
                                </div>
                            </div>
                            <div class="mdui-typo">
                                <hr/>
                            </div>
                            <div class="mdui-row mdui-row-gapless">
                                <div class="mdui-col-lg-4">
                                    <div class="mdui-textfield">
                                        <i class="mdui-icon material-icons">business_center</i>
                                        <input class="mdui-textfield-input" name="companyB" type="text" placeholder="ABC公司"/>
                                    </div>
                                </div>
                                <div class="mdui-col-lg-8">
                                    <div class="mdui-textfield">
                                        <i class="mdui-icon material-icons">timelapse</i>
                                        <input class="mdui-textfield-input" name="timeB" type="text" placeholder="（2010.1~2012.2）"/>
                                    </div>
                                </div>
                            </div>
                            <div class="mdui-row">
                                <div class="mdui-textfield">
                                    <i class="mdui-icon material-icons">assignment</i>
                                    <input class="mdui-textfield-input" name="projectB" type="text" placeholder="DEF项目"/>
                                </div>
                            </div>
                            <div class="mdui-row">
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <i class="mdui-icon material-icons">text_fields</i>
                                    <label class="mdui-textfield-label">我在此项目负责了哪些工作，分别在哪些地方做得出色/和别人不一样/成长快，这个项目中，我最困难的问题是什么，我采取了什么措施，最后结果如何。这个项目中，我最自豪的技术细节是什么，为什么，实施前和实施后的数据对比如何，同事和领导对此的反应如何。</label>
                                    <textarea class="mdui-textfield-input" name="descB" maxlength="200"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mdui-panel-item">
                        <div class="mdui-panel-item-header">
                            <strong>个人证书</strong>
                            <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                        </div>
                        <div class="mdui-panel-item-body">
                            <div class="mdui-textfield">
                                <i class="mdui-icon material-icons">book</i>
                                <input class="mdui-textfield-input" name="certificateA" type="text" placeholder="证书"/>
                            </div>
                            <div class="mdui-textfield">
                                <i class="mdui-icon material-icons">book</i>
                                <input class="mdui-textfield-input" name="certificateB" type="text" placeholder="证书"/>
                            </div>
                            <div class="mdui-textfield">
                                <i class="mdui-icon material-icons">book</i>
                                <input class="mdui-textfield-input" name="certificateC" type="text" placeholder="证书"/>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 提交 -->
                <button class="mdui-fab mdui-fab-fixed mdui-ripple mdui-color-pink" type="submit">
                    <i class="mdui-icon material-icons">check</i>
                </button>
            </form>
        </div>
    </div>
</div>
</body>

</html>
