<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<form:form modelAttribute="boardVO" method="post"
	action="/community/update2" enctype="multipart/form-data">
	<!-- action 에는 url 주소 -->
	<div class="container-fluid">

		<!-- start page title -->
		<div class="col-12">
			<div
				class="page-title-box d-flex align-items-center justify-content-between">
				<h2>커뮤니티 수정</h2>
			</div>
		</div>
		<!-- end page title -->
		<div class="col-12">
			<div class="card">
				<div class="card-body">
					<div class="row mb-3">
						<label for="example-text-input" class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
							<form:input class="form-control" value="${boardVO.brdTitle}"
								path="brdTitle" />
							<%-- 								<form:input style="hidden" value="<sec:authentication property="principal.user"/>" path="brdWrtr"/> --%>
							<form:input type="hidden" value="${boardVO.brdId}" path="brdId" />
						</div>
					</div>
					<div class="row mb-3">
						<label for="example-search-input" class="col-sm-2 col-form-label">내용</label>
						<div class="col-sm-10">
							<form:textarea class="form-control" value="${boardVO.brdCntnt}"
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
					<h6>첨부파일</h6>
					<br>
					<div class="input-group">
						<table class="table">
							<thead class="thead-light">

								<c:forEach items="${files}" var="file" varStatus="idx" step="1">
									<tr>
										<form:input type="hidden" value="${file.atchId}"
											path="atchId" />
										<td class="table-font-center">${file.atchName}</td>
										<td><form:button type="submit"
												class="btn btn-light btn-sm waves-effect waves-light">삭제</form:button></td>
									</tr>
								</c:forEach>


							</thead>
						</table>
					</div>
					<div class="input-group">
						<input type="file" class="form-control" id="customFile"
							name="uploadFile" multiple="multiple">
					</div>
				</div>
			</div>
		</div>
		<!-- end row -->

		<div class="col-lg-12 py-5" align="right">
			<a href="/community/list" id="btnCancel"
				class="btn btn-danger btn-icon-split">취소</a>
			<form:button type="submit" path="btnConfirm"
				class="btn btn-success btn-icon-split">등록</form:button>
		</div>
	</div>
	<!-- container-fluid -->

</form:form>