package com.thedish.postFile.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("PostFileDao")
public class PostFileDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
}
