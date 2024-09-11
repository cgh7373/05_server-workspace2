<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1> * EL (Expression Language) 표현언어</h1>
	<p>
		기존에 사용했던 표현식(출력식:스크립틀릿) &lt;%=name%&gt; 같이 <br>
		JSP상에서 표현하려는 값을 \${ 변수/메소드 } 의 형식으로 표현하는것
	</p>
	
	<h4><a href="el.do">01_EL의 기본구문</a></h4>
	
	<h4><a href="operator.do">02_EL의 연산자</a></h4>
	
	<hr>
	
	<!-- 
	
		* JSP를 이루는 구성인자
		
		1. 스크립팅 원소 : JSP페이지에서 자바코드를 직접 기술할수 있게 기능
						ex) 스크립틀릿, 표현식(출력식) 등등
						
		2. 지시어 : JSP페이지 정보에 대한 내용을 표현하거나 또다른 페이지를 포함할때 사용
				  JSP 기능을 확장시키는 라이브러리 등록할때도 사용
				  ex) page지시어, include지시어, taglib 지시어
				  
		3. 액션태그 (표준액션태그, 커스텀액션태그) : xml 기술을 이용해서 기존의 jsp문법을
		                                    확장하는 기술을 제공하는 태그
		                                    
		    >> 표준 액션 태그     	 : JSP페이지에서 바로사용가능 
		  (Standard Action Tag)	   모든 태그명 앞에 jsp: 접두어 붙음								
		    
		    >> 커스텀 액션 태그		: 별도의 라이브러리 연동 필요
		  (Custom Action Tag)  	  모든 태그명 앞에 jsp: 외의 접두어가 붙음
		  						  가장 대표적인 라이브러리 == JSTL
		  
	 -->

	<h1>JSP Action Tag</h1>
	<p>
		XML 기술을 이용해서 기존의 jsp문법을 확장시키는 기술을 제공하는 태그들
	</p>

	<h3>1. 표준 액션 태그</h3>
	<a href="views/2_standardAction/01_include.jsp">01_jsp:include</a> <br><br>
	<a href="views/2_standardAction/02_forward.jsp">02_jsp:forward</a> <br><br>

	<h3>2. 커스텀 액션 태그 (JSTL)</h3>
	<a href="views/3_customAction/jstl.jsp">JSTL</a>




</body>
</html>