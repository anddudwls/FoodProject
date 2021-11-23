<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.lec.beans.*"%>
<%@ page import ="java.util.*" %>
<jsp:useBean id = "dao" class="com.lec.beans.GoodsDAO"/> <%-- DAO bean 생성 --%>
<%	// dao 이용한 트랜잭션
	List<GoodsDTO> list = dao.select();	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goods.jspf</title>
</head>
<body>
	 <!-- ##### Best Receipe Area Start ##### -->
    <section class="best-receipe-area">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section-heading">
                        <h3>The best Goods</h3>
                    </div>
                </div>
            </div>

            <div class="row">
            <%
			if(list!=null){
				for(GoodsDTO dto : list){
            %>
                <!-- Single Best Receipe Area -->
                <div class="col-12 col-sm-6 col-lg-4">
                    <div class="single-best-receipe-area mb-30">
                        <img src="<%=dto.getPicture() %>" alt="">
                        <div class="receipe-content">
<!--                             <a href="receipe-post.html"> -->
                                <h5><%= dto.getGbsname() %></h5>
                     <!--        </a> -->
                            <div class="ratings">
                               <i><%= dto.getGbsprice() %></i>
                            </div>
                        </div>
                    </div>
                </div>
            <%
				}
			}
            %>
            </div>
        </div>
    </section>
    <!-- ##### Best Receipe Area End ##### -->
    
</body>
</html>