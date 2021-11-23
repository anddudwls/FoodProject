package com.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.comment.AjaxListCommand;
import com.command.comment.CommentCommand;
import com.command.comment.CommentDeleteCommand;
import com.command.comment.CommentListCommand;
import com.command.comment.CommentSelectCommand;
import com.command.comment.CommentUpdateCommand;
import com.command.comment.CommentWriteCommand;

@WebServlet("*.co")
public class CoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CoController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionCo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionCo(request, response);
	}

	protected void actionCo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("actionCo() 호출");
		
		request.setCharacterEncoding("utf-8");
		
		// URL로부터 URI, ContextPath, Command
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String com = uri.substring(conPath.length());
				
		CommentCommand command = null; 
		
		// 컨트롤러는 커맨드에 따라, 로직을 수행
		switch(com) {
		case "/commentList.co":  // 글목록 AJAX요청
			new CommentListCommand().execute(request, response);
			command = new AjaxListCommand();
			command.execute(request, response);
			break;
			
		case "/commentWrite.co":
			new AjaxListCommand().execute(request, response);
			command = new CommentWriteCommand();
			command.execute(request, response);
			break;
		
		case "/commentDelete.co":
			new AjaxListCommand().execute(request, response);
			command = new CommentDeleteCommand();
			command.execute(request, response);
			break;
		
		case "/commentUpdate.co":
			new AjaxListCommand().execute(request, response);
			command = new CommentUpdateCommand();
			command.execute(request, response);
			break;
		
		case "/commentSelect.co":
			new AjaxListCommand().execute(request, response);
			command = new CommentSelectCommand();
			command.execute(request, response);
			break;
		}
		
	}// end ajaxCo()
	
}// end Controller
