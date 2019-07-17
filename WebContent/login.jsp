<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>login</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

body {
	background: url(img/0.jpg);
	background-size: cover;
	background-repeat: no-repeat;
}

form {
	border-radius: 20px;
	box-shadow: 10px 10px 25px rgba(100, 100, 100, 7);
}

.loginform {
	width: 330px;
	height: 350px;
	background-color: aliceblue;
	position: absolute;
	left: 60%;
	top: 20%;
}

.headline {
	font-size: 22px;
	text-align: center;
	padding: 20px;
	color: #3C404D
}

input[type="text"], input[type="submit"] {
	-web-kit-appearance: none;
	-moz-appearance: none;
	display: block;
	margin: 0 auto;
	font-size: 15px;
	width: 240px;
}

input[type="text"] {
	height: 35px;
	border-radius: 6px;
	border: 1px solid #c8cccf;
	color: #6a6f77;
	outline: 0;
}
input[type="password"] {
	height: 35px;
	border-radius: 6px;
	border: 1px solid #c8cccf;
	color: #6a6f77;
	outline: 0;
	display: block;
	margin: 0 auto;
	font-size: 15px;
	width: 240px;
}
input[type="submit"] {
	margin-top: 25px;
	height: 35px;
	background: #72CAD4;
	color: #3C404D;
	font-weight: bold;
	font-size: 16px;
}

input[type="submit"]:hover {
	background: #0e62a3;
	cursor: pointer;
}

.name {
	margin: 5px 0 5px 42px;
	font-size: 17px;
	color: #6a6f77;
}

.pwd {
	display: block;
	float: left;
	margin-left: 46px;
	font-size: 15px;
}

.fpwd {
	display: block;
	float: right;
	margin-right: 46px;
	font-size: 15px;
}

.fpwd a {
	text-decoration: none;
	color: #8B4513;
}

.span {
	color: red;
}
</style>
</head>

<body>

	<div class="loginform">
		<form action="login" method="post">
			<p class="headline">用户登陆</p>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="span">${msg}</span>
			<p class="name">用户名：</p>
			<input type="text" placeholder="请输入用户名" name="name">
			<p class="name">密码：</p>
			<input type="password" placeholder="请输入密码" name="pwd"> <input
				type="submit" value="登录" name="login"> </br>
			<p class="pwd">
				<input type="checkbox" name="rempas" />  记住密码
			</p>
			<p class="fpwd">忘记密码</p>
			</br> </br>
			<p class="fpwd">
				没有账号？ <a href="register.jsp">立即注册</a>
			</p>
		</form>
	</div>
</body>

</html>