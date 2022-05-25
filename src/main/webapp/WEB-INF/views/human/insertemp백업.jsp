<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	
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
	
</script>
<form:form modelAttribute="employeeVO" method="post" action="/human/insertemp"
	enctype="multipart/form-data">  
<div class="page-content">
          <div class="container-fluid">
			<!-- start page title -->
              <div class="row">
                  <div class="col-12">
                      <div class="page-title-box d-flex align-items-center justify-content-between">
                          <h4 class="mb-0">직원 등록</h4>

                      </div>
                  </div>
              </div>
              <!-- end page title -->

              <div class="row">
                  <div class="col-12">
                      <div class="card">
                          <div class="card-body">

							<strong class="text-muted d-block mb-2">증명사진</strong>
					        <div class="form-group">
					        	<div class="imgs_wrap"></div>
					        </div>
					        <div class="form-group">
					        	<input type="file" id="input_imgs" name="uploadFile" multiple />
					        </div>	

                              <div class="row mb-3">
                                  <label for="example-text-input" class="col-sm-2 col-form-label">직원번호</label>
                                  <div class="col-sm-10">
                                      <form:input class="form-control" path="empId" placeholder="EMPL00001"/>
                                      	<font color="red" style="font-size:8pt;">
							            	<form:errors path="empId" />
							            </font>
                                  </div>
                              </div>
                              <div class="row mb-3">
                                  <label for="example-password-input" class="col-sm-2 col-form-label">비밀번호</label>
                                  <div class="col-sm-10">
                                      <form:input class="form-control" path="empPassword"  type="password" placeholder="******"/>
                                  		<font color="red" style="font-size:8pt;">
							            	<form:errors path="empPassword" />
							            </font>
                                  </div>
                              </div>
                    
                              <div class="row mb-3">
                                  <label for="example-search-input" class="col-sm-2 col-form-label">성명</label>
                                  <div class="col-sm-10">
                                      <form:input class="form-control" path="empName" placeholder="백이진"/>
                                  		<font color="red" style="font-size:8pt;">
							            	<form:errors path="empName" />
							            </font>
                                  </div>
                              </div>
                              <div class="row mb-3">
                                  <label for="example-email-input" class="col-sm-2 col-form-label">생년월일</label>
                                  <div class="col-sm-10">
                                      <form:input class="form-control" path="empBirth" placeholder="1994/02/22"/>
                                      <font color="red" style="font-size:8pt;">
							            	<form:errors path="empBirth" />
							            </font>
                                  </div>
                              </div>
                              <div class="row mb-3">
                                  <label for="example-url-input" class="col-sm-2 col-form-label">연락처</label>
                                  <div class="col-sm-10">
                                      <form:input class="form-control" path="empTel" placeholder="010-1234-5678"/>
                                  		<font color="red" style="font-size:8pt;">
							            	<form:errors path="empTel" />
							            </font>
                                  </div>
                              </div>
                              <div class="row mb-3">
                                  <label for="example-tel-input" class="col-sm-2 col-form-label">이메일</label>
                                  <div class="col-sm-10">
                                      <form:input class="form-control" path="empEmail" placeholder="naver@naver.com"/>
                                  </div>
                              </div>
                     
                              <div class="row mb-3">
                                  <label for="empPosition" class="col-sm-2 col-form-label">직원 직급</label>
                                   <div class="col-sm-10">
                                  <form:select path="empPosition" class="form-control select2-search-disable select2-hidden-accessible" data-select2-id="6" tabindex="-1" aria-hidden="true">                                   
                                          <option value="H201" data-select2-id="83">부장</option>
                                          <option value="H202" data-select2-id="84">과장</option>
                                          <option value="H203" data-select2-id="85">대리</option>
                                          <option value="H204" data-select2-id="86">주임</option>
                                          <option value="H205" data-select2-id="86">사원</option>
                                  </form:select>
                                  </div>
                              </div>
                              
                              <div class="row mb-3">
                                  <label for="deptId" class="col-sm-2 col-form-label">부서</label>
                                   <div class="col-sm-10">
                                  <form:select path="deptId" class="form-control select2-search-disable select2-hidden-accessible" data-select2-id="6" tabindex="-1" aria-hidden="true">                                   
                                          <option value="DEP01" data-select2-id="83">관리부</option>
                                          <option value="DEP02" data-select2-id="84">마케팅부</option>
                                          <option value="DEP03" data-select2-id="85">개발부</option>
                                          <option value="DEP04" data-select2-id="86">영업부</option>
                                  </form:select>
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
                              
                        
                           <div class="row mb-3">
                                  <label for="example-url-input" class="col-sm-2 col-form-label">이력서</label>
                                  <div class="col-sm-10">
                                      <form:input class="form-control" path="empResume"/>
                                  </div>
                              </div>
                           <div class="row mb-3">
                                  <label for="example-url-input" class="col-sm-2 col-form-label">입사 일자</label>
                                  <div class="col-sm-10">
                                      <form:input class="form-control" path="empEcnyYmd" type="date"/>
                                      <font color="red" style="font-size:8pt;">
							            	<form:errors path="empEcnyYmd" />
							           </font>
                                  </div>
                              </div>
                           
					          <div class="form-group" style="float:right;">
								<button type="submit" class="mb-2 btn btn-sm btn-success mr-1">등록</button>
								<button type="reset" class="mb-2 btn btn-sm btn-danger mr-1">취소</button>
							  </div>
                              
                          </div>
                      </div>
                  </div> <!-- end col -->
              </div>
              <!-- end row -->

          </div> <!-- container-fluid -->
      </div>
</form:form>

<script>

	$(function(){
		$("#input_imgs").on("change",handleImgsFilesSelect);
	});
	//e : change이벤트를 받음
	function handleImgsFilesSelect(e){
		//이벤트가 일어난 파일객체의 이미지 파일들을 가져옴
		var files = e.target.files;
		//파일들을 배열로 만들어 관리
		var filesArr = Array.prototype.slice.call(files);
		//f : 각각의 파일 객체
		filesArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert("이미지만 가능합니다.");
				//업로드 종료(실패)
				return;
			}
			//각 이미지를 reader로 읽어들임
			var reader = new FileReader();
			reader.onload = function(e){
				var img_html = "<img src=\"" + e.target.result + "\" style='width:100px;' />";
				$(".imgs_wrap").append(img_html);
			}
			reader.readAsDataURL(f);
		});//end forEach
	}
</script>









