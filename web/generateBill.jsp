<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Preview Bill - Pahana Edu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <style>
    body{background:#f7f7ff; font-family:'Segoe UI',sans-serif;}
    .wrapper{max-width:1100px; margin:40px auto; background:#fff; padding:30px; border-radius:12px; box-shadow:0 6px 12px rgba(0,0,0,.1);}
  </style>
</head>
<body>
<%
  String billDate = request.getParameter("bill_date");
  String customerId = request.getParameter("customer_id");
  String totalAmount = request.getParameter("totalAmount");

  String[] itemIds = request.getParameterValues("item_id");
  String[] itemNames = request.getParameterValues("item_name");
  String[] quantities = request.getParameterValues("quantity");
  String[] unitPrices = request.getParameterValues("unit_price");
  String[] totals = request.getParameterValues("total_price");

  if (itemIds == null) { itemIds = new String[0]; }
%>

<div class="wrapper">
  <h3 class="text-center mb-4">Pahana Edu - Customer Bill</h3>

  <div class="mb-3"><strong>Date:</strong> <%= billDate %></div>
  <div class="mb-4"><strong>Customer ID:</strong> <%= customerId %></div>

  <table class="table table-bordered">
    <thead>
      <tr>
        <th>Item</th>
        <th>Qty</th>
        <th>Unit Price</th>
        <th>Total</th>
      </tr>
    </thead>
    <tbody>
    <%
      double gTotal = 0.0;
      for (int i=0; i<itemIds.length; i++){
        String iname = itemNames[i];
        String q = quantities[i];
        String up = unitPrices[i];
        String tp = totals[i];
        try { gTotal += Double.parseDouble(tp); } catch(Exception ignore){}
    %>
      <tr>
        <td><%= iname %></td>
        <td><%= q %></td>
        <td><%= up %></td>
        <td><%= tp %></td>
      </tr>
    <% } %>
    </tbody>
  </table>

  <div class="d-flex justify-content-end">
    <h5>Total: Rs. <%= String.format(java.util.Locale.US,"%.2f", gTotal) %></h5>
  </div>

  <!-- Save Bill form: carry everything forward -->
  <form action="saveBill" method="post" class="mt-4">
    <input type="hidden" name="bill_date" value="<%= billDate %>">
    <input type="hidden" name="customer_id" value="<%= customerId %>">
    <input type="hidden" name="totalAmount" value="<%= String.format(java.util.Locale.US,"%.2f", gTotal) %>">

    <% for (int i=0; i<itemIds.length; i++) { %>
      <input type="hidden" name="item_id" value="<%= itemIds[i] %>">
      <input type="hidden" name="quantity" value="<%= quantities[i] %>">
      <input type="hidden" name="unit_price" value="<%= unitPrices[i] %>">
      <input type="hidden" name="total_price" value="<%= totals[i] %>">
    <% } %>

    <button type="submit" class="btn btn-success">Save Bill</button>
    <button type="button" class="btn btn-secondary" onclick="history.back()">Back</button>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
