<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% // Controller 로부터 결과 데이터 받음.
	int res = (Integer)request.getAttribute("loginResult");
	System.out.println("signInOk session: "+session.getAttribute("sessionID"));
%>

<%-- 위에서 필요한 트랜잭션이 마무리 되면 페이지에 보여주기 --%>
<% if(res == 1){ %>
	<script>
		location.href="index.do";
	</script>
<% } else if(res == -1){ %>
	<script>
		alert("존재하지 않는 아이디입니다.");
		history.back();
	</script>
<% } else{ %>
	<script>
		alert("비밀번호를 다시 확인해주세요.");
		history.back();
	</script>
<%} %>
