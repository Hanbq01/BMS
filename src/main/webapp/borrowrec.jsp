<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,util.DButil,java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 

借阅信息界面
在管理员可以查看，用于显示所有的借阅信息，并增加了过期判断功能，判断借阅日期和当前日期的差值是否大于14天
，如果大于14天则显示已过期，反之显示未过期，通过动态页面实现

 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>借阅信息</title>
<link rel="stylesheet" href="css/borrowrec.css">
<style>
</style>
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


	<h1>借阅信息</h1>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>姓名</th>
			<th>书籍名称</th>
			<th>借阅日期</th>
			<th>是否过期</th>
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
			<td><%=rs.getString("bookname")%></td>
			<td><%=rs.getString("borrow_date")%></td>

			<%
			//获取当前日期和时间
			Date currentDate = new Date();
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String currentStr = simpleDateFormat.format(currentDate);

			//获取该行借书日期和是否已还
			String borrowDate = rs.getString("borrow_date");

			//计算已借时间
			long diff = (simpleDateFormat.parse(currentStr).getTime() - simpleDateFormat.parse(borrowDate).getTime())
					/ (24 * 60 * 60 * 1000);
			%>
			<td class="<%=diff > 14 ? "expired" : "not-expired"%>">
				<%
				if (diff > 14) {
					out.print("已过期");
				} else {
					out.print("未过期");

				}
				%>
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
