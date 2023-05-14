<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page - 图书管理系统</title>
<link rel="stylesheet" href="css/login.css">
</head>
<body>
	<h1>欢迎访问图书管理系统！</h1>
	
	<%-- 显示错误信息 --%>
	<c:if test="${not empty error}">
		<div class="error-box">
			<span class="error-message">${error}</span>
		</div>
	</c:if>
	
	<form method="post" action="login">
		<table border="0">
			<tr>
				<td>用户名：</td>
				<td><input type="text" name="username" placeholder="请输入用户名"
					required></td>
			</tr>
			<tr>
				<td>密 码：</td>
				<td><input type="password" name="password" placeholder="请输入密码"
					required></td>
			</tr>
			<tr>
				<td>身 份：</td>
				<td><select name="role" required>
						<option value="">请选择身份</option>
						<option value="normal">普通用户</option>
						<option value="admin">管理员</option>
				</select></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="登录"></td>
			</tr>
		</table>
	</form>
</body>
</html>
