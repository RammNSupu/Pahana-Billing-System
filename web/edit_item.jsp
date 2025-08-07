<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String itemCode = request.getParameter("code");
    String itemName = "";
    String category = "";
    double price = 0;
    int stock = 0;
    String description = "";

    try (Connection conn = com.pahana.util.DBUtil.getConnection()) {
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM items WHERE item_code = ?");
        stmt.setString(1, itemCode);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            itemName = rs.getString("item_name");
            category = rs.getString("category");
            price = rs.getDouble("price");
            stock = rs.getInt("stock");
            description = rs.getString("description");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Item</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <style>
    body {
      background-color: rgba(62, 85, 212, 0.07);
      font-family: 'Segoe UI', sans-serif;
    }

    .main-content {
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
    }

    .form-card {
      width: 500px;
      background-color: white;
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 6px 8px rgba(0, 0, 0, 0.2);
    }

    .btn-save {
      background-color: #3e55d4;
      color: white;
    }

    .btn-cancel {
      background-color: #ccc;
      color: black;
    }

    .form-label.required::after {
      content: " *";
      color: red;
    }

    .btn-save:hover {
      background-color: #3244b4;
    }
  </style>
</head>
<body>

<div class="main-content">
  <div class="form-card">
    <h4>Edit Item</h4>
    <form action="updateItem" method="post">
      <input type="hidden" name="item_code" value="<%= itemCode %>">

      <div class="mb-3">
        <label class="form-label required">Item Name</label>
        <input type="text" class="form-control" name="item_name" value="<%= itemName %>" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Category</label>
        <select class="form-select" name="category">
          <option value="">-- Select Category --</option>
          <option value="Novel" <%= category.equals("Novel") ? "selected" : "" %>>Novel</option>
          <option value="Stationery" <%= category.equals("Stationery") ? "selected" : "" %>>Stationery</option>
          <option value="Educational" <%= category.equals("Educational") ? "selected" : "" %>>Educational</option>
          <option value="Magazine" <%= category.equals("Magazine") ? "selected" : "" %>>Magazine</option>
          <option value="Children" <%= category.equals("Children") ? "selected" : "" %>>Children</option>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label required">Price</label>
        <input type="number" step="0.01" class="form-control" name="price" value="<%= price %>" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Stock</label>
        <input type="number" class="form-control" name="stock" value="<%= stock %>">
      </div>

      <div class="mb-4">
        <label class="form-label">Description</label>
        <textarea class="form-control" name="description" rows="3"><%= description %></textarea>
      </div>

      <div class="d-flex justify-content-between">
        <button type="submit" class="btn btn-save">Update</button>
        <a href="items.jsp" class="btn btn-cancel">Cancel</a>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
