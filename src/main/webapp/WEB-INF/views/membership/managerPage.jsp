<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-11
  Time: 오전 11:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="/resources/css/main.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <style>

    #section table{
      margin: 0 auto;
      margin-top: 50px;
    }
    #section table tr,th,td{
      text-align: center;
      border: solid 1px black;
      padding: 10px 20px;
    }
  </style>
</head>
<body>

<%@include file="../conponent/header.jsp"%>
<%@include file="../conponent/nav.jsp"%>
<div id="section">
  <table>
    <tr>
      <th>id</th>
      <th>memberEmail</th>
      <th>memberName</th>
      <th>memberMobile</th>
      <th>회원 삭제</th>
    </tr>
    <c:forEach items="${memberList}" var="member">
      <tr>
        <td>${member.id}</td>
        <td>${member.memberEmail}</td>
        <td>${member.memberName}</td>
        <td>${member.memberMobile}</td>
        <td>
          <button onclick="manager('${member.id}')">회원삭제</button>
        </td>
      </tr>
    </c:forEach>
  </table>
</div>

<%@include file="../conponent/footer.jsp"%>
</body>
<script>
  const manager = (id) => {
    location.href="/member/managerDelete?id="+id;

  }
</script>
</html>
