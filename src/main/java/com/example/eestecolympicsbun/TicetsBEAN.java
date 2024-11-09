package com.example.catalog;

public class TicetsBEAN {
    private int id;
    private String insertDate;
    private int userIDSolicitant;
    private int ticketType;
    private int status;
    private String newUser;
    private String newPassword;
    private int courseID;

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getInsertDate() {
        return insertDate;
    }
    public void setInsertDate(String insertDate) {
        this.insertDate = insertDate;
    }
    public int getUserIDSolicitant() {
        return userIDSolicitant;
    }
    public void setUserIDSolicitant(int userIDSolicitant) {
        this.userIDSolicitant = userIDSolicitant;
    }
    public int getTicketType() {
        return ticketType;
    }
    public void setTicketType(int ticketType) {
        this.ticketType = ticketType;
    }
    public int getStatus() {
        return status;
    }
    public void setStatus(int status) {
        this.status = status;
    }
    public String getNewUser() {

        return newUser;
    }
    public void setNewUser(String newUser) {
        this.newUser = newUser;
    }
    public String getNewPassword() {
        return newPassword;
    }
    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }
    public int getCourseID() {
        return courseID;
    }
    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }
}

