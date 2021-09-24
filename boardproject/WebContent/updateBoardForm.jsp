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
	
	//방어코드
	if(request.getParameter("boardNo") == null) {
		response.sendRedirect("./selectBoardList.jsp?currentPage=1"); // 웹브라우저 주소창 주소를 강제로 이동
		System.out.println("수정이 정상적으로 이루어지지 않았습니다.");
		return;	// 메서드를 종료하는 명령어
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
		<h1>게시글 수정하기</h1>
   </div>	

<%	
	Board board = boardDao.selectBoardOne(boardNo); // 수정할 게시글 내용 불러오기
%>

	<form action="./updateBoardAction.jsp?boardNo=<%=boardNo %>" method="post">
		<table class="table table-striped">
			<tr>
			<th class="text-center">boardNo : </th>
			<td><input type="text" name="boardNo" id="boardNo" value=<%=board.getBoardNo() %> readonly="readonly"></td>
			</tr>			
<%
        String[] boardCategory = new String[11];
         if(board.getBoardCategory().equals("csharp")) {
        	 boardCategory[0] = "selected";
         } else if(board.getBoardCategory().equals("css")) {
        	 boardCategory[1] = "selected";
         } else if(board.getBoardCategory().equals("html")) {                       
        	 boardCategory[2] = "selected";
         } else if(board.getBoardCategory().equals("java")) {
        	 boardCategory[3] = "selected";
         } else if(board.getBoardCategory().equals("javascript")) {
        	 boardCategory[4] = "selected";
         } else if(board.getBoardCategory().equals("jpa")) {
        	 boardCategory[5] = "selected";
         } else if(board.getBoardCategory().equals("jquery")) {
        	 boardCategory[6] = "selected";
         } else if(board.getBoardCategory().equals("mybatis")) {
        	 boardCategory[7] = "selected";
         } else if(board.getBoardCategory().equals("python")) {
        	 boardCategory[8] = "selected";
         } else if(board.getBoardCategory().equals("spring")) {
        	 boardCategory[9] = "selected";
         } else if(board.getBoardCategory().equals("sql")) {
        	 boardCategory[10] = "selected";
         }
%>			
			<tr>
			<th class=" text-center">boardCategory : </th>
			<td>
				<select name="boardCategory">
					<option value="csharp" <%=boardCategory[0]%>>csharp</option>
					<option value="css" <%=boardCategory[1]%>>css</option>
					<option value="html" <%=boardCategory[2]%>>html</option>
					<option value="java" <%=boardCategory[3]%>>java</option>
					<option value="javascript" <%=boardCategory[4]%>>javascript</option>
					<option value="jpa" <%=boardCategory[5]%>>jpa</option>
					<option value="jquery" <%=boardCategory[6]%>>jquery</option>
					<option value="mybatis" <%=boardCategory[7]%>>mybatis</option>
					<option value="python" <%=boardCategory[8]%>>python</option>
					<option value="spring" <%=boardCategory[9]%>>spring</option>
					<option value="sql" <%=boardCategory[10]%>>sql</option>
				</select>
			</td>
			</tr>
			
			<tr>
			<th class=" text-center">boardTitle : </th>
			<td><input type="text" name="boardTitle" id="boardTitle" value=<%=board.getBoardTitle() %>></td>
			</tr>
			
			<tr>
			<th class=" text-center">boardContent : </th>
			<td><textarea name="boardContent" id="boardContent" rows="5" cols="50"><%=board.getBoardContent() %></textarea></td>
			</tr>		
			
			<tr>
			<th class=" text-center">boardDate : </th>
			<td><input type="text" name="boardDate" id="boardDate" value=<%=board.getBoardDate() %> readonly="readonly"></td>
			</tr>	
		</table>
		
		<div class="text-center">
			<input type="submit" value="수정" class="btn btn-outline-dark">
			<a href="./selectBoardOne.jsp?boardNo=<%=boardNo %>" class="btn btn-outline-dark">취소</a>
		</div>
	</form>
	<div class="container pt-3"></div>
</div>
</body>
</html>