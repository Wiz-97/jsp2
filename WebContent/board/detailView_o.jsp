<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 출력 포맷 사용하기 위한 태그라이브러리 설정 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 문자열 함수 사용하기 위한 태그라이브러리 설정 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 상세보기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/detail.css?v=3">
</head>
<body>  <!-- 메인글: 익명으로 예시(글비밀번호 사용합니다.) , 댓글 : 실명으로 예시(로그인을 해야 글작성,삭제 할수 있습니다.) -->
<main>
	<h3>우리동네 커뮤니티 글상세보기</h3>
	<hr>
	<div style="width: 80%; margin: auto;max-width: 700px;">
		<ul id="main">
			<li>
				<ul class="row">
					<li>제목</li>
					<li>${bean.subject}</li>
					<li>조회수</li>
					<li>${bean.readCount}</li>
				</ul>
			</li>
			<li>
				<ul class="row">
					<li>작성자</li>
					<li>${bean.writer}<span
				style="font-size: 70%; padding-left: 30px;">(${bean.ip})</span></li>
					<li>작성날짜</li>
					<li><fmt:formatDate value="${bean.wdate }" type="both"/></li>
					<!-- pattern="yyyy-MM-dd HH:mm:ss , type= date,time,both -->
				</ul>
			</li>
			<li id="content">
				<ul>
					<li>내용</li>			
					<!-- textarea에 입력한 엔터는 \n db에도 \n으로 저장됩니다.
					     브라우저 출력은 줄바꿈은 <br> 태그 해결1) pre 태그, 해결  2) \n을 <br>로 대치-->	
					<li>
						<pre>${bean.content}</pre>
					</li>				
				</ul>
			</li>
		</ul>
	<div style="text-align: center;margin-bottom: 10px;">
		<a class="button" href="updateAction.jsp?idx=${bean.idx}">수정</a>
		<!--  예시 : 글 비밀번호 입력하여 삭제. -->
		<a class="button" href="javascript:deleteSet()">삭제</a>
		<a class="button" href="listAction.jsp?page=${page }">목록</a>
	</div>
	<!-- 메인글 출력 끝 -->
	
	<hr>
	<!-- 댓글 등록 -->
	<form action="commentAction.jsp" method="post">
	<!-- 필요한 파라미터 이지만 화면에는 표시안함. 2개 필요 : 메인글의 idx , 현재글의 페이지번호 -->
	<input type="hidden" name="mref" value="${bean.idx }">
	<input type="hidden" name="page" value="${page }">
		
		<ul id="main">
			<li>
				<ul class="row">
					<li>작성자</li>	<!-- 1)로그인한 사용자가 작성할때는 로그인 이메일,닉네임 가져와서 표시 -->			
					<li><input name="writer" class="input" ></li>				
					<li>글 비밀번호</li><!-- 댓글 삭제 : 1)로그인한 사용자가 본인글 삭제 또는 2)글 비밀번호 사용 -->				
					<li><input name="password" class="input" type="password"></li>				
				</ul>
			</li>
			<li>
				<ul style="display: flex;">
					<li>
						<textarea rows="5" cols="80" name="content" 
						style="resize:none;margin-right:20px;" placeholder="댓글을 작성하세요." class="input"></textarea>
					</li>				
					<li style="align-self: center;margin-bottom: 20px;">
						<button type="submit">저장</button>
						<button type="reset">취소</button>
					</li>				
				</ul>
			</li>
			<li>
					<span>댓글</span>
					<span>[${bean.commentCount }]</span> <!-- 댓글갯수 -->
				<hr>
			</li>
			
			<!-- 댓글 목록 -->
			<c:forEach var="cmt" items="${cmtlist}">
			<li>
				<ul class="crow">
					<li>${cmt.writer }</li>				
					<li>${cmt.ip }</li>				
					<li>${cmt.wdate }</li>		
					<!-- 삭제 구현 1) 로그인한 사용자의 글만 삭제 버튼이 보입니다.-->		
					<li><a href="javascript:deleteCmt('${cmt.idx }','${bean.idx }')">삭제</a></li>				
				</ul>
			</li>
			<li>
				<pre class="cmtcontent">${cmt.content }</pre>
			</li>
			</c:forEach>
		</ul>	
	</form>
	</div>
	<!-- 처음에는 display가 none 이고 안보입니다. -->
	<!-- modal : alert,confirm 함수 사용하지 않고 추가적인 정보를 받을 때 사용자가 만드는 입력 상자...-->
	<div id="myModal" class="modal">
		<!-- Modal content : 모달 입력창-->
		<div class="modal-content">
			<span class="close" id="close">&times;</span><br>   <!-- 특수기호 코드 &times;  는  x 기호  -->
			<div style="padding: 0px 20px;">
				<b>글비밀번호</b><br>
				<br>
				<form action="deleteAction.jsp" method="post" name="frmPassword">
						
					<input type="hidden" name="idx" value="${bean.idx }"> <!--삭제할 글번호-->
					<input type="hidden" name="page" value="${page }">	
					<input
						type="password" name="password" size="10">
					<button style="padding: 5px 20px;">확인</button>	
					<br>
					<span style="color:red;font-size:0.8em;" id="err"></span>
				</form>
			</div>
		</div>
	</div>
	<!-- 모달 끝 -->
	<script type="text/javascript">
	//모달 입력 상자 닫기
	//let close = document.getElementsByClassName('close')[0];	//getElementsXXX 이면 배열 리턴. 그 요소중에 0번 인덱스
	const vclose = document.getElementById('close');
	vclose.onclick = function(){
		document.getElementById('myModal').style.display='none';
	}
	
	//메인글 삭제 -> 모달 입력 표시
	function deleteSet() {
		document.getElementById('myModal').style.display='block';
	}
	
	
	//댓글 삭제 함수
		function deleteCmt(cmtidx,idx){
			const yn = confirm('댓글 삭제하시겠습니까?');
			if(yn) {
				//함수의 인자로 받은 2개의 값은 파라미터로 전달합니다. 추가된 파라미터 del 이 있습니다.
				location.href='commentAction.jsp?del=y&page=${page}&cmtidx='+cmtidx + '&idx='+idx;
			}else {
				alert('댓글 삭제 취소합니다.');
			}
		}
	
	</script>
	</main>
</body>
</html>