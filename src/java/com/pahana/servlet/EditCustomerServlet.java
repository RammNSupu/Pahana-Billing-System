package com.pahana.servlet;

import com.pahana.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/editCustomer")
public class EditCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerId = request.getParameter("id");

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM customers WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, customerId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                request.setAttribute("id", rs.getInt("id"));
                request.setAttribute("accountNumber", rs.getString("account_number"));
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("address", rs.getString("address"));
                request.setAttribute("phone", rs.getString("phone"));
                request.setAttribute("email", rs.getString("email"));

                request.getRequestDispatcher("edit_customer.jsp").forward(request, response);
            } else {
                response.sendRedirect("customers.jsp?error=Customer+not+found");
            }

        } catch (SQLException e) {
            throw new ServletException("Error loading customer for editing", e);
        }
    }
}
