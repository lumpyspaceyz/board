<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
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
	String boardCategory = "";
	if(request.getParameter("boardCategory") != null) {
		boardCategory = request.getParameter("boardCategory");
	}
	// boardCategory는 null or "csharp", "css", ...
	// null이면 전체 select
	// null이 아니면 boardCategory만 select
	
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
	  <h1>글입력</h1>
	  <p>
	  	csharp, html, java ..
	  	<div><a href="./selectBoardList.jsp" class="btn btn-warning">목록보기</a></div>
	  </p>
	</div>
	
	<form action="./insertBoardAction.jsp" method="post">
		<table class="table table-striped">
			<tr>
			<th class=" text-center">boardTitle : </th>
			<td><input type="text" name="boardTitle" id="boardTitle"></td>
			</tr>
			
			<tr>
			<th class=" text-center">boardCategory : </th>
			<td>
				<select name="boardCategory">
					<option value="csharp">csharp</option>
					<option value="css">css</option>
					<option value="html">html</option>
					<option value="java">java</option>
					<option value="javascript">javascript</option>
					<option value="jpa">jpa</option>
					<option value="jquery">jquery</option>
					<option value="mybatis">mybatis</option>
					<option value="python">python</option>
					<option value="spring">spring</option>
					<option value="sql">sql</option>
				</select>
			</td>
			</tr>
			
			<tr>
			<th class=" text-center">boardContent : </th>
			<td><textarea name="boardContent" id="boardContent" rows="5" cols="50"></textarea></td>
			</tr>			
		</table>
		
		<div class="text-center">
			<input type="submit" value="글입력" class="btn btn-outline-dark">
			<a href="./selectBoardList.jsp?currentPage=1" class="btn btn-outline-dark">취소</a>
		</div>
	</form>
</div>
</body>
</html>