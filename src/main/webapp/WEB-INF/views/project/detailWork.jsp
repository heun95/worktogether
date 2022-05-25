<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<sec:authentication property="principal.user" var="user"/>
<!-- detail offcanvas -->
<div class="offcanvas offcanvas-end" tabindex="-2" id="wokrDetail"
	aria-labelledby="wokrDetailLabel" data-bs-backdrop="true">
	<div class="offcanvas-header">
		<div class="col-1 thumb size40" id="thumb" style="background-image: url('');  background-size: cover;"></div>
       	<div class="col-9">
       		<div style="margin-left:5px;">
	   			<span class="rqstrNm" ></span>&ensp;
	   			<span class="wrtDt"></span><br>
	   			<span class="workTitleSpan"></span>
       		</div>
   		</div>
		<div class="col-2">
			<a href="#" id="editBtn" class="text-primary" data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Edit" aria-label="Edit"><i id="wkUpdate" class="mdi mdi-pencil font-size-18"></i></a>
			<a href="#" id="delBtn" class="text-danger" data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Delete" aria-label="Delete"><i id="wkdelete" class="mdi mdi-trash-can font-size-18"></i></a>
			<button type="button"  id="offClose" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
	</div>
	<div class="offcanvas-body">
		<form:form id="wokrDetailForm" modelAttribute="projWorkVO"
			method="POST" action="/project/updateWork">
			<form:hidden path="projId" value="${projId }" />
			<form:hidden path="workRqstr" value="" />
			<form:hidden path="workId" value="" />
			<div class="p-3 py-0">
				<form:hidden path="workTitle" />
			</div>
			<div class="p-3">
				<form:hidden path="workCntnt" />
				<div id="workCntntDiv"></div>
			</div>

			<div class="row p-3">
				<div class="col-2">
					<i class="fas fa-clock fa-2x "></i>
				</div>
				<div class="col-10">
					<form:hidden path="workState" />
					<button type="button"
						class="btn btn-secondary btn-rounded waves-effect wkStateBtn"
						id="request">요청</button>
					<button type="button"
						class="btn btn-secondary btn-rounded waves-effect wkStateBtn"
						id="ing">진행</button>
					<button type="button"
						class="btn btn-secondary btn-rounded waves-effect wkStateBtn"
						id="complete">완료</button>
					<button type="button"
						class="btn btn-secondary btn-rounded waves-effect wkStateBtn"
						id="issue">이슈</button>
				</div>
			</div>

			<div class="p-3">
				<div class="row">
					<div class="col-2">
						<i class="fas fa-user-alt fa-2x "></i>
					</div>
					<div class="col-9 dropdown">
						<div class="col-auto">
							<button
								class="btn btn-outline-secondary waves-effect dropdown-toggle"
								type="button" id="dropMember" data-bs-toggle="dropdown"
								aria-expanded="false">담당자</button>
							<ul id="memUl" class="dropdown-menu" aria-labelledby="dropMember">
								<c:forEach var="empVO" items="${memberList }">
									<li><a class="dropdown-item projmem" href="#"
										data-empid="${empVO.empId }">${empVO.empName }</a></li>
								</c:forEach>
							</ul>
						</div>
						<div id="mngrDiv" class="col-auto"></div>
					</div>
				</div>
			</div>

			<div class="p-3">
				<div class="row">
					<div class="col-2">
						<i class="fas fa-calendar fa-2x "></i>
					</div>
					<div class="col-10">
						<label for="workStrtDt" class="dateLabel">시작일자</label> <input
							type="hidden" class="form-control" name="oldWorkStrtDt"
							type="date" />
						<form:input class="form-control" path="workStrtDt" type="date" />
					</div>
				</div>
			</div>

			<div class="p-3">
				<div class="row">
					<div class="col-2">
						<i class="fas fa-calendar fa-2x "></i>
					</div>
					<div class="col-10">
						<label for="workEndDt" class="dateLabel">마감일자</label> <input
							type="hidden" class="form-control" name="oldWorkEndDt"
							type="date" />
						<form:input class="form-control" path="workEndDt" type="date" />
					</div>
				</div>
			</div>

			<div class="p-3">
				<div class="row">
					<div class="col-2">
						<i class="fas fa-flag fa-2x "></i>
					</div>
					<div class="col-10 dropdown">
						<form:hidden path="workPriority" />
						<button
							class="btn btn-outline-secondary waves-effect dropdown-toggle"
							type="button" id="dropPriority" data-bs-toggle="dropdown"
							aria-expanded="false">업무순위</button>
						<ul class="dropdown-menu" aria-labelledby="dropPriority">
							<li><a class="dropdown-item priorityBtn" href="#"
								data-priority="낮음"><i class="fa fa-arrow-down icon"
									style="color: orange"></i>낮음</a></li>
							<li><a class="dropdown-item priorityBtn" href="#"
								data-priority="보통"><span class="icon">➖</span>보통</a></li>
							<li><a class="dropdown-item priorityBtn" href="#"
								data-priority="높음"><i class="fa fa-arrow-up icon"
									style="color: green"></i>높음</a></li>
							<li><a class="dropdown-item priorityBtn" href="#"
								data-priority="긴급"><span class="icon">🚨</span>긴급</a></li>
						</ul>
					</div>
				</div>
			</div>
			
			<div class="p-3">
				<div class="row">
					<div class="col-2">
						<i class="fas fa-chart-bar fa-2x "></i>
					</div>
					<div class="col-6">
						<div class="progress">
							<form:hidden path="workProgress" value=""/>						
	                    	<div class="progress-bar" role="progressbar" style="width: ;" aria-valuenow="" aria-valuemin="0" aria-valuemax="100"></div>
	                  	</div>
					</div>
				</div>
			</div>
			
			<div class="p-3">
				<div class="row">
					<div class="col-2">
						<i class="fas fa-file-alt fa-2x "></i>
					</div>
					<div class="col-6">
						<div class="file">
	                    	<p><a href="\resources\upload\empl\EMPL00004\손영흔.jpg" download>다운로드</a></p>
	                  	</div>
					</div>
				</div>
			</div>
			
			<sec:csrfInput />
		</form:form>
		<hr>
		<div id="rplListDiv"></div>
	</div>
	<div class="offcanvas-footer">
		<div id="rpl" class="shadow">
			<form:form modelAttribute="projWorkReplyVO" id="rplInsertForm"
				method="POST" action="/project/insertRpl">
				<div class="thumb size40"
					style="background-image: url('${user.atchPath }');  background-size: cover;"></div>

				<div class="rplContent">
					<form:hidden path="projId" value="" />
					<form:hidden path="workRplyWrtr" value="${user.username }" />
					<form:hidden path="workId" value="" />
					<form:textarea row="1" class="form-control" path="workRplyCntnt"
						placeholder="댓글을 입력하세요." aria-label=".form-control-lg example" />
				</div>

				<div class="rplContent">
					<button type="button" id="rplInsertBtn"
						class="btn btn-info waves-effect waves-light"
						style="margin-bottom: 30px;">등록</button>
				</div>
			</form:form>
		</div>
	</div>
</div>
<!-- end detail offcanvas -->