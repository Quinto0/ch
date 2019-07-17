<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>register</title>
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

.registerDiv {
	width: 450px;
	height: 320px;
	background-color: aliceblue;
	position: absolute;
	left: 60%;
	top: 20%;
}

#title {
	font-size: 22px;
	text-align: center;
	padding: 10px;
	font-family: "黑体";
}

#table {
	font-size: 15px;
	text-align: left;
}

td {
	height: 45px;
}

input[type="text"] {
	height: 28px;
	width: 200px;
	border-radius: 3px;
	border: 1px solid #c8cccf;
	color: #6a6f77;
	outline: 0;
}

input[type="password"] {
	height: 30px;
	width: 200px;
	border-radius: 3px;
	border: 1px solid #c8cccf;
	color: #6a6f77;
	outline: 0;
}

input[type="submit"] {
	font-family: "黑体";;
	font-size: 20px;
}

label.error {
	background: url(img/unchecked.gif) no-repeat 10px 3px;
	padding-left: 30px;
	font-family: georgia;
	font-size: 10px;
	font-style: normal;
	color: red;
}

label.success {
	background: url(img/checked.gif) no-repeat 10px 3px;
	padding-left: 30px;
}
</style>

<script src="js/jquery-3.4.1.js" type="text/javascript" charset="utf-8"></script>
<!--引入validate插件js文件-->
<script src="js/jquery.validate.min.js" type="text/javascript"
	charset="utf-8"></script>

<script type="text/javascript">
	$(function() {
		jQuery.validator
				.addMethod(
						"isMobile",
						function(value, element) {
							var length = value.length;
							var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
							return this.optional(element)
									|| (length == 11 && mobile.test(value));
						}, "请正确填写您的手机号码");

		$("#registForm").validate({
			rules : {
				name : {
					required : true,
					minlength : 3,
				},
				password : {
					required : true,
					minlength : 6
				},
				phone : {
					required : true,
					isMobile : true
				},
				email : {
					required : true,
					email : email
				},

				gender : {
					required : true,

				}
			},
			messages : {
				username : {
					required : "用户名不能为空”",
					minlength : "用户名不得少于3位"

				},
				password : {
					required : "密码不能为空",
					minlength : "密码不得少于6位"

				},
				phone : {
					required : "电话不能为空",

					isMobile : "电话格式不正确"
				},
				email : {
					required : "邮箱不能为空",
					email : "邮箱格式不正确"
				},

				gender : {
					required : "性别必须勾选",

				}
			},
			errorElement : "label", //用来创建错误提示信息标签
			success : function(label) { //验证成功后的执行的回调函数
				//label指向上面那个错误提示信息标签label
				label.text(" ") //清空错误提示消息
				.addClass("success"); //加上自定义的success类
			}
		});
	});
</script>
</head>

<body>

	<div class="registerDiv">

		<form action="register" method="post" id="registForm">
			<table id="table" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2">
						<p id="title">注册页面</p>
					</td>
				</tr>
				<tr height="35px">
					<td width="80px">&nbsp;用户名：</td>
					<td width="350px"><em style="color: red;">*</em>&nbsp;&nbsp<input
						type="text" name="name" id="name" value="" placeholder="请输入用户名"
						maxlength="16" /></td>
				</tr>
				<tr height="35px">
					<td>&nbsp;密码：</td>
					<td><em style="color: red;">*</em>&nbsp;&nbsp<input
						type="password" name="password" id="password" value="" placeholder="请输入密码" />
					</td>
				</tr>
				<tr height="35px">
					<td>&nbsp;手机号码：</td>
					<td><em style="color: red;">*</em>&nbsp;&nbsp<input
						type="text" name="phone" id="phone" value="" placeholder="请输入手机号码" />
					</td>
				</tr>
				<tr height="35px">
					<td>&nbsp;邮箱：</td>
					<td><em style="color: red;">*</em>&nbsp;&nbsp<input
						type="text" name="email" id="email" value="" placeholder="请输入邮箱" />
					</td>
				</tr>
				<tr height="35px">
					<td>&nbsp;性别：</td>
					<td><em style="color: red;">*</em>&nbsp;&nbsp男&nbsp;&nbsp;<input
						type="radio" name="gender" id="men" value="男" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;女 &nbsp; <input
						type="radio" name="gender" id="women" value="女" /></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit"
						id="submit" value="注册" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>