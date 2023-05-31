package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Book;
import util.DButil;

/*
 *图书信息的增删改操作 
 */

@WebServlet("/book")
public class BookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			// 查询所有图书信息
			conn = DButil.getConnection();
			String sql = "select * from book";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			// 将查询结果封装到List中
			List<Book> bookList = new ArrayList<Book>();
			while (rs.next()) {
				Book book = new Book();
				book.setId(rs.getInt("id"));
				book.setbookname(rs.getString("bookname"));
				book.setAuthor(rs.getString("author"));
				book.setPublisher(rs.getString("publisher"));
				book.setPublishDate(rs.getString("publish_date"));
				book.setQuantity(rs.getInt("quantity"));
				bookList.add(book);
			}

			// 将List转发到jsp页面进行展示
			request.setAttribute("bookList", bookList);
			request.getRequestDispatcher("book.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				DButil.close(conn, ps, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		if ("add".equals(action)) {
			addBook(request, response);
		} else if ("delete".equals(action)) {
			deleteBook(request, response);
		} else if ("update".equals(action)) {
			updateBook(request, response);
		} else {
			// 处理其他请求
		}
	}

	protected void addBook(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			// 获取请求参数
			String bookname = request.getParameter("bookname");
			String author = request.getParameter("author");
			String publisher = request.getParameter("publisher");
			String publishDate = request.getParameter("publishDate");
			int quantity = Integer.parseInt(request.getParameter("quantity"));

			// 添加新图书信息到数据库
			conn = DButil.getConnection();
			String sql = "insert into book(bookname, author, publisher, publish_date, quantity) values(?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bookname);
			ps.setString(2, author);
			ps.setString(3, publisher);
			ps.setString(4, publishDate);
			ps.setInt(5, quantity);
			ps.executeUpdate();

			// 重定向到图书列表页
			response.sendRedirect("book");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				DButil.close(conn, ps, null);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	protected void deleteBook(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			// 获取请求参数
			int id = Integer.parseInt(request.getParameter("id"));

			// 从数据库中删除指定图书
			conn = DButil.getConnection();
			String sql = "delete from book where id=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();

			// 重定向到图书列表页
			response.sendRedirect("book.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				DButil.close(conn, ps, null);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	protected void updateBook(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// 获取请求参数
			int id = Integer.parseInt(request.getParameter("id"));
			String bookname = request.getParameter("bookname");
			String author = request.getParameter("author");
			String publisher = request.getParameter("publisher");
			String publishDate = request.getParameter("publishDate");
			int quantity = Integer.parseInt(request.getParameter("quantity"));

			// 更新图书信息
			conn = DButil.getConnection();
			String sql = "update book set bookname=?, author=?, publisher=?, publish_date=?, quantity=? where id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bookname);
			ps.setString(2, author);
			ps.setString(3, publisher);
			ps.setString(4, publishDate);
			ps.setInt(5, quantity);
			ps.setInt(6, id);
			ps.executeUpdate();

			// 重定向到图书列表页
			response.sendRedirect("book.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				DButil.close(conn, ps, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
