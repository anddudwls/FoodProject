package com.command.comment;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.CommentDAO;
import com.lec.beans.CommentDTO;

public class CommentWriteCommand implements CommentCommand{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse resopnse) {
		
		int cnt = 0;
		//view에 전달할 값. (view에서 사용할 변수)
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		String c_id = (String)request.getSession().getAttribute("sessionID");
		String c_content = request.getParameter("c_content");
		
		CommentDTO cdto = new CommentDTO();//comment 객체 받아오기
		CommentDAO cdao = new CommentDAO();//sql 연결 -> dao method 사용
		
		//사용자가 입력한 값
		cdto.setB_num(b_num);
		cdto.setC_id(c_id);
		cdto.setC_content(c_content);
		
		try {
			cnt = cdao.insertComment(cdto);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("result", cnt );
		request.setAttribute("cdto", cdto);
		
	
	}

}
