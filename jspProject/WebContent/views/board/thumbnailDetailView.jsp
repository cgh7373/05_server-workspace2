<%@page import="com.kh.board.model.vo.Attachment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.kh.board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Board b = (Board)request.getAttribute("b");
	ArrayList<Attachment> list = (ArrayList<Attachment>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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

	<%@ include file="../common/menubar.jsp" %>

    <div class="outer">
        <br>
        <h2 align="center">사진게시판 상세보기</h2>
        <br>

        <table class="detail-area" align="center">
            <tr>
                <td width="70">제목</td>
                <td colspan="3" width="600"><%=b.getBoardTitle() %></td>
            </tr>
            
            <tr>
                <td>작성자</td>
                <td><%=b.getBoardWriter() %></td>
                <td>작성일</td>
                <td><%=b.getCreateDate() %></td>
            </tr>

            <tr>
                <td>내용</td>
                <td colspan="3">
                    <p style="height: 50px;"><%=b.getBoardContent() %></p>
                </td>
            </tr>

            <tr>
                <td>대표사진</td>
                <td colspan="3">
                    <div>
                        <img src="<%=contextPath %>/<%=list.get(0).getFilePath()+list.get(0).getChangeName()%>" width="600" height="300">
                    </div>
                </td>
            </tr>

			<% if (list.size() > 1) { %>
            <tr>
                <td>상세사진</td>
                <td colspan="3">
                    <div>
						<% for (int i = 1; i < list.size(); i++) { %>
	                        <img src="<%=contextPath %>/<%=list.get(i).getFilePath()+list.get(i).getChangeName()%>" width="200" height="150">
	              		<% } %>
                    </div>
                </td>
            </tr>
            <% } %>
        </table>

		<br>
		
		<div align="center">
			<a class="btn btn-sm btn-secondary" href="<%=contextPath%>/list.th">목록가기</a>
		</div>

    </div>

</body>
</html>