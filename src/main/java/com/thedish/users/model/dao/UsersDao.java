package com.thedish.users.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.users.model.vo.Users;

@Repository("usersDao")
public class UsersDao {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    // 로그인
    public Users selectLogin(Users users) {
        return sqlSessionTemplate.selectOne("usersMapper.selectLogin", users);
    }

    // 비밀번호 수정
    public int updatePassword(Users user) {
        return sqlSessionTemplate.update("usersMapper.updatePassword", user);
    }

    // 내 정보 조회 (by loginId)
    public Users selectUsers(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectUsers", loginId);
    }

    // 회원가입
    public int insertUser(Users user) {
        return sqlSessionTemplate.insert("usersMapper.insertUser", user);
    }

    // 아이디 중복 체크
    public int selectCheckId(String userId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectCheckId", userId);
    }

    // 닉네임 중복 체크
    public int selectChecknickName(String nickName) {
        return sqlSessionTemplate.selectOne("usersMapper.selectChecknickName", nickName);
    }

    // 회원정보 수정
    public int updateUser(Users user) {
        return sqlSessionTemplate.update("usersMapper.updateUser", user);
    }

    // 회원 논리 탈퇴 (status = 'INACTIVE')
    public int deactivateUser(String loginId) {
        return sqlSessionTemplate.update("usersMapper.deactivateUser", loginId);
    }

    // 관리자용 상태 변경
    public int updateLoginOk(Users users) {
        return sqlSessionTemplate.update("usersMapper.updateStatus", users);
    }

    // 관리자용 전체 회원 수
    public int selectListCount() {
        return sqlSessionTemplate.selectOne("usersMapper.selectListCount");
    }

    // 관리자용 전체 회원 리스트
    public ArrayList<Users> selectList(Paging paging) {
        return (ArrayList) sqlSessionTemplate.selectList("usersMapper.selectList", paging);
    }

    // 검색 관련 카운트
    public int selectSearchUserIdCount(String keyword) {
        return sqlSessionTemplate.selectOne("usersMapper.selectSearchUserIdCount", keyword);
    }

    public int selectSearchCreatedAtCount(Search search) {
        return sqlSessionTemplate.selectOne("usersMapper.selectSearchCreatedAtCount", search);
    }

    public int selectSearchStatusCount(String keyword) {
        return sqlSessionTemplate.selectOne("usersMapper.selectSearchStatusCount", keyword);
    }

    // 검색 관련 리스트
    public ArrayList<Users> selectSearchUserId(Search search) {
        return (ArrayList) sqlSessionTemplate.selectList("usersMapper.selectSearchUserId", search);
    }

    public ArrayList<Users> selectSearchCreatedAt(Search search) {
        return (ArrayList) sqlSessionTemplate.selectList("usersMapper.selectSearchCreatedAt", search);
    }

    public ArrayList<Users> selectSearchStatus(Search search) {
        return (ArrayList) sqlSessionTemplate.selectList("usersMapper.selectSearchStatus", search);
    }

    public Users findByLoginIdAndEmail(String loginId, String email) {
        Users param = new Users();
        param.setLoginId(loginId);
        param.setEmail(email);
        return sqlSessionTemplate.selectOne("usersMapper.findByLoginIdAndEmail", param);
    }
    
    public int deleteUsers(String userId) {
        return sqlSessionTemplate.update("usersMapper.deleteUsers", userId);
    }

    public int updatePassword(String loginId, String encPwd) {
        Map<String, Object> param = new HashMap<>();
        param.put("loginId", loginId);
        param.put("encPwd", encPwd);
        return sqlSessionTemplate.update("usersMapper.updatePassword", param);
    }
    
    public Users selectUserByLoginId(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectUserByLoginId", loginId);
    }
}
