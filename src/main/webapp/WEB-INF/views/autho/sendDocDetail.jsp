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

<!-- 커스텀 CSS -->
<link rel="stylesheet" href="/resources/css/autho.css" type="text/css"/>

<style>
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
</style>

<div class="row m-1">
	<h3 class="h3 mb-2 text-gray-800" style="color: #6c6ff5">보낸 결재함</h3>
</div>

<div class="row m-1">
	<div class="card overflow-hidden card-h-100 ">
		<div class="card-body" id="j-card">
			<div class="row gx-10 mb-3">
				<div class="col-md-2">
					<div class="mb-3">
						<label for="docTypeName" class="form-label">문서종류</label>
						<input id="docTypeName" type="text" class="form-control" value="${atrzDocVO.docTypeName }" readonly>
					</div>
				</div>
				<div class="col-md-2">
					<div class="mb-3">
						<label for="docRetention" class="form-label">보존연한</label> 
						<input id="docRetention" type="text" class="form-control" value="${atrzDocVO.docRetention }" readonly>
					</div>
				</div>
				<div class="col-md-2">
					<div class="mb-3">
						<label for="docWrtrName" class="form-label">작성자</label> 
						<input id="docWrtrName" type="text" class="form-control" value="${atrzDocVO.docWrtrName }" readonly>
					</div>
				</div>
				<div class="col-md-2">
					<div class="mb-3">
						<label for="docDeptName" class="form-label">부서명</label> 
						<input id="docDeptName" type="text" class="form-control" value="${atrzDocVO.docDeptName }" readonly>
					</div>
				</div>
				<div class="col-md-2">
					<div class="mb-3">
						<label for="docState" class="form-label">문서상태</label> 
						<input id="docState" type="text" class="form-control" value="${atrzDocVO.docState }" readonly>
					</div>
				</div>
				<div class="col-md-2">
					<div class="mb-3">
						<label for="atrzState" class="form-label">결재상태</label> 
						<input id="atrzState" type="text" class="form-control text-light bg-dark" value="${atrzDocVO.atrzState }" readonly>
					</div>
				</div>
			</div>
	
			<div class="row mb-0">
				<div class="col-sm-12">
					<label class="form-label">결재선</label>
				</div>
			</div>
			<div class="row mb-4">
				<div class="col-sm-12">
				<table class="table mb-0 table-bordered border-primary align-middle text-center" id="j-table">
	                <tr>
	                    <td style="width:10%;" rowspan="3" class="col-md-1 table-primary">결재</td>
	                    <td class="table-secondary">
	                    	<input type="text" class="j-input-text" value="${atrzDocVO.atrzLineDetailList[0].positionName}" readonly>
	                    </td>
	                    <td class="table-secondary">
	                    	<input type="text" class="j-input-text" value="${atrzDocVO.atrzLineDetailList[1].positionName}" readonly>	
	                    </td>
	                    <td class="table-secondary">
	                    	<input type="text" class="j-input-text" value="${atrzDocVO.atrzLineDetailList[2].positionName}" readonly>
	                    </td>
	                    <td class="table-secondary">
	                    	<input type="text" class="j-input-text" value="${atrzDocVO.atrzLineDetailList[3].positionName}" readonly>
	                    </td>
	                    <td class="table-secondary">
	                    	<input type="text" class="j-input-text" value="${atrzDocVO.atrzLineDetailList[4].positionName}" readonly>
	                    </td>
	                </tr>
	                <tr>
	                   <c:forEach var="i" begin="0" end="4">
	           		 	<td class="j-td">
	               		 <c:choose>
	               		 	<c:when test="${atrzPathList[i] == null}">
	               		 		<img src="/resources/upload/autho/sign/EMPL00000/sign0.png" style="width:100%; height:100%;">
	               		 	</c:when>	
							<c:otherwise>
								<img src="${atrzPathList[i]}" style="width:100%; height:100%;">
							</c:otherwise>
	               		 </c:choose>
	                	</td>
	               	 </c:forEach>
	                </tr>
	                <tr>
	                    <td class="table-secondary">
	                    	<input type="text" class="j-input-text" value="${atrzDocVO.atrzLineDetailList[0].atrzName}" readonly>
	                    </td>
	                    <td class="table-secondary">
	                    	<input type="text" class="j-input-text" value="${atrzDocVO.atrzLineDetailList[1].atrzName}" readonly>
	                    </td>
	                    <td class="table-secondary">
	                    	<input type="text" class="j-input-text" value="${atrzDocVO.atrzLineDetailList[2].atrzName}" readonly>
	                    </td>
	                    <td class="table-secondary">
	                    	<input type="text" class="j-input-text" value="${atrzDocVO.atrzLineDetailList[3].atrzName}" readonly>
	                    </td>
	                    <td class="table-secondary">
	                    	<input type="text" class="j-input-text" value="${atrzDocVO.atrzLineDetailList[4].atrzName}" readonly>
	                    </td>
	                </tr>
		        </table>
		        </div>
	        </div>
			
			<div class="row mb-3">
				<div class="col-sm-1">
					<label for="docTitle" class="col-form-label">제목</label>
				</div>
				<div class="col-sm-11">
					<input id="docTitle" type="text" value="${atrzDocVO.docTitle}" class="form-control" readonly/>
				</div>
				
			</div>
			
			<div class="row mb-3">
				<div class="col-sm-12">
					<label class="form-label">내용</label>
					<div class="form-control" >
						<img src="${atrzDocVO.docContentPath }">
					</div>
				</div>
			</div>
			
			<div class="row mb-3">
				<c:if test="${atrzDocVO.docState == '반려'}">
					<button type="button" class="btn btn-primary ms-2" onclick="javascript:location.href='/autho/create'" style="width:10%;">다시 작성하기</button>
				</c:if>
				<div class="col d-flex flex-row-reverse bd-highlight">
					<button type="button" class="btn btn-danger ms-2" id="j-cancelBtn" style="width:10%;">뒤로가기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	$("#j-cancelBtn").on("click",function(){
		location.href = "/autho/sendDoc";
	})
	if("${param.selectB}"=="B"){
		alert("문서작성이 완료되었습니다.");
	}
})
</script>