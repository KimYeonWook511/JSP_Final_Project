<%@ page import="java.util.ArrayList"%>
<%@ page import="qna.QnADTO" %>
<%@ page import="qna.QnADAO" %>
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
		<c:if test="${firstInput == null }">
			<script>
				alert("먼저 질문을 해 주세요.");
				location.href = "/whYmile/first.jsp";
			</script>
		</c:if>
		<c:if test="${answer == null }">
			<script>
				alert("답변을 해 주세요.");
				location.href = "/whYmile/inputQuestion.jsp?message=" + ${firstInput};
			</script>
		</c:if>
		<jsp:include page="/layout/navbar.jsp" flush="false"/>
		<div class="container">
			<div class="chatArea">
				<div class="whYmile-div">
					<span class="whYmile">먼저 질문을 해 주세요.</span>
				</div>
				<div class="user-div">
					<span class="user">${firstInput }</span>
				</div>
				<div class="whYmile-div">
					<c:if test="${qnaAnswer == null || qnaAnswer == '' }">
						<span class="whYmile">저도 잘 모르겠어요.</span>
					</c:if>
					<c:if test="${qnaAnswer != null && qnaAnswer != ''}">
						<span class="whYmile">${qnaAnswer }</span>
					</c:if>
				</div>
				<c:if test="${un_qnaQuestion == null || un_qnaQuestion == '' }">
					<div class="whYmile-div">
						<span class="whYmile">질문할 내용이 없어요.</span>
					</div>
				</c:if>
				<c:if test="${un_qnaQuestion != null && un_qnaQuestion != '' }">
					<div class="whYmile-div">
						<span class="whYmile">이번엔 제가 질문할게요!</span>
					</div>
					<div class="whYmile-div">
						<span class="whYmile">${un_qnaQuestion }</span>
					</div>
				</c:if>
				<div class="user-div">
					<span class="user">${answer }</span>
				</div>
				<div class="whYmile-div">
					<span class="whYmile">고마워요.</span>
				</div>
				<div class="whYmile-div">
					<span class="whYmile">대화가 종료되었습니다.</span>
				</div>
			</div>
			<div class="inputArea">
				<button onclick="location.href='/whYmile/first.jsp'" class="btn btn-default pull-right">돌아가기</button>
				<button onclick="location.href='/main.jsp'" class="btn btn-default pull-right">메인으로</button>
			</div>
		</div>
		<jsp:include page="/layout/footer.jsp"></jsp:include>
	</c:if>
</body>
</html>