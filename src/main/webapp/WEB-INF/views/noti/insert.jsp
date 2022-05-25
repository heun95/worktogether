<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>메시지 보내기</title>
</head>
<body>
<form:form modelAttribute="notificationVO" action="/noti/insertNoti" method="post">
	보내는 사람 : <form:input path="notSender" readonly="true" value="${notSender}"/><br/>
	받는 사람 : <form:input path="notReceiver" /><br/>
	보낼 메시지 : <form:input path="notMsg" /><br />
	<button type="submit">전송</button>
</form:form>
</body>
</html>