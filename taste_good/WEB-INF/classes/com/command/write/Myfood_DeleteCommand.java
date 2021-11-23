package com.command.write;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.myfood_FileDAO;
import com.lec.beans.RecipeDAO;

public class Myfood_DeleteCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int cnt = 0;
		RecipeDAO dao = new RecipeDAO();
		myfood_FileDAO fileDao = new myfood_FileDAO();  // 첨부파일
		
		//입력한 값을 받아오기
		int m_num = Integer.parseInt(request.getParameter("m_num"));
		
		try {		
			// ★첨부파일 먼저 삭제
			// 1. 물리적인 파일 삭제 (※정책에 따라 삭제 안하고 보관할수도 있다)
			// 2. test_file 테이블에서 삭제 ( DDL 에서 ON DELETE CASCADE 로 자동 삭제케 가능하다)
			fileDao.deleteByM_num(m_num, request);
			
			// 글 삭제
			cnt = dao.deleteByM_num(m_num);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("result", cnt);
		System.out.println("DeleteCommand");
		
	} // end execute()
} // end Command













