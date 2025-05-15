package com.thedish.admin.model.service;

import java.util.List;
import java.util.Map;  // ✅ Map을 사용하는 searchUsers를 위해 반드시 필요

import com.thedish.users.model.vo.Users;

public interface AdminUserService {

    Users selectUserById(String userId);
    int updateUser(Users user);
    List<Users> selectAllUsers();
    List<Users> searchUsers(Map<String, String> paramMap);
    int countTotalUsers();
    int countActiveUsers();
    int countWithdrawnUsers();
    int deactivateUser(String loginId);
}
