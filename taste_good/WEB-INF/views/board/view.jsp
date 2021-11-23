<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/include/include-path.jspf" %>

<c:choose>
	<c:when test="${empty list || fn:length(list) == 0 }">
		<script>
			alert("해당 정보가 삭제되거나 없습니다");
			history.back();
		</script>			
	</c:when>
	<c:otherwise>
		<c:set var="dto" value="${list[0] }"/>	
<%-- Show it on page when transaction is all set --%>

<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<script src="https://kit.fontawesome.com/75154d7b55.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<title>조회 ${dto.subject}</title> 

    <!-- Favicon -->
    <link rel="icon" href="${path1 }/img/core-img/favicon.ico">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="${path1 }/css/style.css">
	<link rel="stylesheet" type="text/css" href="${path1 }/css/board.css">
</head>

	
<script>
function chkDelete(b_num){
	// 삭제 여부, 다시 확인하고 진행
	var r = confirm("삭제하시겠습니까?");
	
	if(r){
		location.href = 'deleteOK.do?b_num=' + b_num;
	}
}
</script>

<body>
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>	

<div class="container contact-form-area mt-3">
	<div class="row">
		<div class="col-12">
            <div class="section-heading" >
                <h3>${dto.subject }</h3>
            </div>
        <div class="col-12">
        	<span class="float-right">작성일: ${dto.regDateTime }</span><br>
            <span class="float-left">게시글 번호: ${dto.b_num }</span>
            <span class="float-right">조회수: ${dto.viewcnt }</span>
        </div>
        
        </div>
    </div>
        <hr>
        <div class="row">
            <div class="col-12 col-lg-6">
           		<label for="kind">분류:</label>
            	<div class="form-control" style="font-size: 1.5em;">				
            	<c:choose>
					<c:when test="${dto.kind == 'suggestion' }">건의</c:when>
					<c:when test="${dto.kind == 'error' }">에러</c:when>
					<c:when test="${dto.kind == 'etc' }">기타</c:when>
					<c:otherwise>기타</c:otherwise>
				</c:choose>
				</div>
            </div> 
            <div class="col-12 col-lg-6">
                <label for="id">작성자:</label>
                 <div class="form-control" style="font-size: 1.5em;">${dto.id }</div>
            </div>    
            <div class="col-12">
                <label for="subject">제목:</label>
                 <div class="form-control" style="font-size: 1.5em;">${dto.subject}</div>
            </div>    
            <div class="col-12">
                <label for="content">내용:</label>
                 <div class="form-control" style="height:500px; overflow:auto; overflow-x:hidden; font-size: 1.5em;" >${dto.content }</div>
            </div>
          </div>
		<!-- 첨부파일목록 -->
		<div class="container">
		<div class="row">
			<div class="col-12 ">
				<label>첨부파일:</label>
				<!--첨부파일 이름, 다운로드 링크 -->
				<ul class="list-group form-control" style="height: auto; overflow: auto;">
					<c:forEach var="fileDto" items="${fileList }">
						<li class="list-group-item"><a href="download.do?f_num=${fileDto.f_num }">${fileDto.source }</a></li>
					</c:forEach>
				</ul>
				<%-- 이미지인 경우 보여주기 --%>
				<c:forEach var="fileDto" items="${fileList }">
					<c:if test="${fileDto.image == true }">
					<div>
						<img src="upload/${fileDto.file }" class="img-thumbnail">
					</div>
					</c:if>
				</c:forEach>
			</div>
		</div>	
		</div>
		<!-- 첨부파일목록 -->
       
         
</div>
	<div class="container">
		<button type="button" class="btn delicious-btn btn-4 m-1" onclick="location.href='update.do?b_num=${dto.b_num}'">수정</button>
		<button type="button" class="btn delicious-btn btn-4 m-1" onclick="location.href='list.do'">목록</button>
		<c:if test = "${sessionID == dto.id }">
		<button type="button" class="btn delicious-btn btn-4 m-1" onclick="chkDelete(${dto.b_num})">삭제</button>
		</c:if>
		<button type="button" class="btn delicious-btn btn-4 m-1" onclick="location.href='write.do'">작성</button>              
	</div>
	
	<hr>
	<script>
	//b_num에 맞는 댓글 목록 가져오기
	$(document).ready(function(){getList();});
    
    var b_num = "${dto.b_num}";
    var pageContext = "${pageContext.request.contextPath}";
    
    function getList(){
       $.ajax({
          url : pageContext + "/commentList.co?b_num=" + b_num,
          type : "get",
          dataType : "json",
          success : showList
       });
    }
    
    //버튼을 누르면 댓글 목록이 보이도록 함.
    function showList(c_list){
       var text = "";
       
       if(c_list != null && c_list.length != 0){
          var i=0;
          $.each(c_list.data, function(index, data){
        	 
             text += "<div id='comment" + (data.c_num) + "'>";
             text += "<p class='c_id col-6 col-lg-3' style='text-align: right; float:right;'>" + data.c_date + "</p>";
             text += "<p class='c_id col-3 col-lg-3' >" + data.c_id + "</p>";
             text += "<div class='c_content form-control' id='c_content' style='width:100%; overflow-wrap: break-word;'><pre>" + data.c_content + "</pre></div><br>"
             
             if("${sessionID}" == data.c_id){
                text += "<input type='button' class='btn btn-secondary' style='float:right;' onclick='updateCommentBtn(" 
                		+ data.c_num + ",\"" + data.c_content + "\",\"" + data.c_id + "\",\"" + data.c_date + "\")' value='수정'>";
                text += "<input type='button' class='btn btn-outline-danger' style='float:right;' onclick='deleteComment(" + data.c_num 
                		+ ")' value='삭제'><br><br><br>";
             }
             text += "</div>";

          });
       }else{
          text = "<p>댓글이 없습니다.</p>";
       }
       
       $("#comments").html(text);
    }
 
    //댓글 등록
    //Get 형식: 입력한 값을 다음 페이지로 전달하고 싶거나, 전달되는 값이 노출되어도 괜찮은 경우 /id=admin?pw=1234
    //post 방식: 전달하는 값을 노출하고 싶지 않을 때(get보다 데이터의 보완성이 높음)
    function comment(){
       var c_content = $("textarea[name='c_content']").val();
       $.ajax({
          url : pageContext + "/commentWrite.co",
          type : 'post',
          data : {'c_id' : "${sessionID }", 'c_content' : c_content, 'b_num' : b_num},
          success : function(){
             $("textarea[name='c_content']").val("");
             getList();
          }
       });
    }
 
    //댓글 삭제
    function deleteComment(c_num){
       $.ajax({
          url : pageContext + "/commentDelete.co?c_num=" + c_num,
          type : 'post',
          data : {'c_num' : c_num, 'b_num': b_num},
          success : function(){
             getList();
          }
       });
    }
    
    function updateCommentBtn(c_num, c_content, c_id, c_date){
        var text = "";
        

        text += "<div id='comment" + c_num + "'>";
        text += "<p class='c_id col-6 col-lg-3' style='text-align: right; float:right;'>" + c_date + "</p>";
        text += "<p class='c_id col-3 col-lg-3' >" + c_id + "</p>";
        text += " <textarea name='c_contentUpdate' id='c_contentUpdate'" +
        			"placeholder='댓글을 작성 해주세요' class='form-control invert' rows='2'></textarea>"              
        text += "<input type='button' class='btn btn-secondary' style='float:right;' onclick='updateComment("+c_num+",\""+ c_content + "\"," + b_num + ")' value='등록'>";
        text += "<input type='button' class='btn btn-outline-danger' style='float:right;' onclick='getList()' value='취소'><br><br><br>";
        
        text += "</div>";
        $("#comment"+c_num).replaceWith(text);
        $("#comment"+c_num+"#c_contentUpdate").focus();
        
     }
    
    
    //댓글 수정
    function updateComment(c_num, c_content, b_num){
    	 var c_content = $("textarea[name='c_contentUpdate']").val();
         $.ajax({
            url : pageContext + "/commentUpdate.co",
            type : 'post',
            data : {'c_num' : c_num, 'c_content' : c_content, 'b_num' : b_num},
            success : function(){
               $("textarea[name='c_content']").val("");
               getList();
            }
         });
      }

 	
	</script>
	<!-- 댓글 -->	
	<section id="one" class="container form-control commentSection">
               <div class="Comments">
                  <div style="text-align: left; font-size: 1.5em;">
                     <p id="userBoardComment">댓글</p>
                  </div>
                  <div>

                  </div>
                  <c:if test="${sessionID != null }">
                  <form method="post" action="#" class="combined input-group mb-2"
                     style="width: auto;">
                     <input type="hidden" name="b_num" value="${dto.b_num }"/>
                     <input type="hidden" name="c_id" value="${sessionID }"/>                    
                     <textarea name="c_content" id="commentsText"
                        placeholder="댓글을 작성 해주세요" class="form-control invert" rows="2"></textarea>

                     <input id="commentConfirm" 
                        type="button" style="float:right;" class="btn btn-secondary" value="등록" onclick="comment()" />
                  </form>
                  <br>
                  </c:if>
               </div>
               
               <form id="comments" class=" form-control combined input-group"
                  style="flex-direction: column; margin: 0; display: contents;">
               </form>
	</section>

	<!-- 댓글 -->	
	
	

<!-- 푸터 -->
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
 	<script src="${path1 }/js/board.js"></script>




</body>
</html>


	</c:otherwise>
</c:choose>













