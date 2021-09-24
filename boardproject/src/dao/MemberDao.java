package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBUtil;
import vo.Member;

public class MemberDao {
	// 1. 회원탈퇴
   public boolean deleteMember(Member member) throws ClassNotFoundException, SQLException {
      // 매개변수 값은 무조건! 디버깅!!!!! 무조건 하기!!!!!!!
      System.out.println(member.getMemberId() + "<--- MemberDao.deleteMember parem : memberId");
      System.out.println(member.getMemberPw() + "<--- MemberDao.deleteMember parem : memberPw");

      boolean result = false;
      
      DBUtil dbUtil = new DBUtil();
      Connection conn = dbUtil.getConnection();
      
      String sql = "DELETE FROM member WHERE member_id=? AND member_pw=?";
      PreparedStatement stmt = conn.prepareStatement(sql);
      stmt.setString(1, member.getMemberId());
      stmt.setString(2, member.getMemberPw());
      int row = stmt.executeUpdate();
	  // debug
	  System.out.println(stmt + "<-- stmt");
	  System.out.println(row + "<-- insert 결과 row");

	  if(row == 1) {
		  result = true;
	  }
	  
	  stmt.close();
	  conn.close();    
	  
      return result; // 제발! 수정
   }
   
   // 2. 회원정보수정
   // Member member : memberId와 memberPw 값
   // String MemberPwNew : 변경할 memberPw 값
   public boolean updateMember(Member member, Member memberNew) throws ClassNotFoundException, SQLException {
      // 매개변수 값은 무조건! 디버깅!!!!! 무조건 하기!!!!!!!
      System.out.println(member.getMemberId() + "<--- MemberDao.updateMember parem : memberId");
      System.out.println(member.getMemberPw() + "<--- MemberDao.updateMember parem : memberPw");
      System.out.println(member.getMemberName() + "<--- MemberDao.updateMember parem : memberName");
      System.out.println(member.getMemberAge() + "<--- MemberDao.updateMember parem : memberAge");
      System.out.println(member.getMemberGender() + "<--- MemberDao.updateMember parem : memberGender");
      System.out.println(memberNew.getMemberPw() + "<--- MemberDao.updateMember parem : memberPw");
      System.out.println(memberNew.getMemberName() + "<--- MemberDao.updateMember parem : memberName");
      System.out.println(memberNew.getMemberAge() + "<--- MemberDao.updateMember parem : memberAge");
      System.out.println(memberNew.getMemberGender() + "<--- MemberDao.updateMember parem : memberGender");

      boolean result = false;

      DBUtil dbUtil = new DBUtil();
      Connection conn = dbUtil.getConnection();
      
      String sql = "UPDATE member SET member_pw=?, member_name=?, member_age=?, member_gender=? WHERE member_id=? AND member_pw=?";
      PreparedStatement stmt = conn.prepareStatement(sql);
      stmt.setString(1, memberNew.getMemberPw());
      stmt.setString(2, memberNew.getMemberName());
      stmt.setInt(3, memberNew.getMemberAge());
      stmt.setString(4, memberNew.getMemberGender());
      stmt.setString(5, member.getMemberId());
      stmt.setString(6, member.getMemberPw());
      int row = stmt.executeUpdate();
	  // debug
	  System.out.println(stmt + "<-- stmt");
	  System.out.println(row + "<-- updatess 결과 row");
	  
	  if(row == 1) {
		  result = true;
	  }
      return result;
   }
   
   // 3. 회원정보출력(본인) (Member를 통해서 해도 됨, 그게 맞음)
   public Member selectMemberOne(Member member) throws ClassNotFoundException, SQLException {
      // 매개변수값은 무조건! 디버깅
	  System.out.println(member.getMemberId() + "<--- MemberDao.selectMember parem : memberId");
	  
	  Member returnMember = null;
	  
	  DBUtil dbUtil = new DBUtil();
      Connection conn = dbUtil.getConnection();
      
      String sql = "SELECT member_id, member_pw, member_name, member_age, member_gender, member_date FROM member WHERE member_id=?";
      PreparedStatement stmt = conn.prepareStatement(sql);
      stmt.setString(1, member.getMemberId());
      // stmt.setString(2, member.getMemberPw());
      // stmt.setString(3, member.getMemberName());
      ResultSet rs = stmt.executeQuery();
      
      if(rs.next()) {
         returnMember = new Member();
         returnMember.setMemberId(rs.getString("member_id"));
         returnMember.setMemberPw(rs.getString("member_pw"));
         returnMember.setMemberName(rs.getString("member_name"));
         returnMember.setMemberAge(rs.getInt("member_age"));
         returnMember.setMemberGender(rs.getString("member_gender"));
         returnMember.setMemberDate(rs.getString("member_date"));
         return returnMember;
      }
      return null;
   }
   
   // 4. 회원가입
   public boolean insertMember(Member member) throws ClassNotFoundException, SQLException {
      // debug
	  System.out.println(member.getMemberId() + "<--- MemberDao.insertMember parem : memberId");
	  System.out.println(member.getMemberPw() + "<--- MemberDao.insertMember parem : memberPw");
	  System.out.println(member.getMemberName() + "<--- MemberDao.insertMember parem : memberName");
	  System.out.println(member.getMemberAge() + "<--- MemberDao.insertMember parem : memberAge");
	  System.out.println(member.getMemberGender() + "<--- MemberDao.insertMember parem : memberGender");
      
      boolean result = false;
	  
	  DBUtil dbUtil = new DBUtil();
      Connection conn = dbUtil.getConnection();
      
      String sql = "INSERT INTO member(member_id, member_pw, member_name, member_age, member_gender, member_date) VALUES (?, ?, ?, ?, ?, NOW())";
      PreparedStatement stmt = conn.prepareStatement(sql);
      stmt.setString(1, member.getMemberId());
      stmt.setString(2, member.getMemberPw());
      stmt.setString(3, member.getMemberName());
      stmt.setInt(4, member.getMemberAge());
      stmt.setString(5, member.getMemberGender());
      int row = stmt.executeUpdate();
	  // debug
	  System.out.println(stmt + "<-- stmt");
	  System.out.println(row + "<-- insert 결과 row");
	  
	  if(row == 1) {
		  result = true;
	  }
      return result;
   }
   
   // 5. 로그인
   // 로그인 성공시 리턴값 Member : memberId + memberName
   // 로그인 실패시 리턴값 Member : null
   public Member login(Member member) throws ClassNotFoundException, SQLException {
      // Memeber member : memberId와 memberPw 값
      // 매개변수값은 무조건! 디버깅
      System.out.println(member.getMemberId() + "<--- MemberDao.deleteMember parem : memberId");
      System.out.println(member.getMemberPw() + "<--- MemberDao.deleteMember parem : memberPw");
      
      Member returnMember = null;
      
      DBUtil dbUtil = new DBUtil();
      Connection conn = dbUtil.getConnection();
      
      String sql = "SELECT member_id AS memberId, member_name AS memberName FROM member WHERE member_id=? AND member_pw=?";
      PreparedStatement stmt = conn.prepareStatement(sql);
      stmt.setString(1, member.getMemberId());
      stmt.setString(2, member.getMemberPw());
      ResultSet rs = stmt.executeQuery();
      /*
      if(rs.next()) {
         Member returnMember = new Member();
         return returnMember;
      } else {
         return null;
      }
      */
      if(rs.next()) {
         returnMember = new Member();
         returnMember.setMemberId(rs.getString("memberId"));
         returnMember.setMemberName(rs.getString("memberName"));
         return returnMember;
      }
      return null;
   }
}
