package com.command.write;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.FileDAO;
import com.lec.beans.FileDTO;
import com.lec.beans.WriteDAO;
import com.lec.beans.WriteDTO;

public class ViewCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse resopnse) {
		WriteDAO dao = new WriteDAO();
		List<WriteDTO> list = null;
		int b_num = Integer.parseInt(request.getParameter("b_num")); 
		
		try {
			list = dao.readByB_num(b_num);   
			request.setAttribute("list", list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		// 첨부파일용 DAO 추가
		FileDAO fileDao = new FileDAO();
		List<FileDTO> fileList = null;
		
		// 첨부파일 읽어들이기
		try {
			if(list != null && list.size() == 1) {
				
				fileList = fileDao.selectFilesByB_num(b_num); // 첨부파일 읽어오기
				
				// 이미지 파일 세팅 필요
				String realPath = 
						request.getServletContext().getRealPath("upload");
				
				for(FileDTO fileDto : fileList) {
					File f = new File(realPath, fileDto.getFile());
					BufferedImage imgData = ImageIO.read(f);
					if(imgData != null) {
						fileDto.setImage(true);
					}
				}
				
				request.setAttribute("fileList", fileList);  // VIEW 에서 보여줄 첨부파일 목록
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				fileDao.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

}
