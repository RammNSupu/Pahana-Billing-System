package com.pahana.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

import com.pahana.util.DBUtil;

@WebServlet("/saveBill")
public class SaveBillServlet extends HttpServlet {

    private int safeParseInt(String val) {
        try {
            if (val == null || val.trim().isEmpty()) return 0;
            return Integer.parseInt(val.trim());
        } catch (Exception e) {
            return 0;
        }
    }

    private double safeParseDouble(String val) {
        try {
            if (val == null || val.trim().isEmpty()) return 0.0;
            return Double.parseDouble(val.trim());
        } catch (Exception e) {
            return 0.0;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdStr = request.getParameter("customer_id");
        String[] itemIds = request.getParameterValues("item_id");
        String[] quantities = request.getParameterValues("quantity");
        String[] unitPrices = request.getParameterValues("unit_price");
        String[] totalPrices = request.getParameterValues("total_price");

        if (itemIds == null || itemIds.length == 0) {
            throw new ServletException("No items provided for bill");
        }

        // Use totalAmount as both subtotal and total, discount = 0
        String totalStr = request.getParameter("totalAmount");
        double total = safeParseDouble(totalStr);
        double subtotal = total;
        double discount = 0.0;

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            // Insert into bills
            String billSql = "INSERT INTO bills (customer_id, bill_date, subtotal, discount, total) VALUES (?, NOW(), ?, ?, ?)";
            PreparedStatement billStmt = conn.prepareStatement(billSql, Statement.RETURN_GENERATED_KEYS);
            billStmt.setInt(1, safeParseInt(customerIdStr));
            billStmt.setDouble(2, subtotal);
            billStmt.setDouble(3, discount);
            billStmt.setDouble(4, total);
            billStmt.executeUpdate();

            ResultSet rs = billStmt.getGeneratedKeys();
            int billId = 0;
            if (rs.next()) {
                billId = rs.getInt(1);
            }

            // Insert bill items
            String itemSql = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement itemStmt = conn.prepareStatement(itemSql);

            for (int i = 0; i < itemIds.length; i++) {
                itemStmt.setInt(1, billId);
                itemStmt.setInt(2, safeParseInt(itemIds[i]));
                itemStmt.setInt(3, safeParseInt(quantities[i]));
                itemStmt.setDouble(4, safeParseDouble(unitPrices[i]));
                itemStmt.setDouble(5, safeParseDouble(totalPrices[i]));
                itemStmt.addBatch();
            }
            itemStmt.executeBatch();

            conn.commit();
            response.sendRedirect("billing.jsp?success=Bill saved successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error saving bill: " + e.getMessage());
        }
    }
}
