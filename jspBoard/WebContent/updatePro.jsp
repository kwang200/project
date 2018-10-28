<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="gd.board.BoardDAO"%>
    
<!DOCTYPE html>
<%
//수정할 목적->updatePro.jsp?num=?&pageNum=?
		request.setCharacterEncoding("UTF-8");

%>

<jsp:useBean id="article" class=gd.board.BoardDTO"/>
<jsp:setProperty name="article" property="*" />

<%
String pageNum=request.getParameter("pageNum");
System.out.println("pageNum : "+pageNum);
BoardDAO dbPro=new BoardDAO();
int check=dbPro.updateArticle(article);
if(check==1){
	System.out.println("check :"+check);
	%>
	<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum %>">
<% }else{%>
<script>
 alert("비밀번호가 맞지 않습니다.");
 history.go(-1);

</script>


<%}%>>
