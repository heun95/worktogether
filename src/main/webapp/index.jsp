<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAnonymous()">
	<jsp:forward page="/session/login"/>
</sec:authorize>

<sec:authorize access="hasRole('ROLE_MEMBER')">
	<jsp:forward page="/main"/>
</sec:authorize>
