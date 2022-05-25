<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Bootstrap(CSS) -->
<link href="/resources/dist/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">
<link href="/resources/dist/assets/libs/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css">
<link href="/resources/dist/assets/libs/datatables.net-select-bs4/css/select.bootstrap4.min.css" rel="stylesheet" type="text/css">
<link href="/resources/dist/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css">

<!-- DataTable -->
<script src="/resources/dist/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="/resources/dist/assets/js/pages/datatables.init.js"></script>

<!-- Buttons -->
<script src="/resources/dist/assets/libs/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-buttons-bs4/js/buttons.bootstrap4.min.js"></script>
<script src="/resources/dist/assets/libs/jszip/jszip.min.js"></script>
<script src="/resources/dist/assets/libs/pdfmake/build/pdfmake.min.js"></script>
<script src="/resources/dist/assets/libs/pdfmake/build/vfs_fonts.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-buttons/js/buttons.html5.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-buttons/js/buttons.print.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-buttons/js/buttons.colVis.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-select/js/dataTables.select.min.js"></script>

<!-- Responsive -->
<script src="/resources/dist/assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>

<!-- 커스텀 CSS -->
<link rel="stylesheet" href="/resources/css/autho.css" type="text/css"/>

<script>
$(function(){
	$('#datatable-buttons_wrapper > div:nth-child(1) > div:nth-child(1) > div.dt-buttons.btn-group.flex-wrap').hide();
})
</script>

<div class="row m-1">
	<h3>진행중 회의</h3>
</div>

<div class="row m-1">
	<div class="card overflow-hidden card-h-100 ">
		<div class="card-body" id="j-card">
		   <div id="datatable-buttons_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
		   		<div class="row">
		   			<div class="col-sm-12">
		   				<table id="datatable-buttons" class="table table-striped table-bordered dt-responsive nowrap dataTable no-footer dtr-inline" style="border-collapse: collapse; border-spacing: 0px; width: 100%;" role="grid" aria-describedby="datatable-buttons_info">
					       <thead>
					       		<tr role="row">
					       			<th class="text-center" style="width: 50px;" >번호</th>
					       			<th class="text-center" style="width: 50px;" >상태</th>
					       			<th class="text-center" style="width: 800px;">제목</th>
					       			<th class="text-center" style="width: 50px;">회의일시</th>
					       			<th class="text-center" style="width: 50px;">회의분류</th>
					       			<th class="text-center" style="width: 50px;">회의실</th>
					       			<th class="text-center" style="width: 50px;">등록자</th>
					       			<th class="text-center" style="width: 50px;">참석인원</th>
					       		</tr>
					       </thead>
					       <tbody>
							   <c:set var="cnt" value="0"/>
					       	   <c:forEach var="vo" items="${meetingList}">
							   <c:if test="${vo.mtngState == '진행중'}">
							   <c:set var="cnt" value="${cnt+1}"/>
						       <tr>
						           <td class="text-center">${cnt}</td>
						           <td class="text-center">${vo.mtngState}</td>
						           <td>
						           	<a href="/meeting/conferenceDetail?mtngId=${vo.mtngId}">${vo.mtngTitle}</a>
						           </td>
						           <td class="text-center"><fmt:formatDate value="${vo.mtngStrtDt}" pattern="yyyy-mm-dd"/> ${vo.mtngStrtTime}:00~${vo.mtngEndTime}:00</td>
						           <td class="text-center">${vo.mtngTypeName} </td>
						           <td class="text-center">${vo.roomName}</td>
						           <td class="text-center">${vo.empName}</td>
						           <td class="text-center">${vo.mtngAttendCnt}</td>
						       </tr>
						       </c:if>
					       	   </c:forEach>	
					        </tbody>
					    </table>
		    		</div>
		    	</div>
		    </div>
		</div>
	</div>
</div>
