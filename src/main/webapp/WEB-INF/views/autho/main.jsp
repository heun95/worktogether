<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Bootstrap(CSS) -->
<link href="/resources/dist/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">
<link href="/resources/dist/assets/libs/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css">
<link href="/resources/dist/assets/libs/datatables.net-select-bs4/css/select.bootstrap4.min.css" rel="stylesheet" type="text/css">
<link href="/resources/dist/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css">

<!-- 커스텀 CSS -->
<link rel="stylesheet" href="/resources/css/autho.css" type="text/css"/>

<div class="row m-1">
	<h3 class="h3 mb-2 text-gray-800" style="color: #6c6ff5">메인페이지</h3>
</div>

<div class="row m-1">
	<div class="card overflow-hidden card-h-100" style="height: 400px;">
		<div class="card-body" id="j-card">
	       <div class="row mb-3">
				<h4 class="card-title"><a href="/autho/receiveDoc">받은 결재함</a></h4>
		   </div>
		   <div id="datatable-buttons_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
   				<table id="datatable-buttons" class="table table-striped table-bordered dt-responsive nowrap dataTable no-footer dtr-inline" style="border-collapse: collapse; border-spacing: 0px; width: 100%;" role="grid" aria-describedby="datatable-buttons_info">
			       <thead>
			       		<tr role="row">
			       			<th class="text-center" tabindex="0" aria-controls="datatable-buttons" rowspan="1" colspan="1" style="width: 50px;" aria-label="Name: activate to sort column descending">번호</th>
			       			<th class="text-center" tabindex="0" aria-controls="datatable-buttons" rowspan="1" colspan="1" style="width: 800px;" aria-label="Position: activate to sort column ascending">제목</th>
			       			<th class="text-center" tabindex="0" aria-controls="datatable-buttons" rowspan="1" colspan="1" style="width: 80px;" aria-label="Office: activate to sort column ascending">기안자</th>
			       			<th class="text-center" tabindex="0" aria-controls="datatable-buttons" rowspan="1" colspan="1" style="width: 80px;" aria-label="Age: activate to sort column ascending">부서</th>
			       			<th class="text-center" tabindex="0" aria-controls="datatable-buttons" rowspan="1" colspan="1" style="width: 140px;" aria-label="Start date: activate to sort column ascending">작성일시</th>
			       			<th class="text-center" tabindex="0" aria-controls="datatable-buttons" rowspan="1" colspan="1" style="width: 100px;" aria-label="Salary: activate to sort column ascending">문서양식</th>
			       		</tr>
			       </thead>
			       <tbody>
			       	   <c:forEach var="vo" items="${receiveDocList}" varStatus="status">
			       	   <c:if test="${status.count <=5}">
				       <tr>
				           <td class="text-center">${status.count}</td>
				           <td>
				           	<a href="/autho/receiveDocDetail?docId=${vo.docId}&atrzAprvId=${userInfo.username}">${vo.docTitle}</a>
				           	<c:if test="${vo.atrzState == '미결재'}">
				           		<span class="badge rounded-pill bg-danger pt-1" style="float:right; font-size: 11px;">미결재</span>
				           	</c:if>
				           	<c:if test="${vo.atrzState == '진행중'}">
				           		<span class="badge rounded-pill bg-primary pt-1" style="float:right; font-size: 11px;">진행중</span>
				           	</c:if>
				           	<c:if test="${vo.atrzState == '결재완료'}">
				           		<span class="badge rounded-pill bg-success pt-1" style="float:right; font-size: 11px;">결재완료</span>
				           	</c:if>
				           	<c:if test="${vo.atrzState == '반려'}">
				           		<span class="badge rounded-pill bg-info pt-1" style="float:right; font-size: 11px;">반려</span>
				           	</c:if>
				           </td>
				           <td class="text-center">${vo.docWrtrName}</td>
				           <td class="text-center">${vo.docDeptName}</td>
				           <td class="text-center"><fmt:formatDate value="${vo.docWrtDt}" pattern="yyyy-MM-dd hh:mm"/>  </td>
				           <td class="text-center">${vo.docTypeName}</td>
				       </tr>
				       </c:if>
			       	   </c:forEach>	
			        </tbody>
			    </table>
			</div>
		</div>
	</div>
</div>

<div class="row m-1">
	<div class="card overflow-hidden card-h-100" style="height: 400px;">
		<div class="card-body" id="j-card">
	       <div class="row mb-3">
				<h4 class="card-title"><a href="/autho/sendDoc">보낸 결재함</a></h4>
		   </div>
		   <table id="datatable-buttons" class="table table-striped table-bordered dt-responsive nowrap dataTable no-footer dtr-inline" style="border-collapse: collapse; border-spacing: 0px; width: 100%;" role="grid" aria-describedby="datatable-buttons_info">
		       <thead>
		       		<tr role="row">
		       			<th class="text-center" tabindex="0" aria-controls="datatable-buttons" rowspan="1" colspan="1" style="width: 50px;" aria-label="Name: activate to sort column descending">번호</th>
		       			<th class="text-center" tabindex="0" aria-controls="datatable-buttons" rowspan="1" colspan="1" style="width: 800px;" aria-label="Position: activate to sort column ascending">제목</th>
		       			<th class="text-center" tabindex="0" aria-controls="datatable-buttons" rowspan="1" colspan="1" style="width: 80px;" aria-label="Office: activate to sort column ascending">기안자</th>
		       			<th class="text-center" tabindex="0" aria-controls="datatable-buttons" rowspan="1" colspan="1" style="width: 80px;" aria-label="Age: activate to sort column ascending">부서</th>
		       			<th class="text-center" tabindex="0" aria-controls="datatable-buttons" rowspan="1" colspan="1" style="width: 140px;" aria-label="Start date: activate to sort column ascending">작성일시</th>
		       			<th class="text-center" tabindex="0" aria-controls="datatable-buttons" rowspan="1" colspan="1" style="width: 100px;" aria-label="Salary: activate to sort column ascending">문서양식</th>
		       		</tr>
		       </thead>
		       <tbody>
		       	   <c:forEach var="vo" items="${sendDocList}" varStatus="status">
		       	   <c:if test="${status.count <= 5}">
			       <tr>
			           <td class="text-center">${status.count}</td>
			           <td>
			           	<a href="/autho/sendDocDetail?docId=${vo.docId}">${vo.docTitle}</a>
			           	<c:if test="${vo.atrzState == '대기중'}">
			           		<span class="badge rounded-pill bg-secondary pt-1" style="float:right; font-size: 11px;">대기중</span>
			           	</c:if>
			           	<c:if test="${vo.atrzState == '진행중'}">
			           		<span class="badge rounded-pill bg-primary pt-1" style="float:right; font-size: 11px;">진행중</span>
			           	</c:if>
			           	<c:if test="${vo.atrzState == '결재완료'}">
			           		<span class="badge rounded-pill bg-success pt-1" style="float:right; font-size: 11px;">결재완료</span>
			           	</c:if>
			           	<c:if test="${vo.atrzState == '반려'}">
			           		<span class="badge rounded-pill bg-info pt-1" style="float:right; font-size: 11px;">반려</span>
			           	</c:if>
			           </td>
			           <td class="text-center">${vo.docWrtrName}</td>
			           <td class="text-center">${vo.docDeptName}</td>
			           <td class="text-center"><fmt:formatDate value="${vo.docWrtDt}" pattern="yyyy-MM-dd hh:mm"/>  </td>
			           <td class="text-center">${vo.docTypeName}</td>
			       </tr>
			       </c:if>
		       	   </c:forEach>	
		        </tbody>
		    </table>
		</div>
	</div>
</div>


