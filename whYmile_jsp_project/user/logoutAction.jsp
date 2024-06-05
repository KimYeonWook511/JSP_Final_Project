<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whYmile | 로그아웃</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
	
		if (session.getAttribute("userID") == null)
		{
			script.println("<script>");
			script.println("alert('현재 로그인 상태가 아닙니다.')");
			script.println("location.href = '/main.jsp'");
			script.println("</script>");
		}
		else
		{
			session.invalidate(); // 세션 종료	
			script.println("<script>");
			script.println("alert('로그아웃 되었습니다.')");
			script.println("location.href = '/main.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>