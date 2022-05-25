<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

   <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.js"></script>
   <script src="http://cdn.ckeditor.com/4.4.7/standard/ckeditor.js"></script>
   <style>
   .cke_contents{
	min-height:300px;
}
   </style>
   <script>
   $(function(){
	   $("#unsentMailSend").on("click", function(){
		   $("#sendform").submit();
	   });
   });
   </script>

<h1 class="h3 mb-2 text-gray-800">임시보관메일 상세페이지</h1>
<div class="card-header py-3">
    <h6 class="m-0 font-weight-bold text-primary">
    <img src="/resources/images/notes.png"style="width: 40px; height: 40px;" />
   	선택한 메일의 상세정보입니다. 메일의 내용을 수정하여 메일전송을 진행할 수 있습니다.
    </h6>
</div>

<div class="card shadow mb-4">
	<div class="row">
	<div class="col-sm-12">
    <div class="form-actions text-right" style="float: right; margin-top: 10px; margin-right: 10px;">
   	<form method="get" action="/email/unsentMailDel">
    	<input type="hidden" name="emailId" value="${emailVO.emailId}">
    	<input type="submit" style="margin-bottom: 10px;" class="btn btn-outline-danger" value="메일삭제" />
   		<input type="button" style="margin-bottom: 10px;" onclick="location.href='/email/unsentMailBox'"  class="btn btn-outline-info" value="목록으로돌아가기" />
    </form>
 
    </div>
    <c:set var="row"  value="${emailVO}"/>
    <c:set var="attachVO" value="${attachVO}"/>
    <form:form  modelAttribute="emailVO" method="post" action="/email/unsentMailSend" id="sendform" enctype="multipart/form-data">
	<table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;"><thead>
	    <form:input type="hidden" path="emailId"/>
	    <tbody>
	    <tr style="height: 50px; text-align: center;">
	        <th style="background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%); width: 180px;">발신자&nbsp;ID</th>
	        <td>${row.emailSendId}</td>
	        <th style="background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%); width: 180px;">수신자&nbsp;ID</th>
	        <td><form:input type="text" path="emailRcvId"/></td>
	    </tr>
	    <tr style="height: 50px; text-align: center;">
	        <th style="background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%); width: 180px;">제목</th>
	        <td><form:input type="text" path="emailTitle"/></td>
	        <th style="background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%); width: 180px;">작성일자</th>
	        <td><fmt:formatDate value="${row.emailWrtDt}" pattern="yyyy-MM-dd  hh:mm"/></td>
	    </tr>
	    
	    <tr>
	    	<th style="background-image:linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%); width: 180px; text-align: center;">파일첨부</th>
	    	<td colspan="3"><input type="file" id="input_files" name="uploadFile" value="${attachVO.atchPath}" />
	    	<span><img style="width: 40px; height: 40px;" src="/resources/images/check-mark.png"/>&nbsp;&nbsp; 선택했었던 파일명 ▶  ${attachVO.atchName}</span></td>
	    </tr>
	    
		<tr style="height: 400px;">
            <div class="col-sm-10">
	        <th style="background-image:linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%); width: 130px; text-align: center;">메일 내용</th>
	        <td colspan="3"><form:textarea  path="emailCntnt" class="ckeditor" /></td>
            </div>
		</tr>
	    </tbody>
	</table>
	<input type="button" id="unsentMailSend" style="margin-left: 750px; margin-bottom: 20px; margin-top: 10px;" class="btn btn-outline-primary" value="메일전송 진행하기" />
	</form:form>
	</div>
	</div>
</div>