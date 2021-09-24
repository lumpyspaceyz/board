<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div class="jumbotron">
		<h1>홈페이지</h1>
    </div>
	<%
		if(session.getAttribute("loginMember") == null) {
	%>
			<!-- 로그인 전  -->
			<div><a href="./loginForm.jsp">로그인</a></div>
			<div><a href="./insertMemberForm.jsp">회원가입</a></div><!-- insertMemberAction.jsp -->
	<%		
		} else {
			Member loginMember = (Member)session.getAttribute("loginMember");
	%>
			<!-- 로그인 -->
			<div><%=loginMember.getMemberName()%>님 반갑습니다.</div>
			<div><a href="./logout.jsp">로그아웃</a></div>
			<div><a href="./selectMemberOne.jsp">회원정보</a></div>
			<div><a href="./updateMemberForm.jsp">회원정보 수정</a></div>
			<div><a href="./deleteMemberForm.jsp">회원탈퇴</a></div>
	<%	
		}
	%>
	<div><a href="./selectBoardList.jsp">게시판</a></div>
</div>
</body>
</html>