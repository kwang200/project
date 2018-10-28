<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>

<%
request.setCharacterEncoding("utf-8");

//입력값들 받아와서 변수에 다시넣기
String id=request.getParameter("id");
String passwd=request.getParameter("passwd");
String name=request.getParameter("name");
int age=Integer.parseInt(request.getParameter("age"));
String gender=request.getParameter("gender");
String email=request.getParameter("email");

//날짜
Timestamp reg_date = new Timestamp(System.currentTimeMillis());


String url ="jdbc:mysql://localhost/register?serverTimezone=UTC";


String user = "root1";


String pwd="1234";

//jdbc참조변수
Connection con =null;
PreparedStatement pstmt =null;

//1.드라이버 로딩
Class.forName("com.mysql.cj.jdbc.Driver");
//2.DB연결
con = DriverManager.getConnection(url,user,pwd);

String sql="INSERT INTO register(id,passwd, name, age, gender,email,reg_date) VALUES(?,?,?,?,?,?,?)";
pstmt=con.prepareStatement(sql);

pstmt.setString(1, id);
pstmt.setString(2, passwd);
pstmt.setString(3, name);
pstmt.setInt(4, age);
pstmt.setString(5, gender);
pstmt.setString(6, email);
pstmt.setTimestamp(7, reg_date);
pstmt.executeUpdate();

pstmt.close();
con.close();

%>
<script>
alert('회원가입 성공');
location.href='loginForm.jsp';
</script>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>