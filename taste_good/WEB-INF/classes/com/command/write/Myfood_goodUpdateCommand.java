package com.command.write;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.RecipeDAO;
import com.lec.beans.RecipeDTO;

public class Myfood_goodUpdateCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		System.out.println("goodCommand 진입");
		RecipeDAO dao = new RecipeDAO();
		
		int m_num = Integer.parseInt(request.getParameter("m_num"));
		System.out.println("m_num in updatecommand: " +m_num);
		

		
		int cnt = 0;
		
		try {
			cnt= dao.updategood(m_num);
//			response.getWriter().write(cnt);
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		//catch (IOException e) {
			// TODO Auto-generated catch block
		//	e.printStackTrace();
		//}
		
		System.out.println("good resuelt: " + cnt);

	}

}
