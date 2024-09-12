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
        color: azure;
        width: 1000px;
        height: 800px;
        margin: auto;
        margin-top: 50px;
    }

    .detail-area td {
        border: 1px solid white;
        text-align: center;
    }
</style>
</head>
<body>

	<jsp:include page="../common/menubar.jsp" />

    <div class="outer">
        <br>
        <h2 align="center">사진게시판 상세보기</h2>
        <br>

        <table class="detail-area" align="center">
            <tr>
                <td width="70">제목</td>
                <td colspan="3" width="600">${ b.boardTitle }</td>
            </tr>
            
            <tr>
                <td>작성자</td>
                <td>${ b.boardWriter }</td>
                <td>작성일</td>
                <td>${ b.createDate }</td>
            </tr>

            <tr>
                <td>내용</td>
                <td colspan="3">
                    <p style="height: 50px;">${ b.boardContent }</p>
                </td>
            </tr>

            <tr>
                <td>대표사진</td>
                <td colspan="3">
                    <div>
                        <img src="${ list.get(0).filePath }${ list.get(0).changeName }" width="600" height="300">
                    </div>
                </td>
            </tr>

			<c:if test="${ list.size() gt 1 }">
	            <tr>
	                <td>상세사진</td>
	                <td colspan="3">
	                    <div>
							<c:forEach var="i" begin="1" end="${ list.size() - 1 }">
		                        <img src="${ list.get(i).filePath }${ list.get(i).changeName }" width="200" height="150">
		              		</c:forEach>
	                    </div>
	                </td>
	            </tr>
            </c:if>
        </table>

		<br>
		
		<div align="center">
			<a class="btn btn-sm btn-secondary" href="list.th">목록가기</a>
		</div>

    </div>

</body>
</html>