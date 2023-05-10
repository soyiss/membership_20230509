<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-10
  Time: 오후 4:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="/resources/css/main.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>

<%@include file="../conponent/header.jsp"%>
<%@include file="../conponent/nav.jsp"%>
<div id="section">
  <form action="/member/updatePass" method="post" name="updateForm">
  <input type="text" name="memberPassword" id="memberPassword" placeholder="현재 비밀번호를 입력해주세요">
  <input type="button" onclick="pass_check()" value="비밀번호 확인">
</div>

<%@include file="../conponent/footer.jsp"%>
</body>
<script>
  // 비밀번호 확인 메소드
  const pass_check = () => {
    //  확인할 비밀번호
    const inputPass = document.getElementById("memberPassword").value;
    // 서버에 저장되있는 비밀번호
    const DBPass = '${member.memberPassword}';
    if (inputPass == DBPass) {
      document.updateForm.submit();
    } else {
      alert("비밀번호가 일치하지 않습니다! 다시 입력해주세요");
    }
  }
</script>
</html>
