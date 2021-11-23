<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include-path.jspf" %>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>Delicious - taste_good | Receipe</title>

    <!-- Favicon -->
    <link rel="icon" href="${path1 }/img/core-img/favicon.ico">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="${path1 }/css/style.css">
    <link rel="stylesheet" href="${path1 }/css/recipe.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>	

    <!-- ##### Breadcumb Area Start ##### -->
    <div class="breadcumb-area bg-img bg-overlay" style="background-image: url(${path1}/img/bg-img/breadcumb3.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-text text-center">
                        <h2>레시피 찾기</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ##### Breadcumb Area End ##### -->

    <div class="receipe-post-area section-padding-80">

        <!-- Receipe Post Search -->
        <div class="receipe-post-search mb-80">
            <div class="container">
                <form action="#" method="post">
                    <div class="row">
                        <div class="col-12 col-lg-3">
                            <select id="foodCategory" name="category">
								<option value="all_food" selected>전체</option>
								<option value="korean_food">한식</option>
								<option value="chinese_food">중식</option>
								<option value="japanese_food">일식</option>
								<option value="western_food">양식</option>
								<option value="other_food">기타</option>
							</select>
                        </div>                       
                        <div class="col-12 col-lg-3">
                            <input type="search" name="search" placeholder="Search Receipies">
                        </div> 
                        <div class="col-12 col-lg-3 text-right">
                            <button id="ctgrBtn" type="button" class="btn delicious-btn">Search</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="w3-main w3-content w3-padding" style="max-width: 1200px; margin-top: 100px">
        <table id="recipeList"></table>
        <br><br>
        </div>
	<%-- <jsp:include page="category.jsp"></jsp:include> --%>
	<hr>
	<!-- ##### Best Receipe Area Start #####(goods) --> 
	<jsp:include page="goods.jsp"></jsp:include>
    <!-- ##### Best Receipe Area End ##### -->
  
	<hr>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function() {	
	var url = "http://211.237.50.150:7080/openapi/62ce31d82e32076b5beb4931415ba9ee315ec247a4318a07a036e2a5830695ed/json/Grid_20150827000000000226_1/1/5";
	
	$("#ctgrBtn").click(function() {
		$.ajax({
			url: url,
			type: "GET",
			cache: false,
			success: function(data, status) {
				if(status == "success") parseJSON(data);
			}
		});		
	});
});

function parseJSON(jsonObj, food_ctgr) {
	var food_ctgr = document.getElementById("foodCategory").value.trim();
	var row = jsonObj.Grid_20150827000000000226_1.row;
	var i;
	
	/*var table = "<tr><th>음식 이름</th><th>설명</th><th>사진</th></tr>";*/
	var table = "";
	
	if(food_ctgr == "all_food") {
		$("#recipeList").html("");
		
		for(i = 0; i < row.length; i++) {
			if(keyword == row[i].RECIPE_NM_KO){
				table += "<tr>";
				table += "<td class='tableCT'>" + row[i].RECIPE_NM_KO + "</td>" + "<br>";
				table += "<td class='tablePD'>" + row[i].SUMRY + "</td>";
				table += "<td>" + "<img src='"+row[i].IMG_URL + "' width='100px' height='150'>" + "</td>";
				table += "<td class='tableCT'>" + "<a href='" + row[i].DET_URL + "'>" + "자세히 보기" + "</a>" +"&nbsp</td>";
				table += "</tr>";
				}
		}
		$("#recipeList").html(table);
		
	} else if(food_ctgr == "korean_food") {
		$("#recipeList").html("");
		
		for(i = 0; i < row.length; i++) {
			if(row[i].NATION_NM == "한식") {
				table += "<tr>";
				table += "<td class='tableCT'>" + row[i].RECIPE_NM_KO + "</td>";
				table += "<td class='tablePD'>" + row[i].SUMRY + "</td>";
				table += "<td>" + "<img src='"+row[i].IMG_URL + "' width='250px' height='250'>" + "</td>";
				table += "<td class='tableCT'>" + "<a href='" + row[i].DET_URL + "'>" + "자세히 보기" + "</a>" +"&nbsp</td>";
				table += "</tr>";
			}
		}
		$("#recipeList").html(table);
		
	} else if(food_ctgr == "chinese_food") {
		$("#recipeList").html("");
		
		for(i = 0; i < row.length; i++) {
			if(row[i].NATION_NM == "중국") {
				table += "<tr>";
				table += "<td class='tableCT'>" + row[i].RECIPE_NM_KO + "</td>";
				table += "<td class='tablePD'>" + row[i].SUMRY + "</td>";
				table += "<td>" + "<img src='"+row[i].IMG_URL + "' width='250px' height='250'>" + "</td>";
				table += "<td class='tableCT'>" + "<a href='" + row[i].DET_URL + "'>" + "자세히 보기" + "</a>" +"&nbsp</td>";
				table += "</tr>";
			}
		}
		$("#recipeList").html(table);
		
	} else if(food_ctgr == "japanese_food") {
		$("#recipeList").html("");
		
		for(i = 0; i < row.length; i++) {
			if(row[i].NATION_NM == "일본") {
				table += "<tr>";
				table += "<td class='tableCT'>" + row[i].RECIPE_NM_KO + "</td>";
				table += "<td class='tablePD'>" + row[i].SUMRY + "</td>";
				table += "<td>" + "<img src='"+row[i].IMG_URL + "' width='250px' height='250'>" + "</td>";
				table += "<td class='tableCT'>" + "<a href='" + row[i].DET_URL + "'>" + "자세히 보기" + "</a>" +"&nbsp</td>";
				table += "</tr>";
			}
		}
		$("#recipeList").html(table);
		
	} else if(food_ctgr == "western_food") {
		$("#recipeList").html("");
		
		for(i = 0; i < row.length; i++) {
			if(row[i].NATION_NM == "서양") {
				table += "<tr>";
				table += "<td class='tableCT'>" + row[i].RECIPE_NM_KO + "</td>";
				table += "<td class='tablePD'>" + row[i].SUMRY + "</td>";
				table += "<td>" + "<img src='"+row[i].IMG_URL + "' width='250px' height='250'>" + "</td>";
				table += "<td class='tableCT'>" + "<a href='" + row[i].DET_URL + "'>" + "자세히 보기" + "</a>" +"&nbsp</td>";
				table += "</tr>";
			}
		}
		$("#recipeList").html(table);
		
	} else {
		$("#recipeList").html("");
		
		for(i = 0; i < row.length; i++) {
			if(row[i].NATION_NM != "한식" && row[i].NATION_NM != "중국" && row[i].NATION_NM != "일본" && row[i].NATION_NM != "서양") {
				table += "<tr>";
				table += "<td class='tableCT'>" + row[i].RECIPE_NM_KO + "</td>";
				table += "<td class='tablePD'>" + row[i].SUMRY + "</td>";
				table += "<td>" + "<img src='"+row[i].IMG_URL + "' width='250px' height='250'>" + "</td>";
				table += "<td class='tableCT'>" + "<a href='" + row[i].DET_URL + "'>" + "자세히 보기" + "</a>" +"&nbsp</td>";
				table += "</tr>";
			}
		}
		$("#recipeList").html(table);
	}
}

function noRun() {
	if(food_ctgr == "all_food") {
		$("#recipeList").html("");
		
		for(i = 0; i < row.length; i++) {
			table += "<tr>";
			table += "<td>" + row[i].RECIPE_NM_KO + "</td>";
			table += "<td>" + row[i].SUMRY + "</td>";
			table += "<td>" + "<img src='"+row[i].IMG_URL + "' width='250px' height='250'>" + "</td>";
			table += "<td>" + "<a href='" + row[i].DET_URL + "'>" + "자세히 보기&nbsp&nbsp&nbsp" + "</a>" +"&nbsp</td>";
			table += "</tr>";
		}
		$("#recipeList").html(table);
		
	} else if(food_ctgr == "korean_food") {
		$("#recipeList").html("");
		
		for(i = 0; i < row.length; i++) {
			if(row[i].NATION_NM == "한식") {
				table += "<tr>";
				table += "<td>" + row[i].RECIPE_NM_KO + "</td>";
				table += "<td>" + row[i].SUMRY + "</td>";
				table += "<td>" + "<img src='"+row[i].IMG_URL + "' width='250px' height='250'>" + "</td>";
				table += "<td>" + "<a href='" + row[i].DET_URL + "'>" + "자세히 보기&nbsp&nbsp&nbsp" + "</a>" +"&nbsp</td>";
				table += "</tr>";
			}
		}
		
	} else if(food_ctgr == "chinese_food") {
		$("#recipeList").html("");
		
		for(i = 0; i < row.length; i++) {
			if(row[i].NATION_NM == "중국") {
				table += "<tr>";
				table += "<td>" + row[i].RECIPE_NM_KO + "</td>";
				table += "<td>" + row[i].SUMRY + "</td>";
				table += "<td>" + "<img src='"+row[i].IMG_URL + "' width='250px' height='250'>" + "</td>";
				table += "<td>" + "<a href='" + row[i].DET_URL + "'>" + "자세히 보기&nbsp&nbsp&nbsp" + "</a>" +"&nbsp</td>";
				table += "</tr>";
			}
		}
		
	} else if(food_ctgr == "japanese_food") {
		$("#recipeList").html("");
		
		for(i = 0; i < row.length; i++) {
			if(row[i].NATION_NM == "일본") {
				table += "<tr>";
				table += "<td>" + row[i].RECIPE_NM_KO + "</td>";
				table += "<td>" + row[i].SUMRY + "</td>";
				table += "<td>" + "<img src='"+row[i].IMG_URL + "' width='250px' height='250'>" + "</td>";
				table += "<td>" + "<a href='" + row[i].DET_URL + "'>" + "자세히 보기&nbsp&nbsp&nbsp" + "</a>" +"&nbsp</td>";
				table += "</tr>";
			}
		}
		
	} else if(food_ctgr == "western_food") {
		$("#recipeList").html("");
		
		for(i = 0; i < row.length; i++) {
			if(row[i].NATION_NM == "서양") {
				table += "<tr>";
				table += "<td>" + row[i].RECIPE_NM_KO + "</td>";
				table += "<td>" + row[i].SUMRY + "</td>";
				table += "<td>" + "<img src='"+row[i].IMG_URL + "' width='250px' height='250'>" + "</td>";
				table += "<td>" + "<a href='" + row[i].DET_URL + "'>" + "자세히 보기&nbsp&nbsp&nbsp" + "</a>" +"&nbsp</td>";
				table += "</tr>";
			}
		}
		
	} else {
		$("#recipeList").html("");
		
		for(i = 0; i < row.length; i++) {
			if(row[i].NATION_NM != "한식" || row[i].NATION_NM != "중국" || row[i].NATION_NM != "일본" || row[i].NATION_NM != "서양") {
				table += "<tr>";
				table += "<td>" + row[i].RECIPE_NM_KO + "</td>";
				table += "<td>" + row[i].SUMRY + "</td>";
				table += "<td>" + "<img src='"+row[i].IMG_URL + "' width='250px' height='250'>" + "</td>";
				table += "<td>" + "<a href='" + row[i].DET_URL + "'>" + "자세히 보기&nbsp&nbsp&nbsp" + "</a>" +"&nbsp</td>";
				table += "</tr>";
			}
		}
	}
}




</script>
</html>