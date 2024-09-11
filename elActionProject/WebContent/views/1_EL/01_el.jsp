<%@page import="com.kh.model.vo.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<% 
	String requestScope = (String)request.getAttribute("scope"); 
	String sessionScope = (String)session.getAttribute("scope"); 
	String applicationScope = (String)application.getAttribute("scope"); 
%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h3>1. 기존의 방식대로 스크립틀릿과 표현식을 이용해서 각 scope에 담긴값 출력</h3>

	<%-- 
	<%
		String classRoom = (String)request.getAttribute("classRoom");
		Person student = (Person)request.getAttribute("student");
		
		String academy = (String)session.getAttribute("academy");
		Person teacher = (Person)session.getAttribute("teacher");
	%>
	
	<p>
		학원명 : <%=academy %> <br>
		강의장 : <%=classRoom %> <br>
		강사 : <%=teacher.getName() %>, <%=teacher.getAge() %>, <%=teacher.getGender() %> <br> <br>
		수강생 정보 
		<ul>
			<li>이름 : <%=student.getName() %></li>
			<li>나이 : <%=student.getAge() %>살</li>
			<li>성별 : <%=student.getGender() %></li>
		</ul>
	</p>
	--%>
	
	<h3>2. EL을 이용해서 보다 쉽게 해당 Scope에 담긴값 출력</h3>
	<p>
		EL을 이용해서 getter를 통해 값을 가져올 필요없이 EL구문 내에 키값만 제시하면 접근가능
		기본적으로 EL은 JSP 내장객체를 구분하지않고 자동으로 모든 내장객체의 키값을 
		검색해서 존재하는 경우에 값을 가져옴 (getAttribute 필요없다!)
	</p>
	
	<p>
		학원명 : ${academy} <br>
		강의장 : ${classRoom} <br>
		강사 : ${ teacher.name }, ${ teacher.age }, ${ teacher.gender } <br> <br>
		
		<!-- 
			teacher에 접근하면 밸류값은 Person객체임
			해당 Person 객체의 필드에 담긴 값을 출력할때, .필드명으로 접근
			=> 내부적으로 getter 메소드를 찾아서 실행되기에 EL을 쓸때도
			   getter/setter 생성 필수
		 -->		
		 
		수강생정보
		<ul>
			<li>이름 : ${ student.name }</li>
			<li>나이 : ${ student.age }살</li>
			<li>성별 : ${ student.gender }</li>
		</ul>
		 
	</p>
	
	<h3>3. 단, EL 사용시 내장 객체들에 저장된 키값이 동일할 경우</h3>
	scope 값 : ${ scope } <br>
	<!-- 
		EL은 공유범위가 제일 작은 scope에서부터 해당 키값을 검색
		page < request < session < application
		
		만일, 모든 영역에서 해당 키값이 없을경우 => 아무것도 출력하지 않음(오류x)
	 -->
	test 값 : ${ test } <br>
	 
	<h3>4. 직접 Scope를 지정해서 접근하기</h3>
	
		<%
		// pageScope에 담기
		pageContext.setAttribute("scope", "page");
		%>
	
	scope 값 : ${ scope } <br>
	각 내장객체의 scope값 : ${ pageScope.scope }, ${ requestScope.scope }, ${ sessionScope.scope }, ${ applicationScope.scope } <br><br> 
		
	<!-- 
		각 영역에 중복된 키값으로 데이터를 저장했다면
		Scope를 직접 지정해서 키값 제시하는게 제일 정확
		
		키값만을 제시하면 의도치않은 데이터를 가져올수 있음
	 -->
		
	잘못접근예시 (session에서 classRoom) : ${ sessionScope.classRoom } <br>
	제대로 가져오려면 => ${ classRoom } or ${ requestScope.classRoom } <br><br>
		
		
</body>
</html>