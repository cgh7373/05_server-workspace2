<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    
    	<c:if test="${ not empty alergMsg }">
	   		<script>
			 	alert('${ alertMsg }');
	   		</script>
	   		<c:remove var="alertMsg" scope="session" />
		</c:if> 
		
        <h1 align="center">Welcome kh World</h1>

        <div class="login-area">

		<c:choose>
			<c:when test="${ empty loginUser }">
			
	            <!-- case 1. 로그인 전 -->
	            <form action="login.me" method="post">
	
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
	                        location.href = "enrollForm.me";
	                    }
	                    
	                   
	                </script>
	            </form> 
            </c:when>
            
			<c:otherwise>
	            <!-- case 2. 로그인 후 -->
	            <div>
	                <b>${ loginUser.userName }</b>님의 방문을 환영합니다. <br><br>
	                <div align="center">
	                    <a href="myPage.me">마이페이지</a>
	                    <a href="logout.me">로그아웃</a>
	                </div>
	            </div>
			</c:otherwise>
		</c:choose>
			
        </div>

        <br clear="both">
        <br>

        <div class="nav-area" align="center">
            
            <div class="menu"><a href="${ pageContext.request.contextPath }">HOME</a></div>
            <div class="menu"><a href="list.no">공지사항</a></div>
            <div class="menu"><a href="list.bo?cPage=1">일반게시판</a></div>
            <div class="menu"><a href="list.th?cPage=1">사진게시판</a></div>

        </div>






    </body>

    </html>