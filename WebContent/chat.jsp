<%@ page language="java" import="entity.*,java.util.Map"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>chat</title>
</head>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.qqFace.js"></script>
<style type="text/css">
body {
	background: url(img/0.jpg);
	background-repeat: no-repeat;
	background-size: 100% 100%;
	background-attachment: fixed;
}

.container {
	width: 750px;
	height: 450px;
	background-color: white;
	position: fixed;
	position: absolute;
	left: 25%;
	top: 18%;
	border: 1px solid #999999;
}

.left {
	border: 1px solid #999999;
	width: 25%;
	height: 450px;
	float: left
}

.right {
	border: 1px solid #999999;
	width: 74.4%;
	height: 300px;
	float: left
}

.bottom {
	border: 1px solid #999999;
	width: 74%;
	height: 148px;
	float: left
}

.member_list_div {
	width: 100%;
	border: 1px solid #999999;
	height: 45px;
	background-color: #EBEEF3;
}

.member_list {
	font-family: "楷体";
	font-size: 18px;
}

.member_list_all {
	font-family: "楷体";
	font-size: 18px;
	width: 101%;
	height: 367px;
	overflow: auto;
}

.member_list_outButton {
	border: 1px solid #999999;
	height: 33px;
	width: 186px;
	background-color: #EBEEF3;
	position: relative;
	position: absolute; left; 0;
	bottom: 0;
}

input[id="outButton"] {
	margin-top: 2px;
	height: 28px;
	color: #3C404D;
	font-weight: bold;
	font-size: 4px;
}

.chat_content_div_top {
	width: 100%;
	border: 1px solid #999999;
	height: 45px;
	background-color: #EBEEF3;
}

.chat_content_div {
	width: 100%;
	height: 217px;
	overflow: auto;
}

.middle {
	border: 1px solid #999999;
	width: 100%;
	height: 35px;
	background-color: #EBEEF3;
}

.chat_send_button {
	width: 100.6%;
	border: 1px solid #999999;
	height: 33px;
	background-color: #EBEEF3;
}

.emotion_p {
	margin-top: 8px;
	margin-left: 30px;
}

#textarea {
	border: none;
	resize: none;
	cursor: pointer;
}

input[id="sendUser"] {
	width: 80px;
}

input[id="userButton"] {
	color: #3C404D;
	font-weight: bold;
	font-size: 10px;
}

input[id="allButton"] {
	margin-top: 2px;
	margin-left: 30px;
	height: 28px;
	color: #3C404D;
	font-weight: bold;
	font-size: 10px;
}
</style>

<body>
	<div class="container">
		<div class="left">

			<div class="member_list_div">
				<br /> <span class="member_list">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在线成员列表</span>

			</div>

			<div class="member_list_all1">
				<table>
					<tr>
						<td id="member_list_all"></td>
					</tr>

				</table>
			</div>
			<div class="member_list_outButton">
				<input type="button" name="outButton" id="outButton"
					class="outButton" value="退出登录" onclick='location.href=("exit")'
					style="font-size: 14px; font-family: '黑体';" />
			</div>
		</div>
		<div class="right">
			<div class="chat_content_div_top">
				<br /> <span class="member_list">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;聊天内容
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					用户:${user.name}</span>

			</div>
			<div class="chat_content_div" id="chat_content_div">

			</div>
			<div class="middle">
				<p class="emotion_p">
					<img class="emotion" id="emotion" src="img/00.jpg" width="23px"
						height="23px" />

				</p>
			</div>
		</div>
		<div class="bottom">
			<div class="chat_send">
				<textarea id="textarea" class="textarea" rows="7" cols="77"></textarea>
			</div>
			<div class="chat_send_button">
				<span style="color: #3C404D; font-weight: bold; font-size: 15px;">&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发送给:
				</span><input type="text" name="sendUser" id="sendUser" /> <input
					type="button" name="userButton" id="userButton" value="私聊"
					style="font-size: 18px; font-family: '黑体';" /> <input
					type="button" name="allButton" id="allButton" value="群聊发送"
					style="font-size: 18px; font-family: '黑体';" />
			</div>
		</div>
	</div>

</body>
<%
	UserInfo user = (UserInfo) session.getAttribute("user");
	String name = user.getName();
%>
<script>
		//页面一执行就显示在线人数列表
		$(function(){			
			showOnline();		
		});
		function showOnline(){
			$.post("${pageContext.request.contextPath}/online.jsp?"+new Date().getTime(),function(data){
				$("#member_list_all").html(data);
			});
		}
		window.setInterval("showOnline();",1000);
		var ws=null;
		
		var target = "ws:192.168.4.10:8080/chat/chatt/<%=name%>";
		if(WebSocket){
			//建立连接
			ws = new WebSocket(target);
		}else{
			alert("该浏览器不支持WebSocket");
		}
		
		//通道连接后执行的动作
		ws.onopen=function(event){
			//向客户端发送消息
			ws.send("<%=name%>:加入了聊天室");
		}
		
		//接收服务器端发送的数据
		ws.onmessage=function(event){
			//debugger;
			var content = $("#chat_content_div");
			var value = content.html();
			
			var str = event.data.replace(/\</g, '&lt;');

			str = str.replace(/\>/g, '&gt;');

			str = str.replace(/\n/g, '<br/>');

			str = str.replace(/\[em_([0-9]*)\]/g,'<img src="img/$1.gif" border="0" />');
						
			value=value+"<ul><li type='none' style='font-size: 12px;font-family: '宋体';'>"+str+"</li></ul>";
			//追加内容
			content.html(value);
			//滚动到最新
			content.scrollTop(content[0].scrollHeight);
			
		}
		
		//群发消息
		$("#allButton").click(function(){
			//获取textarea文本框的内容
			var message = $("#textarea").val(); 
			//将textarea内容发送到服务器
			ws.send("[<%=name%>]说:" + message);
		//发送消息后清除textarea
		$("#textarea").val("");
		})
		
		//私聊发送消息
		$("#userButton").click(function(){
			//获取接收用户的名字
			var username = $("#sendUser").val();
			
			//获取textarea文本框的内容
			var message = $("#textarea").val(); 
			//将textarea内容发送到服务器
			ws.send("."+"<%=name%>对" + "<a>"+username +"</a>" +"说:" + message);
			//发送消息后清除textarea
			$("#sendUser").val("");
			$("#textarea").val("");
		})

	$(function() {
		$('.emotion').qqFace({

			id : 'facebox',

			assign : 'textarea',

			path : 'img/' //表情存放的路径
		});
	});
</script>
</html>