<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	CommentDao commentDao = new CommentDao();

	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	
	// debug
	System.out.println(commentNo + "<-- commentNo");
	System.out.println(boardNo + "<-- boardNo");
	
	if(commentDao.deleteComment(commentNo)) {
		System.out.println("댓글삭제성공");
	}

	response.sendRedirect("./selectBoardOne.jsp?boardNo="+boardNo);
%>
</body>
</html>