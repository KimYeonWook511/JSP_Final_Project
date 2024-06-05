<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whYmile | 게시판 글쓰기</title>
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
			alert('로그인을 해 주세요.');
			location.href = '/user/loginForm.jsp';
		</script>
	</c:if>
	<c:if test="${sessionScope.userID != null }">
		<jsp:include page="/layout/navbar.jsp" flush="false"/>
		<div class="container">
			<h1>게시판 글쓰기</h1>
			<form action="writeAction.jsp" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label>제목 : </label> <!-- for와 id 맞추기 -->
					<input type="text" class="form-control" name="title" placeholder="제목을 입력해 주세요." maxlength="50">
				</div>
					<!-- id는 화면에서 컨트롤(내부) name은 넘어갈 때 쓰는 파라미터 -->
				<div class="form-group">
					<label>내용 : </label>
					<textarea class="form-control" rows="20" name="content" maxlength="1000"></textarea>
				</div>
				<div class="form-group">
					<label>이미지 : </label>
					<table class="rest_imgFile">
						<tr>
							<td><input type="file" name="img1" accept="image/gif, image/png, image/jpeg" class="file_input"></td>
							<td><input type="file" name="img2" accept="image/gif, image/png, image/jpeg" class="file_input"></td>
							<td><input type="file" name="img3" accept="image/gif, image/png, image/jpeg" class="file_input"></td>
							<td><input type="file" name="img4" accept="image/gif, image/png, image/jpeg" class="file_input"></td>
							<td><input type="file" name="img5" accept="image/gif, image/png, image/jpeg" class="file_input"></td>
						</tr>
					</table>
					<div class="rest_imgMain">
						<span class="rest_img" style="display: table-cell; text-align: center; vertical-align: middle;">미리보기</span>
						<span class="rest_img" style="display: table-cell; text-align: center; vertical-align: middle;">미리보기</span>
						<span class="rest_img" style="display: table-cell; text-align: center; vertical-align: middle;">미리보기</span>
						<span class="rest_img" style="display: table-cell; text-align: center; vertical-align: middle;">미리보기</span>
						<span class="rest_img" style="display: table-cell; text-align: center; vertical-align: middle;">미리보기</span>
					</div>
				</div>
				<input type="submit" class="btn btn-default" value="등록">	
				<button type="button" onclick="history.back()"class="btn btn-default">뒤로가기</button>	
			</form>
		</div>
		<jsp:include page="/layout/footer.jsp"></jsp:include>
	</c:if> 
	<script>
		let input = document.querySelectorAll('[type="file"]');
		let preview = document.querySelectorAll('.rest_img');
		for(let i=0; i<input.length; i++) {
		    input[i].addEventListener('change', function(e) {
		        let file = e.target.files;
		        if(file.length) {
		            let reader = new FileReader();
		            reader.readAsDataURL(file[0]);
		            reader.onload = function() {
		                let dataUrl = reader.result;
		                preview[i].innerHTML = '<img src="' + dataUrl + '" style="height:'+ $('.rest_img').height() +'px; width:'+ $('.rest_img').width() +'px;">';
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
			var w = ($('.container').width())/5-5;
			$('.rest_imgFile').css({width:$('.container').width()+'px'});
			$('.file_input').css({width:w+'px'});
			$('.rest_imgMain').css({height:h+'px', width:$('.container').width()+'px'});
			$('.rest_img').css({height:h+'px', width:w+'px'});
		});
	</script> 
</body>
</html>