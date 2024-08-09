<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .outer {
        background-color: #333;
        color: aliceblue;
        width: 1000px;
        height: 700px;
        margin: auto;
        margin-top: 50px;
    }

    #enroll-form table {
        border: 1px solid white;
    }

    #enroll-form input, #enroll-form textarea {
        width: 100%;
        box-sizing: border-box;
    }
</style>
</head>
<body>

	<%@ include file="../common/menubar.jsp" %>

    <div class="outer">
        <br>
        <h2 align="center">사진게시판 작성하기</h2>
        <br>

        <form id="enroll-form" method="post" enctype="multipart/form-data" action="<%=contextPath%>/insert.th">
        
        	<input type="hidden" name="userNo" value="<%=loginUser.getUserNo()%>">
            <table align="center">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3"><input type="text" name="title" required></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3"><textarea rows="5" style="resize: none;" name="content" required></textarea></td>
                </tr>
                <tr>
                    <th>대표이미지</th>
                    <td colspan="3" align="center">
                        <img id="titleImg" width="250" height="170" onclick="chooseFile(1)">
                    </td>
                </tr>
                <tr>
                    <th>상세이미지</th>
                    <td><img width="150" height="120" id="contentImg1" onclick="chooseFile(2)"></td>
                    <td><img width="150" height="120" id="contentImg2" onclick="chooseFile(3)"></td>
                    <td><img width="150" height="120" id="contentImg3" onclick="chooseFile(4)"></td>
                </tr>
            </table>

            <div id="file-area" style="display:none">
                <input type="file" name="file1" id="file1" onchange="loadImg(this, 1)" required>
                <input type="file" name="file2" id="file2" onchange="loadImg(this, 2)">
                <input type="file" name="file3" id="file3" onchange="loadImg(this, 3)">
                <input type="file" name="file4" id="file4" onchange="loadImg(this, 4)">
            </div>

            <script>
            	function chooseFile(num) {
            		
            		$("#file"+num).click();
            		
            	}
            
                function loadImg(inputFile, num) {
                    // inputFile에는 변화가 생긴 input:file 요소객체
                    // num에는 몇번째 input요소인지 구분하기위해

                    // 선택된 file이 있다면 inputFile.files[0] 에 선택된 파일이 담겨있음 (원래 제공되는 배열)
                    if (inputFile.files.length == 1) {

                        // 파일을 읽어들일 FileReader 객체 생성
                        const reader = new FileReader();

                        // 파일을 읽어들이는 메소드
                        reader.readAsDataURL(inputFile.files[0])
                        // 해당 파일을 읽어들이는 순간 해당 파일의 고유한 url 부여

                        // 파일 읽어들이기가 완료됐을때 실행할 함수 정의
                        reader.onload = function(e) {

                            // e.target.result => 읽어들인 파일의 url
                            switch (num) {
                                case 1 : $("#titleImg").attr("src", e.target.result); break;
                                case 2 : $("#contentImg1").attr("src", e.target.result); break;
                                case 3 : $("#contentImg2").attr("src", e.target.result); break;
                                case 4 : $("#contentImg3").attr("src", e.target.result); break;
                            }

                        }

                    } else { // 선택된 파일이 취소된경우.. 미리보기 빼주기

                            switch (num) {
                                case 1 : $("#titleImg").attr("src", null); break;
                                case 2 : $("#contentImg1").attr("src", null); break;
                                case 3 : $("#contentImg2").attr("src", null); break;
                                case 4 : $("#contentImg3").attr("src", null); break;
                            }
                    }
                }
            </script>

            <br><br>

            <div align="center">
                <button>등록하기</button>
                <button></button>
                <button></button>
            </div>

        </form>




    </div>




</body>
</html>