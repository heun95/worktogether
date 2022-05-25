<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!-- 줄바꿈 설정 -->
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
<% 
pageContext.setAttribute("br", "<br/>"); 
pageContext.setAttribute("cn", "\n"); 
%>
</script>
<div class="container-fluid">

	<!-- start page title -->
	<div class="col-12">
		<div
			class="page-title-box d-flex align-items-center justify-content-between">
			<a href="/qna/list"><h2>QnA</h2></a>
		</div>
	</div>
	<div class="card">
		<div class="card-body">
			<div class="table-responsive">
				<table class="table mb-0">
					<tr>
						<td style="width: 80px;">작성자 : ${boardVO.brdWrtr}</td>
						<td style="width: 130px;">작성일 : <fmt:formatDate
								value="${boardVO.brdWrtDt}" pattern="yyyy/MM/dd" /></td>
						<td style="width: 130px;">수정일 : <fmt:formatDate
								value="${boardVO.brdMdfyDt}" pattern="yyyy/MM/dd" /></td>
						<td style="width: 100px;">조회수 : ${boardVO.brdHit}</td>
					</tr>
					<tr>
						<td colspan="4" style="width: 250px;"><br>
							<h4>${boardVO.brdTitle }</h4>
							<hr> <br> ${fn:replace(boardVO.brdCntnt, cn, br) }
							<p></td>
					</tr>
				</table>
			</div>
		</div>
	</div>

	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
				<form:form modelAttribute="boardReplyVO" method="post"
					action="/qna/rinsert?brdId=${boardReplyVO.brdId}&currentPage=${currentPage}">

					<div class="table-responsive">
						<div>
							<form:textarea class="form-control" placeholder="댓글을 입력하세요"
								rows="3" path="brdRplyCntnt" />
						</div>
						<br>
						<div align="right">
							<form:button type="submit" path="btnRConfirm"
								class="btn btn-sm btn-success btn-icon-split">댓글등록</form:button>
						</div>
					</div>
				</form:form>
				<br>
				<div class="col-lg-12">
					<table width="100%">
						<tr id="rupdateFormTr">
							<td colspan="3">
								<form action="/qna/rupdate" method="post" id="rupdateForm"
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

						<c:forEach var="boardReplyVO" items="${rlist}">
							<tr>
								<td>작성자 : ${boardReplyVO.brdRplyWrtr }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>작성일 : <fmt:formatDate
										value="${boardReplyVO.brdRplyWrtDt }" pattern="yyyy/MM/dd" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
								<td>
									<%-- 								${boardReplyVO.brdRplyWrtr}<br> --%> <%-- 								${userName } --%>
									<%-- 								<sec:authentication property="principal.user.empName"/> --%>
									<c:if test="${boardReplyVO.brdRplyWrtr == userName }">
										<a
											href="/qna/rdelete?brdId=${boardReplyVO.brdId}&brdRplyId=${boardReplyVO.brdRplyId}&currentPage=${currentPage}"
											id="btnRDelete"
											class="btn btn-sm btn-secondary btn-icon-split">삭제</a>
										<a
											href="javascript:viewForm(${boardReplyVO.brdRplyId}, '${boardReplyVO.brdRplyCntnt }')"
											id="btnREdit" class="btn btn-sm btn-info waves-effect waves-light">수정</a>
									</c:if> <c:if test="${boardReplyVO.brdRplyWrtr != userName }">
										<sec:authorize access="hasRole('ROLE_ADMIN')">
											<a
												href="/qna/rdelete?brdId=${boardReplyVO.brdId}&brdRplyId=${boardReplyVO.brdRplyId}&currentPage=${currentPage}"
												id="btnRDelete"
												class="btn btn-sm btn-secondary btn-icon-split">삭제</a>
										</sec:authorize>

									</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="3">${fn:replace(boardReplyVO.brdRplyCntnt, cn, br) }</td>
							</tr>
						</c:forEach>

					</table>
				</div>

			</div>
		</div>
	</div>
</div>

<div class="col-lg-12 py-5" align="right">
	<c:if test="${boardVO.brdWrtr == userName}">
		<a href="/qna/delete?brdId=${param.brdId}" id="btnDelete"
			class="btn btn-secondary btn-icon-split">삭제</a>
		<a href="/qna/update?brdId=${param.brdId}" id="btnEdit"
			class="btn btn-info waves-effect waves-light">수정</a>
	</c:if>

	<c:if test="${boardVO.brdWrtr != userName }">
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<a href="/qna/delete?brdId=${param.brdId}" id="btnDelete"
				class="btn btn-secondary btn-icon-split">삭제</a>
		</sec:authorize>
	</c:if>

	<a href="/qna/list?currentPage=${currentPage}"
		class="btn btn-danger btn-user">목록보기</a>
</div>

<script>
	function viewForm(brdId, content) {
		$("#upbrdRplyId").val(brdId);
		$("#upbrdRplyCntnt").val(content);
		$(this).parent().parent().after($("#rupdateFormTr"));
		$("#rupdateForm").show();

	}
</script>