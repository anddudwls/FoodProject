package com.command.write;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.UserDAO;
import com.lec.beans.WriteDAO;
import com.lec.beans.WriteDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

public class WriteCommand implements Command {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int cnt = 0;
		WriteDAO dao = new WriteDAO();
			
		//---------------------------------------------
		// 1. MultipartRequest ���� -> ���� ���ε� ��  
		ServletContext context = request.getServletContext();
		// ���� ���� upload ���� ��θ� �˾ƿ´�
		String saveDirectory = context.getRealPath("upload");
		System.out.println("���ε� ���: " + saveDirectory);
		
		int maxPostSize = 5 * 1024 * 1024;  
		String encoding = "utf-8"; 
		FileRenamePolicy policy = new DefaultFileRenamePolicy(); 
		MultipartRequest multi = null;

		try { 
			multi = new MultipartRequest(
					request,
					saveDirectory,
					maxPostSize,
					encoding,
					policy
					);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		//--------------------------------------------
		// 2. ���ε�� ������ '�����̸�(��)' �� '����� �̸�(��)' �޾ƿ���
		List<String> originalFileNames = new ArrayList<String>();
		List<String> fileSystemNames = new ArrayList<String>();
		
		Enumeration names = multi.getFileNames();	
		while(names.hasMoreElements()){		
			String name = (String)names.nextElement();  
			String originalFileName = multi.getOriginalFileName(name);
			String fileSystemName = multi.getFilesystemName(name);
			System.out.println("÷������: " + originalFileName + "->" + fileSystemName);
			
			if(originalFileName != null && fileSystemName != null) {
				originalFileNames.add(originalFileName);
				fileSystemNames.add(fileSystemName);
			}
		} // end while
				
		
		//-----------------------------------------
		// 3. �Խñ� �� ÷������ -> DB �� ����		
		String id = (String)request.getSession().getAttribute("sessionID");
		int u_num = 0;
		try {
			u_num = new UserDAO().getU_numById(id);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");
		String kind = multi.getParameter("kind");
		
		WriteDTO dto = new WriteDTO();
		dto.setId(id);
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setKind(kind);
		dto.setU_num(u_num);
		
		if(kind != null && subject != null &&
				kind.trim().length() > 0 && subject.trim().length() > 0) {
			try {
				cnt = dao.insert(dto, originalFileNames, fileSystemNames);
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		request.setAttribute("result", cnt);
		request.setAttribute("dto", dto); 

	}

}


















