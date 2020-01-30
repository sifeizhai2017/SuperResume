package com.resume.pojo;

/**
 * 和用户信息有关的类
 *
 * @author danny
 * @date 2020/1/27
 */
public class User {
    private String username;
    private String password;
    private String emailAddr;
    private String emailPassword;
    private String imapServer;
    private String smtpServer;
    private String pop3Server;

    public User() {
    }

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmailAddr() {
        return emailAddr;
    }

    public void setEmailAddr(String emailAddr) {
        this.emailAddr = emailAddr;
    }

    public String getEmailPassword() {
        return emailPassword;
    }

    public void setEmailPassword(String emailPassword) {
        this.emailPassword = emailPassword;
    }

    public String getImapServer() {
        return imapServer;
    }

    public void setImapServer(String imapServer) {
        this.imapServer = imapServer;
    }

    public String getSmtpServer() {
        return smtpServer;
    }

    public void setSmtpServer(String smtpServer) {
        this.smtpServer = smtpServer;
    }

    public String getPop3Server() {
        return pop3Server;
    }

    public void setPop3Server(String pop3Server) {
        this.pop3Server = pop3Server;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("User{");
        sb.append("username='").append(username).append('\'');
        sb.append(", password='").append(password).append('\'');
        sb.append(", emailAddr='").append(emailAddr).append('\'');
        sb.append(", emailPassword='").append(emailPassword).append('\'');
        sb.append(", imapServer='").append(imapServer).append('\'');
        sb.append(", smtpServer='").append(smtpServer).append('\'');
        sb.append(", pop3Server='").append(pop3Server).append('\'');
        sb.append('}');
        return sb.toString();
    }
}
