<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String id=(String)session.getAttribute("id");

 if(id==null){
	 response.sendRedirect("SessionLogin.jsp");
 }

%>
<h1>sessionMain.jsp 메인 페이지</h1>
<hr>
<%=id %>님이 로그인 하셧습니다.<br>
 <input type="button" value="로그아웃" onclick="location.href='sessionLogout.jsp'">





</body>
</html>