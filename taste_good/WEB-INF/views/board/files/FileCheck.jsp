<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>  <%-- URLEncoder 외 --%>

<%-- JSTL 활용 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% request.setCharacterEncoding("utf-8"); %>    
<c:set var="originalFileNames" value="${paramValues.originalFileName }"/>
<c:set var="fileSystemNames" value="${paramValues.fileSystemName }"/>
<c:set var="cnt" value = "${fn:length(paramValues.originalFileName) }"/>    
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>파일 확인 & 다운로드 링크</title>
<style>
form p {text-decoration: underline;}
form p:hover {cursor: pointer; color:blue;}
</style>
</head>
<body>

<h3>${cnt } 개의 파일 확인</h3>
<ul>
<c:forEach var="i" begin="0" end="${cnt - 1 }" varStatus="status">
	<li>파일: ${i + 1 }</li>
	<ul>
		<li>원본이름: ${originalFileNames[status.index] }</li>
		<li>파일시스템이름: ${fileSystemNames[status.index] }</li>
	</ul>
</c:forEach>
</ul>

<hr>

<h3>다운로드 링크: post + JSTL</h3>
<c:forEach var="i" begin="0" end="${cnt - 1 }">
<form name="ifrm${i }" action="FileDownload.jsp" method="post">
	<%-- 화면에는 '원본파일' 이름으로, 실제링크는 업로드 된 파일 이름으로 --%>
	<input type="hidden" name="fileSystemName" value="${fileSystemNames[i] }"/>
	<input type="hidden" name="originalFileName" value="${originalFileNames[i] }"/>
	<p onclick="document.forms['ifrm${i}'].submit()">${originalFileNames[i] }</p>
</form>
</c:forEach>

<hr>

<h3>이미지 보기</h3> 
<c:forEach var="i" begin="0" end="${cnt -1 }">
<div style="width:300px">
	<img style="width:100%; height:auto" src="upload/${fileSystemNames[i] }"/>
</div>
</c:forEach>

</body>
</html>


































