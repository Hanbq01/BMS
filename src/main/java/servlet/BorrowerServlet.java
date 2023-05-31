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

@WebServlet("/borrower")
public class BorrowerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		if ("delete".equals(action)) {
			deleteuser(request, response);
		} else if ("update".equals(action)) {
			updateuser(request, response);
		} else {
			// 处理其他请求
		}
	}

	protected void deleteuser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			// 获取请求参数
			int id = Integer.parseInt(request.getParameter("id"));

			// 从数据库中删除指定图书
			conn = DButil.getConnection();
			String sql = "delete from users where id=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();

			// 重定向到图书列表页
			response.sendRedirect("borrower.jsp");
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

	protected void updateuser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// 获取请求参数
			int id = Integer.parseInt(request.getParameter("id"));
			String username = request.getParameter("username");
			String realname = request.getParameter("realname");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String address = request.getParameter("address");

			// 更新图书信息
			conn = DButil.getConnection();
			String sql = "update users set username=?, realname=?, phone=?, email=?, address=? where id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, realname);
			ps.setString(3, phone);
			ps.setString(4, email);
			ps.setString(5, address);
			ps.setInt(6, id);
			ps.executeUpdate();

			// 重定向到图书列表页
			response.sendRedirect("borrower.jsp");
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
