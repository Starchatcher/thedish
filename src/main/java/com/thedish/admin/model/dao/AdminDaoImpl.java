package com.thedish.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.users.model.vo.Users;

@Repository("adminDao")
public class AdminDaoImpl implements AdminDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public int countTodayJoin() {
        return sqlSession.selectOne("com.thedish.admin.model.dao.AdminDao.countTodayJoin");
    }

    @Override
    public int countTodayWithdraw() {
        return sqlSession.selectOne("com.thedish.admin.model.dao.AdminDao.countTodayWithdraw");
    }

    @Override
    public int countTodayReports() {
        return sqlSession.selectOne("com.thedish.admin.model.dao.AdminDao.countTodayReports");
    }

    @Override
    public int countTodayReviews() {
        return sqlSession.selectOne("com.thedish.admin.model.dao.AdminDao.countTodayReviews");
    }

    @Override
    public int countTodayInquiries() {
        return sqlSession.selectOne("com.thedish.admin.model.dao.AdminDao.countTodayInquiries");
    }

    @Override
    public int countTotalUsers() {
        return sqlSession.selectOne("com.thedish.admin.model.dao.AdminDao.countTotalUsers");
    }

    @Override
    public List<Map<String, Object>> selectDailySummary() {
        return sqlSession.selectList("com.thedish.admin.model.dao.AdminDao.selectDailySummary");
    }

    @Override
    public List<Map<String, Object>> selectDailyPostAndView() {
        return sqlSession.selectList("com.thedish.admin.model.dao.AdminDao.selectDailyPostAndView");
    }

    @Override
    public List<Users> searchUsers(Map<String, Object> param) {
        return sqlSession.selectList("com.thedish.admin.model.dao.AdminDao.searchUsers", param);
    }
    
    @Override
    public int countActiveUsers() {
    	return sqlSession.selectOne("com.thedish.admin.model.dao.AdminDao.countActiveUsers");
    }
    
    @Override
    public int countWithdrawnUsers() {
    	return sqlSession.selectOne("com.thedish.admin.model.dao.AdminDao.countWithdrawnUsers");
    } 
    
    @Override
    public int countUsersByStatus(Map<String, Object> param) {
    	return sqlSession.selectOne("com.thedish.admin.model.dao.AdminDao.countUsersByStatus", param);
    }
}
