<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="board.BoardDTO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whYmile | 글 삭제 처리</title>
</head>
<body>
<%	
	int no = 0;

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
		if (request.getParameter("no") != null)
		{
			no = Integer.parseInt(request.getParameter("no"));
		}
		
		BoardDTO board = new BoardDAO().getBoard(no);
		
		if (no == 0 || board == null)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 게시물입니다.')");
			script.println("location.href = 'list.jsp'");
			script.println("</script>");
		}
		
		if (!session.getAttribute("userID").equals(board.getWriter()))
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유저의 정보가 일치하지 않습니다.')");
			script.println("location.href = 'list.jsp'");
			script.println("</script>");
		}
		else
		{		
			BoardDAO boardDAO = new BoardDAO();
			
			ArrayList<String> boardImgList = boardDAO.getBoardImg(no);
			String boardImgPath = application.getRealPath("/img/");
			
			for (int i = 0; i < boardImgList.size(); i++)
			{
				if (boardImgList.get(i) == null)
				{
					continue;
				}
				                 
				File file = new File(boardImgPath + boardImgList.get(i));
				file.delete();					
			}
			
			int result = boardDAO.delete(no);
				
			if (result == -1) // 글 삭제 실패
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제 중 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else
			{
				result = boardDAO.refreshNo(no);
				
				if (result == -1)
				{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 번호 새로고침 중 오류가 발생했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else
				{
					result = boardDAO.deleteImg(no);
					
					if (result == -1)
					{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('게시글 이미지 삭제 중 오류가 발생했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else
					{	
						result = boardDAO.refreshImgNo(no);
						
						if (result == -1)
						{
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('게시글 이미지 번호 새로고침 중 오류가 발생했습니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
						else
						{
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'list.jsp'");
							script.println("</script>");													
						}
					}
				}
			}
		}
	}
%>
</body>
</html>