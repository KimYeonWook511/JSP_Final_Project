<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whYmile | 로그인 처리</title>
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO();
		request.setAttribute("userDAO", userDAO);
	%>
	<c:if test="${sessionScope.userID != null }">
		<script>
			alert('이미 로그인 중입니다.');
			location.href = '/main.jsp';
		</script>
	</c:if>
	
	<!-- joinAction.jsp에서는 빈즈 사용, 여기서는 표현 태그 라이브러리 사용 -->
	<c:set var="user" value="<%=new UserDTO() %>" scope="page"/>
	<c:set target="${user }" property="userID" value="${param.userID }"/>
	<c:set target="${user }" property="userPassword" value="${param.userPassword }"/>
	
	${result = userDAO.login(user.getUserID(), user.getUserPassword());'' }
	
	<c:choose>
		<c:when test="${result ==  1}">
			${sessionScope.userID = user.getUserID();'' }
			<script>
				location.href = '/main.jsp';
			</script>
		</c:when>
		<c:when test="${result ==  0}">
			<script>
				alert('비밀번호가 틀립니다.');
				history.back();
			</script>
		</c:when>
		<c:when test="${result ==  -1}">
			<script>
				alert('존재하지 않는 아이디입니다.');
				history.back()
			</script>
		</c:when>
		<c:when test="${result ==  -2}">
			<script>
				alert('데이터베이스 오류가 발생했습니다.');
				history.back();
			</script>
		</c:when>
	</c:choose>
</body>
</html>