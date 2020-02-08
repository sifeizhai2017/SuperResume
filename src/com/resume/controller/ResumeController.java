package com.resume.controller;

import com.resume.mail.ReceiveMailSSL;
import com.resume.pojo.Resume;
import com.resume.service.ResumeService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author danny
 * @date 2020/1/31
 */
@Component
@RequestMapping(value = "resume")
@SessionAttributes(value = {"inboxMessages", "sendMessages", "selectedResumes"}, types = {ArrayList.class})
public class ResumeController {
    ResumeService resumeService;
    /**
     * todo: 建立一个方法，从数据库中获取邮箱密码等，并将其复制给receiveMail中的属性 解决日期：2020-02-04
     */
    ReceiveMailSSL receiveMail;
    SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd hh:mm", Locale.ROOT);
    SimpleDateFormat sdf1 = new SimpleDateFormat("yy-MM-dd", Locale.ROOT);

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
     * 列出所有日程
     *
     * @param startDate 开始日期
     * @param endDate   结束日期
     * @return 原页面
     */
    @RequestMapping("listSchedule")
    public String listSchedule(@RequestParam String startDate, @RequestParam String endDate
            , Map<String, Object> map) throws ParseException {
        System.out.println("startDate = " + startDate);
        Date formattedStartDate = sdf1.parse(startDate);
        Date formattedEndDate = sdf1.parse(endDate);

        List<Resume> selectedResumes = resumeService.getSelectedResumes(formattedStartDate, formattedEndDate);
        if (selectedResumes == null) {
            map.put("dateErrMsg", "日期大于结束日期，请重新选择");
        } else {
            map.put("selectedResumes", selectedResumes);
        }

        return "forward:/views/schedule.jsp";
    }

    @RequestMapping("resumeGuide")
    public String resumeGuide(@RequestParam String email, @RequestParam String phone, @RequestParam String sms,
                              @RequestParam String name, @RequestParam String sex, @RequestParam String birth,
                              @RequestParam String edu, @RequestParam String school, @RequestParam String position,
                              @RequestParam String salary, @RequestParam String companyA, @RequestParam String timeA,
                              @RequestParam String projectA, @RequestParam String descA, @RequestParam String companyB,
                              @RequestParam String timeB, @RequestParam String projectB, @RequestParam String descB,
                              @RequestParam String certificateA, @RequestParam String certificateB,
                              @RequestParam String certificateC) {
        // 填充文字
        StringBuilder sb = new StringBuilder(1000);
        sb.append("# 个人简历\n## 联系方式\n")
                .append(" - 手机：").append(phone).append("\n")
                .append(" - 电子邮箱：").append(email).append("\n")
                .append(" - 微信/QQ：").append(sms).append("\n")
                .append("## 个人信息\n")
                .append(" - ").append(name).append("\\").append(sex).append("\\").append(birth).append("\n")
                .append(" - ").append(edu).append("\\").append(school).append("\n")
                .append(" - 期望职位").append(position).append("\n")
                .append(" - 期望薪资").append(salary).append("\n");

        if (companyA != null && timeA != null && projectA != null && descA != null) {
            sb.append("## 工作经历\n").append("### ").append(companyA).append("\t(").append(timeA).append(")\n")
                    .append("#### ").append(projectA).append("\n")
                    .append(descA).append("\n");
        }
        if (companyB != null && timeB != null && projectB != null && descB != null) {
            sb.append("### ").append(companyB).append("\t(").append(timeB).append(")\n")
                    .append("#### ").append(projectB).append("\n")
                    .append(descB).append("\n");
        }

        if (certificateA != null) {
            sb.append("## 个人证书\n").append(" - ").append(certificateA).append("\n");
        }
        if (certificateB != null) {
            sb.append(" - ").append(certificateB).append("\n");
        }
        if (certificateC != null) {
            sb.append(" - ").append(certificateC).append("\n");
        }

        File file = new File("/Users/danny/Desktop/test.md");
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(file);
            var bytes = sb.toString().getBytes();
            fos.write(bytes);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // todo：跳转到文件下载页面
        return "redirect:/views/success.jsp";
    }

    @RequestMapping("testHttpMessageDown")
    public ResponseEntity<byte[]> download(HttpServletRequest request) throws IOException {
        File file = new File("/Users/danny/Desktop/test.md");
        byte[] body = null;
        InputStream is = new FileInputStream(file);
        body = new byte[is.available()];
        is.read(body);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attchement;filename=" + file.getName());
        HttpStatus statusCode = HttpStatus.OK;
        ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(body, headers, statusCode);
        return entity;
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
