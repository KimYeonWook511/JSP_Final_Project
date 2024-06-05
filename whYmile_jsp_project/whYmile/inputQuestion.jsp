<%@ page import="qna.QnADTO" %>
<%@ page import="qna.QnADAO" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whYmile | 와이밀리 질문 처리</title>
</head>
<body>
	<%
		String question = null;
		PrintWriter script = response.getWriter();
	
		if (request.getParameter("message") != null)
		{
			question = request.getParameter("message").trim();
		}
		
		if (question == null || question.equals(""))
		{
			script.println("<script>");
			script.println("alert('메시지를 입력해 주세요.')");
			script.println("location.href = '/whYmile/first.jsp'");
			script.println("</script>");
		}
		else
		{
			if (session.getAttribute("userID") == null)
			{
				script.println("<script>");
				script.println("alert('로그인을 해 주세요.')");
				script.println("location.href = '/user/loginForm.jsp'");
				script.println("</script>");
			}
			
			ArrayList<QnADTO> qnaList = new QnADAO().getAnswer(question);
			QnADTO qna = null;
			
			if (qnaList == null)
			{
				// 데이터 베이스 오류
				script.println("<script>");
				script.println("alert('데이터 베이스 오류')");
				script.println("location.href = '/whYmile/first.jsp'");
				script.println("</script>");
			}
			else if (qnaList.size() == 0)
			{
				// 사용자 질문에 대한 답변이 없는 경우
				qna = null;
				int result = new QnADAO().isUnQnA(question);
				
				if (result == -1)
				{
					// 데이터 베이스 오류
					script.println("<script>");
					script.println("alert('데이터 베이스 오류')");
					script.println("location.href = '/whYmile/first.jsp'");
					script.println("</script>");
				}
				else if (result == 0)
				{
					// 같은 질문이 있으면 테이블에 추가하지 않음
				}
				else
				{
					result = new QnADAO().addUnQnA(question); // 질문만 있는 테이블에 추가하기
					
					if (result == -1)
					{
						// 데이터 베이스 오류
						script.println("<script>");
						script.println("alert('데이터 베이스 오류')");
						script.println("location.href = '/whYmile/first.jsp'");
						script.println("</script>");
					}
				}
				
			}
			else
			{
				// 사용자 질문에 대한 답변이 있는 경우
				qna = new QnADTO();
				int random_idx = (int)(Math.random() * qnaList.size()); // 랜덤하게 뽑아낼 레코드 인덱스
				
				for (int i = 0; i < qnaList.size(); i++)
				{
					if (i == random_idx)
					{
						qna = qnaList.get(i);
					}
				}
			}
			
			ArrayList<QnADTO> un_qnaList = new QnADAO().getQuestion();
			QnADTO un_qna = null;
			
			if (un_qnaList == null)
			{
				// 데이터 베이스 오류
				script.println("<script>");
				script.println("alert('데이터 베이스 오류')");
				script.println("location.href = '/whYmile/first.jsp'");
				script.println("</script>");
			}
			else if (un_qnaList.size() == 0)
			{
				// 사용자에게 물어볼 질문이 없는 경우
				un_qna = null;
			}
			else
			{
				// 사용자에게 물어볼 질문이 있는 경우
				un_qna = new QnADTO();
				int random_idx = (int)(Math.random() * un_qnaList.size()); // 랜덤하게 뽑아낼 레코드 인덱스
				
				for (int i = 0; i < un_qnaList.size(); i++)
				{
					if (i == random_idx)
					{
						un_qna = un_qnaList.get(i);
					}
				}
			}
			
			request.setAttribute("question", question); // 사용자 입력 값 (사용자의 질문)
			request.setAttribute("qna", qna); // 사용자가 질문한 것에 대한 답변이 담긴 QnADTO (no, question, answer)
			request.setAttribute("un_qna", un_qna); // whYmile가 사용자한테 질문한 QnADTO (no, question)
			
			RequestDispatcher rd = request.getRequestDispatcher("/whYmile/second.jsp");
			rd.forward(request, response);
		}
	%>
</body>
</html>