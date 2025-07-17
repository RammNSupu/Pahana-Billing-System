<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login - Pahana Edu Billing System</title>
</head>
<body>
    <h2>Login</h2>

    <form action="login" method="post">
        <label>Username:</label><br>
        <input type="text" name="username"><br><br>

        <label>Password:</label><br>
        <input type="password" name="password"><br><br>

        <button type="submit">Login</button>
    </form>

    <%-- Show error if present --%>
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <p style="color:red;"><%= error %></p>
    <%
        }
    %>
</body>
</html>


