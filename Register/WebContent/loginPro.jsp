<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>

 <%
 //폼 ID PASSWD 가져오기
 String id = request.getParameter("id");
 String passwd = request.getParameter("passwd");
 
 

String url ="jdbc:mysql://localhost/register?serverTimezone=UTC";


String user = "root1";


String pwd="1234";
 //JDBC참조변수
 Connection con =null;
 PreparedStatement pstmt =null;
 ResultSet rs= null;
 
 //1. 드라이버 로딩
 Class.forName("com.mysql.cj.jdbc.Driver");
 //2.DB연결
 con=DriverManager.getConnection(url,user,pwd);
 
 //3. ID에 해당하는 passwd 가져오기
 String sql ="SELECT passwd,level FROM register WHERE id=?";
 pstmt=con.prepareStatement(sql);
 pstmt.setString(1,id); //id를 입력시켜야 pwd가져옴
 
 //4 실행 rs에 아이디를 저장시킴
 rs=pstmt.executeQuery();
 
//5.rs에 데이터(행)가 있으면 아이디 있음
//패스워드 비교후 맞으면 로그인 인증
//패스워드 틀리면 패스워드틀렸다고 다시 로그인페이지로
// rs에데이터가없으면  아이디가없다고 메시지띄우고 로그인페이지로 다시
if(rs.next()){
	//아이디 있으면
	 if(passwd.equals(rs.getString("passwd"))){
		 //로그인 인증 main.jsp로이동
		 session.setAttribute("id", id);
		 session.setAttribute("level", 	rs.getString("level"));
		 response.sendRedirect("loginMain.jsp");//로그인인증이된 main
		 //여기서 이해하는게 중요 form html안에서 넘어온값들은 request.getParameter로
		 //입력된값을 여기 id로 대입시켜똑같이사용가능 그러면 jsp의 데이터에있는 id는 또다른
		 //jsp로 옮길때 session에 넣어준다. setattribute("이름", 값)
		 //넣어주고 sendredirect까지는 해줘야하는지는잘모르곘음
		 
	 }else{
		 %>
		 <script>
		 alert("패스워드가 틀림");
		 history.back();
		 </script>
		 <%
	 }
}else{
	%>
	<script>
	alert('아이디가 없음');
	history.back();
	</script>
	
	<%
}



 
 
 
 %>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>