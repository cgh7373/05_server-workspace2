package com.kh.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class JqAjaxController2
 */
@WebServlet("/jqAjax2.do")
public class JqAjaxController2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqAjaxController2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// request.setCharacterEncoding("utf-8");
		// post라 이렇게해봤는데 ajax는 안되는듯.. ??? 이렇게나옴
		
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		
		// 요청처리가 됐다는 가정하의 데이터
		// ver1. 하나의 문자열
		String responseData = "이름 : " + name + ", 나이 : " + age;
		
		// response.setContentType("text/html; charset=utf-8");
		// 응답데이터에 한글이 있을경우에 이렇게 인코딩처리
		
		// response.getWriter().print(responseData);
		
		// ver2. 응답데이터 여러개일 경우
		// response.getWriter().print(name);
		// response.getWriter().print(age);
		// => success:function의 매개변수에 오긴하는데 두개가 연이어서 하나의 문자열로옴
		
		/*
		 * JSON (JavaScript Object Notation : 자바스크립트 객체 표기법)
		 *  - ajax 통신시 데이터 전송에 자주사용되는 포맷형식중 하나
		 *  
		 *  	> [value, value, value]	 => 자바스크립트에서의 배열객체 => JSONArray
		 *  	> {key:value, key:value} => 자바스크립트에서의 일반객체 => JSONObject
		 *  
		 *  - 라이브러리 필요 (https://code.google.com/archive/p/json-simple/downloads)
		 *  
		 */
		
		/* JSONArray를 사용하는 경우
		JSONArray jArr = new JSONArray(); // []
		jArr.add(name); // ["name"]
		jArr.add(age); // ["name", age]
		
		response.setContentType("json/application; charset=utf-8"); // JSON 타입의 데이터를 응답한다는 뜻
		response.getWriter().print(jArr);
		*/
		
		JSONObject jObj = new JSONObject(); // {}
		jObj.put("name", name); // {name:name}
		jObj.put("age", age); // {name:name, age:age} 근데 순서는 안정해진다.. map과 같이
		
		response.setContentType("json/application; charset=utf-8;");
		response.getWriter().print(jObj);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
