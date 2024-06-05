<%@ page import="java.util.ArrayList"%>
<%@ page import="board.BoardDTO" %>
<%@ page import="board.BoardDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whYmile | 메인 페이지</title>
<!-- 라이브러리 등록 - jQuery, Bootstrap : CDN 방식-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/css/main.css">
</head>
<body>
	<%
		BoardDAO boardDAO = new BoardDAO();
		ArrayList<BoardDTO> hotList = boardDAO.getHotList(); // 인기 순(조회 수) 게시글 불러오기
		ArrayList<String> boardImg = new ArrayList<String>(); // 해당 인기 게시글에 등록된 이미지 파일 명을 저장할 ArrayList
		
		request.setAttribute("boardDAO", boardDAO);
		request.setAttribute("hotList", hotList);
		request.setAttribute("boardImg", boardImg);
	%>
	<jsp:include page="/layout/navbar.jsp" flush="false"/>
	<div class="container">
		<div class="goArea">
			<div class="go-whYmile">
				<a type="button" onclick="location.href = '/whYmile/first.jsp'" style="position: relative;">
					<img src="/css/img/gowhYmile.png" style="width: 400px; height: 400px;">
				</a>
			</div>
			<div class="go-board">
				<a type="button" onclick="location.href = '/board/list.jsp'" style="position: relative;">
					<img src="/css/img/goboard.png" style="width: 400px; height: 400px;">
				</a>
			</div>
		</div>
		<div class="boardArea">
			<c:if test="${hotList == null }">
				<div style="">
					현재 인기글이 존재하지 않습니다.
				</div>
			</c:if>
			<c:if test="${hotList != null }">
				<div class="hotHeader">인기 게시글</div>
				<hr>
				<div class="hotList">
					<c:forEach var="board" items="${hotList }" varStatus="status">
						<div class="hotBoard${status.index + 1 }">
							<div class="background">
								<a onclick="location.href = '/board/view.jsp?no=${board.getNo() }'" style="position: relative;">
									${thumbnail = -1;'' }
									<c:forEach var="boardimg" items="${boardDAO.getBoardImg(board.getNo()) }" varStatus="imgStatus">
										<c:if test="${boardimg != null && thumbnail == -1}">
											${thumbnail = imgStatus.index;'' }
										</c:if>
									</c:forEach>
									<c:if test="${thumbnail == -1 }">
										<img src="/css/img/NOIMAGE.png" style="width: 570px; height: 250px;">
									</c:if>
									<c:if test="${thumbnail != -1 }">
										<img src="/img/${boardDAO.getBoardImg(board.getNo()).get(thumbnail) }" style="width: 570px; height: 250px;">
									</c:if>
									<div class="hotBoardTitle">
										<span class="hotBoardTitle-inner">${board.getTitle() }</span>
									</div>
								</a>
							</div>
						</div>
						<c:if test="${status.index % 2 != 0 }">
<!-- 							<hr class="list_hr"> -->
						</c:if>
					</c:forEach>
				</div>
			</c:if>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>