<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>

<link href="/resources/css/project.css" rel="stylesheet" type="text/css" />


<style>
.card-title{
	height: auto;
}
.container{
	display: flex;
}
.table-container {
	overflow: auto;
}
</style>


<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
				<%@ include file="includeTab.jsp" %>
			</div>
		</div>
	</div>
</div>

<div class="row">

<!--     <div class="col-lg-1"> -->
<!--     </div> -->
    <div class="col-lg-8">
    	<div class="row">
	        <div class="col-lg-3">
		        <div class="card">
		            <div class="card-body vh45">
		            	<h5 class="text-center mb-4">참여자</h5>
				            <c:forEach var="projmem" items="${memlist }">
			            	<div class="container m-2">
					            <div class="item thumb size40 projmem" style="background-image: url('${projmem.empPhoto }'); background-size: cover;" data-empid="${projmem.empId }">
					             </div>
					           <div class="item m-2">
					            	${projmem.empName } 
					           </div>
				            </div>
				            </c:forEach>
		            </div>
		        </div>
        	</div>
    		<div class="col-lg-9"> 
		        <div class="card">
		            <div class="card-body vh45">
		                <div id="pie_chart" class="apex-charts" dir="ltr"></div>
		            </div>
		        </div>
	        </div>
        </div>
        <div class="card">
            <div class="card-body vh45">
                <div id="line_chart" class="apex-charts" dir="ltr"></div>   
            </div>
        </div>
    </div>
    <div class="col-lg-4">
         <div class="card mainWrokDiv"  id="late" data-id="late">
            <div class="card-body mainWrokDiv p-1 vh45">
				<div class="mb-2">
		        	<ul class="nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
                       <li class="nav-item">
                           <a class="nav-link active" data-bs-toggle="tab" href="#home1" role="tab" aria-selected="true">
                               <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
                               <b><span class="d-none d-sm-block">지난 업무 <span class="total"></span></span></b> 
                           </a>
                       </li>
                       
                   </ul>
	        	</div> 
				<div class="table-container h70">
					
				</div>
				<div class="page-container">
					
				</div>
			</div>
		</div>
         <div class="card mainWrokDiv" id="come" data-id="come">
            <div class="card-body mainWrokDiv p-1 vh45">
				<div class="mb-2">
		        	<ul class="nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
                       <li class="nav-item">
                           <a class="nav-link active" data-bs-toggle="tab" href="#home1" role="tab" aria-selected="true">
                               <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
                               <b><span class="d-none d-sm-block">마감임박 업무<span class="total"></span></span></b> 
                           </a>
                       </li>
                       
                   </ul>
	        	</div> 
				<div class="table-container h70">
					
				</div>
				<div class="page-container">
					
				</div>
			</div>
		</div>

    </div>
 </div>


<%@ include file="modal.jsp"%>

<!-- apexcharts -->
<script src="/resources/dist/assets/libs/apexcharts/apexcharts.min.js"></script>
<script src="/resources/js/project.js"></script>
<script>

	// 현재 업무량 가져오기
	var labelsData = [];
	var seriesData = [];
		
	$.ajax({
	    url: "/project/projChart",
	    type: "GET",
	    data: {
	        'projId': projId
	    },
	    async: false,
	    success: function (res) {
	        
	        labelsData = Object.keys(res);
	        $.each(res, function(i, v) {
	        	seriesData.push(v);
	        })
	
	    },
	    dataType: "json"
	})
	
	options = {
	    chart: {
	        height: 320,
	        type: "pie"
	    },
	    title: {
            text: "현재업무현황",
            align: "left"
        },
// 	    series: [44, 55, 41, 17],
	    series: seriesData,
// 	    labels: ["Series 1", "Series 2", "Series 3", "Series 4", "Series 5"],
	    labels: labelsData,
// 	    colors: ["#6fbe36", "#6c6ff5", "#fcb92c", "#2ec8f1", "#ff5d5d"],
	    colors: ["#6c6ff5", "#2ec8f1", "#00b19c", "#ff5d5d"],
	    legend: {
	        show: !0,
	        position: "top",
	        horizontalAlign: "right",
	        verticalAlign: "right",
	        floating: !1,
	        fontSize: "14px",
	        offsetX: 0,
	        offsetY: 5,
	        formatter: function(seriesName, opts) {
	            return [seriesName, " (", opts.w.globals.series[opts.seriesIndex], ")"]
	        }
        
	    },
	    responsive: [{
	        breakpoint: 600,
	        options: {
	            chart: {
	                height: 300
	            },
	            legend: {
	                show: !1
	            }
	        }
	    }]
	};
	(chart = new ApexCharts(document.querySelector("#pie_chart"), options)).render();
	
	
	// 일일 업무량 가져오기
	var memObj = $(".projmem");
	var memList = [];
	var seriesData = [];  	
	var categoriesData = [];
	
	for(var i=0; i < memObj.length; i++){
		memList.push($(memObj[i]).data("empid"));
	}
	
	$.ajax({
	    url: "/project/workCountDate",
	    type: "POST",
	    contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
	        'projId' : projId,
	        'memList' : memList
	    }),
	    async: false,
	    success: function (res) {
	        console.log("workCountDate : ", res);
		        
// 		        name: "이중호",
// 	            data: [26, 24, 32, 36, 33, 31, 12]
		     
	        
	        for(var i=0; i < memList.length; i++){
	        	
				var empName = '';
				var cntList = [];
				var ymd = '';
	        	for(var j=0; j < res.length; j++){
// 			        	console.log("res[i] : ", res[i].EMP_ID);
	        		if(memList[i] == res[j].EMP_ID){
	        			empName = res[j].EMP_NAME
	        			cntList.push(res[j].CNT);
		        		console.log("res[j]  ", res[j].EMP_ID);
		        		ymd = res[j].YMD;
						if(i==0){
							categoriesData.push(ymd);
							
						}
	        		}
	        	}
        		var seriesTemp = {
        				name : empName,
        				data : cntList
        			}
        		seriesData.push(seriesTemp);
			}

       		console.log("categoriesData", categoriesData);
	
	    },
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token)
        },
	    dataType: "json"
	})
		
	var line_options = {
        chart: {
            height: 320,
            type: "line",
            zoom: {
                enabled: !1
            },
            toolbar: {
                show: !1
            }
        },
        colors: ["#6c6ff5", "#00B19C", "#ff5d5d", "#ff9b2d", "#4f9dff"],
        dataLabels: {
            enabled: !1
        },
        stroke: {
            width: [3, 3],
            curve: "straight"
        },
        series: seriesData,
//         series: [
        	
//         	{
// 	            name: "이중호",
// 	            data: [26, 24, 32, 36, 33, 31, 12]
// 	        } 
        	
// 	        ,{
// 	            name: "손영흔",
// 	            data: [14, 11, 16, 12, 17, 13, 12]
// 	        }
	        
//         ],
        title: {
            text: "일일업무량",
            align: "left"
        },
        grid: {
            row: {
                colors: ["transparent", "transparent"],
                opacity: .2
            },
            borderColor: "#f1f1f1"
        },
        markers: {
            style: "inverted",
            size: 6
        },
        xaxis: {
//             categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
            categories: categoriesData,
            title: {
                text: "Week"
            }
        },
        yaxis: {
            title: {
                text: ""
            },
            min: 0,
            max: 20
        },
        legend: {
            position: "top",
            horizontalAlign: "right",
            floating: !0,
            offsetY: -25,
            offsetX: -5
        },
        responsive: [{
            breakpoint: 600,
            options: {
                chart: {
                    toolbar: {
                        show: !1
                    }
                },
                legend: {
                    show: !1
                }
            }
        }]
    },
    
    chart = new ApexCharts(document.querySelector("#line_chart"), line_options);
	chart.render();
	
	// 마감지남, 마감임박 데이터 리스트로 가져오기
	mainWorkList("late", 1, "late")
	mainWorkList("come", 1, "come")
</script>
