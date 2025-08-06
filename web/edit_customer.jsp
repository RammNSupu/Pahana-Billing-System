<%@page import="java.sql.*, java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String acc = request.getParameter("acc");
    Map<String, String> customer = new HashMap<>();

    try (Connection conn = com.pahana.util.DBUtil.getConnection()) {
        String query = "SELECT * FROM customers WHERE account_number = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, acc);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            customer.put("account_number", rs.getString("account_number"));
            customer.put("name", rs.getString("name"));
            customer.put("address", rs.getString("address"));
            customer.put("phone", rs.getString("phone"));
            customer.put("email", rs.getString("email"));
        } else {
            response.sendRedirect("customers.jsp"); // if not found, go back
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Customer</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
        background-color: #4d65e6;
        font-family: 'Segoe UI', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
    }
    .form-container {
        background-color: white;
        padding: 40px;
        border-radius: 20px;
        box-shadow: 6px 6px 0 rgba(0, 0, 0, 0.25);
        width: 100%;
        max-width: 500px;
    }
    h4 {
        font-weight: bold;
        margin-bottom: 20px;
    }
    .btn-save {
        background-color: #3e55d4;
        color: white;
        width: 100px;
    }
    .btn-cancel {
        background-color: #d1d1d1;
        color: black;
        width: 100px;
    }
  </style>
</head>
<body>

<div class="form-container">
  <h4>Edit Customer</h4>
  <hr>
  <form action="updateCustomer" method="post">
    <input type="hidden" name="originalAcc" value="<%= customer.get("account_number") %>">

    <div class="mb-3">
      <label for="accountNumber" class="form-label">Account Number</label>
      <input type="text" class="form-control" name="accountNumber" id="accountNumber" value="<%= customer.get("account_number") %>" required>
    </div>
    <div class="mb-3">
      <label for="name" class="form-label">Name</label>
      <input type="text" class="form-control" name="name" id="name" value="<%= customer.get("name") %>" required>
    </div>
    <div class="mb-3">
      <label for="address" class="form-label">Address</label>
      <input type="text" class="form-control" name="address" id="address" value="<%= customer.get("address") %>">
    </div>
    <div class="mb-3">
      <label for="phone" class="form-label">Phone</label>
      <input type="text" class="form-control" name="phone" id="phone" value="<%= customer.get("phone") %>" required>
    </div>
    <div class="mb-3">
      <label for="email" class="form-label">Email</label>
      <input type="email" class="form-control" name="email" id="email" value="<%= customer.get("email") %>">
    </div>

    <div class="d-flex justify-content-between mt-4">
      <button type="submit" class="btn btn-save">Update</button>
      <a href="customers.jsp" class="btn btn-cancel">Cancel</a>
    </div>
  </form>
</div>

</body>
</html>
