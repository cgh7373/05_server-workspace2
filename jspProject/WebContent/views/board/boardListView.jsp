<%@page import="com.kh.common.model.vo.PageInfo"%>
<%@page import="com.kh.board.model.vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

    .outer {
        background-color: black;
        color: white;
        width: 1000px;
        height: 500px;
        margin: auto;
        margin-top: 50px;
    }

    .list-area {
        border: 1px solid white;
        text-align: center;
    }

</style>

</head>
<body>

	<%@ include file="../common/menubar.jsp" %>
    <div class="outer">

        <br>
        <h2 align="center">일반게시판</h2>
        <br>

        <!-- 로그인한 회원만 볼수있는 div -->
        <% if (loginUser != null) { %>
        <div align="right" style="width: 864px;">
            <button>글작성</button>
            <br><br>
        </div>
        <% } %>

        <table align="center" class="list-area">

            <thead>
                <tr>
                    <th width="70">글번호</th>
                    <th width="80">카테고리</th>
                    <th width="300">제목</th>
                    <th width="100">작성자</th>
                    <th width="50">조회수</th>
                    <th width="100">작성일</th>
                </tr>
            </thead>

            <tbody>
            
                <!-- case 1. 게시글이 없을 경우 -->
                <% if (list.isEmpty()) { %>
                <tr>
                    <td colspan="6">조회된 게시글이 없습니다.</td>
                </tr>
				<% } else { %>
				
                <!-- case 2. 게시글이 있을 경우  -->
                <% for (Board b : list) { %>
                <tr>
                    <td><%=b.getBoardNo() %></td>
                    <td><%=b.getCategory() %></td>
                    <td><%=b.getBoardTitle() %></td>
                    <td><%=b.getBoardWriter() %></td>
                    <td><%=b.getCount() %></td>
                    <td><%=b.getCreateDate() %></td>
                </tr>
                <% }} %>

            </tbody>

        </table>

        <br><br>

        <div class="paging-area" align="center">
            <button>&lt;</button>
            <% for (int i = pi.getStartPage(); i <= pi.getEndPage(); i++) { %>
            <button><%=i %></button>
            <% } %>
            <button>&gt;</button>
        </div>

    </div>




</body>
</html>