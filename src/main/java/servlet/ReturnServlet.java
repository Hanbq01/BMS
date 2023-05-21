package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.DButil;

/*
 *归还图书的操作
 */

@WebServlet("/returnbook")
public class ReturnServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 获取 Borrow 表中的 borrow_id 和 book_name
		int borrow_id = Integer.parseInt(request.getParameter("borrow_id"));
		int book_id = Integer.parseInt(request.getParameter("book_id"));

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// 获取数据库连接
			conn = DButil.getConnection();

			// 删除 Borrow 表中的对应记录
			String sqlDeleteRecord = "delete from borrow where id=?";
			ps = conn.prepareStatement(sqlDeleteRecord);
			ps.setInt(1, borrow_id);
			ps.executeUpdate();

			// 在 Book 表中将对应书籍数量+1
			String sqlUpdateBook = "update book set quantity=quantity+1 where id=?";
			ps = conn.prepareStatement(sqlUpdateBook);
			ps.setInt(1, book_id);
			ps.executeUpdate();

			// 提示用户归还成功
			request.setAttribute("returnmsg", "归还成功!");
			request.getRequestDispatcher("userborrowrec.jsp").forward(request, response);
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
