package com.kh.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.common.MyFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class BoardUpdateController
 */
@WebServlet("/update.bo")
public class BoardUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		if (ServletFileUpload.isMultipartContent(request)) {
		
			int maxSize = 1024 * 1024 * 10;
			
			String savePath = request.getSession().getServletContext().getRealPath("/resources/board_upfiles/");
			
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "utf-8", new MyFileRenamePolicy());
			
			int boardNo = Integer.parseInt(multiRequest.getParameter("bNo"));
			String category = multiRequest.getParameter("category");
			String boardTitle = multiRequest.getParameter("title");
			String boardContent = multiRequest.getParameter("content");
			
			Board b = new Board();
			
			b.setBoardNo(boardNo);
			b.setCategory(category);
			b.setBoardTitle(boardTitle);
			b.setBoardContent(boardContent);
			
			Attachment at = null;
		
			if (multiRequest.getOriginalFileName("upfile") != null) {
				
				at = new Attachment();
				at.setOriginName(multiRequest.getOriginalFileName("upfile"));
				at.setChangeName(multiRequest.getFilesystemName("upfile"));
				at.setFilePath("resources/board_upfiles/");
				
				if (multiRequest.getParameter("originFileNo") != null) {
					
					// 기존의 첨부파일이 있던 경우 => update Attachment
					at.setFileNo(Integer.parseInt(multiRequest.getParameter("originFileNo")));
					
				} else {
					at.setRefBoardNo(boardNo);
				}
				
			}
		
		// 새로 넘어온 첨부파일이 없다면 at은 여전히 null
		
		int result = new BoardService().updateBoard(b, at);
		// 새로운 첨부파일 x             		 => b, null  		=> Board update
		// 새로운 첨부파일 o, 기존의 첨부파일 o  	 => b, fileNo		=> Board update, Attachment update
		// 새로운 첨부파일 o, 기존의 첨부파일 x 	 => b, refBoardNo 	=> Board update, Attachment insert
				
		if (result > 0) {
			// 성공 => 기존에 봤던 상세조회페이지
			request.getSession().setAttribute("alertMsg", "수정되었습니다.");
			response.sendRedirect(request.getContextPath()+"/detail.bo?bNo="+boardNo);
		} else {
			// 실패 => 에러페이지
			request.setAttribute("errorMsg", "수정되지 않았습니다");
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
