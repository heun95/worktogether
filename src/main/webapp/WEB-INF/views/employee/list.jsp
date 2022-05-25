<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
    이거는 member만 가능함
  <c:forEach var="vo" items="${list}">
  	${vo.empId }<br>
  </c:forEach>

  <sec:authorize access="hasRole('ROLE_TIMJANG')">
   	 요거는 ROLE_TIMJANG 만 볼수 있어
  </sec:authorize>

