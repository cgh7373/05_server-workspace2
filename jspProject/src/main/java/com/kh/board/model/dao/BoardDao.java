package com.kh.board.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.board.model.vo.Reply;
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
			 * currentPage : 1 => 시작값 : 1 ~ 10 currentPage : 2 => 시작값 : 11 ~ 20 currentPage
			 * : 3 => 시작값 : 21 ~ 30
			 * 
			 * 시작값 : (currentPage - 1) * boardLimit + 1 끝값 : 시작값 - 1 + boardLimit
			 */

			int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
			int endRow = startRow - 1 + pi.getBoardLimit();

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rset = pstmt.executeQuery();

			while (rset.next()) {

				list.add(new Board(rset.getInt("board_no"), rset.getString("category_name"),
						rset.getString("board_title"), rset.getString("user_id"), rset.getInt("count"),
						rset.getString("create_date")));

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
				list.add(new Category(rset.getInt("category_no"), rset.getString("category_name")));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}

	public int insertBoard(Connection conn, Board b) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertBoard");

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, Integer.parseInt(b.getCategory()));
			pstmt.setString(2, b.getBoardTitle());
			pstmt.setString(3, b.getBoardContent());
			pstmt.setInt(4, Integer.parseInt(b.getBoardWriter()));

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int insertAttachment(Connection conn, Attachment at) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAttachment");

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, at.getOriginName());
			pstmt.setString(2, at.getChangeName());
			pstmt.setString(3, at.getFilePath());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int increaseCount(Connection conn, int boardNo) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("increaseCount");

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, boardNo);

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public Board selectBoard(Connection conn, int boardNo) {

		Board b = null;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectBoard");

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, boardNo);

			rset = pstmt.executeQuery();

			if (rset.next()) {

				b = new Board(rset.getInt("board_no"), rset.getString("category_name"), rset.getString("board_title"),
						rset.getString("board_content"), rset.getString("user_id"), rset.getString("create_date"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return b;
	}

	public Attachment selectAttachment(Connection conn, int boardNo) {

		Attachment at = null;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectAttachment");

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, boardNo);

			rset = pstmt.executeQuery();

			if (rset.next()) {

				at = new Attachment();

				at.setFileNo(rset.getInt("file_no"));
				at.setOriginName(rset.getString("origin_name"));
				at.setChangeName(rset.getString("change_name"));
				at.setFilePath(rset.getString(4));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return at;
	}

	public int updateBoard(Connection conn, Board b) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateBoard");

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, Integer.parseInt(b.getCategory()));
			pstmt.setString(2, b.getBoardTitle());
			pstmt.setString(3, b.getBoardContent());
			pstmt.setInt(4, b.getBoardNo());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int updateAttachment(Connection conn, Attachment at) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateAttachment");

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, at.getOriginName());
			pstmt.setString(2, at.getChangeName());
			pstmt.setString(3, at.getFilePath());
			pstmt.setInt(4, at.getFileNo());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int insertNewAttachment(Connection conn, Attachment at) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertNewAttachment");

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, at.getRefBoardNo());
			pstmt.setString(2, at.getOriginName());
			pstmt.setString(3, at.getChangeName());
			pstmt.setString(4, at.getFilePath());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int deleteBoard(Connection conn, int bNo) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteBoard");

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, bNo);
			pstmt.setInt(2, bNo);

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int insertThBoard(Connection conn, Board b) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertThBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, b.getBoardTitle());
			pstmt.setString(2, b.getBoardContent());
			pstmt.setInt(3, Integer.parseInt(b.getBoardWriter()));

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int insertAttachmentList(Connection conn, ArrayList<Attachment> list) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAttachmentList");

	
		try {
			for (Attachment at : list) {
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, at.getOriginName());
				pstmt.setString(2, at.getChangeName());
				pstmt.setString(3, at.getFilePath());
				pstmt.setInt(4, at.getFileLevel());

				result = pstmt.executeUpdate();

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public ArrayList<Board> selectThumbnailList(Connection conn) {
		
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectThumbnailList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
			
			while (rset.next()) {
				
				list.add(new Board(
								    rset.getInt("board_no")
								  , rset.getString("board_title")
								  , rset.getInt("count")
								  , rset.getString("titleImg")
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

	public ArrayList<Attachment> selectAttachmentList(Connection conn, int boardNo) {
		
		ArrayList<Attachment> list = new ArrayList<Attachment>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			while (rset.next()) {
				
				Attachment at = new Attachment();
				
				at.setChangeName(rset.getString("change_name"));
				at.setFilePath(rset.getString("file_path"));
				
				list.add(at);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public ArrayList<Reply> selectReplyList(Connection conn, int bNo) {
		
		ArrayList<Reply> list = new ArrayList<Reply>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectReplyList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bNo);
			
			rset = pstmt.executeQuery();
			
			while (rset.next()) {
				list.add(new Reply(
									  rset.getInt(1)
									, rset.getString(2)
									, rset.getString(3)
									, rset.getString(4)
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

	public int insertReply(Connection conn, Reply r) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertReply");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, r.getReplyContent());
			pstmt.setInt(2, r.getRefBoardNo());
			pstmt.setInt(3, Integer.parseInt(r.getReplyWriter()));
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
