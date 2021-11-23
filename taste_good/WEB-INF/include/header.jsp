<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include-path.jspf" %>
<!-- ##### Header Area Start ##### -->
    <header class="header-area">
    <!-- Top Header Area -->
        <div class="top-header-area">
            <div class="container h-100">
                <div class="row h-100 align-items-center justify-content-between">  
            
                    <!-- Top Social Info -->
                    <div class="col-12 col-sm-6">
                        <div id="login">
                        	<c:choose>
	                        	<c:when test="${sessionID != null }">  
	                        	<!--${sessionID } 로그인 중  -->
	                        		<a href="myPage.do">My page</a>   <!--  마이페이지로 이동 --> 
	                        		<a href="signOut.do">Sign out</a>
	                        	</c:when>
		                        <c:otherwise>
		                            <a href="signIn.do">Sign in</a>		                            
		                            <a href="signUp.do">Sign up</a>
	                            </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Navbar Area -->
        <div class="delicious-main-menu">
            <div class="classy-nav-container breakpoint-off">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="deliciousNav">

                        <!-- Logo -->
                        <a class="nav-brand" href="index.do"><img src="${path1 }/img/core-img/logo.png" alt=""></a>

                        <!-- Navbar Toggler -->
                        <div class="classy-navbar-toggler">
                            <span class="navbarToggler"><span></span><span></span><span></span></span>
                        </div>

                        <!-- Menu -->
                        <div class="classy-menu">

                            <!-- close btn -->
                            <div class="classycloseIcon">
                                <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                            </div>

                            <!-- Nav Start -->
                            <div class="classynav">
                                <ul>
                                    <li class="active"><a href="index.do">Home</a></li>                                                                     
                                    <li><a href="recipe.do">Recipe</a></li>
                                    <li><a href="share.do">Share</a></li>
                                    <li><a href="restaurantSearch.do">Restaurants</a></li>
                                    <li><a href="list.do">Board</a></li>
                                    <li><a href="#">Contacts</a></li>
                                </ul>
                            </div>
                            <!-- Nav End -->
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <!-- ##### Header Area End ##### -->