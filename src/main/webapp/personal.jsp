<%@page import="java.sql.*"%>
<%@page import="util.DButil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>个人信息</title>
<link rel="stylesheet" type="text/css" href="css/personal.css">
<script src="js/showhidediv.js"></script>
</head>
<body>
	<%
	String username = (String) session.getAttribute("username");
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM users WHERE username=?";
	try {
		// 建立数据库连接
		conn = DButil.getConnection();
		// 准备 SQL 语句
		ps = conn.prepareStatement(sql);
		// 设置参数，查询当前登录用户的信息
		ps.setString(1, username);
		// 执行 SQL 查询并获取结果集
		rs = ps.executeQuery();
		if (rs.next()) {
			// 取出数据，并显示在页面上
			String realname = rs.getString("realname");
			String phone = rs.getString("phone");
			String email = rs.getString("email");
			String role = rs.getString("role");
	%>
	<h1 class="title">个人信息</h1>
	<p>
		用户名：<%=username%></p>
	<p>
		真实姓名：<%=realname%></p>
	<p>
		电话：<%=phone%></p>
	<p>
		邮箱：<%=email%></p>
	<p>
		身份：<%=role%></p>

	<div id="editDiv" style="display: none;">
		<form action="savePersonalInfo" method="post">
			<label for="realnameInput">真实姓名：</label> <input type="text"
				id="realnameInput" name="realname" value="<%=realname%>"><br>
			<br> <label for="phoneInput">电话：</label> <input type="text"
				id="phoneInput" name="phone" value="<%=phone%>"><br> <br>
			<label for="emailInput">邮箱：</label> <input type="email"
				id="emailInput" name="email" value="<%=email%>"><br> <br>
			<input type="submit" value="保存"> <input type="button"
				value="取消" onclick="hideEdit()">
		</form>
	</div>
	<div id="changePassword" style="display: none;">
		<form action="changePassword" method="post">
			<label for="oldPasswordInput">旧密码：</label> <input type="password"
				id="oldPasswordInput" name="oldPassword" required><br>
			<br> <label for="newPasswordInput">新密码：</label> <input
				type="password" id="newPasswordInput" name="newPassword" required><br>
			<br> <label for="confirmPasswordInput">确认密码：</label> <input
				type="password" id="confirmPasswordInput" name="confirmPassword"
				required><br> <br> <input type="submit" value="保存">
			<input type="button" value="取消" onclick="hideChangePassword()">
		</form>

	</div>
	<p>
		<button id="editButton" onclick="showEdit()">编辑个人信息</button>
		<button id="changePasswordButton" onclick="showChangePassword()">修改密码</button>
	</p>

	<c:if test="${not empty errorMsg}">
		<p class="error errorMsg" style="color: red;">${errorMsg}</p>
	</c:if>

	<c:if test="${not empty successMsg}">
		<p class="successMsg" style="color: green;">${successMsg}</p>
	</c:if>

	<%
	} else {
	// 没有找到该用户的信息
	out.println("<p>没有找到该用户的信息。</p>");
	}
	} catch (SQLException e) {
	e.printStackTrace();
	} finally {
	// 关闭数据库资源
	try {
	DButil.close(conn, ps, rs);
	} catch (SQLException e) {
	e.printStackTrace();
	}
	}
	%>
</body>

</html>