<%@ page import="java.util.ArrayList"%>
<%@ page import="board.BoardDTO"%>
<%@ page import="board.BoardDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whYmile | 게시판 글 수정</title>
<!-- 라이브러리 등록 - jQuery, Bootstrap : CDN 방식-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
	.btn_remove {
		 top: 0; right: 0; 
		 z-index: 1; 
		 display: block; 
		 width: 30px; 
		 height: 30px;
	}
	.picture_remove {
	    top: 8px;
	    right: 8px;
	    width: 13px;
	    height: 13px;
	    background-image: url(http://localhost:8080/Project_PLANB/btn/remove.png);
	}
	.btn_remove:hover {
		background-color: black;
		color: white;
	}
</style>
</head>
<body>
	<c:if test="${sessionScope.userID == null}">
		<script>
			alert('로그인을 해 주세요.');
			location.href = '/user/loginForm.jsp';
		</script>
	</c:if>
	<c:if test="${sessionScope.userID != null }">
		<%
			int no = 0;
		
			if (request.getParameter("no") != null)
			{
				no = Integer.parseInt(request.getParameter("no"));
			}
			
			BoardDTO board = new BoardDAO().getBoard(no);
			ArrayList<String> boardImgList = new BoardDAO().getBoardImg(no);
			
			request.setAttribute("no", no);
			request.setAttribute("board", board);
			request.setAttribute("boardImgList", boardImgList);
		%>
		<c:if test="${no == 0 || board == null }">
			<script>
				alert('존재하지 않는 게시물입니다.');
				location.href = '/board/list.jsp';
			</script>
		</c:if>
		<c:if test="${!sessionScope.userID.equals(board.getWriter()) }">
			<script>
				alert('유저의 정보가 일치하지 않습니다.');
				location.href = '/board/list.jsp';
			</script>
		</c:if>
		<jsp:include page="/layout/navbar.jsp" flush="false"/>
		<div class="container">
			<h1>게시판 글 수정하기</h1>
			<form action="updateAction.jsp?no=${no }" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label>번호 : ${board.getNo() }</label>
				</div>
				<div class="form-group">
					<label>제목 : </label>
					<input type="text" class="form-control" name="title" placeholder="제목을 입력해 주세요." maxlength="50" value="${board.getTitle() }">
				</div>
					<!-- id는 화면에서 컨트롤(내부) name은 넘어갈 때 쓰는 파라미터 -->
				<div class="form-group">
					<label>내용 :</label>
					<textarea class="form-control" rows="5" name="content" maxlength="1000" >${board.getContent() }</textarea>
				</div>
				<div class="form-group">
					<label>이미지 : </label>
					<table class="board_imgFile">
					    <tr>
					        <td><input type="file" name="img1" accept="image/gif, image/png, image/jpeg" class="file_input"></td>
					        <td><input type="file" name="img2" accept="image/gif, image/png, image/jpeg" class="file_input"></td>
					        <td><input type="file" name="img3" accept="image/gif, image/png, image/jpeg" class="file_input"></td>
					        <td><input type="file" name="img4" accept="image/gif, image/png, image/jpeg" class="file_input"></td>
					        <td><input type="file" name="img5" accept="image/gif, image/png, image/jpeg" class="file_input"></td>
					    </tr>
				    </table>
					<div class="board_imgMain">
					    <c:forEach var="boardImg" items="${boardImgList }">
					    	<c:if test="${boardImg == null }">
					    		<span class="board_img" style="display: table-cell; text-align: center; vertical-align: middle;">
					    			미리보기
					    		</span>
					    	</c:if>
					    	<c:if test="${boardImg != null }">
					    		<span class="board_img" style="display: table-cell; text-align: center; vertical-align: middle;">
					    			<img class="board_imgtag" src="/img/${boardImg }">
					    		</span>
					    	</c:if>
					    </c:forEach>
					</div>
				</div>
				<div class="form-group">
					<label>작성자 : ${board.getWriter() }</label> 
				</div>
				<input type="submit" class="btn btn-default" value="수정">
				<button type="button" onclick="history.back()"class="btn btn-default">뒤로가기</button>	
			</form>
		</div>
		<jsp:include page="/layout/footer.jsp"></jsp:include>
	</c:if>
	<script>
		let input = document.querySelectorAll('[type="file"]');
		let preview = document.querySelectorAll('.board_img');
		for(let i=0; i<input.length; i++) {
		    input[i].addEventListener('change', function(e) {
		        let file = e.target.files;
		        if(file.length) {
		            let reader = new FileReader();
		            reader.readAsDataURL(file[0]);
		            reader.onload = function() {
		                let dataUrl = reader.result;
		                preview[i].innerHTML = '<img src="' + dataUrl + '" style="height:'+ $('.board_img').height() +'px; width:'+ $('.board_img').width() +'px;">';
		            }
		        } else {
		            preview[i].innerHTML = '미리보기';
		        }
		    })
		}
	</script>
	<script>
		$(document).ready(function(){
			var h = 220;
			var w = ($('.container').width())/5;
			$('.board_imgFile').css({width:$('.container').width()+'px'});
			$('.file_input').css({width:w+'px'});
			$('.board_imgMain').css({height:h+'px', width:$('.container').width()+'px'});
			$('.board_img').css({height:h+'px', width:w+'px'});
			$('.board_imgtag').css({height:h+'px', width:w+'px'});
		});
	</script>
</body>
</html>