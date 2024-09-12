<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h3>1. formatNumber</h3>
	<p>
		숫자데이터의 포맷 지정 <br>
		- 나타낼 숫자데이터의 형식을 통화기호, % 등 적절하게 형식을 지정하는 태그 <br>
		
		&lt;fmt:formatNumber value="값" [groupingUsed="true|false" type="percent|currency" currencySymbol="통화기호문자"]&gt; <br><br>
	</p>
	
	<c:set var="num1" value="123456789" />
	<c:set var="num2" value="0.75" />
	<c:set var="num3" value="50000" />
	
	그냥출력 : ${ num1 } <br>
	세자리마다 구분 : <fmt:formatNumber>${ num1 }</fmt:formatNumber> <br>
	숫자 그대로 출력 : <fmt:formatNumber value="${ num1 }" groupingUsed="false" /> <br><br>
	<!-- groupingUsed : 세자리마다 구분자(,) 여부지정. default는 true -->
	
	percent : <fmt:formatNumber value="${ num2 }" type="percent" /> <br>
	currency : <fmt:formatNumber value="${ num3 }" type="currency" /> <br>
	currency : <fmt:formatNumber value="${ num3 }" type="currency" currencySymbol="악;;" groupingUsed="false" /> <br>
	
	<br>
	<hr>
	
	<h3>2. formatDate</h3>
	<p>
		날짜 및 시간 데이터의 포맷 지정 (단, java.util.Date 객체 사용)
	</p>
	<c:set var="current" value="<%= new java.util.Date() %>" />
	
	그냥 출력 : ${ current } <br>
	
	<ul>
		<li>현재날짜 : <fmt:formatDate value="${current}"/></li> <!-- type 생략시 default는 date -->
		<li>현재시간 : <fmt:formatDate value="${current}" type="time"/></li>
		<li>둘 다 : <fmt:formatDate value="${current}" type="both"/> </li> <!-- date/timeStyle default가 medium이다 -->
		<li>Medium : <fmt:formatDate value="${current}" type="both" dateStyle="medium" timeStyle="medium"/> </li>
		<li>Long : <fmt:formatDate value="${current}" type="both" dateStyle="long" timeStyle="long"/></li>
		<li>Full : <fmt:formatDate value="${current}" type="both" dateStyle="full" timeStyle="full"/></li>
		<li>Short : <fmt:formatDate value="${current}" type="both" dateStyle="short" timeStyle="short"/></li>
		<li>내 패턴 : <fmt:formatDate value="${current}" type="both" pattern="yyyy-MM-dd(E) HH:mm:ss(a)"/> </li>
	</ul>
	
	
	

</body>
</html>