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
 *登录的操作 
 */

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 获取用户名和密码参数
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String role = request.getParameter("role");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 连接数据库并查询用户信息
			conn = DButil.getConnection();
			String sql = "SELECT * FROM users WHERE username=? AND password=? AND role=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, role);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				// 根据数据库中查询出来的用户信息判断用户角色并存入Session中
				String userRole = rs.getString("role");
				HttpSession session = request.getSession();
				session.setAttribute("role", userRole);

				// 将用户名也存储在Session中
				session.setAttribute("username", username);

				// 根据用户角色重定向到不同的首页
				if ("admin".equals(userRole)) {
					response.sendRedirect(request.getContextPath() + "/admin.jsp");
				} else if ("user".equals(userRole)) {
					response.sendRedirect(request.getContextPath() + "/user.jsp");
				}
			} else {
				// 用户名或密码错误或身份错误，返回登录页面并显示错误信息
				request.setAttribute("error", "用户名或密码或身份选择错误！");
				// 将请求转发回 login.jsp 页面
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			}

		} catch (SQLException e) {
			// 如果出现SQLException异常，打印异常堆栈并跳转到错误页面
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		} finally {
			try {
				DButil.close(conn, pstmt, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
