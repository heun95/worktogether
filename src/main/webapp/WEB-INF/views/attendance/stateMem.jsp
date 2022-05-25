<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<!-- pdf 파일 다운로드 -->
<script src="/resources/dist/assets/libs/pdfmake/build/pdfmake.min.js"></script>
<script src="/resources/dist/assets/libs/pdfmake/build/vfs_fonts.js"></script>

<!-- 조직도에 필요한 CSS와 JS  -->
<link href="/resources/css/bstreeview.min.css" rel="stylesheet"
	type="text/css" />
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>

<style>
.year_mon {
	font-size: 30px;
}

th {
	height: 50px;
	width: 70px;
}

td {
	text-align: center;
	height: 150px;
	width: 70px;
}

input {
	height: 40px;
	width: 40px;
	border: none;
	font-size: 20px;
}

.colToday {
	background-color: #B4C3FF;
}
</style>

<sec:authentication property="principal.user" var="user" />
<input type="hidden" id="userId" value="${user.username }">
<input type="hidden" id="userPhoto" value="${user.atchPath }">
<input type="hidden" id="token" value="${_csrf.token }">
<input type="hidden" id="header" value="${_csrf.headerName }">

<div class="card">
	<div class="card-body">
		<div
			class="page-title-box d-flex align-items-center justify-content-between">
			<h4 class="mb-0">
				<a href="/attendance/state">근태현황</a>
			</h4>

			<div class="page-title-right">
				<button type="button"
					class="btn btn-sm btn-light waves-effect waves-light">
					<a href="/attendance/state">나의 근태</a>
				</button>
				<button type="button"
					class="btn btn-sm btn-light waves-effect waves-light">
					<a href="/attendance/stateMem">사원 근태</a>
				</button>
			</div>
		</div>

		<%-- <form:form modelAttribute="atndnDlyVO" method="get" --%>
		<%--  action="/attendance/state"> --%>
		<%-- 		<p>${atndnDlyVO}</p> --%>
		<%-- </form:form> --%>

		<div align="left" style="float: left">
			<button class="btn btn-sm btn-light" style="cursor: default"
				type="button">퇴근</button>
			<button class="btn btn-sm btn-primary" style="cursor: default"
				type="button">
				<span style="position: relative">재택</span>
			</button>
			<button class="btn btn-sm btn-secondary" style="cursor: default"
				type="button">외근</button>
			<button class="btn btn-sm btn-success" style="cursor: default"
				type="button">연차</button>
			<button class="btn btn-sm btn-info" style="cursor: default"
				type="button">휴가</button>
			<button class="btn btn-sm btn-warning" style="cursor: default"
				type="button">지각/조퇴</button>
			<button class="btn btn-sm btn-danger" style="cursor: default"
				type="button">결근</button>
		</div>


		<div align="right" style="float: right">
			<c:if test="${selectEmpName == null }">
			<label>선택된 사원 : ${employeeVO.empName} (사원번호 : ${atndnDlyVO.empId})</label>&nbsp;&nbsp;
			</c:if>
			<c:if test="${selectEmpName != null }">
			<label>선택된 사원 : ${selectEmpName} (사원번호 : ${selectEmpId})</label>&nbsp;&nbsp;
			</c:if>
			
			
			<button type="button" data-bs-toggle="modal"
				data-bs-target="#insertModal"
				class="btn btn-sm btn-light waves-effect waves-light"
				id="insertReason">사원선택</button>
		</div>

		<!-- Modal -->
		<div class="modal fade" id="insertModal" tabindex="-1"
			aria-labelledby="modalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<%-- 					<form:form modelAttribute="atndnDlyVO" method="post" --%>
					<%-- 						action="/project/projInsert"> --%>
					<div class="modal-header">
						<h6 class="modal-title">조직도를 조회하여 사원을 선택하세요</h6>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div align="center">
							<button type="button" class="treeBtn" value="treeSome"
								style="border: none;">직원 조직도 조회</button>
							<button type="button" class="treeBtn" value="treeAll"
								style="border: none; display: none;">조직도 조회(전부)</button>
						</div>
						<div class="container" id="treeContainer" style="display: none;">
							<br>
							<div>
								<div>
									<div id="tree" class="bstreeview"></div>
								</div>
							</div>
						</div>
					</div>
<!-- 					<div class="modal-footer"> -->
<!-- 						<button type="button" class="btn btn-secondary" -->
<!-- 							data-bs-dismiss="modal">취소</button> -->
<!-- 						<button type="submit" id="okBtn" class="btn btn-primary">사원선택</button> -->
<!-- 					</div> -->
					<sec:csrfInput />
					<%-- 					</form:form> --%>
				</div>
			</div>
		</div>
		<!-- Modal End -->

		<br> <br> <br>

		<div class="card">
			<div class="card-body">
				<div class="table-responsive">
					<table class="table mb-0" id="calendar">
						<thead align="center">
							<tr>
								<th><input name="preMon" type="button" value="<"></th>
								<th colspan="5" class="year_mon"></th>
								<th><input name="nextMon" type="button" value=">"></th>
							</tr>
							<tr style="font-size: 15px;">
								<th>일</th>
								<th>월</th>
								<th>화</th>
								<th>수</th>
								<th>목</th>
								<th>금</th>
								<th>토</th>
							</tr>
						</thead>
						<tbody align="center">
						</tbody>
					</table>
					<br>
				</div>
			</div>
		</div>
<!-- 		<div align="right"> -->
<!-- 			<div class="dt-buttons btn-group flex-wrap"> -->
<!-- 				<button class="btn btn-secondary buttons-pdf buttons-html5 " -->
<!-- 					tabindex="0" aria-controls="datatable-buttons" type="button"> -->
<!-- 					<span>PDF 출력하기</span> -->
<!-- 				</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
	</div>
</div>
<script>
        $(function(){
            var today = new Date();
            var date = new Date();   
            
            var token = $("#token").val();
        	var header = $("#header").val();

            $("input[name=preMon]").click(function() { // 이전달
                $("#calendar > tbody > td").remove();
                $("#calendar > tbody > tr").remove();
                today = new Date ( today.getFullYear(), today.getMonth()-1, today.getDate());
                buildCalendar();
            })
            
            $("input[name=nextMon]").click(function(){ //다음달
                $("#calendar > tbody > td").remove();
                $("#calendar > tbody > tr").remove();
                today = new Date ( today.getFullYear(), today.getMonth()+1, today.getDate());
                buildCalendar();
            })
			
            buildCalendar();

            function buildCalendar() {
            	//console.log('check'); //중호 주석
            	nowYear = today.getFullYear();
                nowMonth = today.getMonth();
                firstDate = new Date(nowYear,nowMonth,1).getDate();
                firstDay = new Date(nowYear,nowMonth,1).getDay(); //1st의 요일
                lastDate = new Date(nowYear,nowMonth+1,0).getDate();
            	
                //alert(nowYear+":"+nowMonth);
            	$.ajax({
            		type: 'post',
            		dataType: 'text',
            		url: '/attendance/stateMem_ajax',
            		data:{
            			year: nowYear,
            			month: nowMonth,
            			selectEmpId : "${selectEmpId}"
            		}, 
            		beforeSend: function (xhr) {
                        xhr.setRequestHeader(header, token)
                    },
            		error: function(){
            			console.log('error');
            		},
            		success: function(data){ //data는 아무이름이나 가능. success해서 list가 넘어온 것
            			//console.log(data); //중호 주석
		            	var v_datas = JSON.parse(data);
		            	var v_atndnTypeId = $("#atndnTypeId").val();
// 		            	var v_datas = data;

//						DB에서 이런 데이터를 가져왔다고 가정, DB에서 VO 타입 지정해서 가정와야 함
// 		            	// List<VO>
// 		            	var v_datas = [
// 		            		{date:7,start:"10:00",end:"12:00"},  // VO
// 		            		{date:11,start:"11:00",end:"13:00"},
// 		            		{date:20,start:"12:00",end:"14:00"},
// 		            		{date:25,start:"15:00",end:"15:00"},
// 		            		{date:26,start:"09:00",end:"16:00"},
// 		            		{date:30,start:"13:00",end:"17:00"}            		
// 		            	];

            			if((nowYear%4===0 && nowYear % 100 !==0) || nowYear%400===0) { //윤년 적용
                            lastDate[1]=29;
                        }

                        $(".year_mon").text(nowYear+"년 "+(nowMonth+1)+"월");

                        for (i=0; i<firstDay; i++) { //첫번째 줄 빈칸
                            $("#calendar tbody:last").append("<td></td>");
                        }
                        for (i=1; i <=lastDate; i++){ // 날짜 채우기
                            plusDate = new Date(nowYear,nowMonth,i).getDay();
                            if (plusDate==0) {
                                $("#calendar tbody:last").append("<tr></tr>");
                            }
                            
                            var v_is = false;  // 이미 넣은 날짜를 또 넣지 않기 위해서 선언, 일단 없다고 가정
                            for(var j=0; j< v_datas.length; j++){
                            	if(i == v_datas[j].date){
                            		console.log("i : " + i + ", v_datas[j].date : " + v_datas[j].date);
                            		//그냥 이것으로 하장!
                            		let icon = "";
                            		if( v_datas[j].atndnTypeId =='late'){
                            			icon = "<input type='button' style='cursor:default; font-size:13px; background-color:orange; width:60px; border-radius:5px;' value='지각'/>";
                            		}else if(v_datas[j].atndnTypeId =='earlyLeave'){
                            			
                            			icon = "<input type='button' style='cursor:default; font-size:13px; background-color:orange; width:60px; border-radius:5px;' value='조퇴'/>";
//                             			icon = "<button class='btn btn-sm btn-warning' style='cursor:default; active:none;' type='button'>조퇴</button>";
                            		}else if(v_datas[j].atndnTypeId =='leave'){
                            			icon = "<input type='button' style='cursor:default; font-size:13px; background-color:#eff2f7; width:60px; border-radius:5px;' value='퇴근'/>";
                            		}else if(v_datas[j].atndnTypeId =='home'){
                            			icon = "<input type='button' style='cursor:default; font-size:13px; background-color:#7878FF; width:60px; border-radius:5px;' value='재택'/>";
                            		}else if(v_datas[j].atndnTypeId =='out'){
                            			icon = "<input type='button' style='cursor:default; font-size:13px; background-color:lightgray; width:60px; border-radius:5px;' value='외근''/>";
                            		}else if(v_datas[j].atndnTypeId =='annual'){
                            			icon = "<input type='button' style='cursor:default; font-size:13px; background-color:#68D168; width:60px; border-radius:5px;' value='연차'/>";
                            		}else if(v_datas[j].atndnTypeId =='vacation'){
                            			icon = "<input type='button' style='cursor:default; font-size:13px; background-color:#46AAFF; width:60px; border-radius:5px;' value='휴가'/>";
                            		}else if(v_datas[j].atndnTypeId =='attendance'){
                            			icon = "<input type='button' style='cursor:default; font-size:13px; background-color:#FF5A5A; width:60px; border-radius:5px;' value='출근'/>";
                            		}
                            		
                            		let reason = v_datas[j].atndnDlyRsn;
                            		if(v_datas[j].atndnDlyRsn == null ){
                            			reason = "";
                            		}
                            		
                            		var v_result = ""; 
                            		v_result += "<td class='date'>"+"<strong style='font-size:14px;'>" + i + "</strong>";
                            		v_result += "<br>" + icon;
                            		//지각, 조퇴, 퇴근에만 표시함 시작---------------------
                            		if(  v_datas[j].atndnTypeId == 'attendance' ||v_datas[j].atndnTypeId =='late' || v_datas[j].atndnTypeId =='earlyLeave' || v_datas[j].atndnTypeId =='leave'){
	                            		v_result += "<br>출근:"+ v_datas[j].start;
	                            		//console.log("아아아 : "+v_datas[j].end); //중호 주석
	                            		if(v_datas[j].end == ""){
	                            			
	                            		}else{
	                            			v_result += "<br>퇴근:"+ v_datas[j].end;
	                            		}
                            		}//end outer if
                            		//지각, 조퇴, 퇴근에만 표시함 시작---------------------
                            		v_result += "<br>"+ reason;
                            		v_result += "</td>";
//                             		+"<br>"+ v_datas[j].atndnDlyRsn
                            		
                            		
                            		$("#calendar tbody:last").append(v_result); 
                            		v_is = true;  // 해당 날짜 넣었다는 표시
                                    break;
                            	}
                            }
                            if(!v_is){  // 없으면 넣기
                            	$("#calendar tbody:last").append("<td class='date'>"+ i +"</td>");
                            }
                           
                        }
                        if($("#calendar > tbody > td").length%7!=0) { //마지막 줄 빈칸
                            for(i=1; i<= $("#calendar > tbody > td").length%7; i++) {
                                $("#calendar tbody:last").append("<td></td>");
                            }
                        }
                        $(".date").each(function(index){ // 오늘 날짜 표시
                            if(nowYear==date.getFullYear() && nowMonth==date.getMonth() && $(".date").eq(index).text()==date.getDate()) {
                                $(".date").eq(index).addClass('colToday');
                            }
                        }) 
            		}
            	});
            };
        });
    </script>

<script>
$(function(){
	var token = "${_csrf.token }";
	var header = "${_csrf.headerName }";
	
	$(".treeBtn").on("click",function(){
		var v_treeBtnValue = $(this).val();
		$.ajax({
			url: "/common/treeList",
			type: "POST",
			contentType : "application/json; charset=utf-8",
			data: JSON.stringify({
				"treeSelect" : v_treeBtnValue
			}),
			success: function(res) {
// 				console.log(res);
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
									//console.log("v2 : ",v2);
									v_result += ' 	<div href="#tree-item-'+(v_index++)+'" class="list-group-item v2class" data-toggle="collapse" style="padding-left: 3.75rem;">';
									if(v2.empName == null){
										v_result += ' 		(직원 없음)';	
									}else{
										v_result += ' 		'+v2.empName+'('+v2.cmmnGroupName+')';
									}
									v_result += '		<input type="hidden" class="hiddenEmpId" value="'+v2.empId+'">';
									v_result += '		<input type="hidden" class="hiddenEmpName" value="'+v2.empName+'">';

									v_result += ' 	</div>';
								})
								v_result += ' 	</div>';
						})
						v_result += '	</div>';
					}
				})
				$("#tree").html(v_result);
				
				$(".v2class").on("click",function(){
					var v_hiddenEmpId = $(this).find(".hiddenEmpId").val();
					var v_hiddenEmpName = $(this).find(".hiddenEmpName").val();
					
					location.href = "/attendance/stateMem?selectEmpId="+v_hiddenEmpId+"&selectEmpName="+v_hiddenEmpName;

				});
				
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
