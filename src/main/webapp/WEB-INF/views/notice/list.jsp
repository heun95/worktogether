<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
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
</style>

<script>
	function fn_submit() {
		// 		alert('df');
		var frm = document.searchForm;
		frm.submit();
		// sarchform 안에 action 을 작동
	}
</script>

<div class="container-fluid">

	<!-- start page title -->
	<div class="col-12">
		<div
			class="page-title-box d-flex align-items-center justify-content-between">
			<a href="/notice/list"><h2>공지사항</h2></a>
		</div>
	</div>

	<div class="card">
		<div class="card-body">
			<div>
				<form name="searchForm" id="searchForm"
					class="app-search d-none d-lg-block"
					action="/notice/list?keyWord=${param.keyWord}" method="get">
					<div class="col-sm-3" style="float: right;">
						<div class="position-relative">
							<input type="text" name="keyWord" id="search"
								class="form-control" style="color: #445990" /> <a href="#"><span
								class="ri-search-line" onclick="fn_submit()"
								style="color: #445990"></span></a>
						</div>
					</div>
				</form>
				<div>
					<br> <br>
				</div>
				<table class="table table-striped mb-0">
					<thead>
						<tr role="row">
							<th style="width: 80px; text-align:center;">#</th>
							<th style="width: 200px;">제목</th>
							<th style="width: 90px; text-align:center;">작성자</th>
							<th style="width: 100px; text-align:center;">작성일</th>
							<th style="width: 100px; text-align:center;">수정일</th>
							<th style="width: 70px; text-align:center;">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="vo" items="${list}">
							<tr>
								<td style="text-align:center;">${vo.rnum }</td>
								<td><a
									href="/notice/detail?brdId=${vo.brdId }&currentPage=${page.currentPage}">${vo.brdTitle }</a></td>
								<td style="text-align:center;">${vo.brdWrtr }</td>
								<td style="text-align:center;"><fmt:formatDate value="${vo.brdWrtDt }"
										pattern="yyyy/MM/dd" /></td>
								<td style="text-align:center;"><fmt:formatDate value="${vo.brdMdfyDt }"
										pattern="yyyy/MM/dd" /></td>
								<td style="text-align:center;">${vo.brdHit }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<br> <br>

				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<a href="/notice/insert" class="mb-2 btn btn-md btn-success mr-3"
						style="float: right;">등록</a>
				</sec:authorize>
				<br>

				<!-- 페이징 처리 시작 -->
				<div class="col-lg-12 offset-lg-4 py-5 ">
					<ul class="pagination" style="width: 320px;">
						<!-- Previous 시작 -->
						<li
							class="paginate_button page-item previous <c:if test='${page.startPage<page.pagingCount+1}'>disabled</c:if>"
							id="dataTable_previous"><a
							href="/notice/list?currentPage=${page.startPage-page.pagingCount}&keyWord=${param.keyWord}"
							aria-controls="dataTable" data-dt-idx="0" tabindex="0"
							class="page-link">Previous</a></li>
						<!-- Previous 끝 -->
						<!-- Page번호 시작 -->
						<c:forEach var="pNo" begin="${page.startPage}"
							end="${page.endPage}" step="1">
							<li
								class="paginate_button page-item <c:if test='${page.currentPage eq pNo}'>active</c:if>"><a
								href="/notice/list?currentPage=${pNo}&keyWord=${param.keyWord}"
								aria-controls="dataTable" data-dt-idx="1" tabindex="0"
								class="page-link">${pNo}</a></li>
						</c:forEach>
						<!-- Page번호 끝 -->
						<!-- Next 시작 -->
						<li
							class="paginate_button page-item next <c:if test='${page.endPage>=page.totalPages}'>disabled</c:if>"
							id="dataTable_next"><a
							href="/notice/list?currentPage=${page.startPage+page.pagingCount}&keyWord=${param.keyWord}"
							aria-controls="dataTable" data-dt-idx="7" tabindex="0"
							class="page-link">Next</a></li>
						<!-- Next 끝 -->
					</ul>
				</div>
				<!-- 페이징 처리 끝 -->
			</div>

		</div>
	</div>
</div>
