<%@ page language="java" import="util.DButil" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>添加书籍</title>
<link rel="stylesheet" type="text/css" href="css/book.css">
</head>
<body>
	<h2>添加书籍</h2>
	<form action="book?action=add" method="post">
		<table border="1">
			<tr>
				<td>书名</td>
				<td><input name="title" type="text"></td>
			</tr>
			<tr>
				<td>作者</td>
				<td><input name="author" type="text"></td>
			</tr>
			<tr>
				<td>出版社</td>
				<td><input name="publisher" type="text"></td>
			</tr>
			<tr>
				<td>出版日期</td>
				<td><input name="publish_date" type="date"></td>
			</tr>
			<tr>
				<td>库存量</td>
				<td><input name="quantity" type="number"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="添加"></td>
			</tr>
		</table>
	</form>
	<p>
		<a href="book.jsp">返回图书列表</a>
	</p>
</body>
</html>
