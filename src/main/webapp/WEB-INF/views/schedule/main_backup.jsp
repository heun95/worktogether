<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Plugin css -->
<link rel="stylesheet"
	href="/resources/dist/assets/libs/@fullcalendar/core/main.min.css"
	type="text/css">
<link rel="stylesheet"
	href="/resources/dist/assets/libs/@fullcalendar/daygrid/main.min.css"
	type="text/css">
<link rel="stylesheet"
	href="/resources/dist/assets/libs/@fullcalendar/bootstrap/main.min.css"
	type="text/css">
<link rel="stylesheet"
	href="/resources/dist/assets/libs/@fullcalendar/timegrid/main.min.css"
	type="text/css">

<script src="/resources/dist/assets/libs/pdfmake/build/pdfmake.min.js"></script>
<script src="/resources/dist/assets/libs/pdfmake/build/vfs_fonts.js"></script>

<style>
.fc-event {
	border: 0px;
}
</style>


<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">

				<div
					class="page-title-box d-flex align-items-center justify-content-between">
					<h4 class="mb-0">
						<a href="/schedule/main">전체 일정</a>
					</h4>
					<div align="right">
						<ol class="breadcrumb m-0">
							<li class="breadcrumb-item"><a href="">나의
									일정</a></li>
							<li class="breadcrumb-item"><a href="">회사
									일정</a></li>
						</ol>
					</div>
				</div>
				<div class="row mb-4">
					<div class="col-xl-3">
						<div class="card h-100">
							<div class="card-body">
								<div>
									<button type="button"
										class="btn font-16 btn-primary waves-effect waves-light w-100"
										id="btn-new-event" data-bs-toggle="modal"
										data-bs-target="#event-modal">새 일정</button>
								</div>
								<p></p>
								<div id="external-events">
									<br>
									<p class="text-muted">드래그앤드롭 또는 일정표를 클릭하세요</p>
									<div class="external-event fc-event bg-success"
										data-class="bg-success">
										<i></i>기본 일정
									</div>
									<div class="external-event fc-event bg-info"
										data-class="bg-info">
										<i></i>회의
									</div>
									<div class="external-event fc-event bg-warning"
										data-class="bg-warning">
										<i></i>경고
									</div>
									<div class="external-event fc-event bg-danger"
										data-class="bg-danger">
										<i></i>긴급
									</div>

								</div>


							</div>
						</div>
					</div>
					<!-- end col-->
					<div class="col-xl-9">
						<div class="card mb-0">
							<div class="card-body">
								<div id="calendar"></div>
							</div>
						</div>
					</div>
					<!-- end col -->
				</div>
				<!-- end row-->
				<div style='clear: both'></div>
				<div align="right">
					<button class="btn btn-secondary buttons-pdf buttons-html5 "
						tabindex="0" aria-controls="datatable-buttons" type="button">
						<span>PDF 출력하기</span>
					</button>
				</div>


				<!-- Add New Event MODAL -->
				<div class="modal fade" id="event-modal" data-bs-backdrop="static"
					data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header py-3 px-4">
								<h5 class="modal-title" id="modal-title">일정 추가</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>

							<div class="modal-body p-4">
								<form class="needs-validation" name="event-form" id="form-event"
									novalidate>
									<div class="row">
										<div class="col-12">
											<div class="row mb-3">
												<label for="example-date-input"
													class="col-sm-4 col-form-label">시작일자</label>
												<div class="col-sm-8">
													<%-- 									<form:input class="form-control" type="date" path="projStrtDt" /> --%>
													<input class="form-control" type="date" id="projStrtDt" />
												</div>
											</div>
											<div class="row mb-3">
												<label for="example-date-input"
													class="col-sm-4 col-form-label">종료일자</label>
												<div class="col-sm-8">
													<%-- 									<form:input class="form-control" type="date" path="projStrtDt" /> --%>
													<input class="form-control" type="date" id="projEndDt" />
												</div>
											</div>

											<div class="mb-3">
												<label class="form-label">일정 이름</label> <input
													class="form-control" placeholder="일정 이름을 입력하세요" type="text"
													name="title" id="event-title" required value="">
												<div class="invalid-feedback">일정 이름을 입력하세요</div>
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
												<button type="button" class="btn btn-danger"
													id="btn-delete-event">삭제</button>
											</div>
											<!-- end col-->
											<div class="col-6 text-end">
												<button type="button" class="btn btn-light me-1"
													data-bs-dismiss="modal">닫기</button>
												<button type="submit" class="btn btn-success"
													id="btn-save-event">저장</button>
											</div>
											<!-- end col-->
										</div>
										<!-- end row-->
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
<script
	src="/resources/dist/assets/libs/jquery-ui-dist/jquery-ui.min.js"></script>
<script src="/resources/dist/assets/libs/@fullcalendar/core/main.min.js"></script>
<script
	src="/resources/dist/assets/libs/@fullcalendar/bootstrap/main.min.js"></script>
<script
	src="/resources/dist/assets/libs/@fullcalendar/daygrid/main.min.js"></script>
<script
	src="/resources/dist/assets/libs/@fullcalendar/timegrid/main.min.js"></script>
<script
	src="/resources/dist/assets/libs/@fullcalendar/interaction/main.min.js"></script>

<!-- Calendar init -->
<!-- 	<script src="/resources/dist/assets/js/pages/calendar.init.js"></script>	 -->

<script>
! function (g) {
    "use strict";

    function e() {}
    e.prototype.init = function () {
        var l = g("#event-modal"),
            t = g("#modal-title"),
            a = g("#form-event"),
            i = null,
            r = null,
            s = document.getElementsByClassName("needs-validation"),
            i = null,
            r = null,
            e = new Date,
            n = e.getDate(),
            d = e.getMonth(),
            o = e.getFullYear();
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
            
            ],
            v = (document.getElementById("external-events"), document.getElementById("calendar"));

        function u(e) {
            l.modal("show"), a.removeClass("was-validated"), a[0].reset(), g("#event-title").val(), g("#event-category").val(), t.text("Add Event"), r = e
        }
        var m = new FullCalendar.Calendar(v, {
            plugins: ["bootstrap", "interaction", "dayGrid", "timeGrid"],
            editable: !0,
            droppable: !0,
            selectable: !0,
            defaultView: "dayGridMonth",
            themeSystem: "bootstrap",
            header: {
                left: "prev,next today",
                center: "title",
                right: "dayGridMonth,timeGridWeek,timeGridDay,listMonth"
            },
            eventClick: function (e) {
                l.modal("show"), a[0].reset(), i = e.event, g("#event-title").val(i.title), g("#event-category").val(i.classNames[0]), r = null, t.text("Edit Event"), r = null
            },
            dateClick: function (e) {
                u(e)
            },
            events: c
        });
        m.render(), g(a).on("submit", function (e) {
            e.preventDefault();
            g("#form-event :input");
            var t, a = g("#event-title").val(),
                n = g("#event-category").val();
            !1 === s[0].checkValidity() ? (event.preventDefault(), event.stopPropagation(), s[0].classList.add("was-validated")) : (i ? (i.setProp("title", a), i.setProp("classNames", [n])) : (t = {
                title: a,
                start: r.date,
                allDay: r.allDay,
                className: n
            }, m.addEvent(t)), l.modal("hide"))
        }), g("#btn-delete-event").on("click", function (e) {
            i && (i.remove(), i = null, l.modal("hide"))
        }), g("#btn-new-event").on("click", function (e) {
            u({
                date: new Date,
                allDay: !0
            })
        })
    }, g.CalendarPage = new e, g.CalendarPage.Constructor = e
}(window.jQuery),
function () {
    "use strict";
    window.jQuery.CalendarPage.init()
}();	


// 	$(function() {

// 		var request = $.ajax({
// 			url : "/schedule/caldata",
// 			data : {
// 				'schdlId' : "${sessionScope.schdlId}"
// 			},
// 			method : "GET",
// 			dataType : "json" //서버로 부터 받는 값의 타입
// 		});

// 		request.done(function(data) {
// 					console.log(data)

// 					var calendarEl = document.getElementById('calendar');
// 					var calendar = new FullCalendar.Calendar(
// 							calendarEl,
// 							{
// 								plugins : [ "bootstrap", "interaction",
// 										"dayGrid", "timeGrid" ],
// 								editable : !0,
// 								droppable : !0,
// 								selectable : !0,
// 								defaultView : "dayGridMonth",
// 								themeSystem : "bootstrap",
// 								header : {
// 									left : "prev,next today",
// 									center : "title",
// 									right : "dayGridMonth,timeGridWeek,timeGridDay,listMonth"
// 								},
// 								eventLimit : true,
// 								events : data

// 							});//new FullCalendar end

// 					calendar.render();

// 				});
// 	});
</script>


