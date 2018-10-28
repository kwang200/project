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
request.setCharacterEncoding("utf-8");

//id pw 가져오기
String id = request.getParameter("id");
String passwd=request.getParameter("passwd");

//jdbc참조변수
Connection con = null;
PreparedStatement pstmt=null;
ResultSet rs = null;

//DB연결정보

String url="jdbc:mysql://localhost/register?serverTimezone=UTC";
String user="root1";
String pwd="1234";

//1.드라이버 로딩

Class.forName("com.mysql.cj.jdbc.Driver");

//2.DB연결
con= DriverManager.getConnection(url,user,pwd);

//3.id에 해당하는 passwd 가져오기

String sql="SELECT passwd FROM register WHERE id=?";
pstmt=con.prepareStatement(sql);
pstmt.setString(1,id);

//4.rs저장
rs= pstmt.executeQuery();

if(rs.next()){
	if(passwd.equals(rs.getString("passwd"))){
		pstmt.close();
		sql="DELETE FROM register WHERE id=?";
		pstmt =con.prepareStatement(sql);
		pstmt.setString(1,id);
		
		//실행
		pstmt.executeUpdate();
		%>
		   <script>
		   alert('삭제 성공');
		   location.href='deleteForm.jsp';
		   </script>
	<%
	}else{
		%>
		   <script>
		   alert('비밀번호없음');
		   location.href='deleteForm.jsp';
		   </script>
	<%
	}}
   else{%>
	   <script>
	   alert('아이디없음');
	   location.href='deleteForm.jsp';
	   </script>
<%
	}
   rs.close();
   if(pstmt !=null )pstmt.close();
   con.close();

%>

</body>
</html>