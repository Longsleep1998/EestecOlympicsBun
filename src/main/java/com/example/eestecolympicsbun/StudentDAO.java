package com.example.catalog;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    private static final String SELECT_ALL_UNENROLLED_STUDENTS = "Select u.* from users u where role=2 except select u.* from users u join enrollments e on e.user_id=u.id and e.course_id=? where role=2 ";
    private static final String SELECT_ALL_ENROLLED_STUDENTS = "Select u.* from users u join enrollments e on e.user_id=u.id and e.course_id=? where u.role=2";

    public static List<StudentBEAN> allenrolledstudents(int courseID) throws SQLException, ClassNotFoundException {
        List<StudentBEAN> allstudents = new ArrayList<>();
        try (Connection connection = DatabaseCon.initializeDatabase();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_ENROLLED_STUDENTS);

        ) {
            preparedStatement.setInt(1,courseID);
            try(ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    StudentBEAN student = new StudentBEAN();
                    student.setId(rs.getInt("id"));
                    student.setClassCurrent(rs.getString("classCurrent"));
                    student.setFirstName(rs.getString("firstName"));
                    student.setLastName(rs.getString("lastName"));
                    student.setYearOfStudy(rs.getInt("yearOfStudy"));
                    student.setAction("Disenroll");
                    allstudents.add(student);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return allstudents;
    }
    public List<StudentBEAN> allunenrolledstudents(int CourseID) {
        List<StudentBEAN> allunenrolledstudents = new ArrayList<>();
        try (Connection connection = DatabaseCon.initializeDatabase();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_UNENROLLED_STUDENTS)) {
            preparedStatement.setInt(1, CourseID);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                StudentBEAN student = new StudentBEAN();
                student.setId(rs.getInt("id"));
                student.setClassCurrent(rs.getString("classCurrent"));
                student.setFirstName(rs.getString("firstName"));
                student.setLastName(rs.getString("lastName"));
                student.setYearOfStudy(rs.getInt("yearOfStudy"));
                student.setAction("Enroll");
                allunenrolledstudents.add(student);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return allunenrolledstudents;
    }
}


