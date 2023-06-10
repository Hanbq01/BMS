<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,util.DButil,java.sql.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 

借阅人信息界面
在管理员界面可查看，显示所有借阅人信息

5.30更新，增加了修改用户信息和删除用户信息的功能
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>借阅人信息</title>
<link rel="stylesheet" href="css/borrower.css">
<script>
function editPer(id, username, realname, phone, email, address) {
	document.getElementById('editId').value = id;
	document.getElementById('editusername').value = username;
	document.getElementById('editrealname').value = realname;
	document.getElementById('editphone').value = phone;
	document.getElementById('editemail').value = email;
	document.getElementById('editaddress').value = address;
	document.getElementById('editDiv').style.display = 'block';
}

function cancelEdit() {
	document.getElementById('editDiv').style.display = 'none';
}
</script>
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
	<!-- 查找用户 -->
	<div>
		<form method="get" action="" class="finduser">
			<label for="search-type">按照</label> <select name="searchType"
				id="search-type">
				<option value="id">编号</option>
				<option value="username">用户名</option>
				<option value="realname">真实姓名</option>
				<option value="phone">电话</option>
				<option value="email">电子邮箱</option>
				<option value="address">地址</option>
			</select> <label for="search-keyword">查找</label> <input type="text"
				name="searchKeyword" id="search-keyword">
			<button type="submit">搜索</button>
		</form>
	</div>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>用户名</th>
			<th>姓名</th>
			<th>电话</th>
			<th>地址</th>
			<th>电子邮箱</th>
			<th>注册时间</th>
			<th>操作</th>
		</tr>
		<%
		String searchType = request.getParameter("searchType");
		String searchKeyword = request.getParameter("searchKeyword");

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// 获取数据库连接
			conn = DButil.getConnection();

			// 查询role为user的所有用户信息
			String sql = "SELECT * FROM users WHERE role = 'user'";
			if (searchKeyword != null && !"".equals(searchKeyword)) {
				sql += " and " + searchType + " like '%" + searchKeyword + "%'";
			}
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
			<td>
				<button id="editBtn_<%=rs.getInt("id")%>"
					onclick="editPer(<%=rs.getInt("id")%>,'<%=rs.getString("username")%>','<%=rs.getString("realname")%>','<%=rs.getString("phone")%>','<%=rs.getString("email")%>','<%=rs.getString("address")%>')">修改</button>
				<button id="delBtn_<%=rs.getInt("id")%>"
					onclick="if(confirm('确认删除吗？')){document.getElementById('deleteForm_<%=rs.getInt("id")%>').submit();}">
					删除</button>
				<form id="deleteForm_<%=rs.getInt("id")%>" action="borrower"
					method="post">
					<input type="hidden" name="action" value="delete"> <input
						type="hidden" name="id" value="<%=rs.getInt("id")%>">
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
	<div id="editDiv" class="showandhidediv" style="display: none;">
		<form action="borrower" method="post">
			<input type="hidden" name="action" value="update"> <input
				type="hidden" name="id" id="editId"> <label>用户名：</label><input
				type="text" name="username" id="editusername"><br> <label>真实姓名：</label><input
				type="text" name="realname" id="editrealname"><br> <label>电话号码：</label><input
				type="text" name="phone" id="editphone"><br> <label>电子邮箱：</label><input
				type="text" name="email" id="editemail"><br> <label>地址：</label><input
				type="text" name="address" id="editaddress"><br> <input
				type="submit" value="保存"> <input type="button" value="取消"
				onclick="cancelEdit()">
		</form>
	</div>
</body>
</html>
