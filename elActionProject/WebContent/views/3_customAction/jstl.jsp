<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>JSTL이란?</h1>
	<p>
		JSP Standard Tag Library의 약자로 JSP에서 사용되는 커스텀 액션태그 <br>
		자주 사용되는 코드들을 집합, 태그화하여 표준으로 제공하는 라이브러리 <br>
	</p><br>
	
	<h3>* 라이브러리 다운로드 후 추가</h3>
	1) 아파치톰캣 사이트 접속 <br>
	2) 메뉴바 Taglibs 접속 <br>
	3) 4개의 라이브러리 다운로드 <br>
	4) WEB-INF/lib/ 에 추가 <br><br> 

	<h3>* JSTL 선언 방법</h3>
	<p>
		JSTL을 사용하고자 하는 해당 jsp 페이지의 상단에 <br>
		taglib 지시어를 사용해서 선언함 <br><br>
		
		&lt;%@ taglib prefix="접두어" uri="라이브러리 파일상에 uri주소" %&gt;
	</p><br>
	
	<h4>1. JSTL Core Library</h4>
	<p>
		변수와 조건문/반복문 등의 로직과 관련된 문법을 제공
	</p>
	<a href="01_core.jsp">Core Library</a>








</body>
</html>