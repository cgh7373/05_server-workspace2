package com.kh.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.member.model.service.MemberService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class MemberInsertController
 */
@WebServlet("/insert.me")
public class MemberInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1) 인코딩 작업(post면서 한글값 넘어올때)
		request.setCharacterEncoding("utf-8");
		
		// 2) 요청시 전달값 뽑아서 변수 및 객체에 기록하기
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		String userName = request.getParameter("userName");
		String phone = request.getParameter("phone"); // "010-~~" | "" (입력안했을시)
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String[] interestArr = request.getParameterValues("interest"); // [] | null
		
		// String[] --> String
		// ["운동", "등산"] --> "운동, 등산"
		String interest = "";
		if (interestArr != null) {
			interest = String.join(", ", interestArr);
		}
		
		// 기본생성자로 생성 후 setter 메소드 이용해서 담기
		// 매개변수생성자를 이용해서 생성과 동시에 담기
		Member m = new Member(userId, userPwd, userName, phone, email, address, interest);
		
		// 3) 요청처리(서비스 메소드 호출 및 결과 받기)
		int result = new MemberService().insertMember(m);
		
		// 4) 처리 결과를 가지고 사용자가 보게될 응답뷰 지정후 포워딩/url재요청
		if (result > 0) {
			
			// 성공 => /jsp url재요청 index 페이지
			response.sendRedirect(request.getContextPath());
			
		} else {
			
			// 실패 => 에러페이지
			request.setAttribute("errorMsg", "회원가입에 실패했습니다.");
			
			RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
			view.forward(request, response);
			
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
