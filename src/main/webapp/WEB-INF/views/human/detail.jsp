<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- <script type="text/javascript" src="/resources/js/jquery-latest.min.js"></script> -->
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/jspdf.min.js"></script>
<script type="text/javascript" src="/resources/js/html2canvas.min.js"></script>
<script type="text/javascript" src="/resources/js/html2pdf.bundle.min.js"></script>
<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->

<script type="text/javascript">

//ajax Post 사용시 같이 보낼 토큰헤더 
var token = '${_csrf.token}'
var header = '${_csrf.headerName}'

//다음 우편 번호 검색
function openHomeSearch(){
	new daum.Postcode({
		oncomplete:function(data){
			$('[name=empPostno]').val(data.zonecode);
			$('[name=empAddr1]').val(data.address);
			$('[name=empAddr2]').val(data.buildingName);
		}
	}).open();
}

/* 파일 첨부 시작 */
var sel_file;

// e = event;
function handleImgFileSelect(e) {
	console.log(e.target.files); // 이벤트를 발생 시킨 녀석
	
    var files = e.target.files;
    var filesArr = Array.prototype.slice.call(files); 
    // 배열로 바꾸깅, OK!

    filesArr.forEach(function(f) {
        if(!f.type.match("image.*")) {
            alert("이미지 파일만 첨부해주세요.");
            return;  // 암것도 안하고 끝내기
        }

        sel_file = f;
        var reader = new FileReader();
        reader.onload = function(e) {
        	//console.log(e.target.result);
            $("#pic").attr("src", e.target.result);
        }
        reader.readAsDataURL(f);
    });
}

/* 파일 첨부 끝 */
$(document).ready(function() {
		$("#input_imgs").on("change", handleImgFileSelect);
		var formObj = $("#employInsertForm");

		//수정
		$("#su").on("click", function() {
			//alert("test");
			$(".form-control").attr("readonly", false);
			$("#su").hide();
			$("#sa").hide();
			$("#okno1").show();
			$('#empPosition').attr('disabled', false);
			$('.treeDepartBtn').attr('disabled', false);
			$('.homeBtn').attr('disabled', false);
			//$("#okno2").show();

		})

		//삭제
		$("#sa").on("click", function() {
			var conf = confirm("정말 퇴사처리 하시겠습니까?")
			if(conf){
				formObj.attr("action", "/human/delete");
				formObj.attr("method", "post");
				formObj.submit();
			}
		})

		//확인1
		$("#but1").on("click", function() {
			formObj.attr("action", "/human/update");
			formObj.attr("method", "post");
			formObj.submit();
		})

		//취소1
		$("#but2").on("click", function() {
			location.href = "/human/detail?empId=${employeeVO.empId}"
		})

		/* 조직도 시작 */
			var token = "${_csrf.token }";
			var header = "${_csrf.headerName }";
			
			/* 위에 이벤트가 있으니까 $(document)로 처리해 줘야 함 */
			$(document).on("click", ".deptName", function(){
				console.log($.trim($(this).text()));
				var deptName = $.trim($(this).text());
				var deptId = $.trim($(this).data("deptid"));
				console.log($("#deptModal"));
				$("#deptModalClose").trigger("click");
				$("#deptName").val(deptName);
				$("#deptId").val(deptId);
			})
			
			$(".treeDepartBtn").on("click", function(){
				var v_treeBtnValue = $(this).val();
				$.ajax({
					url: "/common/treeList",
					type: "POST",
					contentType : "application/json; charset=utf-8",
					data: JSON.stringify({
						"treeSelect" : v_treeBtnValue
					}),
					success: function(res) {
						console.log(res);
						$("#treeDepartContainer").css("display","block");
						var v_result = "";
						var v_index = 0;
						$.each(res,function(i,v){
							if(v.topDeptId != null && v.topDeptId != 'DEP00'){
								v_result += '	<div href="#tree-item-'+(v_index++)+'" class="list-group-item" data-toggle="collapse" style="padding-left: 1.25rem;" aria-expanded="true" >';
								v_result += '		<i class="state-icon fa-angle-down fa"></i>'+v.topDeptName;
								v_result += '	</div>';
								v_result += '	<div class="list-group collapse" id="tree-item-'+(v_index-1)+'" style="">';
								
								$.each(v.deptList,function(i1,v1){
										v_result += '	<div data-deptid="'+v1.deptId+'" href="#tree-item-'+(v_index++)+'" class="list-group-item deptName" data-toggle="collapse" style="padding-left: 2.5rem;">';
										v_result += '		'+v1.deptName+'';
										v_result += '	</div>';
										v_result += '	<div class="list-group collapse" id="tree-item-'+(v_index-1)+'">';
										v_result += ' 	</div>';
								})
								v_result += '	</div>';
							}
						})
						
						$("#treeDepart").html(v_result);
						
					},
					error: function(xhr) {
//		 				alert(xhr.status)
					},
					beforeSend: function (xhr) {
			                xhr.setRequestHeader(header, token)
					},
					dataType: "json"
				})
			})
	
		/* 조직도 끝 */	
})
</script>

<style>

::-webkit-scrollbar {

display:none;

} 

body{
background-color: #eff3f7;
}
.left{
 width : 25%;
 height : 200px;
 float : left;
 padding : 3px;
}
.imm{
  margin : 3px;
  padding : 5px;
  border : 1px dotted orange;
}
#scroll {
    -ms-overflow-style: none; /* IE and Edge */
    scrollbar-width: none; /* Firefox */
    overflow-x: none
}
#scroll::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Opera*/
    overflow-x: none
}
#su{
	align:left;
}
.justify-content-between {
    /* -webkit-box-pack: justify!important; */
    -ms-flex-pack: justify!important;
    justify-content: space-between!important;
}
</style>

<form:form modelAttribute="employeeVO" id="employInsertForm" method="post" action="/human/insertemp"
	enctype="multipart/form-data">  

         <div class="col-12">
            <div class="page-title-box d-flex align-items-center justify-content-between">
               <h3 class="mb-0">직원 정보</h3>
	            <div>
					<a href="javascript:void(0);" id="su" class="me-3 text-primary"
					data-bs-toggle="tooltip" data-placement="top" title=""
					data-bs-original-title="Edit" aria-label="Edit"><i
					class="mdi mdi-pencil font-size-18" ></i></a> 
					
					<a href="javascript:void(0);" id="sa" class="text-danger"
					data-bs-toggle="tooltip" data-placement="top" title=""
					data-bs-original-title="Delete" aria-label="Delete"><i
					class="mdi mdi-trash-can font-size-18" ></i></a>
				</div>		
				<div class="form-group" id="okno1"
					style="float: right; display: none;">
					<button id="but1" type="button"
						class="mb-2 btn btn-sm btn-success mr-1">확인</button>
					<button id="but2" type="button"
						class="mb-2 btn btn-sm btn-danger mr-1">취소</button>
				</div>
	         </div>
	      </div>  
   
<div class="row">
     <div class="col-lg-6">
       <div class="col">
         <div class="card">
             <div class="card-body">
                 <h4 class="card-title ri-file-user-fill"> 사진업로드(증명사진)</h4>
                  <hr>
                 <div class="dtab" id = "second"> 
				  <div class = "left" id="imm">
				  	
				   <img id="pic" src="${employeeVO.atchPath}" style="width:150px; height:200px;">
				  </div>
				  <div class = "right">
				  증명사진을 첨부해주세요.
				  </div>
				  <br>
				    <div class="form-group">
			        	<input type="file" readonly="true" id="input_imgs" name="uploadFile" />
			        </div>	
				  <br>
				  <div class = "right">
				 첨부하시는 사진은 직원 등록 및 직원 확인용으로 사용되며, 가로 295px, 세로 354px이상을 권장 합니다.
				  </div>
				</div>
			</div>
          </div>
         <div class="card">
           <div class="card-body">
               <h4 class="card-title ri-pencil-fill"> 회사 정보</h4>
               <hr>
            <div class="row mb-3">
                <label for="empPosition" class="col-sm-2 col-form-label">직원 직급</label>
                 <div class="col-sm-10">
                <form:select path="empPosition" class="form-control select2-search-disable select2-hidden-accessible" 
                data-select2-id="6" tabindex="-1" aria-hidden="true" disabled="true">                                   
                        <option value="H205" data-select2-id="83">부장</option>
                        <option value="H204" data-select2-id="84">과장</option>
                        <option value="H203" data-select2-id="85">대리</option>
                        <option value="H202" data-select2-id="86">주임</option>
                        <option value="H201" data-select2-id="86">사원</option>
                </form:select>
                </div>
            </div>
            
            <div class="row mb-3">
                <label for="deptId" class="col-sm-2 col-form-label">부서</label>
                 <div class="col-sm-7">
                	<form:hidden path="deptId" />                                   
                	<form:input path="deptName" readonly="true" class="form-control select2-search-disable select2-hidden-accessible" data-select2-id="6" tabindex="-1" aria-hidden="true" />                                   
                </div>
                <button type="button" class="btn btn-primary btn-icon-split btn-sm col-sm-2 treeDepartBtn" data-toggle="modal" data-target="#deptModal" value="treeAll" disabled>
				 <span class="text">부서 검색</span>
				</button>
            </div>  
            
            <div class="row mb-3">
               <label for="example-url-input" class="col-sm-2 col-form-label">입사 일자</label>
               <div class="col-sm-10">
                   <form:input class="form-control" readonly="true" path="empEcnyYmd" type="date"/>
                   <font color="red" style="font-size:8pt;">
					<form:errors path="empEcnyYmd" />
				</font>
                </div>
            </div>
			
           </div>
         </div>  
       </div>
     </div>
     <div class="col-lg-6 -ms-overflow-style: none;"  id="scroll" style="overflow-x: hidden">
         <div class="card -ms-overflow-style: none;" id="scroll" style="overflow-x: hidden">
             <div class="card-body -ms-overflow-style: none;">
                 <h4 class="card-title ri-pencil-fill"> 신상정보</h4>
                <hr>
                 <div class="table-responsive">
                     <table class="table table-dark mb-0">
                		                        
                         <div class="row mb-3">
                              <label for="example-text-input" class="col-sm-2 col-form-label">직원번호</label>
                              <div class="col-sm-10">
                                  <form:input class="form-control" readonly="true" path="empId" placeholder="EMPL00001"/>
                                  	<font color="red" style="font-size:8pt;">
			            	<form:errors path="empId" />
			          		  </font>
                              </div>
                          </div>
                          
						  <div class="row mb-3">
                              <label for="example-search-input" class="col-sm-2 col-form-label">성명</label>
                              <div class="col-sm-10">
                                  <form:input class="form-control" readonly="true" path="empName" placeholder="백이진"/>
                              		<font color="red" style="font-size:8pt;">
			            	</font>
			            	<form:errors path="empName" />
                              </div>
                          </div>
                          
                        <div class="row mb-3">
                              <label for="example-email-input" class="col-sm-2 col-form-label">생년월일</label>
                              <div class="col-sm-10">
                                  <form:input class="form-control" readonly="true" path="empBirth" placeholder="1994/02/22"/>
                                  <font color="red" style="font-size:8pt;">
				            	<form:errors path="empBirth" />
				            </font>
	                     </div>
                        </div>  

                          <div class="row mb-3">
                              <label for="example-password-input" class="col-sm-2 col-form-label">비밀번호</label>
                              <div class="col-sm-10">
                                  <form:input class="form-control" readonly="true" path="empPassword"  type="password" placeholder="******"/>
                              		<font color="red" style="font-size:8pt;">
			            			<form:errors path="empPassword" />
			          		  </font>
                              </div>
                          </div>
                              
                        <div class="row mb-3">
                             <label for="example-url-input" class="col-sm-2 col-form-label">연락처</label>
                             <div class="col-sm-10">
                                 <form:input class="form-control" readonly="true" path="empTel" placeholder="010-1234-5678"/>
                             		<font color="red" style="font-size:8pt;">
				            	<form:errors path="empTel" />
				            </font>
                             </div>
                         </div>   
                         
                       <div class="row mb-3">
                           <label for="example-tel-input" class="col-sm-2 col-form-label">이메일</label>
                           <div class="col-sm-10">
                               <form:input class="form-control" readonly="true" path="empEmail" placeholder="naver@naver.com"/>
                           </div>
                       </div>   
                       
                       <div class="row mb-3">
                             <label for="example-password-input" class="col-sm-2 col-form-label">직원 주소</label>
                             <div class="col-sm-7">
                                 <form:input path="empPostno" readonly="true" class="form-control"  value=""/>
                             </div>
				          <button type="button" onclick="openHomeSearch()" class="btn btn-primary btn-icon-split btn-sm col-sm-2 homeBtn" disabled>
					          <span class="text">우편번호 검색</span>
					      </button>
			           </div>
			                         
					    <div class="row mb-3">
                             <label for="example-number-input" class="col-sm-2 col-form-label">주소</label>
                             <div class="col-sm-10">
                                 <form:input path="empAddr1" readonly="true" class="form-control" type="text" />
                          </div>
                        </div>
		  
                         <div class="row mb-3">
                             <label for="example-number-input" class="col-sm-2 col-form-label">상세주소</label>
                             <div class="col-sm-10">
                                 <form:input path="empAddr2" readonly="true" class="form-control" type="text" />
                            </div>
                          </div>  
                        
                     </table>
                 </div>
             </div>
         </div>
     </div>
 </div>
 
</form:form>

<div class="modal fade" id="deptModal" role="dialog"> 
	<div class="modal-dialog"> 
		<div class="modal-content">
			<div class="modal-header"> 
				<h4 class="modal-title">부서 검색</h4>
				<button type="button" id="deptModalClose" class="close" data-dismiss="modal">×</button> 
			</div> 
			<div class="modal-body"> 
				<div class="container" id="treeDepartContainer" style="display:none;">
					<div class="content">
						<div class="col-md-4 pt-5">
							<div id="treeDepart" class="bstreeview"></div>
						</div>
					</div>
				</div>
			</div> 
			<div class="modal-footer"></div> 
		</div> 
	</div> 
</div>
			<script>
		
			//직급이 input에 나오게 하기
            $(function(){
	            var v_empPosition = "${employeeVO.empPosition}"; //사원번호 : H201 = 사원
            	//alert(v_empPosition);
            	$("#empPosition").val(v_empPosition).prop("selected", true);

            })
            
            //부서가 input에 나오게 하기
            $(function(){
            	//var v_deptId = "${employeeVO.deptId}"; //부서번호 : DEP0301 = 
            	var v_deptName = "${employeeVO.deptName}"; //부서이름 : 개발1팀
            	//alert(v_deptName);
            	$("#deptName").val(v_deptName);
            	//console.log("${employeeVO}");
            })
			
			
            </script>