<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>JSTL Functions Library</h1>

	<c:set var="str" value="How are u?" />

	str : ${ str } <br><br>
	
	문자열의 길이 : ${ str.length() } <br>
	문자열의 길이 : ${ fn:length(str) } <br><br>
	
	모두 대문자로 출력 : ${ fn:toUpperCase(str) } <br>
	모두 소문자로 출력 : ${ fn:toLowerCase(str) } <br><br>

	are의 시작인덱스 : ${ fn:indexOf(str, "are") } <br><br>
 
	are => were 변경 : ${ fn:replace(str, "are", "were") } <br><br>

	<c:if test="${ fn:contains(str, 'are') }">
		포함되어있음
	</c:if>




</body>
</html>