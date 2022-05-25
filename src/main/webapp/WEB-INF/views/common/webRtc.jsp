<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

화상회의
<button type="button" id="openBtn" class="btn btn-primary" style="display:none;">화상회의</button>
		

<script>
$(function(){
	$("#openBtn").on("click",function(){
		//alert("1");
		//window.open('https://192.168.142.10:3000/', 'a1',  'status=no, height=410, width=1100, left=400, top=200,menubar=no,scrollbars=yes,resizable=yes' );
		window.open('https://192.168.142.10:3000/', 'a1',  'status=no, height=410, width=1100, left=400, top=200,menubar=no,scrollbars=yes,resizable=yes' );
		window.history.go(-1);
	})
	
	$("#openBtn").trigger("click");
})
</script>

