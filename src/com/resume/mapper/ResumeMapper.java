package com.resume.mapper;

import com.resume.pojo.Resume;

import java.util.List;

/**
 * @author danny
 * @date 2020/1/29
 */
public interface ResumeMapper {
    /**
     * 插入一条记录
     * @param resume 简历pojo类
     */
    void insertResume(Resume resume);

    /**
     * 收到邮件后更新数据
     * @param resume 简历pojo类
     */
    void updateTime(Resume resume);

    /**
     * 查询一条简历
     * @param resume 简历pojo类
     * @return 这条发出去的简历
     */
    Resume getResumeInfo(Resume resume);
}
