<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
/* selectbox 스타일 */

.where {
	display: block;
	margin: 25px 15px;
	font-size: 11px;
	color: #000;
	text-decoration: none;
	font-family: verdana;
	font-style: italic;
}

.selectbox {
	position: relative;
	width: 200px;
	border: 1px solid #999;
	z-index: 1;
	height: 43px;
	margin: 20px;
}

.selectbox:before {
	content: "";
	position: absolute;
	top: 50%;
	right: 15px;
	width: 0;
	height: 0;
	margin-top: -1px;
	border-left: 5px solid transparent;
	border-right: 5px solid transparent;
	border-top: 5px solid #333;
}

.selectbox label {
	position: absolute;
	top: 1px;
	left: 5px;
	padding: .8em .5em;
	color: #999;
	z-index: -1;
}

.selectbox select {
	width: 100%;
	height: auto;
	line-height: normal;
	font-family: inherit;
	padding: .8em .5em;
	border: 0;
	opacity: 0;
	filter: alpha(opacity = 0);
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}
/* 검색 스타일주기  */
#dataTable_length {
	display: none;
}

element.style {
	
}

body[data-sidebar=colored] .app-search .form-control {
	background-color: #f6f6fa;
}

.app-search .form-control {
	border: none;
	height: 38px;
	padding-right: 40px;
	padding-left: 20px;
	background-color: #22294a;
	-webkit-box-shadow: none;
	box-shadow: none;
	border-radius: 30px;
}

textarea::placeholder {
	color: #445990;
}

#search {
	background-color: #f6f6fa;
}

#add {
	padding-top: 20px;
}

#title {
	background-color: #f6f6fa;
}
/* 하단바 없애기 */
::-webkit-scrollbar {
	display: none;
}
</style>

<!-- 박스 검색 선택 -->
<script>
	$(document).ready(
			function() {

				var pos_pos = '${pos}';
				var dep_dep = '${dep}';
				console.log(pos_pos);
				console.log(dep_dep);

				
				if (pos_pos != '') {
					//console.log($('option[id=' + pos_pos + ']').text())
					$("#posLabel").text($('option[id=' + pos_pos + ']').text());;
				}

				if (dep_dep != '') {
					//console.log($('option[id=' + dep_dep + ']').text())
					$("#depLabel").text($('option[id=' + dep_dep + ']').text());;
				}
				
			});

	//검색바
	function fn_submit() {
		//		alert('df');
		var frm = document.searchForm;
		frm.submit();
		// sarchform 안에 action 을 작동
	}

	//선택바1
	function se1_submit(sel) {
		console.log(sel);
		document.selectForm1.submit();
	}
	
	//선택바2
	function se2_submit(sel) {
		console.log(sel);
		document.selectForm2.submit();
	}
	
	
	
</script>
<div class="container-fluid -ms-overflow-style: none; ">

	<!-- start page title -->
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-flex align-items-center justify-content-between">
				<h4 class="mb-0 ri-file-list-3-fill">직원 조회</h4>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"></li>
					</ol>
				</div>
			</div>
		</div>
	</div>
	<!-- end page title -->

	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<div class="col-sm-3">
							<form name="searchForm" id="searchForm"
								class="app-search d-none d-lg-block"
								action="/human/list?keyWord=${param.keyWord}" method="get">
								<div class="position-relative">
									<%-- <input type="hidden" name="currentPage" id="currentPage" value="${param.currentPage}"> --%>
									<input type="text" name="keyWord" id="search"
										class="form-control" style="color: #445990"> <a
										href="#"> <span class="ri-search-line" onclick="fn_submit"
										style="color: #445990"> </span></a>
								</div>
							</form>
						</div>
						
					<div class="selectbox col-sm-3">
						<form name="selectForm1" id="selectForm1" action="/human/list"
							method="get">
								<label for="ex_select" id="posLabel">직책선택</label> 
								<select id="ex_select" name="pos" onchange="se1_submit(this)">
									<option id="pos" value="" selected disabled>직급</option>
									<option id="H205" value="H205">부장</option>
									<option id="H204" value="H204">과장</option>
									<option id="H203" value="H203">대리</option>
									<option id="H202" value="H202">주임</option>
									<option id="H201" value="H201">사원</option>
								</select>
						</form>
					</div>	
						
					<div class="selectbox col-sm-3">
					<form name="selectForm2" id="selectForm2" action="/human/list"
							method="get">
								<label for="ex_select" id="depLabel">부서선택</label> 								
								<select id="ex_select"
									name="dep" onchange="se2_submit(this)">
									<option id="dep" value="" selected disabled>부서</option>
									<option id="DEP0101" value="DEP0101">인사팀</option>
									<option id="DEP0102" value="DEP0102">재무팀</option>
									<option id="DEP0201" value="DEP0201">영업팀</option>
									<option id="DEP0202" value="DEP0202">웹기획팀</option>
									<option id="DEP0301" value="DEP0301">개발 1팀</option>
									<option id="DEP0302" value="DEP0302">개발 2팀</option>
									<option id="DEP0401" value="DEP0401">해외 영업부</option>
									<option id="DEP0402" value="DEP0402">국내 영업부</option>
									<option id="DEP0403" value="DEP0403">고객 관리부</option>
								</select>
					</form>
					</div>
						<div class="col-sm-3" style="text-align: right;">
							<div id="add">
								<a href="/human/insertemp" class="btn btn-success mb-2"><i
									class="mdi mdi-plus me-2"></i>직원 추가</a>
							</div>
						</div>
					</div>
				</div>
				<div class="table-responsive mt-3">
					<div id="DataTables_Table_0_wrapper"
						class="dataTables_wrapper dt-bootstrap4 no-footer">
						<div class="row">
							<div class="col-sm-12">
								<table
									class="table table-centered datatable dt-responsive nowrap dataTable no-footer dtr-inline collapsed"
									style="border-collapse: collapse; border-spacing: 0px; width: 100%;"
									id="DataTables_Table_0" role="grid"
									aria-describedby="DataTables_Table_0_info">
									<thead class="thead-light">
										<tr role="row" id="title">
											<th style="width: 30px;" class="sorting_disabled" rowspan="1"
												colspan="1" aria-label="&amp;nbsp;">
												<div class="form-check">

													<label class="form-check-label mb-0" for="customercheck">&nbsp;</label>
												</div>
											</th>
											<th class="sorting_asc" tabindex="0"
												aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
												style="width: 120px;" aria-sort="ascending"
												aria-label="Customer: activate to sort column descending">사원번호</th>
											<th class="sorting" tabindex="0"
												aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
												style="width: 120px;"
												aria-label="Email: activate to sort column ascending">성명</th>
											<th class="sorting" tabindex="0"
												aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
												style="width: 120px;"
												aria-label="Phone: activate to sort column ascending">직책</th>
											<th class="sorting" tabindex="0"
												aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
												style="width: 120px;"
												aria-label="Wallet Balance: activate to sort column ascending">부서</th>
											<th class="sorting" tabindex="0"
												aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
												style="width: 120px;"
												aria-label="Joining Date: activate to sort column ascending">입사일자</th>
											<th class="sorting" tabindex="0"
												aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
												style="width: 120px;"
												aria-label="Joining Date: activate to sort column ascending">회사이메일</th>

										</tr>
									</thead>
									<tbody>
										<c:forEach var="row" items="${list}">
											<tr>
												<td></td>
												<td>${row.empId}</td>
												<td><a href="/human/detail?empId=${row.empId}">${row.empName}</a></td>
												<td>${row.empPosition}</td>
												<td>${row.deptName}</td>
												<c:if test="${row.empRetireYmd eq null}">
													<fmt:formatDate value="${row.empEcnyYmd}" pattern="yyyy-MM-dd" var="empEcnyYmd" />
													<td>${empEcnyYmd }</td>
												</c:if>
												<c:if test="${row.empRetireYmd ne null}">
													<fmt:formatDate value="${row.empRetireYmd}" pattern="yyyy-MM-dd" var="empRetireYmd" />
													<td style="color: red;">퇴사 ${empRetireYmd }</td>
												</c:if>
												<td>${row.empEmail}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-5"></div>
							<div class="col-sm-12 col-md-7">
								<!-- 페이징 처리 시작 -->
								<ul class="pagination">
									<!-- Previous 시작 -->
									<li
										class="paginate_button page-item previous <c:if test='${page.startPage<page.pagingCount+1}'>disabled</c:if>"
										id="dataTable_previous"><a
										href="/human/list?currentPage=${page.startPage-page.pagingCount}&keyWord=${param.keyWord}"
										aria-controls="dataTable" data-dt-idx="0" tabindex="0"
										class="page-link">Previous</a></li>
									<!-- Previous 끝 -->
									<!-- Page번호 시작 -->
									<c:forEach var="pNo" begin="${page.startPage}"
										end="${page.endPage}" step="1">
										<li
											class="paginate_button page-item <c:if test='${page.currentPage eq pNo}'>active</c:if>"><a
											href="/human/list?currentPage=${pNo}&keyWord=${param.keyWord}"
											aria-controls="dataTable" data-dt-idx="1" tabindex="0"
											class="page-link">${pNo}</a></li>
									</c:forEach>
									<!-- Page번호 끝 -->
									<!-- Next 시작 -->
									<li
										class="paginate_button page-item next <c:if test='${page.endPage>=page.totalPages}'>disabled</c:if>"
										id="dataTable_next"><a
										href="/human/list?currentPage=${page.startPage+page.pagingCount}&keyWord=${param.keyWord}"
										aria-controls="dataTable" data-dt-idx="7" tabindex="0"
										class="page-link">Next</a></li>
									<!-- Next 끝 -->
								</ul>
								<!-- 페이징 처리 끝 -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- container-fluid -->
