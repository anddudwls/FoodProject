<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- cos 라이브러리 --%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>    
<%@ page import="com.oreilly.servlet.multipart.FileRenamePolicy" %>    
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>    
    
<%-- parameter 값들,  file name 값들 추출 --%>
<%@ page import="java.util.Enumeration" %>   

<%--File 객체 추출 --%>
<%@ page import="java.io.File" %>

<%-- 이미지 파일 다루기 --%>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>    
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>파일업로드 결과</title>
</head>
<body>
<form action="FileCheck.jsp" method="post" name="fileCheck">
<%
	// 파일 저장 경로
	String saveDirectory = "";
	//saveDirectory = "C:\\tomcat\\taste_good\\upload";
	
	ServletContext context = this.getServletContext();
	// 서블릿 상의 upload 폴더 경로를 알아온다
	saveDirectory = context.getRealPath("upload");
	
	System.out.println("업로드 경로: " + saveDirectory);
	
	int maxPostSize = 5 * 1024 * 1024;  // POST 받기, 최대 5M byte
	String encoding = "utf-8";  // 인코딩
	FileRenamePolicy policy = new DefaultFileRenamePolicy(); // 업로딩 파일 이름 중복에 대한 rename 정책
	
	MultipartRequest multi = null; 
	
	// MultipartRequest 생성단계에서 이미 파일 저장까지 마무리 됨. 
	multi = new MultipartRequest(
			request,   // 내부객체 request
			saveDirectory,   // 업로드된 파일 저장 경로
			maxPostSize,     // 최대 파일 크기 (post 크기)
			encoding,
			policy
			);
	
	Enumeration names = null;
	
	// 1. parameter name 들 추출
	names = multi.getParameterNames();  // 일반 form 요소 name 들 추출
	while(names.hasMoreElements()){
		String name = (String)names.nextElement();  // name
		String value = multi.getParameter(name);  // value
		out.println(name + " : " + value + "<br>"); 
	}
	out.println("<hr>");
	
	// 2. File 정보 추출 
	names = multi.getFileNames();  // type='file' 요소 name(들) 추출
	while(names.hasMoreElements()){
		String name = (String)names.nextElement();
		out.println("input name: " + name + "<br>");
		
		// 원본 파일 이름
		String originalFileName = multi.getOriginalFileName(name);
		out.println("원본파일 이름: " + originalFileName + "<br>");
		out.println("<input type='hidden' name='originalFileName' value='" + originalFileName +"'/>");
		
		// 업로딩된 파일 이름
		String fileSystemName = multi.getFilesystemName(name);
		out.println("파일시스템 이름: " + fileSystemName + "<br>");
		out.println("<input type='hidden' name='fileSystemName' value='" + fileSystemName +"'/>");
		
		// 업로딩된 파일의 타입 : MIME 타입
		String fileType = multi.getContentType(name);
		out.println("파일타입: " + fileType + "<br>");
		
		// File 객체 가져오기
		File file = multi.getFile(name);
		if(file != null){
			long fileSize = file.length();
			out.println("파일크기: " + fileSize + " bytes<br>");
			
			// 이미지 파일 다루기
			BufferedImage bi = ImageIO.read(file);
			if(bi != null){  // 이미지 파일 판정 여부
				int width = bi.getWidth();
				int height = bi.getHeight();
				out.println("이미지파일 WxH: " + width + " x " + height + "<br>");
			} else {
				out.println("이미지 파일이 아닙니다<br>");
			}
		}
		
		out.println("<hr>");
	}	
	
%>
<input type="submit" value="업로드 파일 확인"/>
</form>

</body>
</html>



















