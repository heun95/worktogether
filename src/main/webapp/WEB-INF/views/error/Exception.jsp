<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 404 Error Text -->
<div class="text-center">
    <div class="error mx-auto" data-text="Exception">Exception</div>
    <p class="lead text-gray-800 mb-5">
    ${exception.getMessage()}
    </p>
    <ul>
    	<c:forEach var="stack" items="${exception.getStackTrace()}">
    		<li>${stack.toString()}</li>
    	</c:forEach>
    </ul>
    
    
    <a href="#">&larr; 처음으로 이동</a>
</div>
