<%@ page import="java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet" %>
<%@ page import="com.pahana.util.DBUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>





<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Pahana Edu Dashboard</title>

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
      color: white;
    }

    .dashboard-header {
      background-color: white;
      padding: 20px;
      border-radius: 12px;
      color: black;
      font-weight: 600;
      margin-bottom: 30px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .card-box {
      border-radius: 12px;
      padding: 20px;
      color: white;
      font-weight: 600;
    }

    .icon-blue { background-color: rgba(62, 85, 212, 0.80); }
    .icon-pink { background-color: #c832c4; }
    .icon-red { background-color: #dc3545; }
    .icon-green { background-color: #28a745; }

    .card-shadow {
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
      padding: 20px;
      color: black;
    }

    .quick-action button {
      width: 100%;
      height: 60px;
      font-weight: 600;
      border-radius: 8px;
      color: white;
      border: none;
    }

    .btn-customer {
      background-color: #3e55d4;
    }

    .btn-item {
      background-color: #28a745;
    }

    .btn-bill {
      background: linear-gradient(to right, #f12f2f, #ec1e79);
    }

    .badge-notify {
      position: absolute;
      top: 0;
      right: -5px;
      font-size: 12px;
    }
    
    .sidebar .nav-link:hover {
  background-color: #3e55d4;
  color: white !important;
  transition: 0.3s;
}

.quick-action .btn:hover {
  filter: brightness(1.1);
  transform: scale(1.03);
  transition: 0.3s ease;
}

  </style>
</head>
<body>

    <%
    String successMsg = request.getParameter("success");
    if (successMsg != null && !successMsg.isEmpty()) {
    %>
        <div class="alert alert-success alert-dismissible fade show" role="alert" style="margin: 100px 30px 0 270px;">
            <%= successMsg %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
        }
    %>

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
      <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary btn-sm">Logout</a>

    </div>
  </div>

  <!-- Sidebar -->
  <div class="sidebar">
    <div class="text-center">
      <div class="quick-stats-btn">Quick Stats<br><small>Today's Overview</small></div>
    </div>
    <nav class="nav flex-column">
  <a class="nav-link active" href="dashboard.jsp"><i class="bi bi-house-door-fill"></i> Dashboard</a>
  <a class="nav-link" href="customers.jsp"><i class="bi bi-people-fill"></i> Customers</a>
  <a class="nav-link" href="items.jsp"><i class="bi bi-box-fill"></i> Items</a>
  <a class="nav-link" href="billing.jsp"><i class="bi bi-receipt"></i> Billing</a>
  <a class="nav-link" href="help.jsp"><i class="bi bi-question-circle-fill"></i> Help</a>
</nav>

  </div>

  <!-- Main Content -->
  <div class="main-content">
    <div class="dashboard-header d-flex justify-content-between align-items-center">
      <div>
        <h4>Dashboard</h4>
        <p class="text-muted mb-0">Welcome to the Pahana Edu Management System</p>
      </div>
      <div>
    <i class="bi bi-calendar-event"></i> 
    <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %>
  </div>
    </div>

    <div class="row g-4">
      <div class="col-md-3">
        <div class="card-box icon-blue d-flex justify-content-between align-items-center">
          <div>Total Customers<br><span class="fs-4">750</span></div>
          <i class="bi bi-person-fill fs-2"></i>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card-box icon-pink d-flex justify-content-between align-items-center">
          <div>Total Items<br><span class="fs-4">1170</span></div>
          <i class="bi bi-box fs-2"></i>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card-box icon-red d-flex justify-content-between align-items-center">
          <div>Total Revenue<br><span class="fs-4">1170</span></div>
          <i class="bi bi-currency-dollar fs-2"></i>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card-box icon-green d-flex justify-content-between align-items-center">
          <div>Recent Bills<br><span class="fs-4">17</span></div>
          <i class="bi bi-receipt fs-2"></i>
        </div>
      </div>
    </div>

    <div class="row g-4 mt-4">
      <div class="col-md-6">
        <div class="card-shadow">
          <h6>Recent Customers</h6>
          <table class="table table-bordered mt-2">
            <thead>
              <tr><th>Name</th><th>Email</th><th>Date</th></tr>
            </thead>
            <tbody>
<%
    try (Connection conn = com.pahana.util.DBUtil.getConnection()) {
        String sql = "SELECT name, email, created_at FROM customers ORDER BY created_at DESC LIMIT 6";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        boolean hasData = false;
        while (rs.next()) {
            hasData = true;
%>
            <tr>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy")
                        .format(rs.getTimestamp("created_at")) %></td>
            </tr>
<%
        }
        if (!hasData) {
%>
            <tr><td colspan="3" class="text-center">No recent customers</td></tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <tr><td colspan="3" class="text-danger text-center">Error loading customers</td></tr>
<%
    }
%>
</tbody>

          </table>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card-shadow">
          <h6>Low Stock Alert</h6>
          <p class="mt-3">All items are well stocked!</p>
        </div>
      </div>
    </div>

    <div class="card-shadow mt-4">
      <h6 class="mb-3">Quick Actions</h6>
      <div class="row g-3 quick-action">
  <div class="col-md-4">
    <a href="add_customer.jsp" class="btn btn-customer d-block text-center">
      <i class="bi bi-person-plus me-2"></i>Add New Customer
    </a>
  </div>
  <div class="col-md-4">
    <a href="addItem.jsp" class="btn btn-item d-block text-center">
      <i class="bi bi-box-seam me-2"></i>Add New Item
    </a>
  </div>
  <div class="col-md-4">
    <a href="generateBill.jsp" class="btn btn-bill d-block text-center">
      <i class="bi bi-file-earmark-plus me-2"></i>Generate Bill
    </a>
  </div>
</div>

    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  
  
  
  <script>
  // Auto-dismiss success alert after 3 seconds
  setTimeout(function () {
    var alert = document.querySelector('.alert-success');
    if (alert) {
      alert.style.display = 'none';
    }
  }, 5000); // 3000 ms = 3 seconds
</script>

  
</body>
</html>
