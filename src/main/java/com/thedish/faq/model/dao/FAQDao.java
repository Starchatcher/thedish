package com.thedish.faq.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.faq.model.vo.FAQ;

@Repository("faqDao")
public class FAQDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	  public List<FAQ> selectFAQList() {
	        return sqlSessionTemplate.selectList("faqMapper.selectFAQList");
	    }
}
