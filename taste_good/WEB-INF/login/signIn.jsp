<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>로그인</title>
    <%@ include file="/WEB-INF/include/include-path.jspf" %>
    <link rel="icon" href="${path1 }/img/core-img/favicon.ico">
   <link rel="stylesheet" href="${path1 }/css/style.css">
    <style>
		.container_signin {
			text-align: center;
			width: 385px;
			line-height: 50px;
			margin: 40px auto;
		}
		
		.login_signin {
			background-color: #474747;
			color: white;
			border-radius: 5px;
			border: 0;
			width : 380px;
			height: 50px;
			white-space:nowrap;
		}
	</style>
	

</head>

<body>

    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>	
    
	<c:if test="${sessionID != null }">
		<script>
			alert("이미 로그인 중입니다.");
			location.href = "index.do";
		</script>
	</c:if>
	<div class="container_signin">
        <h5 style="color: #474747; text-align:"center"><span>로그인</span></h5>
        <form action="signInOk.do" method="post">
            <input type="text" placeholder=" 아이디" name="id" required style="height:30px; width: 380px; border: 1px solid lightgray; border-radius: 3px;" /><br />
            <input type="password" placeholder=" 비밀번호" name="pass" required style="height:30px; width: 380px; border: 1px solid lightgray; border-radius: 3px;" /><br />
            <button type="submit" class="login_signin">로그인</button><br>
            <button onclick="location.href='index.do';" class="login_signin" style="top:8px; position:relative" >HOME</button>
        </form>
        <button onclick="location.href='signUp.do';" class="login_signin" style="top:15px; position:relative">회원가입</button>
    </div>
    <br><br><br><br><br>
    
     <!-- 푸터 -->
    <jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>	
</body>
</html>