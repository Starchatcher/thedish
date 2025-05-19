package com.thedish.users.model.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
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

    // ✅ 비밀번호 변경 (loginId + 암호화된 비밀번호 전달)
    @Override
    public int updatePassword(String loginId, String encPwd) {
        return usersDao.updatePassword(loginId, encPwd);
    }

    // 🧨 계정 삭제
    @Override
    public int deleteUsers(String userId) {
        return usersDao.deleteUsers(userId);
    }

    // 🚫 탈퇴 처리
    @Override
    public int deactivateUser(String loginId) {
        return usersDao.deactivateUser(loginId);
    }

    // ✅ 중복 체크
    @Override
    public int selectCheckId(String userId) {
        return usersDao.selectCheckId(userId);
    }

    @Override
    public int selectChecknickName(String nickName) {
        return usersDao.selectChecknickName(nickName);
    }

    // 👨‍💼 관리자 기능
    @Override
    public int selectListCount() {
        return usersDao.selectListCount();
    }

    @Override
    public ArrayList<Users> selectList(Paging paging) {
        return usersDao.selectList(paging);
    }

    @Override
    public int updateStatus(Users users) {
        return usersDao.updateLoginOk(users);
    }

    // 🔍 검색 기능
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

    // 🔐 비밀번호 찾기용 사용자 조회
    @Override
    public Users findByLoginIdAndEmail(String loginId, String email) {
        return usersDao.findByLoginIdAndEmail(loginId, email);
    }

    @Override
    public Users selectUserByLoginId(String loginId) {
        return usersDao.selectUserByLoginId(loginId);
    }

    // 자유게시판 활동
    @Override
    public int getFreeBoardViewCount(String loginId) {
        return usersDao.selectFreeBoardViewCount(loginId);
    }

    @Override
    public int getFreeBoardPostCount(String loginId) {
        return usersDao.selectFreeBoardPostCount(loginId);
    }

    // 🔹 자유게시판 마지막 작성일 조회
    @Override
    public String getFreeBoardLastPostDate(String loginId) {
        return usersDao.selectFreeBoardLastPostDate(loginId);
    }

    @Override
    public int getReviewBoardPostCount(String loginId) {
        return usersDao.selectReviewBoardPostCount(loginId);
    }

    @Override
    public String getReviewBoardLastPostDate(String loginId) {
        return usersDao.selectReviewBoardLastPostDate(loginId);
    }

    @Override
    public int getBoardCommentCount(String loginId) {
        return usersDao.selectBoardCommentCount(loginId);
    }

    @Override
    public String getBoardLastCommentDate(String loginId) {
        return usersDao.selectBoardLastCommentDate(loginId);
    }

    @Override
    public int getTipBoardPostCount(String loginId) {
        return usersDao.selectTipBoardPostCount(loginId);
    }

    @Override
    public String getTipBoardLastPostDate(String loginId) {
        return usersDao.selectTipBoardLastPostDate(loginId);
    }
}
