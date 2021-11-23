<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/include/include-path.jspf"%>


<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Title -->
<title>Delicious - taste_good | Share</title>

<!-- Favicon -->
<link rel="icon" href="${path1 }/img/core-img/favicon.ico">

<!-- Core Stylesheet -->
<link rel="stylesheet" href="${path1 }/css/style.css">
<link rel="stylesheet" href="${path1 }/mypage_css/icomoon.css">



</head>


<body>

	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>


	<!-- ##### Breadcumb Area Start ##### 상단 이미지 바-->
	<div class="breadcumb-area bg-img bg-overlay"
		style="background-image: url(${path1 }/img/bg-img/breadcumb2.jpg);">
		<div class="container h-100">
			<div class="row h-100 align-items-center">
				<div class="col-12">
					<div class="breadcumb-text text-center">
						<h2>Share</h2>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ##### Breadcumb Area End ##### -->

	<!-- ##### Share Area Start ##### -->
	<div class="blog-area section-padding-80">
		<div class="container">
			<div class="row">
				<c:forEach var="dto" items="${list }">
							<div class="col-12 col-lg-8"
								style="margin: auto; display: block; width: 50%">
								<div class="blog-posts-area">

									<!-- Single Share Area -->
									<div class="single-blog-area mb-80">
										<!-- Thumbnail -->
										<div class="blog-thumbnail">
											<img src="recipe_saveD/${dto.ff_file }">
											<!-- Post Date -->
											<div class="post-date">
												<a><span>${ dto.m_num}</span> <br></a>
											</div>
										</div>
										<!-- Content -->
										<div class="blog-content">
											<a href="myfood_view.do?m_num=${ dto.m_num}"
												class="post-title">${ dto.subject}</a>
										</div>
										<p>${dto.content}</p>
										<span><i class="icon-heart"></i>&nbsp;${dto.good }</span>
									</div>
									<!-- Single Share Area - End  -->

								</div>
							</div>
				</c:forEach>
			</div>
		</div>


		<div class="col-12 col-lg-4" style="margin: auto; display: block;">
			<div class="blog-sidebar-area">
				<div class="single-widget mb-80">
					<div class="quote-area text-center">
						<span>"</span>
						<h4>Nothing is better than going home to family and eating
							good food and relaxing</h4>
						<p>John Smith</p>
					</div>
				</div>
			</div>
		</div>
		<button type="button" class="btn delicious-btn mt-30"
			style="margin: auto; display: block;"
			onclick="location.href = 'myfood_write.do' ">작성</button>
	</div>

	<!-- ##### Share Area End ##### -->

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
</body>

</html>
