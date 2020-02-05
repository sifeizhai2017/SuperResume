package com.resume.service;

import com.resume.pojo.Resume;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author danny
 * @date 2020/2/1
 */
public interface ResumeService {
    /**
     * 插入一条记录
     * @param resume 简历pojo类
     * @return 插入成功/失败
     */
    boolean insertResume(Resume resume);

    /**
     * 收到邮件后更新数据
     * @param resume 简历pojo类
     * @return 更新成功/失败
     */
    boolean updateTime(Resume resume);

    /**
     * 查询一条简历
     * @param resume 简历pojo类
     * @return 这条发出去的简历
     */
    Resume getResumeInfo(Resume resume);

    /**
     * 判断这条简历是不是存在
     * @param resume 简历pojo类
     * @return 有/没有
     */
    boolean getResumeExist(Resume resume);

    /**
     * 查询面试时间范围内的简历
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 列表
     */
    ArrayList<Resume> getSelectedResumes(Date startDate, Date endDate);
}
