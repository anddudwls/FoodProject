package com.command.comment;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lec.beans.AjaxCommentListJSON;
import com.lec.beans.CommentDTO;

public class AjaxListCommand implements CommentCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		System.out.println("ajaxListCommand");

		int b_num = Integer.parseInt(request.getParameter("b_num"));
		
		List<CommentDTO> c_list = (List<CommentDTO>)request.getAttribute("c_list");
		
		AjaxCommentListJSON obj = new AjaxCommentListJSON();  // response 할 Java객체
		
		if(c_list == null) {
			obj.setStatus("FAIL");
		} else {
			obj.setB_num(b_num);
			obj.setStatus("OK");
			obj.setCount(c_list.size());
			obj.setC_list(c_list);
		}
		
		ObjectMapper mapper = new ObjectMapper();  // Java -> JSON 매핑할 Mapper 객체
		
		try {
			String output = null;
			output = mapper.writeValueAsString(obj);
			System.out.println(output);
			response.setContentType("application/json; charset=utf-8"); // MIME 설정
			response.getWriter().write(output);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
				
			}