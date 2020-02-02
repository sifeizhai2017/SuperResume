package com.resume.test;

import com.resume.mapper.ResumeMapper;
import com.resume.mapper.UserMapper;
import com.resume.pojo.Resume;
import com.resume.pojo.User;
import com.resume.service.ResumeService;
import com.resume.service.UserService;
import com.resume.service.impl.ResumeServiceImpl;
import com.resume.service.impl.UserServiceImpl;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.*;
import java.sql.Date;
import java.util.List;

/**
 * @author danny
 */
public class Test {
    public static void main(String[] args) throws IOException {
//        File file = new File("/Users/danny/Desktop/test.md");
//        FileOutputStream fos = new FileOutputStream(file);
//        String ttt = "# this is a test";
//        byte[] bytes = ttt.getBytes();
//        fos.write(bytes);
//        fos.close();
//        ResumeServiceImpl resumeService = new ResumeServiceImpl();
//        Resume resume = new Resume();
//        resume.setUsername("danny");
//        resume.setCompany("sk");
//        resume.setPosition("ant");
//        resume.setRead(false);
//        resumeService.insertResume(resume);

        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserMapper userMapper = (UserMapper) context.getBean("userMapper");
//        userMapper.insertUser(new User("eddie", "111111"));

        ResumeMapper resumeMapper = (ResumeMapper) context.getBean("resumeMapper");
        Resume resume = new Resume();
        resume.setUsername("danny");
        resume.setCompany("sk");
        resume.setPosition("ant");
        resumeMapper.insertResume(resume);

    }
}
