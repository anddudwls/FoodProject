<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include-path.jspf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script data-require="jquery@*" data-semver="2.1.4"
	src="https://code.jquery.com/jquery-2.1.4.js"></script>

<c:choose>
	<c:when test="${empty list || fn:length(list) == 0 }">
		<script>
			alert("해당 정보가 삭제되거나 없습니다");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
		<c:set var="dto" value="${list[0] }" />

		<!DOCTYPE html>
		<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
<title>조회 ${dto.subject }</title>
<!-- 제목에 내용을 넣을수도 있다 -->

<!-- Favicon -->
<link rel="icon" href="${path1 }/img/core-img/favicon.ico">

<!-- Core Stylesheet -->
<link rel="stylesheet" href="${path1 }/css/style.css">
</head>

<script>
function chkDelete(m_num){
	// 삭제 여부, 다시 확인하고 진행
	var r = confirm("삭제하시겠습니까?");
	
	if(r){
		location.href = 'myfood_deleteOk.do?m_num=' + m_num;
	}
}
</script>

<script>
function goodCheck(num) {
    var query = {m_num : num}
    
     //	ajax 비동기 통신을 하기위한 코드
     $.ajax({
        url : "good.do",		// 해당 request를 보낼 주소
        type: "get",
        data: query,	
        dataType: 'JSON',
       	success:function(){ 
        		consol.log("하이");
  				alert("좋아요 + 1");
/* 	            location.reload();  */
	   /*         $("#like").html("이거"); */
	   consol.log(location.reload);
        },
        error: function(){
        	$("#reload").load(window.location.href + " #reload");
        }
    }); 
}


</script>

<body>

	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>

	<div class="container mt-3">
		<h2>${dto.subject }</h2>
		<hr>
		<div class="mb-3 mt-3 clearfix">
			<span class="float-start me-2">작성자: ${dto.id }</span>
		</div>
		<section>
			<div class="mb-3">
				<label for="name">종류:</label>
				<div class="border bg-light rounded p-2">${dto.kinds }</div>
			</div>
			<div class="mb-3 mt-3">
				<label for="subject">제목:</label>
				<div class="border bg-light rounded p-2">${dto.subject }</div>
			</div>
			<div class="mb-3 mt-3">
				<label for="content">내용:</label>
				<div class="border bg-light rounded p-2">${dto.content }</div>
			</div>

			<!-- 첨부파일목록 -->
			<div class="container mt-3 mb-3 border rounded">
				<div class="mb-3 mt-3">
					<%-- 					<label>첨부파일:</label>
					<!--첨부파일 이름, 다운로드 링크 -->
					<ul class="list-group mb-1">
						<c:forEach var="fileDto" items="${fileList }">
							<li class="list-group-item"><a
								href="download.do?f_num=${fileDto.ff_num }">${fileDto.ff_source }</a></li>
						</c:forEach>
					</ul> --%>
					<!-- 이미지인 경우 보여주기 -->
					<c:forEach var="fileDto" items="${fileList }">
						<c:if test="${fileDto.image == true }">
							<div>
								<img src="recipe_saveD/${fileDto.ff_file }"
									class="img-thumbnail">
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<!-- 첨부파일목록 -->
			
			
			<div id="reload">
				<button type="button" class="btn btn-outline-dark"
					onclick="location.href='share.do'">목록</button>
				<button type="button" class="btn btn-outline-dark"
					onclick="chkDelete(${dto.getM_num()})">삭제</button>
				<button type="button" class="btn btn-outline-dark"
					onclick="location.href='myfood_update.do?m_num=${ dto.m_num}'">수정</button>
				<button type="button" class="btn btn-outline-dark"
					onclick="location.href='myfood_write.do'">작성</button>
				<input type="button" value="♥" class="btn btn-outline-dark"
					onclick="goodCheck(${dto.m_num})" />&nbsp;${dto.good }
			</div>

		</section>
	</div>
	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>

</body>
		</html>

	</c:otherwise>
</c:choose>













