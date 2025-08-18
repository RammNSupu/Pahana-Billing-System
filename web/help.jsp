<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Help - Pahana Edu</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>

  <style>
    body { margin:0; font-family:'Segoe UI',sans-serif; background-color:rgba(62,85,212,.07); }

    /* Sidebar + Topbar same as before */
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

    /* Creative Help Section */
    .dashboard-header{background:#fff; padding:20px; border-radius:12px; color:#000; font-weight:600; margin-bottom:30px; box-shadow:0 4px 8px rgba(0,0,0,.1);}
    .accordion-item { border:none; margin-bottom:15px; border-radius:12px; overflow:hidden; box-shadow:0 3px 8px rgba(0,0,0,.08);}
    .accordion-button { font-weight:600; font-size:16px; display:flex; align-items:center; }
    .accordion-button i { font-size:18px; margin-right:12px; }
    .accordion-button:not(.collapsed) { background:linear-gradient(to right,#3e55d4,#6a5acd); color:#fff; }
    .accordion-body { background:#f9f9ff; padding:20px; border-top:1px solid #eee; }
    .accordion-body p strong { color:#333; }
    .accordion-body p { color:#555; }

    /* Support Box */
    .support-box {
      background: linear-gradient(to right, #ff7e5f, #f74040);
      color: #fff;
      border-radius: 15px;
      padding: 25px;
      margin-top: 40px;
      box-shadow: 0 6px 15px rgba(0,0,0,.15);
      text-align:center;
    }
    .support-box h5 { font-weight:700; margin-bottom:10px; }
    .support-box p { margin:0; font-size:15px; }
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
      <span class="badge bg-danger rounded-pill" style="position:absolute; top:0; right:-5px; font-size:12px;">3</span>
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
    <a class="nav-link" href="dashboard.jsp"><i class="bi bi-house-door-fill"></i> Dashboard</a>
    <a class="nav-link" href="customers.jsp"><i class="bi bi-people-fill"></i> Customers</a>
    <a class="nav-link" href="items.jsp"><i class="bi bi-box-fill"></i> Items</a>
    <a class="nav-link" href="billing.jsp"><i class="bi bi-receipt"></i> Billing</a>
    <a class="nav-link active" href="help.jsp"><i class="bi bi-question-circle-fill"></i> Help</a>
  </nav>
</div>

<!-- Main -->
<div class="main-content">
  <div class="dashboard-header">
    <h4>Help & FAQs</h4>
    <p class="text-muted mb-0">Find quick answers and instructions</p>
  </div>

  <div class="accordion" id="helpAccordion">
    <!-- Getting Started -->
    <div class="accordion-item">
      <h2 class="accordion-header" id="heading1">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1">
          <i class="bi bi-gear-fill text-primary"></i> Getting Started
        </button>
      </h2>
      <div id="collapse1" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
        <div class="accordion-body">
          <p><strong>How do I login?</strong><br>Use the username and password provided by the admin to log in.</p>
          <p><strong>How do I navigate?</strong><br>Use the left menu for Customers, Items, Billing, and Help.</p>
        </div>
      </div>
    </div>

    <!-- Customer Management -->
    <div class="accordion-item">
      <h2 class="accordion-header" id="heading2">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2">
          <i class="bi bi-people-fill text-success"></i> Customer Management
        </button>
      </h2>
      <div id="collapse2" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
        <div class="accordion-body">
          <p><strong>How to add a new customer?</strong><br>Go to Customers → Click Add → Fill form → Save.</p>
          <p><strong>How to search a customer?</strong><br>Use the search bar at the top of the Customers page.</p>
        </div>
      </div>
    </div>

    <!-- Item Management -->
    <div class="accordion-item">
      <h2 class="accordion-header" id="heading3">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse3">
          <i class="bi bi-box-fill text-warning"></i> Item Management
        </button>
      </h2>
      <div id="collapse3" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
        <div class="accordion-body">
          <p><strong>How to add new items?</strong><br>Navigate to Items → Add → Enter details and Save.</p>
          <p><strong>How to update item details?</strong><br>Edit the existing item record and click Update.</p>
        </div>
      </div>
    </div>

    <!-- Billing System -->
    <div class="accordion-item">
      <h2 class="accordion-header" id="heading4">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse4">
          <i class="bi bi-receipt text-danger"></i> Billing System
        </button>
      </h2>
      <div id="collapse4" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
        <div class="accordion-body">
          <p><strong>How to create a bill?</strong><br>Go to Billing → Select customer → Add items → Generate Bill.</p>
          <p><strong>Where to find past bills?</strong><br>All saved bills are in the Billing History section.</p>
        </div>
      </div>
    </div>

    <!-- Security & Access -->
    <div class="accordion-item">
      <h2 class="accordion-header" id="heading5">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse5">
          <i class="bi bi-lock-fill text-dark"></i> Security & Access
        </button>
      </h2>
      <div id="collapse5" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
        <div class="accordion-body">
          <p><strong>How do I change my password?</strong><br>Contact your admin to reset or change your password.</p>
          <p><strong>User roles?</strong><br>Admin = full access, Staff = limited access.</p>
          <p><strong>How do I log out safely?</strong><br>Click the Logout button in the top right corner.</p>
        </div>
      </div>
    </div>
  </div>

  <!-- Support Box -->
  <div class="support-box mt-4">
    <h5>Need More Help? 🤝</h5>
    <p>If you can't find what you're looking for, contact our support team:</p>
    <p class="mt-2"><i class="bi bi-envelope-fill"></i> support@pahanaedu.com</p>
    <p><i class="bi bi-telephone-fill"></i> +94 77 123 4567</p>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
