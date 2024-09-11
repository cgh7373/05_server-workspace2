<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@
	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>JSTL Core Library</h1>

	<h3>1. 변수(속성 == attribute)</h3>
	<pre style="font-size:14px;">
 * 변수 선언과 동시에 초기화
  &lt;c:set var="" value="" [scope=""]&gt;
  
 - 변수 선언하고 초기값을 대입해두는 기능을 제공
 - 해당 변수를 어떤 scope에 담아둘건지 지정이 가능함 (생략시 pageScope가 default)
 
 => 즉, 해당 scope에 setAttribute를 통해서 key-value 형태로 데이터를 담아두는것
 => c:set 으로 선언된 변수는 EL로 접근해서 사용가능 (스크립틀릿 ㄴㄴ)
 
 - 변수 타입을 별도로 지정하지 않음
 - 초기값을 반드시 지정해야함!!
	</pre>
	
	<c:set var="num1" value="10" /> <!-- pageContext.setAttribute("num1", "10);이 된것과 같다 -->
	<c:set var="num2" value="20" scope="request" /> <!-- request.setAttribute("num1", "10);이 된것과 같다 -->
	
	num1 변수값 : ${ num1 } <br>
	num2 변수값 : ${ num2 } <br>
	
	<c:set var="result" value="${num1 + num2}" scope="session" />
	result 변수값 : ${ result } <br><br>
	
	<!-- value 속성 대신에 시작태그와 종료태그 사이에 초기값 지정가능 -->
	<c:set var="result" scope="request">
		999999999
	</c:set>
	request의 result값 : ${ requestScope.result }
	
	<hr>
	
	<pre style="font-size:14px;">
 * 변수 삭제 
  &lt;c:remove var="제거할변수명" [scope=""]&gt;

 - 해당 scope 영역에서 해당 변수를 찾아서 제거하는 태그
 - scope 지정 생략시 모든 scope에서 해당 변수를 제거
 
 => 즉, 해당 scope에 .removeAttribute()를 통해 제거하는것과 동일
	</pre>
	
	삭제전 result : ${ result } <br><br>
	
	1) 특정 scope 지정해서 삭제 <br>
	<c:remove var="result" scope="request" />
	requestScope의 result 삭제 후 : ${ result } <br><br>
	
	2) 모든 scope에서 삭제 <br>
	<c:remove var="result"/>
	모든 result 삭제 후 : ${ result } <br>
	
	<hr>
	
	<pre style="font-size:14px;">
 * 변수(데이터) 출력
  &lt;c:out value="출력할 값" [default="기본값"] [escapeXml="true|false"]&gt;
 
 - 데이터를 출력하고자 할때 사용하는 태그
	</pre>
	
	result : <c:out value="${result}" /> <br>
	result : <c:out value="${result}" default="값 없음"/> <br><br>
	
	<c:set var="outTest" value="<b>출력테스트</b>" />
	
	<c:out value="${outTest}" /> <!-- escapeXml 생략시 기본값 true --> <br>
	<c:out value="${outTest}" escapeXml="false" /> 
	
	<hr>
	
	<h3>2. 조건문 - if &lt;c:if test="조건"&gt;</h3>
	
	<pre style="font-size:14px;">
 - JAVA의 if문과 비슷한 역할을 하는 태그
 - 조건식은 test 속성에 작성 (단, EL구문으로 기술해야함)
	</pre>
	
	<c:if test="${ num1 gt num2 }">
		<b>num1이 num2보다 큽니다.</b>
	</c:if> 	
	
	<c:if test="${ num1 le num2 }">
		<b>num1이 num2보다 작거나 같습니다.</b>
	</c:if>
	
	<br>
	
	<c:set var="str" value="안녕하세요"/>
	
	<c:if test="${ str eq '안녕하세요' }">
		<h4>Hello World</h4>
	</c:if>
	
	<c:if test="${ str ne '안녕하세요' }">
		<h4>Bye World</h4>
	</c:if>
	

</body>
</html>