<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="loginCheck.jspf" %>
<%

 String passwd="";
 String name="";
 int age=0;
 String gender="";
 String email="";
 Timestamp reg_date=null;
 
 String url="jdbc:mysql://localhost/register?serverTimezone=UTC";
 String user="root1";
 String pwd="1234";
 
 //JDBC변수
 Connection con=null;
 PreparedStatement pstmt =null;
 ResultSet rs= null;
 
  Class.forName("com.mysql.cj.jdbc.Driver");
  
  con=DriverManager.getConnection(url,user,pwd);

  String sql="SELECT *FROM register WHERE id=?";
  
  pstmt=con.prepareStatement(sql);
  pstmt.setString(1,id);
  
   rs= pstmt.executeQuery();
   
   if(rs.next()){
	   passwd=rs.getString("passwd");
	   name=rs.getString("name");
	   age=rs.getInt("age");
	   gender=rs.getString("gender");
	   email=rs.getString("email");
	   reg_date=rs.getTimestamp("reg_date");
   }
 %>
<h1>회원수정</h1>
<hr>
<form action="updatePro.jsp" method="post">
아이디 : <input type="text" name="id" value="<%=id %>" readonly><br>
패스워드: <input type="password" name="passwd"><br>
이름 :<input type="text" name="name" value="<%=name%>"><br>
나이 :<input type="text" name="age" min="0" max="100" value="<%=age%>"><br>
성별 :<input type="radio" name="gender" value="남"
  <%if(gender!=null && gender.equals("남")){ %>checked<% }%>>남자
<input type="radio" name="gender" value="여자"
<%if(gender!=null && gender.equals("여")){ %>checked<% }%>>여자 <br>
이메일 : <input type="email" name="email"><br><br>
<input type="submit" value="회원수정">
<input type="button" value="로그인 화면으로 이동 " onclick="location.href='loginMain.jsp'">
</form>
</body>
</html>