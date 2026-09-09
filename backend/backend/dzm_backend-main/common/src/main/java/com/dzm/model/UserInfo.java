package com.dzm.model;

import com.dzm.constant.UserRoleTyoe;
import lombok.Builder;

import java.io.Serializable;
import java.util.List;
import java.util.UUID;

@Builder
public class UserInfo implements Serializable {

    @Builder.Default
    private String id = UUID.randomUUID().toString().replace("-", "");

    private String email;

    private String username;

    private String nickname;

    private String password;

    @Builder.Default
    private String avatar = "";

    @Builder.Default
    private Integer role = UserRoleTyoe.GENERAL.getRole();

    @Builder.Default
    private Boolean isDeleted = false;

    @Builder.Default
    private Long createdTime = System.currentTimeMillis();

    @Builder.Default
    private Long modifiedTime = System.currentTimeMillis();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname == null ? null : nickname.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar == null ? null : avatar.trim();
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public Long getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Long createdTime) {
        this.createdTime = createdTime;
    }

    public Long getModifiedTime() {
        return modifiedTime;
    }

    public void setModifiedTime(Long modifiedTime) {
        this.modifiedTime = modifiedTime;
    }


    public static boolean checkRoles(int role, int[] requiredRoles) {
        if(requiredRoles == null || requiredRoles.length == 0) {
            return true;
        }
        for(int r: requiredRoles) {
            if((role & r) != 0) return true;
        }
        return false;
    }

    public void setRoles(List<Integer> roles) {
        if(roles == null) return;
        int role = 0;
        for(Integer r: roles) {
            role = role | r;
        }
        setRole(role);
    }

}