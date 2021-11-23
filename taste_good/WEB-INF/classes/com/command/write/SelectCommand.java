package com.command.write;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.FileDAO;
import com.lec.beans.FileDTO;
import com.lec.beans.WriteDAO;
import com.lec.beans.WriteDTO;

public class SelectCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		WriteDAO dao = new WriteDAO();
		List<WriteDTO> list = null;
		int b_num = Integer.parseInt(request.getParameter("b_num")); 
		
		try {
			list = dao.selectByB_num(b_num);  
			request.setAttribute("list", list);
		} catch (SQLException e) { 
			e.printStackTrace();
		}
		
		FileDAO fileDao = new FileDAO();
		List<FileDTO> fileList = null;   
		
		try {
			if(list != null && list.size() == 1) {
				fileList = fileDao.selectFilesByB_num(b_num);
				request.setAttribute("fileList", fileList);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	} //end execute()
} // end Command
