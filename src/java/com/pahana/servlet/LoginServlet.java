package com.pahana.servlet;

import com.pahana.util.DBUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean usernameError = false;
        boolean passwordError = false;

        try (Connection conn = DBUtil.getConnection()) {

            //  Check if username exists
            String checkUser = "SELECT password FROM users WHERE username = ?";
            PreparedStatement stmtUser = conn.prepareStatement(checkUser);
            stmtUser.setString(1, username);
            ResultSet rsUser = stmtUser.executeQuery();

            if (!rsUser.next()) {
                // username not found
                usernameError = true;
            } else {
                //  check password
                String correctPassword = rsUser.getString("password");
                if (!correctPassword.equals(password)) {
                    passwordError = true;
                }
            }
            
            if (!usernameError && !passwordError) {
                // Login success
                RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
                dispatcher.forward(request, response);
            } else {
           
                request.setAttribute("usernameError", usernameError);
                request.setAttribute("passwordError", passwordError);
                request.setAttribute("usernameValue", username);
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database connection or query failed!", e);
        }
    }
}
