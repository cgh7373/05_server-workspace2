package com.kh.notice.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.notice.model.service.NoticeService;
import com.kh.notice.model.vo.Notice;

/**
 * Servlet implementation class NoticeUpdateController
 */
@WebServlet("/update.no")
public class NoticeUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		int nNoticeNo = Integer.parseInt(request.getParameter("num"));
		String nTitle = request.getParameter("title");
		String nContent = request.getParameter("content");
		
		Notice n2 = new Notice(nNoticeNo, nTitle, nContent);
		
		int result = new NoticeService().updateNotice(n2);
		
		if (result > 0) {
			HttpSession session = request.getSession();
//			request.setAttribute("notice", n);
			session.setAttribute("alertMsg", "공지사항이 수정되었습니다.");
//			request.getRequestDispatcher("views/notice/noticeDetailView.jsp").forward(request, response);
			response.sendRedirect(request.getContextPath() + "/detail.no?num=" + nNoticeNo);
			//어차피 detail.no 에서 받은 num을 기준으로 조회해서 뽑으니까 절로 보내면 끝
		} else {
			request.setAttribute("errorMsg", "수정실패");
			request.getRequestDispatcher("views/common/errorPage.jsp");
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
