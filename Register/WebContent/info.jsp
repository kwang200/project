<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
 //세션값 가져오기 
 String id = (String) session.getAttribute("id");
if(id==null){
	response.sendRedirect("loginForm.jsp");
	return;
}
//변수 선언
String passwd="";
String name="";
Timestamp reg_date=null;
int age=0;
String gender="";
String email="";

String url ="jdbc:mysql://localhost/register?serverTimezone=UTC";
String user ="root1";
String pwd ="1234";

//JDBC 변수
Connection con = null;
PreparedStatement pstmt =null;
ResultSet rs= null;

//드라이버 로딩
Class.forName("com.mysql.cj.jdbc.Driver");

//연결
con= DriverManager.getConnection(url,user,pwd);
//sql id에해당되는 정보전부 들고오기

String sql= "SELECT *FROM register WHERE id=?";
 pstmt=con.prepareStatement(sql);
 pstmt.setString(1,id);
 
 rs=pstmt.executeQuery();
 
 if(rs.next()){
	 passwd= rs.getString("passwd");
	 name= rs.getString("name");
	 age= rs.getInt("age");
	 gender= rs.getString("gender");
	 email=rs.getString("email");
	 reg_date=rs.getTimestamp("reg_date");
 }
%>
<h1>회원정보 조회</h1>
<hr>
아이디:<%=id %><br>
패스워드:<%=passwd %><br>
이름:<%=name %><br>
나이:<%=age %><br>
성별:<%=gender %><br>
이메일:<%=email %><br>
가입일:<%=reg_date %><br>

<br>
<a href="loginMain.jsp">마이페이지</a>


</body>
</html>