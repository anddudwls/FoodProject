package com.command.write;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.beans.UserDAO;

public class SignInCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
 		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		HttpSession session = request.getSession();
		
		UserDAO dao = new UserDAO();
		
		try {
			int loginResult = dao.login(id, pass);
			
			if(loginResult == 1) {
				request.setAttribute("loginResult", loginResult);
				session.setAttribute("sessionID", id);
			}else {
				request.setAttribute("loginResult", loginResult);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}

}
