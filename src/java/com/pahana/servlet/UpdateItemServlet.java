package com.pahana.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.pahana.util.DBUtil;

@WebServlet("/updateItem")
public class UpdateItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("item_code");
        String name = request.getParameter("item_name");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String description = request.getParameter("description");

        try {
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);

            try (Connection conn = DBUtil.getConnection()) {
                String sql = "UPDATE items SET item_name=?, category=?, price=?, stock=?, description=? WHERE item_code=?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, name);
                stmt.setString(2, category);
                stmt.setDouble(3, price);
                stmt.setInt(4, stock);
                stmt.setString(5, description);
                stmt.setString(6, code);

                stmt.executeUpdate();
            }

            response.sendRedirect("items.jsp?success=Item updated successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("edit_item.jsp?code=" + code + "&error=Failed to update item");
        }
    }
}
