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
		<jsp:include page="/layout/navbar.jsp" flush="false"/>
		<div class="container">
			<div class="chatArea">
				<div class="whYmile-div">
					<span class="whYmile">먼저 질문을 해 주세요.</span>
				</div>
				<div class="user-div">
					<span class="user">먼저
					질문 하기</span>
				</div>
				<div class="whYmile-div">
					<span class="whYmile">질문에 대한 답변 하기ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ</span>
				</div>
					<div class="whYmile-div"><span class="whYmile">이번엔 제가 질문할게요!</span></div>
					<div class="whYmile-div"><span class="whYmile">커피 추천해 줘</span></div>
				<div class="user-div">
					<span class="user">아샷추에 샷을 추가해서 샷을 추가해버리면 투샷을 추가한 것이니 거기에 한번 더 샷을 추가해버리기~aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</span>
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