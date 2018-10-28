<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="updatePro.jsp" method="post">
  아이디:<input type="text" name="id"><br>
  비밀번호:<input type="password" name="passwd"><br>
  수정할 이름 이름:<input type="text" name="name"><br>
  <input type="submit" value="회원수정">
</form>
</body>
</html>