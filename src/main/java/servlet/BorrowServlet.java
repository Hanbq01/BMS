package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.DButil;

/*
 *借阅图书的操作
 */

@WebServlet("/borrow")
public class BorrowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 设置响应内容类型
		response.setContentType("text/html;charset=UTF-8");

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		int bookId = Integer.parseInt(request.getParameter("bookId"));

		try {
			// 获取数据库连接
			conn = DButil.getConnection();

			// 查询要借阅的书籍信息
			String sql = "select * from book where id=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bookId);
			rs = ps.executeQuery();
			int quantity = 0;
			String bookName = "";

			while (rs.next()) {
				quantity = rs.getInt("quantity");
				bookName = rs.getString("bookname");
			}
			// 更新库存数量并将图书及个人信息存入borrow表
			if (quantity > 0) {
				String sql1 = "select * from users where username = ?"; // 获取用户信息
				ps = conn.prepareStatement(sql1);
				HttpSession session = request.getSession();
				String username = (String) session.getAttribute("username");
				ps.setString(1, username);
				rs = ps.executeQuery();
				String realname = "";
				String phone = "";
				while (rs.next()) {
					realname = rs.getString("realname");
					phone = rs.getString("phone");
				}

				String sql2 = "insert into borrow (name, phone, bookid,bookname, borrow_date) values (?, ?, ?, ?, now())"; // 将图书及个人信息存入borrow表
				ps = conn.prepareStatement(sql2);
				ps.setString(1, realname);
				ps.setString(2, phone);
				ps.setInt(3, bookId);
				ps.setString(4, bookName);
				ps.executeUpdate();

				String sql3 = "update book set quantity=? where id=?"; // 更新库存数量
				ps = conn.prepareStatement(sql3);
				ps.setInt(1, quantity - 1);
				ps.setInt(2, bookId);
				ps.executeUpdate();

				request.setAttribute("borrowmsg", "借阅成功!");
				request.getRequestDispatcher("userborrow.jsp").forward(request, response);
			} else {
				request.setAttribute("borrowmsg", "该书已全部借出!");
				request.getRequestDispatcher("userborrow.jsp").forward(request, response);
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
	}
}