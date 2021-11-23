<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include-path.jspf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="dto" value="${list[0] }" />

<c:choose>
	<c:when test="${empty list || fn:length(list) == 0 }">
		<script>
			alert("해당 정보가 삭제되거나 없습니다");
			history.back();
		</script>
	</c:when>
	<c:when test="${sessionID != dto.id }">
		<script>
			alert("수정은 작성자만 가능합니다.");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
		<%-- Show it on page when transaction is all set --%>

		<!DOCTYPE html>
		<html lang="ko">
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>레시피 공유 - 수정</title>

<!-- Favicon -->
<link rel="icon" href="${path1}/img/core-img/favicon.ico">

<!-- Core Stylesheet -->
<link rel="stylesheet" href="${path1}/css/style.css">
</head>
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
		<h2>수정</h2>
		<hr>
		<div class="mb-3 mt-3 clearfix">
			<span class="float-start me-2">m_num: ${dto.m_num }</span>
		</div>

		<form name="frm" action="myfood_updateOk.do" method="post"
			onsubmit="return chkSubmit()" enctype="Multipart/form-data">
			<%-- 수정단계에서 파일 추가(업로딩) 가능 Multipart request --%>
			<input type="hidden" name="m_num" value="${dto.m_num }" />

			<div class="mb-3">
				<label for="kinds">종류:</label>
				<div>
					<select id="foodCategory" name="kinds">
						<option value="전체" selected>전체</option>
						<option value="한식">한식</option>
						<option value="중식">중식</option>
						<option value="일식">일식</option>
						<option value="양식">양식</option>
						<option value="기타">기타</option>
					</select>
				</div>
			</div>
			<div class="mb-3 mt-3">
				<label for="subject">제목:</label> <input type="text"
					class="form-control" id="subject" placeholder="제목을 입력하세요"
					name="subject" value="${dto.subject }">
			</div>
			<div class="mb-3 mt-3">
				<label for="content">내용:</label>
				<textarea class="form-control" rows="5" id="content"
					placeholder="내용을 입력하세요" name="content">${dto.content }</textarea>
			</div>

			<!-- 기존 첨부파일 목록 (삭제 가능) -->
			<c:if test="${fn:length(fileList) > 0 }">
				<div class="container mb-3 mt-3 border rounded">
					<div id="delFiles"></div>
					<!-- 삭제할 file 의 bf_uid 값(들)을 담기위한 div -->
					<div class="mb-3 mt-3">
						<label>첨부파일</label>
						<c:forEach var='fileDto' items="${fileList }">
							<div class="input-group mb-2">
								<input class="form-control col-xs-3" type='text' readonly
									value="${fileDto.ff_source }">
								<button type="button" class="btn btn-outline-danger"
									onclick="deleteFiles(${fileDto.ff_num}); $(this).parent().remove()">삭제</button>
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
					<div id="files"></div>
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


			<button type="submit" class="btn btn-outline-dark">수정완료</button>
			<button type="button" class="btn btn-outline-dark"
				onclick="history.back();">이전으로</button>
			<button type="button" class="btn btn-outline-dark"
				onclick="location.href='share.do'">목록</button>
		</form>

	</div>

</body>
		</html>

	</c:otherwise>
</c:choose>














