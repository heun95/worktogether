<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="container-fluid">

	<!-- start page title -->
	<div class="col-12">
		<div
			class="page-title-box d-flex align-items-center justify-content-between">
			<a href="/community/list2"><h2>익명게시판</h2></a>
		</div>
	</div>
	<div class="card">
		<div class="card-body">
			<div class="table-responsive">
				<table class="table mb-0">
					<tr>
						<td style="width: 80px;">작성자 : 익명</td>
						<td style="width: 130px;">작성일 : <fmt:formatDate
								value="${boardVO.brdWrtDt}" pattern="yyyy-MM-dd" /></td>
						<td style="width: 130px;">수정일 : <fmt:formatDate
								value="${boardVO.brdMdfyDt}" pattern="yyyy-MM-dd" /></td>
						<td style="width: 100px;">조회수 : ${boardVO.brdHit}</td>
					</tr>
					<tr>
						<td colspan="4" style="width: 250px;"><br>
							<h4>${boardVO.brdTitle}</h4>
							<hr> <br> ${boardVO.brdCntnt}
							<p></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
				<h6>첨부파일</h6>
				<br>
				<div class="input-group">
					<table class="table">
						<thead class="thead-light">
							<c:forEach items="${files}" var="file" varStatus="idx" step="1">
								<tr onclick='downloadFile("${file.atchId}")'>
									<td class="table-font-center">${file.atchName}</td>
								</tr>
							</c:forEach>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
				<form:form modelAttribute="boardReplyVO" method="post"
					action="/community/rinsert2?brdId=${boardReplyVO.brdId}&currentPage=${currentPage}">

					<div class="table-responsive">
						<div>
							<form:textarea class="form-control" placeholder="댓글을 입력하세요"
								rows="3" path="brdRplyCntnt" />
						</div>
						<br>
						<div align="right">
							<input type="hidden" name="brdRcvId" value="${boardVO.brdRcvId}">
							<form:button type="submit" class="btn btn-sm btn-success btn-icon-split">댓글등록</form:button>
						</div>
					</div>
					
				</form:form>
				<br>
				<div class="col-lg-12">
					<table width="100%">
						<tr id="rupdateFormTr">
							<td colspan="3">
								<form action="/community/rupdate2" method="post" id="rupdateForm"
									style="display: none;">
									<sec:csrfInput />
									<input type="hidden" name="brdRplyId" id="upbrdRplyId">
									<input type="hidden" name="brdId" value="${boardReplyVO.brdId}">
									<input type="hidden" name="currentPage" value="${currentPage}">
									<textarea class="col-lg-12" name="brdRplyCntnt"
										id="upbrdRplyCntnt" rows="3"></textarea>
									<div align="right">
										<input type="submit" value="수정등록"
											class="btn btn-sm btn-secondary btn-icon-split">
									</div>
									<br>
								</form>
							</td>
						</tr>
						
						<!-- 댓글 목록 -->
						<c:forEach var="boardReplyVO" items="${rlist2}">
							<tr>
								<td>작성자 : 익명&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>작성일 : <fmt:formatDate
										value="${boardReplyVO.brdRplyWrtDt}" pattern="yyyy/MM/dd" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
								<td>
	<%-- 								${boardReplyVO.brdRplyWrtr}<br> --%> <%-- 								${userName } --%>
	<%-- 								<sec:authentication property="principal.user.empName"/> --%>
									
									<c:if test="${boardReplyVO.brdRplyWrtr == userName}">
										<a
											href="/community/rdelete2?brdId=${boardReplyVO.brdId}&brdRplyId=${boardReplyVO.brdRplyId}&currentPage=${currentPage}"
											id="btnRDelete"
											class="btn btn-sm btn-secondary btn-icon-split">삭제</a>
										<a
											href="javascript:viewForm(${boardReplyVO.brdRplyId}, '${boardReplyVO.brdRplyCntnt}')"
											id="btnREdit" class="btn btn-sm btn-info waves-effect waves-light">수정</a>
									</c:if>
									
									<c:if test="${boardReplyVO.brdRplyWrtr != userName}">
										<sec:authorize access="hasRole('ROLE_ADMIN')">
											<a
												href="/community/rdelete2?brdId=${boardReplyVO.brdId}&brdRplyId=${boardReplyVO.brdRplyId}&currentPage=${currentPage}"
												id="btnRDelete"
												class="btn btn-sm btn-secondary btn-icon-split">삭제</a>
										</sec:authorize>
									</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="3">${boardReplyVO.brdRplyCntnt}</td>
							</tr>
						</c:forEach>

					</table>
			  </div>

			</div>
		</div>
	</div>
	<div class="col-lg-12 py-5" align="right">
		<!-- 자기 자신이 쓴 게시글일때 -->
		<c:if test="${boardVO.brdWrtr == userName}">
			<a href="/community/delete2?brdId=${param.brdId}" id="btnDelete"
				class="btn btn-secondary btn-icon-split">삭제</a>
			<a href="/community/update2?brdId=${param.brdId}" id="btnEdit"
				class="btn btn-info waves-effect waves-light">수정</a>
		</c:if>
		<!-- 인사팀으로 로그인했을때 -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<c:if test="${boardVO.brdWrtr != userName}">
				<a href="/community/delete2?brdId=${param.brdId}" id="btnDelete"
				class="btn btn-secondary btn-icon-split">삭제</a>
			</c:if>
		</sec:authorize>
		<a href="/community/list2?currentPage=${currentPage}"
			class="btn btn-danger btn-user">목록보기</a>
	</div>
</div>


<script>
	function downloadFile(filename) {
		const encFileName = encodeURI(filename);
		$.ajax({
			method : "GET",
			url : `fileDownLoad.do`,
			success : function(data) {
				window.location = `fileDownLoad.do?FileName=${encFileName}`;
			},
			error : function(request, status) {
				alert("오류가 발생했습니다.");
			}
		});
	}
	
	function viewForm(brdId, content) {
		$("#upbrdRplyId").val(brdId);
		$("#upbrdRplyCntnt").val(content);
		$(this).parent().parent().after($("#rupdateFormTr"));
		$("#rupdateForm").show();

	}
</script>