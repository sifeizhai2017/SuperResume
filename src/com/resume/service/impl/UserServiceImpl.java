package com.resume.service.impl;

import com.resume.mapper.UserMapper;
import com.resume.pojo.User;
import com.resume.service.UserService;
import org.springframework.stereotype.Service;

/**
 * 憨批，注意！
 * servlet容器和Springioc容器不是一个容器！！！！！！！！
 *
 * @author danny
 * @date 2020/1/28
 */
@Service
public class UserServiceImpl implements UserService {
    UserMapper userMapper;

    public UserMapper getUserMapper() {
        return userMapper;
    }

    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Override
    public boolean insertUser(User user) {
        if (!this.getExist(user.getUsername())) {
            userMapper.insertUser(user);
            return true;
        } else {
            return false;
        }
    }

    @Override
    public User getUserByUsername(String username) {
        return userMapper.getUserByUsername(username);
    }

    @Override
    public boolean getExist(String username) {
        return userMapper.getUserByUsername(username) != null;
    }

    @Override
    public boolean updateEmailInfo(User user) {
        // 用户存在才能修改
        if (getExist(user.getUsername())) {
            userMapper.updateEmailInfo(user);
            return true;
        } else {
            return false;
        }
    }

    @Override
    public boolean updateUserPassword(User user) {
        if (getExist(user.getUsername())) {
            userMapper.updateUserPassword(user);
            return true;
        } else {
            return false;
        }
    }

    @Override
    public boolean updateServer(User user) {
        if (getExist(user.getUsername())) {
            userMapper.updateServer(user);
            return true;
        } else {
            return false;
        }
    }
}
