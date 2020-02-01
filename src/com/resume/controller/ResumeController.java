package com.resume.controller;

import com.resume.mail.ReceiveMailSSL;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

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
@SessionAttributes(value = {"sentMessages", "messages"}, types = {Message.class})
public class ResumeController {
    /**
     * 更新收件箱的内容
     * @return 跳转会原页面，session域中存放的是Messages数组
     */
    @RequestMapping(value = "updateInbox")
    public String updateInbox(Map<String, Object> map) throws Exception {
        // TODO: 为了防止报空指针异常，这里最好用Option包一下
        ReceiveMailSSL receiveMail = new ReceiveMailSSL();
        Message[] messages = receiveMail.receive(ReceiveMailSSL.INBOX_FOLDER);
        System.out.println("CTRL messages = " + Arrays.toString(messages));
        map.put("messages", messages);

        return "redirect:/views/mailsystem.jsp";
    }

    /**
     * 更新发件箱的内容
     * @return 跳转会原页面，session域中存放的是Messages数组
     */
    @RequestMapping(value = "updateSend")
    public String updateSend(Map<String, Object> map) throws Exception {
        // TODO: 为了防止报空指针异常，这里最好用Option包一下
        ReceiveMailSSL receiveMail = new ReceiveMailSSL();
        Message[] sentMessages = receiveMail.receive(ReceiveMailSSL.SENT_FOLDER);
        System.out.println("CTRL messages = " + Arrays.toString(sentMessages));
        map.put("sentMessages", sentMessages);

        return "redirect:/views/mailsystem.jsp#send";
    }
}
