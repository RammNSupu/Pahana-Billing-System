<%-- 
    Document   : add_customer.jsp
    Created on : Aug 4, 2025, 12:26:00 PM
    Author     : nimas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Customer</title>
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
        .form-label {
            font-weight: 500;
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
    <h4>Add New Customer</h4>
    <hr>
    <form action="addCustomer" method="post">
        <div class="mb-3">
            <label for="accountNumber" class="form-label">Account Number <span class="text-danger">*</span></label>
            <input type="text" class="form-control" name="accountNumber" id="accountNumber" required>
        </div>
        <div class="mb-3">
            <label for="name" class="form-label">Name <span class="text-danger">*</span></label>
            <input type="text" class="form-control" name="name" id="name" required>
        </div>
        <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <input type="text" class="form-control" name="address" id="address">
        </div>
        <div class="mb-3">
            <label for="phone" class="form-label">Phone Number <span class="text-danger">*</span></label>
            <input type="text" class="form-control" name="phone" id="phone" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" name="email" id="email">
        </div>

        <div class="d-flex justify-content-between mt-4">
            <button type="submit" class="btn btn-save">Save</button>
            <button type="reset" class="btn btn-cancel">Cancel</button>
        </div>
    </form>
</div>

</body>

<% String success = (String) request.getAttribute("success"); %>
<% String error = (String) request.getAttribute("error"); %>

<% if (success != null) { %>
  <div class="alert alert-success" role="alert"><%= success %></div>
<% } %>

<% if (error != null) { %>
  <div class="alert alert-danger" role="alert"><%= error %></div>
<% } %>

</html>

