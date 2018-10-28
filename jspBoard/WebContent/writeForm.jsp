<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
 int num=0,ref=1,re_step=0,re_level=0;

if(request.getParameter("num")!=null){
	num=Integer.parseInt(request.getParameter("num"));
	ref=Integer.parseInt(request.getParameter("ref"));
	re_step=Integer.parseInt(request.getParameter("re_step"));
	re_level=Integer.parseInt(request.getParameter("re_level"));
	System.out.printf("content.jsp에서 넘어온 매개변수 확인,num: %d, ref:%d,re_step : %d, re_level : %d",num,ref,re_step,re_level);
}

%>
</head>
<body>
<center><b>글쓰기</b>
<br>
<form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave()">
<input type="hidden" name="num" value="<%=num %>"></input>
<input type="hidden" name="ref" value="<%=ref %>"></input>
<input type="hidden" name="re_step" value="<%=re_step %>"></input>
<input type="hidden" name="re_level" value="<%=re_level %>"></input>
<table width="400" border="1" cellspacing="0" cellpadding="0" bgcolor="#e0ffff" align="center">
<tr>
 <td align="right" colspan="2" bgcolor="#b0e0e6">
 <a href="list.jsp">글목록</a>
</td>
</tr>
<tr>
<td width="70" bgcolor="#b0e0e6" align="center">이 름</td>
<td width="330">
 <input type="text" size="10" maxlength="10" name="writer"></td>
</tr>
<tr>
<td width="70" bgcolor="#b0e0e6" align="center">제 목</td>
<td width="330">
 <input type="text" size="40" maxlength="50" name="subject"></td>
</tr>
<tr>
<td width="70" bgcolor="#b0e0e6" align="center">Email</td>
<td width="330">
 <input type="text" size="40" maxlength="30" name="email"></td>
</tr>
<tr>
<td width="70" bgcolor="#b0e0e6" align="center">내  용</td>
<td width="330">
<textarea name="content" rows="13" cols="40"></textarea></td>
</tr>
<tr>
<td width="70" bgcolor="#b0e0e6" align="center">비밀번호</td>
<td width="330">
 <input type="password" size="8" maxlength="12" name="passwd"></td>
</tr>
<tr>
<td colspan=2 bgcolor="#b0e0e6" align="center">
<input type="submit" value="글쓰기">
<input type="reset" value="다시작성">
<input type="button" value="목록보기" Onclick="window.location='list.jsp'">
</td></tr>
</table>
</form>
</center>

</body>
</html>