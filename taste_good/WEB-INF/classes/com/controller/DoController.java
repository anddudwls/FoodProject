package com.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.command.write.Command;
import com.command.write.DeleteCommand;
import com.command.write.DownLoadCommand;
import com.command.write.ListCommand;
import com.command.write.MainCommand;
import com.command.write.MyPageCommand;
import com.command.write.Myfood_DeleteCommand;
import com.command.write.Myfood_ListCommand;
import com.command.write.Myfood_SelectCommand;
import com.command.write.Myfood_UpdateCommand;
import com.command.write.Myfood_ViewCommand;
import com.command.write.Myfood_WriteCommand;
import com.command.write.Myfood_goodUpdateCommand;
import com.command.write.RecipeCommand;
import com.command.write.SelectCommand;
import com.command.write.SignInCommand;
import com.command.write.SignOutCommand;
import com.command.write.SignUpCommand;
import com.command.write.UpdateCommand;
import com.command.write.ViewCommand;
import com.command.write.WriteCommand;


@WebServlet("*.do")
public class DoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DoController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	
	protected void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("actionDo() 호출");
		
		request.setCharacterEncoding("utf-8"); // 한글 인코딩
		
		// URL로부터 URI, ContextPath, Command
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String com = uri.substring(conPath.length());
		
		// 테스트 출력
//		System.out.println("uri: " + uri);
//		System.out.println("conPath: " + conPath);
//		System.out.println("com:" + com);
		
		// 컨트롤러는 아래 두가지를 결정해야 한다.
		Command command = null;  // 어떠한 로직을 수행할지
		String viewPage = null;  // 어떠한 페이지(뷰) 를 보여줄지 결정
		
		// 컨트롤러는 커맨드에 따라, 로직을 수행하고
		// 결과를 내보낼 view 를 결정
		switch(com) {
			
		case "/signUp.do":
			viewPage = "login/signUp.jsp";
			break;
		
		case "/signUpOk.do":
			command = new SignUpCommand();
			command.execute(request, response);
			viewPage = "login/signUpOk.jsp";
			break;
		
		case "/signIn.do":
			viewPage = "login/signIn.jsp";
			break;
			
		case "/signInOk.do":
			command = new SignInCommand();
			command.execute(request, response);
			viewPage = "login/signInOk.jsp";
			break;
			
		case "/signOut.do":
			command = new SignOutCommand();
			command.execute(request, response);
			viewPage = "login/signOut.jsp";
			break;
			
		case "/myPage.do":
			command = new MyPageCommand();
			command.execute(request,response);
			viewPage = "myPage.jsp";
			break;
			
		case "/idCheckForm.do":
			viewPage ="login/idCheckForm.jsp";
			break;
		
		case "/idCheckProc.do":
			viewPage = "login/idCheckProc.jsp";
			break;
			
		case "/index.do":
			command = new MainCommand();
			command.execute(request, response);
			viewPage = "index.jsp";
			break;
			
		case "/recipe.do":
			command = new RecipeCommand();
			command.execute(request, response);
			viewPage = "views/recipe/recipe.jsp";
			break;	
			
			
		case "/about.do":
			viewPage = "about.jsp";
			break;		
			
			
		case "/list.do":
			command = new ListCommand();
			command.execute(request, response);
			viewPage = "views/board/list.jsp";
			break;
			
		case "/write.do":
			viewPage = "views/board/write.jsp";
			break;
		
		case "/writeOK.do":
			command = new WriteCommand();
			command.execute(request, response);
			viewPage = "views/board/writeOK.jsp";
			break;
			
		case "/view.do":
			command = new ViewCommand();
			command.execute(request, response);
			viewPage = "views/board/view.jsp";
			break;
		case "/update.do":
			command = new SelectCommand(); 
			command.execute(request, response);
			viewPage = "views/board/update.jsp";
			break;
			
		case "/updateOK.do":
			command = new UpdateCommand();
			command.execute(request, response);
			viewPage = "views/board/updateOK.jsp";
			break;  
			
		case "/deleteOK.do":
			command = new DeleteCommand();
			command.execute(request, response);
			viewPage = "views/board/deleteOK.jsp";
			break;			
			
		case "/download.do":
			command = new DownLoadCommand();
			command.execute(request, response);  
			break;			
			
		case "/restaurantSearch.do":
			viewPage = "views/restaurants/restaurantSearch.jsp";
			break;
			
		case "/share.do":
			command = new Myfood_ListCommand();
			command.execute(request, response);
			viewPage = "views/share/share.jsp";
			break;	
			
		case "/myfood_write.do":
			viewPage = "views/share/myfood_write.jsp";
			break;
		
		case "/myfood_writeOk.do":
			command = new Myfood_WriteCommand();
			command.execute(request, response);
			viewPage = "views/share/myfood_writeOk.jsp";
			break;
			
		case "/myfood_view.do":
			command = new Myfood_ViewCommand();
			command.execute(request, response);
			viewPage = "views/share/myfood_view.jsp";
			break;
			
		case "/myfood_update.do":
			command = new Myfood_SelectCommand();  // '수정' 이지만, 일단 읽어오는것부터 시작이다.
			command.execute(request, response);
			viewPage = "views/share/myfood_update.jsp";
			break;
			
		case "/myfood_updateOk.do":
			command = new Myfood_UpdateCommand();
			command.execute(request, response);
			viewPage = "views/share/myfood_updateOk.jsp";
			break;  // 디버깅 훈련, 이 break를 없애고, 찾아보기
			
		case "/myfood_deleteOk.do":
			command = new Myfood_DeleteCommand();
			command.execute(request, response);
			viewPage = "views/share/myfood_deleteOk.jsp";
			break;
			
		case "/good.do":
			command = new Myfood_goodUpdateCommand();
			command.execute(request, response);
			break;
		} // end switch
		
		// response 를 위해, 위에서 결정된 페이지(viewPage) 에 forward 해줌.
		if(viewPage != null) {
			RequestDispatcher dispatcher =
					request.getRequestDispatcher("/WEB-INF/"+viewPage);
			dispatcher.forward(request, response);
		}
		
		
	}

}
