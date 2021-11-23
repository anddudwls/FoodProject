package com.command.write;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.RecipeDAO;
import com.lec.beans.myfood_FileDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;


public class Myfood_UpdateCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int cnt = 0;
		RecipeDAO dao = new RecipeDAO();
		myfood_FileDAO fileDao = new myfood_FileDAO();
		
		//---------------------------------------------
		// 1. MultipartRequest 생성 -> 파일 업로드 됨  
		ServletContext context = request.getServletContext();
		// 서블릿 상의 upload 폴더 경로를 알아온다
		String saveDirectory = context.getRealPath("recipe_saveD");
		System.out.println("업로드 경로: " + saveDirectory);
		
		int maxPostSize = 5 * 1024 * 1024;  // POST 받기, 최대 5M byte :1Kbyte = 1024 byte, 1Mbyte = 1024 Kbyte
		String encoding = "utf-8";  // response 인코딩
		FileRenamePolicy policy = new DefaultFileRenamePolicy(); //업로딩 파일 이름 중복에 대한 정책
		MultipartRequest multi = null; // com.oreilly.servlet.MultipartRequest 임포트

		try {  // MultipartRequest 생성 단계에서 이미 파일은 저장됨.
			multi = new MultipartRequest(
					request,                 // JSP 내부객체 request
					saveDirectory,
					maxPostSize,
					encoding,
					policy
					);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		//--------------------------------------------
		// 2. 업로드된 파일의 '원본이름(들)' 과 '저장된 이름(들)' 받아오기
		List<String> originalFileNames = new ArrayList<String>();
		List<String> fileSystemNames = new ArrayList<String>();
		
		Enumeration names = multi.getFileNames();   // type="file" 요소 name들 추출		
		while(names.hasMoreElements()){		
			String name = (String)names.nextElement();  
			String originalFileName = multi.getOriginalFileName(name);
			String fileSystemName = multi.getFilesystemName(name);
			System.out.println("첨부파일: " + originalFileName + "->" + fileSystemName);
			
			if(originalFileName != null && fileSystemName != null) {
				originalFileNames.add(originalFileName);
				fileSystemNames.add(fileSystemName);
			}
		} // end while

		
		//---------------------------------------------------------
		// 3. 삭제될 기존의 첨부파일(들) -> DB 에서 삭제, 물리적 파일도 삭제
		String [] delFiles = multi.getParameterValues("delfile");
		if(delFiles != null && delFiles.length > 0) {  // 삭제될 첨부파일이 있다면
			// String []  -> int [] 변환
			int [] delFileUids = new int[delFiles.length];
			for (int i = 0; i < delFileUids.length; i++) {
				delFileUids[i] = Integer.parseInt(delFiles[i]);
			}
			
			try {
				fileDao.deleteByF_num(delFileUids, request);  // 물리적 삭제 + DB 삭제
			} catch (SQLException e) {
				e.printStackTrace();
			}  
		}
						
		// 4. 입력한 값을 받아오기 -> 글 수정
		int m_num = Integer.parseInt(multi.getParameter("m_num"));
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");
		String kinds = multi.getParameter("kinds");
		
		if(subject != null && subject.trim().length() > 0){			
			try {			
				cnt = dao.update(m_num, kinds, subject, content);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} // end if
		
		// 5. 추가된 첨부파일(들) -> DB 에 저장
		fileDao = new myfood_FileDAO();
		try {
			fileDao.insert(m_num, originalFileNames, fileSystemNames);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("result", cnt);
		request.setAttribute("m_num", m_num);
	} // end execute()
} // end Command