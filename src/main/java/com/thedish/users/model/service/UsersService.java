package com.thedish.users.model.service;

import com.thedish.users.model.vo.Users;

public interface UsersService {
	Users selectLogin(Users user);
	Users selectUsers(String loginId);

}