package com.ncs.test.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ncs.test.member.model.service.MemberServiceImpl;
import com.ncs.test.member.model.vo.Member;

/**
 * Servlet implementation class MemberController
 */
@WebServlet("/login")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Member m = new Member();

		m.setMemberId(request.getParameter("userId"));

		m.setMemberPwd(request.getParameter("userPwd"));

		Member loginMember = new MemberServiceImpl().memberLogin(m);

		if(loginMember != null) { // 로그인 성공

				request.getSession().setAttribute("loginMember", loginMember);

				response.sendRedirect(request.getContextPath());

		} else { // 로그인 실패

			request.setAttribute("msg", "로그인 실패");

			request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);;

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
