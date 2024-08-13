package com.kh.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.kh.model.vo.Member;

/**
 * Servlet implementation class JqAjaxController
 */
@WebServlet("/jqAjax3.do")
public class JqAjaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqAjaxController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int userNo = Integer.parseInt(request.getParameter("number"));
		
		// Member m = new MemberService().selectMember(userNo);
		// 위의 m 객체에 조회된 데이터가 있다고 치자
		
		Member m = new Member(1, "차은우", 20, "남"); // 조회된데이터가 이렇다는 가정하에
		
		// response.getWriter().print(m/*.toString()이 있는것*/); vo 객체를 쌩으로 응답시 .toString()의 문자열이 날아감
		
		/* JSONObject {key:value, key:value, ...}
		JSONObject jObj = new JSONObject();
		jObj.put("userNo", m.getUserNo());
		jObj.put("userName", m.getUserName());
		jObj.put("age", m.getAge());
		jObj.put("gender", m.getGender());
		
		JSONArray jarr = new JSONArray();
		jarr.add(0, m.getUserNo());
		jarr.add(1, m.getUserName());
		jarr.add(2, m.getAge());
		jarr.add(3, m.getGender());
		
		response.setContentType("json/application; charset=utf-8;");
		//response.getWriter().print(jObj);
		response.getWriter().print(jarr);
		*/
		
		// 더 간단한 방법 : 위의 과정을 알아서 해주는 GSON 라이브러리
		// GSON : Google JSON (MVNRepository)
		
		response.setContentType("json/application; charset=utf-8;");
		//Gson gson = new Gson(); // Gson객체.toJson(응답할자바객체, 응답할스트림);
		//gson.toJson(m, response.getWriter());
		new Gson().toJson(m, response.getWriter());
		// 걍 toJson박아도 하나면 jsonObject, 여럿이면 jsonArray로 만들어줌
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
