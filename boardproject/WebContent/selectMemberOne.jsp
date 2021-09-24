<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
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
		<h1>회원정보 조회</h1>
    </div>
<%
	request.setCharacterEncoding("utf-8");
	MemberDao memberDao = new MemberDao();
	
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect("./index.jsp");
		return;
	}
	Member sessionMember = (Member)session.getAttribute("loginMember");
	Member member = memberDao.selectMemberOne(sessionMember);
	// debug
	System.out.println(member.getMemberId() + "<-- loginMemberId");
%>
	<div class="container p-3 my-3 border">
		<table class="table table-borderless table-hover text-center">
			<thead>
				<tr class="border-bottom font-weight-bold">
					<td>memberId</td>
					<td>memberPw</td>
					<td>memberName</td>
					<td>memberAge</td>
					<td>memberGender</td>
					<td>memberDate</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=member.getMemberId() %></td>
					<td><%=member.getMemberPw() %></td>
					<td><%=member.getMemberName() %></td>
					<td><%=member.getMemberAge()%></td>
					<td><%=member.getMemberGender() %></td>
					<td><%=member.getMemberDate() %></td>
	
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="text-right">
		<a href="./updateMemberForm.jsp" class="btn btn-outline-dark">회원정보수정</a>
		<a href="./deleteMemberForm.jsp" class="btn btn-outline-dark">회원탈퇴</a>
		<a href="./selectBoardList.jsp?currentPage=1" class="btn btn-outline-dark">목록</a>
	</div>
</div>
</body>
</html>