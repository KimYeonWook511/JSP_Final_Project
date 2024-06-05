package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	// Database Access Object
	Connection conn;
	
	public UserDAO() // MySQL �����ϴ� �κ�, ������
	{	
		try
		{
			String driver = "com.mysql.jdbc.Driver";
			String dbURL = "jdbc:mysql://localhost:3306/jsp_project2021";
			String dbID = "root";
			String dbPassword = "root";
			
			// 1. ����̹� Ȯ��
			Class.forName(driver);
			// 2. ����
			this.conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public int join(UserDTO user) // ȸ������
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
			
			return pstmt.executeUpdate(); // ���������� insert, update, delete �� 0�̻��� ����� ��ȯ��
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -1; // �����ͺ��̽� ����
		}
	}
	
	public int login(String userID, String userPassword) // �α��� �õ�
	{
		String SQL = "select userPassword from user where userID = ?";	
		
		try
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			ResultSet rs = pstmt.executeQuery(); // �ϼ��� SQL������ ������ ����� ResultSet�� ����	
			
			if (rs.next()) // ����� �����ϴ���
			{
				if (rs.getString("userPassword").equals(userPassword))
				{
					return 1; // ���̵� �����ϰ� ��й�ȣ ��ġ (�α��� ����)
				}
				else
				{
					return 0; // ���̵�� �����ϳ� ��й�ȣ ����ġ (�α��� ����)
				}
			}
			return -1; // ����� �������� ����(���̵� �������� ����)
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -2; // �����ͺ��̽� ����
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
