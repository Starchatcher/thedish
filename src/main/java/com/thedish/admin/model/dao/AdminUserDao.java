package com.thedish.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.thedish.users.model.vo.Users;

public interface AdminUserDao {
    Users selectUserById(String userId);
    int updateUser(Users user);
    List<Users> selectAllUsers();
    List<Users> searchUsers(Map<String, String> paramMap);
    int countTotalUsers();
    int countActiveUsers();
    int countWithdrawnUsers();
    int deactivateUser(String loginId); // 로그인 ID 기준으로 status = 'INACTIVE' 처리
}
