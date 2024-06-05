package board;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;

public class BoardDAO { // Database Access Object ������ ���� ��ü
	Connection conn;
	int no;

	public BoardDAO() // MySQL �����ϴ� �κ�, ������
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

	public int boardWrite(String title, String content, String writer) 
	{
		String SQL = "insert into board values (?, ?, ?, ?, ?, ?)";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL); // conn ��ü�� �̿��ؼ� SQL������ �����غ�ܰ�� ����
			pstmt.setInt(1, this.no = getNext()); // getNext() �Լ� ȣ�� (�Խñ� ��ȣ)
			pstmt.setString(2, title); // �Ķ����(�Ű�����) title
			pstmt.setString(3, content); // �Ķ����(�Ű�����) content
			pstmt.setString(4, writer); // �Ķ����(�Ű�����) writer
			pstmt.setString(5, getDate()); // getDate() �Լ� ȣ�� (��¥)
			pstmt.setInt(6, 0); // ��ȸ��
			
			return pstmt.executeUpdate(); // ���������� insert, update, delete �� 0�̻��� ����� ��ȯ��
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return -1; //�����ͺ��̽� ����
		}
	}
	
	public int boardWriteImg(int no, String fileRealName, int imgNo) 
	{
		String SQL = "insert into boardimg values (?, ?, ?)";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setInt(1, no);
			pstmt.setString(2, fileRealName);
			pstmt.setInt(3, imgNo);
			return pstmt.executeUpdate();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return -1; //�����ͺ��̽� ����
		}
	}
	
	public String getDate() 
	{
		//������ �ð��� �������� mysql ����
		String SQL = "select now()";
		
		try 
		{
			// pstmt ���� ��ü / conn ��ü�� �̿��ؼ� SQL������ �����غ�ܰ�� ����
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery(); // ������ ������������ ���
			
			if (rs.next())
			{
				return rs.getString(1);				
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		return "Database Error";
	}
	
	public ArrayList<BoardDTO> getList(int pageNumber) 
	{
		String SQL = "select * from board where no < ? order by no desc limit 15"; // limit 15�� ������ 15���� ������ �� �ְ� ��
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL); // conn ��ü�� �̿��ؼ� SQL������ �����غ�ܰ�� ����
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 15); /*
																 * getNext() = ���� ���� ��ȣ 
																 * ���� �Խñ��� 13���̰� 1�������� no < 14 �ؼ� 13���� ��ϸ� ������
																 * ���� �Խñ��� 24���̰� 2�������� no < (25 - 15) �ؼ� 9���� ��ϸ� ������ 
																 */
			ResultSet rs = pstmt.executeQuery(); // ������ ���
			
			while (rs.next()) 
			{
				BoardDTO board = new BoardDTO();
				board.setNo(rs.getInt("no"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setWriter(rs.getString("writer"));
				board.setWriteDate(rs.getString("writeDate"));
				board.setViewCount(rs.getInt("viewCount"));
				list.add(board);
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<BoardDTO> getSearchList(int pageNumber,String selected, String search)
	{
		String concat = "concat��";
		
		if (selected.equals("��ü"))
		{
			concat = " concat(title, content, writer) ";
		}
		else if (selected.equals("����"))
		{
			concat = " concat(title) ";
		}
		else if (selected.equals("����"))
		{
			concat = " concat(content) ";
		}
		else if (selected.equals("�ۼ���"))
		{
			concat = " concat(writer) ";
		}
		else
		{
			return null;
		}
		
		String SQL = "select * from board where" + concat + "like ? order by no desc";
		ArrayList<BoardDTO> list = new ArrayList<>();
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search + "%");
			ResultSet rs = pstmt.executeQuery();
			int rsCnt = 0; // ������ ��� ī��Ʈ ��
			
			while (rs.next())
			{
				rsCnt++;
				
				if (pageNumber * 15 >= rsCnt && (pageNumber - 1) * 15 < rsCnt)
				{
					BoardDTO board = new BoardDTO();
					board.setNo(rs.getInt("no"));
					board.setTitle(rs.getString("title"));
					board.setContent(rs.getString("content"));
					board.setWriter(rs.getString("writer"));
					board.setWriteDate(rs.getString("writeDate"));
					board.setViewCount(rs.getInt("viewCount"));
					list.add(board);					  
				}
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean lastPage(int pageNumber) // ������ ������ Ȯ�� �޼ҵ�
	{
		String SQL = "select * from board where no < ? order by no desc limit 15";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - pageNumber * 15);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				return false; // ������ �������� �ƴ�
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return true; // ������ ��������
	}
	
	public boolean lastSearchPage(int pageNumber, String selected, String search)
	{
		String concat = "concat��";
		
		if (selected.equals("��ü"))
		{
			concat = " concat(title, content, writer) ";
		}
		else if (selected.equals("����"))
		{
			concat = " concat(title) ";
		}
		else if (selected.equals("����"))
		{
			concat = " concat(content) ";
		}
		else if (selected.equals("�ۼ���"))
		{
			concat = " concat(writer) ";
		}
		
		String SQL = "select * from board where" + concat + "like ? order by no desc";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search + "%");
			ResultSet rs = pstmt.executeQuery();
			int rsCnt = 0; // ������ ��� ī��Ʈ ��
			
			while (rs.next())
			{
				rsCnt++;
			}
			
			if (pageNumber * 15 < rsCnt)
			{
				return false; // �˻����� ������ ������ �ƴ�
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return true; // �˻����� ������ ��������
	}
	
	public int getNext() 
	{
		// ���������� �ؼ� ���� �������� ���� �� ��ȣ�� ������ ��
		String SQL = "select no from board order by no desc";
		
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
	
	public int getSearchTotal(String selected, String search)
	{
		// �˻��� �Խñ��� �� ����
		String concat = "concat��";
		
		if (selected.equals("��ü"))
		{
			concat = " concat(title, content, writer) ";
		}
		else if (selected.equals("����"))
		{
			concat = " concat(title) ";
		}
		else if (selected.equals("����"))
		{
			concat = " concat(content) ";
		}
		else if (selected.equals("�ۼ���"))
		{
			concat = " concat(writer) ";
		}
		else
		{
			return -1;
		}
		
		String SQL = "select * from board where" + concat + "like ?";
		
		try
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search + "%");
			ResultSet rs = pstmt.executeQuery();
			int total = 0;
			
			while (rs.next())
			{
				total++;		
			}
			
			return total;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return -2; // �����ͺ��̽� ����
		}		
	}
	
	public BoardDTO getBoard(int no) 
	{
		String SQL = "select * from board where no = ?";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) 
			{
				BoardDTO board = new BoardDTO();
				board.setNo(rs.getInt("no"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setWriter(rs.getString("writer"));
				board.setWriteDate(rs.getString("writeDate"));
				board.setViewCount(rs.getInt("viewCount"));
				
				return board;
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return null; // �ش� ��ȣ�� ���� �������� ���� ��
	}

	public ArrayList<String> getBoardImg(int no) 
	{
		String SQL = "select * from boardimg where no = ?";
		ArrayList<String> boardImgList = new ArrayList<>();
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				boardImgList.add(rs.getString("fileRealName"));
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		Collections.reverse(boardImgList); // ����Ʈ ���� ������
		return boardImgList;
	}
	
	public ArrayList<BoardDTO> getHotList()
	{
		String SQL = "select * from board order by viewCount desc limit 6"; // 6���� �Խñ۸� ��������
		ArrayList<BoardDTO> hotList = new ArrayList<BoardDTO>();
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) 
			{
				BoardDTO board = new BoardDTO();
				board.setNo(rs.getInt("no"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setWriter(rs.getString("writer"));
				board.setWriteDate(rs.getString("writeDate"));
				board.setViewCount(rs.getInt("viewCount"));
				hotList.add(board);
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return hotList;
	}

	public int boardUpdate(int no, String title, String content) 
	{
		String SQL = "update board set title = ?, content = ? where no = ?";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, no);
			
			return pstmt.executeUpdate();
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			return -1;
		}
	}

	public int boardImgUpdate(int no, String fileRealName, int imgNo) 
	{
		String SQL = "update boardimg set fileRealName = ? where no = ? and imgNo = ?";
		
		try
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setString(1, fileRealName);
			pstmt.setInt(2, no);
			pstmt.setInt(3, imgNo);

			return pstmt.executeUpdate();
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -1;
		}
	}

	public void serverImgFileRemove(String preFileRealName, String boardImgPath)
	{
		if (preFileRealName == null)
		{
			return;
		}
		
		File file = new File(boardImgPath + preFileRealName);
		file.delete();
	}

	public int delete(int no) 
	{
		String SQL = "delete from board where no = ?";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setInt(1, no);
			
			return pstmt.executeUpdate();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return -1;
		}
	}

	public int deleteImg(int no) 
	{
		String SQL = "delete from boardimg where no = ?";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setInt(1, no);
			
			return pstmt.executeUpdate();
		} 
		catch (Exception e)
		{
			e.printStackTrace();
			return -1;
		}
	}

	public int refreshNo(int no) // �Խñ� ���� �� �Խñ� ��ȣ ���ΰ�ħ
	{
		String SQL = "update board set no = ? where no = ?";
		
		if (no == getNext() + 1) return 0; // ������ �Խñ��� ������ ��ȣ���� �� ������
		
		try 
		{
			for (int i = 0; i < getNext() - no; i++) 
			{
				PreparedStatement pstmt = this.conn.prepareStatement(SQL);
				pstmt.setInt(1, no + i);
				pstmt.setInt(2, no + i + 1);
				pstmt.executeUpdate();
			}
			return 1;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return -1;
		}
	}

	public int refreshImgNo(int no) 
	{
		String SQL = "update boardimg set no = ? where no = ?";
		
		if (no == getNext() + 1) return 0; // ������ �Խñ��� ������ ��ȣ���� �� ������
		try 
		{
			for (int i = 0; i < getNext() - no; i++) 
			{
				PreparedStatement pstmt = this.conn.prepareStatement(SQL);
				pstmt.setInt(1, no + i);
				pstmt.setInt(2, no + i + 1);
				pstmt.executeUpdate();
			}
			return 1;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return -1;
		}
	}
	
	public int upViewCount(int no, int viewCount)
	{
		String SQL = "update board set viewCount = ? where no = ?";
		
		try 
		{			
			PreparedStatement pstmt = this.conn.prepareStatement(SQL);
			pstmt.setInt(1, viewCount + 1);
			pstmt.setInt(2, no);
			
			return pstmt.executeUpdate();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return -1;
		}
	}
	
	public int getNo() 
	{
		return this.no;
	}
}
