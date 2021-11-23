package com.command.write;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.beans.UserDAO;
import com.lec.beans.UserDTO;

public class SignUpCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int cnt = 0;
		UserDAO dao= new UserDAO();
		
		
		// 입력한 값 받아오기
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String tel = request.getParameter("tel");
		String email = request.getParameter("email");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		
		UserDTO dto = new UserDTO();
		dto.setId(id);
		dto.setPass(pass);
		dto.setName(name);
		dto.setGender(gender);
		dto.setTel(tel);
		dto.setEmail(email);
		dto.setAddress1(address1);
		dto.setAddress2(address2);
		
		// 유효성 체크
		if(name!=null&&id!=null&&pass!=null&&name.trim().length()>0&&id.trim().length()>0) {
			try {
				cnt=dao.insert(dto);
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		request.setAttribute("result", cnt);
		request.setAttribute("dto",dto);	//	auto-generated key(u_num)
	}

}
