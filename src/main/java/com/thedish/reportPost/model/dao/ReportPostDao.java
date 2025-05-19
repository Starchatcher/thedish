package com.thedish.reportPost.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.reportPost.model.vo.ReportPost;

@Repository("ReportPostDao")


public class ReportPostDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
}
