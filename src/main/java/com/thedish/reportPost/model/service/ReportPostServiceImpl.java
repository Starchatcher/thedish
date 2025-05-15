package com.thedish.reportPost.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.reportPost.model.dao.ReportPostDao;
import com.thedish.reportPost.model.vo.ReportPost;

@Service("reportPostService")
public class ReportPostServiceImpl implements ReportPostService{

	@Autowired
	ReportPostDao reportPostDao;

}
