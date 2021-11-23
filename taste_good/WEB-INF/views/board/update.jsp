<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/include/include-path.jspf" %>
<c:set var="dto" value="${list[0] }"/> 

<c:choose>
	<c:when test="${empty list || fn:length(list) == 0 }">
		<script>
			alert("해당 정보가 삭제되거나 없습니다");
			history.back();
		</script>
	</c:when>
	<c:when test="${sessionID != dto.id }">
		<script>
			alert("건의글 수정은 작성자만 가능합니다.");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
<%-- Show it on page when transaction is all set --%>

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
    <link rel="icon" href="${path1}/img/core-img/favicon.ico">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="${path1 }/css/style.css">
	<link rel="stylesheet" type="text/css" href="${path1 }/css/board.css">
</head>
 

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
                <h3>글 수정</h3>
        <div class="mb-3 mt-3 clearfix">
            <span class="float-start me-2">b_num: ${dto.b_num }</span>
            <span class="float-end ms-4">작성일: ${dto.regDateTime }</span> 
            <span class="float-end">조회수: ${dto.viewcnt }</span>
        </div>
            </div>
        </div>
    </div>
	<hr>
	<!-- 글 내용이 많을수 있기 때문에 POST 방식 사용 -->
	<form name="frm" action="updateOK.do" method="post" onsubmit="return chkSubmit()"
		enctype="Multipart/form-data">
	<input type="hidden" name="b_num" value="${dto.b_num }"/>
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
            <p class="form-control">${dto.id}<br></p>
        </div>
        <div class="col-12">
            <label for="subject">제목:</label>
            <input type="text" class="form-control" id="subject" value="${dto.subject}" name="subject">
        </div>
        <div class="col-12">
            <label for="content">내용:</label>
            <textarea class="form-control" rows="5" id="content" name="content">${dto.content }</textarea>
        </div>
        
<!-- 기존 첨부파일 목록 (삭제 가능) -->
			<c:if test="${fn:length(fileList) > 0 }">
			<div class="container mb-3 mt-3 border rounded">
				<div id="delFiles"></div>  <!-- 삭제할 file 의 bf_num 값(들)을 담기위한 div -->
				<div class="mb-3 mt-3">
					<label>첨부파일</label>
					<c:forEach var='fileDto' items="${fileList }"> 
						<div class="input-group mb-2">
							<input class="form-control col-xs-3" type='text' readonly value="${fileDto.source }">
							<button type="button" class="btn btn-outline-danger" onclick="deleteFiles(${fileDto.f_num}); $(this).parent().remove()">삭제</button>
						</div>
					</c:forEach>
				</div>
			</div>	
			<script>
			function deleteFiles(fileUid){
				$("#delFiles").append("<input type='hidden' name='delfile' value='" + fileUid + "'>");
			}
			</script>		
			</c:if>
			<!-- 기존 첨부파일 목록 (삭제 가능) -->
			
			<!-- 새로운 첨부파일 추가 -->
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
			
			<!-- 새로운 첨부파일 추가 -->
			
		<!-- 첨부파일 -->
			<div class="col-12 col-sm-6">
           <button type="submit" class="btn delicious-btn m-1">수정완료</button>
           </div>
           <div class = "col-12 col-sm-6">
           <button type="button" class="float-right btn delicious-btn btn-4 m-1" onclick="history.back();">이전으로</button>
           <button type="button" class="float-right btn delicious-btn btn-4 m-1" onclick="location.href='list.do'">목록</button>
           </div>
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
 	 <script src="${path1 }/js/board.js"></script></body> 
 	 
</body> 	 
</html>


	</c:otherwise>
</c:choose>









