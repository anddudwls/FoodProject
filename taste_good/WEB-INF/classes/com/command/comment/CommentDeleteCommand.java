package com.command.comment;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.write.Command;
import com.lec.beans.CommentDAO;

public class CommentDeleteCommand implements Command, CommentCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse resopnse) {
		int cnt = 0;
		CommentDAO cdao = new CommentDAO();
		
		
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		int c_num = Integer.parseInt(request.getParameter("c_num"));
		
		try {			
			cnt = cdao.deleteCommentByC_num(b_num, c_num);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("result", cnt);

	}

}
