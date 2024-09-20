<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>EL 연산</h1>
	
	<h3>1. 산술 연산</h3>
	
	기존 방식(el X) : <%= (int)request.getAttribute("big") + (int)request.getAttribute("small") %> <br><br>
	
	el 방식 <br>
	ㄴ 10 + 3 = ${ big + small } <br>
	ㄴ 10 - 3 = ${ big - small } <br>
	ㄴ 10 x 3 = ${ big * small } <br>
	ㄴ 10 / 3 = ${ big / small } 또는 ${ big div small } <br>
	ㄴ 10 % 3 = ${ big % small } 또는 ${ big mod small } <br>
 	
 	<h3>2. 대소 비교 연산</h3>
 	
 	10 &gt; 3 = ${ big > small } 또는 ${ big gt small } <br>
 	10 &lt; 3 = ${ big < small } 또는 ${ big lt small } <br>
 	10 &gt;= 3 = ${ big >= small } 또는 ${ big ge small } <br>
 	10 &lt;= 3 = ${ big <= small } 또는 ${ big le small } <br><br>
 	
 	<h3>3. 동등 비교 연산</h3>
 	
 	<!-- el에서의 == 비교는 자바에서의 equals()와 같은 동작을 함 -->
 	sOne과 sTwo가 일치합니까? : ${ sOne == sTwo } 또는 ${ sOne eq sTwo } <br>
 	sOne과 sTwo가 불일치합니까? : ${ sOne != sTwo } 또는 ${ sOne ne sTwo } <br>

	<h3>4. 객체가 null인지 또는 리스트가 비어있는지 비교</h3>
	
	pTwo가 null입니까? : ${ pTwo == null } 또는 ${ empty pTwo } <br>
	pOne이 null입니까? : ${ pOne == null } 또는 ${ empty pOne } <br>
	pOne이 null이 아닙니까? : ${ pOne != null } 또는 ${ !empty pOne } 또는 ${ not empty pOne } <br><br>

	lOne이 텅비었습니까? : ${ empty lOne } <br><br>
	
	<h3>5. 논리 연산</h3>
	${ true && true } 또는 ${ true and true } <br>
	${ false || true } 또는 ${ false or true } <br><br>
	
	big이 small보다 크고 lOne이 텅비었습니까? : ${ big gt small and empty lOne } <br>

</body>
</html>