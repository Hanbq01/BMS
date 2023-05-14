<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,util.DButil,java.sql.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>借阅人信息</title>
<link rel="stylesheet" href="css/borrow.css">
</head>
<body>
	<h1>借阅人信息</h1>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>姓名</th>
			<th>书籍名称</th>
			<th>借阅日期</th>
			<th>是否归还</th>
		</tr>
		<%
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// 获取数据库连接
			conn = DButil.getConnection();

			// 查询所有图书信息
			String sql = "select * from borrow";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			// 遍历结果集并输出到页面
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getInt("id")%></td>
			<td><%=rs.getString("name")%></td>
			<td><%=rs.getString("book")%></td>
			<td><%=rs.getString("borrow_date")%></td>
			<td
				class="<%=rs.getInt("returned") == 0 ? "returned-no" : "returned-yes"%>">
				<%=rs.getInt("returned") == 0 ? "否" : "是"%>
			</td>
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
