<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 로그인 상태에서는 페이지 접근불가
	if(session.getAttribute("loginMember") != null) {
		// 다시 브라우저에게 다른곳을 요청하도록 하는 메서드
		// 보내는 게 아님. 다른곳을 호출하도록 하는 것.
		response.sendRedirect("./index.jsp");
		return;
	}
%>
	<h1>회원가입</h1>
	<form method="post" action="./insertMemberAction.jsp">
		<!-- memberId -->
		<div>아이디 : </div>
		<div><input type="text" name="memberId"></div>
		<!-- memberPw -->
		<div>비밀번호 : </div>
		<div><input type="password" name="memberPw"></div>
		<!-- memberName -->
		<div>이름 : </div>
		<div><input type="text" name="memberName"></div>
		<!-- memberAge -->
		<div>나이 : </div>
		<div><input type="text" name="memberAge"></div>
		<!-- memberGender -->
		<div>성별 : </div>
		<div>
			<input type="radio" name="memberGender" value="남"> 남
			<input type="radio" name="memberGender" value="여"> 여
		</div>
		<br>
		<div>
			<button type="submit">회원가입</button>
		</div>
	</form>
</body>
</html>