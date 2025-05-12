package com.thedish.users.model.service;

import java.util.ArrayList;

import org.slf4j.Logger;  // 추가
import org.slf4j.LoggerFactory;  // 추가
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.users.model.dao.UsersDao;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpSession;

@Service("usersService")
public class UsersServiceImpl implements UsersService {

    private static final Logger logger = LoggerFactory.getLogger(UsersServiceImpl.class);  // logger 초기화

    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;
    
    @Autowired
    private UsersDao usersDao;

    // 세션을 처리하기 위한 의존성 주입
    @Autowired
    private HttpSession session;

    @Override
    public Users selectLogin(Users users) {
        return usersDao.selectLogin(users);
    }

    @Override
    public Users selectUsers(String loginId) {
        return usersDao.selectUsers(loginId);
    }

    @Override
    public int insertUser(Users user) {
        return usersDao.insertUser(user);
    }

    @Override
    public int selectChecknickName(String nickName) {
        return usersDao.selectChecknickName(nickName);  
    }

    @Override
    public int selectCheckId(String userId) {
        return usersDao.selectCheckId(userId);
    }

    // 회원 정보 수정
    @Override
    public int updateUser(Users user) {
        return usersDao.updateUser(user); // updateUser 메서드를 호출
    }

    // 회원 탈퇴
    @Override
    public int deleteUsers(String userId) {
        logger.info("Attempting to delete user with loginId: " + userId); // 로그 추가

        int result = usersDao.deleteUsers(userId);

        if (result > 0) {
            logger.info("User successfully deleted: " + userId); // 성공 로그 추가
            session.invalidate();
        } else {
            logger.error("Failed to delete user: " + userId); // 실패 로그 추가
        }

        return result;
    }

    // 검색 관련 메서드 구현
    @Override
    public int selectListCount() {
        return usersDao.selectListCount();  // 전체 회원 수 조회
    }

    @Override
    public ArrayList<Users> selectList(Paging paging) {
        return usersDao.selectList(paging); // 페이징 처리된 회원 리스트 조회
    }

    @Override
    public int updateStatus(Users users) {
        return usersDao.updateLoginOk(users); // 사용자 상태 업데이트
    }
    
    @Override
    public Users findByLoginIdAndEmail(String loginId, String email) {
        return usersDao.findByLoginIdAndEmail(loginId, email);
    }
    
    // 3. UsersServiceImpl.java - 비밀번호 변경 로직
    @Override
    public int resetPassword(String loginId, String newPassword) {
        String encPwd = bcryptPasswordEncoder.encode(newPassword);
        return usersDao.updatePassword(loginId, encPwd);
    }
    

    @Override
    public int selectSearchUserIdCount(String keyword) {
        return usersDao.selectSearchUserIdCount(keyword);  // 사용자 아이디로 검색된 갯수
    }

    @Override
    public int selectSearchCreatedAtCount(Search search) {
        return usersDao.selectSearchCreatedAtCount(search);  // 생성일자로 검색된 갯수
    }

    @Override
    public int selectSearchStatusCount(String keyword) {
        return usersDao.selectSearchStatusCount(keyword);  // 사용자 상태로 검색된 갯수
    }

    @Override
    public ArrayList<Users> selectSearchUserId(Search search) {
        return usersDao.selectSearchUserId(search); // 사용자 아이디로 검색된 리스트
    }

    @Override
    public ArrayList<Users> selectSearchCreatedAt(Search search) {
        return usersDao.selectSearchCreatedAt(search); // 생성일자로 검색된 리스트
    }

    @Override
    public ArrayList<Users> selectSearchStatus(Search search) {
        return usersDao.selectSearchStatus(search); // 상태로 검색된 리스트
    }
}
