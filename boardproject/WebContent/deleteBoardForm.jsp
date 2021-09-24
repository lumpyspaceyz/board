<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
a, a:hover {
	color: #fff;
}
nav li {
	font-size: 1.3em;
	padding-left: 20px;
}
</style>
</head>
<body>
<div class="container">
<%
	request.setCharacterEncoding("utf-8");

	BoardDao boardDao = new BoardDao();

	// 방어코드
	if(request.getParameter("boardNo") == null) {
		response.sendRedirect("./selectBoardList.jsp?currentPage=1");
		return;
	}
	
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	// debug
	System.out.println(boardNo + "<-- boardNo");

	ArrayList<String> boardCategoryList = boardDao.selectBoardCategoryList(); // 카테고리 불러오기	
%>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<a class="navbar-brand btn font-weight-bold" href="./selectBoardList.jsp">전체보기</a>
		<ul class="navbar-nav">
<%
			for(String category : boardCategoryList) {
%>
		  <li class="nav-item">
		    <a class="nav-link" href="./selectBoardList.jsp?boardCategory=<%=category%>"><%=category%></a>
		  </li>
<%
			}
%>
		</ul>
	</nav>
	
	<div class="jumbotron">
		<h1>게시글 삭제하기</h1>
   </div>	
<%
	Board board = boardDao.selectBoardOne(boardNo); // 삭제할 게시글 내용 불러오기
%>
	<div class="font-weight-bold">
		<h5>정말 삭제하시겠습니까?</h5>
	</div>
	<form action="./deleteBoardAction.jsp?boardNo=<%=boardNo %>" method="post">

		<div class="container p-3 my-3 border">
			<table class="table table-borderless table-hover text-center">
				<thead>
					<tr class="border-bottom font-weight-bold">
						<td>boardNo</td>
						<td>boardCategory</td>
						<td>boardTitle</td>
						<td>boardContent</td>
						<td>boardDate</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><%=boardNo%></td>
						<td><%=board.getBoardCategory()%></td>
						<td><%=board.getBoardTitle()%></td>
						<td><%=board.getBoardContent()%></td>
						<td><%=board.getBoardDate()%></td>
					</tr>
				</tbody>
			</table>
		</div>
			
		<div class="text-center">
			<input type="submit" value="삭제" class="btn btn-outline-dark">
			<a href="./selectBoardOne.jsp?boardNo=<%=boardNo %>" class="btn btn-outline-dark">취소</a>
		</div>
	</form>
	<div class="container pt-3"></div>
	<div class="container pt-3"></div>
	<div class="container pt-3"></div>
</div>
</body>
</html>