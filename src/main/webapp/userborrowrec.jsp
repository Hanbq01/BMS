<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,util.DButil,java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 

普通用户借阅记录界面
显示个人所有借阅书籍的信息，右侧有归还按钮，点击即可归还图书

 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的借阅记录</title>
<link rel="stylesheet" href="css/borrowrec.css">
<link rel="stylesheet" href="css/userborrow.css">
</head>
<body>

	<!-- 未登录提示 -->
	<%
	String username1 = (String) session.getAttribute("username");
	if (username1 == null || "".equals(username1)) {
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

	<h1>我的借阅记录</h1>

	<c:if test="${not empty returnmsg}">
		<div class="msg-box">${returnmsg}</div>
	</c:if>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>姓名</th>
			<th>书籍名称</th>
			<th>借阅日期</th>
			<th>操作</th>
		</tr>
		<%
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// 获取数据库连接
			conn = DButil.getConnection();

			// 根据 session 中存储的 username 获取用户真实姓名
			String username = (String) session.getAttribute("username");
			String realname = null;
			String sqlGetRealname = "select realname from users where username=?";
			ps = conn.prepareStatement(sqlGetRealname);
			ps.setString(1, username);
			ResultSet rsGetRealname = ps.executeQuery();
			while (rsGetRealname.next()) {
				realname = rsGetRealname.getString("realname");
			}

			// 查询该用户的借阅信息
			String sql = "select * from borrow where name=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, realname);
			rs = ps.executeQuery();

			// 遍历结果集并输出到页面
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getInt("id")%></td>
			<td><%=rs.getString("name")%></td>
			<td><%=rs.getString("bookname")%></td>
			<td><%=rs.getString("borrow_date")%></td>
			<td>
				<form action="returnbook" method="post">
					<input type="hidden" name="borrow_id" value="<%=rs.getInt("id")%>">
					<input type="hidden" name="book_id"
						value="<%=rs.getInt("bookid")%>"> <input type="submit"
						value="归还">
				</form>
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
