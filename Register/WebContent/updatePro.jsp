<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@page import="java.sql.*" %>

<%@include file="loginCheck.jspf" %>
<%
request.setCharacterEncoding("utf-8");


String passwd= request.getParameter("passwd");
String name= request.getParameter("name");
int age = Integer.parseInt(request.getParameter("age"));
String gender= request.getParameter("gender");
String email= request.getParameter("email");

//db연결정보
String url="jdbc:mysql://localhost/register?serverTimezone=UTC";
String user="root1";
String pwd="1234";

//jdbc참조변수
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs =null;
//1. 드라이버 로딩
Class.forName("com.mysql.cj.jdbc.Driver");
//DB연결
con= DriverManager.getConnection(url,user,pwd);

//3.ID에 해당하는 passwd가져오기
String sql= "SELECT passwd FROM register WHERE id=?";
pstmt=con.prepareStatement(sql);
pstmt.setString(1,id);

rs= pstmt.executeQuery();


	if(rs.next()){
		if(passwd.equals(rs.getString("passwd"))){
			pstmt.close();
			pstmt=null;
			
			sql="UPDATE register SET name=?,age=?,gender=?,email=? WHERE id=?";
			pstmt= con.prepareStatement(sql);
			pstmt.setString(1,name);
			pstmt.setInt(2,age);
			pstmt.setString(3,gender);
			pstmt.setString(4,email);
			pstmt.setString(5,id);
			//실행
			pstmt.executeUpdate();
		
			%>
			<script>
			alert('수정 성공');
			location.href='loginMain.jsp';
			</script>
			<%
		}else{
			%>
			<script>
			alert('패스워드 틀림');
			history.back();
			</script>
			<%
		}}
%>
