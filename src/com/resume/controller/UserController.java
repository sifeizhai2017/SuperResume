package com.resume.controller;

import com.resume.pojo.User;
import com.resume.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author danny
 * @date 2020/1/28
 */
@Controller
@RequestMapping(value = "user")
public class UserController {
    UserService userService;

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    /**
     * 根据用户名获取用户
     *
     * @param map 存储attribute
     * @return 跳转页面
     */
    @RequestMapping(value = "getUser", method = RequestMethod.POST)
    public String getUserByUsername(String username, Map<String, Object> map) {
        System.out.println("this.userService = " + this.userService);
        User user = userService.getUserByUsername(username);
        System.out.println("user = " + user);
        map.put("user", user);

        return "/views/success.jsp";
    }

    /**
     * 用户注册
     *
     * @param username 用户名
     * @param password 密码
     * @return 跳转页面
     */
    @RequestMapping(value = "insertUser")
    public String insertUser(@RequestParam String username, @RequestParam String password) {
        System.out.println("username = " + username);
        System.out.println("password = " + password);
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        boolean b = userService.insertUser(user);
        System.out.println("b = " + b);

        return "redirect:/login.jsp";
    }

    /**
     * 用户登录
     *
     * @param username 用户名
     * @param password 密码
     * @param session  session对象
     * @param map      map对象
     * @return 登陆成功/失败的页面
     */
    @RequestMapping(value = "userLogin", method = RequestMethod.POST)
    public String userLogin(@RequestParam String username, @RequestParam String password, HttpSession session
            , Map<String, Object> map) {
        // 从数据库中获取用户名、密码
        User userFromDatabase = userService.getUserByUsername(username);
        String usernameFromDatabase = userFromDatabase.getUsername();
        String passwordFromDatabase = userFromDatabase.getPassword();
        boolean result = username.equals(usernameFromDatabase) && password.equals(passwordFromDatabase);
        if (result) {
            // 只有在用户名和密码正确的前提下才能把用户名和User对象放入session中去
            session.setAttribute("username", username);
            session.setAttribute("user", userFromDatabase);
            return "redirect:/views/index.jsp";
        } else {
            session.setAttribute("msg", "用户名或密码错误，请重试");
            // 返回的页面自动打开登陆窗口，并通过requestScope中设置的值显示登陆错误
            return "redirect:/login.jsp";
        }
    }

    @RequestMapping(value = "updateEmail", method = RequestMethod.POST)
    public String updateEmail(@RequestParam String emailAddr, @RequestParam String emailPwd
            , HttpSession session, Map<String, Object> map) {
        User user = new User();
        String username = (String) session.getAttribute("username");
        user.setUsername(username);
        user.setEmailAddr(emailAddr);
        user.setEmailPassword(emailPwd);
        boolean b = userService.updateEmailInfo(user);
        if (b) {
            map.put("emailMsg", "更新成功");
        } else {
            map.put("emailMsg", "更新失败");
        }

        return "forward:/views/settings.jsp";
    }

    @RequestMapping(value = "updateUserPassword", method = RequestMethod.POST)
    public String updateUserPassword(@RequestParam String oldPwd, @RequestParam String newPwd
            , @RequestParam String confirmPwd, HttpSession session, Map<String, Object> map) {
        boolean blankOldPwd = oldPwd == null || "".equals(oldPwd.trim());
        boolean blankNewPwd = newPwd == null || "".equals(newPwd.trim());
        boolean blankConfirmPwd = confirmPwd == null || "".equals(confirmPwd.trim());
        if (blankConfirmPwd || blankNewPwd || blankOldPwd) {
            map.put("pwdMsg", "有填充项为空，请重新输入");
        } else {
            // 从数据库中获取用户
            String username = (String) session.getAttribute("username");
            User userFromDatabase = userService.getUserByUsername(username);
            String pwdFromDataBase = userFromDatabase.getPassword();
            if (!pwdFromDataBase.equals(oldPwd)) {
                // 原密码不正确
                map.put("pwdMsg", "原密码错误，请重新输入");
            } else {
                User user = new User();
                user.setUsername(username);
                user.setPassword(newPwd);
                boolean b = userService.updateUserPassword(user);
                if (b) {
                    map.put("pwdMsg", "修改成功");
                } else {
                    map.put("pwdMsg", "修改失败，请重试");
                }
            }
        }
        return "forward:/views/settings.jsp";
    }

    @RequestMapping(value = "updateServer", method = RequestMethod.POST)
    public String updateServer(@RequestParam String imapServer, @RequestParam String pop3Server
            , @RequestParam String smtpServer, HttpSession session, Map<String, Object> map) {
        boolean blankImapServer = imapServer == null || "".equals(imapServer.trim());
        boolean blankPop3Server = pop3Server == null || "".equals(pop3Server.trim());
        boolean blankStmpServer = smtpServer == null || "".equals(smtpServer.trim());
        if (blankImapServer || blankPop3Server || blankStmpServer) {
            map.put("svrMsg", "有填充项为空，请重新输入");
        } else {
            String username = (String) session.getAttribute("username");
            User user = new User();
            user.setImapServer(imapServer);
            user.setPop3Server(pop3Server);
            user.setSmtpServer(smtpServer);
            boolean b = userService.updateServer(user);
            if (b) {
                map.put("svrMsg", "修改成功");
            } else {
                map.put("svrMsg", "修改失败");
            }
        }

        return "forward:/views/settings.jsp";
    }
}
