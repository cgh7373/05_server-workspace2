<%@ page language="java" contentType="text/html; charset=UTF-8"

pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>로그인 테스트</title>

</head>

<body>

<c:choose>

	<c:when test="${empty loginMember}">
	
		<form action="login" method="post">
		
			<label> ID : </label> <input type="text" name="memberId"> <br>
			
			<label>PWD : </label> <input type="password" name="memberPwd"> <br>
			
			<button>로그인</button>
			
		</form>
		
	</c:when>
	
	<c:otherwise>
	
		<h3>${loginUser.memberName} 님 환영합니다.</h3>
	
	</c:otherwise>
	
</c:choose>

</body>

</html>