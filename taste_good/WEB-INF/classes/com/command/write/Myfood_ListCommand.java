package com.command.write;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.RecipeDAO;
import com.lec.beans.RecipeDTO;
import com.lec.beans.myfood_FileDAO;
import com.lec.beans.myfood_FileDTO;

public class Myfood_ListCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		RecipeDAO dao = new RecipeDAO();  
		List<RecipeDTO> list = null;
		
		
		try {
			
			list = dao.select();
			
			request.setAttribute("list", list);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
//		// 사진 읽어오기 
//		try {
//			if(list!=null) {
//				fileList = fileDao.selectFiles();
//			}
//		}finally {
//			try {
//				fileDao.close();
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
	}
	

}
