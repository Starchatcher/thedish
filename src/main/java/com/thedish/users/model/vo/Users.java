package com.thedish.users.model.vo;

import java.sql.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

public class Users implements java.io.Serializable {
    private static final long serialVersionUID = -8078395567683396465L;

    private String userId;         // ← JSP의 name="userId"
    private String password;       // ← name="userPwd"
    private String userPwd2;       // ← 비밀번호 확인용 (DB 저장 X)
    private String userName;       // ← name="userName"
    private String nickName;       // ← name="nickName"
    private String gender;         // ← name="gender"
    private int age;               // ← name="age"
    private String phone;          // ← name="phone"
    private String email;          // ← name="email"
    private String status;         // ← name="status"
    private String provider;       // ← name="provider"
    private String role;           // ← name="role"
    private String loginId;        // ← name="loginId"

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createdAt;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date updatedAt;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date withdrawnAt;

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
    
    //
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getWithdrawnAt() { return withdrawnAt; }
    public void setWithdrawnAt(Date withdrawnAt) { this.withdrawnAt = withdrawnAt; }

    //
    
    @Override
    public String toString() {
        return "Users [userId=" + userId + ", password=" + password + ", userPwd2=" + userPwd2 +
               ", userName=" + userName + ", nickName=" + nickName + ", gender=" + gender +
               ", age=" + age + ", phone=" + phone + ", email=" + email +
               ", status=" + status + ", provider=" + provider + ", role=" + role +
               ", loginId=" + loginId + ", createdAt=" + createdAt +
               ", updatedAt=" + updatedAt + ", withdrawnAt=" + withdrawnAt + "]";
    }
}
