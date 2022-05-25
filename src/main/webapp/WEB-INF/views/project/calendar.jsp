<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>   
<!-- Plugin css -->
<link rel="stylesheet" href="/resources/dist/assets/libs/@fullcalendar/core/main.min.css" type="text/css">
<link rel="stylesheet" href="/resources/dist/assets/libs/@fullcalendar/daygrid/main.min.css" type="text/css">
<link rel="stylesheet" href="/resources/dist/assets/libs/@fullcalendar/bootstrap/main.min.css" type="text/css">
<link rel="stylesheet" href="/resources/dist/assets/libs/@fullcalendar/timegrid/main.min.css" type="text/css">
<link href="/resources/css/project.css" rel="stylesheet" type="text/css" />

<style>
.fc-event {
	border: 0px;
}
.fc-requestBtn-button{
	background : #4f9dff;
	border-color: #4f9dff;
}
.fc-ingBtn-button{
	background : rgb(0, 177, 156);
	border-color: rgb(0, 177, 156);
}
.fc-completeBtn-button{
	background : #271050;
	border-color: #271050;
}
.fc-issueBtn-button{
	background : #ff5d5d;
	border-color: #ff5d5d;
}
</style>

<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
			
				<%@ include file="includeTab.jsp" %>
				
				
                        <sec:csrfInput />
                        <div class="row mb-4">
<!--                             <div class="col-xl-3"> -->
<!--                                 <div class="card h-100"> -->
<!--                                     <div class="card-body"> -->
<!--                                         <button type="button" class="btn font-16 btn-primary waves-effect waves-light w-100" -->
<!--                                             id="btn-new-event" data-bs-toggle="modal" data-bs-target="#event-modal"> -->
<!--                                             Create New Event -->
<!--                                         </button> -->
            
<!--                                         <div id="external-events"> -->
<!--                                             <br> -->
<!--                                             <p class="text-muted">Drag and drop your event or click in the calendar</p> -->
<!--                                             <div class="external-event fc-event bg-success" data-class="bg-success"> -->
<!--                                                 <i class="mdi mdi-checkbox-blank-circle font-size-11 me-2"></i>New Event -->
<!--                                                 Planning -->
<!--                                             </div> -->
<!--                                             <div class="external-event fc-event bg-info" data-class="bg-info"> -->
<!--                                                 <i class="mdi mdi-checkbox-blank-circle font-size-11 me-2"></i>Meeting -->
<!--                                             </div> -->
<!--                                             <div class="external-event fc-event bg-warning" data-class="bg-warning"> -->
<!--                                                 <i class="mdi mdi-checkbox-blank-circle font-size-11 me-2"></i>Generating -->
<!--                                                 Reports -->
<!--                                             </div> -->
<!--                                             <div class="external-event fc-event bg-danger" data-class="bg-danger"> -->
<!--                                                 <i class="mdi mdi-checkbox-blank-circle font-size-11 me-2"></i>Create -->
<!--                                                 New theme -->
<!--                                             </div> -->
<!--                                         </div> -->
                                        
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> end col -->
                            <div class="col-xl-12">
                                <div class="card mb-0">
                                    <div class="card-body">
                                        <div id="calendar"></div>
                                    </div>
                                </div>
                            </div> <!-- end col -->
                        </div> <!-- end row-->
                        <div style='clear:both'></div>
            
                        <!-- Add New Event MODAL -->
                        <div class="modal fade" id="event-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                            aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header py-3 px-4">
                                        <h5 class="modal-title" id="modal-title">Event</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
            
                                    <div class="modal-body p-4">
                                        <form class="needs-validation" name="event-form" id="form-event" novalidate>
                                            <div class="row">
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                        <label class="form-label">Event Name</label>
                                                        <input class="form-control" placeholder="Insert Event Name" type="text"
                                                            name="title" id="event-title" required value="">
                                                        <div class="invalid-feedback">Please provide a valid event name
                                                        </div>
                                                    </div>
                                                </div> <!-- end col-->
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                        <label class="form-label">Category</label>
                                                        <select class="form-select" name="category" id="event-category">
                                                            <option  selected> --Select-- </option>
                                                            <option value="bg-danger">Danger</option>
                                                            <option value="bg-success">Success</option>
                                                            <option value="bg-primary">Primary</option>
                                                            <option value="bg-info">Info</option>
                                                            <option value="bg-dark">Dark</option>
                                                            <option value="bg-warning">Warning</option>
                                                        </select>
                                                        <div class="invalid-feedback">Please select a valid event
                                                            category</div>
                                                    </div>
                                                </div> <!-- end col-->
                                            </div> <!-- end row-->
                                            <div class="row mt-2">
                                                <div class="col-6">
                                                    <button type="button" class="btn btn-danger"
                                                        id="btn-delete-event">Delete</button>
                                                </div> <!-- end col-->
                                                <div class="col-6 text-end">
                                                    <button type="button" class="btn btn-light me-1"
                                                        data-bs-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-success" id="btn-save-event">Save</button>
                                                </div> <!-- end col-->
                                            </div> <!-- end row-->
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

<%@ include file="modal.jsp"%>


	<!-- plugin js -->
	<script src="/resources/dist/assets/libs/moment/min/moment.min.js"></script>
	<script src="/resources/dist/assets/libs/jquery-ui-dist/jquery-ui.min.js"></script>
	<script src="/resources/dist/assets/libs/@fullcalendar/core/main.min.js"></script>
	<script src="/resources/dist/assets/libs/@fullcalendar/bootstrap/main.min.js"></script>
	<script src="/resources/dist/assets/libs/@fullcalendar/daygrid/main.min.js"></script>
	<script src="/resources/dist/assets/libs/@fullcalendar/timegrid/main.min.js"></script>
	<script src="/resources/dist/assets/libs/@fullcalendar/interaction/main.min.js"></script>
	
	<script src="/resources/js/project.js"></script>
        
        	
	<script>
	$(function(){
		
		var request = $.ajax({
		  url: "/project/caldata",
		  data : {
			  'projId': "${sessionScope.projId }"
		  },
		  method: "GET",
		  dataType: "json"
		});
		 
		request.done(function( data ){
			console.log(data)
		
	    var calendarEl = document.getElementById('calendar');   
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	    	plugins: ["bootstrap", "interaction", "dayGrid", "timeGrid"],
            editable: !0,
            droppable: !0,
            selectable: !0,
            defaultView: "dayGridMonth",
            themeSystem: "bootstrap",
            customButtons: {
              requestBtn: {
                text: '요청'
                ,click: function() {
                  
                }
              },
              ingBtn: {
                text: '진행'
                ,click: function() {
                  
                }
              },
              completeBtn: {
                text: '완료'
                ,click: function() {
                  
                }
              },
              issueBtn: {
                text: '이슈'
                ,click: function() {
                  
                }
              },
            },
            header: {
                left: "prev,next today",
                center: "title",
                right: "requestBtn ingBtn completeBtn issueBtn,listMonth"
            },
            eventClick: function (e) {
//                 console.log()
                var workId = e.event._def.publicId;
                
                console.log(workId);
                // 오프캔버스 활성화
                var myOffcanvas = $("#wokrDetail")
				var bsOffcanvas = new bootstrap.Offcanvas(myOffcanvas)
                bsOffcanvas.show();
                // 디테일
            	workDetail(workId);
                // 댓글리스트  
                rplList(workId);

            },
            eventLimit: true,
	        events: data

	   });//new FullCalendar end
	 
	   calendar.render();
	   
	  });
		
		
		
	});
	
	
	

	</script>
	
        