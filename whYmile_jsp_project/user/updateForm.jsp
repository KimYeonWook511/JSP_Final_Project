<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whYmile | 회원정보 수정</title>
<!-- 라이브러리 등록 - jQuery, Bootstrap : CDN 방식-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<c:if test="${sessionScope.userID == null}">
		<script>
			alert('현재 로그인 상태가 아닙니다.');
			location.href = '/main.jsp';
		</script>
	</c:if>
	<%	
		UserDTO user = new UserDAO().getUser((String)session.getAttribute("userID"));
	%>
	<jsp:include page="/layout/navbar.jsp" flush="false"/>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div style="padding-top: 20px;">
				<form method="post" action="updateAction.jsp">
					<h3 style="text-align: center;">회원정보 수정</h3>
					<div class="form-group">
						<input type="text" class="form-control" readonly value="<%=user.getUserID() %>">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="현재 비밀번호" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="수정할 비밀번호" name="updatePassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="수정할 비밀번호 확인" name="updatePasswordCheck" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="수정할 이름" name="userName" maxlength="20" value="<%=user.getUserName() %>">
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="수정할 이메일" name="userEmail" maxlength="40" value="<%=user.getUserEmail() %>">
					</div>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary <%if (user.getUserGender().equals("남자")) {%>active<%} %>">
								<input type="radio" name="userGender" autocomplete="off" value="남자" <%if (user.getUserGender().equals("남자")) {%>checked<%} %>>남자			
							</label>
							<label class="btn btn-primary <%if (user.getUserGender().equals("여자")) {%>active<%} %>">
								<input type="radio" name="userGender" autocomplete="off" value="여자" <%if (user.getUserGender().equals("여자")) {%>checked<%} %>>여자
							</label>
						</div>
					</div>
					<br><br>
					<input type="submit" class="btn btn-primary form-control" value="정보수정">
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>