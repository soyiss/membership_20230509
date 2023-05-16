<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오후 5:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
      .memberLogin1{
       text-align: center;
      }

    </style>
</head>
<body>

<%@include file="../conponent/header.jsp" %>
<%@include file="../conponent/nav.jsp" %>
<br>
<div id="section">

    <form action="/member/login" method="post" id="save-form">
        <div class="memberLogin1">
            <input type="text" name="memberEmail" id="member-email" placeholder="이메일"><br>
            <p></p>
            <input type="text" name="memberPassword" id="member-password" placeholder="비밀번호"><br>
            <p></p>
            <input type="submit" value="login">
        </div>
    </form>
</div>

<%@include file="../conponent/footer.jsp" %>
</body>
<script>
    <!-- 이벤트 리스너 적용 -->
    const saveForm = document.getElementById("save-form");
    saveForm.addEventListener("submit", function (e) {
        e.preventDefault(); // 해당 요소의 기본 동작을 수행하지 않을 때
        // 로그인 버튼을 아무리 눌러도 서브밋을 막음

        const email = document.getElementById("member-email");
        const password = document.getElementById("member-password");
        if (email.value == "") {
            alert("이메일을 입력하세요");
            email.focus();
        } else if (password.value == "") {
            alert("비밀번호를 입력하세요");
            password.focus();
        } else {
            saveForm.submit();
        }

    });
</script>
</html>
