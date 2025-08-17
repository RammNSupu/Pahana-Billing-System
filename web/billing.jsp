<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Load customers
    List<Map<String, String>> customers = new ArrayList<>();
    try (Connection conn = com.pahana.util.DBUtil.getConnection()) {
        PreparedStatement st = conn.prepareStatement("SELECT id, name FROM customers ORDER BY name");
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Map<String,String> c = new HashMap<>();
            c.put("id", rs.getString("id"));
            c.put("name", rs.getString("name"));
            customers.add(c);
        }
    } catch (Exception ex) { ex.printStackTrace(); }

    // Load items
    List<Map<String, String>> items = new ArrayList<>();
    try (Connection conn = com.pahana.util.DBUtil.getConnection()) {
        PreparedStatement st = conn.prepareStatement("SELECT id, item_name, price FROM items ORDER BY item_name");
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Map<String,String> i = new HashMap<>();
            i.put("id", rs.getString("id"));
            i.put("name", rs.getString("item_name"));
            i.put("price", rs.getString("price"));
            items.add(i);
        }
    } catch (Exception ex) { ex.printStackTrace(); }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Billing - Pahana Edu</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>

  <style>
    body { margin:0; font-family:'Segoe UI',sans-serif; background-color:rgba(62,85,212,.07); }
    .sidebar{position:fixed; top:70px; left:0; height:calc(100vh - 70px); width:240px; background:#fff; padding:20px 10px; box-shadow:0 0 10px rgba(0,0,0,.1);}
    .quick-stats-btn{background:linear-gradient(to right,#A626C6,#F74040); color:#fff; border-radius:20px; padding:15px 20px; width:100%; text-align:center; font-weight:600; margin-bottom:25px;}
    .sidebar .nav-link{color:black; font-weight:500; padding:10px 15px; margin-bottom:10px; display:flex; gap:10px; border-radius:10px;}
    .sidebar .nav-link.active,.sidebar .nav-link:hover{background:#3e55d4; color:#fff!important;}
    .topbar{position:fixed; top:0; left:0; width:100%; height:70px; background:#fff; display:flex; align-items:center; justify-content:space-between; padding:0 30px; border-bottom:1px solid #eee; z-index:1000;}
    .brand-area{display:flex; align-items:center; gap:15px;}
    .brand-area img{width:40px;}
    .brand-text h5{margin:0; font-weight:bold; color:#3e55d4;}
    .brand-text small{font-size:12px; color:#666;}
    .user-info{display:flex; align-items:center; gap:15px;}
    .main-content{margin-left:240px; margin-top:70px; padding:30px;}
    .dashboard-header{background:#fff; padding:20px; border-radius:12px; color:#000; font-weight:600; margin-bottom:30px; box-shadow:0 4px 8px rgba(0,0,0,.1);}
    .card-shadow{background:#fff; border-radius:12px; box-shadow:0 6px 8px rgba(0,0,0,.15); padding:20px; color:#000;}
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
<% } %>

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
      <span class="badge bg-danger rounded-pill" style="position:absolute; top:0; right:-5px; font-size:12px;">3</span>
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

<!-- Main -->
<div class="main-content">
  <div class="dashboard-header d-flex justify-content-between align-items-center">
    <div>
      <h4>Create New Bill</h4>
      <p class="text-muted mb-0">Add items and generate customer bill</p>
    </div>
    <div><i class="bi bi-calendar-event"></i> <%= java.time.LocalDate.now() %></div>
  </div>

  <div class="card-shadow">
    <!-- STEP 1: Post to generateBill.jsp -->
    <form id="billForm" action="generateBill.jsp" method="post">
      <div class="row mb-3">
        <div class="col-md-4">
          <label class="form-label">Bill Date &amp; Time</label>
          <input type="datetime-local" name="bill_date" id="bill_date" class="form-control"
                 value="<%= java.time.LocalDateTime.now().toString().substring(0,16) %>" required>
        </div>
        <div class="col-md-4">
          <label class="form-label">Select Customer</label>
          <select name="customer_id" id="customer_id" class="form-select" required>
            <option value="">-- Select Customer --</option>
            <% for (Map<String,String> c: customers){ %>
              <option value="<%= c.get("id") %>"><%= c.get("name") %></option>
            <% } %>
          </select>
        </div>
      </div>

      <div class="row g-3 align-items-end">
        <div class="col-md-5">
          <label class="form-label">Item</label>
          <select id="itemSelect" class="form-select">
            <option value="">-- Select Item --</option>
            <% for (Map<String,String> i: items){ %>
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
          <button type="button" class="btn btn-primary" id="addBtn">Add</button>
        </div>
      </div>

      <table class="table table-bordered mt-4" id="itemsTable">
        <thead>
          <tr>
            <th>Item</th>
            <th>Qty</th>
            <th>Unit Price</th>
            <th>Total</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody id="itemsBody"></tbody>
      </table>

      <!-- Grand total (and hidden) -->
      <div class="d-flex justify-content-end mt-3">
        <h5>Total: Rs. <span id="grandTotal">0.00</span></h5>
        <input type="hidden" name="totalAmount" id="totalAmount" value="0.00">
      </div>

      <!-- These hidden inputs will be appended per-row: item_id[], item_name[], quantity[], unit_price[], total_price[] -->

      <div class="mt-4">
        <button type="submit" class="btn btn-primary">Generate Bill</button>
        <a href="dashboard.jsp" class="btn btn-secondary">Cancel</a>
      </div>
    </form>
  </div>
</div>

<script>
  let runningTotal = 0;

  const itemSelect = document.getElementById('itemSelect');
  const unitPriceInput = document.getElementById('unitPrice');
  const itemsBody = document.getElementById('itemsBody');
  const grandTotalEl = document.getElementById('grandTotal');
  const totalAmountHidden = document.getElementById('totalAmount');

  // auto-fill unit price
  itemSelect.addEventListener('change', function() {
    const price = this.options[this.selectedIndex]?.getAttribute('data-price') || '';
    unitPriceInput.value = price;
  });

  document.getElementById('addBtn').addEventListener('click', function(){
    const itemId = itemSelect.value;
    const itemName = itemSelect.options[itemSelect.selectedIndex]?.text || '';
    const qty = parseInt(document.getElementById('quantity').value, 10);
    const unitPrice = parseFloat(unitPriceInput.value);

    if (!itemId) { alert('Please select an item.'); return; }
    if (!Number.isFinite(qty) || qty <= 0) { alert('Invalid quantity.'); return; }
    if (!Number.isFinite(unitPrice) || unitPrice <= 0) { alert('Invalid unit price.'); return; }

    const rowTotal = qty * unitPrice;

    // Visible row + hidden inputs (array names!)
     const tr = document.createElement('tr');
tr.innerHTML = `
  <td>${itemName}</td>
  <td>${qty}</td>
  <td>${unitPrice.toFixed(2)}</td>
  <td>${rowTotal.toFixed(2)}</td>
  <td><button type="button" class="btn btn-danger btn-sm">Remove</button></td>
`;

// Hidden inputs
tr.innerHTML += `
  <input type="hidden" name="item_id" value="${itemId}">
  <input type="hidden" name="item_name" value="${itemName}">
  <input type="hidden" name="quantity" value="${qty}">
  <input type="hidden" name="unit_price" value="${unitPrice.toFixed(2)}">
  <input type="hidden" name="total_price" value="${rowTotal.toFixed(2)}">
`;


    // update totals
    runningTotal += rowTotal;
    grandTotalEl.textContent = runningTotal.toFixed(2);
    totalAmountHidden.value = runningTotal.toFixed(2);

    // reset qty to 1
    document.getElementById('quantity').value = 1;
  });

  // prevent submit without items
  document.getElementById('billForm').addEventListener('submit', function(e){
    if (!itemsBody.querySelector('input[name="item_id"]')) {
      e.preventDefault();
      alert('Please add at least one item to the bill.');
    }
  });

  // Success alert auto-hide
  setTimeout(()=> {
    const a = document.querySelector('.alert-success');
    if (a) a.style.display = 'none';
  }, 5000);
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
