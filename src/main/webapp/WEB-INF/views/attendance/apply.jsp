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

<sec:authentication property="principal.user" var="user" />
<input type="hidden" id="userId" value="${user.username }">
<input type="hidden" id="userPhoto" value="${user.atchPath }">
<input type="hidden" id="token" value="${_csrf.token }">
<input type="hidden" id="header" value="${_csrf.headerName }">

<style>
.year_mon {
	font-size: 30px;
}

#calendar th {
	height: 50px;
	width: 70px;
}

#calendar td {
	text-align: center;
	height: 100px;
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

#checkBox .form-check-label {
	margin-top: 0.35em;
}
</style>


<div class="card">
	<div class="card-body">
		<div
			class="page-title-box d-flex align-items-center justify-content-between">
			<h4 class="mb-0">
				<a href="/attendance/apply">근태신청</a>
			</h4>
			<div class="page-title-right">
				<button type="button"
					class="btn btn-sm btn-light waves-effect waves-light">
					<a href="/attendance/apply">나의 신청현황</a>
				</button>
				<sec:authorize access="hasRole('ROLE_BUJANG')">
					<button type="button"
						class="btn btn-sm btn-light waves-effect waves-light">
						<a href="/attendance/applyMem">사원의 신청현황</a>
					</button>
				</sec:authorize>
			</div>
		</div>
		<div align="right" style="float: right">
			<button type="button" data-bs-toggle="modal"
				data-bs-target="#insertModal"
				class="btn btn-sm btn-light waves-effect waves-light" id="ajax-home">근태신청
				작성</button>
			<button type="button" data-bs-toggle="modal"
				data-bs-target="#listModal"
				class="btn btn-sm btn-primary waves-effect waves-light"
				id="ajax-home">근태신청 목록</button>
		</div>
		<br>

		<!-- 근태신청 목록 Modal -->
		<div class="modal fade" id="listModal" tabindex="-1"
			aria-labelledby="modalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">신청내역</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div>
							<c:forEach var="vo" items="${list}" varStatus="status">
								<tr>
									<td>근태신청종류 : <c:if test="${vo.atndnTypeId == 'out'}">
											외근
										</c:if> <c:if test="${vo.atndnTypeId == 'vacation'}">
											휴가
										</c:if> <c:if test="${vo.atndnTypeId == 'home'}">
											재택
										</c:if> <c:if test="${vo.atndnTypeId == 'annual'}">
											연차
										</c:if>
									</td>
									<br>
									<td>신청기간 : <fmt:formatDate pattern="yyyy-MM-dd"
											value="${vo.atndnStrtDt}" /> ~ <fmt:formatDate
											pattern="yyyy-MM-dd" value="${vo.atndnEndDt}" /></td>
								</tr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%-- 								<input type="hidden" id="deleteId" value="${vo.atndnAplctId}"/> --%>
								<button type="button" id="deleteBtn"
									class="btn btn-sm btn-danger btn-primary"
									onclick="deleteBtn('${vo.atndnAplctId}')">삭제</button>
								<br>
								<br>
							</c:forEach>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
		<sec:csrfInput />
		<!-- Modal End -->

		<!-- 근태신청 작성 Modal -->
		<form:form modelAttribute="atndnAplictVO" method="post"
			action="/attendance/apply">
			<div class="modal fade" id="insertModal" tabindex="-1"
				aria-labelledby="modalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">신청하기</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form:input class="form-control" type="hidden"
								path="atndnAplctRqstr" />
							<div class="row mb-3">
								<label for="example-date-input" class="col-sm-4 col-form-label">신청
									시작일자</label>
								<div class="col-sm-8">
									<form:input class="form-control" type="date" path="atndnStrtDt" />
								</div>
							</div>
							<div class="row mb-3">
								<label for="example-date-input" class="col-sm-4 col-form-label">신청
									마감일자</label>
								<div class="col-sm-8">
									<form:input class="form-control" type="date" path="atndnEndDt" />
								</div>
							</div>
							<div class="row mb-3">
								<label for="example-text-input" class="col-sm-4 col-form-label">신청
									종류</label>
								<div class="col-sm-8">
									<div id="checkBox">
										<input type='checkbox' class="form-check-input"
											name='atndnTypeId' value='home' id='atndnTypeIdHome'
											onclick='checkOnlyOne(this)' /> <label
											class="form-check-label" for="atndnTypeIdHome">
											재택근무&nbsp;&nbsp; </label> <input type='checkbox'
											class="form-check-input" name='atndnTypeId'
											id='atndnTypeIdOut' value='out' onclick='checkOnlyOne(this)' />
										<label class="form-check-label" for="atndnTypeIdOut">
											외근&nbsp;&nbsp; </label> <input type='checkbox'
											class="form-check-input" name='atndnTypeId'
											id='atndnTypeIdAnnual' value='annual'
											onclick='checkOnlyOne(this)' /><label
											class="form-check-label" for="atndnTypeIdAnnual">
											연차&nbsp;&nbsp; </label> <input type='checkbox'
											class="form-check-input" name='atndnTypeId'
											id='atndnTypeIdVacation' value='vacation'
											onclick='checkOnlyOne(this)' /> <label
											class="form-check-label" for="atndnTypeIdVacation">
											휴가&nbsp;&nbsp; </label>
									</div>
								</div>
							</div>
							<div class="row mb-3">
								<label for="example-text-input" class="col-sm-4 col-form-label">신청
									내용</label>
								<div class="col-sm-8">
									<form:textarea placeholder="내용을 입력하세요" class="form-control"
										path="atndnAplctRsn" id="atndnAplctRsn" name="atndnAplctRsn"
										rows="10" value="${atndnAplictVO.atndnAplctRsn}"></form:textarea>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
							<button type="submit" id="submitBtn" class="btn btn-primary">제출하기</button>
						</div>
						<sec:csrfInput />
					</div>
				</div>
			</div>
			<sec:csrfInput />
		</form:form>
		<!-- Modal End -->

		<br> <br>
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
							<tr>
								<th>일</th>
								<th>월</th>
								<th>화</th>
								<th>수</th>
								<th>목</th>
								<th>금</th>
								<th>토</th>
							</tr>
						</thead>
						<tbody align="center" id="tbody">
						</tbody>
					</table>
					<br>
				</div>
			</div>
		</div>
		<br>
		<div class="card">
			<div class="card-body">
				<h5 style="color: red">
					<strong>연차 한 눈에 보기</strong>
				</h5>
				<div class="table-responsive">
					<table class="table table-bordered mb-0">
						<thead style="text-align: center;">
							<tr>
								<th>잔여 연차</th>
								<th>사용 연차</th>
								<th>총 연차</th>
							</tr>
						</thead>
						<tbody style="text-align: center;">
							<tr>
								<td scope="row">3</td>
								<td>1</td>
								<td>4</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<br>
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">연차 발생내역</h4>
				<div class="table-responsive">
					<table class="table table-bordered mb-0">
						<thead style="text-align: center;">
							<tr>
								<th>등록일</th>
								<th>등록자</th>
								<th>발생연차일</th>
								<th>연차발생사유</th>
							</tr>
						</thead>
						<tbody style="text-align: center;">
							<%-- 							<c:forEach var="" items="${}"> --%>
							<tr>
								<td scope="row">2022/01/01</td>
								<td>인사관리자</td>
								<td>1일</td>
								<td>근로보상</td>
							</tr>
							<tr>
								<td scope="row">2022/02/01</td>
								<td>인사관리자</td>
								<td>1일</td>
								<td>근로보상</td>
							</tr>
							<tr>
								<td scope="row">2022/03/01</td>
								<td>인사관리자</td>
								<td>1일</td>
								<td>근로보상</td>
							</tr>
							<tr>
								<td scope="row">2022/04/01</td>
								<td>인사관리자</td>
								<td>1일</td>
								<td>근로보상</td>
							</tr>
							<%-- 							</c:forEach> --%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<br>
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">연차 사용내역</h4>
				<div class="table-responsive">
					<table class="table table-bordered mb-0">
						<thead style="text-align: center;">
							<tr>
								<th>이름</th>
								<th>부서명</th>
								<th>연차 사용기간</th>
								<th>사용 연차</th>
							</tr>
						</thead>
						<tbody style="text-align: center;">
							<%-- 							<c:forEach var="" items="${}"> --%>
							<tr>
								<td scope="row">${employeeVO.empName}</td>
								<td>${deptName }</td>
								<td>2022/04/29 ~ 2022/04/29</td>
								<td>1</td>
							</tr>
							<%-- 							</c:forEach> --%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function checkOnlyOne(element) {
	  
	  const checkboxes 
	      = document.getElementsByName("atndnTypeId");
	  
	  checkboxes.forEach((cb) => {
	    cb.checked = false;
	  })
	  
	  element.checked = true;
	}
</script>

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
                
                nowYear = today.getFullYear();
                nowMonth = today.getMonth();
                firstDate = new Date(nowYear,nowMonth,1).getDate();
                firstDay = new Date(nowYear,nowMonth,1).getDay(); //1st의 요일
                lastDate = new Date(nowYear,nowMonth+1,0).getDate();

                $.ajax({
            		type: 'post',
            		dataType: 'text',
            		url: '/attendance/apply_ajax',
            		data:{
            			year: nowYear,
            			month: nowMonth
            		}, 
            		beforeSend: function (xhr) {
                        xhr.setRequestHeader(header, token)
                    },
            		error: function(){
            			console.log('error');
            		},
            		success: function(data){ //data는 아무이름이나 가능. success해서 list가 넘어온 것
		            	var v_datas = JSON.parse(data);
            			console.log(v_datas);
		            	var v_atndnTypeId = $("#atndnTypeId").val();
		            	var v_atndnAplctRsn = $("#atndnAplctRsn").val();
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
                            var plusDate = new Date(nowYear,nowMonth,i).getDay();
                            var nowDate = new Date(nowYear,nowMonth,i);
                        
                        if (plusDate==0) {
                                $("#calendar tbody:last").append("<tr></tr>");
                            }
                            
                            var v_is = false;  // 이미 넣은 날짜를 또 넣지 않기 위해서 선언, 일단 없다고 가정
                            
                            for(var j=0; j< v_datas.length; j++){
                            	var startDate = new Date(v_datas[j].atndnStrtDt);
                            	var endDate = new Date(v_datas[j].atndnEndDt);
                            	
                            	
                            	if((nowDate >= startDate && nowDate <= endDate)){
                            		
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
                            		
                            		let reason = v_datas[j].atndnAplctRsn;
                            		if(v_datas[j].atndnAplctRsn == null ){
                            			reason = "";
                            		}
                            		
                            		var v_result = ""; 
                            		v_result += "<td class='date'>"+"<strong style='font-size:14px;'>" + i + "</strong>";
                            		v_result += "<br>" + icon;
//                             		v_result += "<br>출근:"+ v_datas[j].start;
//                             		console.log("아아아 : "+v_datas[j].end);
//                             		if(v_datas[j].end == ""){
                            			
//                             		}else{
//                             			v_result += "<br>퇴근:"+ v_datas[j].end;
//                             		}
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
         }
      })
    </script>

<script>
function deleteBtn(a){
	location.href = "/attendance/apply?deleteId="+a;
}

</script>