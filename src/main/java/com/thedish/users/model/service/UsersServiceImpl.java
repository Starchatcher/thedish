package com.thedish.users.model.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.users.model.dao.UsersDao;
import com.thedish.users.model.vo.Users;

@Service("usersService")
public class UsersServiceImpl implements UsersService {

    private static final Logger logger = LoggerFactory.getLogger(UsersServiceImpl.class);

    @Autowired
    private UsersDao usersDao;

 
    // 🔐 로그인
    @Override
    public Users selectLogin(Users users) {
        return usersDao.selectLogin(users);
    }

    // 👤 내 정보 조회
    @Override
    public Users selectUsers(String loginId) {
        return usersDao.selectUsers(loginId);
    }

    // 📝 회원가입
    @Override
    public int insertUser(Users user) {
        return usersDao.insertUser(user);
    }

    // 🔁 회원 정보 수정
    @Override
    public int updateUser(Users user) {
        return usersDao.updateUser(user);
    }

    // 🔑 비밀번호 변경
    @Override
    public int updatePassword(Users user) {
        return usersDao.updatePassword(user);
    }
    
    @Override
    public int deleteUsers(String userId) {
        return usersDao.deleteUsers(userId); // 또는 내부 로직에 맞게 수정
    }

 

    // 🚫 회원 탈퇴 (논리 삭제)
    @Override
    public int deactivateUser(String loginId) {
        return usersDao.deactivateUser(loginId);
    }

    // ✅ 아이디 중복 체크
    @Override
    public int selectCheckId(String userId) {
        return usersDao.selectCheckId(userId);
    }

    // ✅ 닉네임 중복 체크
    @Override
    public int selectChecknickName(String nickName) {
        return usersDao.selectChecknickName(nickName);
    }

    // 👨‍💼 관리자: 전체 회원 수
    @Override
    public int selectListCount() {
        return usersDao.selectListCount();
    }

    // 👨‍💼 관리자: 전체 회원 리스트
    @Override
    public ArrayList<Users> selectList(Paging paging) {
        return usersDao.selectList(paging);
    }

    // 👨‍💼 관리자: 회원 상태 변경
    @Override
    public int updateStatus(Users users) {
        return usersDao.updateLoginOk(users);
    }


    // 🔍 검색 카운트
    @Override
    public int selectSearchUserIdCount(String keyword) {
        return usersDao.selectSearchUserIdCount(keyword);
    }

    @Override
    public int selectSearchCreatedAtCount(Search search) {
        return usersDao.selectSearchCreatedAtCount(search);
    }

    @Override
    public int selectSearchStatusCount(String keyword) {
        return usersDao.selectSearchStatusCount(keyword);
    }

    // 🔍 검색 리스트
    @Override
    public ArrayList<Users> selectSearchUserId(Search search) {
        return usersDao.selectSearchUserId(search);
    }

    @Override
    public ArrayList<Users> selectSearchCreatedAt(Search search) {
        return usersDao.selectSearchCreatedAt(search);
    }

    @Override
    public ArrayList<Users> selectSearchStatus(Search search) {
        return usersDao.selectSearchStatus(search);
    }

    // 🔐 이메일 기반 사용자 검색
    @Override
    public Users findByLoginIdAndEmail(String loginId, String email) {
        return usersDao.findByLoginIdAndEmail(loginId, email);
    }
}
