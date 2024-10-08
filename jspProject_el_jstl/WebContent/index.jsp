<%@page import="com.kh.common.JDBCTemplate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
</head>
<body>

	<!-- 
		
		* 회원 서비스
		
						| C(Insert) | R(Select) | U(Update) | D(Delete)
		=========================================================================
			로그인 		| 			|	  O		|			|
		   회원가입		|	  O		|			|			|
		  마이페이지		|			|	  O		|			|
		   정보변경		|			|			|	  O		|
		   회원탈퇴		|			|			|     O		|
		[아이디중복체크]	|			|	  O		|			|	
		
		* 공지사항 서비스
		
		  공지사항 리스트 조회(R) / 상세조회(R) 
		  공지사항 작성(C) / 공지사항 수정(U) / 공지사항 삭제(U)
		
		* 일반게시판 서비스
		
		  게시판 리스트 조회(R) - 페이징 처리 / 상세조회(R)
		  게시글 작성(C) / 게시글 수정(U) / 게시글 삭제(U)
		  [댓글리스트 조회(R) / 댓글 작성(C)]
		  
		* 사진게시판 서비스
		  
		  게시판 리스트 조회(R) - 썸네일 형식 / 상세조회(R)
		  게시글 작성(C) - 첨부파일 업로드(C)
		
	 -->

	<jsp:include page="views/common/menubar.jsp" />




</body>
</html>