<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.lec.beans.*" %>
<jsp:useBean id = "dao" class="com.lec.beans.UserDAO"/> <%-- DAO bean 생성 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복확인 결과</title>
</head>
<script>
	function apply(id){
		opener.document.frm.id.value=id;
		window.close();
	}
</script>
<body>
	<div style="text-align: center;">
	<%
		String id = request.getParameter("id").trim();
		int cnt = dao.checkId(id);
		if(cnt ==0){
			out.println("<p>사용 가능한 아이디입니다.</p>");
			out.println("<a href='javascript:apply(\""+id+"\")'>[적용]</a>");
		}else{
			out.println("<p style='color:red'>해당 아이디는 사용할 수 없습니다.</p>");
		}
	%>
		<hr>
		<a href="javascript:history.back()">[다시검색]</a>
		<a href="javascript:window.close()">[창닫기]</a>
	</div>
</body>
</html>