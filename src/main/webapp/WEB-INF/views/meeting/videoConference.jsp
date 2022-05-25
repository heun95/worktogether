<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 커스텀 CSS -->
<link rel="stylesheet" href="/resources/css/autho.css" type="text/css"/>

<div class="row m-1">
	<h3>화상회의</h3>
</div>
<div class="row m-1">
	<div class="card overflow-hidden card-h-100 ">
		<div class="card-body" id="j-card">
		 	<form action="/common/notiWebRtc" method="get">
				<button onclick="f_open()" type="button" id="videoBtn" class="btn btn-primary">화상회의</button>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">

// 	$("#videoBtn").on("click",function(){
// 		alert("화상채팅을 연결합니다.");
// 		//location.href = "";
// 		window.open("","워크To게더","width=800, height=800");
// 	})

	function f_open() {
		window.open('https://192.168.142.10:3000/', 'b2', 'status=no, height=410, width=1100, left=400, top=200,menubar=no,scrollbars=yes,resizable=yes' );
		$("form").submit();
	}

</script>