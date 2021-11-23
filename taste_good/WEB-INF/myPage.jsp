<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/include/include-path.jspf"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title><%=session.getAttribute("sessionID")%>의 마이페이지</title>
<link rel="icon" href="${path1 }/img/core-img/favicon.ico">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- stylesheet  -->
<link rel="stylesheet" href="${path1 }/css/style.css">
<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,700"
	rel="stylesheet">
<link rel="stylesheet"
	href="${path1 }/mypage_css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="${path1 }/mypage_css/animate.css">
<link rel="stylesheet" href="${path1 }/mypage_css/owl.carousel.min.css">
<link rel="stylesheet"
	href="${path1 }/mypage_css/owl.theme.default.min.css">
<link rel="stylesheet" href="${path1 }/mypage_css/magnific-popup.css">
<link rel="stylesheet" href="${path1 }/mypage_css/aos.css">
<link rel="stylesheet" href="${path1 }/mypage_css/ionicons.min.css">
<link rel="stylesheet"
	href="${path1 }/mypage_css/bootstrap-datepicker.css">
<link rel="stylesheet" href="${path1 }/mypage_css/jquery.timepicker.css">
<link rel="stylesheet" href="${path1 }/mypage_css/flaticon.css">
<link rel="stylesheet" href="${path1 }/mypage_css/icomoon.css">
<link rel="stylesheet" href="${path1 }/mypage_css/style.css">
<!-- stylesheet -->

</head>


<body>

	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>

	<c:choose>
		<c:when test="${empty list || fn:length(list) == 0 }">
			<k style="position: relative; left: 45%">레시피를 공유해주세요!</k>
			<br>
		</c:when>
		<c:otherwise>
			<div id="colorlib-page">
				<section class="ftco-section">
					<div class="row">
						<c:forEach var="dto" items="${list }">
							<div class="col-md-4">
								<div class="blog-entry ftco-animate">
									<a href="#" class="img img-2"
										style="background-image: url(recipe_saveD/${dto.ff_file});"></a>
									<div class="text text-2 pt-2 mt-3">
										<span class="category mb-3 d-block"><a href="#">${dto.kinds }</a></span>
										<h3 class="mb-4">
											<a href="myfood_view.do?m_num=${dto.m_num }">${dto.subject }</a>
										</h3>
										<p class="mb-4">${dto.content }</p>
										<div class="author mb-4 d-flex align-items-center">
											<div class="ml-3 info"></div>
										</div>
										<div class="meta-wrap align-items-center">
											<div class="half order-md-last">
												<p class="meta">
													<span><i class="icon-heart"></i>${dto.good }</span>
												</p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</section>
			</div>
		</c:otherwise>
	</c:choose>


	<!-- 
	<div id="ftco-loader" class="show fullscreen">
		<svg class="circular" width="48px" height="48px">
			<circle class="path-bg" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke="#eeeeee" />
			<circle class="path" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
	</div> -->

	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>

	<script src="${path1 }/mypage_js/jquery.min.js"></script>
	<script src="${path1 }/mypage_js/jquery-migrate-3.0.1.min.js"></script>
	<script src="${path1 }/mypage_js/popper.min.js"></script>
	<script src="${path1 }/mypage_js/bootstrap.min.js"></script>
	<script src="${path1 }/mypage_js/jquery.easing.1.3.js"></script>
	<script src="${path1 }/mypage_js/jquery.waypoints.min.js"></script>
	<script src="${path1 }/mypage_js/jquery.stellar.min.js"></script>
	<script src="${path1 }/mypage_js/owl.carousel.min.js"></script>
	<script src="${path1 }/mypage_js/jquery.magnific-popup.min.js"></script>
	<script src="${path1 }/mypage_js/aos.js"></script>
	<script src="${path1 }/mypage_js/jquery.animateNumber.min.js"></script>
	<script src="${path1 }/mypage_js/bootstrap-datepicker.js"></script>
	<%-- 	<script src="${path1 }/mypage_js/jquery.timepicker.min.js"></script> --%>
	<script src="${path1 }/mypage_js/scrollax.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<%-- 	<script src="${path1 }/mypage_js/js/google-map.js"></script> --%>
	<script src="${path1 }/mypage_js/main.js"></script>

</body>
</html>