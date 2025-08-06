<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Add Item - Pahana Edu</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>

  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: rgba(62, 85, 212, 0.07);
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

    .form-card h4 {
      margin-bottom: 20px;
      font-weight: bold;
    }

    .btn-save {
      background-color: #3e55d4;
      color: white;
    }

    .btn-cancel {
      background-color: #ccc;
      color: black;
    }

    .btn-save:hover {
      background-color: #3244b4;
    }

    .form-label.required::after {
      content: " *";
      color: red;
    }
  </style>
</head>
<body>

<div class="main-content">
  <div class="form-card">
    <h4>Add New Item</h4>
    <form action="addItemServlet" method="post">
      <div class="mb-3">
        <label class="form-label required">Item Code</label>
        <input type="text" class="form-control" name="item_code" required>
      </div>
      <div class="mb-3">
        <label class="form-label required">Item Name</label>
        <input type="text" class="form-control" name="item_name" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Category</label>
        <select class="form-select" name="category">
          <option value="">-- Select Category --</option>
          <option value="Novel">Novel</option>
          <option value="Stationery">Stationery</option>
          <option value="Educational">Educational</option>
          <option value="Magazine">Magazine</option>
          <option value="Children">Children</option>
        </select>
      </div>
      <div class="mb-3">
        <label class="form-label required">Price</label>
        <input type="number" step="0.01" class="form-control" name="price" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Stock</label>
        <input type="number" class="form-control" name="stock">
      </div>
      <div class="mb-4">
        <label class="form-label">Description</label>
        <textarea class="form-control" name="description" rows="3"></textarea>
      </div>
      <div class="d-flex justify-content-between">
        <button type="submit" class="btn btn-save">Save</button>
        <a href="items.jsp" class="btn btn-cancel">Cancel</a>
      </div>
    </form>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
