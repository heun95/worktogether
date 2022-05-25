<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!-- CKEDITOR -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<!-- 플러그인 참조 -->
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.js"></script>
<script src="http://cdn.ckeditor.com/4.4.7/standard/ckeditor.js"></script>

<!-- Bootstrap Tree(조직도) -->
<link href="/resources/css/bstreeview.min.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<script src="/resources/js/html2canvas.js"></script>

<!-- 커스텀 CSS -->
<link rel="stylesheet" href="/resources/css/autho.css" type="text/css"/>

<style>
#j-table{
	border-color: black;
	border-style: dashed;
}
#j-table tr td{
	width: 20px;
}
.j-td{
	height: 100px;
}
.j-input-text{
	width: 100%;
	height: 100%;
	background: #e8edf2;
	border: 0px solid #e8edf2;
}
.j-input-text:focus{
	outline: none;
}
.cke_contents{
	min-height: 900px;
	min-width: 650px;
}
.modal-dialog{
	min-width: 600px;
}
.modal-content{
	min-height: 800px;
}
#i1{
 	width: 50px;
}
.j-divHover:hover{
	background: #eff2f7;
}
</style>

<div class="row m-1">
	<h3 class="h3 mb-2 text-gray-800" style="color: #6c6ff5">임시보관함</h3>
</div>

<div class="row m-1">
	<div class="card overflow-hidden card-h-100 ">
		<div class="card-body" id="j-card">
			<form:form id="j-form" modelAttribute="atrzDocVO" method="post" action="/autho/tempDocUpdate">
				<form:hidden path="docId" value="${docId}"/>
				<div class="row gx-10 mb-3">
					<div class="col-md-3">
						<div class="mb-3">
							<label for="docTypeId" class="form-label">문서종류</label>
							<form:select path="docTypeId" class="form-select" onchange="f_selectChange(this.value)">
								<option value="">선택</option>
								<form:option value="A101" label="기안서"/>
								<form:option value="A102" label="품의서"/>
								<form:option value="A103" label="지출결의서"/>
								<form:option value="A104" label="회의록"/>
							</form:select>
							<form:hidden path="docTypeName" value=""/>
						</div>
					</div>
					<div class="col-md-2">
						<div class="mb-3">
							<label for="docRetention" class="form-label">보존연한</label> 
							<form:select path="docRetention" class="form-select">
								<option value="">선택</option>
								<form:option value="A401" label="1년"/>
								<form:option value="A402" label="3년"/>
								<form:option value="A403" label="5년"/>
								<form:option value="A404" label="10년"/>
								<form:option value="A405" label="영구"/>
							</form:select>
						</div>
					</div>
		            <p id="empName" style="display:none"><sec:authentication property='principal.user.empName'/></p>
					<div class="col-md-2">
						<div class="mb-3">
							<label for="docWrtrName" class="form-label">작성자</label> 
							<form:input path="docWrtrName" class="form-control" value=""/>
						</div>
					</div>
					<script>
					  document.getElementById("docWrtrName").value = document.getElementById("empName").innerHTML;
					</script>
		           
		            <p id="deptName" style="display:none"><sec:authentication property='principal.user.deptName'/></p>
					<div class="col-md-2">
						<div class="mb-3">
							<label for="docDeptName" class="form-label">부서명</label> 
							<form:input path="docDeptName" class="form-control" value=""/>
						</div>
					</div>
					<script>
					  document.getElementById("docDeptName").value = document.getElementById("deptName").innerHTML;
					</script>
					
					<div class="col-md-2">
						<div class="mb-3">
							<label for="tempDocState" class="form-label">문서상태</label> 
							<input id="tempDocState" class="form-control" value="${atrzDocVO.docState}"/>
						</div>
					</div>
					
				</div>
			
	
	
				<div class="row mb-0">
					<div class="col-sm-12">
						<label class="form-label">결재선등록</label>
						<label class="form-label mx-3">
							<button type="button" class="btn btn-outline-primary waves-effect waves-light" 
							data-bs-toggle="modal" data-bs-target="#myModal"
							id="j-modBtn">등록하기</button>
						</label>
					</div>
				</div>
				
				<div class="row mb-4">
					<div class="col-sm-12">
					<table class="table mb-0 table-bordered border-primary align-middle text-center" id="j-table">
		                <tr>
		                    <td style="width:10%;" rowspan="3" class="col-md-1 table-primary">결재</td>
		                    <td class="table-secondary">
		                    	<input name="atrzLineDetailPositionName" type="text" value="" id="atrzPosi-1" class="j-input-text" readonly>
		                    </td>
		                    <td class="table-secondary">
		                    	<input name="atrzLineDetailPositionName" type="text" value="" id="atrzPosi-2" class="j-input-text" readonly>	
		                    </td>
		                    <td class="table-secondary">
		                    	<input name="atrzLineDetailPositionName" type="text" value="" id="atrzPosi-3" class="j-input-text" readonly>
		                    </td>
		                    <td class="table-secondary">
		                    	<input name="atrzLineDetailPositionName" type="text" value="" id="atrzPosi-4" class="j-input-text" readonly>
		                    </td>
		                    <td class="table-secondary">
		                    	<input name="atrzLineDetailPositionName" type="text" value="" id="atrzPosi-5" class="j-input-text" readonly>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="j-td"></td>
		                    <td></td>
		                    <td></td>
		                    <td></td>
		                    <td></td>
		                </tr>
		                <tr>
		                    <td class="table-secondary">
		                    	<input name="atrzName" type="text" value="" id="atrzName-1" class="j-input-text" readonly>
		                    	<input name="atrzLineDetailId" type="hidden" value="" id="atrzLineId-1">
		                    	<input name="atrzLineDetailDeptName" type="hidden" value="" id="atrzLineDeptName-1">
		                    </td>
		                    <td class="table-secondary">
		                    	<input name="atrzName" type="text" value="" id="atrzName-2" class="j-input-text" readonly>
		                    	<input name="atrzLineDetailId" type="hidden" value="" id="atrzLineId-2">
		                    	<input name="atrzLineDetailDeptName" type="hidden" value="" id="atrzLineDeptName-2">
		                    </td>
		                    <td class="table-secondary">
		                    	<input name="atrzName" type="text" value="" id="atrzName-3" class="j-input-text" readonly>
		                    	<input name="atrzLineDetailId" type="hidden" value="" id="atrzLineId-3">
		                    	<input name="atrzLineDetailDeptName" type="hidden" value="" id="atrzLineDeptName-3">
		                    </td>
		                    <td class="table-secondary">
		                    	<input name="atrzName" type="text" value="" id="atrzName-4" class="j-input-text" readonly>
		                    	<input name="atrzLineDetailId" type="hidden" value="" id="atrzLineId-4">
		                    	<input name="atrzLineDetailDeptName" type="hidden" value="" id="atrzLineDeptName-4">
		                    </td>
		                    <td class="table-secondary">
		                    	<input name="atrzName" type="text" value="" id="atrzName-5" class="j-input-text" readonly>
		                    	<input name="atrzLineDetailId" type="hidden" value="" id="atrzLineId-5">
		                    	<input name="atrzLineDetailDeptName" type="hidden" value="" id="atrzLineDeptName-5">
		                    </td>
		                </tr>
			        </table>
			        <input name="atrzLineMap" type="hidden" id="atrzLineMap" value=""> 
			        </div>
		        </div>
				<div class="row mb-3">
					<div class="col-sm-1">
						<label for="docTitle" class="col-form-label">제목</label>
					</div>
					<div class="col-sm-11">
						<form:input path="docTitle" class="form-control" />
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-sm-12">
						<form:textarea path="docCntnt" class="ckeditor" rows="50" ></form:textarea>				
					</div>
				</div>
				<div class="row mb-3">
					<div class="com-sm-12">
						<button type="button" class="btn btn-outline-primary form-control j-btn" value="대기중">작성완료</button>
					</div>
				</div>
				<div class="row mb-3">
					<div class="com-sm-12">
						<button type="button" class="btn btn-outline-info form-control j-btn" value="임시저장">임시저장</button>
					</div>
				</div>
				<div class="row mb-3">
					<div class="com-sm-12">
						<button type="button" class="btn btn-outline-danger form-control" id="j-cancelBtn" value="취소">취소</button>
					</div>
				</div>
				<p id="secEmpId" style="display:none"><sec:authentication property='principal.user.username'/></p>
		      	<form:hidden path="docWrtr" value="" required=""/>
				<script>
				   document.getElementById("docWrtr").value = document.getElementById("secEmpId").innerHTML;
				</script>
				<form:hidden path="docState" value=""/>
				<form:hidden path="docContentPath" value=""/>
			</form:form>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-sm-6 col-md-4 col-xl-3">
		<!-- sample modal content -->
		<div id="myModal" class="modal fade" tabindex="-1"
			aria-labelledby="myModalLabel" style="display: none;"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="myModalLabel">결재선 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="row px-3 ">
							<div class="col-sm-6">
						        <div class="col">
									<div id="tree" class="bstreeview rounded-3 border-secondary"></div>
								</div>
							</div>
							<div class="col-sm-1"></div>
							<div class="col-sm-5">
								<div class="col border rounded-3 border-secondary" id="j-atrz" style="height: 208px; font-size: 0.9rem; color: black;"></div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default waves-effect waves-light"
							data-bs-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-info waves-effect waves-light" id="j-modReset">초기화</button>
						<button type="button" id="j-save" class="btn btn-primary waves-effect waves-light" data-bs-dismiss="modal">저장하기</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
	</div>
</div>
<input type="hidden" value="<sec:authentication property='principal.user.empPosition'/>" id="loginEmpPosition">
<script>
//tempDocDetail(ONLY) 
$(function(){
	$("#j-cancelBtn").on("click",function(){
		location.href = "/autho/tempDoc";
	})
})
</script>

<script>
//조직도
$(function(){
	
	var v_list = [];
	var loginEmpPosition = $("#loginEmpPosition").val();
	var v_positionList = [];
	var v_envIndex = 1;
	var v_startIndex = 1;
	
//결재선 불러오기(Page) 시작 --------------------------------
	//결재자 직급명
	var v_positionName1 = "${atrzDocVO.atrzLineDetailList[0].positionName}";
	var v_positionName2 = "${atrzDocVO.atrzLineDetailList[1].positionName}";
	var v_positionName3 = "${atrzDocVO.atrzLineDetailList[2].positionName}";
	var v_positionName4 = "${atrzDocVO.atrzLineDetailList[3].positionName}";
	var v_positionName5 = "${atrzDocVO.atrzLineDetailList[4].positionName}";
	
	$("#atrzPosi-1").val(v_positionName1);
	$("#atrzPosi-2").val(v_positionName2);
	$("#atrzPosi-3").val(v_positionName3);
	$("#atrzPosi-4").val(v_positionName4);
	$("#atrzPosi-5").val(v_positionName5);
	
	var v_positionId1 = "${atrzDocVO.atrzLineDetailList[0].positionId}";
	var v_positionId2 = "${atrzDocVO.atrzLineDetailList[1].positionId}";
	var v_positionId3 = "${atrzDocVO.atrzLineDetailList[2].positionId}";
	var v_positionId4 = "${atrzDocVO.atrzLineDetailList[3].positionId}";
	var v_positionId5 = "${atrzDocVO.atrzLineDetailList[4].positionId}";
	
	
	v_positionList.push(v_positionId1.substring(1));
	v_positionList.push(v_positionId2.substring(1));
	v_positionList.push(v_positionId3.substring(1));
	v_positionList.push(v_positionId4.substring(1));
	v_positionList.push(v_positionId5.substring(1));
	
	for(var i=0; i<5; i++){
		
		if(v_positionList[i] == ""){
			v_positionList.splice(i, 1);
			i--;
		}
	}
	
	//결재자이름
	var v_atrzName1 = "${atrzDocVO.atrzLineDetailList[0].atrzName}";
	var v_atrzName2 = "${atrzDocVO.atrzLineDetailList[1].atrzName}";
	var v_atrzName3 = "${atrzDocVO.atrzLineDetailList[2].atrzName}";
	var v_atrzName4 = "${atrzDocVO.atrzLineDetailList[3].atrzName}";
	var v_atrzName5 = "${atrzDocVO.atrzLineDetailList[4].atrzName}";
	
	$("#atrzName-1").val(v_atrzName1);
	$("#atrzName-2").val(v_atrzName2);
	$("#atrzName-3").val(v_atrzName3);
	$("#atrzName-4").val(v_atrzName4);
	$("#atrzName-5").val(v_atrzName5);
	
	v_list.push(v_atrzName1);
	v_list.push(v_atrzName2);
	v_list.push(v_atrzName3);
	v_list.push(v_atrzName4);
	v_list.push(v_atrzName5);
	
	for(var i=0; i<5; i++){
		if(v_list[i] == ""){
			v_list.splice(i, 1);
			i--;
		}
	}
	
	//결재자ID
	var v_atrzLineDetailId1 = "${atrzDocVO.atrzLineDetailList[0].atrzAprvId}";
	var v_atrzLineDetailId2 = "${atrzDocVO.atrzLineDetailList[1].atrzAprvId}";
	var v_atrzLineDetailId3 = "${atrzDocVO.atrzLineDetailList[2].atrzAprvId}";
	var v_atrzLineDetailId4 = "${atrzDocVO.atrzLineDetailList[3].atrzAprvId}";
	var v_atrzLineDetailId5 = "${atrzDocVO.atrzLineDetailList[4].atrzAprvId}";
	
	$("#atrzLineId-1").val(v_atrzLineDetailId1);
	$("#atrzLineId-2").val(v_atrzLineDetailId2);
	$("#atrzLineId-3").val(v_atrzLineDetailId3);
	$("#atrzLineId-4").val(v_atrzLineDetailId4);
	$("#atrzLineId-5").val(v_atrzLineDetailId5);
	
	//결재자부서명
	var v_atrzLineDetailDeptName1 = "${atrzDocVO.atrzLineDetailList[0].deptName}";
	var v_atrzLineDetailDeptName2 = "${atrzDocVO.atrzLineDetailList[1].deptName}";
	var v_atrzLineDetailDeptName3 = "${atrzDocVO.atrzLineDetailList[2].deptName}";
	var v_atrzLineDetailDeptName4 = "${atrzDocVO.atrzLineDetailList[3].deptName}";
	var v_atrzLineDetailDeptName5 = "${atrzDocVO.atrzLineDetailList[4].deptName}";
	
	$("#atrzLineDeptName-1").val(v_atrzLineDetailDeptName1);
	$("#atrzLineDeptName-2").val(v_atrzLineDetailDeptName2);
	$("#atrzLineDeptName-3").val(v_atrzLineDetailDeptName3);
	$("#atrzLineDeptName-4").val(v_atrzLineDetailDeptName4);
	$("#atrzLineDeptName-5").val(v_atrzLineDetailDeptName5);	
	
	
//결재선 불러오기(Page) 끝 --------------------------------

	$("#j-modBtn").on("click",function(){
		$.ajax({
			url: "/autho/treeList",
			type: "GET",
			contentType : "application/json; charset=utf-8",
			success: function(res) {
				console.log("조직도 리스트 : ",res);
//결재선 불러오기(Modal) 시작 --------------------------------
				if(v_startIndex == 1){
					v_startIndex++;
					var atrzLineDetailList  = [];	
				 	<c:forEach var="atrDetail" items="${atrzDocVO.atrzLineDetailList}">
				 		var atrzLineDetail  = {};
				 		atrzLineDetail.atrzLineId = '${atrDetail.atrzLineId }';
				 		atrzLineDetail.atrzLineLevel = ${atrDetail.atrzLineLevel };
				 		atrzLineDetail.atrzAprvId = '${atrDetail.atrzAprvId }';
				 		atrzLineDetail.atrzName = '${atrDetail.atrzName }';
				 		atrzLineDetail.positionName = '${atrDetail.positionName }';
				 		atrzLineDetail.deptName = '${atrDetail.deptName }';
				 		atrzLineDetailList.push(atrzLineDetail);
				 	</c:forEach>
				
					//console.log("list",atrzLineDetailList);
				 	
					var v_result = "";
					for(var i=0; i<atrzLineDetailList.length; i++ ){
						var v_vo = atrzLineDetailList[i];
						v_result += "<div class='col mb-1 p-2 j-divHover'>";
						v_result += 	v_vo.atrzName+"("+v_vo.positionName+")" +"&nbsp;&nbsp;&nbsp;"+v_vo.deptName;
						v_result += 	"<input type='hidden' class='env' id='env-"+(v_envIndex)+"' value='"+v_vo.atrzName+"'>"; //결재자이름
						v_result += 	"<input type='hidden' class='cgnv' id='cgnv-"+(v_envIndex)+"' value='"+v_vo.positionName+"'>"; //직급명
						v_result += 	"<input type='hidden' class='eiv' id='eiv-"+(v_envIndex)+"' value='"+v_vo.atrzAprvId+"'>"; //결재자아이디
						v_result += 	"<input type='hidden' class='epl' id='epl-"+(v_envIndex)+"' value='"+v_vo.positionName+"'>"; //직급명
						v_result += 	"<input type='hidden' class='dnv' id='dnv-"+(v_envIndex++)+"' value='"+v_vo.deptName+"'>"; //부서명
						v_result += "</div>"
					}
					$("#j-atrz").append(v_result);
				}
//결재선 불러오기(Modal) 끝 --------------------------------

				var v_result = "";
				var v_index = 0;
				$.each(res,function(i,v){
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
							v_result += ' 	<div href="#tree-item-'+(v_index++)+'" class="list-group-item j-move" data-toggle="collapse" style="padding-left: 3.75rem;">';
							v_result += ' 		'+v2.empName+'('+v2.cmmnGroupName+')'
							v_result += '		<input type="hidden" class="empNameValue" value="'+v2.empName+'">';
							v_result += '		<input type="hidden" class="cmmnGroupNameValue" value="'+v2.cmmnGroupName+'">';
							v_result += '		<input type="hidden" class="empIdValue" value="'+v2.empId+'">';
							v_result += '		<input type="hidden" class="empPositionValue" value="'+v2.empPosition+'">';
							v_result += '		<input type="hidden" class="deptNameValue" value="'+v2.deptName+'">';
							v_result += ' 	</div>';
						})
						v_result += ' 	</div>'; 
					})
					v_result += '	</div>';
				})
				$("#tree").html(v_result);
				
				
				$(".j-move").on("click",function(){
					var v_empNameValue = $(this).children(".empNameValue").val();
					var v_cmmnGroupNameValue = $(this).children(".cmmnGroupNameValue").val();
					var v_empIdValue = $(this).children(".empIdValue").val();
					var v_empPositionValue = $(this).children(".empPositionValue").val();
					var v_deptNameValue = $(this).children(".deptNameValue").val();
					
					var v_emp = $(this).text();
					v_empValid = v_emp.replace(/\n/g,"").replace(/\s*/g,"");
					v_empValid = v_empValid.substring(0, 3);
					
					var v_username = $("#docWrtr").val();
					if(v_empIdValue == v_username){
						alert("자기 자신은 선택 할 수 없습니다.");
						return false;
					}
					var loginEmpPositionValid = loginEmpPosition.substring(1);
					v_empPositionValid = v_empPositionValue.substring(1);
					if(v_empPositionValid <= loginEmpPositionValid){
						alert("자기 자신보다 높은 직급을 선택해 주세요.");
						return false;
					}
					for(var i=0; i<v_list.length; i++){
						if(v_list[i] == v_empValid){
							alert("중복된 이름입니다.");
							return false;
						}
						if(v_positionList[i]<v_empPositionValid){
							//alert(v_positionList[i]+" < "+v_empPositionValid);
							alert("결재선 순서가 올바르지 않습니다.");
							return false;
						}
						
					}
					if(v_list.length == 5){
						alert("결재선은 최대 다섯명까지 가능합니다.");
						return false;
					}
					
					v_list.push(v_empValid);
					v_positionList.push(v_empPositionValid);
					
					var v_result = "";
					v_result += "<div class='col mb-1 p-2 j-divHover'>";
					v_result += 	v_emp +"&nbsp;&nbsp;&nbsp;"+v_deptNameValue;
					v_result += 	"<input type='hidden' class='env' id='env-"+(v_envIndex)+"' value='"+v_empNameValue+"'>";
					v_result += 	"<input type='hidden' class='cgnv' id='cgnv-"+(v_envIndex)+"' value='"+v_cmmnGroupNameValue+"'>";
					v_result += 	"<input type='hidden' class='eiv' id='eiv-"+(v_envIndex)+"' value='"+v_empIdValue+"'>";
					v_result += 	"<input type='hidden' class='epl' id='epl-"+(v_envIndex)+"' value='"+v_empPositionValue+"'>"; 
					v_result += 	"<input type='hidden' class='dnv' id='dnv-"+(v_envIndex++)+"' value='"+v_deptNameValue+"'>"; 
					v_result += "</div>"
					
					$("#j-atrz").append(v_result);
				})
				
				$("#j-modReset").on("click",function(){
					$('#j-atrz').html('');
					v_list = [];
					v_positionList = [];
					v_envIndex = 1;
				})
				
// 				$(".j-divHover").on("click",function(){
				$("#j-atrz").on("click",".j-divHover",function(){
					//alert("음~?");
					var v_emptyName = $(this).text().replace(/\n/g,"").replace(/\s*/g,"").substring(0, 3);
					//alert(v_emptyName);
					for(var i=0; i<v_list.length; i++){
						if(v_list[i]==v_emptyName){
							//console.log("누른이름 : ",v_emptyName,"/ 비교하는 이름 : ",v_list[i]);
							//console.log("변경전 : v_list : ",v_list,"/ v_positionList : ",v_positionList);
							v_list.splice(i, 1);
							v_positionList.splice(i, 1);
							i--;
							//console.log("변경후 : v_list : ",v_list,"/ v_positionList : ",v_positionList);
							//console.log("엔터");
							break;
						}
					}
					$(this).detach();
				})
			},
			error: function(xhr) {
				alert(xhr.status)
			},
			dataType: "json"
		})
	})
	
	$("#j-save").on("click",function(){
		//결재선-결재자이름
		var v_envName1 = $("#j-atrz").find("div:eq(0)").find(".env").val();
		var v_envName2 = $("#j-atrz").find("div:eq(1)").find(".env").val();
		var v_envName3 = $("#j-atrz").find("div:eq(2)").find(".env").val();
		var v_envName4 = $("#j-atrz").find("div:eq(3)").find(".env").val();
		var v_envName5 = $("#j-atrz").find("div:eq(4)").find(".env").val();
		
		$("#atrzName-1").val(v_envName1);
		$("#atrzName-2").val(v_envName2);
		$("#atrzName-3").val(v_envName3);
		$("#atrzName-4").val(v_envName4);
		$("#atrzName-5").val(v_envName5);
		
		//결재선-결재자직급
		var v_envPosi1 = $("#j-atrz").find("div:eq(0)").find(".cgnv").val();
		var v_envPosi2 = $("#j-atrz").find("div:eq(1)").find(".cgnv").val();
		var v_envPosi3 = $("#j-atrz").find("div:eq(2)").find(".cgnv").val();
		var v_envPosi4 = $("#j-atrz").find("div:eq(3)").find(".cgnv").val();
		var v_envPosi5 = $("#j-atrz").find("div:eq(4)").find(".cgnv").val();

		$("#atrzPosi-1").val(v_envPosi1);
		$("#atrzPosi-2").val(v_envPosi2);
		$("#atrzPosi-3").val(v_envPosi3);
		$("#atrzPosi-4").val(v_envPosi4);
		$("#atrzPosi-5").val(v_envPosi5);

		//갤재선-결재자아이디
		var v_atrzLineId1 = $("#j-atrz").find("div:eq(0)").find(".eiv").val();
		var v_atrzLineId2 = $("#j-atrz").find("div:eq(1)").find(".eiv").val();
		var v_atrzLineId3 = $("#j-atrz").find("div:eq(2)").find(".eiv").val();
		var v_atrzLineId4 = $("#j-atrz").find("div:eq(3)").find(".eiv").val();
		var v_atrzLineId5 = $("#j-atrz").find("div:eq(4)").find(".eiv").val();
		
		$("#atrzLineId-1").val(v_atrzLineId1);
		$("#atrzLineId-2").val(v_atrzLineId2);
		$("#atrzLineId-3").val(v_atrzLineId3);
		$("#atrzLineId-4").val(v_atrzLineId4);
		$("#atrzLineId-5").val(v_atrzLineId5);
		
		//결재선-결재자부서명
		var v_atrzLineDeptName1 = $("#j-atrz").find("div:eq(0)").find(".dnv").val();
		var v_atrzLineDeptName2 = $("#j-atrz").find("div:eq(1)").find(".dnv").val();
		var v_atrzLineDeptName3 = $("#j-atrz").find("div:eq(2)").find(".dnv").val();
		var v_atrzLineDeptName4 = $("#j-atrz").find("div:eq(3)").find(".dnv").val();
		var v_atrzLineDeptName5 = $("#j-atrz").find("div:eq(4)").find(".dnv").val();
		
		$("#atrzLineDeptName-1").val(v_atrzLineDeptName1);
		$("#atrzLineDeptName-2").val(v_atrzLineDeptName2);
		$("#atrzLineDeptName-3").val(v_atrzLineDeptName3);
		$("#atrzLineDeptName-4").val(v_atrzLineDeptName4);
		$("#atrzLineDeptName-5").val(v_atrzLineDeptName5);
		
	})
	
})
</script>

	
<script>
//CKEDITOR에 내용 집어넣기
function f_selectChange(value){
	console.log("CKEDITOR : ",value);
		if(value == 'A101'){
			CKEDITOR.instances.docCntnt.setData('${docContent["A101"]}');
			
		}else if(value == "A102"){
			CKEDITOR.instances.docCntnt.setData('${docContent["A102"]}');
		}else if(value == "A103"){
			CKEDITOR.instances.docCntnt.setData('${docContent["A103"]}');
		}else if(value == "A104"){
			CKEDITOR.instances.docCntnt.setData('${docContent["A104"]}');
		}
	var v_docTypeName = $('#docTypeId option:selected').prop('label');
	$('#docTypeName').val(v_docTypeName);
}

//CKEDITOR의 내용 가져오기
//CKEDITOR.instances.textarea_id.getData()
$(function(){
	// ajax Post 사용시 같이 보낼 토큰헤더 
	//var token = '${_csrf.token}'
	//var header = '${_csrf.headerName}'
	
	$("#docWrtrName").prop("readonly",true);
	$("#docDeptName").prop("readonly",true);
	$("#tempDocState").prop("readonly",true);
	
	$(".j-btn").on("click",function(){
		var v_docTypeId = document.getElementById('docTypeId').value;
		var v_docRetention = document.getElementById('docRetention').value;
		var v_atrzLine = document.getElementById('atrzName-1').value;
		var v_docTitle = document.getElementById('docTitle').value;
		var v_docCntnt = CKEDITOR.instances.docCntnt.getData();
		
		var v_jBtnValue = $(this).val();
		$("#docState").val(v_jBtnValue);
		
		if(v_docTypeId == "") {
			alert("문서종류를 선택해주세요."); 
			return false;
		}
		if(v_docRetention == ""){
			alert("보존연한을 선택해주세요.");
			return false;
		}
		if(v_atrzLine == ""){
			alert("결재선을 선택해주세요.");
			return false;
		}
		if(v_docTitle == ""){
			alert("제목을 입력해주세요.");
			return false;
		}
		if(v_docCntnt == ""){
			alert("내용을 입력해주세요.");
			return false;
		}
		
		
		//이미지 다운로드 업로드
		var token = "${_csrf.token }";
		var header = "${_csrf.headerName }";	
		var v_dd = $("iframe").contents().find("body");
		html2canvas(v_dd).then(function(canvas) {
			var myImg = canvas.toDataURL("image/png");
			myImg = myImg.replace("data:image/png;base64,", "");
			console.log("myImg : "+myImg);
			$.ajax({
				type : "POST",
				data : {
					"imgSrc" : myImg,
					"docId" : "${docId}"
				},
				url : "/autho/docCntntImg",
				success : function(data) {
					var v_ckeditor = CKEDITOR.instances.docCntnt.getData();
					
					v_ckeditor = v_ckeditor.replace(/\n/g,"");
					
					CKEDITOR.instances.docCntnt.setData(v_ckeditor);
					
					
					$("#docContentPath").val(data);
					//alert("data : "+data);
					alert("문서 작성이 완료되었습니다.");
					
					var v_env1 = $("#j-atrz").find("div:eq(0)").find(".env").val();
					var v_env2 = $("#j-atrz").find("div:eq(1)").find(".env").val();
					var v_env3 = $("#j-atrz").find("div:eq(2)").find(".env").val();
					var v_env4 = $("#j-atrz").find("div:eq(3)").find(".env").val();
					var v_env5 = $("#j-atrz").find("div:eq(4)").find(".env").val();
					
					var v_eiv1 = $("#j-atrz").find("div:eq(0)").find(".eiv").val();
					var v_eiv2 = $("#j-atrz").find("div:eq(1)").find(".eiv").val();
					var v_eiv3 = $("#j-atrz").find("div:eq(2)").find(".eiv").val();
					var v_eiv4 = $("#j-atrz").find("div:eq(3)").find(".eiv").val();
					var v_eiv5 = $("#j-atrz").find("div:eq(4)").find(".eiv").val();
					
					$("#j-form").submit();
				},
				error : function(xhr) {
					alert("error");
				},
				beforeSend: function (xhr) {
	                xhr.setRequestHeader(header, token)
				},
				dataType : "text"
			});
		});
		
		
	})
})
</script>