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
<title>whYmile | 게시글 보기</title>
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
	<%
		int no = 0;
		
		if (request.getParameter("no") != null)
		{
			no = Integer.parseInt(request.getParameter("no"));
		}
		
		BoardDAO boardDAO = new BoardDAO();
		BoardDTO board = boardDAO.getBoard(no);
		ArrayList<String> boardImgList = boardDAO.getBoardImg(no);
		
		request.setAttribute("boardDAO", boardDAO);
		request.setAttribute("no", no);
		request.setAttribute("board", board);
		request.setAttribute("boardImgList", boardImgList);
	%>
	<c:if test="${no == 0 || board == null }">
		<script>
			alert('존재하지 않는 게시물입니다.');
			location.href = 'list.jsp';
		</script>
	</c:if>
	<c:if test="${sessionScope.userID != null }">
		<!-- DB에 있는 해당 게시판 레코드 조회수 1증가 시키기 -->
		${result = boardDAO.upViewCount(board.getNo(), board.getViewCount());'' }
		<c:if test="${result == -1 }">
			<script>
				alert('조회수 카운트 오류.');
			</script>
		</c:if>
		<c:if test="${result != -1 }">
			<!-- DB에 성공적으로 업데이트가 되면 이미 불러와진 조회수에서 + 1 하여 출력하기 위한 setter사용 -->
			${board.setViewCount(board.getViewCount() + 1);'' }
		</c:if>
	</c:if>
	<jsp:include page="/layout/navbar.jsp" flush="false"/>
	<div class="container">
		<div style="color: #747474; font-weight: bold; font-size: 30px;">게시판 글보기</div>
		<table class="table"> <!-- 부트스트랩 테이블 -->
			<tr>
				<th style="width: 20%;">번호</th>
				<td colspan="2">${board.getNo() }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="2">${board.getReplaceTitle() }</td>
			</tr>
			<tr>
				<th>내용</th>
				<td style="word-wrap: break-word; word-break: break-all;">${board.getReplaceContent() }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td colspan="2">${board.getWriter() }</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td colspan="2">${board.getWriteDate() }</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td colspan="2">${board.getViewCount() }</td>
			</tr>
			<tr>
				<td colspan="3"></td>
			</tr>
		</table>
		${flag = false;'' }
		<c:forEach var="boardImg" items="${boardImgList }">
			<c:if test="${boardImg != null }">
				${flag = true;'' }
			</c:if>
		</c:forEach>
		<c:if test="${flag == true }"> <!-- 등록된 사진이 있을 경우에 myCarousel 생성 -->
			${firstImg = true;'' }
			<div class="container">
				<div id="myCarousel" class="carousel slide" data-ride="carousel" style="width: 400px; height: 300px;">
					<ol class="carousel-indicators">
						<c:forEach var="boardImg" items="${boardImgList }" varStatus="status">
							<c:choose>
								<c:when test="${boardImg != null && firstImg == true }">
									<li data-target="#myCarousel" data-slide-to="${status.count }" class="active">
									${firstImg = false;'' }
								</c:when>
								<c:when test="${boardImg != null }">
									<li data-target="#myCarousel" data-slide-to="${status.count }">
								</c:when>
							</c:choose>
						</c:forEach>
					</ol>
					${firstImg = true;'' }
					<div class="carousel-inner">
						<c:forEach var="boardImg" items="${boardImgList }">
							<c:choose>
								<c:when test="${boardImg != null && firstImg == true }">
									<div class="item active">
										<img src="/img/${boardImg }" style="width: 400px; height: 300px;">
										${firstImg = false;'' }
									</div>
								</c:when>
								<c:when test="${boardImg != null }">
									<div class="item">
										<img src="/img/${boardImg }" style="width: 400px; height: 300px;">
									</div>
								</c:when>
							</c:choose>
						</c:forEach>
					</div>
					<a class="left carousel-control" href="#myCarousel" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left"></span>
				</a>
				<a class="right carousel-control" href="#myCarousel" data-slide="next">
					<span class="glyphicon glyphicon-chevron-right"></span>
				</a>
			</div>
		</div>
		<br>
		</c:if>
		<c:if test="${sessionScope.userID != null && sessionScope.userID.equals(board.getWriter()) }">
			<a href="updateForm.jsp?no=${no }" class="btn btn-default">수정</a>
			<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?no=${no }" class="btn btn-default">삭제</a>
		</c:if>
		<a href="list.jsp" class="btn btn-default">목록</a>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>