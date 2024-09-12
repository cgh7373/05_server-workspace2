<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h3>jsp:include</h3>
	<p>
		또다른 페이지를 포함하고자 할때 쓰는 태그
	</p>
	
	<h4>1. 기존의 include 지시어 이용한 방식 (정적 include 방식 == 컴파일시 포함이 되는 형태)</h4>

	<%-- 
	<br>
	
	특징 : include 하고있는 페이지상의 변수를 현재의 페이지에서도 사용가능 <br>
	year from footer : <%=year%> <br><br>
	
	=> 단, 현재 페이지에서 동일한 이름의 변수를 선언할수 없음 <br>
	--%>
	 
	<h4>2. JSP 표준 액션 태그를 이용한 방식 (동적 include 방식 == 런타임시 포함되는 형태)</h4>

	<jsp:include page="footer.jsp" /> <br>

	특징 1 : include 하고있는 페이지에 선언된 변수를 공유하지 않음 <br>
	 => 동일한 이름의 변수 재선언 가능
	 <% int year = 2025; %>
	 
	<br><br> 

	특징 2 : 포함시 include하는 페이지로 값 전달할수 있음
	<jsp:include page="footer.jsp">
		<jsp:param name="test" value="Hello" />
	</jsp:include>
	
	<jsp:include page="footer.jsp">
		<jsp:param name="test" value="Bye" />
	</jsp:include>


</body>
</html>