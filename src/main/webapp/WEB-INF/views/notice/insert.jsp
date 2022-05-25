<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!--
    ${list} => 		model.getAttribute("list");
 -->

<form:form modelAttribute="boardVO" method="post"
	action="/notice/insert" enctype="multipart/form-data">
	<!-- action 에는 url 주소 -->
	<div class="container-fluid">

		<!-- start page title -->
		<div class="col-12">
			<div
				class="page-title-box d-flex align-items-center justify-content-between">
				<h2 id="autowrite" onclick="autowrite()">공지사항 등록</h2>
			</div>
		</div>
		<!-- end page title -->
		<div class="col-12">
			<div class="card">
				<div class="card-body">
					<div class="row mb-3">
						<label for="example-text-input" class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
							<form:input class="form-control" placeholder="제목을 입력하세요"
								path="brdTitle" />
							<%-- 								<form:input style="hidden" value="<sec:authentication property="principal.user"/>" path="brdWrtr"/> --%>
							<form:input type="hidden" value="${boardVO.brdWrtr}"
								path="brdWrtr" />
						</div>
					</div>
					<div class="row mb-3">
						<label for="example-search-input" class="col-sm-2 col-form-label">내용</label>
						<div class="col-sm-10">
							<form:textarea class="form-control" placeholder="내용을 입력하세요"
								rows="10" path="brdCntnt" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- end col -->

		<div class="col-lg-12">
			<div class="card">
				<div class="card-body">
					<h6>파일 등록</h6>
					<br>
					<div class="input-group">
						<input type="file" class="form-control" id="uploadFile"
							name="uploadFile" multiple="multiple">
					</div>
				</div>
			</div>

		</div>
		<!-- end row -->

		<div class="col-lg-12 py-5" align="right">
			<a href="/notice/list" id="btnCancel"
				class="btn btn-danger btn-icon-split">취소</a>
			<form:button type="submit" path="btnConfirm"
				class="btn btn-success btn-icon-split">등록</form:button>
		</div>

	</div>
	<!-- container-fluid -->
	<sec:csrfInput />
</form:form>

<script>
	function autowrite() {
		$("#brdTitle").val("실적에 따른 포상 안내 ");
		$("#brdCntnt").val("곧 실적에 따른 포상이 있습니다.\n\n실적기간 : 2022.03.01. ~ 2022.04.01.");
	}
</script>
