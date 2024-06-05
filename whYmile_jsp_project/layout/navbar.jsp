<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whYmile | 상단 메뉴</title>
<style>
	.navbar-brand {
		background-image: url("/css/img/logo.png");
		background-size: cover;
		background-position: center;
	}
</style>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/main.jsp" style="width: 100px;"></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="/main.jsp">메인</a></li>
				<li><a href="/whYmile/first.jsp">whYmile</a></li>
				<li><a href="/board/list.jsp">게시판</a></li>
			</ul>
			<c:if test="${sessionScope.userID == null}">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdwon">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" 
							aria-expanded="false" style="font-weight: bold; font-size: 15px; padding-left: 20px; padding-right: 20px;">
							접속하기
						</a>
						<ul class="dropdown-menu">
							<li><a href="/user/loginForm.jsp">로그인</a></li> 
							<li><a href="/user/joinForm.jsp">회원가입</a></li>
						</ul>
					</li>
				</ul>
			</c:if>
			<c:if test="${sessionScope.userID != null}">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdwon">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" 
							aria-expanded="false" style="font-weight: bold; font-size: 15px; padding-left: 20px; padding-right: 20px;">
							${sessionScope.userID }
						</a>
						<ul class="dropdown-menu">
							<li><a href="/user/updateForm.jsp">정보수정</a></li> 
							<li><a href="/user/logoutAction.jsp">로그아웃</a></li> 							
						</ul>
					</li>
				</ul>
			</c:if>
		</div>
	</nav>
</body>
</html>