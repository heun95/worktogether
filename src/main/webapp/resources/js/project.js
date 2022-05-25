
	var token = $("#token").val();
	var header = $("#header").val();
    var userId = $("#userId").val();
    var userPhoto = $("#userPhoto").val();
    var projId = $("#projId").val();
	
// console.log("token" , token);
// console.log("test" , header);
	
	// 클래스 지워주는 메소드
    function removeClass(p_obj, p_list) {
        // console.log(p_obj);
        for (var i = 0; i < p_list.length; i++) {
            $(p_obj).removeClass(p_list[i]);
            // console.log(p_list[i]);
        }
    }
	
	// 날짜 yyyy-mm-dd 형식으로 변환해주는 메소드
    function toStringYmd(date) {
        var year = date.getFullYear();
        var month = ('0' + (date.getMonth() + 1)).slice(-2);
        var day = ('0' + date.getDate()).slice(-2);

        var dateString = year + '-' + month + '-' + day;

        return dateString;
    }
	
    // 날짜 yyyy-MM-dd hh:mm
    function toStringYmdHm(date) {
        let month = date.getMonth() + 1;
        let day = date.getDate();
        let hour = date.getHours();
        let minute = date.getMinutes();
        let second = date.getSeconds();

        month = month >= 10 ? month : '0' + month;
        day = day >= 10 ? day : '0' + day;
        hour = hour >= 10 ? hour : '0' + hour;
        minute = minute >= 10 ? minute : '0' + minute;
        second = second >= 10 ? second : '0' + second;

        return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
}

	// 업무상태 버튼클릭시 메소드
    function wkStateBtnClick(p_btn) {
        var wkState = $(p_btn).text();
        var removeList = ["btn-info", "btn-success", "btn-dark", "btn-danger"];
        removeClass(".wkStateBtn", removeList);

        $(".wkStateBtn").addClass("btn-secondary");

        if (wkState == "요청") {
            $(p_btn).addClass("btn-info");
        }
        if (wkState == "진행") {
            $(p_btn).addClass("btn-success");
        }
        if (wkState == "완료") {
            $(p_btn).addClass("btn-dark");
        }
        if (wkState == "이슈") {
            $(p_btn).addClass("btn-danger");
        }

        $(p_btn).siblings("#workState").val(wkState);
    }
	
	// 업무순위 버튼 클릭시
    function priorityBtnClick(p_btn) {
        var priority = $(p_btn).data("priority")

        var priorityBtn = $(p_btn).parents('.dropdown').find("#dropPriority");


        var removeList = ["btn-outline-secondary", "btn-outline-warning", "btn-outline-dark", "btn-outline-success",
            "btn-outline-danger"
        ];
        removeClass(priorityBtn, removeList)


        var code = "";
        if (priority == "낮음") {
            code += '<i class="fa fa-arrow-down icon" style="color:orange"></i>낮음';
            priorityBtn.html(code);
            priorityBtn.addClass("btn-outline-warning");
        }
        if (priority == "보통") {
            priorityBtn.text($(p_btn).text());
            priorityBtn.addClass("btn-outline-dark");

        }
        if (priority == "높음") {
            code += '<i class="fa fa-arrow-down icon" style="color:green"></i>높음';
            priorityBtn.html(code);
            priorityBtn.addClass("btn-outline-success");

        }
        if (priority == "긴급") {
            priorityBtn.text($(p_btn).text());
            priorityBtn.addClass("btn-outline-danger");
        }

        $(p_btn).parents('.dropdown').find('input[name=workPriority]').val(priority);

    }
	
	// 담당자 클릭시
	function mngrBtnAdd(p_mngr){
		var memlist = [];
        
        memlist = $(p_mngr).parents(".dropdown").find(".membtn");
		console.log("memlist", memlist);
		console.log("1",$(p_mngr).text());

        // 중복이름 선택시 리턴
        for (var i = 0; i < memlist.length; i++) {
            if ($(p_mngr).text() == memlist[i].innerText) {
            	console.log("2",memlist[i].innerText);
            	
            	alert("이미 선택했습니다.");
                return false;
            }
        }
		console.log("test :  ", $(p_mngr));
		console.log("test :  ", $(p_mngr).data("empid"));
        // 이름들어간 버튼 만들기
        var btn = "<button type='button' class='btn btn-outline-info waves-effect waves-light membtn'>";
        btn += "<i class='ri-close-line align-middle me-2'></i>";
        btn += $(p_mngr).text();
        btn += "</button>";
        // 선택한 이름 VO에 들어갈 수 있게 히든으로 넣어놓기
        btn += '<input id="workMngrId" name="workMngrId" value="'+ $(p_mngr).data("empid")+'" data-workmngrnm="' + $(p_mngr).text() +
            '" type="hidden">';
        var mngrDiv = $(p_mngr).parents(".dropdown").find("#mngrDiv")
		console.log(mngrDiv);
        $(mngrDiv).append(btn);

	}
	
	// 담당자 X 클릭시
	function mngrBtnRemove(p_mngr){
		 var memBtn = $(p_mngr).parents(".btn")[0];
		 console.log(memBtn);
         var memNm = memBtn.innerText;
         // 히든 없애기
         $(memBtn).parents("#mngrDiv").find("input[data-workMngrNm=" + memNm + "]").remove();
         // 버튼 없애기
         $(memBtn).remove();
	}
	
	// 프로그레스바 클릭시 값 변경
	function progressClick(p_progress){
	    var boxPos =  p_progress.getBoundingClientRect();
	    var clickVal  = parseInt((event.clientX-boxPos.left)/boxPos.width*100);
	    
	    clickVal = Math.round(clickVal/ 10) * 10;
	    
        $(p_progress).find(".progress-bar").attr("style", "width: "+clickVal +"%")
        $(p_progress).find(".progress-bar").attr("aria-valuenow", clickVal)
        $(p_progress).find(".progress-bar").text(clickVal+"%");
        $(p_progress).find("#workProgress").val(clickVal);
	}
	
	// 
	function offHideEvent(){
		var myOffcanvas = document.getElementById('wokrDetail')
		myOffcanvas.addEventListener('hidden.bs.offcanvas', function () {
			workList(1);
		})
	}
	
	// 업무 수정
	function updateWork(){
		var formData = $("#wokrDetailForm").serialize();
		console.log(formData);
		$.ajax({
            url: "/project/updateWorkForm",
            type: "POST",
            data: formData,
            success: function (res) {

				console.log("update res : " , res);
                
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
	
	// 업무 디테일
    function workDetail(workId){
        $.ajax({
            url: "/project/workDetail",
            type: "POST",
            dataType: "json",
            data: {
                'workId': workId
                ,'projId': projId
            },
            success: function (resMap) {
            	var res = resMap["worktDetail"]
                console.log(res);
                // 업무코드
                $("#wokrDetail #workId").val(res.workId);
                
                // 작성자 사진
                $("#wokrDetail #thumb").css("background-image", "url(" + res.workRqstrPhoto + ")");
                
                // 작성자
                $("#wokrDetail .rqstrNm").text(res.workRqstrNm);
                
                // 작성일자
                var workWrtDt = toStringYmdHm(new Date(res.workWrtDt));
                $("#wokrDetail .wrtDt").text(workWrtDt);
                
                // 제목
                $("#wokrDetail #workTitle").val(res.workTitle);
                $("#wokrDetail .workTitleSpan").text(res.workTitle);
                
                // 내용
                $("#wokrDetail #workCntnt").val(res.workCntnt);
                $("#wokrDetail #workCntntDiv").text(res.workCntnt);
                
                // 상태
                $("#wokrDetail #workState").val(res.workState);
                var removeList = ["btn-info", "btn-success", "btn-dark", "btn-danger"];
                removeClass(".wkStateBtn", removeList);

                if (res.workState == "요청") {
                    $("#wokrDetail #request").addClass("btn-info");
                }
                if (res.workState == "진행") {
                    $("#wokrDetail #ing").addClass("btn-success");
                }
                if (res.workState == "완료") {
                    $("#wokrDetail #complete").addClass("btn-dark");
                }
                if (res.workState == "이슈") {
                    $("#wokrDetail #issue").addClass("btn-danger");
                }


                // 담당자
                $("#wokrDetail #mngrDiv").empty()
					console.log(res.workMngr.length)
                for (var i = 0; i < res.workMngr.length; i++) {
                    // 이름들어간 버튼 만들기
                    var btn = "<button type='button' class='btn btn-outline-info waves-effect waves-light membtn'>";
                    btn += "<i class='ri-close-line align-middle me-2'></i>";
                    btn += res.workMngr[i].workMngrNm;
                    btn += "</button>";
                    // 선택한 이름 VO에 들어갈 수 있게 히든으로 넣어놓기
                    btn += '<input id="workMngrId" name="workMngrId" value="' + res.workMngr[i].workMngrId + '" data-workMngrNm="'+res.workMngr[i].workMngrNm+'" type="hidden">';

                    $("#wokrDetail #mngrDiv").append(btn);
                }

                // 날짜
                if(res.workStrtDt != null || res.workEndDt != null){
                	var workStrtDt = toStringYmd(new Date(res.workStrtDt))
                	var workEndDt = toStringYmd(new Date(res.workEndDt))
                	$("#wokrDetail input[name=oldWorkStrtDt]").val(workStrtDt);
                	$("#wokrDetail input[name=oldWorkEndDt]").val(workEndDt);
                	$("#wokrDetail #workStrtDt").val(workStrtDt);
                	$("#wokrDetail #workEndDt").val(workEndDt);
                }

                // 업무순위
                if(res.workPriority != null){
                	$("#wokrDetail #workPriority").val(res.workPriority);
                	var removeList = ["btn-outline-secondary", "btn-outline-warning",
                		"btn-outline-dark", "btn-outline-success", "btn-outline-danger"
                		];
                	removeClass("#wokrDetail #dropPriority", removeList)
                	
                	code = "";
                	if (res.workPriority == "낮음") {
                		code +=
                			'<i class="fa fa-arrow-down icon" style="color:orange"></i>낮음';
                		$("#wokrDetail #dropPriority").addClass("btn-outline-warning");
                	}else if (res.workPriority == "보통") {
                		code += '<span class="icon">➖</span>보통';
                		$("#wokrDetail #dropPriority").addClass("btn-outline-dark");
                		
                	}else if (res.workPriority == "높음") {
                		
                		code +=  '<i class="fa fa-arrow-down icon" style="color:green"></i>높음';
                		$("#wokrDetail #dropPriority").addClass("btn-outline-success");
                		
                	}else if (res.workPriority == "긴급") {
                		code += '<span class="icon">🚨</span>긴급';
                		$("#wokrDetail #dropPriority").addClass("btn-outline-danger");
                		
                	}else{
                		code += '업무순위';
                		
                	}
                	
                	$("#wokrDetail #dropPriority").html(code);
                }
                
                // 업무진행도
                $("#wokrDetail .progress").data("old",res.workProgress )
                $("#wokrDetail .progress-bar").attr("style", "width: "+res.workProgress +"%")
                $("#wokrDetail .progress-bar").attr("aria-valuenow", res.workProgress)
                $("#wokrDetail .progress-bar").text(res.workProgress+"%");
                $("#wokrDetail #workProgress").val(res.workProgress);
                
                file = '';
                
                // 첨부파일
                $.each(res.attachVO, function(i, v){
                	file += '<a href="'+v.atchPath+'" target="_self"  download="">'+v.atchName+'</a>';
                })
                $("#wokrDetail .file").html(file);
                
                // mem
                var memList = resMap["memberList"]
                console.log(memList);
                
                var mem="";
                $.each(memList, function(i, v){
                	mem += '<li><a class="dropdown-item projmem" href="#" data-empid="'+v.empId+'">'+v.empName+'</a></li>';
                })
                console.log(mem);
                $("#memUl").html(mem);

            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token)
            },
            error: function (xhr) {
                alert(xhr.status)

            }
        })
    }
    
 // 홈업무리스트
    function mainWorkList(p_btn, p_currentPage, division) {
    	console.log(division);
    	
    	var tableContainer;
    	var pageContainer;
    	var totalSpan;
    	
    	tableContainer = $(p_btn).parents(".card").find(".table-container");
    	pageContainer = $(p_btn).parents(".card").find(".page-container");
    	totalSpan = $(p_btn).parents(".card").find(".total");
    	
    	if(p_btn == "get" || p_btn == "give" || p_btn == "issue"
    		 || p_btn == "late" || p_btn == "come"){
    		tableContainer = $("#"+p_btn+" .table-container");
    		pageContainer = $("#"+p_btn+" .page-container");
    		totalSpan = $("#"+p_btn+" .total");
    		
// console.log("tableContainer", tableContainer);
// console.log("pageContainer",pageContainer);
    		console.log("이프 들어왔나? ",totalSpan);
    	}
    	
        var currentPage = 0;
// console.log("p_currentPage : ", p_currentPage);
        
        if(p_currentPage == undefined){
            currentPage = 1;
        }else if(p_currentPage == "previous"){
            currentPage = page.startPage-page.pagingCount;
            
        }else if(p_currentPage == "next"){
            currentPage = page.startPage+page.pagingCount;
            
        }else{
            currentPage = parseInt(p_currentPage);
        
        }
        	
        var size = 8;
        if(division == 'come' || division == 'late'){
        	size = 6;
        }
        var start = currentPage * size - (size - 1);
        var end = currentPage * size;
        
        $.ajax({
            url: "/project/mainWorkList",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                'empId': userId,
                'projId': projId,
                'division': division,
                'main': "main",
                'currentPage': currentPage,
                'size': size,
                'start': start,
                'end': end,
                'keyWord': "keyWord",
            }),
            success: function (result) {
// console.log(result);
// console.log(result["workList"]);
// console.log(result["page"]);
                
                var table = "";
                table += '<table class="projMainTb" style="width: 100%; table-layout:fixed;">';
                table += '<tr>';
                table += '<th style="width: 10%;"></th>';
                table += '<th style="width: 30%; text-overflow:ellipsis; overflow:hidden;"><nobr>업무제목</nobr></th>';
                table += '<th style="width: 20%; text-overflow:ellipsis; overflow:hidden;"><nobr>담당자</nobr></th>';
                table += '<th style="width: 20%;">시작일</th>';
                table += '<th style="width: 20%;">마감일</th>';
                table += '</tr>';
            
                var res = result["workList"]
                $.each(res, function (i, v) {
                    
    					
                    table += '<tr class="homeWorkdt" data-bs-toggle="offcanvas" data-bs-target="#wokrDetail" aria-controls="wokrDetail" data-workid="'+ v.workId +'">';
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
                    table += '<td style="width: 30%; text-overflow:ellipsis; overflow:hidden;"><nobr>'+v.workTitle +'</nobr></td>';
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


                $(tableContainer).html(table);
                
                var page = result["page"];
                var total = result["total"];
                
                
                
                var pageCode = '';
                pageCode += '<ul class="pagination pagination-rounded">';
                
// <!-- Previous 시작 --
                if(page.startPage<page.pagingCount+1){
                    pageCode += '<li id="previous" class="page-item disabled">';
                }else{
                    pageCode += '<li id="previous" class="page-item ">';
                    
                }
                
                pageCode += '<span class="page-link"><i class="mdi mdi-chevron-left"></i></span>';
                pageCode += '</li>';
// <!-- Previous 끝 -->
// <!-- Page번호 시작 -->
                for(var pNo=page.startPage; pNo <= page.endPage; pNo++){
                    if(page.currentPage == pNo){
                        pageCode += '<li class="page-item pageNo active" >';
                        
                    }else{
                        pageCode += '<li class="page-item pageNo" >';
                        
                    }
                    pageCode += '<a class="page-link" href="#">'+pNo+'</a></li>';
                    
                }
// <!-- Page번호 끝 -->
// <!-- Next 시작 -->
                if(page.endPage>=page.totalPages){
                    pageCode += '<li id="next" class="page-item disabled">';
                }else{
                    pageCode += '<li id="next" class="page-item">';
                    
                }
                pageCode += '<a class="page-link" href="#"><i class="mdi mdi-chevron-right"></i></a>';
                pageCode += '</li>';
// <!-- Next 끝 -->
                pageCode += '</ul>';
                
                $(pageContainer).html(pageCode);
                
                $(totalSpan).text("("+total+")")

                console.log("totalSpan : ",totalSpan)
                console.log("total : ",total);
                
//                var tooltipTriggerList = [].slice.call(document.querySelectorAll(
//                    '[data-bs-toggle="tooltip"]'))
//                var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
//                    return new bootstrap.Tooltip(tooltipTriggerEl)
//                })

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
	
	// 업무리스트
    function workList(p_currentPage) {

        // console.log($(this).val());
        // division = $(this).val();`
        var division = $("input[name='division']:checked").val();
        // console.log(division);

        var wkStateObj = $("input[name='wkState']:checked");
        // console.log(wkStateObj);

        var priorityObj = $("input[name='priority']:checked");
        // console.log(priorityObj);

        if (wkStateObj.length < 1 || priorityObj.length < 1) {
            alert("최소 한 개 이상 선택하세요!")
            event.preventDefault()
            return false;
        }

        var wkStateList = [];
        for (var i = 0; i < wkStateObj.length; i++) {
            // console.log(wkStateObj[i].value);
            wkStateList.push(wkStateObj[i].value)
        }

        var priorityList = [];
        for (var i = 0; i < priorityObj.length; i++) {
            // console.log(wkStateObj[i].value);
            priorityList.push(priorityObj[i].value)
        }
        
        var currentPage = 0;
        console.log("p_currentPage : ", p_currentPage);
        
        if(p_currentPage == undefined){
        	currentPage = 1;
        }else if(p_currentPage == "previous"){
        	currentPage = page.startPage-page.pagingCount;
        	
        }else if(p_currentPage == "next"){
        	currentPage = page.startPage+page.pagingCount;
        	
        }else{
        	currentPage = parseInt(p_currentPage);
        
        }
        var size = 8;
        var start = currentPage * size - (size - 1);
        var end = currentPage * size;
        
        $.ajax({
            url: "/project/workList",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                'empId': userId,
                'projId': projId,
                'division': division,
                'currentPage': currentPage,
                'size': size,
                'start': start,
                'end': end,
                'keyWord': "keyWord",
                'wkStateList': wkStateList,
                'priorityList': priorityList
            }),
            success: function (result) {
            	console.log(result);
                console.log(result["workList"]);
                var res = result["workList"]
                var tbody = "";
                $.each(res, function (i, v) {

                    // var workId = "'" + v.workId + "'";
                    tbody +=
                        '<tr class="wkDetail" data-bs-toggle="offcanvas" data-bs-target="#wokrDetail" aria-controls="wokrDetail" >';
                    tbody += '<td class="workId" >' + v.workId + '</td>';
                    tbody += '<td>';
                    if (v.workState == null) {
                        tbody += '-';
                    }
                    if (v.workState == "요청") {
                        tbody +=
                            '<button type="button" class="btn btn-sm btn-info btn-rounded waves-effect ">' +
                            v.workState + '</button>';
                    }
                    if (v.workState == "진행") {
                        tbody +=
                            '<button type="button" class="btn btn-sm btn-success btn-rounded waves-effect ">' +
                            v.workState + '</button>';
                    }
                    if (v.workState == "완료") {
                        tbody +=
                            '<button type="button" class="btn btn-sm btn-dark btn-rounded waves-effect ">' +
                            v.workState + '</button>';
                    }
                    if (v.workState == "이슈") {
                        tbody += '<button type="button" class="btn btn-sm btn-danger btn-rounded waves-effect ">' +
                            v.workState + '</button>';
                    }
                    tbody += '</td>';

                    // 순위
                    if (v.workPriority == null) {
                        tbody += '<td>-</td>';
                    } else {
                        tbody += '<td>';

                        if (v.workPriority == "낮음") {
                            tbody +=
                                '<i class="fa fa-arrow-down icon" style="color:orange"></i>낮음';
                        }
                        if (v.workPriority == "보통") {
                            tbody += '<span class="icon">➖</span>보통';

                        }
                        if (v.workPriority == "높음") {
                            tbody +=
                                '<i class="fa fa-arrow-down icon" style="color:green"></i>높음';

                        }
                        if (v.workPriority == "긴급") {
                            tbody += '<span class="icon">🚨</span>긴급';

                        }
                        tbody += '</td>';
                    }

                    tbody += '<td>' + v.workTitle + '</td>';

                    if (v.workMngr.length == 1) {
                        tbody += '<td>' + v.workMngr[0].workMngrNm + '</sapn></td>';
                    } else if (v.workMngr.length > 1) {
                        tbody +=
                            '<td><span data-bs-toggle="tooltip" data-bs-placement="bottom" title="';
                        for (var i = 0; i < v.workMngr.length; i++) {
                            tbody += v.workMngr[i].workMngrNm;
                            if (i != (v.workMngr.length - 1)) {
                                tbody += ", ";
                            }
                        }

                        tbody += '">' + v.workMngr[0].workMngrNm + '외 ' + (v.workMngr.length - 1) +
                            '명</sapn> </td>';
                    } else {
                        tbody += '<td> - </td>';

                    }

                    tbody += '<td>' + toStringYmd(new Date(v.workMdfyDt)) +
                        '</td>';
                    tbody += '</tr>';


                })

                $("#tbody").html(tbody);
                
                var page = result["page"];
                var total = result["total"];
                var pageCode = '';
                pageCode += '<ul class="pagination pagination-rounded">';
                
// <!-- Previous 시작 -->
                if(page.startPage<page.pagingCount+1){
                	pageCode += '<li id="previous" class="page-item disabled">';
                }else{
                	pageCode += '<li id="previous" class="page-item ">';
                	
                }
                
                pageCode += '<span class="page-link"><i class="mdi mdi-chevron-left"></i></span>';
                pageCode += '</li>';
// <!-- Previous 끝 -->
// <!-- Page번호 시작 -->
                for(var pNo=page.startPage; pNo <= page.endPage; pNo++){
                	if(page.currentPage == pNo){
                		pageCode += '<li class="page-item pageNo active" >';
                		
                	}else{
                		pageCode += '<li class="page-item pageNo" >';
                		
                	}
                	pageCode += '<a class="page-link" href="#">'+pNo+'</a></li>';
                	
                }
// <!-- <li -->
// <%-- class="paginate_button page-item <c:if test='${page.currentPage eq
// pNo}'>active</c:if>"><a --%>
// <%-- href="/human/list?currentPage=${pNo}&keyWord=${param.keyWord}"
// aria-controls="dataTable" --%>
// <%-- data-dt-idx="1" tabindex="0" class="page-link">${pNo}</a></li> --%>
						
         
// <!-- <li class="page-item active"> -->
// <!-- <span class="page-link"> -->
// <!-- 2 -->
// <!-- <span class="sr-only">(current)</span> -->
// <!-- </span> -->
// <!-- </li> -->
// <!-- <li class="page-item"><a class="page-link" href="#">3</a></li> -->

// <!-- Page번호 끝 -->
// <!-- Next 시작 -->
                if(page.endPage>=page.totalPages){
                	pageCode += '<li id="next" class="page-item disabled">';
            	}else{
            		pageCode += '<li id="next" class="page-item">';
            		
            	}
                pageCode += '<a class="page-link" href="#"><i class="mdi mdi-chevron-right"></i></a>';
                pageCode += '</li>';
// <!-- Next 끝 -->
                pageCode += '</ul>';
                
                $("#page-container").html(pageCode);
				
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
    
    // 댓글 리스트
    function rplList(workId){
    	console.log("rplList");
    	$.ajax({
            url: "/project/rplList",
            type: "POST",
            data: {
                'workId': workId
            },
            success: function (res) {
            	console.log(res);
            	var rpl = "";
                $.each(res, function (i, v) {
                	var workRplyMdfyDt = toStringYmdHm(new Date(v.workRplyMdfyDt))
                	
                	rpl += '<form>';
                	rpl += '<div class="rplbox">';
                	rpl += '<div class="thumb size40" style="background-image: url('+v.wrtrPhoto+');  background-size: cover;"></div>';
                	rpl += '<div class="rplContent">';
                	rpl += '<input type="hidden" id="workReplyId" name="workReplyId" value="'+v.workReplyId+'" >';
                	rpl += '<p class="mb-2"><span id="workRplyWrtr">' + v.empName + '</span>&nbsp;&nbsp;<span>' + workRplyMdfyDt + ' </span>&nbsp;&nbsp;';
                	rpl += '<span style="inline-text-align:right;">';
                	if(v.workRplyWrtr == userId){
	                	rpl += '<a href="#" id="rplEditBtn" class="text-primary" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip"data-bs-placement="top" title="수정"><i id="wkUpdate" class="mdi mdi-pencil font-size-18"></i></a>'; 
	                	rpl += '<a href="#" id="rplDelBtn" class="text-danger" data-bs-toggle="tooltip" data-bs-placement="top" title="삭제"><i id="wkdelete" class="mdi mdi-trash-can font-size-18"></i></a>';
                	}
                	rpl += '</span>';
                	rpl += '</p>';
                	rpl += '<p class="mb-2"><span>' + v.workRplyCntnt + '</span></p>';
                	rpl += '</div>';
                	rpl += '</div>';
                	rpl += '</form>';
                })
                
                $("#rplListDiv").html(rpl);
                
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
// alert("js파일");
// alert(projId);
	
	// 페이지 버튼 클릭시
	$(document).on("click", ".workListDiv .pageNo", function(){
		console.log("pageNo : " , $(this).text());
		var currentPage = $(this).text();
		workList(currentPage);
	})
	$(document).on("click", ".workListDiv #previous", function(){
		workList("previous");
	})
	$(document).on("click", ".workListDiv #next", function(){
		workList("next");
	})
	
	// 메인, 홈페이지 버튼 클릭시
	$(document).on("click", ".mainWrokDiv .pageNo", function(){
		var division = $(this).parents(".card").data("id");
		console.log("division : " , division);
		console.log("pageNo : " , $(this).text());
		var currentPage = $(this).text();
		mainWorkList(this, currentPage , division);
	})
	$(document).on("click", ".mainWrokDiv #previous", function(){
		var division = $(this).parents(".card").data("id");
		mainWorkList(this, "previous", division);
	})
	$(document).on("click", ".mainWrokDiv #next", function(){
		var division = $(this).parents(".card").data("id");
		mainWorkList(this, "next", division);
	})
	$(document).on("click", ".homeWorkdt, #work-card .hoverTr", function(){
		var workId = $(this).data("workid");
		console.log(workId)
		// 오프캔버스 활성화
        $(".offcanvas").show();
        // 디테일
    	workDetail(workId);
        // 댓글리스트
        rplList(workId);
	})
	
	
	// 프로그레스바 클릭시
	$(document).on("click", "#insertWorkModal .progress, #updateWorkModal .progress", function(){
		progressClick(this);

	})
	
	// 내브탭 클릭시
	$("#projTab .nav-link").on("click", function(){
		console.log("test")
		var clicktab = $(this).attr('id'); 
		var projId = $(this).data("projid");
		var tabList = [];
		tabList = $("#projTab .nav-link")
		removeClass(tabList, "active");
		$(this).addClass("active");
		
		if(clicktab=="home"){
			location.href = "/project/home?projId="+projId;
		}
		
		if(clicktab=="work"){
			location.href = "/project/work?projId="+projId;
		}
		
		if(clicktab=="ganttchart"){
			location.href = "/project/ganttchart?projId="+projId;
		}
		
		if(clicktab=="calendarTab"){
			location.href = "/project/calendar?projId="+projId;
		}
		if(clicktab=="file"){
			location.href = "/project/file?projId="+projId;
		}
	});

	// 사이드탭 클릭시
	$(".sideBox").on("click", function(){
		workList();
		
	})
	// ========================
	
	
	
    // 업무추가 버튼 클릭시 모달 보여짐
    $("#insertWorkBtn").on("click", function () {
        $("#insertWorkModal").modal("show");

        $("#mngrDiv").empty();
    })

// ------------인서트와 업데이트 모달안에서 이벤트---------------
    // 담당자 클릭시 해당 담당자 추가됨
    
    console.log("두번?")
    $("#insertWorkModal .projmem, #updateWorkModal .projmem ").on("click", function () {
    	mngrBtnAdd(this);
        
    })

    // 추가된 담당자버튼에 있는 x클릭시 담당자 삭제됨
    $(document).on("click", "#insertWorkModal .ri-close-line, #updateWorkModal .ri-close-line", function () {
    	mngrBtnRemove(this);   
    })

    // 업무우선도 클릭시
    $("#insertWorkModal .priorityBtn, #updateWorkModal .priorityBtn").on("click", function () {
        priorityBtnClick(this);

    })

    // 업무상태 버튼 클릭시
    $("#insertWorkModal .wkStateBtn, #updateWorkModal .wkStateBtn").on("click", function () {
        wkStateBtnClick(this);

    })

// $(".offcanvas").on("hidden.bs.offcanvas", function () {
// $("#updateOffcanvas").submit();

// })

// ------------인서트와 업데이트 모달안에서 이벤트 끝---------------

// ------------디테일 클릭시 이벤트---------------
    $(document).on("click", ".wkDetail", function () {
    	console.log("*wkDetail test");
        var workId = $(this).children(".workId").text();
        console.log(workId);
        // 오프캔버스 활성화
        $(".offcanvas").show();
        // 디테일
    	workDetail(workId);
        // 댓글리스트
        rplList(workId);
    	
    })

// ------------디테일 클릭시 이벤트 끝---------------

// ------------디테일 창 안에 데이터 클릭시 이벤트 ----------
    // 상태버튼 클릭시
    $("#wokrDetail .wkStateBtn").on("click", function () {
        Swal.fire({
            title: '상태를 변경하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                wkStateBtnClick(this);
            	updateWork()
            	offHideEvent();
            }
        })

    })

    // 담당자 추가시
    $(document).on("click", "#wokrDetail .projmem", function () {
        Swal.fire({
            title: '담당자를 추가하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
            	mngrBtnAdd(this);
            	updateWork()
            }
        })

    })

    // 담당자 X클릭시
    $(document).on("click", "#wokrDetail .ri-close-line", function () {
        Swal.fire({
            title: '담당자를 삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
            	mngrBtnRemove(this);
                updateWork()
            }
        })

    })
    // 날짜버튼 클릭시
    $("#wokrDetail #workStrtDt, #wokrDetail #workEndDt").on('focusin', function () {
        console.log("value " + $(this).val());
        $(this).data('old', $(this).val());
    });
    
    // 날짜버튼 변경시
    $("#wokrDetail #workStrtDt, #wokrDetail #workEndDt").on("change", function () {
        // alert($("#wokrDetail input[name=oldWorkStrtDt]").val());
        oldvalue = $(this).data('old');
        Swal.fire({
            title: '상태를 변경하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                updateWork()
            }else{
            	$(this).val(oldvalue);
            }
        })

    })

    // 업무우선도 클릭시
    $("#wokrDetail .priorityBtn").on("click", function () {
        Swal.fire({
            title: '업무 우선도를 바꾸시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                priorityBtnClick(this);
                updateWork()
            }else{
            	
            }
        })

    })
    
    // 업무우선도 클릭시
    $("#wokrDetail .progress").on("click", function () {
    	progressClick(this);
    	Swal.fire({
    		title: '업무 진행도를 바꾸시겠습니까?',
    		icon: 'warning',
    		showCancelButton: true,
    		confirmButtonColor: '#3085d6',
    		cancelButtonColor: '#d33',
    		confirmButtonText: '확인',
    		cancelButtonText: '취소'
    	}).then((result) => {
    		if (result.isConfirmed) {
    			updateWork()
    		}else{
    			console.log(this); 
    			var clickVal = $(this).data("old");
    	        $(this).find(".progress-bar").attr("style", "width: "+clickVal +"%")
    	        $(this).find(".progress-bar").attr("aria-valuenow", clickVal)
    	        $(this).find(".progress-bar").text(clickVal+"%");
    	        $(this).find("#workProgress").val(clickVal);
    		}
    	})
    	
    })

    // 수정버튼 클릭시 수정모달에 데이터 집어넣기
    $("#wokrDetail #wkUpdate").on("click", function () {
		// 오프캔버스 닫기
		$("#offClose").trigger('click'); 
		
        $("#updateWorkModal").modal("show");
        console.log("*wkUpdate test");
        var workDetail = $(this).parents("#wokrDetail");
        var workId = workDetail.find("#workId").val();
        var workStartDt = workDetail.find("input[name=oldWorkStrtDt]").val();
        var workEndDt = workDetail.find("input[name=oldWorkEndDt]").val();
        var workState = workDetail.find("#workState").val();
        var workPriority = workDetail.find("#workPriority").val();
        var workTitle = workDetail.find(".workTitleSpan").text();
        var workCntnt = workDetail.find("#workCntnt").val();
        var workMngrObj = workDetail.find("input[name=workMngrId]");
        var workProgress = workDetail.find("#workProgress").val();
// var workMngr = []
// for (var i = 0; i < workMngrObj.length; i++) {
// console.log(workMngrObj);
// workMngr.push(workMngrObj[i].value)
// console.log(workMngr[i]);
// }

// console.log(workId);
// console.log(workStartDt);
// console.log(workEndDt);
// console.log(workState);
// console.log(workPriority);
// console.log(workTitle);
// console.log(workCntnt);

        // 업무코드
        $("#updateWorkModal #workId").val(workId);
        // 제목
        $("#updateWorkModal #workTitle").val(workTitle);
        // 내용
        $("#updateWorkModal #workCntnt").text(workCntnt);
        // 상태
        $("#updateWorkModal #workState").val(workState);
        var removeList = ["btn-info", "btn-success", "btn-dark", "btn-danger"];
        removeClass(".wkStateBtn", removeList);

        if (workState == "요청") {
            $("#updateWorkModal #request").addClass("btn-info");
        }
        if (workState == "진행") {
            $("#updateWorkModal #ing").addClass("btn-success");
        }
        if (workState == "완료") {
            $("#updateWorkModal #complete").addClass("btn-dark");
        }
        if (workState == "이슈") {
            $("#updateWorkModal #issue").addClass("btn-danger");
        }

        // 담당자
        $("#updateWorkModal #mngrDiv").empty()
        for (var i = 0; i < workMngrObj.length; i++) {
        	console.log(workMngrObj[i])
            // 이름들어간 버튼 만들기
            var btn =
                "<button type='button' class='btn btn-outline-info waves-effect waves-light membtn'>";
            btn += "<i class='ri-close-line align-middle me-2'></i>";
            btn += $(workMngrObj[i]).data("workmngrnm");
            btn += "</button>";
            // 선택한 이름 VO에 들어갈 수 있게 히든으로 넣어놓기
            btn += '<input id="workMngrId" name="workMngrId" value="'+$(workMngrObj[i]).val()+'" data-workmngrnm="'+ $(workMngrObj[i]).data("workmngrnm")+'" type="hidden">';

            $("#updateWorkModal #mngrDiv").append(btn);
        }

        // 날짜
        $("#updateWorkModal #workStrtDt").val(workStartDt);
        $("#updateWorkModal #workEndDt").val(workEndDt);

        // 업무순위
        $("#updateWorkModal #workPriority").val(workPriority);
        var removeList = ["btn-outline-secondary", "btn-outline-warning", "btn-outline-dark",
            "btn-outline-success", "btn-outline-danger"
        ];
        removeClass("#updateWorkModal #dropPriority", removeList)

        code = "";
        if (workPriority == "낮음") {
            code += '<i class="fa fa-arrow-down icon" style="color:orange"></i>낮음';
            $("#updateWorkModal #dropPriority").addClass("btn-outline-warning");
        }
        if (workPriority == "보통") {
            code += '<span class="icon">➖</span>보통';
            $("#updateWorkModal #dropPriority").addClass("btn-outline-dark");

        }
        if (workPriority == "높음") {

            code += '<i class="fa fa-arrow-down icon" style="color:green"></i>높음';
            $("#updateWorkModal #dropPriority").addClass("btn-outline-success");

        }
        if (workPriority == "긴급") {
            code += '<span class="icon">🚨</span>긴급';
            $("#updateWorkModal #dropPriority").addClass("btn-outline-danger");

        }
        $("#updateWorkModal #dropPriority").html(code);

        // 업무 진행도
        $("#updateWorkModal .progress-bar").attr("style", "width: "+workProgress +"%")
        $("#updateWorkModal .progress-bar").attr("aria-valuenow", workProgress)
        $("#updateWorkModal .progress-bar").text(workProgress+"%");
        $("#updateWorkModal #workProgress").val(workProgress);

    })
    
    // 삭제버튼 클릭시
	$("#wkdelete").on("click", function(){
		var workId = $(this).parents("#wokrDetail").find("#workId").val();
		
		var conf = confirm("정말로 삭제하시겠습니까?")
		
		if(conf){

            $.ajax({
                url: "/project/deleteWork",
                type: "GET",
                dataType: "json",
                data: {
                    'workId': workId
                },
                success: function (res) {
                	if(res > 0){
                		// 오프캔버스 닫기
                		$("#offClose").trigger('click'); 
                		workList();
                	}else{
						alert("삭제에 실패했습니다.")
                	}
                },
                error: function (xhr) {
                    alert(xhr.status)

                }
            })
		}
	})
					
    // 댓글 등록
	$("#rplInsertBtn").on("click", function(){
		var formData = $("#rplInsertForm").serialize();
		var workId = $(this).parents(".offcanvas").find("#workId").val();
		
		console.log("workId",workId);
		console.log("check",formData);
		$.ajax({
            url: "/project/insertRpl",
            type: "POST",
            data: formData,
            success: function (res) {
                rplList(workId);
				$("#workRplyCntnt").val("");
                
                console.log(res);
                console.log(res.workReplyId);
                var workReplyId = res.workReplyId;
                
                console.log($('#wokrDetail .offcanvas-body')[0].scrollHeight);
            	$('#wokrDetail .offcanvas-body')[0].scrollTo(0,$('#wokrDetail .offcanvas-body')[0].scrollHeight);
            	
                
            },
            error: function (xhr) {
                alert(xhr.status)

            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token)
            },
            dataType: "json"
		})
	})
	
	
			
    // 댓글 수정
	$("#rplEditBtn").on("click", function(){
		
		$.ajax({
            url: "/project/updateRpl",
            type: "POST",
            data: formData,
            success: function (res) {
            	if(res>0){
            		rplList(workId);
            		$('.offcanvas-body').scrollTop($('.offcanvas-body')[0].scrollHeight);
            	}
               
            },
            error: function (xhr) {
                alert(xhr.status)

            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token)
            },
            dataType: "json"
		})
	})
	
			
    // 댓글 삭제
	$(document).on("click", "#rplDelBtn", function(){
		var workReplyId = $(this).parents(".rplContent").find("#workReplyId").val();
		var workId = $(this).parents(".offcanvas").find("#workId").val();
		
		$.ajax({
            url: "/project/deleteRpl",
            type: "POST",
            data: {"workReplyId" : workReplyId},
            success: function (res) {
            	if(res > 0){
            		rplList(workId);
            		$('.offcanvas-body').scrollTop($('.offcanvas-body')[0].scrollHeight);
            	}else{
            		alert("삭제에 실패했습니다.");
            	}
            },
            error: function (xhr) {
                alert(xhr.status)

            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token)
            },
            dataType: "json"
		})
	})
	



// ------------디테일 창 안에 데이터 클릭시 이벤트 끝----------
	
// ---------------수정모달 안에서 이벤트 ---------------

// ---------------수정모달 안에서 이벤트 끝 ---------------

// 홈 디테일에서 이벤트
	$(".rplShow").on("click", function(){
		var workId = $(this).parents(".homeWkDetail").find("#workId").val();
		var rplListDiv = $(this).parents(".homeWkDetail").find(".rplListDiv");
		$(this).parents(".homeWkDetail").find(".rplShow").hide();
		$(this).parents(".homeWkDetail").find(".rplHide").show();
		
		$.ajax({
            url: "/project/rplList",
            type: "POST",
            data: {
                'workId': workId
            },
            success: function (res) {
            	console.log(res);
            	rpl = '';
        		$.each(res, function (i, v) {
        			var workRplyMdfyDt = toStringYmdHm(new Date(v.workRplyMdfyDt))
        			
        			rpl += '<form>';
        			rpl += '<div class="rplbox">';
        			rpl += '<div class="thumb size40" style="background-image: url('+v.wrtrPhoto+');  background-size: cover;"></div>';
        			rpl += '<div class="rplContent">';
        			rpl += '<input type="hidden" id="workReplyId" name="workReplyId" value="'+v.workReplyId+'" >';
        			rpl += '<p class="mb-2"><span id="workRplyWrtr">' + v.empName + '</span>&nbsp;&nbsp;<span>' + workRplyMdfyDt + ' </span>&nbsp;&nbsp;';
        			rpl += '<span style="inline-text-align:right;">';
        			if(v.workRplyWrtr == userId){
        				rpl += '<a href="#" id="rplEditBtn" class="text-primary" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip"data-bs-placement="top" title="수정"><i id="wkUpdate" class="mdi mdi-pencil font-size-18"></i></a>'; 
        				rpl += '<a href="#" id="rplDelBtn" class="text-danger" data-bs-toggle="tooltip" data-bs-placement="top" title="삭제"><i id="wkdelete" class="mdi mdi-trash-can font-size-18"></i></a>';
        			}
        			rpl += '</span>';
        			rpl += '</p>';
        			rpl += '<p class="mb-2"><span>' + v.workRplyCntnt + '</span></p>';
        			rpl += '</div>';
        			rpl += '</div>';
        			rpl += '</form>';
        		})
        		rpl += '<div id="rpl" class="shadow">';
        		rpl += '<form modelAttribute="projWorkReplyVO" id="rplInsertForm"';
        		rpl += 'method="POST" action="/project/insertRpl">';
        		rpl += '<div class="thumb size40"';
        		rpl += 'style="background-image: url();  background-size: cover;"></div>';

        		rpl += '<div class="rplContent">';
        		rpl += '<input type=hidden id="projId" name="projId" value="" />';
        		rpl += '<input type=hidden id="workRplyWrtr" name="workRplyWrtr" value="" />';
        		rpl += '<input type=hidden id="workId" name="workId" value="" />';
        		rpl += '<textarea row="1" class="form-control" path="workRplyCntnt"';
        		rpl += 'placeholder="댓글을 입력하세요." aria-label=".form-control-lg example"></textarea>';
        		rpl += '</div>';

        		rpl += '<div class="rplContent">';
        		rpl += '<button type="button" id="rplInsertBtn"';
        		rpl += 'class="btn btn-info waves-effect waves-light"';
        		rpl += 'style="margin-bottom: 30px;">등록</button>';
        		rpl += '</div>';
        		rpl += '</form>';
        		rpl += '</div>';
        		
        		$(rplListDiv).html(rpl);
        		
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
	})
	
	$(".rplHide").on("click", function(){
		$(this).parents(".homeWkDetail").find(".rplShow").show();
		$(this).parents(".homeWkDetail").find(".rplHide").hide();
		$(this).parents(".homeWkDetail").find(".rplListDiv").html("");
	})
// 홈 디테일에서 이벤트 끝
	

    

	
})
