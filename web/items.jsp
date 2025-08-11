<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Get search keyword from request
    String keyword = request.getParameter("search") != null ? request.getParameter("search").trim() : "";

    List<Map<String, String>> items = new ArrayList<>();
    try (Connection conn = com.pahana.util.DBUtil.getConnection()) {
        String sql = "SELECT * FROM items";
        
        // If keyword is not empty, add WHERE conditions
        if (!keyword.isEmpty()) {
            sql += " WHERE item_code LIKE ? OR item_name LIKE ? OR category LIKE ? OR description LIKE ?";
        }

        PreparedStatement stmt = conn.prepareStatement(sql);

        if (!keyword.isEmpty()) {
            String like = "%" + keyword + "%";
            stmt.setString(1, like);
            stmt.setString(2, like);
            stmt.setString(3, like);
            stmt.setString(4, like);
        }

        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Map<String, String> item = new HashMap<>();
            item.put("item_code", rs.getString("item_code"));
            item.put("item_name", rs.getString("item_name"));
            item.put("category", rs.getString("category"));
            item.put("price", rs.getString("price"));
            item.put("stock", rs.getString("stock"));
            items.add(item);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Item Management - Pahana Edu</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>

  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: rgba(62, 85, 212, 0.07);
    }
    .sidebar {
      position: fixed;
      top: 70px;
      left: 0;
      height: calc(100vh - 70px);
      width: 240px;
      background-color: #fff;
      padding: 20px 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .quick-stats-btn {
      background: linear-gradient(to right, #A626C6, #F74040);
      color: white;
      border-radius: 20px;
      padding: 15px 20px;
      width: 100%;
      text-align: center;
      font-weight: 600;
      margin-bottom: 25px;
    }
    .sidebar .nav-link {
      color: black;
      font-weight: 500;
      padding: 10px 15px;
      margin-bottom: 10px;
      display: flex;
      align-items: center;
      gap: 10px;
      border-radius: 10px;
    }
    .sidebar .nav-link.active {
      background-color: #3e55d4;
      color: white !important;
    }
    .topbar {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 70px;
      background-color: #fff;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 30px;
      border-bottom: 1px solid #eee;
      z-index: 1000;
    }
    .brand-area {
      display: flex;
      align-items: center;
      gap: 15px;
    }
    .brand-area img {
      width: 40px;
    }
    .brand-text h5 {
      margin: 0;
      font-weight: bold;
      color: #3e55d4;
    }
    .brand-text small {
      font-size: 12px;
      color: #666;
    }
    .user-info {
      display: flex;
      align-items: center;
      gap: 15px;
    }
    .main-content {
      margin-left: 240px;
      margin-top: 70px;
      padding: 30px;
      color: black;
    }
    .dashboard-header {
      background-color: white;
      padding: 20px;
      border-radius: 12px;
      font-weight: 600;
      margin-bottom: 30px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    .card-shadow {
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
      padding: 20px;
      color: black;
    }
    .btn-success, .btn-danger {
      font-size: 0.75rem;
      padding: 4px 12px;
    }
    .sidebar .nav-link:hover {
      background-color: #3e55d4;
      color: white !important;
      transition: 0.3s;
    }
    .input-group input {
      height: 42px;
    }
  </style>
</head>
<body>

  <!-- Topbar -->
  <div class="topbar">
    <div class="brand-area">
      <img src="Group 12.png" alt="logo">
      <div class="brand-text">
        <h5>Pahana Edu</h5>
        <small>Bookshop Management System</small>
      </div>
    </div>
    <div class="user-info">
      <div class="text-end">
        <span class="fw-bold">Welcome, Perera</span><br>
        <small class="text-muted">Admin</small>
      </div>
      <div class="position-relative">
        <i class="bi bi-bell-fill text-danger fs-5"></i>
        <span class="badge bg-danger rounded-pill badge-notify">3</span>
      </div>
      <button class="btn btn-primary btn-sm">Logout</button>
    </div>
  </div>

  <!-- Sidebar -->
  <div class="sidebar">
    <div class="text-center">
      <div class="quick-stats-btn">Quick Stats<br><small>Today's Overview</small></div>
    </div>
    <nav class="nav flex-column">
      <a class="nav-link" href="dashboard.jsp"><i class="bi bi-house-door-fill"></i> Dashboard</a>
      <a class="nav-link" href="customers.jsp"><i class="bi bi-people-fill"></i> Customers</a>
      <a class="nav-link active" href="items.jsp"><i class="bi bi-box-fill"></i> Items</a>
      <a class="nav-link" href="billing.jsp"><i class="bi bi-receipt"></i> Billing</a>
      <a class="nav-link" href="help.jsp"><i class="bi bi-question-circle-fill"></i> Help</a>
    </nav>
  </div>

  <!-- Main Content -->
  <div class="main-content">
    <div class="dashboard-header d-flex justify-content-between align-items-center">
      <div>
        <h4>Item Management</h4>
        <p class="text-muted mb-0">Manage Items here</p>
      </div>
      <a href="add_item.jsp" class="btn btn-primary">+ Add Item</a>
    </div>

    <!-- Search Form -->
    <form method="get" class="input-group mt-4 mb-3">
      <span class="input-group-text"><i class="bi bi-search"></i></span>
      <input type="text" class="form-control" placeholder="Search item by code, name, category, or description" name="search" value="<%= keyword %>">
      <button type="submit" class="btn btn-outline-primary">Search</button>
    </form>

    <div class="card-shadow">
      <h6>Item list (<%= items.size() %>)</h6>
      <table class="table table-bordered mt-2">
        <thead>
          <tr>
            <th>Item Code</th>
            <th>Item Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Stock</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
        <% if (items.isEmpty()) { %>
          <tr><td colspan="6" class="text-center">No items found</td></tr>
        <% } else {
          for (Map<String, String> item : items) { %>
            <tr>
              <td><%= item.get("item_code") %></td>
              <td><%= item.get("item_name") %></td>
              <td><%= item.get("category") %></td>
              <td>Rs. <%= item.get("price") %></td>
              <td><%= item.get("stock") %></td>
              <td>
                <a href="edit_item.jsp?code=<%= item.get("item_code") %>" class="btn btn-success btn-sm">Update</a>
                <a href="deleteItem?code=<%= item.get("item_code") %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to remove this item?')">Remove</a>
              </td>
            </tr>
        <%  }} %>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
