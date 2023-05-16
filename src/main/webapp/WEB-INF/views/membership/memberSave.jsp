<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오후 3:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

    <style>
        .save1{
            text-align: center;
        }

    </style>
</head>
<body>

<%@include file="../conponent/header.jsp" %>
<%@include file="../conponent/nav.jsp" %>
<br>
<div id="section">

    <form action="/member/save" method="post" id="save-form" enctype="multipart/form-data">
        <div class="save1">
            <input type="text" name="memberEmail" placeholder="이메일" id="member-email" onblur="email_check()"><br>
            <p id="check-result"></p>
            <input type="text" name="memberPassword" placeholder="비밀번호" id="member-password"
                   onblur="password_check()"><br>
            <p id="pass-rule"></p>
            <input type="text" name="memberName" id="member-name" placeholder="이름"><br>
            <p></p>
            <input type="text" name="memberMobile" placeholder="전화번호" id="member-mobile" onblur="mobile_check()"><br>
            <p id="mobile-rule"></p>
            <input type="file" name="memberFile"> <br>
            <input type="submit" value="가입">
        </div>
    </form>
</div>

<%@include file="../conponent/footer.jsp" %>
</body>
<script>


    const email_check = () => {
        const email = document.getElementById("member-email").value;
        const result = document.getElementById("check-result");
        $.ajax({
            type: "post",
            url: "/member/email-check",
            data: {
                "memberEmail": email
            },
            success: function () {
                result.innerHTML = "사용가능한 이메일입니다.";
                result.style.color = "green";
            },
            error: function (err) {
                // 성공이 아닌경우 응답을 err로 받음.
                //err 내부의 status에는 서버에서 응답한 http status code값이 담겨있음.
                //status code 값으로 화면에 출력하는 부분 제어
                console.log(err);
                if (err.status == "409") { //중복되는 경우
                    result.innerHTML = "이미 사용 중인 이메일입니다."
                    result.style.color = "red";
                } else if (err.status == "404") { // 아무값도 입력하지 않은 경우
                    result.innerHTML = "입력해주세요";
                    result.style.color = "red";
                }
            }
        });
    }

    const password_check = () => {

        const password = document.getElementById("member-password").value;
        const rule = document.getElementById("pass-rule");
        const exp = /^(?=.*[a-z])(?=.*\d)(?=.*[-_!#])[A-Za-z\d-_!#]{5,10}$/;

        if (password.match(exp)) {
            rule.innerHTML = "사용가능한 비밀번호입니다.";
            rule.style.color = "green";
            return false;
            //   false면 다음조건이 맞았을때로 들어감
        } else {
            rule.innerHTML = "소문자,숫자,특수문자(-_!# 중) 필수입력 입니다\n5~10글자 내로 입력하세요";
            rule.style.color = "red";
            return true;
            //
        }

    }

    const mobile_check = () => {
        const mobile = document.getElementById("member-mobile").value;
        const rule = document.getElementById("mobile-rule");
        const exp = /^\d{3}-\d{4}-\d{4}$/;

        if (!(mobile.match(exp))) {
            rule.innerHTML = "000 - 0000 - 0000(기호필수)으로 입력해주세요";
            rule.style.color = "red";
            return true;
        } else {
            rule.innerHTML = "입력 가능합니다";
            rule.style.color = "green";
            return false;
        }

    }

    <!-- 이벤트 리스너 적용 -->
    const saveForm = document.getElementById("save-form");
    saveForm.addEventListener("submit", function (e) {
        e.preventDefault(); // 해당 요소의 기본 동작을 수행하지 않을 때
        // 가입하기 버튼을 아무리 눌러도 서브밋을 막음

        const email = document.getElementById("member-email");
        const password = document.getElementById("member-password");
        const name = document.getElementById("member-name");
        const mobile = document.getElementById("member-mobile");
        if (email.value == "") {
            alert("이메일을 입력하세요");
            email.focus();
        } else if (password.value == "") {
            alert("비밀번호를 입력하세요");
            password.focus();
        } else if (name.value == "") {
            alert("이름을 입력하세요");
            name.focus();
        } else if (mobile.value == "") {
            alert("전화번호를 입력하세요");
            mobile.focus();
        } else if (password_check()) {
            alert("비밀번호를 다시입력해주세요 ");
            password.focus();
        } else if (mobile_check()) {
            alert("전화번호를 다시입력해주세요");
            mobile.focus();
        } else {
            saveForm.submit();
        }

    });


</script>
</html>
