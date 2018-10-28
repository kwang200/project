<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="gd.board.*, java.util.*,java.text.SimpleDateFormat"%>
<%!
   int pageSize=2;//numPerPage와 같다 ->페이지당 보여주는 게시물수
   int blockSize=2;//pagePerBlock -> 블럭당 보여주는 페이지수
   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
//게시판을 맨 처음 실행시키면 무조건 1페이지 부터 출력
String pageNum=request.getParameter("pageNum");
if(pageNum==null){ //처음 시작은 아무런 값이 없다. 페이지 실행시
	pageNum="1";  //따라서 null이 떨어지면 보여줄페이지가 없기 때문에 , 강제로 1로 이동시켜준다.	
}
int currentPage=Integer.parseInt(pageNum);

int startRow=(currentPage-1)*pageSize+1;
int endRow=currentPage*pageSize;
int count=0;
int number=0;
List articleList =null;

BoardDAO dbPro=new BoardDAO();
count=dbPro.getArticleCount();
System.out.println("현재 레코드 수(count) :" +count);
if(count>0){
	articleList=dbPro.getArticles(startRow, pageSize);
	
}

number=count-(currentPage-1)*pageSize;
System.out.println("페이지별 number:"+number);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="#e0ffff">
<center><b>글목록(전체 글 :<%=count %>)</b>
<table width="700">
<tr>
<td align="right" bgcolor="#b0e0e6">
<a href="writeForm.jsp">글쓰기</a>
</td>
</table>
<%
 if(count==0){%>
 <table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
 <tr>
   <td align="center">게시판에 저장된 글이 없습니다.</td>
   </tr>
 </table>
<%}else {%>   
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
<tr height="30" bgcolor="#b0e0e6">
<td align="center" width="50">번 호 </td>
<td align="center" width="250">제  목</td>
<td align="center" width="100">작성자</td>
<td align="center" width="150">작성일</td>
<td align="center" width="50">조 회</td>
<td align="center" width="50">IP</td>
</tr>
<%
for(int i=0; i<articleList.size(); i++){
	BoardDTO article=(BoardDTO)articleList.get(i);
%>
<tr height="30">
<td align="center" width="50"><%=number-- %></td>
<td width="250">

<%
int wid=0;
if(article.getRe_level()>0){
   wid=7*(article.getRe_level());
%>
<img src="images/level.gif" width="<%=wid %>" height="16">
<img src="images/re.gif">
<%}else { %>
<img src="images/level.gif" width="<%=wid %>" height="16">
<%} %>

<a href="content.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>">
  <%=article.getSubject() %></a>
  <%if(article.getReadcount() >=20){ %>
	  <img src="images/hot.gif" border="0" height="16">
  <%}//if %>
  </td>
  <td align="center" width="100">
  <a href="mailto:<%=article.getEmail() %>"><%=article.getWriter() %></a></td>
  <td align="center" width="150"><%=sdf.format(article.getReg_date()) %></td>
  <td align="center" width="50"><%= article.getReadcount() %></td>
  <td align="center" width="100"><%=article.getIp() %></td>
  </tr>
  <%}//for %>

</table>

<%}//else%>
<%
//페이징 처리
if(count>0){
	
	int pageCount=count/pageSize+(count%pageSize==0?0:1);
	
	int startPage=0;
	if(currentPage%blockSize!=0){
		startPage=(currentPage/blockSize)*blockSize+1;
	}else{
		startPage=((currentPage/blockSize)-1)*blockSize+1;
	}
	int endPage=startPage+blockSize-1;
	System.out.println("startPage :"+startPage+", endPage :"+endPage);
	
	if(endPage> pageCount)endPage=pageCount;
	
	if(startPage>blockSize){%>
	<a href="list.jsp?pageNum=<%=startPage-blockSize%>">[이전]</a>
	<%}
for(int i=startPage; i<=endPage; i++){%>
 <a href="list.jsp?pageNum=<%=i %>">[<%=i %>]</a>
<%}
if(endPage <pageCount){%>
<a href="list.jsp?pageNum=<%=startPage+blockSize %>">[다음]</a>
<%}

}//if%>
</center>
</body>
</html>