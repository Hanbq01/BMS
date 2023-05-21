package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DButil {
	private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://localhost:3306/bms?&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "root";

	public static Connection getConnection() throws SQLException {
		try {
			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		System.out.println("数据库连接成功");
		return DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
	}

	public static void close(Connection conn, PreparedStatement ps, ResultSet rs) throws SQLException {
		if (rs != null) {
			rs.close();
		}
		if (ps != null) {
			ps.close();
		}
		if (conn != null) {
			conn.close();
		}
	}
}
