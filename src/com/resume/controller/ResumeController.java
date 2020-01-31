package com.resume.controller;

import com.resume.mail.ReceiveMailSSL;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.mail.Message;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * @author danny
 * @date 2020/1/31
 */
@Component
@RequestMapping(value = "resume")
public class ResumeController {
    /**
     * 更新收件箱的内容
     * @return 跳转会原页面，request域中存放的是Messages数组，以及一切其他信息（邮件数目.....）
     */
    @RequestMapping(value = "updateInbox")
    public String updateInbox(Map<String, Object> map) throws Exception {
        // TODO: 为了防止报空指针异常，这里最好用Option包一下
        Message[] messages = ReceiveMailSSL.receive();
        System.out.println("CTRL messages = " + Arrays.toString(messages));
        map.put("messages", messages);

        return "/views/mailsystem.jsp";
    }
}
