<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/include/include-path.jspf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%
	String id = (String)session.getAttribute("sessionID");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- Favicon -->
    <link rel="icon" href="${path1}/img/core-img/favicon.ico">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="${path1}/css/style.css">
    <title>작성</title>
</head>

<script>
	if(<%=id%> == null){ 	
		alert("게시글은 로그인 후에만 작성할 수 있습니다.");
		location.href = "signIn.do";}
</script>

<script>
// form 검증(validation)
function chkSubmit(){
	
	frm = document.forms['frm'];
	var subject = frm['subject'].value.trim();
	
	
	if(subject == ""){
		alert("제목은 반드시 작성해야 합니다");
		frm["subject"].focus();
		return false;
	}
	
	return true;	
}
</script>
<body>
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>	

	<div class="container mt-3">
		<h2>레시피 작성</h2>
		<hr>
		<%-- 글 내용이 많을수 있기 때문에 POST 방식 사용 --%>
		<form name="frm" action="myfood_writeOk.do" method="post" onsubmit="return chkSubmit()"
				enctype="Multipart/form-data">
            <div class="mb-3 mt-3">
                <label for="kinds">종류:</label>
                <select id="kinds" name="kinds">
					<option value="전체" selected>전체</option>
					<option value="한식">한식</option>
					<option value="중식">중식</option>
					<option value="일식">일식</option>
					<option value="양식">양식</option>
					<option value="기타">기타</option>
					</select>           
            </div>
            <div class="mb-3 mt-3">
                <label for="subject">제목:</label>
                <input type="text" class="form-control" id="subject" placeholder="제목을 입력하세요" name="subject">
            </div>
            <div class="mb-3 mt-3">
                <label for="content">내용:</label>
                <textarea class="form-control" rows="5" id="content" placeholder="내용을 입력하세요" name="content"></textarea>
            </div>

			<!-- 첨부파일 -->

			<div class="container mt-3 mb-3 border rounded">
				<div class="mb-3 mt-3">
					<label>첨부파일:</label>
					<div id="files">
					
					</div>
					<button type="button" id="btnAdd" class="btn btn-secondary">추가</button>
				</div>
			</div>
			<script>
			var i = 0;
			$("#btnAdd").click(function(){
				$("#files").append('<div class="input-group mb-2">'
                        + '<input class="form-control col-xs-3" type="file" name="file' + i + '"/>'
                        + '<button type="button" class="btn btn-outline-danger" onclick="$(this).parent().remove()">삭제</button>'
                        + '</div>');
				i++;
			});
			</script>
			<!-- 첨부파일 -->

            <button type="submit" class="btn btn-outline-dark">작성완료</button>
            <button type="button" class="btn btn-outline-dark" onclick="location.href='share.do'">목록</button>
		</form>
	</div>
	
     <!-- 푸터 -->
    <jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>	
</body>
</html>
















