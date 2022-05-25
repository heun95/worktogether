<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>

<!-- Bootstrap(CSS) -->
<link href="/resources/dist/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">
<link href="/resources/dist/assets/libs/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css">
<link href="/resources/dist/assets/libs/datatables.net-select-bs4/css/select.bootstrap4.min.css" rel="stylesheet" type="text/css">
<!-- <link href="/resources/dist/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css"> -->
<link rel="stylesheet" href="/resources/css/table.css" type="text/css"/>


<div class="row">
	<div class="col-12">
	    <div class="card">
	        <div class="card-body">
				<%@ include file="includeTab.jsp"%>
	
<!-- 	            <h4 class="card-title">Default Datatable</h4> -->
<!-- 	            <p class="card-title-desc">DataTables has most features enabled by -->
<!-- 	                default, so all you need to do to use it with your own tables is to call -->
<!-- 	                the construction function: <code>$().DataTable();</code>. -->
<!-- 	            </p> -->
	
	            <table id="datatable" class="table table-bordered dt-responsive nowrap custable" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
	                <thead>
		               <tr>
		                    <th >파일명</th>
		                    <th >용량</th>
		                    <th >등록자</th>
		                    <th >등록일</th>
		                    <th >다운로드</th>
		       
		                </tr>
		            </thead>
		
		
		            <tbody>
		                
		                <c:forEach var="fileVO" items="${fileList}">
		                <tr>
		                    <td>${fileVO.atchName }</td>
		                    <td>${fileVO.atchSize }kb</td>
		                    <td>${fileVO.atchWrtr }</td>
		                    <fmt:formatDate value="${fileVO.atchWrtDate }" pattern="yyyy-MM-dd" var="atchWrtDate"/>
		                    <td>${atchWrtDate } </td>
		                    <td><a href="${fileVO.atchPath} " download>다운로드</a></td>
		                </tr>
		                </c:forEach>
	             
	                </tbody>
	            </table>
	
	        </div>
	    </div>
	</div> <!-- end col -->
</div> <!-- end row -->	




<!-- DataTable -->
<script src="/resources/dist/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="/resources/dist/assets/js/pages/customdatatables.init.js"></script>

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

<script src="/resources/js/project.js"></script>
