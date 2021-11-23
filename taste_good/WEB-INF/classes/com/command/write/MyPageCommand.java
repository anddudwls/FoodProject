package com.command.write;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.beans.FileDTO;
import com.lec.beans.RecipeDAO;
import com.lec.beans.RecipeDTO;
import com.lec.beans.UserDAO;
import com.lec.beans.myfood_FileDAO;
import com.lec.beans.myfood_FileDTO;

public class MyPageCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("sessionID");

		System.out.println("id: " + id);

		RecipeDAO dao = new RecipeDAO();
		List<RecipeDTO> list = null;

		try {
			
			int u_num = new UserDAO().getU_numById(id);
			System.out.println("u_num: " + u_num);
			list = dao.selectByU_num(u_num);
			request.setAttribute("list", list);
			System.out.println("list의 길이: "+ list.size());

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
