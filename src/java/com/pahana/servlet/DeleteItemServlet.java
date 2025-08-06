package com.pahana.servlet;

import com.pahana.util.DBUtil;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.*;

@WebServlet("/deleteItem")
public class DeleteItemServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM items WHERE item_code = ?");
            stmt.setString(1, code);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("items.jsp?error=Failed to delete item");
            return;
        }

        response.sendRedirect("items.jsp?success=Item removed successfully");
    }
}
