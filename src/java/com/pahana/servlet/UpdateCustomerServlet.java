package com.pahana.servlet;

import com.pahana.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/updateCustomer")
public class UpdateCustomerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String originalAcc = request.getParameter("originalAcc");
        String accNo = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE customers SET account_number=?, name=?, address=?, phone=?, email=? WHERE account_number=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, accNo);
            stmt.setString(2, name);
            stmt.setString(3, address);
            stmt.setString(4, phone);
            stmt.setString(5, email);
            stmt.setString(6, originalAcc);

            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("customers.jsp?success=Customer+updated+successfully");
            } else {
                response.getWriter().write("Update failed.");
            }

        } catch (Exception e) {
            throw new ServletException("Database update failed", e);
        }
    }
}
