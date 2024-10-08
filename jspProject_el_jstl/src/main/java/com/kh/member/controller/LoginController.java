package com.kh.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.service.MemberService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/login.me")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1) 전달값에 한글이 있을 경우 인코딩 처리해야됨 (post 방식에만)
		//    근데 아이디 비번받을거라 한글이없네.. pass
//		request.setCharacterEncoding("utf-8");
		
		// 2) 요청시 전달값 뽑아서 변수 또는 객체에 기록하기
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		
		// 3) 요청 처리 (db의 sql문 실행)
		//    해당 요청을 처리하는 서비스 클래스의 메소드 호출 및 결과 받기
		Member loginUser = new MemberService().loginMember(userId, userPwd);
		
		// 4) 처리된 결과를 가지고 사용자가 보게될 응답뷰 지정 후 포워딩 또는 url 재요청
		
		/*
		 * 
		 * 응답페이지에 전달할 값이 있을 경우 어딘가에 담아야됨 ! 
		 * 	ㄴ> JSP 내장객체 4종류 (1 ~ 4 갈수록 좁은영역)
		 * 	   1) application : 여기에 담긴 데이터는 전역에서 다 꺼내쓸수있음
		 * 	   2) session : 여기에 담긴 데이터는 내가지우기전까지, 세션이 만료(서버가 멈추거나, 브라우저 종료) 
		 * 					되기 전까지 어떤 jsp든, 어떤 servlet이던 꺼내쓸수있음
		 * 	   3) request : 여기에 담긴 데이터는 현재 request 객체를 "포워딩한 응답 jsp에서만" 꺼내쓸수있음(일회성느낌)
		 *     4) page : 해당 jsp에서 담고 그 jsp에서만 꺼내쓸수있음
		 *      
		 * 공통적으로 데이터 담고자 한다면 .setAttribute("키", 밸류);
		 * 				 뽑고자 한다면 .getAttribute("키") : Object 밸류
		 * 				 지우려 한다면 .removeAttribute("키");
		 */
		
		if (loginUser == null) {
			
			// 조회결과 없음 == 로그인 실패 => 에러페이지로 이동
			request.setAttribute("errorMsg", "로그인 실패했습니다!");
			
			// 응답페이지(jsp)에게 위임시 필요한 객체(RequestDispatcher)
			// 포워딩 방식 : 해당 경로로 선택된 view가 보여짐(요청시의 url이 변경되지 않고 남아있음)
			RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
			view.forward(request, response);
			
		} else {
			
			// 조회결과 있음 == 로그인 성공 => 메인페이지(index) 응답
			// 이거는 포워딩하면 안됨.. request는 해당 jsp에만 쓸수있는데 다른페이지 넘어가면 못써먹
			
			// 로그인한 회원정보(loginUser)를 session에 담아버리기(여기저기서 쓸수있도록)
			
			// Servlet에서는 session에 접근하려면 세션 객체부터 얻어와야함
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", loginUser);
			
			// 1. 포워딩 방식 응답뷰 출력
			//    해당 선택된 jsp가 보여질뿐 url에는 여전히 현재 서블릿 매핑값이 남아있음
			//    localhost:8001/jsp/login.me
//			RequestDispatcher view = request.getRequestDispatcher("index.jsp");
//			view.forward(request, response);
			
			// 2. url 재요청 (sendRedirect 방식)
			//    기존에 그 페이지를 응답하는 url이 존재한다면 사용가능
			response.sendRedirect(request.getContextPath());
			
			
			
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
