<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include-path.jspf" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>맛잘알 : 맛집 검색</title>
<link rel="icon" href="${path1 }/img/core-img/favicon.ico">
<link rel="stylesheet" href="${path1 }/css/style.css">
<link rel="stylesheet" href="${path1 }/css/restaurantSearch.css">
</head>
<body>
    
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>	
    
    <!-- 본문 상단 -->
    <div id="restaurantImg" class="breadcumb-area bg-img bg-overlay">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-text text-center">
                        <h2>맛집 검색</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

	<!-- 맛집 검색 본문 -->
    <div class="restaurant-search-area section-padding-80">

        <!-- 검색어 입력 부분 -->
        <div class="restaurant-search mb-80">
            <div class="container">
                <form onsubmit="restaurantSearch(); return false;">
                    <div class="row">
                        <div class="col-12 col-lg-10">
                            <input type="text" id="mapKeyword" name="mapKeyword" placeholder="검색어를 입력해주세요">
                        </div>
                        <div class="col-12 col-lg-2 text-right">
                            <button type="submit" class="btn restaurant-btn">검색</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- 지도 부분 -->
        <div class="container">
            <div class="row">
                <div class="col-12">
					<jsp:include page="map.jsp"></jsp:include>
                </div>
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
</body>
</html>