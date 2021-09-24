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

	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String commentContent = request.getParameter("commentContent");
	// debug
	System.out.println(boardNo + "<-- boardNo");
	System.out.println(commentContent + "<-- commentContent");
	
	Comment comment = null;
	comment = new Comment();
	comment.boardNo = boardNo;
	comment.commentContent = commentContent;
	if(commentDao.insertComment(comment)) {
		System.out.println("댓글입력성공");
		response.sendRedirect("./selectBoardOne.jsp?boardNo="+boardNo);
	}
%>
</body>
</html>




