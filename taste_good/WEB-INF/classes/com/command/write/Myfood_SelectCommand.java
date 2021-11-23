package com.command.write;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.myfood_FileDAO;
import com.lec.beans.myfood_FileDTO;
import com.lec.beans.RecipeDAO;
import com.lec.beans.RecipeDTO;

public class Myfood_SelectCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		RecipeDAO dao = new RecipeDAO();
		List<RecipeDTO> list = null;
		int m_num = Integer.parseInt(request.getParameter("m_num"));  // 매개변수 검증 필요
		
		System.out.println("selectcommand 진입 + m_num: "+m_num);
		
		try {
			list = dao.selectByM_num(m_num);  // 읽기 only
			request.setAttribute("list", list);
		} catch (SQLException e) { // 만약 ConnectionPool 을 사용한다면 여기서 NamingException 도 catch 해야 한다  
			e.printStackTrace();
		}
//		System.out.println(list.size());
		
		// 첨부파일 정보도 update 화면에 보여주어야 한다
		// 첨부파일 DAO 추가
		myfood_FileDAO fileDao = new myfood_FileDAO();
		List<myfood_FileDTO> fileList = null;   // 첨부파일 목록
		
		// 첨부파일 목록 읽어들이기
		try {
			if(list != null && list.size() == 1) {
				fileList = fileDao.selectFilesByM_num(m_num);
				request.setAttribute("fileList", fileList);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	} //end execute()
} // end Command














