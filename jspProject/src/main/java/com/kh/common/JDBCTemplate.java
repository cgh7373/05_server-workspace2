package com.kh.common;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCTemplate {

	// 1. Connection 객체 생성 한후 해당 Connection 객체를 반환하는 getConnection 메소드
	public static Connection getConnection() {

		Connection conn = null;
		
		Properties prop = new Properties(); // Map계열 컬렉션 (키-밸류 쌍)
		
		// 읽어들이고자 하는 classes 폴더내의 driver.properties 파일의 물리적인 경로
		// /는 최상위 폴더 의미
		String filePath = JDBCTemplate.class.getResource("/db/driver/driver.properties").getPath();
		
		try {
			prop.load(new FileInputStream(filePath));
//			prop에 filePath에 있는 키-밸류값 집어넣기
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		try {
			// jdbc driver 등록
			Class.forName(prop.getProperty("driver"));
			
			// 접속할 db의 url, 계정명, 비밀번호 제시해서 Connection 객체 생성
			conn = DriverManager.getConnection(prop.getProperty("url"),
											   prop.getProperty("username"),
											   prop.getProperty("password"));
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
		
	}
	
	// 2_1. Connection 객체 전달받아 commit하는 commit 메소드
	public static void commit(Connection conn) {
		
		try {
			if (conn != null && !conn.isClosed()) {
				conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 2_2. 	""				  rollback하는 rollback 메소드
	public static void rollback(Connection conn) {
		
		try {
			if (conn != null && !conn.isClosed()) {
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 3_1. Connection 객체 전달받아서 반납하는 close 메소드
	public static void close(Connection conn) {
		
		try {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 3_2. Statement 객체 전달받아서 반납하는 close 메소드
	public static void close(Statement stmt) {
		
		try {
			if (stmt != null && !stmt.isClosed()) {
				stmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 3_3. ResultSet 객체 전달받아서 반납한느 close 메소드
	public static void close(ResultSet rset) {
		
		try {
			if (rset != null && !rset.isClosed()) {
				rset.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	
	
}
