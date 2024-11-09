package com.example.catalog;
public class Assignments {
    private String dueDate;
    private String material;

    public Assignments(String dueDate, String material) {
        this.dueDate = dueDate;
        this.material = material;
    }

    public String getDueDate() {
        return dueDate;
    }

    public void setDueDate(String dueDate) {
        this.dueDate = dueDate;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }
}

