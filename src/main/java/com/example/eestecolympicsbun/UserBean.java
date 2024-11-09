package com.example.catalog;

public class UserBean {

    private String username;
    private String password;
    private int role;
    public boolean valid;


    public String getUsername() {
        return username;
    }

    public void setUsername(String newUsername) {
        username= newUsername;
    }


    public String getPassword() {
        return password;
    }

    public void setPassword(String newPassword) {
        password = newPassword;
    }


    public int getRole() {
        return role;
    }

    public void setRole(int newRole) {
        role = newRole;
    }


    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean newValid) {
        valid = newValid;
    }
}