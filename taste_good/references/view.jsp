<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:choose>
	<c:when test="${empty list || fn:length(list) == 0 }">
		<script>
			alert("해당 정보가 삭제되거나 없습니다");
			history.back();
		</script>			
	</c:when>
	<c:otherwise>
		<c:set var="dto" value="${list[0] }"/>
		
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
	<title>조회 ${dto.subject }</title>  <!-- 제목에 내용을 넣을수도 있다 -->
</head>

<script>
function chkDelete(uid){
	// 삭제 여부, 다시 확인하고 진행
	var r = confirm("삭제하시겠습니까?");
	
	if(r){
		location.href = 'deleteOk.do?uid=' + uid;
	}
}
</script>

<body>
	<div class="container mt-3">
		<h2>조회 ${dto.subject }</h2>
		<hr>
		<div class="mb-3 mt-3 clearfix">
            <span class="float-start me-2">uid: ${dto.uid }</span>
            <span class="float-end ms-4">작성일: ${dto.regDateTime }</span> <%-- getRegDateTime() 사용 --%>
            <span class="float-end">조회수: ${dto.viewCnt }</span>
        </div>
        <section>
            <div class="mb-3">
                <label for="name">작성자:</label>
                 <div class="border bg-light rounded p-2" >${dto.name }</div>
            </div>    
            <div class="mb-3 mt-3">
                <label for="subject">제목:</label>
                 <div class="border bg-light rounded p-2" >${dto.subject }</div>
            </div>    
            <div class="mb-3 mt-3">
                <label for="content">내용:</label>
                 <div class="border bg-light rounded p-2" >${dto.content }</div>
            </div>    

            <button type="button" class="btn btn-outline-dark" onclick="location.href='update.do?uid=${dto.uid}'">수정</button>
            <button type="button" class="btn btn-outline-dark" onclick="location.href='list.do'">목록</button>
            <button type="button" class="btn btn-outline-dark" onclick="chkDelete(${dto.uid})">삭제</button>
            <button type="button" class="btn btn-outline-dark" onclick="location.href='write.do'">작성</button>

        </section>        
	</div>
</body>
</html>

	</c:otherwise>
</c:choose>













