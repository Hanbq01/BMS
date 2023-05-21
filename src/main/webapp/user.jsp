<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- 

普通用户页面
包含个人信息，借阅图书，借阅记录页面，复用了管理员页面的代码以及样式

 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>图书管理系统 - 普通用户页面</title>
<link rel="stylesheet" type="text/css" href="css/everyuser.css">
</head>

<body>

<!-- 未登录提示 -->
	<%
	String username = (String) session.getAttribute("username");
	if (username == null || "".equals(username)) {
		response.setContentType("text/html;charset=UTF-8");
	%>
	<script>
		alert("未登录，请登录后使用！");
		window.location.href = "login.jsp";
	</script>
	<%
	return;
	}
	%>

	<header>
		<nav>
			<h3>图书管理系统-普通用户</h3>
			<ul>
				<li class="quit"><a href="login.jsp">退出登录</a></li>
			</ul>
		</nav>
	</header>

	<main>
		<div class="sidebar">
			<ul>
				<li><a href="personal.jsp" target="main">个人信息</a></li>
				<li><a href="userborrow.jsp" target="main">借阅图书</a></li>
				<li><a href="userborrowrec.jsp" target="main">我的借阅记录</a></li>
			</ul>
		</div>

	</main>
	<div class="content">
		<iframe src="personal.jsp" name="main" scrolling="auto" target="_self"></iframe>
	</div>
</body>
</html>
