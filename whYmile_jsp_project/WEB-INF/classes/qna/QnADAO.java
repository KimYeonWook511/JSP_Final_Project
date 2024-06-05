package qna;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class QnADAO {
	Connection conn;
	int no;

	public QnADAO() // MySQL 접속하는 부분, 생성자
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
	
	public int getNext(String table) 
	{
		// 데이터 베이스 qna 혹은 undefined 테이블 no 지정하는 메소드
		String SQL = "select no from "+ table +" order by no desc";
		
		try 
		{
			PreparedStatement pstmt = this.conn.prepareStatement(SQL); // conn 객체를 이용해서 SQL문장을 실행준비단계로 만듬
			ResultSet rs = pstmt.executeQuery(); // 실제로 실행했을때의 결과
			
			if (rs.next())
			{
				return rs.getInt("no") + 1; // 내림차순 후 맨 위 게시글 번호 가져온 뒤 + 1				
			}
			
			return 1; // 게시물이 없는 경우(첫 게시물)
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return -1; // 데이터베이스 오류
		}
	}
	
	public int getMost(String input)
	{
		// 사용자가 입력한 질문과 가장 관련이 많은 레코드의 개수를 반환해줌
		String SQL = "select * from qna where question like ?"; // 최종 SQL문
		String addSQL = "select * from qna where question like ?"; // union all 사용 시 추가되는 쿼리
		String union_all = " union all ";
		String[] inputWords = input.split(" "); // 사용자의 입력을 띄어쓰기 기준으로 스플릿
		int mostRecord = 0; // 한 어절과 관련된 레코드들을 종합 -> 종합된 수중 최댓값을 mostRecord에 저장
		
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
				// "오늘 뭐 먹지" -> 3어절 -1 = 2 -> 2보다 mostRecord가 적을 경우 질문에 대한 답이 없다고 판별   
				mostRecord = 0;
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			mostRecord = -1; // "데이터 베이스 오류"
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
			String SQL = "select * from qna where question like ?"; // 최종 SQL문
			String addSQL = "select * from qna where question like ?"; // union all 사용 시 추가되는 쿼리
			String union_all = " union all ";
			String[] inputWords = input.split(" "); // 사용자의 입력을 띄어쓰기 기준으로 스플릿
			
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
			return null; // 데이터베이스 오류
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
			return -1; // 데이터베이스 오류
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
			
			return pstmt.executeUpdate(); // 성공적으로 insert, update, delete 시 0이상의 결과를 반환함
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -1; // 데이터베이스 오류
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
				 * 이미 같은 질문에 해당하는 답변이 있을 시
				 * 이미 undefined_qna 테이블에 질문 존재하는 것으로
				 * 아무 처리 해주지 않음
				 */
				return 0;
			}
			
			// 같은 질문에 해당하는 답변이 없을 시 undefined_qna 확인 후 추가
			int result = this.isUnQnA(question);
			
			if (result == -1)
			{
				// 데이터베이스 오류
				return -1;
			}
			else if (result == 0)
			{
				// undefined_qna에 이미 해당 질문 존재 -> 무반응 처리
				return 0;
			}
			else
			{
				// undefined_qna에 해당 질문 부재 -> 추가 처리
				this.addUnQnA(question);
				return 1;
			}			
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -1; // 데이터베이스 오류
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
				// 이미 같은 질문을 받은 적이 있으면 추가하지 않음
				return 0;
			}
			
			// 처음 받는 질문이면 1을 반환하여 undefined_qna 테이블에 추가
			return 1;
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -1; // 데이터베이스 오류
		}
	}
}
