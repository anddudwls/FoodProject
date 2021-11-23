package com.command.write;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.FileDAO;
import com.lec.beans.FileDTO;

public class DownLoadCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		FileDAO fileDao = new FileDAO();
		List<FileDTO> fileList = null;

		// 첨부파일의 bf_num
		int f_num = Integer.parseInt(request.getParameter("f_num"));  // 매개변수 검증 필요

		FileInputStream in = null;
		ServletOutputStream sout = null;
		
		try {
			fileList = fileDao.selectByF_num(f_num);  // 다운로드할 첨부파일 (1개) 정보 불러오기

			String fileSystemName = fileList.get(0).getFile();  // 저장된 파일명
			String originalFileName = fileList.get(0).getSource(); // 원본 파일명
			
			String downloadFilePath = request.getServletContext().getRealPath("upload")
					+ File.separator + fileSystemName;
			
//			String fileType = context.getMimeType(downloadFilePath);
			String fileType = request.getServletContext().getMimeType(downloadFilePath);
	
			// 유형이 지정되지 않은 경우
			if(fileType == null){
				fileType = "application/octet-stream";  // 일련의 8bit 스트림 형식
														// 유형이 알려지지 않은 파일에 대한 읽기 형식 지정
			}
			System.out.println("파일유형(MIME): " + fileType);
			
			// 3. response 세팅
			// response 에 유형(MIME)을 알려준다
			response.setContentType(fileType);  // ※ 일반적으로 html 은 text/html; charset=utf-8 이었다.

			// 원본파일명으로 다운로드 받게 하기
			response.setHeader("Content-Disposition", "attachment; filename=" +
					URLEncoder.encode(originalFileName, "utf-8"));

			
			// 파일 읽기 -> 전송
			File srcFile = new File(downloadFilePath);
			in = new FileInputStream(srcFile);
			sout = response.getOutputStream();
			
			// 읽어야할 용량은 최대 업로드 용량을 초과하지 않는다.
			byte [] buff = new byte[(int)srcFile.length()];  // 파일 크기 만큼의 버퍼 준비
			int numRead = 0;
			int totalRead = 0;
			 // ↓파일로부터 읽기
			while( (numRead = in.read(buff, 0, buff.length)) != -1){    // -1 이면 EOF 종료
				totalRead += numRead;
				sout.write(buff, 0, numRead);  // 전송! response
			}
			System.out.println("전송 byte: " + totalRead);

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{		
			try {
				if(sout != null) { 
					sout.flush();  // 마지막까지 완전히 전송하고.
					sout.close();
				}
				if(in != null) in.close();
				fileDao.close();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		}
	
	}

}
