package com.kh.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.PageInfo;

/**
 * Servlet implementation class BoardListController
 */
@WebServlet("/list.bo")
public class BoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// ------------------ 페이징 처리 ----------------------
		int listCount;		 // 현재 총 게시글의 개수
		int currentPage; 	 // 현재 페이지
		int pageLimit;	  	 // 페이징바의 페이지 단위개수
		int boardLimit; 	 // 한 페이지 내에 보여질 게시글 최대개수
		
		int maxPage;  		 // 가장 마지막페이지
		int startPage; 		 // 페이징바의 시작수
		int endPage; 		 // 페이징바의 끝수
		
		// * listCount : 총 게시글 개수
		listCount = new BoardService().selectListCount();
		
		// * currentPage : 현재 페이지
		currentPage = Integer.parseInt(request.getParameter("cPage"));
		
		// * pageLimit , boardLimit : 이건 개발할때 정하는것.. 여기선 10개씩해보자
		pageLimit = 10;
		boardLimit = 10;
		
		/*
		 * * maxPage : 제일 마지막 페이지수(총 페이지 수)
		 * 
		 * listCount, boardLimit에 영향을 받음
		 * 
		 *  ex) 게시글이 10개씩 보여진다는 가정하에
		 *  
		 *  listCount boardLimit      maxPage
		 *     100        10            10
		 *     105		  10            11
		 *     110        10            11
		 */
		
		maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
		/*
		 * * startPage : 페이징바의 시작수
		 * 
		 *  currentPage, pageLimit에 영향을 받음
		 *  
		 *  ex) 페이징바의 목록이 10개단위(pageLimit=10)씩이라는 가정하에
		 *  	startPage : 1, 11, 21, 31, ...
		 *  				=> n * pageLimit + 1
		 */
		
//		int n = (currentPage-1)/pageLimit;
//		startPage = n * pageLimit + 1;
		
		startPage = (currentPage-1) / pageLimit * pageLimit + 1;
		
		/*
		 * * endPage : 페이징바의 끝 수
		 * 
		 * 	 startPage, pageLimit에 영향을 받음(단, maxPage에도 영향을 받을수있음)
		 * 
		 * 	 ex) pageLimit : 10 가정하에
		 * 
		 * 	 startPage : 1	=> 10
		 * 	 startPage : 11 => 20
		 * 	 startPage : 21 => 30
		 */
		
		endPage = startPage + pageLimit - 1;
		
		// startPage가 11이면 endPage는 20이 되는데, 만약 maxPage가 13이라면?
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		// com.kh.common.model.vo.PageInfo
		// * 페이징바를 만들때 필요한 객체
		PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
		
		// * 현재 요청한 페이지에 보여질 게시글 리스트 boardLimit수만큼 조회
		ArrayList<Board> list = new BoardService().selectList(pi);
		
		if (!list.isEmpty()) {
			request.setAttribute("list", list);
			request.setAttribute("pi", pi);
			request.getRequestDispatcher("views/board/boardListView.jsp").forward(request, response);
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
