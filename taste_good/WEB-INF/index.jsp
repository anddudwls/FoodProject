<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include-path.jspf" %>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>Delicious - taste_good | Home</title>

    <!-- Favicon -->
    <link rel="icon" href="${path1}/img/core-img/favicon.ico">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="${path1}/css/style.css">

</head>

<body>
    
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>	
      

     <!-- ##### Hero Area Start ##### -->
    <section class="hero-area">
        <div class="hero-slides owl-carousel">
            <!-- Single Hero Slide -->
            <div class="single-hero-slide bg-img" style="background-image: url(${path1}/img/bg-img/bg1.jpg);">
                <div class="container h-100">
                    <div class="row h-100 align-items-center">
                        <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                            <div class="hero-slides-content" data-animation="fadeInUp" data-delay="10ms">
                                <h2 data-animation="fadeInUp" data-delay="300ms">오늘 뭐먹지</h2>
                                <p data-animation="fadeInUp" data-delay="700ms">오늘 무엇을 먹을지 고민하는 당신께. 추천합니다.</p>
                                <a href="recipe.do" class="btn delicious-btn" data-animation="fadeInUp" data-delay="1000ms">See Receipe</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Single Hero Slide -->
            <div class="single-hero-slide bg-img" style="background-image: url(${path1}/img/bg-img/bg6.jpg);">
                <div class="container h-100">
                    <div class="row h-100 align-items-center">
                        <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                            <div class="hero-slides-content" data-animation="fadeInUp" data-delay="10ms">
                                <h2 data-animation="fadeInUp" data-delay="300ms">오늘 뭐먹지</h2>
                                <p data-animation="fadeInUp" data-delay="700ms">오늘의 메뉴! 이건 어떠십니까??</p>
                                <a href="recipe.do" class="btn delicious-btn" data-animation="fadeInUp" data-delay="1000ms">See Receipe</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Hero Area End ##### -->

    <!-- ##### Top Catagory Area Start ##### -->
    <section class="top-catagory-area section-padding-80-0">
        <div class="container">
            <div class="row">
                <!-- Top Catagory Area -->
                <div class="col-12 col-lg-6">
                    <div class="single-top-catagory">
                        <img src="${path1}/img/bg-img/bg2.jpg" alt="">
                        <!-- Content -->
                        <div class="top-cta-content">
                            <h3>나에게 딱 맞는 레시피 찾기</h3>
                            <h6>Simple &amp; Delicios</h6>
                            <a href="recipe.do" class="btn delicious-btn">See Full Receipe</a>
                        </div>
                    </div>
                </div>
                <!-- Top Catagory Area -->
                <div class="col-12 col-lg-6">
                    <div class="single-top-catagory">
                        <img src="${path1}/img/bg-img/bg3.jpg" alt="">
                        <!-- Content -->
                        <div class="top-cta-content">
                            <h3>오늘의 추천 상품</h3>
                            <h6>Simple &amp; Goods</h6>
                            <a href="recipe.do" class="btn delicious-btn">See Goods</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Top Catagory Area End ##### -->

    <!-- ##### CTA Area Start ##### -->
    <section class="cta-area bg-img bg-overlay" style="background-image: url(${path1}/img/bg-img/bg4.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <!-- Cta Content -->
                    <div class="cta-content text-center">
                        <h2>우리동네 맛집 확인하기</h2>
                        <a href="restaurantSearch.do" class="btn delicious-btn">Confirm</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### CTA Area End ##### -->
	
     <!-- 푸터 -->
    <jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>	

    <!-- ##### All Javascript Files ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="${path1}/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="${path1}/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="${path1}/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="${path1}/js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="${path1}/js/active.js"></script>
</body>

</html>