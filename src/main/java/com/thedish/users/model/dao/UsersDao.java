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

    public Users selectLogin(Users users) {
        return sqlSessionTemplate.selectOne("usersMapper.selectLogin", users);
    }

    // ✅ 비밀번호 변경용 - loginId와 암호화된 비밀번호를 매핑하여 업데이트
    public int updatePassword(String loginId, String encPwd) {
        Map<String, Object> param = new HashMap<>();
        param.put("loginId", loginId);
        param.put("encPwd", encPwd);
        return sqlSessionTemplate.update("usersMapper.updatePassword", param);
    }

    public Users selectUsers(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectUsers", loginId);
    }

    public int insertUser(Users user) {
        return sqlSessionTemplate.insert("usersMapper.insertUser", user);
    }

    public int selectCheckId(String userId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectCheckId", userId);
    }

    public int selectChecknickName(String nickName) {
        return sqlSessionTemplate.selectOne("usersMapper.selectChecknickName", nickName);
    }

    public int updateUser(Users user) {
        return sqlSessionTemplate.update("usersMapper.updateUser", user);
    }

    public int deactivateUser(String loginId) {
        return sqlSessionTemplate.update("usersMapper.deactivateUser", loginId);
    }

    public int updateLoginOk(Users users) {
        return sqlSessionTemplate.update("usersMapper.updateStatus", users);
    }

    public int selectListCount() {
        return sqlSessionTemplate.selectOne("usersMapper.selectListCount");
    }

    public ArrayList<Users> selectList(Paging paging) {
        return (ArrayList) sqlSessionTemplate.selectList("usersMapper.selectList", paging);
    }

    public int selectSearchUserIdCount(String keyword) {
        return sqlSessionTemplate.selectOne("usersMapper.selectSearchUserIdCount", keyword);
    }

    public int selectSearchCreatedAtCount(Search search) {
        return sqlSessionTemplate.selectOne("usersMapper.selectSearchCreatedAtCount", search);
    }

    public int selectSearchStatusCount(String keyword) {
        return sqlSessionTemplate.selectOne("usersMapper.selectSearchStatusCount", keyword);
    }

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

    public Users selectUserByLoginId(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectUserByLoginId", loginId);
    }

    // 자유게시판 조회수 총합
    public int selectFreeBoardViewCount(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectFreeBoardViewCount", loginId);
    }

    // 자유게시판 작성글 수
    public int selectFreeBoardPostCount(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectFreeBoardPostCount", loginId);
    }

    // 자유게시판 마지막 작성일
    public String selectFreeBoardLastPostDate(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectFreeBoardLastPostDate", loginId);
    }

    // 후기게시판 작성글 수
    public int selectReviewBoardPostCount(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectReviewBoardPostCount", loginId);
    }

    // 후기게시판 마지막 작성일
    public String selectReviewBoardLastPostDate(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectReviewBoardLastPostDate", loginId);
    }

    // 후기게시판 댓글 수
    public int selectBoardCommentCount(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectBoardCommentCount", loginId);
    }

    // 후기게시판 마지막 댓글 작성일
    public String selectBoardLastCommentDate(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectBoardLastCommentDate", loginId);
    }

    // 팁게시판 작성글 수
    public int selectTipBoardPostCount(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectTipBoardPostCount", loginId);
    }

    // 팁게시판 마지막 작성일
    public String selectTipBoardLastPostDate(String loginId) {
        return sqlSessionTemplate.selectOne("usersMapper.selectTipBoardLastPostDate", loginId);
    }
}
