package com.command.comment;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.CommentDAO;

public class CommentUpdateCommand implements CommentCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse resopnse) {
		int cnt = 0;
		CommentDAO cdao = new CommentDAO();
		
		
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		int c_num = Integer.parseInt(request.getParameter("c_num"));
		String c_content = request.getParameter("c_content");
		
			try {			
				cnt = cdao.updateComment(b_num, c_num, c_content);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		
		
		request.setAttribute("c_result", cnt);
		request.setAttribute("c_num", c_num);
	}

}
