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

	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	// debug
	System.out.println(boardNo + "<-- boardNo");
	
	if(boardDao.deleteBoard(boardNo)) {
		System.out.println("정상적으로 삭제되었습니다.");
		response.sendRedirect("./selectBoardList.jsp?currentPage=1");
	}
%>
</body>
</html>