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
	Member deleteMember = memberDao.selectMemberOne(loginMember);
	// debug
	System.out.println(deleteMember.getMemberId() + "<-- loginMemberId");
	
	if(memberDao.deleteMember(deleteMember)) {
		System.out.println("회원탈퇴 성공");
		response.sendRedirect("./loginForm.jsp");
		session.invalidate(); // 사용자의 세션을 새로운 세션으로 갱신
	}

%>