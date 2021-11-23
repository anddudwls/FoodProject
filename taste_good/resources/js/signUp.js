/*변수 선언*/


var id = document.querySelector('#id');

var pw1 = document.querySelector('#pswd1');

var pw2 = document.querySelector('#pswd2');
var pwMsgArea = document.querySelector('.int_pass');

var userName = document.querySelector('#name');


var gender = document.querySelector('#gender');

var email = document.querySelector('#email');

var mobile = document.querySelector('#mobile');

var address1 = document.querySelector('#address1');

var error = document.querySelectorAll('.error_next_box');



/*이벤트 핸들러 연결*/


id.addEventListener("focusout", checkId);
pw1.addEventListener("focusout", checkPw);
pw2.addEventListener("focusout", comparePw);
userName.addEventListener("focusout", checkName);
gender.addEventListener("focusout", function() {
 /*   if(gender.value === "") {
        error[4].style.display = "none";
    } else {
        error[4].style.display = "none";
    }
*/
})
email.addEventListener("focusout", isEmailCorrect);
mobile.addEventListener("focusout", checkPhoneNum);
address1.addEventListener("focusout", checkAddress);





/*콜백 함수*/

function checkAddress(){
	if(address1.value===""){
		error[7].style.display="none";
	}else{
		error[7].style.display="none";
	}
	
}


function checkId() {
    if(id.value === "") {
        error[0].innerHTML = "필수 정보입니다.";
        error[0].style.display = "block";
    }else{
		error[0].style.display = "none";
	}
}

function checkPw() {
    var pwPattern = /[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,16}/;
    if(pw1.value === "") {
        error[1].innerHTML = "필수 정보입니다.";
        error[1].style.display = "block";
/*    } else if(!pwPattern.test(pw1.value)) {
        error[1].innerHTML = "8~16자 영문 대소문자, 숫자, 특수문자를 사용하세요.";
        pwMsgArea.style.paddingRight = "93px";
        error[1].style.display = "block";*/
    } else {
        error[1].style.display = "none";

    }
}

function comparePw() {
    if(pw2.value === pw1.value && pw2.value !== "") {
        error[2].style.display = "none";
    } else if(pw2.value !== pw1.value) {
        error[2].innerHTML = "비밀번호가 일치하지 않습니다.";
        error[2].style.display = "block";
    } 

    if(pw2.value === "") {
        error[2].innerHTML = "필수 정보입니다.";
        error[2].style.display = "block";
    }
}

function checkName() {
    var namePattern = /[a-zA-Z가-힣]/;
    if(userName.value === "") {
        error[3].innerHTML = "필수 정보입니다.";
        error[3].style.display = "block";
    } else if(!namePattern.test(userName.value) || userName.value.indexOf(" ") > -1) {
        error[3].innerHTML = "한글과 영문 대소문자를 사용하세요. (특수기호, 공백 사용 불가)";
        error[3].style.display = "block";
    } else {
        error[3].style.display = "none";
    }
}




function isEmailCorrect() {
    var emailPattern = /[a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/;

    if(email.value === ""){ 
        error[6].style.display = "none"; 
    } else if(!emailPattern.test(email.value)) {
        error[6].style.display = "block";
    } else {
        error[6].style.display = "none"; 
    }

}

function checkPhoneNum() {
    var isPhoneNum = /([01]{2})([01679]{1})-([0-9]{3,4})-([0-9]{4})/;

    if(mobile.value === "") {
        error[5].style.display = "none";
    } else if(!isPhoneNum.test(mobile.value)) {
        error[5].innerHTML = "형식에 맞지 않는 번호입니다.";
        error[5].style.display = "block";
    } else {
        error[5].style.display = "none";
    }

    
}
