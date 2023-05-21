<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,util.DButil,java.sql.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 

借阅人信息界面
在管理员界面可查看，显示所有借阅人信息

 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>借阅人信息</title>
<link rel="stylesheet" href="css/borrower.css">
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
	
	
	<h1>借阅人信息</h1>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>用户名</th>
			<th>姓名</th>
			<th>电话</th>
			<th>地址</th>
			<th>电子邮箱</th>
			<th>注册时间</th>
		</tr>
		<%
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// 获取数据库连接
			conn = DButil.getConnection();

			// 查询role为user的所有用户信息
			String sql = "SELECT id, username, realname, phone, address, email, reg_time FROM users WHERE role = 'user'";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			// 遍历结果集并输出到页面
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getInt("id")%></td>
			<td><%=rs.getString("username")%></td>
			<td><%=rs.getString("realname")%></td>
			<td><%=rs.getString("phone")%></td>
			<td><%=rs.getString("address")%></td>
			<td><%=rs.getString("email")%></td>
			<td><%=rs.getTimestamp("reg_time").toString()%></td>
		</tr>
		<%
		}
		} catch (SQLException e) {
		e.printStackTrace();
		} finally {
		// 关闭数据库连接
		try {
		DButil.close(conn, ps, rs);
		} catch (SQLException e) {
		e.printStackTrace();
		}
		}
		%>

	</table>
</body>
</html>
