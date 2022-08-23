<%@page import="java.util.Map"%>
<%@page import="vo.BookMember"%>
<%@page import="java.util.HashMap"%>
<%@page import="dao.BookMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userid = request.getParameter("userid");
String password = request.getParameter("password");

BookMemberDao dao = BookMemberDao.getInstance();
Map<String, String> map = new HashMap<>();
map.put("email", userid);
map.put("password", password);

//userid="admin@gmail.com"이고 비밀번호는 12345
out.print("<script>");
BookMember vo = dao.login(map);
if (vo != null) {
	//인증 성공
	session.setAttribute("user", userid);
	session.setAttribute("sessionId", session.getId());
	out.print("alert('로그인 했습니다..')");
	out.print("location.href='home.jsp';");
} else {
	//인증 실패
	out.print("alert('로그인 계정 정보가 다릅니다.')");
	out.print("location.href='loginForm.jsp'");
}
out.print("<script>");
%>