<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-10
  Time: 오전 8:51
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

<%@include file="./conponent/header.jsp"%>
<%@include file="./conponent/nav.jsp"%>
<div id="section">
  ${sessionScope.loginEmail} 님 환영해요!
    <button onclick="update()">회원정보수정</button>

</div>

<%@include file="./conponent/footer.jsp"%>
</body>
<script>
  const update = () => {
    location.href="/member/updatePass";
  }
</script>
</html>
