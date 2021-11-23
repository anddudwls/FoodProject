package com.command.write;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.command.write.Command;
import com.lec.beans.WriteDAO;
import com.lec.beans.WriteDTO;

public class MainCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse resopnse) {
//		HttpSession session = request.getSession();
//		session.invalidate();
	}

}