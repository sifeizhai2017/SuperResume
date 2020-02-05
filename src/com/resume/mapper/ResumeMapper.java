package com.resume.mapper;

import com.resume.pojo.Resume;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author danny
 * @date 2020/1/29
 */
public interface ResumeMapper {
    /**
     * 插入一条记录
     *
     * @param resume 简历pojo类
     */
    void insertResume(Resume resume);

    /**
     * 收到邮件后更新数据
     *
     * @param resume 简历pojo类
     */
    void updateTime(Resume resume);

    /**
     * 查询一条简历
     *
     * @param resume 简历pojo类
     * @return 这条发出去的简历
     */
    Resume getResumeInfo(Resume resume);

    /**
     * 查询面试时间范围内的简历
     *
     * @param startDate 开始日期
     * @param endDate   结束日期
     * @return list
     */
    ArrayList<Resume> getSelectedResumes(@Param(value = "startDate") Date startDate, @Param(value = "endDate") Date endDate);
}
