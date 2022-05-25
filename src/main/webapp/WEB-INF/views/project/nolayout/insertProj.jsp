<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<!--insert Modal -->

<form:form modelAttribute="projectVO" method="post"
	action="/project/projInsert">
	<div class="modal-header">
		<h5 class="modal-title">새프로젝트</h5>
	</div>
	<div class="modal-body">
		<div class="row mb-3">
			<label for="example-text-input" class="col-sm-4 col-form-label">프로젝트명</label>
			<div class="col-sm-8">
				<form:input class="form-control" path="projName" />
			</div>
		</div>
		<div class="row mb-3">
			<label for="example-text-input" class="col-sm-4 col-form-label">프로젝트설명</label>
			<div class="col-sm-8">
				<form:textarea class="form-control" path="projCntnt" />
			</div>
		</div>
		<div class="row mb-3">
			<label for="example-date-input" class="col-sm-4 col-form-label">시작일자</label>
			<div class="col-sm-8">
				<form:input class="form-control" type="date" path="projStrtDt" />
			</div>
		</div>
		<div class="row mb-3">
			<label for="example-date-input" class="col-sm-4 col-form-label">만료일자</label>
			<div class="col-sm-8">
				<form:input class="form-control" type="date" path="projEndDt" />

			</div>
		</div>
		<div class="row mb-3">
			<label for="example-date-input" class="col-sm-4 col-form-label">팀원</label>
			<div class="col-sm-8">
				<div id="memDiv"></div>
				<p class="addMem">추가하기</p>
				<div id="tree" class="bstreeview"></div>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary"
			data-bs-dismiss="modal">취소</button>
		<button type="submit" id="okBtn" class="btn btn-primary">확인</button>
	</div>
	<sec:csrfInput />
</form:form>
	