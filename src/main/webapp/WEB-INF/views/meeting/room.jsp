<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- 커스텀 CSS -->
<link rel="stylesheet" href="/resources/css/autho.css" type="text/css"/>

<div class="row m-1">
	<h3>회의실 현황</h3>
</div>

<div class="row m-1">
	<div class="card overflow-hidden card-h-100 ">
		<div class="card-body" id="j-card">
			<div class="row mb-3">
				<div class="col-sm-2">
					<label id="label1" for="mtngRsrvtDt" class="col-form-label">예약일</label>
					<input type="text" name="mtngRsrvtDt" id="mtngRsrvtDt" class="form-control">
				</div>
				<div class="col-sm-2">
					<label for="mtngTypeId" class="col-form-label">회의실</label>
					<select name="mtngTypeId" id="mtngTypeId" class="form-select">
						<option value="">선택</option>
						<option value="E201" label="세미나실1"/>
						<option value="E202" label="세미나실2"/>
						<option value="E203" label="세미나실3"/>
						<option value="E204" label="세미나실4"/>
					</select>
				</div>
				<div class="col-sm-2 align-self-end">
					<button type="button" id="mtngRsrvtBtn" class="btn btn-primary">조회</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$.datepicker.setDefaults({
	dateFormat: 'yy-mm-dd',
	prevText: '이전 달',
	nextText: '다음 달',
	monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	showMonthAfterYear: true,
	yearSuffix: '년'
});

$(function () {
	$('#mtngRsrvtDt').datepicker();
});
</script>

