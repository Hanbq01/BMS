<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 

注册页面
为了安全性只能注册普通用户，管理员用户信息需要直接去数据库进行添加

 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注册</title>
<link rel="stylesheet" href="css/register.css">
</head>
<body>
	<h1>用户注册</h1>
	<%-- 显示错误信息 --%>
	<c:if test="${not empty error}">
		<div class="error-box">
			<span class="error-message">${error}</span>
		</div>
	</c:if>
	<form method="post" action="register">
		<table border="0">
			<tr>
				<td>用户名：</td>
				<td><input type="text" name="username" required></td>
			</tr>
			<tr>
				<td>密码：</td>
				<td><input type="password" name="password" required></td>
			</tr>
			<tr>
				<td>确认密码：</td>
				<td><input type="password" name="confirmPassword" required></td>
			</tr>
			<tr>
				<td>真实姓名：</td>
				<td><input type="text" name="realname"></td>
			</tr>
			<tr>
				<td>手机号码：</td>
				<td><input type="tel" name="phone"></td>
			</tr>
			<tr>
				<td>电子邮箱：</td>
				<td><input type="email" name="email"></td>
			</tr>
			<tr>
				<td>家庭地址：</td>
				<td><input type="text" name="address"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="注册"></td>
			</tr>
		</table>
	</form>
</body>
</html>
