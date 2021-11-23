package com.command.comment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CommentCommand {
	void execute(HttpServletRequest request, HttpServletResponse resopnse);

}
