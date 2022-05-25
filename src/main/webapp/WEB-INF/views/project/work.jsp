<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<link href="/resources/dist/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
<link href="/resources/dist/assets/libs/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
<link href="/resources/dist/assets/libs/datatables.net-select-bs4/css//select.bootstrap4.min.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/project.css" rel="stylesheet" type="text/css" />


<sec:authentication property="principal.user" var="user"/>

<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">

				<%@ include file="includeTab.jsp"%>

				<div class="row">

					<div class="col-lg-2 ">
						<%@ include file="includeSide.jsp"%>
					</div>
					<!-- col end -->

					<div class="col-lg-10 workListDiv">
					
						<div class="row">
							<div class="table-responsive workTb">
								<table id="selection-datatable"
									class="table dt-responsive nowrap w-100">
									<thead class="table-light">
										<tr class="text-center">
											<th style="width: 10%">번호</th>
											<th style="width: 8%">상태</th>
											<th style="width: 8%">우선순위</th>
											<th style="width: 40%">업무내용</th>

											<th>담당자</th>
											<th>수정일시</th>
										</tr>
									</thead>
									<tbody id="tbody">



									</tbody>
								</table>
								
							</div>
							<!-- end table-->
                            
						</div>
						<!-- row end -->
                        <div class="row">
                        	<div class="col-4">
                        
<!--                             <input type="text" id="" class="form-control"  placeholder="Search...">  -->
<!--                             <span class="ri-search-line"></span> -->
         
                        	</div>
                        	
                            <div id="page-container" class="col-4">
                            
                            </div>
                            
                            <div class="col-4">
                               

                            </div>
                        </div>

					</div>
					<!-- col end -->

				</div>
				<!-- end row-->
			</div>
			<!-- end card body-->
		</div>
		<!-- end card -->
	</div>
</div>

<!-- 	<div class="alert alert-primary alert-dismissible fade" role="alert"> -->
<!-- 		<font style="vertical-align: inherit;"> -->
<!-- 			<font style="vertical-align: inherit;"> -->
<!--         	최소 한 개 이상 체크하세요! -->
<!--         	</font> -->
<!--         </font> -->
<!--         <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="닫기"> -->
<!--         </button> -->
<!--     </div> -->


<!-- insert Modal -->
<div class="modal" id="insertWorkModal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<form:form modelAttribute="projWorkVO" method="POST"
				action="/project/insertWork" enctype="multipart/form-data">
				<div class="modal-header">
					<h5 class="modal-title">업무추가</h5>

					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form:hidden path="projId" value="${projWorkVO.projId }" />
					<form:hidden path="workRqstr" value="${user.username }" />
					<div class="row p-3">
						<form:input class="form-control form-control-lg" path="workTitle"
							placeholder="제목을 입력하세요" />
					</div>

					<div class="row p-3">
						<div class="col-2">
							<i class="fas fa-clock fa-2x "></i>
						</div>
						<div class="col-10">
							<form:hidden path="workState" />
							<button type="button"
								class="btn btn-secondary btn-rounded waves-effect wkStateBtn">요청</button>
							<button type="button"
								class="btn btn-secondary btn-rounded waves-effect wkStateBtn">진행</button>
							<button type="button"
								class="btn btn-secondary btn-rounded waves-effect wkStateBtn">완료</button>
							<button type="button"
								class="btn btn-secondary btn-rounded waves-effect wkStateBtn">이슈</button>
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
									<ul class="dropdown-menu" aria-labelledby="dropMember">
										<c:forEach var="empVO" items="${memList }">
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
								<label for="workStrtDt" class="dateLabel">시작일자</label>
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
								<label for="workEndDt" class="dateLabel">마감일자</label>
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
	                       			<div class="progress-bar" role="progressbar" style="width: %;" aria-valuenow="" aria-valuemin="0" aria-valuemax="100"></div>
	                    		</div>
							</div>
						</div>
					</div>
					
					<div class="p-3">
						<form:textarea path="workCntnt" class="form-control" rows="10"
							placeholder="내용을 입력하세요" />
					</div>

					<div class="p-3">
						<input type="file" class="form-control" name="uploadFile" multiple />
					</div>

				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" id="okBtn" class="btn btn-primary">확인</button>
				</div>
				<sec:csrfInput />
			</form:form>
		</div>
	</div>
</div>
<!-- end insert Modal  -->

<%@ include file="modal.jsp"%>

<script src="https://cdn.ckeditor.com/ckeditor5/33.0.0/decoupled-document/ckeditor.js"></script>
<script src="/resources/dist/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="/resources/js/project.js"></script>

<script type="text/javascript">



	
$(function () {
	// 시연용 데이터
	$(".modal-title").on("click",function(){
		$("#workTitle").val("착수발표용 PPT 수정");
		$("#workStrtDt").val("2022-04-21");
		$("#workEndDt").val("2022-04-21");
		$("#workCntnt").text("착수발표용 PPT 수정 부탁드려요~~~~");
	})
	
	if(${param.home == "click"}){
		console.log("click");
		$("#work").trigger('click');
	}
	
	// 리스트 가져오기
	workList();
        
	$.ajax({
	    url: "/project/projChart",
	    type: "GET",
	    data: {
	        'projId' : projId
	    },
	    async: false,
	    success: function (res) {
	        console.log(res["완료"]);
			$("#requestSpan").text(" ("+res["요청"]+")");
			$("#progressSpan").text(" ("+res["진행"]+")");
			$("#issueSpan").text(" ("+res["이슈"]+")");
			$("#completeSpan").text(" ("+res["완료"]+")");
	
	    },
	    dataType: "json"
	})   
		
  
}) // end $(function)
    
// console.log("===== ", document.querySelector('#workCntnt'));
//    ClassicEditor
//    .create( document.querySelector( '#workCntnt' ) )
//    .catch( error => {
//        console.error( error );
//    } );
    
</script>