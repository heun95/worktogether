<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<form:form modelAttribute="crtfcAplictVO" method="post"
	action="/human/insertcertificate" enctype="multipart/form-data">
<div class="row">
     <div class="col-xl-8">
         <div class="card">
             <div class="card-body">
                 <h2 class="card-title mb-4 ri-file-list-fill"> 증명서신청내역</h2>
 
                 <div class="table-responsive">
                     <table class="table table-centered table-nowrap mb-0">
                         <thead class="thead-light">
                             <tr>
                                 <th>신청번호</th>
                                 <th>증명서구분</th>
                                 <th>신청일자</th>
                                 <th>사원번호</th>
                                 <th>성명</th>
                                 <th>발급상태</th>
                                 <th>발행일자</th>
                                 <th>용도</th>
                             </tr>
                         </thead>
						 <tbody>
						<c:forEach var="row" items="${list2}">
							<tr>
								<td></td>
								<td>${row.crtfcAplctId}</td>
								<td>${row.crtfcTypeId}</td>
								<td><fmt:formatDate value="${row.crtfcAplctDt}"
										type="date" /></td>	
								<td>${row.crtfcAplctDt}</td>
								<td>${row.crtfcAplctEmpId}</td>
								<td>${row.crtfcAplctEmpId}</td>
								<td>${row.crtfcAplctState}</td>
								<td><fmt:formatDate value="${row.crtfcIssueDt}"
										type="date" /></td>
								<td>${row.crtfcUse}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
                 </div>                        
             </div><!-- end card-body -->
         </div><!-- end card -->
     </div><!-- end col -->
 
     <div class="col-xl-4">
         <div class="card">
             <div class="card-body">
             <div class="row">
                 <h2 class="card-title mb-4 ri-pencil-fill"> 증명서 신청</h2>
             </div>
                 <div class="mt-4 pt-3 mt-sm-0 px-3">
 
                     <div class="d-flex py-3">
                         <div class="flex-grow-1">
                             <p class="mb-2 text-muted">증명서 구분</p>
                             <div class="col-sm-10">
									<select id="crtfcTypeId" name="crtfcTypeId" tabindex="-1" aria-hidden="true" data-select2-id="6" class="form-control select2-search-disable select2-hidden-accessible">
										<option value="D101" data-select2-id="83">재직증명서</option>
										<option value="D102" data-select2-id="84">경력증명서</option>
									</select>
								</div>
                         </div>
                         
                     </div>
                     <div class="d-flex pt-3 border-top">
                         <div class="flex-grow-1">
                             <p class="mb-2 text-muted">발급 용도</p>
                             <textarea name="crtfcUse" class="form-control" id="billing-address" rows="3" placeholder="Enter full address"></textarea>
                         </div>
          </div><!-- end card-body -->
              </div>
                <br>
                <div class="form-group" style="float: right;">
					<button type="submit" class="mb-2 btn btn-sm btn-success mr-1">등록</button>
					<button type="reset" class="mb-2 btn btn-sm btn-danger mr-1">취소</button>
				</div>
             </div>
         </div><!-- end card -->
     </div><!-- end col -->

 </div>
 
 </form:form>