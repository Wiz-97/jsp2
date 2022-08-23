<%@page import="board.vo.Comment"%>
<%@page import="board.dao.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//댓글 추가와 삭제하는 dao 메소드를 실행하는 Action 클래스
	//   ㄴ 댓글 삭제할때에는 del 파라미터를 전달합니다.
	request.setCharacterEncoding("UTF-8");
	CommentDao dao = CommentDao.getInstance();
	String del = request.getParameter("del");
	if(del !=null && del.equals("y")) {	//del이 null 일때는 첫번째 조건 false 이므로 두번째 조건 equals메소드 실행 안합니다.
		//댓글 삭제
		int cmtidx = Integer.parseInt(request.getParameter("cmtidx"));
		int idx = Integer.parseInt(request.getParameter("idx"));
		dao.delete(cmtidx);
		response.sendRedirect("detailAction.jsp?idx="+idx + "&page="+request.getParameter("page"));
	} else {
		//댓글 등록(추가)
		//댓글을 등록하기 위하 mref 컬럼 값 꼭 필요합니다.
				int mref= Integer.parseInt(request.getParameter("mref"));
				String writer = request.getParameter("writer");
				String content = request.getParameter("content");
				String ip =request.getRemoteAddr();
				
				Comment vo = new Comment(0,mref,writer,content,null,ip,0);
				dao.insert(vo);
				//댓글 등록 확인하기 위해 글상세보기 페이지로 이동
				response.sendRedirect("detailAction.jsp?idx="+mref+"&page="+request.getParameter("page"));
	}
%>