package com.resume.controller;

import com.resume.mail.ReceiveMailSSL;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.mail.Message;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

/**
 * @author danny
 * @date 2020/1/31
 */
@Component
@RequestMapping(value = "resume")
@SessionAttributes(value = {"inboxMessages", "sendMessages"}, types = {ArrayList.class})
public class ResumeController {
    /**
     * 更新收件箱的内容
     *
     * @return 跳转会原页面，session域中存放的是Messages数组
     */
    @RequestMapping(value = "updateInbox")
    public String updateInbox(Map<String, Object> map) throws Exception {
        ReceiveMailSSL receiveMail = new ReceiveMailSSL();
        Message[] messages = receiveMail.receive(ReceiveMailSSL.INBOX_FOLDER);
        System.out.println("CTRL messages = " + Arrays.toString(messages));
        // 减少扩容，初始化容量
        ArrayList<Message> inboxMessages = new ArrayList<>(100);
        // 对所有邮件进行筛选，如果在标题中出现Re:、求职、应聘、简历字样，放入一个新的ArrayList中
        for (Message message : messages) {
            if (message.getSubject().contains("Re:") && (message.getSubject().contains("应聘")
                    || message.getSubject().contains("求职") || message.getSubject().contains("简历"))) {
                inboxMessages.add(message);
            }
        }
        System.out.println("inboxMessage = " + inboxMessages);
        map.put("inboxMessages", inboxMessages);

        return "redirect:/views/mailsystem.jsp";
    }

    /**
     * 更新发件箱的内容
     *
     * @return 跳转会原页面，session域中存放的是Messages数组
     */
    @RequestMapping(value = "updateSend")
    public String updateSend(Map<String, Object> map) throws Exception {
        ReceiveMailSSL receiveMail = new ReceiveMailSSL();
        Message[] messages = receiveMail.receive(ReceiveMailSSL.SENT_FOLDER);
        // 减少扩容，初始化容量
        ArrayList<Message> sendMessages = new ArrayList<>(100);
        // 对所有邮件进行筛选，如果在标题中出现求职、应聘、简历字样，放入一个新的ArrayList中
        for (Message message : messages) {
            if (message.getSubject().contains("应聘") || message.getSubject().contains("求职")
                    || message.getSubject().contains("简历")) {
                sendMessages.add(message);
            }
        }
        System.out.println("sendMessages = " + sendMessages);
        map.put("sendMessages", sendMessages);

        return "redirect:/views/mailsystem.jsp#send";
    }
}
