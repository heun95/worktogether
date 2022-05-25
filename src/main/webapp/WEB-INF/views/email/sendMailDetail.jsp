<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h1 class="h3 mb-2 text-gray-800">보낸메일 상세페이지</h1>
<div class="card-header py-3">
    <h6 class="m-0 font-weight-bold text-primary">
    <img src="/resources/images/notes.png"style="width: 40px; height: 40px;" />
    	선택한 메일의 상세정보입니다.</h6>
</div>
<div class="card shadow mb-4">
	<div class="row">
	<div class="col-sm-12">
    <div class="form-actions text-right" style="float: right; margin-top: 10px; margin-right: 10px;">
    	<form method="get" action="/email/sendMaildelete">
    	<input type="hidden" name="emailId" value="${emailVO[0].emailId}">
    	<input type="submit" style="margin-bottom: 10px;" class="btn btn-outline-danger" value="메일삭제" />
        <input type="button" style="margin-bottom: 10px;"
        onclick="location.href='/email/sendMailBox'" class="btn btn-outline-info" value="목록으로돌아가기" />
        </form>
    </div>
	<table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">     <thead>
	    <c:forEach var="row" items="${emailVO}">

	    <tbody >
	    <tr style="height: 50px; text-align: center;">
	        <th style="background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%); width: 180px;">발신자&nbsp;ID</th>
	        <td>${row.emailSendId}</td>
	        <th style="background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%); width: 180px;">수신자&nbsp;ID&nbsp;&nbsp;|&nbsp;&nbsp;이름</th>
	        <td>${row.emailRcvId} | ${row.empName }</td>
	    </tr>
	    <tr style="height: 50px; text-align: center;">
	        <th style="background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%); width: 180px;">제목</th>
	        <td>${row.emailTitle}</td>
	        <th style="background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);">작성일자</th>
	        <td><fmt:formatDate value="${row.emailWrtDt}"  pattern="yyyy-MM-dd  hh:mm"/></td>
	    </tr>
	    
	    <c:set var="senddownfile" value="${senddownfile}"/>
	    <tr style="height: 50px; text-align: center;">
	        <th style="background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%); width: 180px;">보낸파일</th>
	    	<td colspan="3"><a href="${senddownfile.atchPath}" download>
	    	<input type="text" id="filename" value="${senddownfile.atchName}" name="fileName" class="form-control" readonly="readonly" /></a></td>
	    </tr>
	    
		<tr style="height: 400px;" >
	        <th style="background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%); text-align: center;">메일 내용</th>
	        <td colspan="3">${row.emailCntnt}</td>
		</tr>
	    </c:forEach>
	    </tbody>
		
	</table>
	</div>
	</div>
</div>

