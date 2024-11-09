package com.example.catalog;

import com.example.catalog.DatabaseCon;
import com.example.catalog.TicetsBEAN;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TicketsDAO {

    public String hashMessage(String message) throws NoSuchAlgorithmException {
        final MessageDigest digest = MessageDigest.getInstance("SHA3-256");
        final byte[] hashBytes = digest.digest(message.getBytes(StandardCharsets.UTF_8));
        return bytesToHex(hashBytes);
    }

    private static String bytesToHex(byte[] hash) {
        StringBuilder hexString = new StringBuilder(2 * hash.length);
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }

    private static final String SELECT_ALL_CURRENT_TICKETS = "SELECT * FROM tickets WHERE Status = 0";
    private static final String SELECT_ALL_OLD_TICKETS = "SELECT * FROM tickets WHERE Status = 2 OR Status=1";
    private static final String UPDATE_TICKET_STATUS1 = "UPDATE tickets SET Status = ? WHERE ID_Ticket = ? AND Status=0 ";
    private static final String UPDATE_TICKET_STATUS2 = "UPDATE users SET Password = ? WHERE ID_User = ?";
    private static final String UPDATE_TICKET_STATUS3 = "INSERT INTO enrollments (user_id, course_id) VALUES (?, ?) ";

    public List<TicetsBEAN> selectAllCurrentTickets() {
        List<TicetsBEAN> tickets = new ArrayList<>();
        try (Connection connection = DatabaseCon.initializeDatabase();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CURRENT_TICKETS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                TicetsBEAN ticket = new TicetsBEAN();
                ticket.setId(rs.getInt("ID_Ticket"));
                ticket.setInsertDate(rs.getString("InsertDate"));
                ticket.setUserIDSolicitant(rs.getInt("UserIDSolicitant"));
                ticket.setTicketType(rs.getInt("TicketType"));
                ticket.setStatus(rs.getInt("Status"));
                ticket.setNewUser(rs.getString("NewUser"));
                ticket.setNewPassword(rs.getString("NewPassword"));
                ticket.setCourseID(rs.getInt("CourseID"));
                tickets.add(ticket);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return tickets;
    }
    public List<TicetsBEAN> selectAllOldTickets() {
        List<TicetsBEAN> tickets = new ArrayList<>();
        try (Connection connection = DatabaseCon.initializeDatabase();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_OLD_TICKETS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                TicetsBEAN ticket = new TicetsBEAN();
                ticket.setId(rs.getInt("ID_Ticket"));
                ticket.setInsertDate(rs.getString("InsertDate"));
                ticket.setUserIDSolicitant(rs.getInt("UserIDSolicitant"));
                ticket.setTicketType(rs.getInt("TicketType"));
                ticket.setStatus(rs.getInt("Status"));
                ticket.setNewUser(rs.getString("NewUser"));
                ticket.setNewPassword(rs.getString("NewPassword"));
                ticket.setCourseID(rs.getInt("CourseID"));
                tickets.add(ticket);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    public boolean updateTicketStatusAccept(int ticketId, int newStatus) {
        try (Connection connection = DatabaseCon.initializeDatabase()) {

            // Query to get the TicketType and relevant data based on the ticket ID
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "SELECT TicketType, NewPassword, NewUser, UserIDSolicitant, CourseID FROM tickets WHERE ID_Ticket = ?");
            preparedStatement.setInt(1, ticketId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int ticketType = resultSet.getInt("TicketType");

                // Update the ticket status
                PreparedStatement updateStatusStmt = connection.prepareStatement(UPDATE_TICKET_STATUS1);
                updateStatusStmt.setInt(1, newStatus);
                updateStatusStmt.setInt(2, ticketId);
                updateStatusStmt.executeUpdate();
                updateStatusStmt.close();

                if (ticketType == 1) {
                    // If TicketType is 1, update the user's password
                    String newPasswordHashed = hashMessage(resultSet.getString("NewPassword"));
                    PreparedStatement updatePasswordStmt = connection.prepareStatement(UPDATE_TICKET_STATUS2);
                    updatePasswordStmt.setString(1, newPasswordHashed);
                    updatePasswordStmt.setInt(2, resultSet.getInt("UserIDSolicitant"));
                    updatePasswordStmt.executeUpdate();
                    updatePasswordStmt.close();

                } else if (ticketType == 2) {
                    // If TicketType is 2, insert a new enrollment record
                    PreparedStatement insertEnrollmentStmt = connection.prepareStatement(UPDATE_TICKET_STATUS3);
                    insertEnrollmentStmt.setInt(1, resultSet.getInt("UserIDSolicitant"));
                    insertEnrollmentStmt.setInt(2, resultSet.getInt("CourseID"));
                    insertEnrollmentStmt.executeUpdate();
                    insertEnrollmentStmt.close();
                }

                return true;
            }
            return false;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean updateTicketStatusReject(int ticketId, int newStatus) throws SQLException, ClassNotFoundException {
        Connection connection = DatabaseCon.initializeDatabase();
        PreparedStatement preparedStatement = connection.prepareStatement("UPDATE tickets SET Status=? WHERE ID_Ticket=?");
        preparedStatement.setInt(1, newStatus);
        preparedStatement.setInt(2, ticketId);
        return true;
    }
    }

