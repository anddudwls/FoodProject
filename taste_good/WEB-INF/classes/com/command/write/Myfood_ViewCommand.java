package com.command.write;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.FileDTO;
import com.lec.beans.RecipeDAO;
import com.lec.beans.RecipeDTO;
import com.lec.beans.myfood_FileDAO;
import com.lec.beans.myfood_FileDTO;

public class Myfood_ViewCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse resopnse) {
		RecipeDAO dao = new RecipeDAO();
		List<RecipeDTO> list = null;
		int m_num = Integer.parseInt(request.getParameter("m_num")); 
		
		try {
			list = dao.readByM_num(m_num);   
			request.setAttribute("list", list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		// 첨부파일용 DAO 추가
		myfood_FileDAO fileDao = new myfood_FileDAO();
		List<myfood_FileDTO> fileList = null;
		
		// 첨부파일 읽어들이기
		try {
			if(list != null && list.size() == 1) {
				
				fileList = fileDao.selectFilesByM_num(m_num); // 첨부파일 읽어오기
				
				// 이미지 파일 세팅 필요
				String realPath = 
						request.getServletContext().getRealPath("recipe_saveD");
				
				for(myfood_FileDTO fileDto : fileList) {
					File f = new File(realPath, fileDto.getFf_file());
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
