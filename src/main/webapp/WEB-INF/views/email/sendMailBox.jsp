<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
	function fn_submit(){
		var frm = document.searchForm;
		console.log("frm.keyWord : " + frm.keyWord.value);
		frm.submit();
	}
	function deletechoiceMail(){
		var delMail = [];
		$("input:checkbox[name=check]:checked").each(function(){
			delMail.push($(this).val());
		});
		
		$.ajax({
			url : "/email/deletesendChoice",
			data : {delSendArr : delMail},
			type : "get",
			success : function(data){
				if(data=="success"){
					location.href = "/email/sendMailBox";
				}else{
					alert("메일 삭제 실패");
				}
			},
			error : function(xhr){
				alert("오류...")
			},
			dataType : "text"
		});
	}	

</script>
<style>
input[type="checkbox"]+label {
    display: block;
    width: 24px;
    height: 24px;
    background: url('/resources/images/unchecked.png') no-repeat 0 0px / contain;
}

 input[type="checkbox"]:checked+label { 
     background: url('/resources/images/checked.png') no-repeat 0 1px / contain; 
 } 

 input[type="checkbox"] { 
     display: none; 
 } 
</style>
<!-- Page Heading -->
<div  style="margin-bottom:10px;" >
<h2 class="m-0 font-weight-bold text-primary">보낸메일함
<img src="/resources/images/email.png" style="width: 40px; height: 40px; margin-bottom:10px;"/></h2>
</div>
<!-- DataTales Example -->
<div class="card shadow mb-4">
    <div class="card-body" style="height: 80vh;">
        <div class="table-responsive">
            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
            	<!-- 검색하는 부분  시작-->
		            <form name="searchForm" id="searchForm" action="/email/sendMailBox" method="get">
		            <label>Search:
		            <input type="search" name="keyWord" id="keyWord" class="form-control form-control-sm" placeholder="검색어를 입력해주세요" aria-controls="dataTable" value="${param.keyWord}"></label>
		            &nbsp;
		            <a href="#"  class="btn btn-primary btn-lg btn-radius" style="margin-bottom: 15px;"  onclick="fn_submit()">
		                <span class="icon text-white-50">
		                    <i class="fas fa-check"></i>
		                </span>
		                <span class="text">검색</span>
		            </a>
		            <input type="button" style="float: right;margin-top: 13px; " onclick="deletechoiceMail()" value="선택메일 삭제하기"   class="btn btn-outline-primary waves-effect waves-light"/>
		            </form>
		        <!-- 검색하는 부분  끝-->
            <div class="row" style="height: 60vh;"><div class="col-sm-12">
            <table style="text-align: center;" class="table table-bordered dataTable table-striped" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
                <thead>
                <tr role="row">
                    <th style="width: 25px;">No</th>                
                    <th style="width: 25px;"><img src="/resources/images/checked.png" style="width: 24px; height: 24px;"/></th>                
                    <th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending" style="width: 200px;">수신자&nbsp;&nbsp;ID&nbsp;&nbsp;|&nbsp;&nbsp;이름</th>
                    <th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">제목</th>
                    <th style="width: 250px;">메일작성일자</th>
                    <th style="width: 150px;">수신여부</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="row" items="${list}" varStatus="status">
               	<tr>
               		<td>${((page.currentPage-1)*7)+status.count}</td>             
               		<td>
	               		<c:set var="count" value="${status.count}" />
	               		<input type="checkbox" id="ck${count}" name="check" value="${row.emailId}"/><label for="ck${count}"></label>
               		</td>              	
                    <td>${row.emailRcvId} | ${row.empName }</td>
                    <td style="text-align:left;"><a href="/email/sendMailDetail?emailId=${row.emailId}">${row.emailTitle}</a></td>
                    <td><fmt:formatDate value="${row.emailWrtDt}"  pattern="yyyy-MM-dd  hh:mm"/></td>
					<td>${row.emailSee}</td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
            </div>
            </div>
            <!-- 페이징 처리 시작 -->
				<ul class="pagination">
					<!-- Previous 시작 -->
					<li
						class="paginate_button page-item previous <c:if test='${page.startPage<page.pagingCount+1}'>disabled</c:if>"
						id="dataTable_previous">
						<a href="/email/sendMailBox?currentPage=${page.startPage-page.pagingCount}&keyWord=${param.keyWord}"
						aria-controls="dataTable" data-dt-idx="0" tabindex="0"
						class="page-link">Previous</a>
					</li>
					<!-- Previous 끝 -->
					<!-- Page번호 시작 -->
					<c:forEach var="pNo" begin="${page.startPage}" end="${page.endPage}"
						step="1">
						<li
							class="paginate_button page-item <c:if test='${page.currentPage eq pNo}'>active</c:if>">
							<a href="/email/sendMailBox?currentPage=${pNo}&keyWord=${param.keyWord}"
							aria-controls="dataTable" data-dt-idx="1" tabindex="0"
							class="page-link">${pNo}</a>
						</li>
					</c:forEach>
					<!-- Page번호 끝 -->
					<!-- Next 시작 -->
					<li
						class="paginate_button page-item next <c:if test='${page.endPage>=page.totalPages}'>disabled</c:if>"
						id="dataTable_next"><a
						href="/email/sendMailBox?currentPage=${page.startPage+page.pagingCount}&keyWord=${param.keyWord}"
						aria-controls="dataTable" data-dt-idx="7" tabindex="0"
						class="page-link">Next</a></li>
					<!-- Next 끝 -->
				</ul>
			<!-- 페이징 처리 끝 -->
            </div>
        </div>
    </div>
</div>





