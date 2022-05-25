<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>
/* .main_card{ */
/* 	height: 40vh;  */
/* } */
.main_chead{ 
	background-color: white; 
} 
.flex_bet_container{
	display: flex;
	justify-content: space-around;
}
.vh65{
	height: 83vh;
	padding-bottom: 1.5rem; 
}
.mainTb{
	table-layout:fixed; 
}

.mainTb th, .mainTb td {
	padding: 2px;
	border-bottom: 1px solid #f3f3f3;
}
.table-container {
	overflow: auto;
}
.flex_container{
	display: flex;
}
.hoverTr:hover {
	background-color: #f3f3f3;
}
.vh33_5{
	height: 33.5vh;
}
.vh25{
	height: 22vh;
}
.vh28{
	height: 28vh;
}
.vh30{
	height: 30vh;
}
.vh43{
	height: 43vh;
}
.card-body{
/* 	overflow: auto; */
}
.h80{
	height: 80%;
}
.mainUserPhoto{
	height: 20vh;
	width: 100%
}
.mainImgBox{

}
.col-lg-4 {
    -webkit-box-flex: 0;
    -ms-flex: 0 0 auto;
    flex: 0 0 auto;
    width: 37.5%;
}
</style>

<div class="row" style="height:100%;">
<sec:authentication property="principal.user" var="user"/>
    <div class="col-lg-3">
<!-- 			<div class="card border-left-primary shadow h-100 py-2"> -->
        <div class="card shadow mb-4">
            <div class="card-body atndnBox vh30">
            	<div class="flex_bet_container mt-2">
	            	<div class="mainImgBox"  style="">
	            		<img class="mainUserPhoto img-fluid" src="${user.atchPath }" >
	            	</div>
	            	<div class="pt-2">
	            		<p ><b class="">${user.empName }</b> ${user.deptName }</p>
	            		
		            	<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" var="nowDate"/>
		            	<fmt:formatDate value="${atndnDaily.atndnStrtDt }" pattern="HH:mm:ss" var="atndnStrtDt"/>
		            	<fmt:formatDate value="${atndnDaily.atndnEndDt }" pattern="HH:mm:ss" var="atndnEndDt" />
		            	<p>${nowDate }</p>
		            	<p class=""><b>출근시간</b> : <span id="startDt">${atndnStrtDt }</span></p>
	            		<p class=""><b>퇴근시간</b> : <span id="endDt">${atndnEndDt }</span></p>
	            	</div>
            	</div>
            	<div id="btnBox" class="d-grid gap-2 mt-1">
            		<c:if test="${atndnDaily.atndnStrtDt eq null }" >
						<button id="startBtn" class="btn btn-danger waves-effect waves-light"
							type="button" onclick="start();">출근하기</button>
            		</c:if>
            	
            		<c:if test="${atndnDaily.atndnStrtDt ne null}" >
						<button id="endBtn" class="btn btn-primary "
							type="button" onclick="end();">퇴근하기</button>
            		</c:if>
				</div>
            </div>
        </div>
        
        <div class="card mb-4">
	        <div class="card-body">
	            <h4 class="card-title mb-2">내 일정</h4>
	
	            <div data-simplebar class="vh43">
	                <ol class="activity-feed mb-0 ps-3 mt-2 pt-2 pb-0">
<!-- 	                    <li class="feed-item"> -->
<!-- 	                        <div class="feed-item-list"> -->
<!-- 	                            <p class="text-muted mb-1">Now</p> -->
<!-- 	                            <p class="mt-0 mb-0">Andrei Coman magna sed porta finibus, risus -->
<!-- 	                                posted a new article: <span class="text-primary">Forget UX -->
<!-- 	                                    Rowland</span></p> -->
<!-- 	                        </div> -->
<!-- 	                    </li> -->
						<c:forEach var="scheduleVO" items="${scheduleList}">
		                    <li class="feed-item">
		                    	<fmt:formatDate value="${scheduleVO.schdlStrtDt }" pattern="yyyy-MM-dd" var="schdlStrtDt"/>
		                        <p class="text-muted mb-1">${schdlStrtDt }</p>
		                        <p class="mt-0 mb-0"><span class="text-primary"> ${scheduleVO.schdlTitle }</span><br>
		                        ${scheduleVO.schdlCntnt } </p>
		                    </li>
						</c:forEach>
					</ol>
	            </div>
	
	        </div><!-- end card-body -->
	    </div><!-- end card -->
    </div>

    <div class="col-lg-4 ">
    
	    <div id="autho-card" class="card main_card shadow mb-4" data-id="autho">
	        <div class="card-header main_chead flex_bet_container " >
	        	<div class="flex_item w-100">
		        	<ul class="nav nav-tabs" role="tablist">
		                <li class="nav-item" id="receiveAutho" data-id="receiveAutho" style="display: none;">
		                    <a class="nav-link active" data-id="receive" data-bs-toggle="tab" href="#profile" role="tab">
		                        <span class="d-block d-sm-none"><i class="far fa-user"></i></span>
		                        <b><span class="d-none d-sm-block">받은결제</span></b>    
		                    </a>
		                </li>
		                <li class="nav-item" id="sendAutho" data-id="sendAutho">
		                    <a class="nav-link active" data-id="send" data-bs-toggle="tab" href="#home" role="tab">
		                        <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
		                        <b><span class="d-none d-sm-block">보낸결제</span></b>    
		                    </a>
		                </li>
		            </ul>
	        	</div>
	        	<div class="flex_item plusIcon p-2">
		            <i class="ri-list-check fa-lg"></i>
	        	</div>
	       	</div>
	       	
	    	<div class="card-body vh33_5 p-0 mx-3">
	    		<div class="table-container h80">
					
				</div>
				<div class="page-container">
					
				</div>
	    	</div>
	    </div>
    
	    <div id="email-card" class="card main_card shadow mb-4"  data-id="email">
	        <div class="card-header main_chead flex_bet_container ">
	        	<div class="flex_item w-100">
		        	<ul class="nav nav-tabs" role="tablist">
		                <li class="nav-item" data-id="unreadMail">
		                    <a class="nav-link active" data-id="unread" data-bs-toggle="tab" href="#home" role="tab">
		                        <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
		                        <b><span class="d-none d-sm-block">읽지않은메일</span></b>    
		                    </a>
		                </li>
		                <li class="nav-item" data-id="sendMail">
		                    <a class="nav-link" data-id="send" data-bs-toggle="tab" href="#profile" role="tab">
		                        <span class="d-block d-sm-none"><i class="far fa-user"></i></span>
		                        <b><span class="d-none d-sm-block">보낸메일</span></b>    
		                    </a>
		                </li>
		            </ul>
	        	</div>
	        	<div class="flex_item plusIcon p-2">
		            <i class="ri-list-check fa-lg "></i>
	        	</div>
	       	</div>
	       	
	    	<div class="card-body vh33_5 p-0 mx-3">
	    		<div class="table-container h80">
					
				</div>
				<div class="page-container">
					
				</div>
	    	</div>
	    </div>

    </div>

    <div class="col-lg-4">
            

	    <div id="work-card" class="card main_card shadow mb-4 " data-id="work">
	        <div class="card-header main_chead flex_bet_container " >
	        	<div class="flex_item w-100">
		        	<ul class="nav nav-tabs" role="tablist">
		                <li class="nav-item" data-id="getWork">
		                    <a class="nav-link active" data-id="get" data-bs-toggle="tab" href="#home" role="tab">
		                        <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
		                        <b><span class="d-none d-sm-block">받은요청</span></b>    
		                    </a>
		                </li>
		                <li class="nav-item" data-id="giveWork">
		                    <a class="nav-link" data-id="give" data-bs-toggle="tab" href="#profile" role="tab">
		                        <span class="d-block d-sm-none"><i class="far fa-user"></i></span>
		                        <b><span class="d-none d-sm-block">보낸요청</span></b>    
		                    </a>
		                </li>
		            </ul>
	        	</div>
	        	<div class="flex_item plusIcon p-2">
		            <i class="ri-list-check fa-lg "></i>
	        	</div>
	       	</div>
	       	
	    	<div class="card-body vh33_5 p-0 mx-3">
	    		<div class="table-container h80">
					
				</div>
				<div class="page-container">
					
				</div>
	    	</div>
	    </div>
	
	
	    <div id="notice-card" class="card main_card shadow mb-4 " data-id="notice">
	        <div class="card-header main_chead flex_bet_container " >
	        	<div class="flex_item w-100">
		        	<ul class="nav nav-tabs" role="tablist">
		                <li class="nav-item" data-id="notice">
		                    <a class="nav-link active" data-bs-toggle="tab" href="#home" role="tab">
		                        <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
		                        <b><span class="d-none d-sm-block">공지사항</span></b>    
		                    </a>
		                </li>
		            </ul>
	        	</div>
	        	<div class="flex_item plusIcon p-2">
		            <i class="ri-list-check fa-lg"></i>
	        	</div>
	       	</div>
	       	
	    	<div class="card-body vh33_5 p-0 mx-3">
	    		<div class="table-container h80">
					
				</div>
				<div class="page-container">
					
				</div>
	    	</div>
	    </div>

    </div>
</div>

<%@ include file="../project/detailWork.jsp" %>

<script src="/resources/js/project.js"></script>
<script>
	
	//미래 날짜형식 조작을 위해서 억지로 작성
	function getTodayDate(nowDate) {
		console.log(nowDate);
		var v_today = nowDate;
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
	
    // 날짜 yyyy-MM-dd hh:mm
    function toStringHms(date) {
        let hour = date.getHours();
        let minute = date.getMinutes();
        let second = date.getSeconds();

        hour = hour >= 10 ? hour : '0' + hour;
        minute = minute >= 10 ? minute : '0' + minute;
        second = second >= 10 ? second : '0' + second;

        return hour + ':' + minute + ':' + second;
	}

	function start() {
		var nowDate = new Date();
		var v_realDateTime = getTodayDate(nowDate).toString();
// 		alert(v_realDateTime);  //체킁

		$.ajax({
			type : "get",
			dataType : "json",
			url : "/attendance/recordStart",
			data : "sdate=" + v_realDateTime,
			contentType : "application/text; charset=UTF-8",
			success : function(msg) {
// 				console.log(msg["noticeMsg"]);
// 				alert(msg);
				alert(msg["noticeMsg"]);
				if(msg["noticeMsg"] == "출근 처리 되었습니다."){
					var startHms = toStringHms(nowDate);
					$("#startDt").text(startHms);
					
					var btn = '<button id="endBtn" class="btn btn-primary"';
					btn += 'type="button" onclick="end();">퇴근하기</button>';
					
					$("#btnBox").append(btn);
					
					$("#startBtn").remove();
				}
			}

		})
	};

	// 	console.log(v_start);

	function end() {

		var nowDate = new Date();
		var v_realDateTime = getTodayDate(nowDate).toString();
		
		$.ajax({
			type : "get",
			dataType : "text",
			url : "/attendance/recordEnd",
			data : "sdate=" + v_realDateTime,
			contentType : "application/text; charset=UTF-8",
			success : function(msg) {
				alert(msg);
				if(msg == "퇴근 처리 되었습니다."){
					var endHms = toStringHms(nowDate);
					
					$("#endDt").text(endHms);
					$("#endBtn").remove();
				}
				
			}

		})

		// 	var v_end = document.querySelector("#time");
		// 		var v_end = document.querySelector("#time").innerHTML;
		// 	alert(v_end);	
		// 	console.log(v_end);	
	}
	
	// 이메일 리스트
	function mainEmail(p_currentPage, division) {
	    var tableContainer;
	    var pageContainer;
	    var currentPage = 0;
	    
	    if(p_currentPage == undefined){
	        currentPage = 1;
	    }else if(p_currentPage == "previous"){
	        currentPage = page.startPage-page.pagingCount;
	    }else if(p_currentPage == "next"){
	        currentPage = page.startPage+page.pagingCount;
	    }else{
	        currentPage = parseInt(p_currentPage);
	    }

	    var size = 6;
	    var start = currentPage * size - (size - 1);
	    var end = currentPage * size;
	    
	    $.ajax({
	        url: "/mainMailList",
	        type: "POST",
	        contentType: "application/json; charset=utf-8",
	        data: JSON.stringify({
	            'currentPage': currentPage,
	            'userId': userId,
	            'size': size,
	            'start': start,
	            'end': end,
	            'division': division,
	        }),
	        success: function (result) {
	            var table = "";
	            table += '<table class="mainTb" style="width: 100%; table-layout:fixed;">';
	            table += '<tr>';
	            table += '<th style="width: 10%;"></th>';
	            table += '<th style="width: 40%; text-overflow:ellipsis; overflow:hidden;"><nobr>제목 </nobr></th>';
	            table += '<th style="width: 20%;">발신자</th>';
	            table += '<th style="width: 30%;">수신일</th>';
	            table += '</tr>';
	            
	            var res = result["mailList"]
	            $.each(res, function (i, v) {
	            	
	                var brdWrtDt = toStringYmd(new Date(v.emailWrtDt))
	                if(division == "unread"){
	                    table += '<tr class="hoverTr" onClick="location.href=\'/email/reMailDetail?emailId='+v.emailId+'\'" >';
                	}else{
	                    table += '<tr class="hoverTr" onClick="location.href=\'/email/sendMailDetail?emailId='+v.emailId+'\'" >';
                	}
	                table += '<td>'+v.rnum +'</td>';
	                table += '<td style="width: 40%; text-overflow:ellipsis; overflow:hidden;"><nobr>'+v.emailTitle +'</nobr></td>';
	                table += '<td>'+v.empName +'</td>';
	                var emailWrtDt = toStringYmd(new Date(v.emailWrtDt));
	                table += '<td>'+emailWrtDt +'</td>';
	                table += '</tr>';
	            })
	                table += '</table>';

	            $("#email-card .table-container").html(table);
	            
	            var page = result["page"];
	            var total = result["total"];
	            var pageCode = '';
	            pageCode += '<ul class="pagination pagination-rounded">';
	            
//	    		<!-- Previous 시작 -->
	            if(page.startPage<page.pagingCount+1){
	                pageCode += '<li id="previous" class="page-item disabled">';
	            }else{
	                pageCode += '<li id="previous" class="page-item ">';
	            }
	            
	            pageCode += '<span class="page-link"><i class="mdi mdi-chevron-left"></i></span>';
	            pageCode += '</li>';
//	    		<!-- Previous 끝 -->

//	    		<!-- Page번호 시작 -->
	            for(var pNo=page.startPage; pNo <= page.endPage; pNo++){
	                if(page.currentPage == pNo){
	                    pageCode += '<li class="page-item pageNo active" >';
	                    
	                }else{
	                    pageCode += '<li class="page-item pageNo" >';
	                }
	                pageCode += '<a class="page-link" href="#">'+pNo+'</a></li>';
	            }
	            
//	    		<!-- Page번호 끝 -->
//	    		<!-- Next 시작 -->
	            if(page.endPage>=page.totalPages){
	                pageCode += '<li id="next" class="page-item disabled">';
	            }else{
	                pageCode += '<li id="next" class="page-item">';
	            }
	            pageCode += '<a class="page-link" href="#"><i class="mdi mdi-chevron-right"></i></a>';
	            pageCode += '</li>';
//	    		<!-- Next 끝 -->
	            pageCode += '</ul>';
	            
	            $("#email-card .page-container").html(pageCode);
	        },
	        error: function (xhr) {
	            alert(xhr.status)

	        },
	        beforeSend: function (xhr) {
	            xhr.setRequestHeader(header, token)
	        },
	        dataType: "json"
	    })
	}

	
	// 공지사항리스트
	function mainNotice(p_currentPage) {
    	
    	var tableContainer;
    	var pageContainer;
    	
        var currentPage = 0;
//        console.log("p_currentPage : ", p_currentPage);
        
        if(p_currentPage == undefined){
            currentPage = 1;
        }else if(p_currentPage == "previous"){
            currentPage = page.startPage-page.pagingCount;
            
        }else if(p_currentPage == "next"){
            currentPage = page.startPage+page.pagingCount;
            
        }else{
            currentPage = parseInt(p_currentPage);
        
        }

        var size = 6;
        var start = currentPage * size - (size - 1);
        var end = currentPage * size;
        
        $.ajax({
            url: "/mainNoticeList",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                'main': "main",
                'userId': userId,
                'currentPage': currentPage,
                'size': size,
                'start': start,
                'end': end,
//                 'keyWord': "keyWord",
            }),
            success: function (result) {
//            		console.log("notice() : ", result);
//                console.log(result["noticeList"]);
                
                var table = "";
                table += '<table class="mainTb" style="width: 100%; table-layout:fixed;">';
                table += '<tr>';
                table += '<th style="width: 5%;"></th>';
                table += '<th style="width: 40%; text-overflow:ellipsis; overflow:hidden;"><nobr>제목 </nobr></th>';
                table += '<th style="width: 20%;">작성일자</th>';
                table += '<th style="width: 20%;">조회수</th>';
                table += '</tr>';
                
                var res = result["noticeList"]
                $.each(res, function (i, v) {
                    if(v.brdWrtDt != null){
                    	var brdWrtDt = toStringYmd(new Date(v.brdWrtDt))
                    }else{
                    	var brdWrtDt = "-"
                    }
//     				console.log("brdWrtDt", brdWrtDt);
    				
                    table += '<tr class="hoverTr" onClick="location.href=\'/notice/detail?brdId='+v.brdId+'&currentPage=1\'" >';
                    table += '<td>'+v.rnum +'</td>';
                    table += '<td style="width: 40%; text-overflow:ellipsis; overflow:hidden;"><nobr>'+v.brdTitle +'</nobr></td>';
                    table += '<td>'+brdWrtDt +'</td>';
                    table += '<td>'+v.brdHit +'</td>';
                    table += '</tr>';
                })
    				table += '</table>';

// 				console.log(table);
// 				console.log($("#notice-card"));
                $("#notice-card .table-container").html(table);
                
                var page = result["page"];
                var total = result["total"];
                var pageCode = '';
                pageCode += '<ul class="pagination pagination-rounded">';
                
//    				<!-- Previous 시작 -->
                if(page.startPage<page.pagingCount+1){
                    pageCode += '<li id="previous" class="page-item disabled">';
                }else{
                    pageCode += '<li id="previous" class="page-item ">';
                    
                }
                
                pageCode += '<span class="page-link"><i class="mdi mdi-chevron-left"></i></span>';
                pageCode += '</li>';
//    				<!-- Previous 끝 -->
//    				<!-- Page번호 시작 -->
                for(var pNo=page.startPage; pNo <= page.endPage; pNo++){
                    if(page.currentPage == pNo){
                        pageCode += '<li class="page-item pageNo active" >';
                        
                    }else{
                        pageCode += '<li class="page-item pageNo" >';
                        
                    }
                    pageCode += '<a class="page-link" href="#">'+pNo+'</a></li>';
                    
                }
//    				<!-- Page번호 끝 -->
//    				<!-- Next 시작 -->
                if(page.endPage>=page.totalPages){
                    pageCode += '<li id="next" class="page-item disabled">';
                }else{
                    pageCode += '<li id="next" class="page-item">';
                    
                }
                pageCode += '<a class="page-link" href="#"><i class="mdi mdi-chevron-right"></i></a>';
                pageCode += '</li>';
//    				<!-- Next 끝 -->
                pageCode += '</ul>';
                
                $("#notice-card .page-container").html(pageCode);
                
                var tooltipTriggerList = [].slice.call(document.querySelectorAll(
                    '[data-bs-toggle="tooltip"]'))
                var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                    return new bootstrap.Tooltip(tooltipTriggerEl)
                })

            },
            error: function (xhr) {
                alert(xhr.status)

            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token)
            },
            dataType: "json"
        })
    }

	
	// 홈업무리스트
    function mainWork(p_currentPage, division) {
//    		console.log(division);
    	
    	var tableContainer;
    	var pageContainer;
    	
        var currentPage = 0;
//        console.log("p_currentPage : ", p_currentPage);
        
        if(p_currentPage == undefined){
            currentPage = 1;
        }else if(p_currentPage == "previous"){
            currentPage = page.startPage-page.pagingCount;
            
        }else if(p_currentPage == "next"){
            currentPage = page.startPage+page.pagingCount;
            
        }else{
            currentPage = parseInt(p_currentPage);
        
        }

        var size = 6;
        var start = currentPage * size - (size - 1);
        var end = currentPage * size;
        
        $.ajax({
            url: "/project/mainWorkList",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                'empId': userId,
                'division': division,
                'main': "main",
                'currentPage': currentPage,
                'size': size,
                'start': start,
                'end': end,
                'keyWord': "keyWord",
            }),
            success: function (result) {
//            	console.log(result);
//                console.log(result["workList"]);
                
                var table = "";
                table += '<table class="mainTb" style="width: 100%; table-layout:fixed;">';
                table += '<tr>';
                table += '<th style="width: 9%;"></th>';
                table += '<th style="width: 35%; text-overflow:ellipsis; overflow:hidden;"><nobr>업무제목</nobr></th>';
                table += '<th style="width: 20%; text-overflow:ellipsis; overflow:hidden;"><nobr>담당자</nobr></th>';
                table += '<th style="width: 18%;">시작일</th>';
                table += '<th style="width: 18%;">마감일</th>';
                table += '</tr>';
                
                var res = result["workList"]
                $.each(res, function (i, v) {
                    console.log(res);
    					
                    table += '<tr class="hoverTr" data-workId="'+ v.workId +'">';
                    table += '<td>';

                    if (v.workState == null) {
                        table += '-';
                    }
                    if (v.workState == "요청") {
                        table +=
                            '<span class="badge rounded-pill bg-info">' +
                            v.workState + '</span>';
                    }
                    if (v.workState == "진행") {
                        table +=
                            '<span class="badge rounded-pill bg-success ">' +
                            v.workState + '</span >';
                    }
                    if (v.workState == "완료") {
                        table +=
                            '<span class="badge rounded-pill bg-dark">' +
                            v.workState + '</span >';
                    }
                    if (v.workState == "이슈") {
                        table += '<span class="badge rounded-pill bg-danger ">' +
                            v.workState + '</span >';
                    }   
                    if(v.workStrtDt != null || v.workEndDt != null){
                    	var workStrtDt = toStringYmd(new Date(v.workStrtDt))
                    	var workEndDt = toStringYmd(new Date(v.workEndDt))
                    }else{
                    	var workStrtDt = "-"
                    	var workEndDt = "-"
                    	
                    }
                    table += '</td>';
                    table += '<td style="width: 40%; text-overflow:ellipsis; overflow:hidden;"><nobr>'+v.workTitle +'</nobr></td>';
                   
                    var workMngr ='';
                    $.each(v.workMngr, function(i, vv) {
    		   	 		workMngr += vv.workMngrNm;
    		   	 		if(i < v.workMngr.length-1){
    			   	 		console.log(i, v.workMngr.length-1)
    			   	 		workMngr += ', ';
    		   	 		}
    		   	 	})
                    table += '<td style="width: 20%; text-overflow:ellipsis; overflow:hidden;"><nobr>'+workMngr +'</nobr></td>';
                    table += '<td>'+workStrtDt +'</td>';
                    table += '<td>'+workEndDt +'</td>';
                    table += '</tr>';
                })
    				table += '</table>';

// 				console.log(table);
// 				console.log($("#work-card"));
                $("#work-card .table-container").html(table);
                
                var page = result["page"];
                var total = result["total"];
                var pageCode = '';
                pageCode += '<ul class="pagination pagination-rounded">';
                
//    				<!-- Previous 시작 -->
                if(page.startPage<page.pagingCount+1){
                    pageCode += '<li id="previous" class="page-item disabled">';
                }else{
                    pageCode += '<li id="previous" class="page-item ">';
                    
                }
                
                pageCode += '<span class="page-link"><i class="mdi mdi-chevron-left"></i></span>';
                pageCode += '</li>';
//    				<!-- Previous 끝 -->
//    				<!-- Page번호 시작 -->
                for(var pNo=page.startPage; pNo <= page.endPage; pNo++){
                    if(page.currentPage == pNo){
                        pageCode += '<li class="page-item pageNo active" >';
                        
                    }else{
                        pageCode += '<li class="page-item pageNo" >';
                        
                    }
                    pageCode += '<a class="page-link" href="#">'+pNo+'</a></li>';
                    
                }
//    				<!-- Page번호 끝 -->
//    				<!-- Next 시작 -->
                if(page.endPage>=page.totalPages){
                    pageCode += '<li id="next" class="page-item disabled">';
                }else{
                    pageCode += '<li id="next" class="page-item">';
                    
                }
                pageCode += '<a class="page-link" href="#"><i class="mdi mdi-chevron-right"></i></a>';
                pageCode += '</li>';
//    				<!-- Next 끝 -->
                pageCode += '</ul>';
                
                $("#work-card .page-container").html(pageCode);
                
                var tooltipTriggerList = [].slice.call(document.querySelectorAll(
                    '[data-bs-toggle="tooltip"]'))
                var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                    return new bootstrap.Tooltip(tooltipTriggerEl)
                })

            },
            error: function (xhr) {
                alert(xhr.status)

            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token)
            },
            dataType: "json"
        })
    }
	
 // 결재 리스트
    function mainAutho(p_currentPage, division) {
//             console.log("division" , division);

        var tableContainer;
        var pageContainer;
        
        var currentPage = 0;
//    	        console.log("p_currentPage : ", p_currentPage);
        
        if(p_currentPage == undefined){
            currentPage = 1;
        }else if(p_currentPage == "previous"){
            currentPage = page.startPage-page.pagingCount;
            
        }else if(p_currentPage == "next"){
            currentPage = page.startPage+page.pagingCount;
            
        }else{
            currentPage = parseInt(p_currentPage);
        
        }

        var size = 6;
        var start = currentPage * size - (size - 1);
        var end = currentPage * size;
        
        $.ajax({
            url: "/mainAuthoList",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                'currentPage': currentPage,
                'userId': userId,
                'size': size,
                'start': start,
                'end': end,
                'division': division,
            }),
            success: function (result) {
//                console.log("autho() : ", result);
//                console.log(result["authoList"]);
                
                var table = "";
                table += '<table class="mainTb" style="width: 100%; table-layout:fixed;">';
                table += '<tr>';
                table += '<th style="width: 15%;"></th>';
                table += '<th style="width: 40%; text-overflow:ellipsis; overflow:hidden;"><nobr>제목 </nobr></th>';
                table += '<th style="width: 15%;">기안자</th>';
                table += '<th style="width: 25%;">작성일</th>';
                table += '</tr>';
                
                var res = result["authoList"]
                $.each(res, function (i, v) {
                   	
                	if(division == "send"){
	                    table += '<tr class="hoverTr" onClick="location.href=\'/autho/sendDocDetail?docId='+v.docId+'\'" >';
                	}else{
	                    table += '<tr class="hoverTr" onClick="location.href=\'/autho/receiveDocDetail?docId='+v.docId+'&atrzAprvId='+userId+'\'" >';
                	}
//                     console.log("v.atrzState",v.atrzState);
                    var atrzState = ""
                    if(v.atrzState == '미결재'){
                    	atrzState += '<span class="badge rounded-pill bg-danger pt-1 ml-1" style="font-size: 11px;">미결재</span>';
                    	
                    }
                    if(v.atrzState == '진행중'){
                    	atrzState += '<span class="badge rounded-pill bg-primary pt-1 ml-1" style="font-size: 11px;">진행중</span>';
                    	
                    }
                    if(v.atrzState == '결재완료'){
                    	atrzState += '<span class="badge rounded-pill bg-success pt-1 ml-1" style="font-size: 11px;">결재완료</span>';
                    	
                    }
                    if(v.atrzState == '반려'){
                    	atrzState += '<span class="badge rounded-pill bg-info pt-1 ml-1" style="font-size: 11px;">반려</span>';
                    	
                    }
                    if(v.atrzState == '대기중'){
                    	atrzState += '<span class="badge rounded-pill bg-secondary pt-1 ml-1" style="font-size: 11px;">대기중</span>';
                    }
// 		         	console.log("atrzState", atrzState)
                    table += '<td class="text-start">'+atrzState+'</td>';
//                     table += '<td><span class="badge rounded-pill bg-secondary pt-1" style="float:right; font-size: 11px;">대기중</span></td>';
                    table += '<td style="width: 40%; text-overflow:ellipsis; overflow:hidden;"><nobr>'+v.docTitle +'</nobr></td>';
                    table += '<td>'+v.docWrtrName +'</td>';
                    var docWrtDt = toStringYmd(new Date(v.docWrtDt));
                    table += '<td>'+docWrtDt +'</td>';
                    table += '</tr>';
                })
                    table += '</table>';

//                 console.log(table);
//                 console.log($("#autho-card"));
                $("#autho-card .table-container").html(table);
                
                var page = result["page"];
                var total = result["total"];
                var pageCode = '';
                pageCode += '<ul class="pagination pagination-rounded">';
                
//    	    				<!-- Previous 시작 -->
                if(page.startPage<page.pagingCount+1){
                    pageCode += '<li id="previous" class="page-item disabled">';
                }else{
                    pageCode += '<li id="previous" class="page-item ">';
                    
                }
                
                pageCode += '<span class="page-link"><i class="mdi mdi-chevron-left"></i></span>';
                pageCode += '</li>';
//    	    				<!-- Previous 끝 -->
//    	    				<!-- Page번호 시작 -->
                for(var pNo=page.startPage; pNo <= page.endPage; pNo++){
                    if(page.currentPage == pNo){
                        pageCode += '<li class="page-item pageNo active" >';
                        
                    }else{
                        pageCode += '<li class="page-item pageNo" >';
                        
                    }
                    pageCode += '<a class="page-link" href="#">'+pNo+'</a></li>';
                    
                }
//    	    				<!-- Page번호 끝 -->
//    	    				<!-- Next 시작 -->
                if(page.endPage>=page.totalPages){
                    pageCode += '<li id="next" class="page-item disabled">';
                }else{
                    pageCode += '<li id="next" class="page-item">';
                    
                }
                pageCode += '<a class="page-link" href="#"><i class="mdi mdi-chevron-right"></i></a>';
                pageCode += '</li>';
//    	    				<!-- Next 끝 -->
                pageCode += '</ul>';
                
                $("#autho-card .page-container").html(pageCode);
                
                var tooltipTriggerList = [].slice.call(document.querySelectorAll(
                    '[data-bs-toggle="tooltip"]'))
                var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                    return new bootstrap.Tooltip(tooltipTriggerEl)
                })

            },
            error: function (xhr) {
                alert(xhr.status)

            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token)
            },
            dataType: "json"
        })
    }
	
	$(function(){
		mainWork(1, "get");
		mainAutho(1, "send");
		mainNotice(1);
		mainEmail(1, "unread");		

		var userRole = $(".userRole");
		for(var i=0; i < userRole.length; i++ ){
			console.log($(userRole[i]).val());
			if($(userRole[i]).val()=="ROLE_BUJANG"){
				$("#receiveAutho").show();
				$("#sendAutho a").removeClass("active");
				mainAutho(1, "receive");
			}
		}
		
		// 페이지 버튼 클릭시
		$(document).on("click", ".main_card .pageNo", function(){
			var cardId = $(this).parents(".main_card").data("id");
			var currentPage;
			var division ='';
			
			if(cardId == "work"){
				division = $(this).parents(".main_card").find(".active").data("id");
				currentPage = $(this).text();
				mainWork(currentPage , division);
			}
			
			if(cardId == "notice"){
				currentPage = $(this).text();
				mainNotice(currentPage);
			}
			
			if(cardId == "autho"){
				division = $(this).parents(".main_card").find(".active").data("id");
				currentPage = $(this).text();
				mainAutho(currentPage, division);	
			}
			
			if(cardId == "email"){
				division = $(this).parents(".main_card").find(".active").data("id");
				currentPage = $(this).text();
				mainEmail(currentPage, division);
			}
			
		})
		
		$(document).on("click", ".main_card #previous", function(){
			var division = $(this).parents("#work-card").find(".active").data("id");
			mainWorkList(this, "previous", division);
			
		})
		
		$(document).on("click", ".main_card #next", function(){
			var division = $(this).parents("#work-card").find(".active").data("id");
			mainWorkList(this, "next", division);
			
		})
		
		// 목록 클릭시
		$(".plusIcon").on("click", function(){
			var navId = $(this).parents(".main_card").find(".active").parents(".nav-item").data('id');
			if(navId == "getWork"){
				location.href = "/project";
			}
			
			if(navId == "giveWork"){
				location.href = "/project";
			}
			
			if(navId == "unreadMail"){
				location.href = "/email/reMailBox";
			}
			
			if(navId == "sendMail"){
				location.href = "/email/sendMailBox";
				
			}
			
			if(navId == "receiveAutho"){
				location.href = "/autho/receiveDoc";
			}
			
			if(navId == "sendAutho"){
				location.href = "/autho/sendDoc";
			}
			
			if(navId == "notice"){
				location.href = "/notice/list";
			}
			
		})
		
		// 탭 클릭시
		$(".nav-item").on("click", function(){
			var navId = $(this).data("id");
			
			if(navId == "getWork"){
				mainWork(1, "get");
			}
			
			if(navId == "giveWork"){
				mainWork(1, "give");
			}
			
			if(navId == "unreadMail"){
				mainEmail(1, "unread");	
			}
			
			if(navId == "sendMail"){
				mainEmail(1, "send");	
			}
			
			if(navId == "receiveAutho"){
				mainAutho(1, "receive");	
			}
			
			if(navId == "sendAutho"){
				mainAutho(1, "send");	
			}
			
		})
		
	})
</script>
		