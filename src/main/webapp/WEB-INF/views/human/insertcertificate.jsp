<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<form:form modelAttribute="crtfcAplictVO" method="post"
	action="/human/insertcertificate" enctype="multipart/form-data">
	<div class="page-content">
		<div class="container-fluid">
			<!-- start page title -->
			<div class="row">
				<div class="col-12">
					<div
						class="page-title-box d-flex align-items-center justify-content-between">
						<h4 class="mb-0">증명서 신청</h4>
					</div>
				</div>
			</div>
			<!-- end page title -->

			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">

							<div class="row mb-3">
								<label for="crtfcTypeId" class="col-sm-2 col-form-label">증명서 구분</label>
								<div class="col-sm-10">
									<form:select path="crtfcTypeId"
										class="form-control select2-search-disable select2-hidden-accessible"
										data-select2-id="6" tabindex="-1" aria-hidden="true">
										<option value="D101" data-select2-id="83">재직증명서</option>
										<option value="D102" data-select2-id="84">경력증명서</option>
									</form:select>
								</div>
							</div>

							<div class="mb-4">
                                <label class="form-label" for="billing-address">발급 용도</label>
                                <textarea name="crtfcUse" class="form-control" id="billing-address" rows="3" placeholder="Enter full address"></textarea>
                            </div>

							<div class="form-group" style="float: right;">
								<button type="submit" class="mb-2 btn btn-sm btn-success mr-1">등록</button>
								<button type="reset" class="mb-2 btn btn-sm btn-danger mr-1">취소</button>
							</div>

						</div>
					</div>
				</div>
				<!-- end col -->
			</div>
			<!-- end row -->

		</div>
		<!-- container-fluid -->
	</div>
</form:form>