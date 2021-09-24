<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("utf-8");
	MemberDao memberDao = new MemberDao();
	
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect("./index.jsp");
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	Member updateMember = memberDao.selectMemberOne(loginMember);
	// debug
	System.out.println(updateMember.getMemberId() + "<-- loginMemberId");
	
	String memberNewPw = request.getParameter("memberNewPw");
	String memberNewName = request.getParameter("memberNewName");
	int memberNewAge = Integer.parseInt(request.getParameter("memberNewAge"));
	String memberNewGender = request.getParameter("memberNewGender");
	
	Member memberNew = null;
	memberNew = new Member();
	memberNew.setMemberPw(memberNewPw);
	memberNew.setMemberName(memberNewName);
	memberNew.setMemberAge(memberNewAge);
	memberNew.setMemberGender(memberNewGender);
	
	if(memberDao.updateMember(updateMember, memberNew)) {
		System.out.println("회원정보 수정 성공");
		response.sendRedirect("./loginForm.jsp");
		session.invalidate(); // 사용자의 세션을 새로운 세션으로 갱신
	}

%>