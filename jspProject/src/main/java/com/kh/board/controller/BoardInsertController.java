package com.kh.board.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.FileUpload;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.common.MyFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class BoardInsertController
 */
@WebServlet("/insert.bo")
public class BoardInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		// String boardTitle = request.getParameter("title");
		// String boardContent = request.getParameter("content");
		// 일반방식이 아닌 multipart/form-data 방식으로 전송하는 경우
		// request로부터 값 뽑기가 불가하다.
		
		// enctype이 multipart/form-data로 잘 전송됐을때만 수행되도록
		if (ServletFileUpload.isMultipartContent(request)) {

			// 파일 업로드를 위한 라이브러리 : cos.jar (com.oreilly.servlet의 약자)
			// 							ㄴ http://www.servlets.com
			
			// 1. 전달되는 파일을 처리할 작업 내용(전달되는 파일의 용량 제한, 전달된 파일의 저장경로)
			// 1-1) 전달되는 파일의 용량 제한(int maxSize => byte단위) => 10Mbyte로
			/*
			 * byte -> kbyte -> mbyte -> gbyte -> tbyte
			 * 
			 * 1kbyte == 1024byte
			 * 1mbyte == 1024kbyte == 1024*1024 byte
			 */
			int maxSize = 10 * 1024 * 1024;
			
			// 1-2) 전달된 파일을 저장시킬 폴더의 경로 알아내기(String savePath)
			String savePath = request.getSession().getServletContext().getRealPath("/resources/board_upfiles/");
			
			// 2. 전달된 파일의 파일명 수정 및 서버에 업로드 작업
			/*
			 *  >> HttpServletRequest request => MultipartRequest multiRequest 변환
			 *  
			 *  아래 구문 한줄 실행만으로 넘어온 첨부파일이 해당 폴더에 무조건 업로드됨!
			 *  
			 *  단, 업로드시의 파일명은 수정해주는게 일반적! 그 객체 제시해야됨
			 *  => 파일명 중복을 미연에방지, 파일명에 한글/특문/띄어쓰기 없어야됨
			 *  
			 *  기본적으로 파일명이 안겹치도록 수정해주는 객체 DefaultFileRenamePolicy (cos.jar)
			 *  내부적으로 해당 클래스의 rename() 메소드가 실행되면서 파일명 수정 후 업로드
			 *   ㄴ rename(원본파일) {
			 *   		기존에 동일한 파일명이 존재할 경우
			 *   		파일명 뒤에 카운팅된 숫자를 붙여줌
			 *   		return 수정파일
			 *   }
			 *   나만의 방식으로 FileRenamePolicy 클래스(rename 메소드 정의) 만들기
			 *    ㄴ com.kh.common.MyFileRenamePolicy 만들기
			 */
			
			// MultipartRequest multiRequest = new MultipartRequest(request, 저장경로, 용량제한, 인코딩값, 파일명수정시켜주는객체);
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "utf-8", new MyFileRenamePolicy());
			
			// 3. DB에 기록할 데이터를 뽑아서 VO에 주섬주섬 담기
			//    > 카테고리번호, 제목, 내용, 작성자회원번호 BOARD에 INSERT
			//    > 첨부파일이 있다면 원본명, 수정명, 저장경로 ATTACH~에 INSERT
			String category = multiRequest.getParameter("category");
			String boardTitle = multiRequest.getParameter("title");
			String boardContent = multiRequest.getParameter("content");
			String boardWriter = multiRequest.getParameter("userNo");
			
			Board b = new Board();
			b.setCategory(category);
			b.setBoardTitle(boardTitle);
			b.setBoardContent(boardContent);
			b.setBoardWriter(boardWriter);
			
			Attachment at = null;
			//multiRequest.getOriginalFileName("키") : 넘어온 첨부파일이 있으명 '원본명' | 없으면 null
			if (multiRequest.getOriginalFileName("upfile") != null) {
				at = new Attachment();
				at.setOriginName(multiRequest.getOriginalFileName("upfile"));
				at.setChangeName(multiRequest.getFilesystemName("upfile"));
				at.setFilePath("resources/board_upfiles/");
			}
			
			// 4. 서비스 요청(요청 처리)
			int result = new BoardService().insertBoard(b, at);
			
			// 5. 응답뷰 지정
			if (result > 0) {
				// 성공 => /jsp/list.bo?cPage=1   url 재요청 => 목록페이지
				request.getSession().setAttribute("alertMsg", "작성되었습니다");
				response.sendRedirect(request.getContextPath()+"/list.bo?cPage=1");
			} else {
				// 실패 => 첨부파일이 있었다면 그걸 삭제해주고 에러페이지(등록실패했는데 파일 갖고있을필요 x)
				if (at != null) {
					new File(savePath + at.getChangeName()).delete();
				}
				
				request.setAttribute("errorMsg", "작성실패!");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
			
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
