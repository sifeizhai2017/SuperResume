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
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author danny
 * @date 2020/1/31
 */
@Component
@RequestMapping(value = "resume")
@SessionAttributes(value = {"inboxMessages", "sendMessages"}, types = {ArrayList.class})
public class ResumeController {
    ResumeService resumeService;
    /**
     * todo: 建立一个方法，从数据库中获取邮箱密码等，并将其复制给receiveMail中的属性 解决日期：2020-02-04
     */
    ReceiveMailSSL receiveMail;
    SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd hh:mm");

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
        HashMap<String, Object> receive = receiveMail.receive(ReceiveMailSSL.INBOX_FOLDER);
        Message[] messages = (Message[]) receive.get("messages");
        String[] contentArr = (String[]) receive.get("contentArr");

        System.out.println("CTRL messages = " + Arrays.toString(messages));
        // 减少扩容，初始化容量
        ArrayList<Message> inboxMessages = new ArrayList<>(100);
        ArrayList<String> inboxMessageContents = new ArrayList<>(100);
        // 对所有邮件进行筛选，如果在标题中出现Re:、求职、应聘、简历字样，放入一个新的ArrayList中
        for (int i = 0; i < messages.length; i++) {
            if (messages[i].getSubject().contains("Re:") && (messages[i].getSubject().contains("应聘")
                    || messages[i].getSubject().contains("求职") || messages[i].getSubject().contains("简历"))) {
                inboxMessages.add(messages[i]);
                // 将对应下标位置的邮件内容存在list里面
                inboxMessageContents.add(contentArr[i]);
            }
        }
        // 对列表进行遍历，并更新所有数据
        Iterator<Message> messageIterator = inboxMessages.iterator();
        Iterator<String> messageContentIterator = inboxMessageContents.iterator();
        while (messageIterator.hasNext() && messageContentIterator.hasNext()) {
            // 获取到这条邮件的主题和邮件的内容
            Message nextMessage = messageIterator.next();
            String nextMessageContent = messageContentIterator.next();
            // 分割出时间
            String interviewTime = nextMessageContent.split("：")[1].strip();
            interviewTime = interviewTime.substring(0, interviewTime.indexOf('&')).strip();
            // 如果内容中提到的时间有年、月、日：把年月改成'-'，日改为""
            if (interviewTime.contains("年")) {
                interviewTime = interviewTime.replace("年", "-");
            }
            if (interviewTime.contains("月")) {
                interviewTime = interviewTime.replace("月", "-");
            }
            if (interviewTime.contains("日")) {
                interviewTime = interviewTime.replace("日", "");
            }

            Resume resume = this.messageToResume(nextMessage, username);
            System.out.println("resume = " + resume);
            Resume resumeInfo = resumeService.getResumeInfo(new Resume(resume.getUsername(), resume.getCompany()));
            System.out.println("resumeInfo = " + resumeInfo);
            // 通过发件人地址和收件人地址来匹配邮件，从而匹配数据库中的一条记录
            if (resume.getFromAddress().equals(resumeInfo.getToAddress()) && resume.getToAddress().equals(resumeInfo.getFromAddress())) {
                Resume updateResume = new Resume();
                updateResume.setReceiveTime(resume.getSendTime());
                updateResume.setIsRead((byte) 1);
                updateResume.setInterviewTime(sdf.parse(interviewTime));
                updateResume.setUsername(username);
                updateResume.setCompany(resume.getCompany());
                resumeService.updateTime(updateResume);
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
        HashMap<String, Object> receive = receiveMail.receive(ReceiveMailSSL.SENT_FOLDER);
        Message[] messages = (Message[]) receive.get("messages");
        String[] contentArr = (String[]) receive.get("contentArr");
        // 减少扩容，初始化容量
        ArrayList<Message> sendMessages = new ArrayList<>(100);
        // 对所有邮件进行筛选，如果在标题中出现求职、应聘、简历字样，放入一个新的ArrayList中
        for (Message message : messages) {
            if (message.getSubject().contains("应聘") || message.getSubject().contains("求职")
                    || message.getSubject().contains("简历")) {
                sendMessages.add(message);
                // 将你发出去的这条简历写入数据库中
                Resume resume = this.messageToResume(message, username);
                Resume resumeForQuery = new Resume(username, resume.getCompany());
                if (!resumeService.getResumeExist(resume)) {
                    // 只有在这条记录不存在的情况下才加入
                    resumeService.insertResume(resume);
                }
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
