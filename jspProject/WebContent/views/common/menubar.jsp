<%@page import="com.kh.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% 
	String contextPath = request.getContextPath(); // "/jsp"

	Member loginUser = (Member)session.getAttribute("loginUser");
	// 로그인 시도 전 menubar.jsp 로딩시 : null
	// 로그인 성공 후 menubar.jsp 로딩시 : 로그인한 회원정보가 담긴 멤버객체
	
	String alertMsg = (String)session.getAttribute("alertMsg");
	// 서비스 요청 전 menubar.jsp 로딩시 : null
	// 서비스 성공 후 menubar.jsp 로딩시 : alert로 띄워줄 메시지 문구
	
	
%>

    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Menubar</title>
        <style>
            .login-area>* {float: right;}
            .login-area a {
                text-decoration: none;
                color: #333;
                font-size: 12px;
            }

            .nav-area {background-color: #333;}
            .menu {
                display: table-cell;
                width: 150px;
                height: 50px;
            }
            .menu a {
                text-decoration: none;
                color: white;
                font-size: 20px;
                font-weight: bold;
                display: block;
                width: 100%;
                height: 100%;
                line-height: 50px;
            }
            .menu a:hover {
                background-color: darkgray;
            }
        </style>
        
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script> -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        
    </head>

    <body>
    
   		<script>
		   	 <% if (alertMsg != null) { %>
		 	 alert("<%= alertMsg %>");
		 	 <% session.removeAttribute("alertMsg"); %>
			 <% } %>
   		</script>
	
        <h1 align="center">Welcome kh World</h1>

        <div class="login-area">

		<% if (loginUser == null) { %>
		
            <!-- case 1. 로그인 전 -->
            <form action="<%=contextPath %>/login.me" method="post">

                <table>

                    <tr>
                        <th>아이디</th>
                        <td><input type="text" name="userId" required></td>
                    </tr>

                    <tr>
                        <th>비밀번호</th>
                        <td><input type="password" name="userPwd" required></td>
                    </tr>

                    <tr>
                        <th colspan="2">
                            <button type="submit">로그인</button>
                            <button type="button" onclick="enrollPage()">회원가입</button>
                        </th>
                    </tr>

                </table>
                <script>
                    function enrollPage() {
                        // location.href = "<%=contextPath %>/views/member/memberEnrollForm.jsp";
                        // 웹 애플리케이션의 디렉토리 구조가 url에 노출괴면 보안에 취약
                        
                        // 단순한 페이지 요청도 servlet 호출해서 servlet을 거치도록 할것!(url에 서블릿 매핑값만 나오게)
                        location.href = "<%= contextPath %>/enrollForm.me";
                    }
                    
                   
                </script>

            </form> 
            
			<% } else { %>
			
            <!-- case 2. 로그인 후 -->
            <div>
                <b><%=loginUser.getUserName() %></b>님의 방문을 환영합니다. <br><br>
                <div align="center">
                    <a href="<%=contextPath %>/myPage.me">마이페이지</a>
                    <a href="<%=contextPath %>/logout.me">로그아웃</a>
                </div>
            </div>
            
			<% } %>
			
        </div>

        <br clear="both">
        <br>

        <div class="nav-area" align="center">
            
            <div class="menu"><a href=<%= request.getContextPath() %>>HOME</a></div>
            <div class="menu"><a href="<%=contextPath%>/list.no">공지사항</a></div>
            <div class="menu"><a href="<%=contextPath%>/list.bo?cPage=1">일반게시판</a></div>
            <div class="menu"><a href="<%=contextPath%>/list.th">사진게시판</a></div>

        </div>






    </body>

    </html>