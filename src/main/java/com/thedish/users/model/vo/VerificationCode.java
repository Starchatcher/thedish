package com.thedish.users.model.vo;

import java.sql.Date;

public class VerificationCode {
    private int id;
    private String email;
    private String code;
    private Date createdAt;
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public VerificationCode setId(int id) {
        this.id = id;
        return this;
    }
    
    public String getEmail() {
        return email;
    }
    
    public VerificationCode setEmail(String email) {
        this.email = email;
        return this;
    }
    
    public String getCode() {
        return code;
    }
    
    public VerificationCode setCode(String code) {
        this.code = code;
        return this;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public VerificationCode setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
        return this;
    }
}