<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<link rel="stylesheet" href="/resources/css/noti.css" type="text/css"/>


<style>
.navbar-header {
	display: -webkit-box;
	display: -ms-flexbox;
	display: flex;
	-ms-flex-pack: justify;
	-webkit-box-pack: justify;
	justify-content: space-between;
	-webkit-box-align: center;
	-ms-flex-align: center;
	align-items: center;
	margin: 0 auto;
	background-color: #AAB9FF;
	height: 70px;
	padding: 0 calc(24px/ 2) 0 0;
}

*, ::after, ::before {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
}

body[data-topbar=dark] .navbar-brand-box {
	background-color: #AAB9FF;
}
</style>
<!-- Header(bar) -->
<header id="page-topbar">
	<div class="navbar-header">
		<div id="momentDiv" class="alert alert-success" style="position: absolute; min-width: 300px; top:10px; right:10px; z-index:99; display:none;"></div>
		<div class="d-flex">
			<!-- LOGO -->
			<div class="navbar-brand-box"></div>

			<button type="button"
				class="btn btn-sm px-3 font-size-16 header-item waves-effect vertical-menu-btn">
				<i class="fa fa-fw fa-bars"></i>
			</button>

			<!-- App Search-->


		</div>

		<div class="d-flex">

			<div class="dropdown d-inline-block d-lg-none ms-2">
				<button type="button" class="btn header-item noti-icon waves-effect"
					id="page-header-search-dropdown" data-bs-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">
					<i class="ri-search-line"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0"
					aria-labelledby="page-header-search-dropdown">

					<form class="p-3">
						<div class="mb-3 m-0">
							<div class="input-group">
								<input type="text" class="form-control" placeholder="Search ...">
								<div class="input-group-append">
									<button class="btn btn-primary" type="submit">
										<i class="ri-search-line"></i>
									</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>

			<div class="dropdown d-none d-lg-inline-block ms-1">
				<button type="button" class="btn header-item noti-icon waves-effect"
					data-bs-toggle="fullscreen">
					<i class="ri-fullscreen-line"></i>
				</button>
			</div>

			<!-- 메모 시작 -->
			<div class="dropdown d-inline-block">
				<a href="/memo/selectMemo" class="text-reset notification-item">
					<button type="button"
						class="btn header-item noti-icon waves-effect">
						<i class="ri-file-edit-line"></i>
					</button>
				</a>
			</div>
			<!-- 메모 끝 -->

			<!-- 조직도 시작 -->
			<div class="dropdown d-inline-block">
				<button type="button" class="btn header-item noti-icon waves-effect"
					id="page-header-notifications-dropdown" 
					id="showModal" class="text-reset notification-item" 
							data-toggle="modal" data-target="#jojicdoModal"
					aria-expanded="false">
					<i  class="fas fa-sitemap jojicBtn"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0"
					aria-labelledby="page-header-notifications-dropdown">
					<div class="p-3">
						<div class="row align-items-center">
							<div class="col">
								<h6 class="m-0">조직도</h6>
							</div>
						</div>
					</div>
					<div data-simplebar style="max-height: 230px;">
						<div data-simplebar style="max-height: 150px;">
							<!-- 조직도 내용 들어갈 곳 코딩 시작  -->
							
							
							<!-- 조직도 내용 들어갈 곳 코딩 끝  -->
						</div>
					</div>
				</div>
			</div>

			<!-- 조직도 끝 -->


			<!-- 실시간 알림 시작 -->
			<div class="dropdown d-inline-block">
				<button type="button" class="btn header-item noti-icon waves-effect" id="page-header-notifications-dropdown" data-bs-toggle="dropdown" aria-expanded="false">
					<i class="ri-notification-3-line"></i>
					<span class="badge rounded-pill bg-danger float-end noti-dot" style="display:none;"></span>
				</button>
				<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0" aria-labelledby="page-header-notifications-dropdown">
					<div class="p-3">
						<div class="row align-items-center">
							<div class="col">
								<h6 class="m-0">실시간 알림 정보</h6>
							</div>
						</div>
					</div>
					<div data-simplebar id="notiListId">
				
					</div>
				</div>
			</div>
			<!-- 실시간 알림 끝 -->



			<!-- 마이페이지 시작  -->
			<div class="dropdown d-inline-block user-dropdown">
				<button type="button" class="btn header-item waves-effect"
					id="page-header-user-dropdown" data-bs-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">
					<sec:authentication property="principal.user.atchPath"
						var="atchPath" />
					<img class="rounded-circle header-profile-user" src="${atchPath }"
						alt="Header Avatar">
				</button>
				<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end">
					<div class="p-1" style="margin-left: 30px;">
						<div class="row align-items-center">
							<div class="col">
								<p>
									Name &nbsp;&nbsp;| &nbsp;&nbsp;
									<sec:authentication property="principal.user.empName" />
								</p>
								<!--                                             <i style="float: right;" class="ri-shut-down-line align-middle me-1"></i> -->
							</div>
						</div>
						<div class="row align-items-center">
							<div class="col">
								<p>
									Department &nbsp;&nbsp;| &nbsp;&nbsp;
									<sec:authentication property="principal.user.deptName" />
								</p>
							</div>
						</div>
					</div>
					<div data-simplebar style="max-height: 150px;">
						<!-- item 1 시작-->
						<!-- 개인정보 시작 -->
						<a id="showModal" class="text-reset notification-item" href="#"
							data-toggle="modal" data-target="#mypageModal">
							<div class="d-flex align-items-center">
								<img src="/resources/images/user.png"
									style="width: 40px; height: 40px; margin-right: 20px;" />
								<div class="flex-grow-1 text-truncate">
									<h6 class="mb-1">Profile</h6>
									<p class="mb-0 font-size-12">개인정보를 조회/수정 할 수 있습니다.</p>
								</div>
							</div>
						</a>

						<!-- 개인정보  끝 -->

						<!-- item 2 시작-->
					<!-- 화면 다크모드 라이트모드 설정하는 부분 시작 -->
					<div class="dropdown d-inline-block text-reset notification-item">
						<button type="button"
							class="btn header-item noti-icon right-bar-toggle waves-effect">
							<div class="d-flex align-items-center">
								<img src="/resources/images/setting.png"
										style="width: 30px; height: 30px; margin-right: 20px;" />
								<div class="flex-grow-1 text-truncate">
									<h6 class="mb-1" style="float: left;">Settings</h6><br/>
									<p class="mb-0 font-size-12" style="color: #445990;">화면의 다크모드/라이트모드 설정</p>
								</div>
							</div>
						</button>
					</div>
					<!-- 화면 다크모드 라이트모드 설정하는 부분 끝 -->
					
					
					</div>
					<!-- item 3 시작-->
					<!-- 로그아웃 , 퇴근하기 시작 -->
					<div class="pt-2 border-top">
						<div class="d-grid">
							<form method="get" action="/session/logout">
								<a class="btn btn-sm btn-link font-size-14 text-center"
									style="margin-left: 120px;" href="javascript:void(0)">
									<button type="submit" class="btn btn-outline-primary">Logout</button>
									
								</a>
							</form>
						</div>
					</div>
					<!-- 로그아웃 , 퇴근하기 끝 -->
				</div>
			</div>
			<!-- 마이페이지 끝 -->
		</div>
	</div>
</header>
<!-- Header(bar) 끝 -->

<!-- Modal 시작 -->
<div class="modal fade" id="mypageModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="font-size: 1.8em;">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;My &nbsp;Page</div>
			<div class="modal-body">
				<div id="myTab" class="row mb-3">
					<ul class="nav nav-tabs nav-tabs-custom nav-justified"
						role="tablist">
						<li class="nav-item" id="bigselect"><a
							class="nav-link active" id="myselect" data-bs-toggle="tab"
							href="#home1" role="tab"> <span class="d-block d-sm-none"><i
									class="fas fa-home"></i></span> <span class="d-none d-sm-block">개인정보조회</span>
						</a></li>

						<li class="nav-item" id="bigupdate"><a class="nav-link"
							id="myupdate" data-bs-toggle="tab" href="#profile1" role="tab">
								<span class="d-block d-sm-none"><i class="far fa-user"></i></span>
								<span class="d-none d-sm-block">비밀번호변경</span>
						</a></li>
					</ul>
					
					<!-- 개인정보 조회하는 페이지 시작-->
					<div id="selectpage" style="margin-top:20px;">
						<sec:authentication property="principal.user.atchPath"
							var="atchPath" />
						<img src="${atchPath }" style="float:left; margin-right:20px; width: 170px;height: 230px;">
						<p>
							이름 &nbsp;&nbsp;| &nbsp;&nbsp;
							<sec:authentication property="principal.user.empName" />
						</p>
						<p>
							부서 &nbsp;&nbsp;| &nbsp;&nbsp;
							<sec:authentication property="principal.user.deptName" />
						</p>
						<p>
							주소  &nbsp;&nbsp;| &nbsp;&nbsp;
							<sec:authentication property="principal.user.empAddr1" /><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<sec:authentication property="principal.user.empAddr2" />
						
						</p>
						<p>
							이메일 &nbsp;&nbsp;| &nbsp;&nbsp;
							<sec:authentication property="principal.user.empEmail" />
						</p>
						<p>
							연락처 &nbsp;&nbsp;| &nbsp;&nbsp;
							<sec:authentication property="principal.user.empTel" />
						</p>
						<p>
							생년월일 &nbsp;&nbsp;| &nbsp;&nbsp;
							<sec:authentication property="principal.user.empBirth" var="birth" />
							<fmt:formatDate value="${birth}"  pattern="yyyy / MM / dd "/>
						</p>
					</div>
					<!-- 개인정보 조회하는 페이지 끝 -->
					
					<!-- 비밀번호 변경하는 페이지 시작 -->
					<div id="updatepage" class="updatepage">
						<p style="margin-top:20px;">비밀번호를  변경하시려면 기존 비밀번호를 입력하세요.</p>
						<input type="hidden" id="loginPassword" value="<sec:authentication property="principal.user.password"/>">
						<input id="passwordcheck" type="password" style="margin-right: 10px;" placeholder="비밀번호를 입력하세요" />
						<button class="btn btn-outline-primary waves-effect waves-light" onclick="passwordcheck(this)">확인</button>
					</div >
					<!-- 비밀번호 입력 성공시 -->
					<form  method="post" action="/mypage/updateEmpl" id="form">
						<div id="passwordok" class="passwordok">
							<input type="password" id ="empPassword" 
										placeholder="변경할 비밀번호를 입력하세요" style="width: 100%; margin-top: 20px;"/>
							<button class="btn btn-outline-primary waves-effect waves-light" onclick="passchange(this)"
									type="button" style="margin-top: 10px;float: right;margin-left: 10px;">확인</button>
							<button class="btn btn-outline-primary waves-effect waves-light" 
								    type="reset" style="margin-top: 10px;float: right;" >재입력</button>
						</div>
					</form>
					<!-- 비밀번호 변경하는 페이지 끝 -->
				</div>
			</div>
			<div class="modal-footer"></div>
		</div>
	</div>
</div>
<!-- Modal 끝 -->

<!-- 조직도 모달시작 -->
<div class="modal fade" id="jojicdoModal">
	<div class="modal-dialog">
		<div class="modal-content" style=" background-color:#D9E5FF">
			<div style="font-size: 1.5em; margin-left: 10px;margin-top: 10px;">조직도</div>
			<div class="modal-body">
				<div id="jojicdo">
				
				</div>
			</div>
			<div class="modal-footer"></div>
		</div>
	</div>
</div>

<!-- 조직도 모달 끝 -->

<!-- Header 페이지에 적용될 스크립트 -->
<script>
	function passchange(changedata){
		
		var changedata = $(changedata).parents("#passwordok").find("#empPassword").val();
		console.log(changedata);
		
		$.ajax({
			url : "/mypage/updateEmpl",
			data :{
				"changedata" : changedata
			},
			type : "get",
			success : function(data){
				console.log();
				if(data=="success"){
					alert("비밀번호가 변경되었습니다.");
					$("#mypageModal").modal("hide");
				}else{
					alert("비밀번호 변경 실패");
				}
			},
			error : function(xhr){
				alert("변경과정중 오류발생...")
			},
			dataType : "text"
		});
		
	}

	$("#showModal").on("click", function() {
		$("#mypageModal").modal("show");

	})

	$("#bigselect").on("click", function() {
		$("#selectpage").show();
		$("#updatepage").hide();
		$("#passwordok").hide();
	})

	$("#bigupdate").on("click", function() {
		$("#updatepage").show();
		$("#passwordok").hide();
		$("#selectpage").hide();
	})

	$("#showModal").on("click", function() {
		$("#updatepage").hide();
		$("#passwordok").hide();
		$("#selectpage").show();
	})
	
	function passwordcheck(checkdata){
	 	var passwordcheck=$(checkdata).parents(".updatepage").find("#passwordcheck").val();
		console.log(passwordcheck); //입력한 비밀번호
		var v_pwd = $("#loginPassword").val();  //로그인한 비밀번호 정보

		if(passwordcheck==v_pwd){
			alert("비밀번호가 확인되었습니다.")
			$("#updatepage").hide();
			$("#passwordok").show();
		}else{
			alert("비밀번호가 일치하지 않습니다.")
		}
		
	}
	
	$(function(){
		var token = "${_csrf.token }";
		var header = "${_csrf.headerName }";
		
		$(".jojicBtn").on("click",function(){
			var v_treeBtnValue ="treeAll";
			$.ajax({
				url: "/common/treeList",
				type: "POST",
				contentType : "application/json; charset=utf-8",
				data: JSON.stringify({
					"treeSelect" : v_treeBtnValue
				}),
				success: function(res) {
					console.log(res);
					$("#treeContainer").css("display","block");
					var v_result = "";
					var v_index = 0;
					$.each(res,function(i,v){
						if(v.topDeptId != null && v.topDeptId != 'DEP00'){
							v_result += '	<div href="#tree-item-'+(v_index++)+'" class="list-group-item" data-toggle="collapse" style="padding-left: 1.25rem;" aria-expanded="true">';
							v_result += '		<i class="state-icon fa-angle-down fa"></i>'+v.topDeptName;
							v_result += '	</div>';
							v_result += '	<div class="list-group collapse" id="tree-item-'+(v_index-1)+'" style="">';
							
							$.each(v.deptList,function(i1,v1){
									v_result += '	<div href="#tree-item-'+(v_index++)+'" class="list-group-item" data-toggle="collapse" style="padding-left: 2.5rem;">';
									v_result += '		<i class="state-icon fa fa-angle-right"></i>'+v1.deptName+'';
									v_result += '	</div>';
									v_result += '	<div class="list-group collapse" id="tree-item-'+(v_index-1)+'">';
									$.each(v1.employeeList,function(i2,v2){
										v_result += ' 	<div data-empid="'+v2.empId+'" href="#tree-item-'+(v_index++)+'" class="list-group-item member" data-toggle="collapse" style="padding-left: 3.75rem;">';
										if(v2.empName == null){
											v_result += ' 		(직원 없음)';	
										}else{
											v_result += ' 		'+v2.empName+'('+v2.cmmnGroupName+')';
										}
										v_result += ' 	</div>';
									})
									v_result += ' 	</div>';
							})
							v_result += '	</div>';
						}
					})
					$("#jojicdo").html(v_result);
					
				},
				error: function(xhr) {
					alert(xhr.status)
				},
				beforeSend: function (xhr) {
		                xhr.setRequestHeader(header, token)
				},
				dataType: "json"
			})
		})
	})
</script>
<script type="text/javascript">
	function showNoti(){
	   $.ajax({
	      url:"/noti/notiAjax",
	      type:"GET",
	      contentType : "application/json; charset=utf-8",
	      success:function(res){
	    	  //console.log("받아온리스트 : "+JSON.stringify(res));
	    	  //console.log("ㅇㅇ? : "+JSON.stringify(res.momentNoti));
	    	  //alert("?");
	    	  var v_result = '';
	    	  var v_hours = '';
	    	  var v_date = new Date();
	    	  //console.log("v_date",v_date.getTime());
	    	  if(res.cnt == 0){
	    		  v_result += '<div class="text-reset notification-item notiOne">';
				  v_result += '<div class="d-flex align-items-center">';
				  v_result += '	<div class="flex-grow-1 text-truncate">';
				  v_result += '알림이 없습니다.';
				  v_result += '	</div>';
				  v_result += '</div>';
				  v_result += '</div>';
	    	  }
	    	  
			  $.each(res.notiList,function(i,v){
				  //console.log(i," : ",v);
				  v_notDt = new Date(v.notDt);
				  //console.log(v_date.getTime(), " : ",v_notDt.getTime());
				  // console.log("oo",(v_date.getTime()-v_notDt.getTime())/(1000*60));
				  var v_diff = v_date.getTime()-v_notDt.getTime();
				  if(v_diff/1000 < 60){
				  	  v_hours = ' '+Math.floor(v_diff/1000);
				  	  v_hours += ' 초 전';
				  }else if(v_diff/(1000*60) < 60){
					  v_hours = ' '+Math.floor(v_diff/(1000*60));
					  v_hours += ' 분 전';
				  }else if(v_diff/(1000*60*60) < 24){
					  v_hours = ' '+Math.floor(v_diff/(1000*60*60));
				  	  v_hours += ' 시간 전';
				  }else{
					  v_hours = ' '+Math.floor(v_diff/(1000*60*60*24));
				  	  v_hours += ' 일 전';
				  }
// 				  if(v_date.getTime() == v_notDt.getTime()){
// 					  v_hours = ' '+v_date.getHours() - v_notDt.getHours();
// 					  v_hours += ' 시간 전';
// 				  }else{
// 					  v_hours = ' '+Math.ceil((v_date.getTime()-v_notDt.getTime())/(1000*60*60*24));
// 					  v_hours += ' 일 전';
// 				  }
				  //console.log("notDt1",v_notDt.getHours());
				  //console.log("v_date1",v_date.getHours());
				  //console.log("두개 차이",new Date(v_date-new Date(v.notDt)));
				  v_result += '<div class="text-reset notification-item notiOne">';
				  v_result += '<div class="d-flex align-items-center">';
				  v_result += '	<div class="flex-grow-1 text-truncate">';
				  v_result += '		<h6 class="row mt-0 mb-1">';
				  v_result += '			<span style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">'+v.notSenderName;
				  v_result += '				<span class="mb-1 text-muted fw-normal" >';
				  v_result += '					'+v.notMsg;
				  v_result += '				</span>';
				  v_result += '			</span>';
				  v_result += '		</h6>';
				  v_result += '		<p class="mb-0 font-size-12">';
				  v_result += '			<i class="mdi mdi-clock-outline"></i>'+v_hours;
				  v_result += '		</p>';
				  v_result += '	</div>';
				  v_result += '</div>';
				  v_result += '<input type="hidden" class="thisNotId" value="'+v.notId+'">';
				  v_result += '<input type="hidden" class="thisNotUrl" value="'+v.notUrl+'">';
				  //v_result += '<input type="hidden" class="thisNotCntntId" value="'+v.notCntntId+'">';
				  v_result += '</div>';
				
	        	//alert(data.notSender + " : " + data.notMsg);         
		      })
		      $("#notiListId").html(v_result);
			  
			  if(res.cnt == 0){
				  $(".noti-dot").css("display","none");
			  }else{
				  $(".noti-dot").html(res.cnt);
				  $(".noti-dot").css("display","block");
			  }
			  
			  $(".notiOne").on("click",function(){
				  //console.log(this);
				  var v_thisNotId = $(this).find(".thisNotId").val();
				  var v_thisNotUrl = $(this).find(".thisNotUrl").val();
				  //var v_thisNotCntntId = $(this).find(".thisNotCntntId").val();
				  //console.log("11",v_thisNotId);
				  
				  $.ajax({
					  url:"/noti/notiUpdateAjax",
					  type:"GET",
					  contentType:"application/json; charset=utf-8",
					  data:{
						  "notId":v_thisNotId
					  },
					  success:function(a){}
				  })
				  location.href=v_thisNotUrl;
			  })
			
  			  //$("#momentDiv").fadeIn(1000).delay(1000).fadeOut(1000);
	    	  
			  //console.log("res.momentNoti:",res.momentNoti);
			  if(res.momentNoti != null){
				  //alert("1");
				  var v_msg = res.momentNoti.notTypeId;
				  //console.log("v_msg: "+v_msg);
				  var v_result1 = "";
				  v_result1 += "<input type='hidden' id='notId' name='notId' value='"+res.momentNoti.notId+"'>";
				  v_result1 += "<input type='hidden' id='notUrl' name='notUrl' value='"+res.momentNoti.notUrl+"'>";
					 
				  
						  
				  $("#momentDiv").html(v_msg+" 알림이 도착했습니다.");
				  $("#momentDiv").append(v_result1);
		    	  
				  $("#momentDiv").fadeIn(2000);
		    	  setTimeout(function(){
		    		  $("#momentDiv").fadeOut(2000);
		    	  },7000);
		    	  
		    	  $.ajax({
		    		  url:"/noti/notiUpdateAjax2",
		    		  type:"GET",
		    		  contentType:"application/json; charset=utf-8",
		    		  data:{
		    			  "notId":res.momentNoti.notId
		    		  },
		    		  success:function(a){}
		    	  })
			  }
			  $("#momentDiv").on("click",function(){
				  $(this).fadeOut(2000);
				  
				  var v_thisNotId = $(this).find("#notId").val();
				  var v_thisNotUrl = $(this).find("#notUrl").val();
				  //var v_thisNotCntntId = $(this).find(".thisNotCntntId").val();
				  //console.log("11",v_thisNotId);
				  
				  $.ajax({
					  url:"/noti/notiUpdateAjax",
					  type:"GET",
					  contentType:"application/json; charset=utf-8",
					  data:{
						  "notId":v_thisNotId
					  },
					  success:function(a){}
				  })
				  location.href=v_thisNotUrl;
			  })
	      },
	      dataType:"json"
	   });
	}
// 	window.onload = function(){
//  	   showNoti();
//    	   setInterval(showNoti,1000);
// 	} 
	
	//모달에서 뒤에 검정배경 없애기 위해 추가하는 코드 
	$(function(){
		$('#mypageModal').on('hide.bs.modal', function (e) {
		    $(".modal-backdrop").remove();
		})
	})
</script>

