package com.resume.service.impl;

import com.resume.mapper.ResumeMapper;
import com.resume.pojo.Resume;
import com.resume.service.ResumeService;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author danny
 * @date 2020/2/1
 */
public class ResumeServiceImpl implements ResumeService {
    ResumeMapper resumeMapper;

    public ResumeMapper getResumeMapper() {
        return resumeMapper;
    }

    public void setResumeMapper(ResumeMapper resumeMapper) {
        this.resumeMapper = resumeMapper;
    }

    @Override
    public boolean insertResume(Resume resume) {
        resumeMapper.insertResume(resume);
        return true;
    }

    @Override
    public boolean updateTime(Resume resume) {
        Resume getExistResume = new Resume();
        getExistResume.setUsername(resume.getUsername());
        getExistResume.setCompany(resume.getCompany());
        if (this.getResumeExist(getExistResume)) {
            resumeMapper.updateTime(resume);
            return true;
        } else {
            return false;
        }
    }

    @Override
    public Resume getResumeInfo(Resume resume) {
        return resumeMapper.getResumeInfo(resume);
    }

    @Override
    public boolean getResumeExist(Resume resume) {
        return resumeMapper.getResumeInfo(resume) != null;
    }

    @Override
    public ArrayList<Resume> getSelectedResumes(Date startDate, Date endDate) {
        // 如果开始日期大于结束日期，返回一个空的list
        if (startDate.compareTo(endDate) > 0) {
            return null;
        } else {
            return resumeMapper.getSelectedResumes(startDate, endDate);
        }
    }
}
