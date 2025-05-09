package com.thedish.users.model.service;

import java.util.ArrayList;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.users.model.vo.Users;

public interface UsersService {
    // 로그인
    Users selectLogin(Users user);

    // 내 정보 조회 (by loginId)
    Users selectUsers(String loginId);

    // 회원가입
    int insertUser(Users user);

    // 아이디 중복 체크
    int selectCheckId(String userId);

    // 회원 정보 수정
    int updateUser(Users user);

    // 회원 탈퇴
    int deleteUsers(String userId);
    
 // 닉네임 중복 체크
    int selectChecknickName(String nickName);
    
    int updatePassword(Users user);

    // 관리자 기능
    int selectListCount();
    ArrayList<Users> selectList(Paging paging);
    int updateStatus(Users users);
    
    // 검색 관련 기능
    int selectSearchUserIdCount(String keyword);
    int selectSearchCreatedAtCount(Search search);
    int selectSearchStatusCount(String keyword);

    ArrayList<Users> selectSearchUserId(Search search);
    ArrayList<Users> selectSearchCreatedAt(Search search);
    ArrayList<Users> selectSearchStatus(Search search);
}
