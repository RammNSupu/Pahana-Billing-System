<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pahana EDU - Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">

    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Inter';
            background-image: url('pahanaBackground.png');
            background-repeat: repeat;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-box {
            width: 90%;
            max-width: 420px;
            padding: 100px 35px;
            background-color: #fff;
            border-radius: 30px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .header {
          padding-bottom: 10px;
          transform: translateY(-60px);
        }

        .logo {
            display: flex;
            justify-content: center;
            margin-bottom: 8px;
        }

        .logo img {
            width: 70px;
        }

        .login-title {
            font-size: 22px;
            font-weight: 700;
            text-align: center;
            margin-top: 10px;
        }

        .subtitle {
            font-size: 14px;
            text-align: center;
            color: #666;
            margin-bottom: 25px;
        }

        .form-label {
            font-weight: 500;
            margin-bottom: 6px;
        }

        /* Keep icons inside box */
.input-with-icon {
    position: relative;
}
.input-with-icon i {
    position: absolute;
    top: 50%;
    left: 12px;
    transform: translateY(-50%);
    color: #aaa;
    pointer-events: none;
}
.input-with-icon input {
    padding-left: 36px;
}

/* Error input style */
.error-input {
    border: 2px solid #e74c3c !important;
    box-shadow: none;
}

/* Error message style */
.error-message {
    font-size: 12px;
    color: #e74c3c;
    margin-top: 4px;
    margin-left: 4px;
}


        .btn-login {
            background-color: #3A71F1;
            color: white;
            border-radius: 12px;
            font-weight: 500;
            margin-top: 30px;
            transform: translateY( 45px);
        }

        .btn-login:hover {
            background-color: #6495ED;
        }

        .form-section {
          transform: translateY(-40px);
        }

        .custom-label {
          color: #000;
          font-size: 13px;
          margin-left: 5px;
          margin-bottom: 5px;
        }

        .form-control{
           color: #666;
           font-size: 12px ;
        }

        input.form-control {
          border: 1.7px solid #B3AFAF;
        }
        
        /* Remove Bootstrap's default validation background icon */
.form-control.is-invalid {
    background-image: none !important;
    padding-right: 0.75rem; /* keep spacing consistent */
}

.invalid-feedback {
    display: block;
    margin-left: 36px; /* same as your input left padding */
    font-size: 12px;
    color: #dc3545; /* Bootstrap red */
}

        
    </style>
</head>
<body>

    <div class="login-box">
      <div class="header">
        <div class="logo">
          <img src="Group 1.png" alt="Logo" style="width: 60px;">
        </div>
        <div class="login-title">PAHANA EDU</div>
        <div class="subtitle">- Bookshop Billing System -</div>
      </div>

      <form action="${pageContext.request.contextPath}/login" method="post" class="form-section">
        <%
         String usernameValue = (String) request.getAttribute("usernameValue");
         Boolean usernameErrorObj = (Boolean) request.getAttribute("usernameError");
         Boolean passwordErrorObj = (Boolean) request.getAttribute("passwordError");

         boolean usernameError = (usernameErrorObj != null) ? usernameErrorObj : false;
         boolean passwordError = (passwordErrorObj != null) ? passwordErrorObj : false;
         %>

        <div class="mb-3">
            <label for="username" class="form-label custom-label"><b>Username</b></label>
            <div class="input-with-icon">
                <i class="fas fa-user"></i>
                <input type="text"
                       class="form-control <%= usernameError ? "error-input" : "" %>"
                       id="username" name="username"
                       placeholder="Enter your username"
                       value="<%= (usernameValue != null) ? usernameValue : "" %>"
                       required>
            </div>
    <% if (usernameError) { %>
        <div class="error-message">Username not found. Please try again.</div>
    <% } %>
</div>

<div class="mb-3">
    <label for="password" class="form-label custom-label"><b>Password</b></label>
    <div class="input-with-icon">
        <i class="fas fa-lock"></i>
        <input type="password"
               class="form-control <%= passwordError ? "error-input" : "" %>"
               id="password" name="password"
               placeholder="Enter your password"
               required>
    </div>
    <% if (passwordError) { %>
        <div class="error-message">Incorrect password. Try again.</div>
    <% } %>
</div>


    <div class="d-grid">
        <button type="submit" class="btn btn-login">Sign in</button>
    </div>
</form>

    </div>

</body>
</html>
