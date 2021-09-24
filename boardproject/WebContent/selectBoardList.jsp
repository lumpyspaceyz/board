<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
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

	String boardCategory = "";
	if(request.getParameter("boardCategory") != null) {
		boardCategory = request.getParameter("boardCategory");
	}
	// boardCategory는 null or "csharp", "css", ...
	// null이면 전체 select
	// null이 아니면 boardCategory만 select
	
	BoardDao boardDao = new BoardDao();
	ArrayList<String> boardCategoryList = boardDao.selectBoardCategoryList();

	// 페이징
	int currentPage = 1; // 현재 페이지
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	int rowPerPage = 10; // 페이징 수 설정
	
	int nowPage = (currentPage / rowPerPage) + 1; // 현재 시작 페이징(=first)을 계산하기 위한 변수
	
	int beginRow = (currentPage-1) * rowPerPage;
	
	int first = (nowPage * rowPerPage) - (rowPerPage-1); // 현재 시작 페이징 번호
		if(request.getParameter("first") != null) {
			first = Integer.parseInt(request.getParameter("first"));
		}
	
	// 디버깅
	System.out.println("디버깅 ----------------------");
	System.out.println(currentPage + "<-- 현재 페이지");
	System.out.println(nowPage + "<-- nowPage");
	System.out.println(beginRow + "<-- beginRow");
	System.out.println(first + "<-- 현재 시작 페이징 번호");
	
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
	
	<div>
		<!-- 본문내용 -->
		<%
			ArrayList<Board> boardList = boardDao.selectBoardListByPage(boardCategory, currentPage, rowPerPage);
		%>
		<div class="jumbotron">
		  <h1>전체 게시글 목록</h1>
		  <p>
		  	csharp, html, java ..
		  	<div><a href="./insertBoardForm.jsp" class="btn btn-warning">글입력</a></div>
		  </p>
		</div>
	
		<table class="table table-dark table-striped table-hover text-center">
			<thead>
				<tr class="font-weight-bold">
					<th>번호</th>
					<th>board_no</th>
					<th>board_category</th>
					<th>board_title</th>
				</tr>
			</thead>
			<tbody>
<%
				int no = 1 + beginRow;
				for(Board board : boardList) {
%>
					<tr>
						<td><%=no%></td>
						<td><%=board.getBoardNo() %></td>
						<td><%=board.getBoardCategory() %></td>
						<td><a href="./selectBoardOne.jsp?boardNo=<%=board.getBoardNo()%>"><%=board.getBoardTitle()%></a></td>
					</tr>
<%		
					no++;
				}
%>
			</tbody>
		</table>
		
	<!-- 페이징 -->
	<div class="text-center">
<%
			int totalCount = boardDao.selectTotalCount(boardCategory);
			if(boardCategory.equals("")) {
				// 마지막 페이지 정보
				int lastPage = totalCount / rowPerPage;
				if(totalCount % rowPerPage != 0) {
					lastPage++;	// lastPage+=1
				}
				
				// 디버깅
				System.out.println(totalCount + "<-- 전체 총 게시글 수");
				System.out.println(lastPage + "<-- 마지막 페이지");
				
				if(currentPage > rowPerPage) {	// 현재 페이지 번호(currentPage)가 페이징 수(rowPerPage)보다 크면 rowPerPage씩 넘어갈 수 있는 이전 버튼 활성화
%>
				<a href="./selectBoardList.jsp?currentPage=1" class="btn btn-outline-dark">처음으로</a>
				<a href="./selectBoardList.jsp?currentPage=<%=currentPage - rowPerPage %>&first=<%=first - rowPerPage %>" class="btn btn-outline-dark">이전</a>
				<!-- 현재 페이지, 시작 페이징: 페이징 수 만큼 빼서 전달 -->
<%		
				}

				for(int i=first; i<first+rowPerPage; i++) {
					if((lastPage+1) == i) {	// 마지막 페이지면 for문 빠져나가기
						break;
					} else if(currentPage == i) {	// 현재 선택한 페이지 -> btn-dark
%>	
						<a class="btn btn-dark" href="./selectBoardList.jsp?currentPage=<%=i %>&first=<%=first%>"><%=i %></a>
<%
					} else {	// 현재 선택하지 않은 페이지 -> btn-outline-dark
%>
						<a href="./selectBoardList.jsp?currentPage=<%=i %>&first=<%=first%>" class="btn btn-outline-dark"><%=i %></a>
<%
					}
				}
				
				if(currentPage < lastPage && rowPerPage < lastPage) {
%>
				<a href="./selectBoardList.jsp?currentPage=<%=currentPage + rowPerPage %>&first=<%=first + rowPerPage %>" class="btn btn-outline-dark">다음</a>
				<!-- 현재 페이지, 시작 페이징: 페이징 수 만큼 더해서 전달 -->
				
				<a href="./selectBoardList.jsp?currentPage=<%=lastPage %>" class="btn btn-outline-dark">끝으로</a>
				</td>
<%
				}
			} else {				
				// 마지막 페이지 정보
				int lastPage = totalCount / rowPerPage;
				if(totalCount % rowPerPage != 0) {
					lastPage++;	// lastPage+=1
				}
				
					// 디버깅
					System.out.println(totalCount + "<-- 카테고리별 총 게시글 수");
					System.out.println(lastPage + "<-- 마지막 페이지");
				
				if(currentPage > rowPerPage) {	// 현재 페이지 번호(currentPage)가 페이징 수(rowPerPage)보다 크면 rowPerPage씩 넘어갈 수 있는 이전 버튼 활성화
%>
				<a href="./selectBoardList.jsp?currentPage=1&boardCategory=<%=boardCategory %>" class="btn btn-outline-dark">처음으로</a>
				<a href="./selectBoardList.jsp?currentPage=<%=currentPage - rowPerPage %>&first=<%=first - rowPerPage %>&boardCategory=<%=boardCategory %>" class="btn btn-outline-dark">이전</a>
				<!-- 현재 페이지, 시작 페이징: 페이징 수 만큼 빼서 전달 -->
<%		
				}
	
				for(int i=first; i<first+rowPerPage; i++) {
					if((lastPage+1) == i) {	// 마지막 페이지면 for문 빠져나가기
						break;
					} else if(currentPage == i) {	// 현재 선택한 페이지 -> btn-dark
%>	
						<a class="btn btn-dark" href="./selectBoardList.jsp?currentPage=<%=i %>&first=<%=first%>&boardCategory=<%=boardCategory %>"><%=i %></a>
					
<%
					} else {	// 현재 선택하지 않은 페이지 -> btn-outline-dark
%>
						<a href="./selectBoardList.jsp?currentPage=<%=i %>&first=<%=first%>&boardCategory=<%=boardCategory %>" class="btn btn-outline-dark"><%=i %></a>
<%
					}
				}
				// 현재 페이지가 마지막 페이지보다 작고 && 마지막 페이지가 페이징 수보다 클 때 다음/끝으로 버튼 활성화
				if(currentPage < lastPage && rowPerPage < lastPage) {
%>
				<a href="./selectBoardList.jsp?currentPage=<%=currentPage + rowPerPage %>&first=<%=first + rowPerPage %>&boardCategory=<%=boardCategory %>" class="btn btn-outline-dark">다음</a>
				<!-- 현재 페이지, 시작 페이징: 페이징 수 만큼 더해서 전달 -->
				
				<a href="./selectBoardList.jsp?currentPage=<%=lastPage %>&boardCategory=<%=boardCategory %>" class="btn btn-outline-dark">끝으로</a>
<%
				}

			}
%>		
		</div>
	</div>
</div>
</body>
</html>