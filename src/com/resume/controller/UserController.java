package com.resume.controller;

import com.resume.pojo.User;
import com.resume.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

/**
 * @author danny
 * @date 2020/1/28
 */
@Controller
@RequestMapping(value = "usercotroller")
public class UserController {
    UserService userService;

    public UserService getUserService() {
        System.out.println("getUserService");
        return userService;
    }

    public void setUserService(UserService userService) {
        System.out.println("setUserService");
        System.out.println("userService = " + userService);
        this.userService = userService;
    }


    /**
     * 根据用户名获取用户
     * @param map 存储attribute
     * @return 跳转页面
     */
    @RequestMapping(value = "/getuser")
    public String getUserByUsername(Map<String, Object> map) {
        System.out.println("this.userService = " + this.userService);
        User user = userService.getUserByUsername("danny");
        System.out.println("user = " + user);
        map.put("user", user);

        return "success";
    }
}
