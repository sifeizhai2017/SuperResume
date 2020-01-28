package com.resume.mapper;

import com.resume.pojo.User;

/**
 * @author danny
 * @date 2020/1/27
 */
public interface UserMapper {
    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @return 用户
     */
    User getUserByUsername(String username);

    /**
     * 增加用户
     * @param user 用户
     * @return 是否增加成功
     */
    boolean insertUser(User user);
}
