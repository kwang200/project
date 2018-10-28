
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title> 회원삭제란</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</head>
<body>
<div class="container">
 <form method="post" action="deletePro.jsp">
  <table class="table table-bordered table-hover" style="text-align:center;border:1px solid #dddddd">
  <thead>
  <tr>
     <th colspan="3"><h4>회원 삭제</h4></th>
  </tr>
  </thead>
  <tbody>
     <tr>
     <td style="width:110px;"><h5>아이디</h5></td>
     <td><input class="form-control" type="text" id="userID" name="id" maxlength="20"></td>
   
     </tr>
        <tr>
     <td style="width:110px;"><h5>비밀번호</h5></td>
     <td colspan="2"><input class="form-control" type="password" id="userPassword1" name="passwd" maxlength="20"></td>
     </tr>
     <tr>
     <td style="text-align:center" colspan="3"><input class="btn btn-primary" type="submit" value="회원 삭제" style="width:300px;"></td>
     </tr>
   
  </tbody>
  </table>
 
 
 </form>
</div>
</body>
</html>