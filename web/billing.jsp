<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Fetch customers
    List<Map<String, String>> customers = new ArrayList<>();
    try (Connection conn = com.pahana.util.DBUtil.getConnection()) {
        PreparedStatement stmt = conn.prepareStatement("SELECT id, name FROM customers");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Map<String, String> c = new HashMap<>();
            c.put("id", rs.getString("id"));
            c.put("name", rs.getString("name"));
            customers.add(c);
        }
    } catch (Exception e) { e.printStackTrace(); }

    // Fetch items
    List<Map<String, String>> items = new ArrayList<>();
    try (Connection conn = com.pahana.util.DBUtil.getConnection()) {
        PreparedStatement stmt = conn.prepareStatement("SELECT id, item_name, price FROM items");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Map<String, String> i = new HashMap<>();
            i.put("id", rs.getString("id"));
            i.put("name", rs.getString("item_name"));
            i.put("price", rs.getString("price"));
            items.add(i);
        }
    } catch (Exception e) { e.printStackTrace(); }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Billing - Pahana Edu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
  <style>
    body { margin:0; font-family:'Segoe UI',sans-serif; background-color:rgba(62,85,212,0.07);}
    .sidebar { position:fixed; top:70px; left:0; height:calc(100vh - 70px); width:240px; background:#fff; padding:20px 10px; box-shadow:0 0 10px rgba(0,0,0,0.1);}
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
    <h4>Create New Bill</h4>
    <p class="text-muted mb-0">Add items and generate customer bill</p>
  </div>

  <!-- Bill Header -->
  <div class="card-shadow mb-4">
    <form id="billingForm" action="saveBill" method="post">
      <div class="row mb-3">
        <div class="col-md-4">
          <label class="form-label">Bill Date</label>
          <input type="date" name="bill_date" class="form-control" value="<%= java.time.LocalDate.now() %>">
        </div>
        <div class="col-md-4">
          <label class="form-label">Select Customer</label>
          <select name="customer_id" class="form-select" required>
            <option value="">-- Select Customer --</option>
            <% for (Map<String, String> c : customers) { %>
              <option value="<%= c.get("id") %>"><%= c.get("name") %></option>
            <% } %>
          </select>
        </div>
      </div>

      <!-- Add Items Section -->
      <div class="row g-3 align-items-end">
        <div class="col-md-5">
          <label class="form-label">Item</label>
          <select id="itemSelect" class="form-select">
            <option value="">-- Select Item --</option>
            <% for (Map<String, String> i : items) { %>
              <option value="<%= i.get("id") %>" data-price="<%= i.get("price") %>"><%= i.get("name") %></option>
            <% } %>
          </select>
        </div>
        <div class="col-md-2">
          <label class="form-label">Quantity</label>
          <input type="number" id="quantity" class="form-control" min="1" value="1">
        </div>
        <div class="col-md-2">
          <label class="form-label">Unit Price</label>
          <input type="text" id="unitPrice" class="form-control" readonly>
        </div>
        <div class="col-md-2">
          <button type="button" class="btn btn-primary" onclick="addItem()">Add</button>
        </div>
      </div>

      <!-- Items Table -->
      <table class="table table-bordered mt-4" id="billTable">
        <thead>
          <tr>
            <th>Item Name</th>
            <th>Qty</th>
            <th>Unit Price</th>
            <th>Total</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody></tbody>
      </table>

      <!-- Summary -->
      <div class="d-flex justify-content-end mt-3">
        <h5>Total: Rs. <span id="grandTotal">0.00</span></h5>
      </div>

      <div class="mt-4">
        <button type="submit" class="btn btn-success">Save Bill</button>
        <a href="billing.jsp" class="btn btn-secondary">Cancel</a>
      </div>
    </form>
  </div>
</div>

<script>
  let grandTotal = 0;
  function addItem() {
    const itemSelect = document.getElementById('itemSelect');
    const quantity = document.getElementById('quantity').value;
    const unitPrice = document.getElementById('unitPrice').value;

    if (!itemSelect.value || quantity <= 0) return alert('Select item & enter quantity');

    const itemName = itemSelect.options[itemSelect.selectedIndex].text;
    const total = (quantity * unitPrice).toFixed(2);

    const tableBody = document.querySelector('#billTable tbody');
    const row = document.createElement('tr');
    row.innerHTML = `
      <td>${itemName}<input type="hidden" name="item_id[]" value="${itemSelect.value}"></td>
      <td>${quantity}<input type="hidden" name="quantity[]" value="${quantity}"></td>
      <td>${unitPrice}<input type="hidden" name="unit_price[]" value="${unitPrice}"></td>
      <td>${total}<input type="hidden" name="total_price[]" value="${total}"></td>
      <td><button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this, ${total})">Remove</button></td>
    `;
    tableBody.appendChild(row);

    grandTotal += parseFloat(total);
    document.getElementById('grandTotal').innerText = grandTotal.toFixed(2);
  }

  function removeRow(button, total) {
    button.parentElement.parentElement.remove();
    grandTotal -= parseFloat(total);
    document.getElementById('grandTotal').innerText = grandTotal.toFixed(2);
  }

  document.getElementById('itemSelect').addEventListener('change', function() {
    const price = this.options[this.selectedIndex].getAttribute('data-price');
    document.getElementById('unitPrice').value = price || '';
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
