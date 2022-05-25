<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- <link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> -->
<link href="/resources/css/bstreeview.min.css" rel="stylesheet" type="text/css" />
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script> -->

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
       rel="stylesheet"
       integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
       crossorigin="anonymous" />
      
<script type="text/javascript">
	
// ajax Post 사용시 같이 보낼 토큰헤더 
var token = '${_csrf.token}'
var header = '${_csrf.headerName}'
	
	// 다음 우편 번호 검색
	function openHomeSearch(){
		new daum.Postcode({
			oncomplete:function(data){
				$('[name=empPostno]').val(data.zonecode);
				$('[name=empAddr1]').val(data.address);
				$('[name=empAddr2]').val(data.buildingName);
			}
		}).open();
	}
	
	//position: 'center-center',
	function mytoast(title, type){
		const Toast = Swal.mixin({
		      toast: true,
		      showConfirmButton: false,
		      timer: 3000,
		      timerProgressBar: true,
		      didOpen: (toast) => {
		        toast.addEventListener('mouseenter', Swal.stopTimer);
		        toast.addEventListener('mouseleave', Swal.resumeTimer);
		      }
		    })

	    Toast.fire({
	      icon: type,
	      title: title
	    });
	}
	
	function myAlert(title, msg, type){
		Swal.fire({
		      icon: type , // 'success', 'error', 'warning', 'info', 'question'
		      title: title,
		      text: msg,
		    });
	}
	
	//직원 등록 버튼 클릭시
	$(function(){	
		$("#inemp").on("click", function(){
			
			var formData = new FormData(document.getElementById("employInsertForm"));
			
			$.ajax({
				url: "/human/insertemp",
				type: "POST",
				contentType : false,
			    processData : false,
				dataType: "text",
				data: formData	,
				success: function(res) {
					if(res=="success"){
						mytoast("정상적으로 등록되었습니다.", "success");
						setTimeout(function() {
							location.href="/human/list";
							}, 3000);
					}else{
						mytoast("등록에 실패했습니다.", "error");
						
					}
						
				},
				beforeSend:function(xhr) { 
					xhr.setRequestHeader(header, token)
				},
				error: function(xhr) {
					alert(xhr.status)
				
				}
			})
		});
	});
	
	function inname(){
			$("#empEcnyYmd").val("2022-04-21");
			$("#empName").val("손영흔");
			$("#empBirth").val("1995-12-08");
			$("#password").val("951208");
			$("#empTel").val("010-4456-8599");
			$("#empEmail").val("sonson@naver.com");
			
	}
	

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

</style>

<form:form modelAttribute="employeeVO" id="employInsertForm" method="post" action="/human/insertemp"
	enctype="multipart/form-data">  
	<form:hidden path="empId" value="0" />
	<div class="row">
         <div class="col-12">
             <div class="page-title-box d-flex align-items-center justify-content-between">
                 <h4 class="mb-0" id="inname" onclick="inname()">직원 등록</h4>

                 <div class="form-group" style="float:right;">

                 <button type="button" id="inemp" class="btn btn-success waves-effect waves-light inempBtn">
                     <i class="ri-check-line align-middle me-2"></i> 등록
                 </button>
                 <button type="reset" onclick="Confirm();" class="btn btn-danger waves-effect waves-light">
                    <i class="ri-close-line align-middle me-2"></i> 취소
                </button>
					
				  </div>

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
				   <img id="pic" style="width:150px; height:200px;">
				  </div>
				  <div class = "right">
				  증명사진을 첨부해주세요.
				  </div>
				  <br>
				  <div class="form-group">
			        	<input type="file" id="input_imgs" name="uploadFile" />
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
               <h4 class="card-title ri-pencil-fill">회사 정보</h4>
               <hr>
            <div class="row mb-3">
                <label for="empPosition" class="col-sm-2 col-form-label">직원 직급</label>
                 <div class="col-sm-10">
                <form:select id="empPo" path="empPosition" class="form-control select2-search-disable select2-hidden-accessible" data-select2-id="6" tabindex="-1" aria-hidden="true">                                   
                        <option value="H205" data-select2-id="83">부장</option>
                        <option value="H204" data-select2-id="84">과장</option>
                        <option value="H203" data-select2-id="85">대리</option>
                        <option value="H202" data-select2-id="86">주임</option>
                        <option value="H201" data-select2-id="86" selected>사원</option>
                </form:select>
                </div>
            </div>
            
            <div class="row mb-3">
                <label for="deptId" class="col-sm-2 col-form-label">부서</label>
                 <div class="col-sm-7">
                	<form:hidden path="deptId" />                                   
                	<form:input path="deptName" class="form-control select2-search-disable select2-hidden-accessible" data-select2-id="6" tabindex="-1" aria-hidden="true" />                                   
                </div>
                <button type="button" class="btn btn-primary btn-icon-split btn-sm col-sm-2 treeDepartBtn" data-toggle="modal" data-target="#deptModal" value="treeAll">
				 <span class="text">부서 검색</span>
				</button>
            </div>  
            
            <div class="row mb-3">
               <label for="example-url-input" class="col-sm-2 col-form-label">입사 일자</label>
               <div class="col-sm-10">
                   <form:input class="form-control" id="empEcnyYmd" path="empEcnyYmd" type="date"/>
                   <font color="red" style="font-size:8pt;">
					<form:errors path="empEcnyYmd" />
				</font>
                </div>
            </div>
			<!-- <div class="row mb-3">
                <label for="example-url-input" class="col-sm-2 col-form-label">이력서</label>
                <div class="col-sm-10">
                   <div class="form-group">
			        	<input type="file" id="input_imgs" name="uploadFile" />
			        </div>
                </div>
            </div> -->
           </div>
       </div>
             
         </div>
     </div>
     
     <div class="col-lg-6">
         <div class="card">
             <div class="card-body -ms-overflow-style: none; ">
                 <h4 class="card-title ri-pencil-fill"> 신상정보</h4>
                <hr>
                 <div class="table-responsive">
                     <table class="table table-dark mb-0">
                
					   	<div class="row mb-3">
                              <label for="example-search-input" class="col-sm-2 col-form-label">성명</label>
                              <div class="col-sm-10">
                                  <form:input class="form-control" id="empName" path="empName" />
                              	  <font color="red" style="font-size:8pt;">
				            	  <form:errors path="empName" />
				            	  </font>
                              </div>
                         </div>
                          
                        <div class="row mb-3">
                              <label for="example-email-input" class="col-sm-2 col-form-label">생년월일</label>
                              <div class="col-sm-10">
                                  <form:input class="form-control" path="empBirth" id="empBirth" />
                                  <font color="red" style="font-size:8pt;">
			            		  <form:errors path="empBirth" />
			            		  </font>
                              </div>
                        </div>  
                        
<!--                          <div class="row mb-3"> -->
<!--                               <label for="example-text-input" class="col-sm-2 col-form-label">직원번호</label> -->
<!--                               <div class="col-sm-10"> -->
<%--                                     <form:input class="form-control" path="empId" /> --%>
<!--                                   	<font color="red" style="font-size:8pt;"> -->
<%-- 			            			<form:errors path="empId" /> --%>
<!-- 			           		 		</font> -->
<!--                               </div> -->
<!--                           </div> -->
                              
                          <div class="row mb-3">
                              <label for="example-password-input" class="col-sm-2 col-form-label">비밀번호</label>
                              <div class="col-sm-10">
                                  <form:input class="form-control" path="empPassword" type="password" id="password"/>
                              		<font color="red" style="font-size:8pt;">
			            			<form:errors path="empPassword" />
			            			</font>
                              </div>
                          </div>
                          
                        <div class="row mb-3">
                             <label for="example-url-input" class="col-sm-2 col-form-label">연락처</label>
                             <div class="col-sm-10">
                                <form:input class="form-control" path="empTel" id="empTel"/>
                             	<font color="red" style="font-size:8pt;">
				            	<form:errors path="empTel" />
				            	</font>
                             </div>
                        </div>   
                         
                       <div class="row mb-3">
                           <label for="example-tel-input" class="col-sm-2 col-form-label">이메일</label>
                           <div class="col-sm-10">
                               <form:input class="form-control" path="empEmail" id="empEmail"/>
                      	 </div>
                       </div>
                       
                       <div class="row mb-3">
                             <label for="example-password-input" class="col-sm-2 col-form-label">직원 주소</label>
                             <div class="col-sm-7">
                                 <form:input path="empPostno"  class="form-control"  value=""/>
                             </div>
					          <button type="button" onclick="openHomeSearch()" class="btn btn-primary btn-icon-split btn-sm col-sm-2">
						          <span class="text">우편번호 검색</span>
						      </button>
			           </div>
			                         
				        <div class="row mb-3">
                          <label for="example-number-input" class="col-sm-2 col-form-label">주소</label>
                          <div class="col-sm-10">
                              <form:input path="empAddr1"  class="form-control" type="text" />
                          </div>
                        </div>
		  
                         <div class="row mb-3">
                           <label for="example-number-input" class="col-sm-2 col-form-label">상세주소</label>
                           <div class="col-sm-10">
                               <form:input path="empAddr2"  class="form-control" type="text" />
                           </div>
                         </div>  
                         <br>                           
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
	       			<div class="modal-footer"> 
	       			</div> 
       			</div> 
      	 	</div> 
   	   </div>

<script type="text/javascript">

/* 파일 첨부 시작 */
var sel_file;

function handleImgFileSelect(e) {
    var files = e.target.files;
    var filesArr = Array.prototype.slice.call(files); // 배열로 바꾸깅, OK!

    filesArr.forEach(function(f) {
        if(!f.type.match("image.*")) {
            alert("이미지 파일만 첨부해주세요.");
            return;
        }

        sel_file = f;
        var reader = new FileReader();
        reader.onload = function(e) {
        	console.log(e.target.result);
            $("#pic").attr("src", e.target.result);
        }
        reader.readAsDataURL(f);
    });
}
/* 파일 첨부 끝 */

/* 조직도 시작 */
$(function(){
	
	var token = "${_csrf.token }";
	var header = "${_csrf.headerName }";
	
	$("#input_imgs").on("change", handleImgFileSelect);
	
	/* 위에 이벤트가 있으니까 $(document)로 처리해 줘야 함
		*/
	$(document).on("click", ".deptName", function(){
		console.log($.trim($(this).text()));
		var deptName = $.trim($(this).text());
		var deptId = $.trim($(this).data("deptid"));
		$("#deptModalClose").trigger("click");
		$("#deptName").val(deptName);
		$("#deptId").val(deptId);
		
	})
	
	$('#deptModal').on('hide.bs.modal', function (e) {
    	$(".modal-backdrop").remove();
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
// 				alert(xhr.status)
			},
			beforeSend: function (xhr) {
	                xhr.setRequestHeader(header, token)
			},
			dataType: "json"
		})
	})
})

/* 조직도 끝 */

</script>


