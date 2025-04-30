package com.thedish.users.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.users.model.vo.Users;

@Repository("usersDao")
public class UsersDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public Users selectLogin(Users users) {
		return sqlSessionTemplate.selectOne("UsersMapper.selectLogin", users);
	}
	
	public Users selectUsers(String loginId) {	// 내 정보 보기
		return sqlSessionTemplate.selectOne("usersMapper.selectUsers", loginId);
	}
}
