package com.thedish.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDaoImpl implements AdminDao {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public int countTodayJoin() {
        return sqlSession.selectOne("adminMapper.countTodayJoin");
    }

    @Override
    public int countTodayWithdraw() {
        return sqlSession.selectOne("adminMapper.countTodayWithdraw");
    }

    @Override
    public int countTodayReports() {
        return sqlSession.selectOne("adminMapper.countTodayReports");
    }

    @Override
    public int countTodayReviews() {
        return sqlSession.selectOne("adminMapper.countTodayReviews");
    }

    @Override
    public int countTodayInquiries() {
        return sqlSession.selectOne("adminMapper.countTodayInquiries");
    }

    @Override
    public int countTotalUsers() {
        return sqlSession.selectOne("adminMapper.countTotalUsers");
    }

    @Override
    public List<Map<String, Object>> selectDailySummary() {
        return sqlSession.selectList("adminMapper.selectDailySummary");
    }

    @Override
    public List<Map<String, Object>> selectDailyPostAndView() {
        return sqlSession.selectList("adminMapper.selectDailyPostAndView");
    }
}
