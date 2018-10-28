package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    
	private Connection conn;
	
	public UserDAO() {
		try {
			
			String dbURL ="jdbc:mysql://localhost:3306/register";
			String dbID ="root1";
			String dbPassword="1234";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		
	}
	public int registerCheck(String userID) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
	 String SQL = "SELECT * FROM USER WHERE userID= ?";
	 try {
		 pstmt = conn.prepareStatement(SQL);
		 pstmt.setString(1, userID);
		 rs= pstmt.executeQuery();
		 if(rs.next()) {
			 return 0; //이미 존재하는 회원
		 }
		 else {
			 return 1;//가입 가능한 아이디
		 }
		 
	 }catch(Exception e) {
		 e.printStackTrace();
	 }finally {
		 try {
			 if(rs !=null)rs.close();
			 if(pstmt !=null) pstmt.close();
			 
		 }catch(Exception e) {
			 e.printStackTrace();
		 }
		 
	 }
	 return -1;//데이터 베이스오류
		
	}
	public int register(UserDTO user) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
	 String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?, ?)";
	 try {
		 pstmt = conn.prepareStatement(SQL);
		 pstmt.setString(1, user.getUserID());
		 pstmt.setString(2, user.getUserPassword());
		 pstmt.setString(3, user.getUserName());
		 pstmt.setInt(4, user.getUserAge());
		 pstmt.setString(5, user.getUserGender());
		 pstmt.setString(6, user.getUserEmail());
		 return pstmt.executeUpdate();
		 
	 }catch(Exception e) {
		 e.printStackTrace();
	 }finally {
		 try {
			 if(rs !=null)rs.close();
			 if(pstmt !=null) pstmt.close();
			 
		 }catch(Exception e) {
			 e.printStackTrace();
		 }
		 
	}
	return -1;
	}
	
}

