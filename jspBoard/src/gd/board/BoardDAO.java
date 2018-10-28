package gd.board;

//DBMYSQL(DB에접속),BoardDTO(매개변수,반환형)
import java.sql.*;
import java.util.*;

public class BoardDAO {
  private DBConnectionMgr pool=null;//선언
  
//2.생성자를 통해서 연결 ->의존성
  public BoardDAO() {
	  try {
		  pool = DBConnectionMgr.getInstance();
		  System.out.println("pool:"+pool);
		  
		  
	  }catch(Exception e) {
		  System.out.println("BoardDAO메소드 오류 :"+e);
	  }
	  
  }
  
  public int getArticleCount() {
	  Connection con=null;
	  PreparedStatement pstmt =null;
	  ResultSet rs=null;
	  int x=0;
	  
	  try {
		  con=pool.getConnection();
		  System.out.println("con: "+con);
		  String sql="select count(*) from board";
		  pstmt=con.prepareStatement(sql);
		  rs=pstmt.executeQuery();
		  if(rs.next()) {
			  x=rs.getInt(1);
		  }
  }catch(Exception e) {
	  System.out.println("getArticleCount메소드 오류 :"+ e);
	  
  }finally {
	  pool.freeConnection(con,pstmt,rs);
  }
	return x;
}
  
  public List getArticles(int start,int end) {
	  Connection con =null;
	  PreparedStatement pstmt=null;
	  ResultSet rs=null;
	  List articleList =null;
	  
	  try {
		  con=pool.getConnection();
		  System.out.println("con : "+con);
		  String sql="select * from board order by ref desc, re_step asc limit ?,?";
		  //mysql>limit 몇번째 레코드부터  몇번째까지 끊어서 보여줘
		  //위select문은 board의 테이블에 ref변수 저장하는곳의 전체를 참고해서 ?1번자리,?마지막자리 조회 내림차순
		  pstmt=con.prepareStatement(sql);
		  pstmt.setInt(1, start-1);
	      
		  pstmt.setInt(2, end);
		  rs=pstmt.executeQuery();
		  
		  if(rs.next()) {
			  articleList = new ArrayList(end);
			  do {
				  BoardDTO article =new BoardDTO();
				  article.setNum(rs.getInt("num"));
				  article.setWriter(rs.getString("writer"));
				  article.setEmail(rs.getString("email"));
				  article.setSubject(rs.getString("subject"));
				  article.setPasswd(rs.getString("passwd"));
				  article.setReg_date(rs.getTimestamp("reg_date"));
				  article.setReadcount(rs.getInt("readcount"));
				  article.setRef(rs.getInt("ref"));
				  article.setRe_step(rs.getInt("re_step"));
				  article.setRe_level(rs.getInt("re_level"));
				  article.setContent(rs.getString("content"));
				  article.setIp(rs.getString("ip"));
				  
				  articleList.add(article);
			  }while(rs.next());
		  }
	  }catch(Exception e) {
		  System.out.println("getArticleCount메소드 오류:"+e);
	  }finally {
		  pool.freeConnection(con,pstmt,rs);
	  }
	  return articleList;
  }
  
  public void insertArticle(BoardDTO article) {
	  Connection con=null;
	  PreparedStatement pstmt=null;
	  ResultSet rs=null;
	  
	  int num=article.getNum();
	  int ref =article.getRef();
	  int re_step= article.getRe_step();
	  int re_level=article.getRe_level();
	  
	  int number=0;
	  
	  System.out.printf("insertArticle 내부의 num: %d, re_step: %d, re_level: %d",num,ref,re_step,re_level);
	  String sql="";
	  
	  try {
		  con=pool.getConnection();
		  sql="select max(num) from board";
		  pstmt=con.prepareStatement(sql);
		  rs=pstmt.executeQuery();
		  
		  if(rs.next()) {
			  number=rs.getInt(1)+1;
		  }else {
			  number=1;
		  }
		  
		  
		  if(num!=0) {
		  
		  }else {
			  ref=number;
			  re_step=0;
			  re_level=0;
		  }
		  
		  sql="insert into board(writer,email,subject,passwd,reg_date,";
		  sql+="ref,re_step,re_level,content,ip) values(?,?,?,?,?,?,?,?,?,?)";
		  
		 pstmt=con.prepareStatement(sql);
		 pstmt.setString(1,article.getWriter());
		 pstmt.setString(2,article.getEmail());
		 pstmt.setString(3,article.getSubject());
		 pstmt.setString(4,article.getPasswd());
		 pstmt.setTimestamp(5,article.getReg_date());
		 pstmt.setInt(6,ref);
		 pstmt.setInt(7,re_step);
		 pstmt.setInt(8,re_level);
		 pstmt.setString(9, article.getContent());
		 pstmt.setString(10, article.getIp());
           
		 
		 int insert = pstmt.executeUpdate();
		 System.out.println("게시판의 글쓰기 성공 유무(insert):"+insert);
	  }catch(Exception e) {
		  System.out.println("getArticleCount메소드 오류 : "+e);
	  }finally {
		  pool.freeConnection(con,pstmt,rs);
	  }
  }
  public BoardDTO getArticle(int num) {
	  Connection con =null;
	  PreparedStatement pstmt =null;
	  ResultSet rs=null;
	  BoardDTO article =null;
	  
	  try{
		  con=pool.getConnection();
		  String sql="update board set readcount=readcount+1 where num=?";
		  pstmt = con.prepareStatement(sql);
		  pstmt.setInt(1, num);
		  int update=pstmt.executeUpdate();
		  System.out.println("조회수 증가유무(update)=>"+update);
		  
		  sql="select * from board where num=?";
		  pstmt=con.prepareStatement(sql);
		  pstmt.setInt(1, num);
		  rs=pstmt.executeQuery();
		  
		  if(rs.next()) {
			  article=makeArticleFromResult(rs);
			  
		  }
		  
	  }catch(Exception e) {
		  System.out.println("getArticle()메서드 에러유발"+e);
	  }finally {
		  pool.freeConnection(con,pstmt,rs);
	  }
	  return article;
  }
  
  public BoardDTO updateGetArticle(int num) {
	  Connection con=null;
	  PreparedStatement pstmt=null;
	  ResultSet rs=null;
	  BoardDTO article=null;
	  
	  try {
		  con=pool.getConnection();
		  System.out.println("con :" +con);
		  String sql="select *from board where num=?";
		  pstmt=con.prepareStatement(sql);
		  pstmt.setInt(1, num);
		  rs=pstmt.executeQuery();
		  
		  if(rs.next()) {
			  article=makeArticleFromResult(rs);
		  }
	  }catch(Exception e) {
		  System.out.println("updateGetArticle메소드 오류 :"+e);
	  }finally {
		  pool.freeConnection(con,pstmt,rs);
	  }
	  return article;
  }
  

private BoardDTO makeArticleFromResult(ResultSet rs) throws Exception {

	BoardDTO article= new BoardDTO();
	article.setNum(rs.getInt("num"));//최대값+1->코딩
	article.setWriter(rs.getString("writer"));
	article.setEmail(rs.getString("email"));
	article.setSubject(rs.getString("subject"));
	article.setPasswd(rs.getString("passwd"));
	article.setReg_date(rs.getTimestamp("reg_date"));
	article.setReadcount(rs.getInt("readcount"));
	article.setRef(rs.getInt("ref"));
	article.setRe_step(rs.getInt("re_step"));
	article.setRe_level(rs.getInt("re_level"));
	article.setContent(rs.getString("content"));
	article.setIp(rs.getString("ip"));
	return article;
}
 
//글 수정시켜주는 메서드 ->insertArticle과 거의 동일하지만,암호를 묻는 부분이 추가된다.
public int updateArticle(BoardDTO article) {
	Connection con = null;
	PreparedStatement pstmt =null;
	ResultSet rs=null;
	
	String dbpasswd= null;
	String sql="";
	int x =-1;
	try {
		con = pool.getConnection();
		sql="select passwd from board where num=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, article.getNum());
		rs= pstmt.executeQuery();
		
		if(rs.next()) {
			dbpasswd = rs.getString("passwd");
			System.out.println("dbpasswd=>"+dbpasswd);
			//db상의 암호=웹상에 입력한 암호가 맞다면
			if (dbpasswd.equals(article.getPasswd())) {
				//12개 ->num,reg_date,readcount(생략)->sysdate, now()<-?대신에
				sql="update board set writer=?,email=?, subject=?, passwd=?,";
				sql +="countent=? where num=?";
				pstmt= con.prepareStatement(sql);
				
				pstmt.setString(1,article.getWriter());//작성자
				pstmt.setString(2, article.getEmail());//이메일
				pstmt.setString(3, article.getSubject());//글제목
				pstmt.setString(4, article.getPasswd());//암호
				pstmt.setString(5, article.getContent());//글내용
				pstmt.setInt(6, article.getNum());
				
				int update =pstmt.executeUpdate();
				System.out.println("게시판의 글수정 성공유무(update)="+update);
				x=1;
			}else {
				x=0;
			}
		}//if

	}catch(Exception e) {
		System.out.println("updateArticle()메서드 에러 유발"+e);
		
	}finally {
		pool.freeConnection(con,pstmt,rs);
	}
	return x;
	
}
  
//글삭제 시켜주려는 메서드->회원 탈퇴(삭제)->암호
public int deleteArticle(int num,String passwd) {
	Connection con=null;
	PreparedStatement pstmt =null;
	ResultSet rs= null;
	String dbpasswd=null;
	String sql="";
	int x= -1;
	try {
		con=pool.getConnection();
		sql="select passwd from board where num=?";
		pstmt= con.prepareStatement(sql);
		pstmt.setInt(1, num);
		rs=pstmt.executeQuery();
		if(rs.next()) {
			dbpasswd= rs.getString("passwd");
			System.out.println("dbpasswd=>" + dbpasswd);
			
			if(dbpasswd.equals(passwd)) {
				
				sql="delete form board where num=?";
				
			    pstmt=con.prepareStatement(sql);
			    pstmt.setInt(1, num);
			    
			    int delete = pstmt.executeUpdate();
			    System.out.println("게시판의 삭제 성공유무(delete)="+delete);
			    x=1;
			}else {
				 x=0;//삭제실패
			}
		
		}
		
	}catch(Exception e) {
		System.out.println("updateArticle()메서드 에러유발"+e);
		
	}finally {
     pool.freeConnection(con,pstmt,rs);		
	}
	
	return x;
}
  
  
  
}