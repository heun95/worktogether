<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- <script type="text/javascript" src="/resources/js/jquery-latest.min.js"></script> -->
<script type="text/javascript" src="/resources/js/jspdf.min.js"></script>
<script type="text/javascript" src="/resources/js/html2canvas.min.js"></script>
<script type="text/javascript"
	src="/resources/js/html2pdf.bundle.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("#detailForm");

		//수정
		$("#su").on("click", function() {
			//alert("test");
			$(".form-control").attr("readonly", false);
			$("#su").hide();
			$("#sa").hide();
			$("#okno1").show();
			$("#okno2").show();

		})

		//삭제
		$("#sa").on("click", function() {
			formObj.attr("action", "/human/delete");
			formObj.attr("method", "post");
			formObj.submit();
		})

		//확인1
		$("#but1").on("click", function() {
			formObj.attr("action", "/human/update");
			formObj.attr("method", "post");
			formObj.submit();
		})

		//취소1
		$("#but2").on("click", function() {
			location.href = "/human/detail?empId=${employeeVO.empId}"
		})

		//확인2
		$("#but3").on("click", function() {
			formObj.attr("action", "/human/update");
			formObj.attr("method", "post");
			formObj.submit();
		})

		//취소2
		$("#but4").on("click", function() {
			location.href = "/human/detail?empId=${employeeVO.empId}"
		})

		// 			//회사정보 누를때 
		// 			$("#tab1").on("click",function(){
		// 				$("#sin").hide();
		// 			})

	})
</script>


<form:form modelAttribute="employeeVO" id='detailForm'
	enctype="multipart/form-data">
	<div class="row">

		<div class="col-xl-4">
			<div class="card">
				<div class="card-body">
					<thead>
						<tr>
							<h5 class="border-top-0" style="width: 110px;" scope="col">${employeeVO.empName}</h5>
						</tr>
					</thead>
					<br> <br>
					<table class="table table-centered mb-0 table-nowrap">
						<tbody>
							<input type="file" id="Photo" accept="image/*"
								onchange="setThumbnail(event);" />
							<div id="Photo">
								<img src="${employeeVO.empPhoto}" width="295px" height="354px"
									text-align="center">
							</div>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="col-xl-8">
			<div class="card">
				<div class="card-body">

					<h4 class="card-title">직원 상세</h4>
					<a href="javascript:void(0);" id="su" class="me-3 text-primary"
						data-bs-toggle="tooltip" data-placement="top" title=""
						data-bs-original-title="Edit" aria-label="Edit"><i
						class="mdi mdi-pencil font-size-18"></i></a> <a
						href="javascript:void(0);" id="sa" class="text-danger"
						data-bs-toggle="tooltip" data-placement="top" title=""
						data-bs-original-title="Delete" aria-label="Delete"><i
						class="mdi mdi-trash-can font-size-18"></i></a>

					<!-- Nav tabs -->
					<ul class="nav nav-tabs nav-tabs-custom nav-justified"
						role="tablist">
						<li class="nav-item"><a class="nav-link active"
							data-bs-toggle="tab" href="#home1" role="tab"> <span
								class="d-block d-sm-none"><i class="fas fa-home"></i></span> <span
								class="d-none d-sm-block">회사 정보</span>
						</a></li>
						<li class="nav-item"><a class="nav-link" data-bs-toggle="tab"
							href="#profile1" role="tab"> <span class="d-block d-sm-none"><i
									class="far fa-user"></i></span> <span class="d-none d-sm-block">신상
									정보</span>
						</a></li>

					</ul>

					<!-- Tab panes -->
					<div class="tab-content p-3 text-muted">
						<div class="tab-pane active" id="home1" role="tabpanel">

							<div class="row mb-3">
								<label for="example-text-input" class="col-sm-2 col-form-label">직원번호</label>
								<div class="col-sm-10">
									<form:input class="form-control" readonly="true" path="empId"
										placeholder="EMPL00001" value="${employeeVO.empId}" />
								</div>
							</div>

							<div class="row mb-3">
								<label for="example-password-input"
									class="col-sm-2 col-form-label">비밀번호</label>
								<div class="col-sm-10">
									<form:input class="form-control" readonly="true"
										path="empPassword" type="password" placeholder="******"
										value="${employeeVO.empPassword}" />
								</div>
							</div>

							<div class="row mb-3" style="display: none;" id="state">
								<label for="empState" class="col-sm-2 col-form-label">재직
									상태</label>
								<div class="col-sm-10">
									<form:select path="empState" readonly="true"
										class="form-control select2-search-disable select2-hidden-accessible"
										data-select2-id="6" tabindex="-1" aria-hidden="true"
										value="${employeeVO.empState}">
										<option value="H101" data-select2-id="83">재직</option>
										<option value="H102" data-select2-id="84">퇴사</option>
										<option value="H103" data-select2-id="85">휴직</option>
									</form:select>
								</div>
							</div>

							<div class="row mb-3">
								<label for="empPosition" readonly="true" id="state"
									class="col-sm-2 col-form-label">직원 직급</label>
								<div class="col-sm-10">
									<form:select path="empPosition" readonly="true"
										class="form-control select2-search-disable select2-hidden-accessible"
										data-select2-id="6" tabindex="-1" aria-hidden="true"
										value="${employeeVO.empPosition}">
										<option value="H201" data-select2-id="83">부장</option>
										<option value="H202" data-select2-id="84">과장</option>
										<option value="H203" data-select2-id="85">대리</option>
										<option value="H204" data-select2-id="86">주임</option>
										<option value="H205" data-select2-id="86">사원</option>
									</form:select>
								</div>
							</div>

							<div class="row mb-3">
								<label for="deptId" readonly="true"
									class="col-sm-2 col-form-label">부서</label>
								<div class="col-sm-10">
									<form:select path="deptId" readonly="true"
										class="form-control select2-search-disable select2-hidden-accessible"
										data-select2-id="6" tabindex="-1" aria-hidden="true"
										value="${employeeVO.deptId}">
										<option value="DEP01" data-select2-id="83">관리부</option>
										<option value="DEP02" data-select2-id="84">마케팅부</option>
										<option value="DEP03" data-select2-id="85">개발부</option>
										<option value="DEP04" data-select2-id="86">영업부</option>
									</form:select>
								</div>
							</div>

							<div class="row mb-3">
								<label for="example-url-input" class="col-sm-2 col-form-label">입사
									일자</label>
								<div class="col-sm-10">
									<p id="ip" style="display: none">
										<fmt:formatDate value='${employeeVO.empEcnyYmd}'
											pattern="yyyy-MM-dd" />
									</p>
									<form:input class="form-control" readonly="true"
										path="empEcnyYmd" type="date" value="" />

									<font color="red" style="font-size: 8pt;"> <form:errors
											path="empEcnyYmd" />
									</font>
								</div>
								<script>
									document.getElementById("empEcnyYmd").value = document
											.getElementById("ip").innerHTML;
								</script>
							</div>

							<div class="form-group" id="okno1"
								style="float: right; display: none;">
								<button id="but1" type="button"
									class="mb-2 btn btn-sm btn-success mr-1">확인</button>
								<button id="but2" type="button"
									class="mb-2 btn btn-sm btn-danger mr-1">취소</button>
							</div>

						</div>
						<!-- Tab panes -->
						<div class="tab-pane" id="profile1" role="tabpanel">
							<div class="row mb-3">
								<label for="example-password-input" id="sin"
									class="col-sm-2 col-form-label">직원 주소</label>
								<div class="col-sm-7">
									<form:input path="empPostno" readonly="true"
										class="form-control" value="${employeeVO.empPostno}" />
								</div>
								<button type="button" onclick="openHomeSearch()"
									class="btn btn-primary btn-icon-split btn-sm col-sm-2">
									<span class="text">우편번호 검색</span>
								</button>
							</div>

							<div class="row mb-3">
								<label for="example-number-input" id="sin"
									class="col-sm-2 col-form-label">주소</label>
								<div class="col-sm-10">
									<form:input path="empAddr1" readonly="true"
										class="form-control" type="text"
										value="${employeeVO.empAddr1}" />
								</div>
							</div>

							<div class="row mb-3">
								<label for="example-number-input" id="sin"
									class="col-sm-2 col-form-label">상세주소</label>
								<div class="col-sm-10">
									<form:input path="empAddr2" readonly="true"
										class="form-control" type="text"
										value="${employeeVO.empAddr2}" />
								</div>
							</div>

							<div class="row mb-3">
								<label for="example-url-input" id="sin"
									class="col-sm-2 col-form-label">이력서</label>
								<div class="col-sm-10">
									<form:input class="form-control" readonly="true"
										path="empResume" value="${employeeVO.empResume}" />
								</div>
							</div>

							<div class="form-group" id="okno2"
								style="float: right; display: none;">
								<button id="but3" type="button"
									class="mb-2 btn btn-sm btn-success mr-1">확인</button>
								<button id="but4" type="button"
									class="mb-2 btn btn-sm btn-danger mr-1">취소</button>
							</div>

						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</form:form>