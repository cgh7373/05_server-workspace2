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
        background-color: black;
        color: aliceblue;
        width: 1000px;
        height: auto;
        margin: auto;
        margin-top: 50px;
        margin-bottom: 50px;
    }
</style>
</head>
<body>

	<jsp:include page="../common/menubar.jsp" />

    <div class="outer">
        <br>
        <h2 align="center">일반게시판 상세보기</h2>
        <br>

        <table id="detail-area" border="1" align="center">

            <tr>
                <th width="70">카테고리</th>
                <td width="70">${ b.category }</td>
                <th width="70">제목</th>
                <td width="350">${ b.boardTitle }</td>
            </tr>

            <tr>
                <th>작성자</th>
                <td>${ b.boardWriter }</td>
                <th>작성일</th>
                <td>${ b.createDate }</td>
            </tr>

            <tr>
                <th>내용</th>
                <td colspan="3">
                    <p style="height: 200px;">${ b.boardContent }</p>
                </td>
            </tr>

            <tr>
                <th>첨부파일</th>
                <td colspan="3">
                	<c:choose>
                		<c:when test="${ empty at }">
		                    첨부파일이 없습니다.
	                    </c:when>
	                    
						<c:otherwise>
	                    	<a download="${ at.originName }" href="${at.filePath}${at.changeName}">${ at.originName }</a>
	                    </c:otherwise>
                    </c:choose>
                </td>
            </tr>

        </table>
        
        <br>

		<div id="reply-area">
		
			<table border="1" align="center">
			
				<thead>
					<tr>
						<th>댓글작성</th>
						
						<c:choose>
							<c:when test="${ not empty loginUser }">
								<td>
								<textarea id="replyContent" row="3" cols="46" style="resize:none;"></textarea>
								</td>
								<td><button onclick="insertReply();">댓글등록</button></td>
							</c:when>
							
							<c:otherwise>
								<td>
								<textarea row="3" cols="46" style="resize:none;" readonly>로그인 후 이용가능한 서비스입니다.</textarea>
								</td>
								<td><button diabled>댓글등록</button></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td>admin</td>
						<td>ㅎㅎㅎ</td>
						<td>24/08/13 12:19</td>
					</tr>
				</tbody>
				
			</table>
		
			<script>
			
				$(function() {
					selectReplyList();
					
					setInterval(selectReplyList, 10000);
				})
				
				// ajax로 해당 게시글에 달린 댓글 목록 조회용
				function selectReplyList() {
					$.ajax({
						url : 'rlist.bo',
						data : {bNo:${b.boardNo}},
						success : function(a) {
	
							let value = "";
							
							for (let i in a) {
								value += "<tr>"
									   + "<td>" + a[i].replyWriter + "</td>"
									   + "<td>" + a[i].replyContent + "</td>"
									   + "<td>" + a[i].createDate + "</td>"
									   + "</tr>"
							}
							
							
							$("#reply-area tbody").html(value);
						},
						error : function() {
							console.log("댓글 조회용 ajax 통신 실패!");
						},
					})
				}
				
				// ajax로 해당 게시글에 댓글 작성하는 함수
				function insertReply() {
					$.ajax({
						url : 'rinsert.bo',
						data : {
							content : $("#replyContent").val(),
							bNo : ${b.boardNo},
						},
						type : 'post',
						success : function(result) {
							if (result > 0) { // 댓글작성성공 => 갱신된 댓글 리스트 조회
								selectReplyList();
								$("#replyContent").val("");
							}
						},
						error : function() {
							console.log("댓글작성용 ajax 통신실패");
						},
					})
				}
				
			</script>
		
		</div>
		
		<br>
		
        <div align="center">
            <a onclick="history.back()" class="btn btn-sm btn-secondary">목록가기</a>

            <!-- 로그인한 사용자가 작성자일 경우 -->
            <c:if test="${ not empty loginUser and loginUser.userId eq b.boardWriter }">
            	<a href="updateForm.bo?bNo=${b.boardNo}" class="btn btn-sm btn-warning">수정하기</a>
            	<a class="btn btn-sm btn-danger" onclick="dConfirm()">삭제하기</a>
            </c:if>
            
            <script>
            
            	function dConfirm() {
            		if (confirm("삭제하시겠습니까?")) {
            			location.href="delete.bo?bNo=${b.boardNo}"
            		}
            	}
            
            </script>
            
        </div>


    </div>

</body>
</html>