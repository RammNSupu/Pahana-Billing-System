package com.pahana.servlet;

import com.pahana.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/addCustomer")
public class AddCustomerServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accNo = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO customers (account_number, name, address, phone, email) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, accNo);
            stmt.setString(2, name);
            stmt.setString(3, address);
            stmt.setString(4, phone);
            stmt.setString(5, email);

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
    response.sendRedirect("dashboard.jsp?success=Customer+added+successfully!");
}
 else {
request.setAttribute("error", "Failed to add customer.");
request.getRequestDispatcher("add_customer.jsp").forward(request, response);
}

        } catch (SQLException e) {
            throw new ServletException("Database insert failed!", e);
        }
    }
}
