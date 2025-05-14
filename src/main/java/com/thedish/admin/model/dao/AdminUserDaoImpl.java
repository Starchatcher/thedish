package com.thedish.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.users.model.vo.Users;

@Repository
public class AdminUserDaoImpl implements AdminUserDao {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public Users selectUserById(String userId) {
        return sqlSession.selectOne("adminUserMapper.selectUserById", userId);
    }

    @Override
    public int updateUser(Users user) {
        return sqlSession.update("adminUserMapper.updateUser", user);
    }

    @Override
    public List<Users> selectAllUsers() {
        return sqlSession.selectList("adminUserMapper.selectAllUsers");
    }

    @Override
    public int countTotalUsers() {
        return sqlSession.selectOne("adminUserMapper.countTotalUsers");
    }

    @Override
    public int countActiveUsers() {
        return sqlSession.selectOne("adminUserMapper.countActiveUsers");
    }

    @Override
    public int countWithdrawnUsers() {
        return sqlSession.selectOne("adminUserMapper.countWithdrawnUsers");
    }

    @Override
    public List<Users> searchUsers(Map<String, String> paramMap) {
        return sqlSession.selectList("adminUserMapper.searchUsers", paramMap);
    }
}
