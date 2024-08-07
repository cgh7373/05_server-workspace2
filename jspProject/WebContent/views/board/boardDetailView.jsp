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
        height: 550px;
        margin: auto;
        margin-top: 50px;
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

        <div align="center">
            <a onclick="history.back()" class="btn btn-sm btn-secondary">목록가기</a>

            <!-- 로그인한 사용자가 작성자일 경우 -->
            <% if (loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())) { %>
            <a href="" class="btn btn-sm btn-warning">수정하기</a>
            <a href=""class="btn btn-sm btn-danger">삭제하기</a>
            <% } %>
        </div>


    </div>

</body>
</html>