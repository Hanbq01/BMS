<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>图书管理系统 - 管理员页面</title>
<link rel="stylesheet" type="text/css" href="css/admin.css">
</head>

<body>
	<header>
		<nav>
			<h3>图书管理系统-管理员</h3>
			<ul>
				<li class="quit"><a href="login.jsp">退出登录</a></li>
			</ul>
		</nav>
	</header>

	<main>
		<div class="sidebar">
			<ul>
				<li><a href="personal.jsp" target="main">个人信息</a></li>
				<li><a href="book.jsp" target="main">图书管理</a></li>
				<li><a href="borrower.jsp" target="main">借阅人信息</a></li>
				<li><a href="borrow.jsp" target="main">借阅记录</a></li>
			</ul>
		</div>

	</main>
	<div class="content">
		<iframe  src="personal.jsp" name="main"  scrolling="auto" target="_self"></iframe>
	</div>
</body>


</frameset>


</html>
