<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                margin: auto;
                margin-top: 50px;
            }

            #mypage-form table {
                margin: auto;
            }

            #mypage-form input {
                margin: 5px;
            }
        </style>
    </head>

    <body>

        <%@ include file="../common/menubar.jsp" %>

            <% String userId = loginUser.getUserId(); 
            String userName = loginUser.getUserName();
            String userPwd = loginUser.getUserPwd();
            String phone = (loginUser.getPhone()==null) ? "" : loginUser.getPhone(); // null 존재가능 
            String email = (loginUser.getEmail()==null) ? "" : loginUser.getEmail(); 
            String address = (loginUser.getAddress()==null) ? "" : loginUser.getAddress(); 
            String interest = (loginUser.getInterest()==null) ? "" : loginUser.getInterest(); %>

                <div class="outer">

                    <br>
                    <h2 align="center">마이페이지</h2>

                    <form id="mypage-form" action="<%= contextPath %>/update.me" method="post">

                        <table>
                            <tr>
                                <td>* 아이디</td>
                                <td><input type="text" name="userId" maxlength="12" value="<%= userId %>" readonly></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>* 이름</td>
                                <td><input type="text" name="userName" maxlength="6" value="<%= userName %>"></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;전화번호</td>
                                <td><input type="text" name="phone" placeholder="- 포함해서 입력" value="<%= phone %>"></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;이메일</td>
                                <td><input type="email" name="email" value="<%= email %>"></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;주소</td>
                                <td><input type="text" name="address" value="<%= address %>"></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;관심분야</td>
                                <td colspan="2">
                                    <input type="checkbox" name="interest" id="sports" value="운동">
                                    <label for="sports">운동</label>

                                    <input type="checkbox" name="interest" id="hiking" value="등산">
                                    <label for="hiking">등산</label>

                                    <input type="checkbox" name="interest" id="fishing" value="낚시">
                                    <label for="fishing">낚시</label>
                                    <br>
                                    <input type="checkbox" name="interest" id="cooking" value="요리">
                                    <label for="cooking">요리</label>

                                    <input type="checkbox" name="interest" id="game" value="게임">
                                    <label for="game">게임</label>

                                    <input type="checkbox" name="interest" id="movie" value="영화">
                                    <label for="movie">영화</label>
                                </td>
                            </tr>
                        </table>

                        <script>

                            $(function () {

                                const interest = '<%= interest %>';
                                // "" | "운동,등산,게임"

                                $('input[type=checkbox]').each(function () {

                                    // $(this).val()
                                    // search() : 해당문자있으면 인덱스반환, 없으면 -1반환
                                    // 검색할거.search("검색할글자")
                                    if (interest.search($(this).val()) != -1) {
                                        $(this).attr("checked", true);
                                    }

                                });

                            })

                        </script>

                        <br><br>

                        <div align="center">
                            <button type="submit" class="btn btn-sm btn-secondary">정보변경</button>
                            <button type="button" class="btn btn-sm btn-warning" data-toggle="modal"
                                data-target="#updatePwdModal">비밀번호 변경</button>
                            <button type="button" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#deleteModal">회원탈퇴</button>
                        </div>



                        <br>

                    </form>

                </div>

                <!-- 비밀번호 변경용 Modal -->
                <div class="modal" id="updatePwdModal">
                    <div class="modal-dialog">
                        <div class="modal-content">

                            <!-- Modal Header -->
                            <div class="modal-header">
                                <h4 class="modal-title">비밀번호 변경</h4>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>

                            <!-- Modal body -->
                            <div class="modal-body" align="center">
                               
                               <form action="<%= contextPath %>/updatePwd.me" method="post">
                               
                               		<input type="hidden" name="userId" value="<%= userId %>">
                               		<table>
                               		
										<tr>
											<td>현재 비밀번호</td>                               		
											<td><input type="password" name="userPwd" required></td>                               	
										</tr>	
                               		
										<tr>
											<td>변경할 비밀번호</td>                               		
											<td><input type="password" name="updatePwd" required></td>                               	
										</tr>	
                               		
										<tr>
											<td>변경할 비밀번호 확인</td>                               		
											<td><input type="password" name="checkPwd" required></td>                               	
										</tr>	
                               		
                               		</table>
                               
                               		<br>
                               		
                               		<button type="submit" class="btn btn-sm btn-secondary" onclick="return validatePwd();">비밀번호 변경</button>
                               
                               </form>
                               
                               <script>
                               
                               		function validatePwd() {
                               			
                               			if ($("input[name=updatePwd]").val() != $("input[name=checkPwd]").val()) {
                               				alert("변경할 비밀번호가 일치하지 않습니다.")
                               				return false;
                               			}
                               			
                               		}
                               
                               </script>
                               
                            </div>


                        </div>
                    </div>
                </div>
                
                <!-- 회원 탈퇴용 Modal -->
                <div class="modal" id="deleteModal">
                    <div class="modal-dialog">
                        <div class="modal-content">

                            <!-- Modal Header -->
                            <div class="modal-header">
                                <h4 class="modal-title">회원탈퇴</h4>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>

                            <!-- Modal body -->
                            <div class="modal-body" align="center">
                               
                               <form action="<%= contextPath %>/delete.me" method="post">
                               
                               		<b>탈퇴 후 복구가 불가능합니다. <br> 정말로 탈퇴하시겠습니까? </b> <br><br>
                               		
                               		<input type="hidden" name="userId" value="<%=userId%>">
                               		비밀번호 : <input type="password" name="userPwd2" required> <br><br>
                               		<button type="submit" class="btn btn-sm btn-danger" onclick="return validatePwd2();">탈퇴하기</button>
                               
                               		<!-- 
                               			요청시 실행할 sql문
                               			UPDATE MEMBER
                               			SET STATUS = 'N'
                               			, MODIFY_DATE = SYSDATE
                               			WHERE USER_ID = 로그인한회원아이디
                               			AND USER_PWD = 사용자가입력한비밀번호
                               			
                               			(정보변경, 비밀번호변경처럼 갱신된 회원 다시 조회할 필요없음!)
                               			
                               			성공했을 경우 => 메인페이지 alert("성공적으로 회원탈퇴되었습니다. 그동안 이용해주셔서 감사합니다.")
                               			을 로그아웃이 되어있어야함. (loginUser 세션값 지우기)
                               			
                               			실패했을 경우 => 마이페이지 alert("회원탈퇴 실패")
                               		 -->
                               
                               </form>
                               
                               <script>
                               
                               		function validatePwd2() {
                               			
                               			if ($("input[name=userPwd2]").val() != "<%=userPwd%>" ) {
                               				alert("비밀번호가 일치하지 않습니다.")
                               				return false;
                               			}
                               			
                               		}
                               
                               </script>
                               
                            </div>


                        </div>
                    </div>
                </div>

    </body>

    </html>