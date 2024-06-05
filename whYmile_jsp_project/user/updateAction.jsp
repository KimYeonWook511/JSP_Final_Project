<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whYmile | 회원정보 수정 처리</title>
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
		
		UserDTO user = new UserDAO().getUser((String)session.getAttribute("userID"));
		
		// 빈즈에서는 입력란 공백시 null이 프로퍼티에 들어가지만, 바로 request객체에서 getParameter를 해서 보면 null이 아닌 ""과 같은 공백임
		if (!user.getUserPassword().equals(request.getParameter("userPassword")))
		{
			script.println("<script>");
			script.println("alert('현재 비밀번호가 일치하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (!request.getParameter("updatePassword").equals(request.getParameter("updatePasswordCheck")))
		{
			script.println("<script>");
			script.println("alert('수정할 비밀번호가 일치하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (request.getParameter("userPassword").equals("")) // 비밀번호 입력란 공백일때
		{
			script.println("<script>");
			script.println("alert('현재 비밀번호를 입력해 주세요.')");
			script.println("history.back()"); // 이전 페이지로 사용자 돌려보내기
			script.println("</script>");
		}
		else if (request.getParameter("userName").equals("")) // 이름 입력란 공백일때
		{
			script.println("<script>");
			script.println("alert('이름을 입력해 주세요.')");
			script.println("history.back()"); // 이전 페이지로 사용자 돌려보내기
			script.println("</script>");
		}
		else if (request.getParameter("userEmail").equals("")) // 이메일 입력란 공백일때
		{
			script.println("<script>");
			script.println("alert('이메일을 입력해 주세요.')");
			script.println("history.back()"); // 이전 페이지로 사용자 돌려보내기
			script.println("</script>");
		}
		else if (request.getParameter("userGender").equals("")) // 회원가입 성별 선택란 공백일때 (사실상 실행 안됨)
		{
			script.println("<script>");
			script.println("alert('성별을 선택해 주세요.')");
			script.println("history.back()"); // 이전 페이지로 사용자 돌려보내기
			script.println("</script>");
		}
		else
		{		
			user.setUserName(request.getParameter("userName"));
			user.setUserEmail(request.getParameter("userEmail"));
			user.setUserGender(request.getParameter("userGender"));
			if (!request.getParameter("updatePassword").equals("")) // 비밀번호 수정
			{
				user.setUserPassword(request.getParameter("updatePassword"));
			}
			
			int result = new UserDAO().updateUser(user);
			
			if (result == -1)
			{
				script.println("<script>");
				script.println("alert('회원정보 수정 중 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else
			{
				script.println("<script>");
				script.println("alert('회원정보를 수정하였습니다.')");
				script.println("location.href = '/user/updateForm.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>