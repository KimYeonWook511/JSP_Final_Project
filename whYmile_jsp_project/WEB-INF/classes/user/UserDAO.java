package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	// Database Access Object
	Connection conn;
	
	public UserDAO() // MySQL 접속하는 부분, 생성자
	{	
		try
		{
			String driver = "com.mysql.jdbc.Driver";
			String dbURL = "jdbc:mysql://localhost:3306/jsp_project2021";
			String dbID = "root";
			String dbPassword = "root";
			
			// 1. 드라이버 확인
			Class.forName(driver);
			// 2. 연결
			this.conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public int join(UserDTO user) // 회원가입
	{
		String SQL = "insert into user values (?, ?, ?, ?, ?)";
		
		try
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserGender());
			
			return pstmt.executeUpdate(); // 성공적으로 insert, update, delete 시 0이상의 결과를 반환함
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -1; // 데이터베이스 오류
		}
	}
	
	public int login(String userID, String userPassword) // 로그인 시도
	{
		String SQL = "select userPassword from user where userID = ?";	
		
		try
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			ResultSet rs = pstmt.executeQuery(); // 완성된 SQL문장을 실행한 결과를 ResultSet에 넣음	
			
			if (rs.next()) // 결과가 존재하는지
			{
				if (rs.getString("userPassword").equals(userPassword))
				{
					return 1; // 아이디가 존재하고 비밀번호 일치 (로그인 성공)
				}
				else
				{
					return 0; // 아이디는 존재하나 비밀번호 불일치 (로그인 실패)
				}
			}
			return -1; // 결과가 존재하지 않음(아이디가 존재하지 않음)
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -2; // 데이터베이스 오류
		}
	}
	
	public UserDTO getUser(String userID)
	{
		String SQL = "select * from user where userID = ?";
		UserDTO user = new UserDTO();
		
		try
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				user.setUserID(rs.getString("userID"));
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserName(rs.getString("userName"));
				user.setUserEmail(rs.getString("userEmail"));
				user.setUserGender(rs.getString("userGender"));
				
				return user;
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	public int updateUser(UserDTO userAfter)
	{
		String SQL = "update user set userPassword = ?, userName = ?, userEmail = ?, userGender = ? where userID = ?";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setString(1, userAfter.getUserPassword());
			pstmt.setString(2, userAfter.getUserName());
			pstmt.setString(3, userAfter.getUserEmail());
			pstmt.setString(4, userAfter.getUserGender());
			pstmt.setString(5, userAfter.getUserID());
			
			return pstmt.executeUpdate();
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			return -1;
		}
	}
}
