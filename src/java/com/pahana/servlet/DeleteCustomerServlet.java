package com.pahana.servlet;

import com.pahana.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/deleteCustomer")
public class DeleteCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accNo = request.getParameter("acc");

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "DELETE FROM customers WHERE account_number = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, accNo);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("customers.jsp?success=Customer+deleted+successfully");
            } else {
                response.sendRedirect("customers.jsp?success=No+matching+customer+found");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("customers.jsp?success=Error+while+deleting+customer");
        }
    }
}
