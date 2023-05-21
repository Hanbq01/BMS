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
import javax.servlet.http.HttpSession;

import util.DButil;

/*
 *更改密码的操作 
 */

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 从 request 中获取用户提交的表单数据
		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");

		// 检查用户输入的旧密码是否正确
		// 如果不正确，返回一个错误提示给用户
		if (!checkOldPassword(request.getSession(), oldPassword)) {
			request.setAttribute("errorMsg", "旧密码输入有误，请重新输入！");
			request.getRequestDispatcher("/personal.jsp").forward(request, response);
			return;
		}

		// 检查新密码和确认密码是否一致
		// 如果不一致，返回一个错误提示给用户
		if (!newPassword.equals(confirmPassword)) {
			request.setAttribute("errorMsg", "两次输入的密码不一致，请重新输入！");
			request.getRequestDispatcher("/personal.jsp").forward(request, response);
			return;
		}

		// 更新数据库中的用户信息，将新密码存储到数据库中
		updatePassword(request.getSession(), newPassword);

		// 返回一个成功提示给用户
		request.setAttribute("successMsg", "密码修改成功！");
		request.getRequestDispatcher("/personal.jsp").forward(request, response);
	}

	/**
	 * 检查用户输入的旧密码是否正确
	 * 
	 * @param session     当前用户的会话
	 * @param oldPassword 用户输入的旧密码
	 * @return 如果旧密码正确，则返回 true；否则返回 false。
	 */
	private boolean checkOldPassword(HttpSession session, String oldPassword) {
		String username = (String) session.getAttribute("username");
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM users WHERE username=? AND password=?";
		try {
			// 建立数据库连接
			conn = DButil.getConnection();
			// 准备 SQL 语句
			ps = conn.prepareStatement(sql);
			// 设置参数，查询当前登录用户的信息
			ps.setString(1, username);
			ps.setString(2, oldPassword);
			// 执行 SQL 查询并获取结果集
			rs = ps.executeQuery();
			if (rs.next()) {
				// 旧密码输入正确
				return true;
			} else {
				// 旧密码输入有误
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			// 关闭数据库资源
			try {
				DButil.close(conn, ps, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 更新数据库中的用户信息，将新密码存储到数据库中
	 * 
	 * @param session     当前用户的会话
	 * @param newPassword 用户输入的新密码
	 */
	private void updatePassword(HttpSession session, String newPassword) {
		String username = (String) session.getAttribute("username");
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "UPDATE users SET password=? WHERE username=?";
		try {
			// 建立数据库连接
			conn = DButil.getConnection();
			// 准备 SQL 语句
			ps = conn.prepareStatement(sql);
			// 设置参数，更新用户的密码
			ps.setString(1, newPassword);
			ps.setString(2, username);
			// 执行 SQL 更新操作
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 关闭数据库资源
			try {
				DButil.close(conn, ps, null);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
