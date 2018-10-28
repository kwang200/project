<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//세션값 가져오기 (Object형으로 가져오기 때문에 다운캐스팅)

String id =(String) session.getAttribute("id");
String level=(String) session.getAttribute("level");//session 내장객체 getattribute는 메소드 <==
   if(id==null){
	   response.sendRedirect("loginForm.jsp");
	   return;
	   //리턴없으면 아래문장 접근하고 없이 접근하면 
	   //if(id.equals("admin"))에서 오류발생 (nullPointerException)
   }

%>
<h1>메인페이지</h1>
<hr>
<%=id %>님이 로그인 하셨습니다.<br>
<input type="button" value="로그아웃" onclick="location.href='logout.jsp'"><br>

<a href="info.jsp">회원정보조회</a><br>
<a href="update.jsp">회원정보수정</a><br>
<a href="deleteForm.jsp">회원정보삭제</a><br>

<%


if(level.equals("9")){
	%>
	마스터계정
	<a href="select.jsp">전체회원목록</a>
	<% 
}
%>



</body>
</html>