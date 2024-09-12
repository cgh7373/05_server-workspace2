<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	@font-face {
	    font-family: 'HakgyoansimDunggeunmisoTTF-B';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2408-5@1.0/HakgyoansimDunggeunmisoTTF-B.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
	}

	body * {
		font-family: 'HakgyoansimDunggeunmisoTTF-B';
	}

    .outer {
        background-color: #333;
        color: aliceblue;
        width: 1000px;
        height: 800px;
        margin: auto;
        margin-top: 50px;
    }

    .list-area {
        width: 760px;
        margin: auto;
    }

    .thumbnail {
        border: 1px solid white;
        width: 220px;
        display: inline-block;
        margin: 14px;
        transition:.3s;
        &:hover {
        	cursor:pointer;
        	opacity:.7;
        	scale:1.02;
        }
    }
</style>
</head>
<body>

	<jsp:include page="../common/menubar.jsp" />

    <div class="outer">
        <br>
        <h2 align="center">사진게시판</h2>
        <br>

        <!-- 로그인한 회원만 보이게 -->
        <c:if test="${ not empty loginUser }">
	        <div align="right" style="width: 860px;">
	            <a href="enrollForm.th" class="btn btn-sm btn-secondary">글작성</a>
	        </div>
        </c:if>
        <br><br>

        <div class="list-area">

            <!-- 썸네일 틀 -->
            <c:forEach var="b" items="${ list }">
	            <div class="thumbnail" align="center">
	            	<input type="hidden" value="${ b.boardNo }">
	                <img src="${ b.titltImg }" width="200" height="150">
	                <p>
	                    No.${ b.boardNo } ${ b.boardTitle } <br>
	                    조회수 : ${ b.count }
	                </p>
	            </div>
			</c:forEach>
        </div>
    </div>
    
    <script>
    	$(function() {
    		$(".thumbnail").click(function() {
    			location.href="detail.th?bNo=" + $(this).children("input").val();
    		})
    	})
    </script>

</body>
</html>