package com.thedish.users.model.service;

import java.util.ArrayList;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.users.model.vo.Users;

public interface UsersService {

    // 🔐 로그인
    Users selectLogin(Users user);

    // 👤 내 정보 조회 (by loginId)
    Users selectUsers(String loginId);

    // 📝 회원가입
    int insertUser(Users user);

    // 🔁 회원 정보 수정
    int updateUser(Users user);

    // ✅ 비밀번호 변경 (loginId + 암호화된 비밀번호 전달)
    int updatePassword(String loginId, String encPwd);

    // 🚫 회원 탈퇴 (논리 삭제: status = 'INACTIVE')
    int deactivateUser(String loginId);

    // ✅ 아이디 중복 체크
    int selectCheckId(String userId);

    // 회원 탈퇴
    int deleteUsers(String userId);

    // 닉네임 중복 체크
    int selectChecknickName(String nickName);

    // 👨‍💼 관리자: 전체 회원 수 조회
    int selectListCount();

    // 👨‍💼 관리자: 전체 회원 리스트 조회 (페이징)
    ArrayList<Users> selectList(Paging paging);

    // 👨‍💼 관리자: 회원 상태 변경
    int updateStatus(Users users);

    // 🔍 검색 관련: Count
    int selectSearchUserIdCount(String keyword);
    int selectSearchCreatedAtCount(Search search);
    int selectSearchStatusCount(String keyword);

    // 🔍 검색 관련: List
    ArrayList<Users> selectSearchUserId(Search search);
    ArrayList<Users> selectSearchCreatedAt(Search search);
    ArrayList<Users> selectSearchStatus(Search search);

    // 🔐 아이디 + 이메일로 사용자 찾기 (비밀번호 초기화용)
    Users findByLoginIdAndEmail(String loginId, String email);

    Users selectUserByLoginId(String loginId);

    // 🔢 마이페이지 활동 요약
    int getFreeBoardViewCount(String loginId);
    int getFreeBoardPostCount(String loginId);
    int getBoardCommentCount(String loginId);
    int getReviewBoardPostCount(String loginId);
    int getTipBoardPostCount(String loginId);

    // 🔹 자유/댓글/후기 마지막 작성일
    String getFreeBoardLastPostDate(String loginId);
    String getBoardLastCommentDate(String loginId);
    String getReviewBoardLastPostDate(String loginId);
    String getTipBoardLastPostDate(String loginId);
}
