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

            // Calculate subtotal
            BigDecimal subtotal = BigDecimal.ZERO;
            if (totalPrices != null) {
                for (String tp : totalPrices) {
                    subtotal = subtotal.add(safeBigDecimal(tp));
                }
            }

            BigDecimal discount = BigDecimal.ZERO;
            BigDecimal total = subtotal.subtract(discount);

            // Insert into bills
            String sqlBill = "INSERT INTO bills (customer_id, bill_date, subtotal, discount, total) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psBill = conn.prepareStatement(sqlBill, Statement.RETURN_GENERATED_KEYS);

            Integer custId = safeParseInt(customerIdStr);
            if (custId == null) {
                psBill.setNull(1, Types.INTEGER);
            } else {
                psBill.setInt(1, custId);
            }

            Timestamp billTimestamp = null;
            if (billDateStr != null && !billDateStr.trim().isEmpty()) {
                // Handle both "2025-08-17T12:36" and "2025-08-17 12:36:00"
                if (billDateStr.contains("T")) {
                    billDateStr = billDateStr.replace("T", " ") + ":00";
                }
                billTimestamp = Timestamp.valueOf(billDateStr);
            }
            psBill.setTimestamp(2, billTimestamp);

            psBill.setBigDecimal(3, subtotal);
            psBill.setBigDecimal(4, discount);
            psBill.setBigDecimal(5, total);
            psBill.executeUpdate();

            // Get generated bill_id
            ResultSet rs = psBill.getGeneratedKeys();
            int billId = 0;
            if (rs.next()) billId = rs.getInt(1);

            // Insert items
            String sqlItem = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psItem = conn.prepareStatement(sqlItem);

            for (int i = 0; i < itemIds.length; i++) {
                Integer itemId = safeParseInt(itemIds[i]);
                Integer qty = safeParseInt(quantities[i]);
                BigDecimal unitPrice = safeBigDecimal(unitPrices[i]);
                BigDecimal totalPrice = safeBigDecimal(totalPrices[i]);

                if (itemId == null || qty == null) continue;

                psItem.setInt(1, billId);
                psItem.setInt(2, itemId);
                psItem.setInt(3, qty);
                psItem.setBigDecimal(4, unitPrice);
                psItem.setBigDecimal(5, totalPrice);
                psItem.executeUpdate();
            }

            conn.commit();
            response.getWriter().write("Bill saved successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            response.getWriter().write("Error saving bill: " + e.getMessage());
        }
    }
}
