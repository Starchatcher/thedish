package com.thedish.user.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.users.model.vo.User;
import com.thedish.users.model.vo.VerificationCode;

@Repository
public class UserDAOImpl implements UserDAO {

    @Autowired
    private SqlSessionTemplate sqlSession;
    
    @Override
    public void insertUser(User user) {
        sqlSession.insert("userMapper.insertUser", user);
    }
    
    @Override
    public User selectUserById(String userId) {
        return sqlSession.selectOne("userMapper.selectUserById", userId);
    }
    
    @Override
    public void updatePassword(String userId, String newPassword) {
        sqlSession.update("userMapper.updatePassword", 
                          new User().setUserId(userId).setPassword(newPassword));
    }
    
    @Override
    public void updateUserStatus(String userId, String status) {
        sqlSession.update("userMapper.updateUserStatus", 
                          new User().setUserId(userId).setStatus(status));
    }
    
    @Override
    public void saveVerificationCode(String email, String code) {
        sqlSession.insert("userMapper.saveVerificationCode", 
                          new VerificationCode().setEmail(email).setCode(code));
    }
    
    @Override
    public String getVerificationCode(String email) {
        return sqlSession.selectOne("userMapper.getVerificationCode", email);
    }

    @Override
    public void insertTermsAgreement(String userId) {
        sqlSession.insert("userMapper.insertTermsAgreement", userId);
    }

}