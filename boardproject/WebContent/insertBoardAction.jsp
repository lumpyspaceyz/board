<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	BoardDao boardDao = new BoardDao();

	String boardTitle = request.getParameter("boardTitle");
	String boardCategory = request.getParameter("boardCategory");
	String boardContent = request.getParameter("boardContent");
	// debug
	System.out.println(boardTitle + "<-- boardTitle");
	System.out.println(boardCategory + "<-- boardCategory");
	System.out.println(boardContent + "<-- boardContent");
	
	Board board = null;
	board = new Board();
	board.setBoardTitle(boardTitle);
	board.setBoardCategory(boardCategory);
	board.setBoardContent(boardContent);
	
	if(boardDao.insertBoard(board)){
		System.out.println("게시글입력성공");
		response.sendRedirect("./selectBoardList.jsp?currentPage=1");
	}
%>
</body>
</html>




