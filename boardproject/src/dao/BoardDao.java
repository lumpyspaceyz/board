package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import db.DBUtil;
import vo.Board;

public class BoardDao {
	
	public ArrayList<String> selectBoardCategoryList() throws ClassNotFoundException, SQLException {
		ArrayList<String> boardCategoryList = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "select distinct board_category from board order by board_category asc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			boardCategoryList.add(rs.getString("board_category"));
		}
		// debug
		System.out.println(stmt + " <-- stmt");
		System.out.println(rs + " <-- rs");
		
		rs.close();
		stmt.close();
		conn.close();
		
		return boardCategoryList;
	}
	
	public ArrayList<Board> selectBoardListByPage(String boardCategory, int currentPage, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Board> boardList = new ArrayList<>();
		// ResultSet이라는 특수한 타입에서 ArrayList라는 일반화된 타입을 변환(가공)
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		int beginRow = (currentPage-1) * rowPerPage;

		// boardCategory값에 따라 분기 -> 동적쿼리
		String sql = null;
		PreparedStatement stmt = null;

		if(boardCategory.equals("") == true) {
			sql = "select board_no, board_category, board_title from board order by board_date desc limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {
			sql = "select board_no, board_category, board_title from board where board_category=? order by board_date desc limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, boardCategory);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Board board = new Board();
			board.setBoardNo(rs.getInt("board_no"));
			board.setBoardCategory(rs.getString("board_category"));
			board.setBoardTitle(rs.getString("board_title"));
			boardList.add(board);				
		}
		// debug
		System.out.println(stmt + " <-- stmt");
		System.out.println(rs + " <-- rs");
		
		rs.close();
		stmt.close();
		conn.close();
		
		return boardList;
		
	}
	
	public int selectTotalCount(String boardCategory) throws ClassNotFoundException, SQLException {
		int totalCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// boardCategory값에 따라 분기
		String sql = null;
		PreparedStatement stmt = null;
		// debug
		System.out.println(boardCategory + "<--boardCategory");
		
		if(boardCategory.equals("") == true) { // 카테고리 선택x
			sql = "SELECT COUNT(*) FROM board";
			stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			// debug
			System.out.println(stmt + " <-- stmt");
			
			if(rs.next()) {
				totalCount = rs.getInt("COUNT(*)");
				// debug
				System.out.println(rs + " <-- rs");
				rs.close();
			}
		} else { // 카테고리 선택o
			sql = "SELECT COUNT(*) FROM board WHERE board_category=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, boardCategory);
			ResultSet rs = stmt.executeQuery();
			// debug
			System.out.println(stmt + "<--stmt");
			
			if(rs.next()) {
				totalCount = rs.getInt("COUNT(*)");
				// debug
				System.out.println(rs + " <-- rs");
				rs.close();
			}
		}

		stmt.close();
		conn.close();
		
		return totalCount;
	}
	
	public Board selectBoardOne(int boardNo) throws ClassNotFoundException, SQLException {
		Board board = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "select board_no, board_category, board_title, board_content, board_date from board where board_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
			
		ResultSet rs = stmt.executeQuery();
		
		if (rs.next()) {
			board = new Board();
			// 정보은닉 되어있는 필드값을 직접 쓰기 불가
			// board.boardCategory = rs.getString("board_category"); -> 직접수정x
			// 캡슐화 메소드(setter)를 통해 쓰기
			board.setBoardCategory(rs.getString("board_category"));
			board.setBoardTitle(rs.getString("board_title"));
			board.setBoardContent(rs.getString("board_Content"));
			board.setBoardDate(rs.getString("board_date"));
		}
		// debug
		System.out.println(stmt + " <-- stmt");
		System.out.println(rs + " <-- rs");

		rs.close();
		stmt.close();
		conn.close();
		
		return board;
	}
	
	public boolean insertBoard(Board board) throws ClassNotFoundException, SQLException {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "insert into board(board_title, board_category, board_content, board_date) values (?, ?, ?, now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, board.getBoardTitle());
		stmt.setString(2, board.getBoardCategory());
		stmt.setString(3, board.getBoardContent());
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			result = true;
		}
		// debug
		System.out.println(stmt + " <-- stmt");
		
		stmt.close();
		conn.close();
		
		return result;
	}
	
	public boolean updateBoard(Board board) throws ClassNotFoundException, SQLException {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "update board set board_category=?, board_title=?, board_content=? where board_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, board.getBoardCategory());	
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setInt(4, board.getBoardNo());
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			result = true;
		}
		// debug
		System.out.println(stmt + " <-- stmt");
		
		stmt.close();
		conn.close();
		
		return result;
	}
	
	public boolean deleteBoard(int boardNo) throws ClassNotFoundException, SQLException {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "delete from board where board_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			result = true;
		}
		// debug
		System.out.println(stmt + " <-- stmt");
		
		stmt.close();
		conn.close();
		
		return result;
	}
	

}
