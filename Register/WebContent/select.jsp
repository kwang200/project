<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.Connection" %>
    <%@page import="java.sql.PreparedStatement" %>
    <%@page import="java.sql.DriverManager" %>
      <%@page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String id=(String) session.getAttribute("id");
String level=(String) session.getAttribute("level");
if(id==null || !level.equals("9")){
	response.sendRedirect("main");
   return;	
}
%>
<h1>전체회원조회</h1>
<hr>
<table border="1">
 <tr>
 <th>아이디</th><th>패스워드</th><th>이름</th><th>나이</th><th>성별</th><th>이메일</th><th>가입날짜</th><th>등급</th>
 </tr>

<%
//DB연결정보
String url="jdbc:mysql://localhost/register?serverTimezone=UTC";
String user="root1";
String pwd="1234";

Connection con=null;
PreparedStatement pstmt=null;
String sql="";
ResultSet rs=null;

Class.forName("com.mysql.cj.jdbc.Driver");

con= DriverManager.getConnection(url,user,pwd);

sql="SELECT * FROM register";
pstmt=con.prepareStatement(sql);

rs=pstmt.executeQuery();

while(rs.next()){
	
	%>
	<tr>
	<td><%=rs.getString("id") %></td>
	<td><%=rs.getString("passwd") %></td>
	<td><%=rs.getString("name") %></td>
    <td><%=rs.getInt("age") %></td>
	<td><%=rs.getString("gender") %></td>
	<td><%=rs.getString("email") %></td>			
	<td><%=rs.getString("reg_date") %></td>
	<td><%=rs.getString("level") %></td>
    </tr>
    
    <%
}
%>

</table>
<input type="button" value="회원수정" onclick="location.href=''">
<input type="button" value="마이페이지" onclick="location.href='loginMain.jsp'">
<%


rs.close();
pstmt.close();
con.close();


%>
</body>
</html>