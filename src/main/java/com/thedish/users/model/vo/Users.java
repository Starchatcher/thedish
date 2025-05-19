package com.thedish.users.model.vo;

import java.sql.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

public class Users implements java.io.Serializable {
    private static final long serialVersionUID = -8078395567683396465L;

    private String userId;
    private String password;
    private String userPwd2;
    private String userName;
    private String nickName;
    private String gender;
    private int age;
    private String phone;
    private String email;
    private String status;
    private String provider;
    private String role;
    private String loginId;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createdAt;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date updatedAt;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date withdrawnAt;

    // 🔹 자유게시판 최근 작성일
    private String lastPostDate;
    
 // 후기 게시판 관련 통계
    private int boardCommentCount;
    private String boardLastCommentDate;

    public Users() {}

    public Users(String userId, String password, String userName, String nickName, String gender, int age,
                 String phone, String email, String status, String provider, String role,
                 String loginId, Date createdAt, Date updatedAt, Date withdrawnAt) {
        this.userId = userId;
        this.password = password;
        this.userName = userName;
        this.nickName = nickName;
        this.gender = gender;
        this.age = age;
        this.phone = phone;
        this.email = email;
        this.status = status;
        this.provider = provider;
        this.role = role;
        this.loginId = loginId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.withdrawnAt = withdrawnAt;
    }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public void setUserPwd(String userPwd) { this.password = userPwd; }
    public String getUserPwd() { return this.password; }

    public String getUserPwd2() { return userPwd2; }
    public void setUserPwd2(String userPwd2) { this.userPwd2 = userPwd2; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getNickName() { return nickName; }
    public void setNickName(String nickName) { this.nickName = nickName; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getProvider() { return provider; }
    public void setProvider(String provider) { this.provider = provider; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getLoginId() { return loginId; }
    public void setLoginId(String loginId) { this.loginId = loginId; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getWithdrawnAt() { return withdrawnAt; }
    public void setWithdrawnAt(Date withdrawnAt) { this.withdrawnAt = withdrawnAt; }

    // 🔹 자유게시판 최근 작성일
    public String getLastPostDate() {
        return lastPostDate;
    }

    public void setLastPostDate(String lastPostDate) {
        this.lastPostDate = lastPostDate;
    }
    
    public int getBoardCommentCount() {
        return boardCommentCount;
    }

    public void setBoardCommentCount(int boardCommentCount) {
        this.boardCommentCount = boardCommentCount;
    }

    public String getBoardLastCommentDate() {
        return boardLastCommentDate;
    }

    public void setBoardLastCommentDate(String boardLastCommentDate) {
        this.boardLastCommentDate = boardLastCommentDate;
    }

    @Override
    public String toString() {
        return "Users [userId=" + userId + ", password=" + password + ", userPwd2=" + userPwd2 +
                ", userName=" + userName + ", nickName=" + nickName + ", gender=" + gender +
                ", age=" + age + ", phone=" + phone + ", email=" + email + ", status=" + status +
                ", provider=" + provider + ", role=" + role + ", loginId=" + loginId +
                ", createdAt=" + createdAt + ", updatedAt=" + updatedAt +
                ", withdrawnAt=" + withdrawnAt + ", lastPostDate=" + lastPostDate + "]";
    }
}
