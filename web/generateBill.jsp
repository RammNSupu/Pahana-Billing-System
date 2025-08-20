<%@ page import="java.util.*,java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");

    String billDate = request.getParameter("bill_date");
    String customerId = request.getParameter("customer_id");
    String totalAmount = request.getParameter("totalAmount");

    String[] itemIds   = request.getParameterValues("item_id");
    String[] itemNames = request.getParameterValues("item_name");
    String[] qtys      = request.getParameterValues("quantity");
    String[] prices    = request.getParameterValues("unit_price");
    String[] totals    = request.getParameterValues("total_price");

    if (itemIds == null || itemIds.length == 0) {
        throw new javax.servlet.ServletException("No items provided for bill");
    }

    // Fetch customer name
    String customerName = "";
    try (Connection conn = com.pahana.util.DBUtil.getConnection()) {
        PreparedStatement ps = conn.prepareStatement("SELECT name FROM customers WHERE id=?");
        ps.setString(1, customerId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) customerName = rs.getString("name");
    } catch (Exception e) { e.printStackTrace(); }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Generate Bill</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background:#f7f7f7;">
<div class="container mt-5 p-4 bg-white rounded shadow">
    <h3 class="text-center mb-4">Pahana Edu - Customer Bill</h3>

    <p><strong>Date:</strong> <%= billDate %></p>
    <p><strong>Customer:</strong> <%= customerName %> (ID: <%= customerId %>)</p>

    <table class="table table-bordered">
        <thead class="table-light">
        <tr>
            <th>Item</th>
            <th>Qty</th>
            <th>Unit Price</th>
            <th>Total</th>
        </tr>
        </thead>
        <tbody>
        <% for (int i = 0; i < itemIds.length; i++) { %>
            <tr>
                <td><%= itemNames[i] %></td>
                <td><%= qtys[i] %></td>
                <td><%= prices[i] %></td>
                <td><%= totals[i] %></td>
            </tr>
        <% } %>
        </tbody>
    </table>

    <h5 class="text-end">Total: Rs. <%= totalAmount %></h5>

    <form action="saveBill" method="post">
        <input type="hidden" name="bill_date" value="<%= billDate %>">
        <input type="hidden" name="customer_id" value="<%= customerId %>">
        <input type="hidden" name="totalAmount" value="<%= totalAmount %>">

        <% for (int i = 0; i < itemIds.length; i++) { %>
            <input type="hidden" name="item_id" value="<%= itemIds[i] %>">
            <input type="hidden" name="item_name" value="<%= itemNames[i] %>">
            <input type="hidden" name="quantity" value="<%= qtys[i] %>">
            <input type="hidden" name="unit_price" value="<%= prices[i] %>">
            <input type="hidden" name="total_price" value="<%= totals[i] %>">
        <% } %>

        <button type="submit" class="btn btn-success">Save Bill</button>
        <a href="billing.jsp" class="btn btn-secondary">Back</a>
    </form>
</div>
</body>
</html>
