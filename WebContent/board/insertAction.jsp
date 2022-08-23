<%@page import="board.vo.Freeboard"%>
<%@page import="board.dao.FreeboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   	request.setCharacterEncoding("UTF-8");
	
	//????
	String writer = request.getParameter("writer");
	String password = request.getParameter("password");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");		
	String ip = request.getRemoteAddr();

	FreeboardDao freedao = FreeboardDao.getInstance();
// 	 Freeboard bean = Freeboard.builder()
// 			.writer("김땡땡").subject("글쓰기 테스트").content("잘되나요??").password("1212").build();
	Freeboard bean 
	= new Freeboard(0,writer,password,subject,content,0,null,ip,0);
//	= new Freeboard(0,"김땡땡","1212","글쓰기 테스트","잘되나요??",	0,null,null,0);
	freedao.insert(bean);
	response.sendRedirect("listAction.jsp");   //글목록 화면으로 url 재요청
%>