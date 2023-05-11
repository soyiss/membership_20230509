<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-10
  Time: 오전 8:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="/resources/css/main.css">
  <link rel="stylesheet" href="/resources/image/main.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>

<%@include file="../conponent/header.jsp"%>
<%@include file="../conponent/nav.jsp"%>
<div id="section">

  ${sessionScope.loginEmail} 님의 MyPage!
    <div id="file">
    <c:if test="${member.memberProfile == 1}">
        <img src="${pageContext.request.contextPath}/upload/${memberFile.storedFileName}" alt="" width="100" height="100">
    </c:if>
    <c:if test="${member.memberProfile == 0}">
      <img src="/resources/image/기본%20프로필.png" alt="" width="100" height="100">
    </c:if>
    </div>
    <c:if test="${sessionScope.loginEmail != 'admin'}">
      <button onclick="update()">회원정보수정</button>
      <button onclick="member_delete()">회원탈퇴</button>
    </c:if>


</div>

<%@include file="../conponent/footer.jsp"%>
</body>
<script>
  const update = () => {
    location.href="/member/updatePass";
  }

  const member_delete = () => {
    location.href="/member/deletePass";
  }


</script>
</html>
