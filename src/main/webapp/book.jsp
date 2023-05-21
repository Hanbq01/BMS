<%@ page language="java" import="java.util.*,util.DButil,java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!-- 

图书管理页面
管理员界面可查看，包含添加图书，修改图书，删除图书，根据类别搜索图书功能

 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>图书管理</title>
<link rel="stylesheet" href="css/book.css">
<script src="js/showhidediv.js"></script>
<script>
function editBook(id, bookname, author, publisher, publishDate, quantity) {
	document.getElementById('editId').value = id;
	document.getElementById('editbookname').value = bookname;
	document.getElementById('editAuthor').value = author;
	document.getElementById('editPublisher').value = publisher;
	document.getElementById('editPublishDate').value = publishDate;
	document.getElementById('editQuantity').value = quantity;
	document.getElementById('editDiv').style.display = 'block';
}

function cancelEdit() {
	document.getElementById('editDiv').style.display = 'none';
}
</script>

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

	<p>图书列表</p>
	<div class="addbtn">
		<button id="addBtn" onclick="showAddDiv()">添加图书</button>
	</div>
	<!--查找图书 -->
	<div>
		<form method="get" action="" class="findbook">
			<label for="search-type">按照</label> <select name="searchType"
				id="search-type">
				<option value="id">编号</option>
				<option value="bookname">图书名</option>
				<option value="author">作者</option>
				<option value="publisher">出版社</option>
			</select> <label for="search-keyword">查找</label> <input type="text"
				name="searchKeyword" id="search-keyword">
			<button type="submit">搜索</button>
		</form>
	</div>
	<div class="table-container">
		<table border="1">
			<tr>
				<th>编号</th>
				<th>书名</th>
				<th>作者</th>
				<th>出版社</th>
				<th>出版日期</th>
				<th>库存</th>
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

				// 查询所有图书信息
				String sql = "select * from book";
				if (searchKeyword != null && !"".equals(searchKeyword)) {
					sql += " where " + searchType + " like '%" + searchKeyword + "%'";
				}
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();

				// 遍历结果集并输出到页面
				while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getInt("id")%></td>
				<td><%=rs.getString("bookname")%></td>
				<td><%=rs.getString("author")%></td>
				<td><%=rs.getString("publisher")%></td>
				<td><%=rs.getString("publish_date")%></td>
				<td><%=rs.getInt("quantity")%></td>
				<td>
					<button id="editBtn_<%=rs.getInt("id")%>"
						onclick="editBook(<%=rs.getInt("id")%>,'<%=rs.getString("bookname")%>','<%=rs.getString("author")%>','<%=rs.getString("publisher")%>','<%=rs.getString("publish_date")%>','<%=rs.getInt("quantity")%>')">修改</button>
					<button id="delBtn_<%=rs.getInt("id")%>"
						onclick="if(confirm('确认删除吗？')){document.getElementById('deleteForm_<%=rs.getInt("id")%>').submit();}">
						删除</button>
					<form id="deleteForm_<%=rs.getInt("id")%>" action="book"
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
	</div>
	<div id="editDiv" class="showandhidediv" style="display: none;">
		<form action="book" method="post">
			<input type="hidden" name="action" value="update"> <input
				type="hidden" name="id" id="editId"> <label>书名：</label><input
				type="text" name="bookname" id="editbookname"><br> <label>作者：</label><input
				type="text" name="author" id="editAuthor"><br> <label>出版社：</label><input
				type="text" name="publisher" id="editPublisher"><br> <label>出版日期：</label><input
				type="date" name="publishDate" id="editPublishDate"><br>
			<label>库存：</label><input type="text" name="quantity"
				id="editQuantity"><br> <input type="submit" value="保存">
			<input type="button" value="取消" onclick="cancelEdit()">
		</form>
	</div>
	<div id="addDiv" class="showandhidediv" style="display: none;">
		<form action="book" method="post">
			<input type="hidden" name="action" value="add"> <label>书名：</label><input
				type="text" name="bookname"><br> <label>作者：</label><input
				type="text" name="author"><br> <label>出版社：</label><input
				type="text" name="publisher"><br> <label>出版日期：</label><input
				type="date" name="publishDate"><br> <label>库存：</label><input
				type="text" name="quantity"><br> <input type="submit"
				value="保存"> <input type="button" value="取消"
				onclick="cancelAdd()">
		</form>
	</div>
</body>
</html>
