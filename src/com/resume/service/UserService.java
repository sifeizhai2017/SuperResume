package com.resume.service;

import com.resume.pojo.User;

/**
 * @author danny
 * @date 2020/1/28
 */
public interface UserService {
    /**
     * 增加一个用户
     *
     * @param user 用户
     * @return 是否增加成功
     */
    boolean insertUser(User user);

    /**
     * 根据用户名查询用户
     *
     * @param username 用户名
     * @return 用户
     */
    User getUserByUsername(String username);

    /**
     * 判断用户是否存在
     *
     * @param username 用户名
     * @return 用户存在/不存在
     */
    boolean getExist(String username);

    /**
     * 更新用户邮箱信息
     *
     * @param user 用户
     * @return 增加成功/失败
     */
    boolean updateEmailInfo(User user);

    /**
     * 更新用户密码
     *
     * @param user 用户
     * @return 更新成功/失败
     */
    boolean updateUserPassword(User user);

    /**
     * 更新邮件服务器信息
     *
     * @param user 用户
     * @return 更新成功/失败
     */
    boolean updateServer(User user);
}
