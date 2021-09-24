<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
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

	BoardDao boardDao = new BoardDao();
	
	// 방어코드
	if(request.getParameter("boardNo") == null
		|| request.getParameter("boardCategory") == null
		|| request.getParameter("boardTitle") == null
		|| request.getParameter("boardContent") == null) {
		response.sendRedirect("./selectBoardList.jsp?currentPage=1");
		System.out.println("수정이 정상적으로 이루어지지 않았습니다.");
		return;
	}
	
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardCategory = request.getParameter("boardCategory");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	// debug
	System.out.println(boardNo + "<-- boardNo");
	System.out.println(boardCategory + "<-- boardCategory");
	System.out.println(boardTitle + "<-- boardTitle");
	System.out.println(boardContent + "<-- boardContent");
	
	Board board = null;
	board = new Board();
	board.setBoardNo(boardNo);
	board.setBoardCategory(boardCategory);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	
	if(boardDao.updateBoard(board)) {
		System.out.println("정상적으로 수정되었습니다.");
		response.sendRedirect("./selectBoardOne.jsp?boardNo=" + boardNo);
	}
%>
</body>
</html>