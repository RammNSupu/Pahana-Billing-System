<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Load customers and items from DB
    List<Map<String, String>> customers = new ArrayList<>();
    List<Map<String, String>> items = new ArrayList<>();

    try (Connection conn = com.pahana.util.DBUtil.getConnection()) {
        PreparedStatement custStmt = conn.prepareStatement("SELECT id, name FROM customers");
        ResultSet custRs = custStmt.executeQuery();
        while (custRs.next()) {
            Map<String, String> c = new HashMap<>();
            c.put("id", custRs.getString("id"));
            c.put("name", custRs.getString("name"));
            customers.add(c);
        }

        PreparedStatement itemStmt = conn.prepareStatement("SELECT item_code, item_name, price FROM items");
        ResultSet itemRs = itemStmt.executeQuery();
        while (itemRs.next()) {
            Map<String, String> i = new HashMap<>();
            i.put("code", itemRs.getString("item_code"));
            i.put("name", itemRs.getString("item_name"));
            i.put("price", itemRs.getString("price"));
            items.add(i);
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
  <title>Billing - Pahana Edu</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>

  <style>
    body { margin:0; font-family:'Segoe UI', sans-serif; background-color:rgba(62, 85, 212, 0.07); }
    .sidebar { position:fixed; top:70px; left:0; height:calc(100vh - 70px); width:240px; background-color:#fff; padding:20px 10px; box-shadow:0 0 10px rgba(0,0,0,0.1);}
    .quick-stats-btn { background:linear-gradient(to right,#A626C6,#F74040); color:white; border-radius:20px; padding:15px 20px; width:100%; text-align:center; font-weight:600; margin-bottom:25px;}
    .sidebar .nav-link { color:black; font-weight:500; padding:10px 15px; margin-bottom:10px; display:flex; align-items:center; gap:10px; border-radius:10px;}
    .sidebar .nav-link.active { background-color:#3e55d4; color:white !important;}
    .topbar { position:fixed; top:0; left:0; width:100%; height:70px; background-color:#fff; display:flex; align-items:center; justify-content:space-between; padding:0 30px; border-bottom:1px solid #eee; z-index:1000;}
    .brand-area { display:flex; align-items:center; gap:15px;}
    .brand-area img { width:40px;}
    .brand-text h5 { margin:0; font-weight:bold; color:#3e55d4;}
    .brand-text small { font-size:12px; color:#666;}
    .user-info { display:flex; align-items:center; gap:15px;}
    .main-content { margin-left:240px; margin-top:70px; padding:30px; color:black;}
    .dashboard-header { background-color:white; padding:20px; border-radius:12px; font-weight:600; margin-bottom:30px; box-shadow:0 4px 8px rgba(0,0,0,0.1);}
    .card-shadow { background-color:white; border-radius:12px; box-shadow:0 6px 8px rgba(0,0,0,0.15); padding:20px; color:black;}
    .sidebar .nav-link:hover { background-color:#3e55d4; color:white !important; transition:0.3s;}
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
      <a class="nav-link" href="items.jsp"><i class="bi bi-box-fill"></i> Items</a>
      <a class="nav-link active" href="billing.jsp"><i class="bi bi-receipt"></i> Billing</a>
      <a class="nav-link" href="help.jsp"><i class="bi bi-question-circle-fill"></i> Help</a>
    </nav>
  </div>

  <!-- Main Content -->
  <div class="main-content">
    <div class="dashboard-header">
      <h4>Generate Bill</h4>
      <p class="text-muted mb-0">Create a new bill for a customer</p>
    </div>

    <div class="card-shadow">
      <form id="billForm" action="generateBillServlet" method="post">
        
        <!-- Customer Selection -->
        <div class="mb-3">
          <label class="form-label">Customer</label>
          <select class="form-select" name="customer_id" required>
            <option value="">Select Customer</option>
            <% for (Map<String,String> c : customers) { %>
              <option value="<%= c.get("id") %>"><%= c.get("name") %></option>
            <% } %>
          </select>
        </div>

        <!-- Item Selection -->
        <div class="row g-3 align-items-end">
          <div class="col-md-5">
            <label class="form-label">Item</label>
            <select class="form-select" id="itemSelect">
              <option value="">Select Item</option>
              <% for (Map<String,String> i : items) { %>
                <option value="<%= i.get("code") %>" data-price="<%= i.get("price") %>">
                  <%= i.get("name") %> - Rs.<%= i.get("price") %>
                </option>
              <% } %>
            </select>
          </div>
          <div class="col-md-3">
            <label class="form-label">Quantity</label>
            <input type="number" id="quantity" class="form-control" min="1" value="1">
          </div>
          <div class="col-md-2">
            <button type="button" class="btn btn-success w-100" id="addItemBtn"><i class="bi bi-plus-circle"></i> Add</button>
          </div>
        </div>

        <!-- Bill Items Table -->
        <div class="mt-4">
          <table class="table table-bordered" id="billTable">
            <thead>
              <tr>
                <th>Item</th>
                <th>Qty</th>
                <th>Price</th>
                <th>Total</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody></tbody>
          </table>
        </div>

        <!-- Total -->
        <div class="text-end mt-3">
          <h5>Total: Rs. <span id="totalAmount">0.00</span></h5>
        </div>

        <!-- Payment -->
        <div class="mb-3 mt-3">
          <label class="form-label">Payment Method</label>
          <select class="form-select" name="payment_method" required>
            <option value="">Select Payment Method</option>
            <option value="Cash">Cash</option>
            <option value="Card">Card</option>
          </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Generate Bill</button>
      </form>
    </div>
  </div>

  <!-- JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    let totalAmount = 0;
    document.getElementById('addItemBtn').addEventListener('click', function(){
      const itemSelect = document.getElementById('itemSelect');
      const qty = parseInt(document.getElementById('quantity').value);
      if(!itemSelect.value || qty <= 0) return;
      const price = parseFloat(itemSelect.selectedOptions[0].getAttribute('data-price'));
      const name = itemSelect.selectedOptions[0].text.split(' - ')[0];
      const total = price * qty;

      const row = `<tr>
        <td>${name}</td>
        <td>${qty}</td>
        <td>${price.toFixed(2)}</td>
        <td>${total.toFixed(2)}</td>
        <td><button type="button" class="btn btn-danger btn-sm removeItem">Remove</button></td>
      </tr>`;
      document.querySelector('#billTable tbody').insertAdjacentHTML('beforeend', row);
      totalAmount += total;
      document.getElementById('totalAmount').textContent = totalAmount.toFixed(2);
    });

    document.querySelector('#billTable').addEventListener('click', function(e){
      if(e.target.classList.contains('removeItem')){
        const row = e.target.closest('tr');
        const total = parseFloat(row.cells[3].textContent);
        totalAmount -= total;
        document.getElementById('totalAmount').textContent = totalAmount.toFixed(2);
        row.remove();
      }
    });
  </script>
</body>
</html>
