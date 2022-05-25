<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 후 index page. 이 화면에서 알림 메시지를 받습니다.</title>
<script src="/resources/js/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
 <!-- 로그인한 아이디 (접속아이디 확인) -->
<h6>${userInfo.username} 님 안녕하세요.</h6>
<a href="/insert?notSender=${userInfo.username}">쪽지보내기</a>

<script>
//var id = '<c:out value="${userInfo.username}" />';   //controller에서 받은 id 세팅
var v_notReceiver = "${userInfo.username}";

function showWindow(){
   $.ajax({
      url:"/noti/viewAjax",
      method:"get",
      data:{"notReceiver": v_notReceiver}, 
      dataType:"json",
      success:function(data){
		   console.log("dd1");
        	alert(data.notSender + " : " + data.notMsg);         
      }
   });
}

window.onload = function(){
   setInterval(showWindow,10000); //밀리세컨드. 1초에 한번씩 read합니다.
} 

</script>
</body>
</html>