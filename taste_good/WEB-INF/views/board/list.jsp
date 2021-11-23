<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/include/include-path.jspf" %>

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

<title>게시판 -목록 </title>
    <!-- Favicon -->
    <link rel="icon" href="${path1}/img/core-img/favicon.ico">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="${path1 }/css/style.css">
	<link rel="stylesheet" type="text/css" href="${path1 }/css/board.css">
</head>

<body>
<!-- 헤더 -->
<jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>	

<div class="container">
   	<div class="row">
        <div class="col-12">
            <div class="section-heading">
                <h3>글 목록</h3>
            </div>
        </div>
    </div>
        <hr>    
</div>
<div class="container section-heading">
     <table class="table table-hover section-padding-80">
		  <thead class="thead-area">
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col">분류</th>
		      <th scope="col">제목</th>
		      <th scope="col">작성자</th>
		      <th scope="col">조회수</th>
		      <th scope="col">작성일</th>
		    </tr>
		  </thead>
   	<tbody>
	<c:choose>
		<c:when test="${empty list || fn:length(list) == 0 }">
			데이터가 없습니다<br>
		</c:when>
		<c:otherwise>
			<c:forEach var="dto" items="${list }">
			<tr>
				<td>${dto.b_num }</td>
				<td>
				<c:choose>
					<c:when test="${dto.kind == 'suggestion' }">건의</c:when>
					<c:when test="${dto.kind == 'error' }">에러</c:when>
					<c:otherwise>기타</c:otherwise>
				</c:choose>
				</td>
				<td><a href="view.do?b_num=${dto.b_num }">${dto.subject }</a></td>
				<td>${dto.id }</td>
				<td>${dto.viewcnt }</td>
				<td>${dto.regDateTime }</td> <%-- getRegDateTime() 사용 --%>
			</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>	
		
	</tbody>
      </table>
      <div class="row">
          <div class="col-12">
              <button type="button" class="btn delicious-btn btn-4 m-1" onclick="location.href = 'write.do';">작성</button>
        </div>
    </div>
</div>

 
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



