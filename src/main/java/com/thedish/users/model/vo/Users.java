package com.thedish.users.model.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Users implements java.io.Serializable{
	private static final long serialVersionUID = -8078395567683396465L;
	
	
	//Field == Property (멤버변수 == 속성)
		private int userId;
		private String email;
		private String nickName;
		private String password;
		private String provider;
		private String role;
		private String status;
		private String loginId;
		private String userName;
		@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
		private java.sql.Date createdAt;

		public Users() {
			super();
		}

		public Users(int userId, String email, String nickName, String password, String provider, String role,
				String status, String loginId, String userName, Date createdAt) {
			super();
			this.userId = userId;
			this.email = email;
			this.nickName = nickName;
			this.password = password;
			this.provider = provider;
			this.role = role;
			this.status = status;
			this.loginId = loginId;
			this.userName = userName;
			this.createdAt = createdAt;
		}

		public int getUserId() {
			return userId;
		}

		public void setUserId(int userId) {
			this.userId = userId;
		}

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getNickName() {
			return nickName;
		}

		public void setNickName(String nickName) {
			this.nickName = nickName;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}

		public String getProvider() {
			return provider;
		}

		public void setProvider(String provider) {
			this.provider = provider;
		}

		public String getRole() {
			return role;
		}

		public void setRole(String role) {
			this.role = role;
		}

		public String getStatus() {
			return status;
		}

		public void setStatus(String status) {
			this.status = status;
		}

		public String getLoginId() {
			return loginId;
		}

		public void setLoginId(String loginId) {
			this.loginId = loginId;
		}

		public String getUserName() {
			return userName;
		}

		public void setUserName(String userName) {
			this.userName = userName;
		}

		public java.sql.Date getCreatedAt() {
			return createdAt;
		}

		public void setCreatedAt(java.sql.Date createdAt) {
			this.createdAt = createdAt;
		}

		public static long getSerialversionuid() {
			return serialVersionUID;
		}
		
		// 확인용 비밀번호 필드 (폼 검증용, DB 저장 X)
		private String userPwd2;

		public String getUserPwd2() {
		    return userPwd2;
		}

		public void setUserPwd2(String userPwd2) {
		    this.userPwd2 = userPwd2;
		}

		@Override
		public String toString() {
			return "Users [userId=" + userId + ", email=" + email + ", nickName=" + nickName + ", password=" + password
					+ ", provider=" + provider + ", role=" + role + ", status=" + status + ", loginId=" + loginId
					+ ", userName=" + userName + ", createdAt=" + createdAt + "]";
		}
		
		
}
