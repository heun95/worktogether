<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row mb-2">
	<div class="col-lg-8">
		<h2>${sessionScope.projName }</h2>
	</div>
	<div class="col-lg-3">
		<button type="button" id="addMemBtn" class="btn btn-primary">팀원초대</button>
	</div>
</div>
<div id="projTab" class="row mb-3">
	<div class="">
		<ul class="nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
		   <li class="nav-item">
		       <a class="nav-link" id="home" data-bs-toggle="tab" href="#home1" role="tab" data-projId="${sessionScope.projId }">
		           <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
		           <span class="d-none d-sm-block">홈</span> 
		       </a>
		   </li>
		   <li class="nav-item">
		       <a class="nav-link" id="work" data-bs-toggle="tab" href="#profile1" role="tab"  data-projId="${sessionScope.projId }" >
		           <span class="d-block d-sm-none"><i class="far fa-user"></i></span>
		           <span class="d-none d-sm-block">업무</span> 
		       </a>
		   </li>
		   <li class="nav-item">
		       <a class="nav-link" id="ganttchart" data-bs-toggle="tab" href="#messages1" role="tab" data-projId="${sessionScope.projId }" >
		           <span class="d-block d-sm-none"><i class="far fa-envelope"></i></span>
		           <span class="d-none d-sm-block">간트차트</span>   
		       </a>
		   </li>
		   <li class="nav-item">
		       <a class="nav-link" id="calendarTab" data-bs-toggle="tab" href="#settings1" role="tab" data-projId="${sessionScope.projId }" >
		           <span class="d-block d-sm-none"><i class="fas fa-cog"></i></span>
		           <span class="d-none d-sm-block">캘린더</span>    
		       </a>
		   </li>
		   <li class="nav-item">
		       <a class="nav-link" id="file" data-bs-toggle="tab" href="#settings1" role="tab"  data-projId="${sessionScope.projId }">
		           <span class="d-block d-sm-none"><i class="fas fa-cog"></i></span>
		           <span class="d-none d-sm-block">파일</span>    
		       </a>
		   </li>
		</ul>
	</div>
</div> 

<script>
$(function(){
	var url = window.location.href;
	console.log("url",url.indexOf("project/"));
	
	var urlTab = url.substring(url.indexOf("project/")+8,url.indexOf("?"));
	$("#"+urlTab+"").addClass("active");
	if(urlTab == "calendar"){
		$("#calendarTab").addClass("active");
	}
	$("#addMemBtn").on("click", function(){
// 		console.log("text");
		$(".jojicBtn").trigger("click");
	})
	
	$(document).on("click", ".member", function(){
		empId = $(this).data("empid");
		console.log($(this).data("empid"));
		var projmem = $(".projmem");
		console.log("projmem", projmem[1]);
		for(var i=0; i < projmem.length; i++ ){
			var mem = projmem[i];
			console.log($(mem).data("empid"));
			if($(mem).data("empid") == empId){
				
				alert("이미 있는 멤버입니다.")
				return false;
			}
		}
		$.ajax({
			  url: "/project/projMemInsert",
			  method: "POST",
			  data : {
				  'projId': "${sessionScope.projId }"
				  ,'empId': empId
			  },
			  success: function (res) {
				  $("#jojicdoModal").hide();
				  $(".modal-backdrop").remove();
				  location.reload();

			  },
	          beforeSend: function (xhr) {
	            xhr.setRequestHeader(header, token)
	          },
			  dataType: "json"
			});
	})
})
</script>
