<%@page import="com.kh.board.model.vo.Attachment"%>
<%@page import="com.kh.board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Board b = (Board)request.getAttribute("b");
	// 글번호, 카테고리명, 제목, 내용, 작성자아이디, 작성일
	
	Attachment at = (Attachment)request.getAttribute("at");
	// 첨부파일x => null
	// 있으면 => 파일번호, 원본파일명, 수정파일명, 저장경로
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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

	<%@ include file="../common/menubar.jsp" %>

    <div class="outer">
        <br>
        <h2 align="center">일반게시판 상세보기</h2>
        <br>

        <table id="detail-area" border="1" align="center">

            <tr>
                <th width="70">카테고리</th>
                <td width="70"><%=b.getCategory() %></td>
                <th width="70">제목</th>
                <td width="350"><%=b.getBoardTitle() %></td>
            </tr>

            <tr>
                <th>작성자</th>
                <td><%=b.getBoardWriter() %></td>
                <th>작성일</th>
                <td><%=b.getCreateDate() %></td>
            </tr>

            <tr>
                <th>내용</th>
                <td colspan="3">
                    <p style="height: 200px;"><%=b.getBoardContent() %></p>
                </td>
            </tr>

            <tr>
                <th>첨부파일</th>
                <td colspan="3">
                    <!-- case 1. 첨부파일 없을경우 -->
                    <% if (at == null) { %>
                    첨부파일이 없습니다.
					<% } else { %>
                    <!-- case 2. 첨부파일 있을경우 -->
                    <a download="<%=at.getOriginName() %>" href="<%=contextPath %>/<%=at.getFilePath()+at.getChangeName()%>"><%=at.getOriginName() %></a>
                    <% } %>
                </td>
            </tr>

        </table>
        
        <br>

		<div id="reply-area">
		
			<table border="1" align="center">
			
				<thead>
					<tr>
						<th>댓글작성</th>
						<% if (loginUser != null) { %>
						<td>
						<textarea id="replyContent" row="3" cols="46" style="resize:none;"></textarea>
						</td>
						<td><button onclick="insertReply();">댓글등록</button></td>
						<% } else { %>
						<td>
						<textarea row="3" cols="46" style="resize:none;" readonly>로그인 후 이용가능한 서비스입니다.</textarea>
						</td>
						<td><button diabled>댓글등록</button></td>
						<% } %>
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
						data : {bNo:<%=b.getBoardNo()%>},
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
							bNo : <%=b.getBoardNo()%>,
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
            <% if (loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())) { %>
            <a href="<%=contextPath%>/updateForm.bo?bNo=<%=b.getBoardNo()%>" class="btn btn-sm btn-warning">수정하기</a>
            <a class="btn btn-sm btn-danger" onclick="dConfirm()">삭제하기</a>
            <% } %>
            
            <script>
            
            	function dConfirm() {
            		if (confirm("삭제하시겠습니까?")) {
            			location.href="<%=contextPath%>/delete.bo?bNo=<%=b.getBoardNo()%>"
            		}
            	}
            
            </script>
            
        </div>


    </div>

</body>
</html>