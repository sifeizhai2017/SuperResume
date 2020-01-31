package com.resume.mail;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * @author danny
 * @date 2020/1/31
 */
public class SendMailSSL {
    public static final String EMAIL_ADDR = "";
    public static final String EMAIL_PWD = "";

    public static void main(String[] args) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.qq.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_ADDR, EMAIL_PWD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("958367333@qq.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse("1469143956@qq.com"));
            message.setSubject("测试邮件");
            message.setText("当你看到这封邮件的时候，说明你已经能够JavaMail+SSL发送邮件了");

            Transport.send(message);
            System.out.println("Done");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
