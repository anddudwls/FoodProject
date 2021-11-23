package com.command.comment;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.CommentDAO;
import com.lec.beans.CommentDTO;

public class CommentListCommand implements CommentCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse resopnse) {
		CommentDAO cdao = new CommentDAO();  
		List<CommentDTO> c_list = null;
		int b_num = Integer.parseInt(request.getParameter("b_num"));		
		try {
			
			c_list = cdao.selectComment(b_num);
			
			request.setAttribute("c_list", c_list);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//end execute()

	}// end command


