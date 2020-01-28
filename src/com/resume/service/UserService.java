package com.resume.service;

import com.resume.pojo.User;

/**
 * @author danny
 * @date 2020/1/28
 */
public interface UserService {
    /**
     * 增加一个用户
     * @param user 用户
     * @return 是否增加成功
     */
    boolean insertUser(User user);

    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @return 用户
     */
    User getUserByUsername(String username);

    /**
     * 判断用户是否村咋
     * @param username 用户名
     * @return 用户存在/不存在
     */
    boolean getExist(String username);
}
