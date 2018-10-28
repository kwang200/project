<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.DriverManager" %>
     <%@page import="java.sql.PreparedStatement" %>
     <%@page import="java.sql.Connection" %>
    <%@page import="java.sql.Timestamp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String id =request.getParameter("id");
String passwd =request.getParameter("passwd");
String name =request.getParameter("name");

Timestamp reg_date= new Timestamp(System.currentTimeMillis());

String url="jdbc:mysql://localhost/register?serverTimezone=UTC";
String user="root1";
String pwd="1234";

Connection con=null;
PreparedStatement pstmt =null;
String sql="";

Class.forName("com.mysql.cj.jdbc.Driver");
con= DriverManager.getConnection(url,user,pwd);
out.println("연결성공<br>");

sql="INSERT INTO register(id,passwd,name,reg_date) VALUES(?,?,?,?)";
pstmt=con.prepareStatement(sql);
pstmt.setString(1,id);
pstmt.setString(2,passwd);
pstmt.setString(3,name);
pstmt.setTimestamp(7,reg_date);


pstmt.executeUpdate();
out.println("회원가입성공");

pstmt.close();
con.close();


%>
</body>
</html>