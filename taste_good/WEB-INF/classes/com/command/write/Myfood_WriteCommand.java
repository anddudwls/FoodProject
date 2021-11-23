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
import com.lec.beans.RecipeDTO;
import com.lec.beans.UserDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

public class Myfood_WriteCommand implements Command {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int cnt = 0;
		RecipeDAO dao = new RecipeDAO();

		// ---------------------------------------------
		// 1. MultipartRequest 생성 -> 파일 업로드 됨
		ServletContext context = request.getServletContext();
		// 서블릿 상의 upload 폴더 경로를 알아온다
		String saveDirectory = context.getRealPath("recipe_saveD");
		System.out.println("업로드 경로: " + saveDirectory);

		int maxPostSize = 5 * 1024 * 1024;
		String encoding = "utf-8";
		FileRenamePolicy policy = new DefaultFileRenamePolicy();
		MultipartRequest multi = null;

		try {
			multi = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		// --------------------------------------------
		// 2. 업로드된 파일의 '원본이름(들)' 과 '저장된 이름(들)' 받아오기
		List<String> originalFileNames = new ArrayList<String>();
		List<String> fileSystemNames = new ArrayList<String>();

		Enumeration names = multi.getFileNames();
		while (names.hasMoreElements()) {
			String name = (String)names.nextElement();
			String originalFileName = multi.getOriginalFileName(name);
			String fileSystemName = multi.getFilesystemName(name);
			System.out.println("첨부파일: " + originalFileName + "->" + fileSystemName);

			if (originalFileName != null && fileSystemName != null) {
				originalFileNames.add(originalFileName);
				fileSystemNames.add(fileSystemName);
			}
		} // end while
		
		int fileResult = originalFileNames.size();
		
		request.setAttribute("fileResult", fileResult);

		// -----------------------------------------
		// 3. 게시글 및 첨부파일 -> DB 에 저장
		String id = (String)request.getSession().getAttribute("sessionID");
		int u_num = 0;
		try {
			u_num = new UserDAO().getU_numById(id);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}

		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");
		String kinds = multi.getParameter("kinds");

		RecipeDTO dto = new RecipeDTO();
		dto.setId(id);
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setKinds(kinds);
		dto.setU_num(u_num);

		if (subject != null && subject.trim().length() > 0) {
			try {
				cnt = dao.insert(dto, originalFileNames, fileSystemNames);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		request.setAttribute("result", cnt);
		request.setAttribute("dto", dto);

	}

}
