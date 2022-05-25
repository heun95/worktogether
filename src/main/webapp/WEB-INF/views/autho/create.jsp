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
#j-card{ 
	background-color: white; 
}
</style>

<div class="row m-1">
	<h3 class="h3 mb-2 text-gray-800" style="color: #6c6ff5"><span id="createReady">작성하기</span></h3>
</div>

<div class="row m-1">
	<div class="card overflow-hidden card-h-100 ">
		<div class="card-body" id="j-card">
			<form:form id="j-form" modelAttribute="atrzDocVO" method="post" action="/autho/create">
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
					
				</div>
			
	
	
				<div class="row mb-0">
					<div class="col-sm-12">
						<label class="form-label">결재선등록</label>
						<label class="form-label mx-3">
							<button type="button" class="btn btn-outline-primary"
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
		                    	<input name="atrzAprv" type="text" value="" id="atrzName-1" class="j-input-text" readonly>
		                    	<input name="atrzLineDetailId" type="hidden" value="" id="atrzLineId-1">
		                    	<input name="atrzLineDetailDeptName" type="hidden" value="" id="atrzLineDeptName-1">
		                    </td>
		                    <td class="table-secondary">
		                    	<input name="atrzAprv" type="text" value="" id="atrzName-2" class="j-input-text" readonly>
		                    	<input name="atrzLineDetailId" type="hidden" value="" id="atrzLineId-2">
		                    	<input name="atrzLineDetailDeptName" type="hidden" value="" id="atrzLineDeptName-2">
		                    </td>
		                    <td class="table-secondary">
		                    	<input name="atrzAprv" type="text" value="" id="atrzName-3" class="j-input-text" readonly>
		                    	<input name="atrzLineDetailId" type="hidden" value="" id="atrzLineId-3">
		                    	<input name="atrzLineDetailDeptName" type="hidden" value="" id="atrzLineDeptName-3">
		                    </td>
		                    <td class="table-secondary">
		                    	<input name="atrzAprv" type="text" value="" id="atrzName-4" class="j-input-text" readonly>
		                    	<input name="atrzLineDetailId" type="hidden" value="" id="atrzLineId-4">
		                    	<input name="atrzLineDetailDeptName" type="hidden" value="" id="atrzLineDeptName-4">
		                    </td>
		                    <td class="table-secondary">
		                    	<input name="atrzAprv" type="text" value="" id="atrzName-5" class="j-input-text" readonly>
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
						<button type="button" class="btn btn-outline-primary j-btn" style="width: 100%;" value="대기중">작성완료</button>
					</div>
				</div>
				
				<div class="row mb-3">
					<div class="com-sm-12">
						<button type="button" class="btn btn-outline-info j-btn" style="width: 100%;" value="임시저장">임시저장</button>
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

<!-- 결재선 모달 -->
<div class="row">
	<div class="col-sm-6 col-md-4 col-xl-3">
		<!-- sample modal content -->
		<div id="myModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
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
						<button type="button" class="btn btn-outline-info" id="j-modReset">초기화</button>
						<button type="button" id="j-save"
							class="btn btn-outline-primary" data-bs-dismiss="modal">저장하기</button>
						<button type="button" class="btn btn-outline-danger"
							data-bs-dismiss="modal">닫기</button>
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

<!-- <img id="loadingImg" src='/resources/images/spinner.gif' style='position: absolute; display: block; margin: 0px auto; top:50%; left:50%;'/> -->

<script>
//조직도
$(function(){
	
//     LoadingWithMask();
//     //setTimeout("closeLoadingWithMask()", 3000);
//     setTimeout(function(){
//     	closeLoadingWithMask();
// 	  },3000); 
    
// 	function LoadingWithMask() {
// 		//alert("1");
// 	    //화면의 높이와 너비를 구합니다.
// 	    var maskHeight = $(document).height();
// 	    var maskWidth  = window.document.body.clientWidth;
	     
// 	    //화면에 출력할 마스크를 설정해줍니다.
// 	    var mask       ="<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
// 	    //화면에 레이어 추가
// 	    $('body').append(mask)
	 
// 	    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채웁니다.
// 	    $('#mask').css({
// 	            'width' : maskWidth,
// 	            'height': maskHeight,
// 	            'opacity' :'0.3'
// 	    });
	  
// 	    //마스크 표시
// 	    $('#mask').show();
	  
// 	    //로딩중 이미지 표시
// // 	    $('#loadingImg').append(loadingImg);
// // 	    $('#loadingImg').show();
	    
// 	   // $("body").append(loadingImg);
// 	    //$("body").show();
// 	    $("#loadingImg").show();
	    
// 	}
	 
// 	function closeLoadingWithMask() {
// 	    $('#mask, #loadingImg').hide();
// 	    $('#mask, #loadingImg').empty(); 
// 	}


	
	
	
	
	var loginEmpPosition = $("#loginEmpPosition").val();
	var v_list = [];
	var v_positionList = [];
	var v_envIndex = 1;

	$("#j-modBtn").on("click",function(){
		$.ajax({
			url: "/autho/treeList",
			type: "GET",
			contentType : "application/json; charset=utf-8",
			success: function(res) {
				console.log("조직도 리스트 : ",res);
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
							//console.log("empId",i2,v2.empId);
							//console.log("empName",i2,v2.empName);
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
						//console.log(i);
						if(v_list[i] == v_empValid){
							alert("중복된 이름입니다.");
							return false;
						}
						if(v_positionList[i]<v_empPositionValid){
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
					
					$(".j-divHover").on("click",function(){
						var v_emptyName = $(this).text().replace(/\n/g,"").replace(/\s*/g,"").substring(0, 3);
						
						for(var i=0; i<v_list.length; i++){
							if(v_list[i]==v_emptyName){
								v_list.splice(i, 1);
								v_positionList.splice(i, 1);
								break;
							}
						}
						$(this).detach();
					})
				})
				
				$("#j-modReset").on("click",function(){
					$('#j-atrz').html('');
					v_list = [];
					v_positionList = [];
					v_envIndex = 1;
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
	
	//var v_iframe = $("iframe").contents().find("body").html();
	//console.log("dd", v_iframe);
	
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
	
	$("#docWrtrName").prop("readonly",true);
	$("#docDeptName").prop("readonly",true);
	
	$(".j-btn").on("click",function(){
		var v_docTypeId = document.getElementById('docTypeId').value;
		var v_docRetention = document.getElementById('docRetention').value;
		var v_atrzLine = document.getElementById('atrzName-1').value;
		var v_docTitle = document.getElementById('docTitle').value;
		var v_docCntnt = CKEDITOR.instances.docCntnt.getData();
		//alert(v_docTypeId);
		//return false;
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
					"imgSrc" : myImg
				},
				url : "/autho/docCntntImg",
				success : function(data) {
					var v_ckeditor = CKEDITOR.instances.docCntnt.getData();
					
					v_ckeditor = v_ckeditor.replace(/\n/g,"");
					
					CKEDITOR.instances.docCntnt.setData(v_ckeditor);
					
					$("#docContentPath").val(data);
					
					//alert("문서 작성이 완료되었습니다.");
					
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

$("#createReady").on("click",function(){
	$("#docTypeId").val("A104").prop("selected",true);
	$("#docRetention").val("A404").prop("selected",true);
	$("#docTitle").val("(오전) 회의록 결재 부탁드립니다!");
	var v_docTypeName = $('#docTypeId option:selected').prop('label');
	$('#docTypeName').val(v_docTypeName);
	var v_cnt = '<h1><cite><strong>회의록</strong></cite></h1><table align="left" border="1" cellpadding="0" cellspacing="0">	<tbody>		<tr>			<td style="width:132px">			<h2><strong>&nbsp; &nbsp; 회의안건</strong></h2>			</td>			<td style="width:469px">			<h2>&nbsp; &nbsp;정보 시스템 유지보수 사업 건</h2>			</td>		</tr>		<tr>			<td style="width:132px">			<h2><strong>&nbsp; &nbsp; 회의일자&nbsp;</strong></h2>			</td>			<td style="width:469px">			<h2>&nbsp; &nbsp;2022-04-21</h2>			</td>		</tr>		<tr>			<td style="width:132px">			<h2><strong>&nbsp; &nbsp; 회의장소&nbsp;</strong></h2>			</td>			<td style="width:469px">			<h2>&nbsp; &nbsp;세미나실2호</h2>			</td>		</tr>		<tr>			<td style="width:132px">			<h2><strong>&nbsp; &nbsp; &nbsp;참석자</strong></h2>			</td>			<td style="width:469px">			<h2>&nbsp; &nbsp;이중호(부장) 강나영(대리) 손영흔(사원)</h2>			</td>		</tr>		<tr>			<td style="height:236px; width:132px">			<h2><strong>&nbsp; &nbsp; 회의내용</strong></h2>			</td>			<td style="height:236px; width:469px">			<h2>&nbsp; &nbsp;회의 참여자의 출장으로 인해 회의가 연기됨</h2>			</td>		</tr>		<tr>			<td style="height:264px; width:132px">			<h2><strong>&nbsp; &nbsp; 회의결과</strong></h2>			</td>			<td style="height:264px; width:469px">			<h2>&nbsp; &nbsp;2022-04-23일에 다시 회의를 할 예정</h2>			</td>		</tr>		<tr>			<td style="width:132px">			<h2><strong>&nbsp; &nbsp; 기타사항</strong></h2>			</td>			<td style="width:469px">			<h3>&nbsp;</h3>			</td>		</tr>	</tbody></table>';
	CKEDITOR.instances.docCntnt.setData(v_cnt);
})

</script>
