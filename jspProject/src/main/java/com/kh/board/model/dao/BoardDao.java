package com.kh.board.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.common.model.vo.PageInfo;

import static com.kh.common.JDBCTemplate.*;

public class BoardDao {

	private Properties prop = new Properties();
	
	public BoardDao() {
		
		try {
			prop.loadFromXML(new FileInputStream(BoardDao.class.getResource("/db/sql/board-mapper.xml").getPath()));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public int selectListCount(Connection conn) {
		// SELECT문 => ResultSet (한행) => int
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectListCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
			
			if (rset.next()) {
				listCount = rset.getInt("count");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return listCount;
	}
	
	public ArrayList<Board> selectList(Connection conn, PageInfo pi) {
		
		// select문 => ResultSet (여러행) => ArrayList<Board>
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			/*
			 * currentPage : 1 => 시작값 :  1 ~ 10
			 * currentPage : 2 => 시작값 : 11 ~ 20
			 * currentPage : 3 => 시작값 : 21 ~ 30
			 * 
			 * 시작값 : (currentPage - 1) * boardLimit + 1
			 * 끝값  : 시작값 - 1 + boardLimit
			 */
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
			int endRow = startRow - 1 + pi.getBoardLimit();
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while (rset.next()) {
				
				list.add(new Board(
									  rset.getInt("board_no")
									, rset.getString("category_name")
									, rset.getString("board_title")
									, rset.getString("user_id")
									, rset.getInt("count")
									, rset.getString("create_date")
								  ));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public ArrayList<Category> selectCategoryList(Connection conn) {
		
		// select문 => ResultSet (여러행) => ArrayList<Category>
		ArrayList<Category> list = new ArrayList<Category>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectCategoryList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
			
			while (rset.next()) {
				list.add(new Category(rset.getInt("category_no"),
									  rset.getString("category_name")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	
}
