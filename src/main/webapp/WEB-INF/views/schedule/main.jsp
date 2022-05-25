<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Plugin css -->
<link rel="stylesheet" href="/resources/dist/assets/libs/@fullcalendar/core/main.min.css" type="text/css">
<link rel="stylesheet" href="/resources/dist/assets/libs/@fullcalendar/daygrid/main.min.css" type="text/css">
<link rel="stylesheet" href="/resources/dist/assets/libs/@fullcalendar/bootstrap/main.min.css" type="text/css">
<link rel="stylesheet" href="/resources/dist/assets/libs/@fullcalendar/timegrid/main.min.css" type="text/css">

<!-- 커스텀 CSS -->
<link rel="stylesheet" href="/resources/css/autho.css" type="text/css"/>

<style>
.fc-event {
	border: 0px;
}
</style>

<!-- <div class="row m-1"> -->
<!-- 	<h3>회의 일정</h3> -->
<!-- </div> -->
<script>
// function auto(){
// 	$("#schdlTitle").val("화요일 프젝마감");
// 	$("#schdlCntnt").val("마감 전에 한번 더 확인필요");
// }
</script>
<button id="searchBtn" style="display:none"></button>

<div class="row m-1">
	<div class="card overflow-hidden card-h-100 ">
		<div class="card-body" id="j-card">
	<div class="col-lg-12">
		<div class="row mb-4">
			<div class="col-xl-3" style="display:none;">	
				<div id="external-events"></div>
			</div>
			<!-- end col-->
			<div class="col-xl-12">
						<div id="calendar"></div>
			</div>
			<!-- end col -->
		</div>
		<!-- end row-->

		<!-- Add New Event MODAL -->
		<div class="modal fade" id="event-modal" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header py-3 px-4">
						<h5 class="modal-title" id="modal-title"></h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body p-4">
						<form action="/schedule/create" method="post" class="needs-validation" name="event-form" id="form-event" novalidate>
							<div class="row">
								<div class="col-12">
									<div class="row ">
										<div class="col-sm-6 mb-4 ee">
												<label class="form-label" for="schdlTypeId">종류</label>
												<select class="form-select" name="schdlTypeId" id="schdlTypeId">
													<option value="업무">업무</option>
													<option value="결재">결재</option>
													<option value="미팅">미팅</option>
													<option value="전화">전화</option>
													<option value="기타">기타</option>
												</select>
											<div class="invalid-feedback">유효한 카테고리를 선택하세요</div>
										</div>
										<div class="col-sm-6 mb-4 ee">
												<label class="form-label" for="schdlImport">강조</label> 
												<select class="form-select" name="schdlImport" id="schdlImport">
													<option value="일반">일반</option>
													<option value="중요">중요</option>
												</select>
												<div class="invalid-feedback">유효한 카테고리를 선택하세요</div>
										</div>
									</div>
								</div>
								<div class="col-12">
									<div class="row mb-4">
										<label for="schdlStrtDt" class="col-sm-3 col-form-label">시작일</label>
										<div class="col-sm-9 ee">
											<input class="form-control" type="date" id="schdlStrtDt" name="schdlStrtDt" required />
											<div class="invalid-feedback">시작일을 선택하세요</div>
										</div>
									</div>
									<div class="row mb-4">
										<label for="schdlEndDt" class="col-sm-3 col-form-label">종료일</label>
										<div class="col-sm-9 ee">
											<input class="form-control" type="date" id="schdlEndDt" name="schdlEndDt" required />
											<div class="invalid-feedback">종료일을 선택하세요</div>
										</div>
									</div>

									<div class="mb-4 ee" >
										<label class="form-label" for="schdlTitle">제목</label> 
										<input class="form-control" placeholder="제목을 입력하세요" type="text"
											name="schdlTitle" id="schdlTitle" required value="">
										<div class="invalid-feedback">제목을 입력하세요</div>
									</div>
									<div class="mb-4 ee">
										<label class="schdlCntnt">내용</label> 
										<textarea class="form-control" placeholder="내용을 입력하세요"
											name="schdlCntnt" id="schdlCntnt" rows="5" required></textarea>
										<div class="invalid-feedback">내용을 입력하세요</div>
									</div>
								</div>
								
								<div class="col-12 mt-2">
									<div class="row">
									<div class="col-sm-6">
<!-- 										<button type="button" class="btn btn-danger" id="btn-delete-event">삭제</button> -->
									</div>
									<div class="col-sm-6 text-end">
										<button type="submit" class="btn btn-success" id="">저장</button>
										<button type="button" class="btn btn-light me-1" data-bs-dismiss="modal">닫기</button>
									</div>
									</div>
								</div>
								<!-- end row-->
							</div>
							<sec:csrfInput/>
						</form>
					</div>
				</div>
				<!-- end modal-content-->
			</div>
			<!-- end modal dialog-->
		</div>
		<!-- end modal-->
		
		
		
		<!-- 일정 상세보기 modal -->
		<div class="modal fade" id="openModal" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header py-3 px-4">
						<h5 class="modal-title" id="modal-title">일정 상세</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body p-4">
						<form action="/schedule/update" method="post" class="needs-validation" name="event-form" id="updateForm" novalidate>
																					<!-- 							form-event  -->
							<div class="row">
								<div class="col-12">
									<div class="row ">
										<div class="col-sm-6 mb-4">
												<label class="form-label" for="schdlTypeId">종류</label>
												<div id="divId1">
													<input type="text" class="form-control" name="schdlTypeId2" id="schdlTypeId2" readonly>
												</div>
											<div class="invalid-feedback">유효한 카테고리를 선택하세요</div>
										</div>
										<div class="col-sm-6 mb-4">
												<label class="form-label" for="schdlImport">강조</label> 
												<div id="divId2">
													<input type="text" class="form-control" name="schdlImport2" id="schdlImport2" readonly>
												</div>

												<div class="invalid-feedback">유효한 카테고리를 선택하세요</div>
										</div>
									</div>
								</div>
								<div class="col-12">
									<div class="row mb-4">
										<label for="schdlStrtDt" class="col-sm-3 col-form-label">시작일</label>
										<div class="col-sm-9">
											<input class="form-control" type="date" id="schdlStrtDt" name="schdlStrtDt" required readonly/>
											<div class="invalid-feedback">시작일을 선택하세요</div>
										</div>
									</div>
									<div class="row mb-4">
										<label for="schdlEndDt" class="col-sm-3 col-form-label">종료일</label>
										<div class="col-sm-9">
											<input class="form-control" type="date" id="schdlEndDt" name="schdlEndDt" required readonly/>
											<div class="invalid-feedback">종료일을 선택하세요</div>
										</div>
									</div>

									<div class="mb-4">
										<label class="form-label" for="schdlTitle">제목</label> 
										<input class="form-control" placeholder="제목을 입력하세요" type="text"
											name="schdlTitle" id="schdlTitle" required value="" readonly>
										<div class="invalid-feedback">제목을 입력하세요</div>
									</div>
									<div class="mb-4">
										<label class="schdlCntnt">내용</label> 
										<textarea class="form-control" placeholder="내용을 입력하세요"
											name="schdlCntnt" id="schdlCntnt" rows="5" required readonly></textarea>
										<div class="invalid-feedback">내용을 입력하세요</div>
									</div>
								</div>
								
								<div class="col-12 mt-2">
									<div class="row">
									<div class="col-sm-6">
										<button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
										<input type="hidden" id="schdlId" name="schdlId" value="${scheduleVO.schdlId}">
									</div>
									<div class="col-sm-6 text-end" id="divUpdate">
										<button type="button" class="btn btn-warning" id="updateBtn">수정</button>
										<button type="button" class="btn btn-light me-1" data-bs-dismiss="modal" id="closeBtn">닫기</button>
									</div>
									</div>
								</div>
								<!-- end row-->
							</div>
							<sec:csrfInput/>
						</form>
					</div>
				</div>
				<!-- end modal-content-->
			</div>
			<!-- end modal dialog-->
		</div>
	</div>
	</div>
	</div>
	
</div>

<!-- plugin js -->
<script src="/resources/dist/assets/libs/moment/min/moment.min.js"></script>
<script src="/resources/dist/assets/libs/jquery-ui-dist/jquery-ui.min.js"></script>
<script src="/resources/dist/assets/libs/@fullcalendar/core/main.min.js"></script>
<script src="/resources/dist/assets/libs/@fullcalendar/bootstrap/main.min.js"></script>
<script src="/resources/dist/assets/libs/@fullcalendar/daygrid/main.min.js"></script>
<script src="/resources/dist/assets/libs/@fullcalendar/timegrid/main.min.js"></script>
<script src="/resources/dist/assets/libs/@fullcalendar/interaction/main.min.js"></script>

<script>
/*
(function(){
	alert("KGB");	
})(); // 즉각실행함수, 라이브러리 맹글떄
*/

// var a,b=100, c=1000;

// !function(g){
// 	g(".aaa");  // g==$
// 	alert("KGB");	
// }(jQuery); // 즉각실행함수, 라이브러리 맹글떄
var v_idList = [];

! function () {
    "use strict";

    function e() {}
    e.prototype.init = function () {
        var l = $("#event-modal");
        var t = $("#modal-title");
        var a = $("#form-event");
        var i = null;
        var r = null;
        var s = document.getElementsByClassName("needs-validation");
        var i = null;
        var r = null;
        var e = new Date;
        var n = e.getDate();
        var d = e.getMonth();
        var o = e.getFullYear();
        
        new FullCalendarInteraction.Draggable(document.getElementById("external-events"), {
            itemSelector: ".external-event",

            eventData: function (e) {
                return {
                    title: e.innerText,
                    className: g(e).data("class")
                }
            }
        });
		
        var c = [];
      	
        <c:forEach var="vo" items="${scheduleList}">
    	
	    	<fmt:formatDate var="fmt_startDate" value="${vo.schdlStrtDt}" pattern="yyyy-MM-dd"/>
	    	var v_startDate = "${fmt_startDate}";
	    	var v_startYear = v_startDate.substring(0,4);
	    	var v_startMonth = v_startDate.substring(5,7)-1;
	    	var v_startDay = v_startDate.substring(8,10);
	    	
	    	<fmt:formatDate var="fmt_endDate" value="${vo.schdlEndDt}" pattern="yyyy-MM-dd"/>
	    	var v_endDate = "${fmt_endDate}";
	    	var v_endYear = v_endDate.substring(0,4);
	    	var v_endMonth = v_endDate.substring(5,7)-1;
	    	var v_endDay = v_endDate.substring(8,10);
	      	
	    	var v_c = {};
			v_c.title = "${vo.schdlTitle}";
			v_c.start = new Date(v_startYear, v_startMonth, v_startDay);
			v_c.end = new Date(v_endYear, v_endMonth, v_endDay);
			
	    	<c:if test="${vo.schdlTypeId == '전체'}">
	    		<c:if test="${vo.schdlImport == '일반'}">
	    			v_c.className = "bg-info";
	    		</c:if>
	    		<c:if test="${vo.schdlImport == '중요'}">
	    			v_c.className = "progress-bar bg-info progress-bar-striped progress-bar-animated";
	    		</c:if>
	    	</c:if>
	    	<c:if test="${vo.schdlTypeId == '업무'}">
	    		<c:if test="${vo.schdlImport == '일반'}">
    				v_c.className = "bg-primary";
	    		</c:if>
	    		<c:if test="${vo.schdlImport == '중요'}">
	    			v_c.className = "progress-bar bg-primary progress-bar-striped progress-bar-animated";
	    		</c:if>
	    	</c:if>
	    	<c:if test="${vo.schdlTypeId == '결재'}">
	    		<c:if test="${vo.schdlImport == '일반'}">
    				v_c.className = "bg-warning";
	    		</c:if>
	    		<c:if test="${vo.schdlImport == '중요'}">
	    			v_c.className = "progress-bar bg-warning progress-bar-striped progress-bar-animated";
	    		</c:if>
	    	</c:if>
	    	<c:if test="${vo.schdlTypeId == '미팅'}">
	    		<c:if test="${vo.schdlImport == '일반'}">
    				v_c.className = "bg-danger";
    			</c:if>
	    		<c:if test="${vo.schdlImport == '중요'}">
	    			v_c.className = "progress-bar bg-danger progress-bar-striped progress-bar-animated";
	    		</c:if>
	    	</c:if>
	    	<c:if test="${vo.schdlTypeId == '전화'}">
	    		<c:if test="${vo.schdlImport == '일반'}">
    				v_c.className = "bg-success";
	    		</c:if>
	    		<c:if test="${vo.schdlImport == '중요'}">
	    			v_c.className = "progress-bar bg-success progress-bar-striped progress-bar-animated";
	    		</c:if>
	    	</c:if>
	    	<c:if test="${vo.schdlTypeId == '기타'}">
	    		<c:if test="${vo.schdlImport == '일반'}">
    				v_c.className = "bg-dark";
	    		</c:if>
	    		<c:if test="${vo.schdlImport == '중요'}">
	    			v_c.className = "progress-bar bg-dark progress-bar-striped progress-bar-animated";
	    		</c:if>
	    	</c:if>
	        
	    	v_c.url = "/schedule/main?schdlId=${vo.schdlId}&selector=s";
	        c.push(v_c);
	        
		</c:forEach>
    
        console.log(c);
        
        var v = (document.getElementById("external-events"), document.getElementById("calendar"));

        function u(e) {
        	l.modal("show");
            a.removeClass("was-validated");
            a[0].reset();
            $("#mtngTitle").val();
            $("#event-category").val();
            t.text("일정 추가");
            r = e;
        }
        
        var m = new FullCalendar.Calendar(v, {
            plugins: ["bootstrap", "interaction", "dayGrid", "timeGrid"],
            editable: false,
            droppable: true,
            selectable: true,
            defaultView: "dayGridMonth",
            themeSystem: "bootstrap",
            header: {
                left: "prev,next today",
                center: "title",
                right: "dayGridMonth,timeGridWeek,timeGridDay,listMonth"
            },
            eventClick: function (e) {
                l.modal("show"), a[0].reset();
                i = e.event;
                $("#mtngTitle").val(i.title);
                $("#event-category").val(i.classNames[0]);
                r = null;
                t.text("Edit Event");
                r = null;
            },
            dateClick: function (e) {
                u(e)
            },
            events: c
        });
        m.render(), 
        $(a).on("submit", function (e) {
            //e.preventDefault();// 실제 전송하지 않음 
            $("#form-event :input");
            var t;
            var a = $("#mtngTitle").val();
            var n = $("#event-category").val();
            false === s[0].checkValidity() ? (event.preventDefault(), event.stopPropagation(), s[0].classList.add("was-validated")) : 
            	(i ? (i.setProp("title", a),  i.setProp("classNames", [n])) : (t = {
																	                title: a,
																	                start: r.date,
																	                allDay: r.allDay,
																	                className: n
																	            }, m.addEvent(t)), l.modal("hide"))
			//alert("일정이 등록되었습니다.");														            
        }), 
        $("#btn-delete-event").on("click", function (e) {
            i && (i.remove(), i = null, l.modal("hide"))
        }), 
        $("#btn-new-event").on("click", function (e) {
            u({
                date: new Date,
                allDay: !0
            })
        })
        
        $(".fc-toolbar .fc-center").addClass('ms-5');
        $(".fc-toolbar .fc-center h2").css("margin-left","100px");

        $(".fc-time").html("");
        var v_result = '';
        v_result += '<button class="btn btn-sm btn-info me-1 selectType" style="cursor: default; border-radius: 5px;" type="button">전체</button>';
        v_result += '<button class="btn btn-sm btn-primary me-1 selectType" style="cursor: default; border-radius: 5px;" type="button">업무</button>';
        v_result += '<button class="btn btn-sm btn-warning me-1 selectType" style="cursor: default; border-radius: 5px;" type="button">결재</button>';
        v_result += '<button class="btn btn-sm btn-danger me-1 selectType" style="cursor: default; border-radius: 5px;" type="button">미팅</button>';
        v_result += '<button class="btn btn-sm btn-success me-1 selectType" style="cursor: default; border-radius: 5px;" type="button">전화</button>';
        v_result += '<button class="btn btn-sm btn-dark selectType" style="cursor: default; border-radius: 5px;" type="button">기타</button>';
        $(".fc-right .btn-group").html(v_result);
        $(".fc-content").css("cursor","pointer");
        $(".fc-content").on("click",function(){
        	event.stopPropagation();
        	console.log($(this).html());
        })
		$(".selectType").on("click",function(){
			var v_selectType = $(this).text();
			location.href="/schedule/main?selectType="+v_selectType;
		})        
        
      	$("#searchBtn").bind("click",function(){
      		$("#openModal").modal("show");
      	})
        
        <c:if test="${scheduleVO != null}">
			setTimeout(function() {
	        	$("#searchBtn").trigger("click");
			}, 1);
			
			$("#openModal").find("#schdlTypeId2").val("${scheduleVO.schdlTypeId}");
			$("#openModal").find("#schdlImport2").val("${scheduleVO.schdlImport}");
			
			//console.log("${get_startDate}");
			<fmt:formatDate var="get_startDate" value="${scheduleVO.schdlStrtDt}" pattern="yyyy-MM-dd"/>
			$("#openModal").find("#schdlStrtDt").val("${get_startDate}");
			
			<fmt:formatDate var="get_endDate" value="${scheduleVO.schdlEndDt}" pattern="yyyy-MM-dd"/>
			$("#openModal").find("#schdlEndDt").val("${get_endDate}");
			
			$("#openModal").find("#schdlCntnt").val("${scheduleVO.schdlCntnt}");
			
			$("#openModal").find("#schdlTitle").val("${scheduleVO.schdlTitle}");
			
			$("#deleteBtn").on("click",function(){
				location.href="/schedule/delete?schdlId=${scheduleVO.schdlId}";
			})
			
			$("#updateBtn").on("click",function(){
				$("#openModal").find("#schdlStrtDt").prop("readonly",false);
				$("#openModal").find("#schdlEndDt").prop("readonly",false);
				$("#openModal").find("#schdlCntnt").prop("readonly",false);
				$("#openModal").find("#schdlTitle").prop("readonly",false);
			
				var v_div1 = '';
				v_div1 += '<select class="form-select" name="schdlTypeId" id="schdlTypeId">';
				v_div1 += '	 <option value="업무">업무</option>';
				v_div1 += '	 <option value="결재">결재</option>';
				v_div1 += '  <option value="미팅">미팅</option>';
				v_div1 += '  <option value="전화">전화</option>';
				v_div1 += '  <option value="기타">기타</option>';
				v_div1 += '</select>';
				$("#divId1").html(v_div1);
				
				$("#divId1").find("#schdlTypeId").val("${scheduleVO.schdlTypeId}").prop("selected",true);
				
				var v_div2 = '';
				v_div2 += '<select class="form-select" name="schdlImport" id="schdlImport">';
				v_div2 += '  <option value="일반">일반</option>';
				v_div2 += '  <option value="중요">중요</option>';
				v_div2 += '</select>';
				$("#divId2").html(v_div2);
				
				$("#divId2").find("#schdlImport").val("${scheduleVO.schdlImport}").prop("selected",true);
				
				$("#deleteBtn").hide();
				$("#closeBtn").text("취소");
				$("#updateBtn").hide();
				
				$("#divUpdate").prepend('<button type="button" class="btn btn-success" id="successBtn">확인</button>');
				//
				
				$("#successBtn").on("click",function(){
// 					var v_val1 = $("#schdlTypeId2").val();
// 					var v_val2 = $("#schdlImport2").val();
// 					$("#schdlTypeId").val(v_val1);
// 					$("#schdlImport").val(v_val2);
					$("#updateForm").submit();
				})
			})
// 			
// 													
// 													
// 													
// 													
// 													
// 												
       	</c:if>
      		
    }, 
    $.CalendarPage = new e;
    $.CalendarPage.Constructor = e;
    
    
    
    
}(),
function () {
    "use strict";
    window.jQuery.CalendarPage.init()
    
}();

$("#modal-title").on("click",function(){
	$(".ee").find("#schdlTypeId").val("미팅").prop("selected",true);
	$(".ee").find("#schdlImport").val("중요").prop("selected",true);
	//var v_date = new Date("2022-04-22");
	//$(".ee").find("#schdlStrtDt").val(v_date);
	$(".ee").find("#schdlStrtDt").val("2022-04-22");
	$(".ee").find("#schdlEndDt").val("2022-04-22");
	$(".ee").find("#schdlTitle").val("거래처 미팅");
	$(".ee").find("#schdlCntnt").val("이경훈 부장과 미팅 예정");
})


</script>
