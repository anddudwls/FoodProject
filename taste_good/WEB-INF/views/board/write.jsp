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
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<script src="https://kit.fontawesome.com/75154d7b55.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<title>게시판 - 작성</title> 

    <!-- Favicon -->
    <link rel="icon" href="${path1 }img/core-img/favicon.ico">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="${path1 }/css/style.css">
	<link rel="stylesheet" type="text/css" href="${path1 }/css/board.css">
</head>

<script>
	if(<%=id%> == null){ 	
		alert("게시글은 로그인 후에만 작성할 수 있습니다.");
		location.href = "signIn.do";}
</script>
	
<script>

function chkSubmit(){
	frm = document.forms['frm'];
	
	var subject = frm['subject'].value.trim();
	
	if (subject == ""){
		alert("제목 작성이 필요합니다.");
		frm["subject"].focus();
		return false;
	}
	
	 
	var kind = document.getElementById('kind').value;
	if (kind == ""){
		alert("건의글 종류 선택이 필요합니다.");
		frm["kind"].focus();
		return false;
	}
	
	return true;
	
}

</script> 
 
<body>
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>	


<div class="container contact-form-area mt-3">
	<div class="row">
        <div class="col-12">
            <div class="section-heading">
                <h3>글 작성</h3>
            </div>
        </div>
    </div>
	<hr>
	<!-- 글 내용이 많을수 있기 때문에 POST 방식 사용 -->
	<form name="frm" action="writeOK.do" method="post" onsubmit="return chkSubmit()"
		enctype="Multipart/form-data">
	<div class="row">
		<div class="col-12 col-lg-3">
            <label for="kind">분류: </label>
			<select size="3" id="kind" name="kind" multiple>
				<option value="" disabled selected>선택</option>
				<option value="suggestion">건의사항</option>
				<option value="error">오류사항</option>
				<option value="etc">기타</option>
			</select>
		</div>
        <div class="col-12 col-lg-9">
            <label for="id">작성자:</label>
            <!--  <input type="text" class="form-control" id="id" placeholder="작성자를 입력하세요" name="id">-->
            <div class="form-control" style="font-size: 1.5em;" name = "id"><%=id %></div>
        </div>
        <div class="col-12">
            <label for="subject">제목:</label>
            <input type="text" class="form-control" id="subject" placeholder="제목을 입력하세요" name="subject">
        </div>
        <div class="col-12">
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
                        + '<input class="form-control col-xs-3" type="file" name="upfile' + i + '"/>'
                        + '<button type="button" class="btn btn-outline-danger" onclick="$(this).parent().remove()">삭제</button>'
                        + '</div>');
				i++;
			});
			</script>
		<!-- 첨부파일 -->

           <button type="submit" class="btn delicious-btn btn-4 m-1">작성완료</button>
           <button type="button" class="btn delicious-btn btn-4 m-1" onclick="location.href='list.do'">목록</button>
	</div>
	</form>	
</div>

<!-- 푸터 -->
     <!-- 푸터 -->
    <jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>	

    <!-- ##### All Javascript Files ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="${path1 }/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="${path1 }/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="${path1 }/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="${path1 }/js/plugins/plugins.js"></script>
    <!-- Active js -->
 	<script src="${path1 }/js/active.js"></script>
 	 <script src="${path1 }/js/board.js"></script>
 	
</body> 
</html>

