package com.pahana.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.pahana.util.DBUtil;

@WebServlet("/saveBill")
public class SaveBillServlet extends HttpServlet {

    private BigDecimal safeBigDecimal(String val) {
        if (val == null || val.trim().isEmpty()) return BigDecimal.ZERO;
        return new BigDecimal(val.trim());
    }

    private Integer safeParseInt(String val) {
        if (val == null || val.trim().isEmpty()) return null;
        return Integer.parseInt(val.trim());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String billDateStr = request.getParameter("bill_date"); 
        String customerIdStr = request.getParameter("customer_id");

        String[] itemIds = request.getParameterValues("item_id[]");
        String[] quantities = request.getParameterValues("quantity[]");
        String[] unitPrices = request.getParameterValues("unit_price[]");
        String[] totalPrices = request.getParameterValues("total_price[]");

        if (itemIds == null || itemIds.length == 0) {
            response.setStatus(400);
            response.getWriter().write("No items added to the bill");
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            BigDecimal subtotal = BigDecimal.ZERO;
            if (totalPrices != null) {
                for (String tp : totalPrices) {
                    subtotal = subtotal.add(safeBigDecimal(tp));
                }
            }
            BigDecimal total = subtotal;

            int billId = -1;
            String insertBill = "INSERT INTO bills (customer_id, bill_date, subtotal, total) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertBill, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, safeParseInt(customerIdStr));
                ps.setString(2, billDateStr);
                ps.setBigDecimal(3, subtotal);
                ps.setBigDecimal(4, total);
                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        billId = rs.getInt(1);
                    }
                }
            }

            String insertItem = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, total_price) VALUES (?,?,?,?,?)";
            try (PreparedStatement ps = conn.prepareStatement(insertItem)) {
                for (int i = 0; i < itemIds.length; i++) {
                    ps.setInt(1, billId);
                    ps.setInt(2, safeParseInt(itemIds[i]));
                    ps.setInt(3, safeParseInt(quantities[i]));
                    ps.setBigDecimal(4, safeBigDecimal(unitPrices[i]));
                    ps.setBigDecimal(5, safeBigDecimal(totalPrices[i]));
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            conn.commit();
            response.sendRedirect("billing.jsp?success=Bill saved successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error saving bill: " + e.getMessage());
        }
    }
}
