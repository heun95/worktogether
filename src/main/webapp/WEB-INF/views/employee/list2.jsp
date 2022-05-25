<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
  이거는 admin만 가능함
  <c:forEach var="vo" items="${list}">
  	${vo.empId }<br>
  </c:forEach>
