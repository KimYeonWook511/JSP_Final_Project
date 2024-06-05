<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whYmile | 와이밀리</title>
<!-- 라이브러리 등록 - jQuery, Bootstrap : CDN 방식-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/css/whYmile.css">
</head>
<body>
	<c:if test="${sessionScope.userID == null}">
		<script>
			alert("로그인을 해 주세요.");
			location.href = "/user/loginForm.jsp";
		</script>
	</c:if>
	<c:if test="${sessionScope.userID != null}">
		<jsp:include page="/layout/navbar.jsp" flush="false"/>
		<div class="container">
			<div class="chatArea">
				<div class="whYmile-div">
					<span class="whYmile">먼저 질문을 해 주세요.</span>
				</div>
			</div>
			<div class="inputArea">
				<form action="inputQuestion.jsp" class="messageArea">
					<div class="user_input"><input type="text" class="form-control" placeholder="메시지를 입력하세요." name="message"></div>
					<div class="user_inputBtn"><button class="btn btn-default">전송</button></div>
				</form>	
			</div>
		</div>
		<jsp:include page="/layout/footer.jsp"></jsp:include>
	</c:if>
</body>
</html>