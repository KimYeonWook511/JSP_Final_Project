package qna;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class QnADAO {
	Connection conn;
	int no;

	public QnADAO() // MySQL �����ϴ� �κ�, ������
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
	
	public int getNext(String table) 
	{
		// ������ ���̽� qna Ȥ�� undefined ���̺� no �����ϴ� �޼ҵ�
		String SQL = "select no from "+ table +" order by no desc";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL); // conn ��ü�� �̿��ؼ� SQL������ �����غ�ܰ�� ����
			ResultSet rs = pstmt.executeQuery(); // ������ ������������ ���
			
			if (rs.next())
			{
				return rs.getInt("no") + 1; // �������� �� �� �� �Խñ� ��ȣ ������ �� + 1				
			}
			
			return 1; // �Խù��� ���� ���(ù �Խù�)
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return -1; // �����ͺ��̽� ����
		}
	}
	
	public int getMost(String input)
	{
		// ����ڰ� �Է��� ������ ���� ������ ���� ���ڵ��� ������ ��ȯ����
		String SQL = "select * from qna where question like ?"; // ���� SQL��
		String addSQL = "select * from qna where question like ?"; // union all ��� �� �߰��Ǵ� ����
		String union_all = " union all ";
		String[] inputWords = input.split(" "); // ������� �Է��� ���� �������� ���ø�
		int mostRecord = 0; // �� ������ ���õ� ���ڵ���� ���� -> ���յ� ���� �ִ��� mostRecord�� ����
		
		for (int i = 0; i < inputWords.length - 1; i++)
		{
			SQL += union_all + addSQL; // select ~ + union all + select ~ 
		}
		
		SQL = "select no, count(no) from (" + SQL + ") derived_qna group by no";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			
			for (int i = 0; i < inputWords.length; i++)
			{
				pstmt.setString(i + 1, "%" + inputWords[i] + "%");
			}
			
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				mostRecord = rs.getInt("count(no)");
			}
			
			if (mostRecord < inputWords.length - 1)
			{
				// "���� �� ����" -> 3���� -1 = 2 -> 2���� mostRecord�� ���� ��� ������ ���� ���� ���ٰ� �Ǻ�   
				mostRecord = 0;
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			mostRecord = -1; // "������ ���̽� ����"
		}	
		return mostRecord;
	}
	
	public ArrayList<QnADTO> getAnswer(String input)
	{
		int mostRecord = this.getMost(input);
		ArrayList<QnADTO> qnaList = new ArrayList<QnADTO>();
		
		if (mostRecord == -1 || this.isQnA(input) == -1)
		{
			return null;
		}
		else if (mostRecord == 0)
		{
			return qnaList;
		}
		else
		{
			String SQL = "select * from qna where question like ?"; // ���� SQL��
			String addSQL = "select * from qna where question like ?"; // union all ��� �� �߰��Ǵ� ����
			String union_all = " union all ";
			String[] inputWords = input.split(" "); // ������� �Է��� ���� �������� ���ø�
			
			for (int i = 0; i < inputWords.length - 1; i++)
			{
				SQL += union_all + addSQL; // select ~ + union all + select ~ 
			}
			
			SQL = "select *, count(no) from (" + SQL + ") derived_qna group by no having count(no) >= " + mostRecord;
			
			try 
			{
				PreparedStatement pstmt = this.conn.prepareStatement(SQL);
				
				for (int i = 0; i < inputWords.length; i++)
				{
					pstmt.setString(i + 1, "%" + inputWords[i] + "%");
				}
				
				ResultSet rs = pstmt.executeQuery();
				
				while (rs.next())
				{
					QnADTO qna = new QnADTO();
					qna.setNo(rs.getInt("no"));
					qna.setQuestion(rs.getString("question"));
					qna.setAnswer(rs.getString("answer"));
					qnaList.add(qna);
				}
				
				return qnaList;
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				return null;
			}	
		}		
	}
	
	public ArrayList<QnADTO> getQuestion() 
	{
		ArrayList<QnADTO> un_qnaList = new ArrayList<QnADTO>();
		String SQL = "select * from undefined_qna";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				QnADTO qna = new QnADTO();
				qna.setNo(rs.getInt("no"));
				qna.setQuestion(rs.getString("question"));
				un_qnaList.add(qna);
			}
			
			return un_qnaList;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return null; // �����ͺ��̽� ����
		}
	}
	
	public int addQnA(String question, String answer)
	{
		String SQL = "insert into qna values (?, ?, ?)";
		
		try
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setInt(1, this.getNext("qna"));
			pstmt.setString(2, question);
			pstmt.setString(3, answer);
			
			return pstmt.executeUpdate();
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -1; // �����ͺ��̽� ����
		}
	}
	
	public int addUnQnA(String question)
	{
		String SQL = "insert into undefined_qna values (?, ?)";
		
		try
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setInt(1, this.getNext("undefined_qna"));
			pstmt.setString(2, question);
			
			return pstmt.executeUpdate(); // ���������� insert, update, delete �� 0�̻��� ����� ��ȯ��
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -1; // �����ͺ��̽� ����
		}
	}
	
	public int isQnA(String question)
	{
		String SQL = "select * from qna where question = ?";
		
		try
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setString(1, question);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				/*
				 * �̹� ���� ������ �ش��ϴ� �亯�� ���� ��
				 * �̹� undefined_qna ���̺� ���� �����ϴ� ������
				 * �ƹ� ó�� ������ ����
				 */
				return 0;
			}
			
			// ���� ������ �ش��ϴ� �亯�� ���� �� undefined_qna Ȯ�� �� �߰�
			int result = this.isUnQnA(question);
			
			if (result == -1)
			{
				// �����ͺ��̽� ����
				return -1;
			}
			else if (result == 0)
			{
				// undefined_qna�� �̹� �ش� ���� ���� -> ������ ó��
				return 0;
			}
			else
			{
				// undefined_qna�� �ش� ���� ���� -> �߰� ó��
				this.addUnQnA(question);
				return 1;
			}			
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -1; // �����ͺ��̽� ����
		}
	}
	
	public int isUnQnA(String question)
	{
		String SQL = "select * from undefined_qna where question = ?";
		
		try
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setString(1, question);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				// �̹� ���� ������ ���� ���� ������ �߰����� ����
				return 0;
			}
			
			// ó�� �޴� �����̸� 1�� ��ȯ�Ͽ� undefined_qna ���̺� �߰�
			return 1;
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -1; // �����ͺ��̽� ����
		}
	}
}
