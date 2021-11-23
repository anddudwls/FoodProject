package com.command.write;

import java.sql.SQLException; 
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.WriteDAO;
import com.lec.beans.WriteDTO;

public class ListCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse resopnse) {
		WriteDAO dao = new WriteDAO();  
		List<WriteDTO> list = null;
		
		try {
			
			list = dao.select();
			
			request.setAttribute("list", list);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
