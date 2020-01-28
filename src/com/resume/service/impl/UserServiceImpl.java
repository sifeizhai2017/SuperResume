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
        System.out.println("getUserMapper");
        return userMapper;
    }

    public void setUserMapper(UserMapper userMapper) {
        System.out.println("setUserMapper");
        System.out.println("userMapper = " + userMapper);
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
}
