package com.resume.controller;

import com.resume.mail.ReceiveMailSSL;
import com.resume.pojo.Resume;
import com.resume.service.ResumeService;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
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
    ResumeService resumeService;
    ReceiveMailSSL receiveMail;

    public ResumeService getResumeService() {
        return resumeService;
    }

    public void setResumeService(ResumeService resumeService) {
        this.resumeService = resumeService;
    }

    public ReceiveMailSSL getReceiveMail() {
        return receiveMail;
    }

    public void setReceiveMail(ReceiveMailSSL receiveMail) {
        this.receiveMail = receiveMail;
    }

    /**
     * 更新收件箱的内容
     *
     * @return 跳转会原页面，session域中存放的是Messages数组
     */
    @RequestMapping(value = "updateInbox")
    public String updateInbox(Map<String, Object> map, HttpSession session) throws Exception {
        String username = (String) session.getAttribute("username");
        boolean result;
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
    public String updateSend(Map<String, Object> map, HttpSession session) throws Exception {
        String username = (String) session.getAttribute("username");
        Message[] messages = receiveMail.receive(ReceiveMailSSL.SENT_FOLDER);
        // 减少扩容，初始化容量
        ArrayList<Message> sendMessages = new ArrayList<>(100);
        // 对所有邮件进行筛选，如果在标题中出现求职、应聘、简历字样，放入一个新的ArrayList中
        for (Message message : messages) {
            if (message.getSubject().contains("应聘") || message.getSubject().contains("求职")
                    || message.getSubject().contains("简历")) {
                sendMessages.add(message);
                // 将你发出去的这条简历写入数据库中
                Resume resume = this.messageToResume(message, username);
                resumeService.insertResume(resume);
            }
        }
        System.out.println("sendMessages = " + sendMessages);
        map.put("sendMessages", sendMessages);

        return "redirect:/views/mailsystem.jsp#send";
    }

    /**
     * 将message中的内容解析为Resume对象
     *
     * @param message 一条邮件信息
     * @return Resume对象
     */
    private Resume messageToResume(Message message, String username) {
        Resume resume = new Resume();
        try {
            String messageTitle = message.getSubject();
            String[] split = messageTitle.split("-");
            // 获取并显示当前发件人与收件人
            String from = ReceiveMailSSL.getFrom((MimeMessage) message);
            String to = ReceiveMailSSL.getReceiveAddress((MimeMessage) message, null);
            String fromAdd = from.substring(from.indexOf('<') + 1, from.indexOf('>'));
            String toAdd = to.substring(to.indexOf('<') + 1, to.indexOf('>'));
            resume.setUsername(username);
            resume.setCompany(split[1]);
            resume.setPosition(split[2]);
            resume.setSendTime(message.getSentDate());
            resume.setFromAddress(fromAdd);
            resume.setToAddress(toAdd);
        } catch (MessagingException | UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return resume;
    }
}
