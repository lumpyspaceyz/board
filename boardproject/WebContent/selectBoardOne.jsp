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
	CommentDao commentDao = new CommentDao();

	if(request.getParameter("boardNo") == null) {
		response.sendRedirect("./selectBoardList.jsp?currentPage=1");
		return;
	}

	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	// debug
	System.out.println(boardNo + " <-- boardNo");
		
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
		<h1>게시글 상세보기</h1>
    </div>
	
<%
	Board board = boardDao.selectBoardOne(boardNo); // 게시글 내용 불러오기
%>
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
				<tr class="border-bottom">
					<td><%=boardNo%></td>
					<td><%=board.getBoardCategory()%></td>
					<td><%=board.getBoardTitle()%></td>
					<td><%=board.getBoardContent()%></td>
					<td><%=board.getBoardDate()%></td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="text-right">
		<a href="./updateBoardForm.jsp?boardNo=<%=boardNo %>" class="btn btn-outline-dark">수정</a>
		<a href="./deleteBoardForm.jsp?boardNo=<%=boardNo %>" class="btn btn-outline-dark">삭제</a>
		<a href="./selectBoardList.jsp?currentPage=1" class="btn btn-outline-dark">목록</a>
	</div>
	
	<div class="container pt-3"></div>
	<div class="container pt-3"></div>
		
	<!-- 댓글 partial -->
	<div class="container p-3 my-3 border">
		<form action="./insertCommentAction.jsp" method="post">
			<input type="hidden" name="boardNo" value="<%=boardNo%>">
			<div class="form-group">
				<br>
				<label for="comment">Comment : </label>
				<textarea name="commentContent" class="form-control" rows="5"></textarea>
			</div>
			<div class="text-right">
				<button class="btn btn-sm btn-outline-dark" type="submit">댓글입력</button>
			</div>
		</form>

	<div class="container pt-3"></div>
	
	<!--  댓글 목록 -->
	<label>Comment list : </label>
	<div class="text-center">
<%
	// 댓글 페이징
	int commentCurrentPage = 1; // 현재 페이지
	if(request.getParameter("commentCurrentPage") != null) {
		commentCurrentPage = Integer.parseInt(request.getParameter("commentCurrentPage"));
	}

	int commentRowPerPage = 5; // 페이징 수 설정
	
	int nowPage = (commentCurrentPage / commentRowPerPage) + 1; // 현재 시작 페이징(=commentFirst)을 계산하기 위한 변수
	
	int commentBeginRow = (commentCurrentPage-1) * commentRowPerPage;
	
	int commentFirst = (nowPage * commentRowPerPage) - (commentRowPerPage-1); // 현재 시작 페이징 번호
		if(request.getParameter("commentFirst") != null) {
			commentFirst = Integer.parseInt(request.getParameter("commentFirst"));
		}
	
	// debug
	System.out.println("디버깅 ----------------------");
	System.out.println(commentCurrentPage + "<-- 현재 페이지");
	System.out.println(nowPage + "<-- nowPage");
	System.out.println(commentBeginRow + "<-- commentBeginRow");
	System.out.println(commentFirst + "<-- 현재 시작 페이징 번호");
	
	ArrayList<Comment> commentList = commentDao.selectCommentListByPage(boardNo, commentRowPerPage, commentCurrentPage); // 댓글 목록 불러오기
	
%>
		<table class="table">
			<thead>
				<tr class="font-weight-bold">
					<td>번호</td>
					<td>commentContent</td>
					<td>commentDate</td>
					<td>delete</td>
				</tr>
			</thead>
			<tbody>
<%
				int no = 1 + commentBeginRow;
				for(Comment comment : commentList) {
%>
					<tr>
						<td><%=no%></td>
						<td><%=comment.commentContent %></td>
						<td><%=comment.commentDate%></td>
						<td><a href="./deleteCommentAction.jsp?commentNo=<%=comment.commentNo %>&boardNo=<%=boardNo %>" class="btn btn-outline-light text-dark">삭제</a></td>
						<!-- 댓글 삭제 후 다시 boardOne으로 되돌아오기 위해서 boardNo도 함께 넘겨준다 -->
					</tr>
<%		
					no++;
				}
%>
			</tbody>
		</table>
		
		<!-- 댓글 페이징 -->
		<div class="text-center">
<%
				int commentTotalCount = commentDao.selectCommentTotalCount(boardNo); // 댓글 총 개수
				
				// 마지막 페이지 정보
				int commentLastPage = commentTotalCount / commentRowPerPage;
				if(commentTotalCount % commentRowPerPage != 0) {
					commentLastPage++;	// lastPage+=1
				}
				
					// 디버깅
					System.out.println(commentTotalCount + "<-- 총 댓글 수");
					System.out.println(commentLastPage + "<-- 마지막 페이지");
				
				if(commentCurrentPage > commentRowPerPage) {	// 현재 페이지 번호(commentCurrentPage)가 페이징 수(commentRowPerPage)보다 크면 commentRowPerPage씩 넘어갈 수 있는 이전 버튼 활성화
%>
				<a href="./selectBoardOne.jsp?boardNo=<%=boardNo %>&commentCurrentPage=1" class="btn btn-sm btn-outline-dark">≪</a>
				<a href="./selectBoardOne.jsp?boardNo=<%=boardNo %>&commentCurrentPage=<%=commentCurrentPage - commentRowPerPage %>&commentFirst=<%=commentFirst - commentRowPerPage %>" class="btn btn-sm btn-outline-dark">＜</a>
				<!-- 현재 페이지, 시작 페이징: 페이징 수 만큼 빼서 전달 -->
<%		
				}
	
				for(int i=commentFirst; i<commentFirst+commentRowPerPage; i++) {
					if((commentLastPage+1) == i) {	// 마지막 페이지면 for문 빠져나가기
						break;
					} else if(commentCurrentPage == i) {	// 현재 선택한 페이지 -> btn-dark
%>	
						<a href="./selectBoardOne.jsp?boardNo=<%=boardNo %>&commentCurrentPage=<%=i%>&commentFirst=<%=commentFirst%>" class="btn btn-sm btn-dark"><%=i%></a>
					
<%
					} else {	// 현재 선택하지 않은 페이지 -> btn-outline-dark
%>
						<a href="./selectBoardOne.jsp?boardNo=<%=boardNo %>&commentCurrentPage=<%=i%>&commentFirst=<%=commentFirst%>" class="btn btn-sm btn-outline-dark"><%=i%></a>
<%
						
					}
				}
				
				// 현재 페이지가 마지막 페이지보다 작고 && 마지막 페이지가 페이징 수보다 클 때 다음,끝으로 버튼 활성화
				if(commentCurrentPage < commentLastPage && commentRowPerPage < commentLastPage) { 
%>
				<a href="./selectBoardOne.jsp?boardNo=<%=boardNo %>&commentCurrentPage=<%=commentCurrentPage + commentRowPerPage %>&commentFirst=<%=commentFirst + commentRowPerPage %>" class="btn btn-sm btn-outline-dark">＞</a>
				<!-- 현재 페이지, 시작 페이징: 페이징 수 만큼 더해서 전달 -->
				
				<a href="./selectBoardOne.jsp?boardNo=<%=boardNo %>&commentCurrentPage=<%=commentLastPage%>" class="btn btn-sm btn-outline-dark">≫</a>
<%
				}
%>
		</div>
		
		</div>

	</div>
	<div class="container pt-3"></div>
</div>
</body>
</html>