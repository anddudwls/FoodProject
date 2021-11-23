<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <title>작성</title>
</head>
<script>
// form 검증(validation)
function chkSubmit(){
	
	frm = document.forms['frm'];
	
	var name = frm['name'].value.trim();
	var subject = frm['subject'].value.trim();
	
	if(name == ""){
		alert("작성자는 반드시 입력해야 합니다");
		frm['name'].focus();
		return false;
	}
	
	if(subject == ""){
		alert("제목은 반드시 작성해야 합니다");
		frm["subject"].focus();
		return false;
	}
	
	return true;	
}
</script>
<body>
	<div class="container mt-3">
		<h2>글작성</h2>
		<hr>
		<%-- 글 내용이 많을수 있기 때문에 POST 방식 사용 --%>
		<form name="frm" action="writeOk.do" method="post" onsubmit="return chkSubmit()">
            <div class="mb-3">
                <label for="name">작성자:</label>
                <input type="text" class="form-control" id="name" placeholder="작성자를 입력하세요" name="name">
            </div>
            <div class="mb-3 mt-3">
                <label for="subject">제목:</label>
                <input type="text" class="form-control" id="subject" placeholder="제목을 입력하세요" name="subject">
            </div>
            <div class="mb-3 mt-3">
                <label for="content">내용:</label>
                <textarea class="form-control" rows="5" id="content" placeholder="내용을 입력하세요" name="content"></textarea>
            </div>

            <button type="submit" class="btn btn-outline-dark">작성완료</button>
            <button type="button" class="btn btn-outline-dark" onclick="location.href='list.do'">목록</button>
		</form>
	</div>
</body>
</html>
















