<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.Timestamp,gd.board.*"%>
<!DOCTYPE html>
    <%
    request.setCharacterEncoding("UTF-8");
    %>
<jsp:useBean id="article" class="gd.board.BoardDTO"/>
<jsp:setProperty  name="article" property="*"/>
<%

 Timestamp temp=new Timestamp(System.currentTimeMillis());
 article.setReg_date(temp);
 article.setIp(request.getRemoteAddr());
 BoardDAO dbPro =new BoardDAO();
 dbPro.insertArticle(article);
 response.sendRedirect("list.jsp");

%>