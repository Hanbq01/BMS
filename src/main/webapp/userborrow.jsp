<%@ page language="java" import="java.util.*,util.DButil,java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 

普通用户借阅图书界面
复用管理员的图书管理界面中部分代码，实现了显示所有图书和查找图书
修改了操作部分的内容，普通用户可以借阅图书

 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>借阅图书</title>
<link rel="stylesheet" href="css/book.css">
<link rel="stylesheet" href="css/userborrow.css">
<script>
    function showReturnDate() {
        // 获取当前日期
        var currentDate = new Date();
        // 计算14天后的日期
        var returnDate = new Date(currentDate.getTime() + 14 * 24 * 60 * 60 * 1000);
        // 格式化日期
        var year = returnDate.getFullYear();
        var month = returnDate.getMonth() + 1;
        month = month < 10 ? '0' + month : month;
        var day = returnDate.getDate();
        day = day < 10 ? '0' + day : day;
        // 弹出提示框
        alert('图书最大借阅期限14天，请于' + year + '-' + month + '-' + day + '之前归还');
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


	<p>图书列表</p>

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

	<c:if test="${not empty borrowmsg}">
		<div class="msg-box">${borrowmsg}</div>
	</c:if>
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

				// 动态生成查询语句
				String sql = "select * from book";
				if (searchKeyword != null && !"".equals(searchKeyword)) {
					sql += " where " + searchType + " like '%" + searchKeyword + "%'";
				}
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();

				//遍历结果集并输出到页面
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
					<form method="post" action="borrow" onsubmit="showReturnDate()">
						<input type="hidden" name="bookId" value="<%=rs.getInt("id")%>">
						<input type="submit" value="借阅" >
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
</body>
</html>
