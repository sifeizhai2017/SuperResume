package com.resume.test;

import com.resume.pojo.User;
import com.resume.service.UserService;
import com.resume.service.impl.UserServiceImpl;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * @author danny
 */
public class Test {
    public static void main(String[] args) throws IOException {
        File file = new File("/Users/danny/Desktop/test.md");
        FileOutputStream fos = new FileOutputStream(file);
        String ttt = "# this is a test";
        byte[] bytes = ttt.getBytes();
        fos.write(bytes);
        fos.close();
    }
}
