<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복확인</title>
</head>
<script>
function blankCheck(p){
	var id=p.id.value;
	id=id.trim();
	if(id==""){
		alert("아이디를 입력해주세요");
		return false;
	}
	return true;
}
</script>
<body>
	<div style="text-align: center;">
		<form method="post" action="idCheckProc.do" onsubmit="return blankCheck(this)">
			아이디: <input type="text" name="id" maxlength="50" autofocus>
			<input type="submit" value="중복확인">
		</form>
	</div>
</body>
</html>
	