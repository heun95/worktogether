<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="page-content">
	<div class="container-fluid">

		<!-- start page title -->
		<div class="row">
			<div class="col-12">
				<div
					class="page-title-box d-flex align-items-center justify-content-between">
					<h4 class="mb-0">증명서신청내역</h4>

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
												<tr role="row">
													<th style="width: 30px;" class="sorting_disabled"
														rowspan="1" colspan="1" aria-label="&amp;nbsp;">
														<div class="form-check">

															<label class="form-check-label mb-0" for="customercheck">&nbsp;</label>
														</div>
													</th>
													<th class="sorting_asc" tabindex="0"
														aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
														style="width: 120px;" aria-sort="ascending"
														aria-label="Customer: activate to sort column descending">신청번호</th>
													<th class="sorting" tabindex="0"
														aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
														style="width: 120px;"
														aria-label="Email: activate to sort column ascending">증명서구분</th>
													<th class="sorting" tabindex="0"
														aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
														style="width: 120px;"
														aria-label="Phone: activate to sort column ascending">신청일자</th>
													<th class="sorting" tabindex="0"
														aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
														style="width: 120px;"
														aria-label="Wallet Balance: activate to sort column ascending">사원번호</th>
													<th class="sorting" tabindex="0"
														aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
														style="width: 120px;"
														aria-label="Joining Date: activate to sort column ascending">성명</th>
													<th class="sorting" tabindex="0"
														aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
														style="width: 120px;"
														aria-label="Joining Date: activate to sort column ascending">발급상태</th>
													<th class="sorting" tabindex="0"
														aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
														style="width: 120px;"
														aria-label="Joining Date: activate to sort column ascending">발행일자</th>
													<th class="sorting" tabindex="0"
														aria-controls="DataTables_Table_0" rowspan="1" colspan="1"
														style="width: 120px;"
														aria-label="Joining Date: activate to sort column ascending">용도</th>

												</tr>
											</thead>
											<tbody>
												<c:forEach var="row" items="${list2}">
													<tr>
														<td></td>
														<td>${row.crtfcAplctId}</td>
														<td>${row.crtfcTypeId}</td>
														<td><fmt:formatDate value="${row.crtfcAplctDt}"
																type="date" /></td>	
														<td>${row.crtfcAplctDt}</td>
														<td>${row.crtfcAplctEmpId}</td>
														<td>${row.crtfcAplctEmpId}</td>
														<td>${row.crtfcAplctState}</td>
														<td><fmt:formatDate value="${row.crtfcIssueDt}"
																type="date" /></td>
														<td>${row.crtfcUse}</td>
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
												href="/human/certilist?currentPage=${page.startPage-page.pagingCount}&keyWord=${param.keyWord}"
												aria-controls="dataTable" data-dt-idx="0" tabindex="0"
												class="page-link">Previous</a></li>
											<!-- Previous 끝 -->
											<!-- Page번호 시작 -->
											<c:forEach var="pNo" begin="${page.startPage}"
												end="${page.endPage}" step="1">
												<li
													class="paginate_button page-item <c:if test='${page.currentPage eq pNo}'>active</c:if>"><a
													href="/human/certilist?currentPage=${pNo}&keyWord=${param.keyWord}"
													aria-controls="dataTable" data-dt-idx="1" tabindex="0"
													class="page-link">${pNo}</a></li>
											</c:forEach>
											<!-- Page번호 끝 -->
											<!-- Next 시작 -->
											<li
												class="paginate_button page-item next <c:if test='${page.endPage>=page.totalPages}'>disabled</c:if>"
												id="dataTable_next"><a
												href="/human/certilist?currentPage=${page.startPage+page.pagingCount}&keyWord=${param.keyWord}"
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

	</div>
	<!-- container-fluid -->
</div>