<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include-path.jspf" %>
<!DOCTYPE html>
<html lang="en">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>회원 가입</title>
    <link rel="stylesheet" href="${path1 }/css/style.css">
    
    <style>
        .login_container {
            width: 500px;
            margin: 40px auto;
            line-height: 16px;
        } 
        h5 {
            text-align: center;
        }
        h5 span {
            color: #474747;
        }
        .n {
            font-size: 13px;
        }
        #signup {
            background-color: #474747;
            color: white;
            border: 0;
            border-radius: 5px;
            padding: 10px 224px;
        }
        .bottom input {
            background-color: white;
            border: 0;
            color: teal;
            font-size: 16px;
        }
        i {
            color: lightgray;
        }
        input {
            border: 1px solid lightgray !important;
            border-radius: 3px;
        }
        select{
        	height:35px; 
        	width: 500px;
        	border: 1px solid lightgray;
        	border-radius: 3px;
        	color:gray;
        	font-size:13px;
        	/* -webkit-appearance: none; */
        	/* appearance: none; */
        }
       
	.error_next_box {
	  margin-top: 9px;
	  font-size: 12px;
	  color: red;    
	  display: none;
	}
	
	#alertTxt {
	  position: absolute;
	  top: 19px;
	  right: 38px;
	  font-size: 12px;
	  color: red;
	  display: none;
	}
	
	.box.int_id {
  		padding-right: 40px;
	}

	.box.int_pass {
  		padding-right: 40px;
	}

	.box.int_pass_check {
  		padding-right: 40px;
	}
	
    </style>
</head>

<script>
// form 검증(validation)
function chkSubmit(){
	
	frm = document.forms['frm'];
	
	var id = frm['id'].value.trim();
	var pass = frm['pass'].value.trim();
	var pass_check = frm['pass_check'].value.trim();
	var name = frm['name'].value.trim();
	var gender = frm['gender'].value.trim();
	var tel = frm['tel'].value.trim();
	var email = frm['email'].value.trim();
	var address1 = frm['address1'].value.trim();
	var address2 = frm['address2'].value.trim();
	
	if(id == ""){
		alert("아이디를 입력해주요.");
		frm['id'].focus();
		return false;
	}
	
	if(pass == ""){
		alert("비밀번호를 입력해주세요.");
		frm["pass"].focus();
		return false;
	}
	
	if(pass != pass_check){
		alert("입력하신 두 개의 비밀번호가 일치하지 않습니다.");
		frm["pass_check"].focus();
		return false;
	}
	
	if(name == ""){
		alert("이름을 입력해주세요.");
		frm["name"].focus();
		return false;
	}
	
/* 	if(gender == ""){
		alert("성별을 입력해주세요.");
		frm["gender"].focus();
		return false;
	} */
	
/* 	if(email == ""){
		alert("이메일을 입력해주세요.");
		frm["email"].focus();
		return false;
	} */
	
/* 	if(address1 == ""){
		alert("주소를 입력해주세요.");
		frm["address1"].focus();
		return false;
	} */
	
	return true;	
}

function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("address1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}

function idCheck(){
	//아이디 중복확인
	window.open("idCheckForm.do", "idwin", "width=400 height=350")
}//idCheck



</script>

<body>
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>	
    
    <div class="login_container">
        <h5><span>회원 가입</span></h5>
        <hr /><br />
        <form name="frm" action="signUpOk.do" method="post" onsubmit="return chkSubmit()">
        	<div>
        		<span class="box int_id">
            		<input type="text" id="id" placeholder=" 아이디" name="id" style= "width: 40%; height: 30px;" readonly />
		            <input type="button" value="중복체크" onclick="idCheck()"><br>
            	</span>
            	<span class="error_next_box"></span>
            </div><br>
            
            <div>
            	<span class="box int_pass">
            		<input type="password" id="pswd1" placeholder=" 비밀번호" name="pass" style="height:30px; width: 495px" /><br />
					<span id="alertTxt">사용불가</span>
            	</span>
            	<span class="error_next_box"></span><br />
            </div>
            
            <div>
            	<span class="box int_pass_check">
            		<input type="password" id="pswd2" placeholder=" 비밀번호 확인" name="pass_check" style="height:30px; width: 495px" /><br />
            	</span>
            	<span class="error_next_box"></span><br>
            </div>
            
            <div>
            	<span class="box int_name">
            		<input type="text" id="name" placeholder=" 이름" name="name" style="height:30px; width: 495px" /><br />
 				</span>
 				<span class="error_next_box"></span><br>
            </div>
            
            <div>
            	<span class="box gender_code">
		            <select id="gender" name="gender">
		            	<option value=""> 성별 선택</option>
		            	<option value="M" style="font-color: black">남</option>
		            	<option value="F" style="font-color: black">여</option>
				    </select><br />
			    </span>
 			    <span class="error_next_box"></span><br> <!-- 성별을 선택해주세요. -->
		 	</div>   
		 
			<div>
				<span class="box int_mobile">		 
            		<input type="tel" id="mobile" placeholder=" 전화번호(xxx-xxxx-xxxx)" name="tel" style="height:30px; width: 495px" /><br />
            	</span>
            	<span class="error_next_box"></span><br>
            </div>
            
 			<div>
				<span class="box int_email">		 
            		<input type="text" id="email" placeholder=" 이메일" name="email" style="height:30px; width: 495px" /><br />
            	</span>
            	<span class="error_next_box">이메일 형식을 다시 확인해주세요.</span><br>
            </div>           
            
			<input type="text" id="sample6_postcode" placeholder=" 우편번호" style= "width: 40%; height: 30px;" readonly/>
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br><br>
			
			 <div>
				<span class="box int_address1">		 
            		<input type="text" id="address1" name="address1" id="sample6_address" placeholder=" 주소" style="height:30px; width: 495px" readonly><br>
            	</span>
            	<span class="error_next_box"></span><br>
            </div>  
			
			<input type="text" name="address2" id="sample6_detailAddress" placeholder=" 상세주소" style="height:30px; width: 495px"><br><br>
			<input type="text" id="sample6_extraAddress" placeholder=" 참고항목" style="height:30px; width: 495px">
            <p><br>
            <input type="submit" value="가입하기" id="signup" /><br /><br />
            </p>
        </form>
        <hr />
    </div>
	
	<!-- 푸터 -->
    <jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>	
    <script src="${path1 }/js/signUp.js"></script>
</body>
</html>