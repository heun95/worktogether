<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<div class="row m-1">
	<h3>회의 일정</h3>
</div>

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
						<form class="needs-validation" name="event-form" id="form-event" novalidate>
							<div class="row">
								<div class="col-12">
									<div class="row mb-3">
										<label for="t" class="col-form-label col-sm-4">제목</label>
										<div class="col-sm-8"> 
											<input type="text" name="title" id="mtngTitle" class="form-control" placeholder="제목을 입력하세요" required>
											<div class="invalid-feedback">제목을 입력하세요</div>
										</div>
									</div>
									<div class="row mb-3">
										<label for="example-date-input" class="col-sm-4 col-form-label">회의시작시간</label>
										<div class="col-sm-8">
											<input class="form-control" type="date" id="projStrtDt"/>
										</div>
									</div>
									<div class="row mb-3">
										<label for="example-date-input" class="col-sm-4 col-form-label">종료일자</label>
										<div class="col-sm-8">
											<input class="form-control" type="date" id="projEndDt" />
										</div>
									</div>

								</div>
								<!-- end col-->
								<div class="col-12">
									<div class="mb-3">
										<label class="form-label">분류</label> <select
											class="form-select" name="category" id="event-category">
											<option selected>--선택--</option>
											<option value="bg-primary">일반</option>
											<option value="bg-warning">경고</option>
											<option value="bg-danger">긴급</option>
											<option value="bg-success">완료</option>
											<option value="bg-info">정보</option>
											<option value="bg-dark">기타</option>
										</select>
										<div class="invalid-feedback">유효한 카테고리를 선택하세요</div>
									</div>
									<!-- end col-->
								</div>
								<!-- end row-->
								<div class="row mt-2">
									<div class="col-6">
										<button type="button" class="btn btn-danger" id="btn-delete-event">삭제</button>
									</div>
									<!-- end col-->
									<div class="col-6 text-end">
										<button type="button" class="btn btn-light me-1" data-bs-dismiss="modal">닫기</button>
										<button type="submit" class="btn btn-success" id="btn-save-event">저장</button>
									</div>
									<!-- end col-->
								</div>
								<!-- end row-->
							</div>
						</form>
					</div>
				</div>
				<!-- end modal-content-->
			</div>
			<!-- end modal dialog-->
		</div>
		<!-- end modal-->
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
        
        var c = [
        	{
                title: "All Day Event",
                start: new Date(o, d, 1)
            }, {
                title: "Long Event",
                start: new Date(o, d, n - 5),
                end: new Date(o, d, n - 2),
                className: "bg-warning"
            }, {
                id: 999,
                title: "Repeating Event",
                start: new Date(o, d, n - 3, 16, 0),
                allDay: !1,
                className: "bg-info"
            }, {
                id: 999,
                title: "Repeating Event",
                start: new Date(o, d, n + 4, 16, 0),
                allDay: !1,
                className: "bg-primary"
            }, {
                title: "Meeting",
                start: new Date(o, d, n, 10, 30),
                allDay: !1,
                className: "bg-success"
            }, {
                title: "Lunch",
                start: new Date(o, d, n, 12, 0),
                end: new Date(o, d, n, 14, 0),
                allDay: !1,
                className: "bg-danger"
            }, {
                title: "Birthday Party",
                start: new Date(o, d, n + 1, 19, 0),
                end: new Date(o, d, n + 1, 22, 30),
                allDay: !1,
                className: "bg-success"
            }, {
                title: "Click for Google",
                start: new Date(o, d, 28),
                end: new Date(o, d, 29),
                url: "http://google.com/",
                className: "bg-dark"
            }
        	
        ];
        var v = (document.getElementById("external-events"), document.getElementById("calendar"));

        function u(e) {
            l.modal("show");
            a.removeClass("was-validated");
            a[0].reset();
            $("#mtngTitle").val();
            $("#event-category").val();
            t.text("회의일정 추가");
            r = e;
        }
        
        var m = new FullCalendar.Calendar(v, {
            plugins: ["bootstrap", "interaction", "dayGrid", "timeGrid"],
            editable: true,
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
        m.render(), $(a).on("submit", function (e) {
        	//alert("1");
            e.preventDefault();// 실제 전송하지 않음 
            $("#form-event :input");
            var t;
            var a = $("#mtngTitle").val();
            var n = $("#event-category").val();
            false === s[0].checkValidity() ? (event.preventDefault(), event.stopPropagation(), s[0].classList.add("was-validated")) : 
            	(i ? (i.setProp("title", a), i.setProp("classNames", [n])) : (t = {
																	                title: a,
																	                start: r.date,
																	                allDay: r.allDay,
																	                className: n
																	            }, m.addEvent(t)), l.modal("hide"))
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
    }, 
    $.CalendarPage = new e;
    $.CalendarPage.Constructor = e;
}(),
function () {
    "use strict";
    window.jQuery.CalendarPage.init()
}();	
</script>




