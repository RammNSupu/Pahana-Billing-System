package com.pahana.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.pahana.util.DBUtil;

@WebServlet("/addItem")
public class AddItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // 1. Get form data
        String code = request.getParameter("item_code");
        String name = request.getParameter("item_name");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String description = request.getParameter("description");

        try {
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);

            // 2. Save to database
            try (Connection conn = DBUtil.getConnection()) {
                String sql = "INSERT INTO items (item_code, item_name, category, price, stock, description) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, code);
                stmt.setString(2, name);
                stmt.setString(3, category);
                stmt.setDouble(4, price);
                stmt.setInt(5, stock);
                stmt.setString(6, description);

                stmt.executeUpdate();
            }

            // 3. Redirect back with success message
            response.sendRedirect("items.jsp?success=Item added successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add_item.jsp?error=Failed to add item");
        }
    }
}
