package com.thedish.user.model.vo;

import java.sql.Date;

public class User {
    private int id;
    private String userId;
    private String password;
    private String name;
    private String birthdate;
    private String gender;
    private String email;
    private Date createdAt;
    private Date updatedAt;
    private String status;
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public User setId(int id) {
        this.id = id;
        return this;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public User setUserId(String userId) {
        this.userId = userId;
        return this;
    }
    
    public String getPassword() {
        return password;
    }
    
    public User setPassword(String password) {
        this.password = password;
        return this;
    }
    
    public String getName() {
        return name;
    }
    
    public User setName(String name) {
        this.name = name;
        return this;
    }
    
    public String getBirthdate() {
        return birthdate;
    }
    
    public User setBirthdate(String birthdate) {
        this.birthdate = birthdate;
        return this;
    }
    
    public String getGender() {
        return gender;
    }
    
    public User setGender(String gender) {
        this.gender = gender;
        return this;
    }
    
    public String getEmail() {
        return email;
    }
    
    public User setEmail(String email) {
        this.email = email;
        return this;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public User setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
        return this;
    }
    
    public Date getUpdatedAt() {
        return updatedAt;
    }
    
    public User setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
        return this;
    }
    
    public String getStatus() {
        return status;
    }
    
    public User setStatus(String status) {
        this.status = status;
        return this;
    }
    
    @Override
    public String toString() {
        return "User [id=" + id + ", userId=" + userId + ", name=" + name + ", email=" + email + ", status=" + status + "]";
    }
}