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
		background-color : black;
		color : white;
		width : 1000px;
		height : 550px;
		margin : auto;
		margin-top : 50px;
	}
	
	#update-form table {
		border : 1px solid white;
	}
	
	#update-form input, #update-form textarea {
		width : 100%;
		box-sizing : border-box;
	}
</style>
</head>
<body>

	<jsp:include page="../common/menubar.jsp" />

	<div class="outer">

		<br>
		<h2 align="center">일반게시판 수정하기</h2>
		<br>

		<form action="update.bo" id="update-form" method="post" enctype="multipart/form-data">
			<input type="hidden" name="bNo" value="${ b.boardNo }">

			<table align="center">
				<tr>
				<th width="70">카테고리</th>
				<td width="500">
					<select name="category">
						<c:forEach var="ca" items="${ list }">
							<option value="${ ca.categoryNo }">${ ca.categoryName }</option>
						</c:forEach>
					</select>

					<script>
						$(function() {
							$("#update-form option").each(function() {
								if ($(this).text() == "${ b.category }") {
									$(this).attr("selected", true);
								}
							})
						})
					</script>
				</td>
				</tr>

				<tr>
					<th>제목</th>
					<td><input type="text" name="title" required value="${ b.boardTitle }"></td>
				</tr>

				<tr>
					<th>내용</th>
					<td><textarea name="content" rows="10" style="resize: none;" required>${ b.boardContent }</textarea></td>
				</tr>

				<tr>
					<th>첨부파일</th>
					<td>
						<c:if test="${ not empty at }">
							${ at.originName }
							<input type="hidden" name="originFileNo" value="${ at.fileNo }">
						</c:if>
						<input type="file" name="upfile">
					</td>
				</tr>
			</table>
			<br>
			<div align="center">
				<button type="submit">수정하기</button>
				<button type="reset">취소하기</button>
			</div>



		</form>

	</div>

</body>
</html>