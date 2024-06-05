<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 파일 이름과 관련되어 처리해주는 클래스 -->
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<% request.setCharacterEncoding("utf-8"); %>
<%-- <!-- scope="page" : 현재의 페이지 안에서만 빈즈 사용 가능 -->
<jsp:useBean id="board" class="board.Board" scope="page"/>
<jsp:setProperty name="board" property="title"/>
<jsp:setProperty name="board" property="content"/> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whYmile | 게시판 글쓰기 처리</title>
</head>
<body>
<%
	if (session.getAttribute("userID") == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해 주세요.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	else
	{
		String boardImgPath = application.getRealPath("/img/"); // 이미지 저장 경로 
		
		MultipartRequest multi = new MultipartRequest(request, boardImgPath, 
				100 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
		
		if (multi.getParameter("title").trim().equals("")) // 제목을 입력 안 했을 시
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('제목을 입력해 주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (multi.getParameter("content").trim().equals("")) // 내용을 입력 안 했을 시
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('내용을 입력해 주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else
		{			
			BoardDAO boardDAO = new BoardDAO();
			int result = boardDAO.boardWrite(multi.getParameter("title").trim(), multi.getParameter("content").trim(), (String)session.getAttribute("userID"));	
			
			if (result == -1) // 글쓰기 실패 (데이터 베이스 오류 등..)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기 중 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else
			{
				Enumeration files = multi.getFileNames(); // 모든 업로드 이미지 받아오기
				int imgNo = 5;
				
				while (files.hasMoreElements())
				{	
					String image = (String) files.nextElement();
					String fileRealName = multi.getFilesystemName(image); // 저장된 이미지 파일명 (서버)
					String fileType = multi.getContentType(image);
					
					if (fileType == null) // 아무 파일을 올리지 않았을 때
					{
						boardDAO.boardWriteImg(boardDAO.getNo(), null, imgNo); // 데이터베이스에 null로 저장
					}
					else if (fileType.equals("image/gif") || fileType.equals("image/png") || fileType.equals("image/jpeg"))
					{
						boardDAO.boardWriteImg(boardDAO.getNo(), fileRealName, imgNo);
					}
					else
					{
						File file = new File(boardImgPath + fileRealName);
						file.delete();
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('이미지 파일 형식이 옳지 않습니다.')");
						script.println("</script>");
						boardDAO.boardWriteImg(boardDAO.getNo(), null, imgNo);
					}
					
					imgNo--;
				}
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'list.jsp'");
				script.println("</script>");
			}
		}
	}
%>
</body>
</html>