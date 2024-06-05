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
<title>whYmile | 와이밀리 답변 처리</title>
</head>
<body>
	<%
		String answer = null;
		PrintWriter script = response.getWriter();
	
		if (request.getParameter("message") != null)
		{
			answer = request.getParameter("message").trim();
		}
		
		if (request.getParameter("firstInput") == null)
		{
			script.println("<script>");
			script.println("alert('메시지를 입력해 주세요.')");
			script.println("location.href = '/whYmile/first.jsp'");
			script.println("</script>");
		}
		else
		{	
			if (answer == null || answer.equals(""))
			{
				script.println("<script>");
				script.println("alert('메시지를 입력해 주세요.')");
				script.println("location.href = '/whYmile/inputQuestion.jsp?message=" + request.getParameter("firstInput") + "'");
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
				
				int result = new QnADAO().addQnA(request.getParameter("un_qnaQuestion"), answer);
				
				if (result == -1)
				{
					// 데이터 베이스 오류
					script.println("<script>");
					script.println("alert('데이터 베이스 오류')");
					script.println("location.href = '/whYmile/second.jsp'");
					script.println("</script>");
				}
				else
				{
					request.setAttribute("answer", answer); // 와이밀리 질문에 대한 사용자 답변 
					request.setAttribute("qnaAnswer", request.getParameter("qnaReplaceAnswer")); // 사용자 질문에 대한 답변
					request.setAttribute("un_qnaQuestion", request.getParameter("un_qnaReplaceQuestion")); // 와이밀리가 한 질문
					request.setAttribute("firstInput", request.getParameter("firstInput")); // 사용자가 한 질문
					
					RequestDispatcher rd = request.getRequestDispatcher("/whYmile/third.jsp");
					rd.forward(request, response);				
				}
			}		
		}
	%>
</body>
</html>