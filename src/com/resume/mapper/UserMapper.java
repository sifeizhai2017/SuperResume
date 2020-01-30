package com.resume.mapper;

import com.resume.pojo.User;

/**
 * @author danny
 * @date 2020/1/27
 */
public interface UserMapper {
    /**
     * 根据用户名查询用户
     *
     * @param username 用户名
     * @return 用户
     */
    User getUserByUsername(String username);

    /**
     * 增加用户
     *
     * @param user 用户
     */
    void insertUser(User user);

    /**
     * 更新用户邮箱信息
     *
     * @param user 用户（只包含用户名，邮箱地址和密码）
     */
    void updateEmailInfo(User user);

    /**
     * 更新用户密码
     *
     * @param user 用户（只有密码）
     */
    void updateUserPassword(User user);

    /**
     * 更新邮件服务器
     *
     * @param user 用户（只有服务器信息）
     */
    void updateServer(User user);
}
