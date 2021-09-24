package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import db.DBUtil;
import vo.Comment;

public class CommentDao {
	
	public ArrayList<Comment> selectCommentListByPage(int boardNo, int commentRowPerPage, int commentCurrentPage) throws SQLException, ClassNotFoundException {
		ArrayList<Comment> commentList = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		int commentBeginRow = (commentCurrentPage-1) * commentRowPerPage;
	
		// ResultSet이라는 특수한 타입에서 ArrayList라는 일반화된 타입을 변환(가공)
		String sql = "select comment_no, comment_content, comment_date from comment where board_no=? order by comment_date desc limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		stmt.setInt(2, commentBeginRow);
		stmt.setInt(3, commentRowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Comment comment = null;
			comment = new Comment();
			comment.commentNo = rs.getInt("comment_no");
			comment.commentContent = rs.getString("comment_content");
			comment.commentDate = rs.getString("comment_date");
			commentList.add(comment);				
		}
		// debug
		System.out.println(stmt + " <-- stmt");
		System.out.println(rs + " <-- rs");

		rs.close();
		stmt.close();
		conn.close();
		
		return commentList;
	}
	
	public int selectCommentTotalCount(int boardNo) throws ClassNotFoundException, SQLException {
		int commentTotalCount = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM comment WHERE board_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {	// rs.next()가 여러개일 때 while문 안에 넣어주고 단한개라면 if문 안에만 넣어줌 (혹시 값이 안 넘어올 경우를 대비해 if)
			commentTotalCount = rs.getInt("COUNT(*)");
		}
		// debug
		System.out.println(stmt + " <-- stmt");
		System.out.println(rs + " <-- rs");
		
		rs.close();
		stmt.close();
		conn.close();
		
		return commentTotalCount;
	}
	
	public boolean insertComment(Comment comment) throws ClassNotFoundException, SQLException {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO comment (board_no, comment_content, comment_date) VALUES (?, ?, now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.boardNo);
		stmt.setString(2, comment.commentContent);
		// debug
		System.out.println(stmt + " <-- stmt");
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			result = true;
		}

		stmt.close();
		conn.close();
		
		return result;
	}
	
	public boolean deleteComment(int commentNo) throws ClassNotFoundException, SQLException {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM comment WHERE comment_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		stmt.executeQuery();
		// debug
		System.out.println(stmt + " <-- stmt");
		
		stmt.close();
		conn.close();
		
		return false;
	}

}
