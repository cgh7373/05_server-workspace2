<%@page import="com.kh.model.vo.Person"%>
<%@page import="java.util.ArrayList"%>
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
	<c:out value="${outTest}" escapeXml="false" /> <!-- true : text // false : html 이렇게보면될듯 -->
	
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
	
	<h3>3. 조건문 - Choose (c:choose, c:when, c:otherwise)</h3>
	<pre style="font-size:14px;">
 - JAVA의 if-else, if-else if문과 비슷한 역할을 하는 태그
 - 각 조건들을 c:choose의 하위요소로 c:when을 통해서 작성.. 마지막 else == c:otherwise
	</pre>

	<%--
	<% if (num1 > 20) { %>	
	~~~~~
	<% } else if (num1 >= 10) { %>
	~~~~~
	<% } else { %>
	~~~~~
	<% } %>
	--%>
	
	<c:choose>
		<c:when test="${ num1 gt 20 }"> <!-- 주석은 choose, then, otherwise 사이에 샌드위치돼있으면 안됨.. 이자리가맞다 -->
			<b>20보다 크다!</b>
		</c:when>
		
		<c:when test="${ num1 ge 10 }">
			<b>10보다는 크거나 같다!</b>
		</c:when>
		
		<c:otherwise>
			<b>10보다도 작다..</b>
		</c:otherwise>
	</c:choose>
	
	<hr>
	
	<h3>4. 반복문 - forEach</h3>
	<pre style="font-size:14px;">
 for loop문	- &lt;c:forEach var="변수명" begin="초기값" end="끝값" [step="반복증감값"]&gt;
 향상된 for문	- &lt;c:forEach var="변수명" items="배열/컬렉션" [varStatus="현재접근된요소의상태값을보관할변수명"]&gt; 
 
 var 속성으로 선언된 변수에 접근할때는 반드시 EL 구문으로 접근
	</pre>
	
	<% for (int i = 1; i <= 6; i++) { %>
		<h<%=i %>><%=i %>..태그안에서도 적용가능</h<%=i %>>
	<% } %>
	
	<br>
	
	<c:forEach var="i" begin="1" end="10" step="2">
		반복확인 : ${ i } <br>
	</c:forEach>
	
	<c:forEach var="i" begin="1" end="6">
		<h${i}>${i}..태그안에서도 적용가능</h${i}>
	</c:forEach>
	
	<c:set var="colors">
		red, yellow, green, pink
	</c:set>
	
	colors 변수값 : ${ colors } => 배열!<br>
	
	<ul>
		<c:forEach var="c" items="${colors}">
			<li style="color:${c}">${ c }</li>
		</c:forEach>
	</ul>
	
	<%
		ArrayList<Person> list = new ArrayList<Person>();
		list.add(new Person("차은우", 20, "남자"));
		list.add(new Person("카리나", 21, "여자"));
		list.add(new Person("아이유", 22, "여자"));
	%>
	
	<c:set var="pList" value="<%=list%>" scope="request" />
	
	<table border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>나이</th>
				<th>성별</th>
			</tr>
		</thead>
		
		<tbody>
		<%-- 
			<% if (pList.isEmpty()) { %>
			
			<% } else { %>
				<% for (Person p : pList) { %>
				
				<% } %>
			<% } %>
		--%>
		
		<c:choose>
			<c:when test="${ empty pList }">
				<tr>
					<td colspan="3">조회된 사람이 없습니다.</td>
				</tr>
			</c:when>
			
			<c:otherwise>
				<c:forEach var="p" items="${ pList }" varStatus="s">
					<tr>
						<td>${ s.count }</td> <!-- index : 0부터 시작 count : 1부터 시작 -->
						<td>${ p.name }</td>
						<td>${ p.age }</td>
						<td>${ p.gender }</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
	
	<br>
	
	<h3>5. 반복문 - forTokens</h3>
	<pre style="font-size:14px;">
 &lt;c:forTokens var="변수명" items="분리시킬문자열" delims="구분자"&gt;
 
 - 구분자를 통해서 분리된 각각의 문자열에 순차적으로 접근하면서 반복 수행
 - JAVA의 split 또는 StringTokenizer와 비슷한 기능 처리
	</pre>
	
	<c:set var="device" value="컴퓨터, 핸드폰, tv.에어컨/냉장고.세탁기" />
	
	<ol>
		<c:forTokens var="d" items="${ device }" delims="/,.">
			<li>${d}</li>			
		</c:forTokens>
	</ol>
	
	<hr>
	
	<h3>6. url, 쿼리스트링 관련 - url, param</h3>
	<pre style="font-size:14px;">
 - url 경로를 생성하고, 쿼리스트링을 정의해둘수 있는 태그
 
 &lt;c:url var="변수명" value="요청할 url"&gt;
 	&lt;c:param name="키값" value="전달할값" /&gt;
 	&lt;c:param name="키값" value="전달할값" /&gt;
 &lt;/c:url&gt;
 	</pre>
	
	<a href="list.do?cpage=1&num=2">기존방식</a> <br>
	
	<c:url var="url" value="list.do">
		<c:param name="cpage" value="1" />
		<c:param name="num">2</c:param>
	</c:url>
	
	<a href="${url}">c:url을 이용한 방식</a>
	
	

</body>
</html>