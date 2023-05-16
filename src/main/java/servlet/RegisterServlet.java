package servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;

import util.DButil;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String realname = request.getParameter("realname");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");

		// 判断密码和确认密码是否一致
		if (!password.equals(confirmPassword)) {
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().println("<p>两次输入的密码不一致！</p>");
		} else {
			// 插入用户信息
			Connection conn = null;
			PreparedStatement ps = null;
			try {
				conn = DButil.getConnection();
				String sql = "INSERT INTO users (username, password, realname, phone, email, reg_time) VALUES (?, ?, ?, ?, ?, ?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, username);
				ps.setString(2, password);
				ps.setString(3, realname);
				ps.setString(4, phone);
				ps.setString(5, email);
				// 设置注册时间为当前时间
				Timestamp timestamp = new Timestamp(Calendar.getInstance().getTimeInMillis());
				ps.setTimestamp(6, timestamp);
				int count = ps.executeUpdate();
				if (count > 0) {
					response.sendRedirect("login.jsp");
				} else {
					response.setContentType("text/html;charset=UTF-8");
					response.getWriter().println("<p>注册失败！</p>");
				}
			} catch (SQLException e) {
				e.printStackTrace();
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().println("<p>注册失败！</p>");
			} finally {
				try {
					DButil.close(conn, ps, null);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
}
