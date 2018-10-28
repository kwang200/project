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
String id = request.getParameter("id");
String passwd=request.getParameter("passwd");

String dbId="admin";
String dbPass="1234";

if(id.equals(dbId)){
	if(passwd.equals(dbPass)){
		session.setAttribute("id", id);
		out.println("로그인 인증됨<br>");
		response.sendRedirect("sessionMain.jsp");
	%>
	<script>
	 alert('로그인 인증되었습니다.');
	 location.href='sessionMain.jsp';
	</script>
	<%
	}else{
		out.println("패스워드 틀림<br>");
		
	}}
    else{
		out.println("아이디 없음");
	}


%>


</body>
</html>