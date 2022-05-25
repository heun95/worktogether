<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<script src="/resources/js/attendance.js"></script>
<style>
/* * { */
/* 	font-family: 'Lucida Sans'; */
/* } */

.date {
	font-size: 45px;
	color: rgb(155, 155, 155);
}

.time {
	font-size: 100px;
	font-weight: bold;
	color: B4B4FF;
}
</style>

<div class="p-4">
	<div class="card overflow-hidden mt-2">
		<div class="auth-logo text-center bg-primary position-relative">
			<div class="img-overlay"></div>
			<br>
			<div class="position-relative pt-4 py-5 mb-1">
				<h1 class="text-white">환영합니다</h1>
				<h3 class="text-white-50 mb-0">오늘 하루도 즐겁게~</h3>
			</div>
		</div>
		<div class="card-body position-relative">
			<br> <br> <br>
			<div id="attendance" class="p-4 mt-n5 card rounded">
				<form class="form-horizontal" action="index.html">
					<div class="alert alert-success text-center mb-4" role="alert">
						<div id="time" class="time"></div>
						<div id="date" class="date"></div>
					</div>
					<br>
					<div style="float: left" class="mt-3">
						<button class="btn btn-danger w-100 waves-effect waves-light"
							type="button" onclick="start();">출근하기</button>
					</div>

					<%-- 					<fmt:formatDate value="${row.emailWrtDt}" pattern="yyyy-MM-dd  hh:mm" /> --%>

					<div class="mt-3" style="float: right">
						<button class="btn btn-primary w-100 waves-effect waves-light"
							type="button" onclick="end(this);">퇴근하기</button>
					</div>
				</form>
				<c:set var="vo" value="${list}" />
				<p id="atndnDlyId">${vo.atndnDlyId}</p>
			</div>
		</div>
	</div>
</div>

<script>
	//미래 날짜형식 조작을 위해서 억지로 작성
// 	var v_atndCode = "ATDLXXXXX"; // 전역변수 코드 저장을 위함
	
	function getTodayDate() {
		var v_today = new Date();
		var v_year = v_today.getFullYear();
		var v_month = v_today.getMonth() + 1;
		var v_date = v_today.getDate();
		var v_hour = v_today.getHours();
		var v_min = v_today.getMinutes();
		var v_sec = v_today.getSeconds();

		if (v_month < 10) {
			v_month = "0" + v_month;
		}
		if (v_date < 10) {
			v_date = "0" + v_date;
		}
		if (v_hour < 10) {
			v_hour = "0" + v_hour;
		}
		if (v_min < 10) {
			v_min = "0" + v_min;
		}
		if (v_sec < 10) {
			v_sec = "0" + v_sec;
		}

		var v_datetime = v_year + "-" + v_month + "-" + v_date + "-" + v_hour
				+ ":" + v_min + ":" + v_sec;
		return v_datetime;
	}

	function start() {

		var v_realDateTime = getTodayDate().toString();
		//alert(v_realDateTime)	;  //체킁

		$.ajax({
			type : "get",
			dataType : "json",
			url : "/attendance/recordStart",
			data : "sdate=" + v_realDateTime,
			contentType : "application/text; charset=UTF-8",
			success : function(r_data) {
				alert(r_data.noticeMsg);
				v_atndCode = r_data.atndCode;
			}

		})
	};

	// 	console.log(v_start);

	function end(aaa) {
// 		var atndnDlyId = $(aaa).parents("#attendance").find("#atndnDlyId").val();
		var v_realDateTime = getTodayDate().toString();
// 		console.log(atndnDlyId);
		console.log(v_realDateTime);
		$.ajax({
			type : "get",
			dataType : "text",
			url : "/attendance/recordEnd",
			data : "sdate=" + v_realDateTime,
			contentType : "application/text; charset=UTF-8",
			success : function(msg) {
				console.log(atndnDlyId);
				alert(msg);
			}

		})

		// 	var v_end = document.querySelector("#time");
		// 		var v_end = document.querySelector("#time").innerHTML;
		// 	alert(v_end);	
		// 	console.log(v_end);	
	}
</script>