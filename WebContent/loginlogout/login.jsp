<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SSAI ログイン</title>
    <style>
        body { 
            font-family: 'Yu Gothic', sans-serif; 
            text-align: center; 
            margin-top: 60px; 
            background-color: #f5f5f5;
        }
        .login-container {
            width: 350px;
            margin: 0 auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .login-container h2 {
            color: #333;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .form-group input:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
        }
        .login-btn {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-bottom: 15px;
        }
        .login-btn:hover {
            background-color: #0056b3;
        }
        .forgot {
            text-align: right;
        }
        .forgot a {
            font-size: 12px;
            color: #007bff;
            text-decoration: none;
        }
        .forgot a:hover {
            text-decoration: underline;
        }
        .error {
            color: #dc3545;
            margin-top: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>SSAI</h2>
        <form action="${pageContext.request.contextPath}/loginlogout/loginExecute" method="post">
            <div class="form-group">
                <label>企業ID</label>
                <input type="text" name="companyCode" placeholder="COMP001" required>
            </div>
            
            <div class="form-group">
                <label>ユーザーID</label>
                <input type="text" name="username" placeholder="admin" required>
            </div>
            
            <div class="form-group">
                <label>パスワード</label>
                <input type="password" name="password" placeholder="admin123" required>
            </div>
            
            <button type="submit" class="login-btn">ログイン</button>
            
            <div class="forgot">
                <a href="#">パスワードを忘れた場合</a>
            </div>
        </form>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
    </div>
</body>
</html