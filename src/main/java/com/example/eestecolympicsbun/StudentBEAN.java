package com.example.catalog;

public class StudentBEAN {
    private int id;
    private String firstName;
    private String lastName;
    private int yearOfStudy;
    private String classCurrent;
    private String action;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public int getYearOfStudy() {
        return yearOfStudy;
    }
    public void setYearOfStudy(int yearOfStudy) {
        this.yearOfStudy = yearOfStudy;
    }
    public String getClassCurrent() {
        return classCurrent;
    }
    public void setClassCurrent(String classCurrent) {
        this.classCurrent = classCurrent;
    }
    public String getAction() {
        return action;
    }
    public void setAction(String action) {
        this.action = action;
    }

}
