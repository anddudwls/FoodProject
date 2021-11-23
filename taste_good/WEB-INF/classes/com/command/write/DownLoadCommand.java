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

		// ÷�������� bf_num
		int f_num = Integer.parseInt(request.getParameter("f_num"));  // �Ű����� ���� �ʿ�

		FileInputStream in = null;
		ServletOutputStream sout = null;
		
		try {
			fileList = fileDao.selectByF_num(f_num);  // �ٿ�ε��� ÷������ (1��) ���� �ҷ�����

			String fileSystemName = fileList.get(0).getFile();  // ����� ���ϸ�
			String originalFileName = fileList.get(0).getSource(); // ���� ���ϸ�
			
			String downloadFilePath = request.getServletContext().getRealPath("upload")
					+ File.separator + fileSystemName;
			
//			String fileType = context.getMimeType(downloadFilePath);
			String fileType = request.getServletContext().getMimeType(downloadFilePath);
	
			// ������ �������� ���� ���
			if(fileType == null){
				fileType = "application/octet-stream";  // �Ϸ��� 8bit ��Ʈ�� ����
														// ������ �˷����� ���� ���Ͽ� ���� �б� ���� ����
			}
			System.out.println("��������(MIME): " + fileType);
			
			// 3. response ����
			// response �� ����(MIME)�� �˷��ش�
			response.setContentType(fileType);  // �� �Ϲ������� html �� text/html; charset=utf-8 �̾���.

			// �������ϸ����� �ٿ�ε� �ް� �ϱ�
			response.setHeader("Content-Disposition", "attachment; filename=" +
					URLEncoder.encode(originalFileName, "utf-8"));

			
			// ���� �б� -> ����
			File srcFile = new File(downloadFilePath);
			in = new FileInputStream(srcFile);
			sout = response.getOutputStream();
			
			// �о���� �뷮�� �ִ� ���ε� �뷮�� �ʰ����� �ʴ´�.
			byte [] buff = new byte[(int)srcFile.length()];  // ���� ũ�� ��ŭ�� ���� �غ�
			int numRead = 0;
			int totalRead = 0;
			 // �����Ϸκ��� �б�
			while( (numRead = in.read(buff, 0, buff.length)) != -1){    // -1 �̸� EOF ����
				totalRead += numRead;
				sout.write(buff, 0, numRead);  // ����! response
			}
			System.out.println("���� byte: " + totalRead);

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
					sout.flush();  // ���������� ������ �����ϰ�.
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
