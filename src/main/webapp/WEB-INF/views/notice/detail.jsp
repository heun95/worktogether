<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
			<a href="/notice/list"><h2>공지사항</h2></a>
		</div>
	</div>
	<div class="card">
		<div class="card-body">
			<div class="table-responsive">
				<table class="table mb-0">

					<tr>
						<td style="width: 80px;">작성자 : ${boardVO.brdWrtr }</td>
						<td style="width: 130px;">작성일 : <fmt:formatDate
								value="${boardVO.brdWrtDt }" pattern="yyyy/MM/dd" /></td>
						<td style="width: 130px;">수정일 : <fmt:formatDate
								value="${boardVO.brdMdfyDt }" pattern="yyyy/MM/dd" /></td>
						<td style="width: 100px;">조회수 : ${boardVO.brdHit }</td>
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
				<h6>첨부파일</h6>
				<br>
				<div class="input-group">
					<table class="table">
						<thead class="thead-light">
							<c:forEach items="${files}" var="file" varStatus="idx" step="1">
								<tr>
									<td class="table-font-center"><a href="${file.atchPath}"
										download>${file.atchName} </a></td>
								</tr>
							</c:forEach>
						</thead>
					</table>
				</div>

			</div>
		</div>
	</div>
	<div class="col-lg-12 py-5" align="right">
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<a href="/notice/delete?brdId=${param.brdId}" id="btnDelete"
				class="btn btn-secondary btn-icon-split">삭제</a>
			<a href="/notice/update?brdId=${param.brdId}" id="btnEdit"
				class="btn btn-info waves-effect waves-light">수정</a>
		</sec:authorize>
		<a href="/notice/list?currentPage=${currentPage}"
			class="btn btn-danger btn-user">목록보기</a>
	</div>
</div>
