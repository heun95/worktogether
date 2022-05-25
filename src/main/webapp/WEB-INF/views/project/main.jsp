<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>

<link href="/resources/css/project.css" rel="stylesheet" type="text/css" />

<style>

</style>

<div class="card vh30">
	<div class="card-body pb-0">
		<div class="row mb-3">
			<div class="col-lg-8">
				<h4>내 프로젝트</h4>
			</div>
			<div class="col-lg-4">
				<!-- Button trigger modal -->
				<button type="button" id="insertBtn" class="btn btn-primary"
					data-toggle="modal" data-target="#projInsertModal">새프로젝트</button>
			</div>
		</div>
		<div class="row" style="height: 150px;">
			<div class="col-1">
				<a href="#" onclick="slider.next()"><i
					class="fas fa-chevron-left sliderBtn"></i></a>
			</div>
			<div class="col-10">
				<div id="slider">
					<c:forEach var="projVO" items="${list }">
						<div class="col p-3 py-4 item projDetail"
							data-projId="${projVO.projId }">

							<p class="projName">${projVO.projName}</p>

							<fmt:formatDate value="${projVO.projStrtDt  }" pattern="yyyy-MM-dd"/>
							~
							<fmt:formatDate value="${projVO.projEndDt  }" pattern="yyyy-MM-dd"/>
							<br />

						</div>
					</c:forEach>
				</div>
			</div>

			<div class="col-1">
				<a href="#" onclick="slider.prev()"><i
					class="fas fa-chevron-right sliderBtn"></i></a>
			</div>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-4">
		<div class="card mainWrokDiv vh55" id="get" data-id="get">
<!-- 			<div class="card-title text-center m-0 p-1"> -->
<!-- 				요청받은 업무 목록 -->
<!-- 			</div> -->
			<div class="card-body mainWrokDiv p-1">
				<div class="mb-2">
		        	<ul class="nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
                       <li class="nav-item">
                           <a class="nav-link active" data-bs-toggle="tab" href="#home1" role="tab" aria-selected="true">
                               <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
                               <b><span class="d-none d-sm-block">받은 요청 <span class="total">(0)</span></span></b> 
                           </a>
                       </li>
                       
                   </ul>
	        	</div> 
				<div class="table-container vh40">
					
				</div>
				<div class="page-container">
					
				</div>
			</div>
		</div>
	</div>

	<div class="col-4">
		<div class="card mainWrokDiv vh55" id="give" data-id="give">
			<div class="card-body p-1">
				<div class="mb-2">
		        	<ul class="nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
                       <li class="nav-item">
                           <a class="nav-link active" data-bs-toggle="tab" href="#home1" role="tab" aria-selected="true">
                               <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
                               <b><span class="d-none d-sm-block">보낸 요청 <span class="total">(0)</span></span></b> 
                           </a>
                       </li>
                       
                   </ul>
	        	</div> 
			
				<div class="table-container vh40"></div>
				<div class="page-container"></div>
			
			</div>
			
			
		</div>
	</div>

	<div class="col-4">
		<div class="card mainWrokDiv vh55" id="issue" data-id="issue">
<!-- 			<div class="card-title">이슈 목록</div> -->
			<div class="card-body p-1">
				<div class="mb-2">
		        	<ul class="nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
                       <li class="nav-item">
                           <a class="nav-link active" data-bs-toggle="tab" href="#home1" role="tab" aria-selected="true">
                               <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
                               <b><span class="d-none d-sm-block">이슈 목록 <span class="total">(0)</span></span> </b>
                           </a>
                       </li>
                       
                   </ul>
	        	</div> 
				<div class="table-container vh40">
					
				</div>
				<div class="page-container">
					
				</div>
			</div>
		</div>
	</div>
</div>
<!-- row end -->




<sec:authentication property="principal.user" var="user"/>

<!--insert Modal -->
<div class="modal" id="projInsertModal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<form:form modelAttribute="projectVO" method="post"
				action="/project/projInsert">
				<div class="modal-header">
					<h5 class="modal-title">새프로젝트</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row mb-3">
						<label for="example-text-input" class="col-sm-4 col-form-label">프로젝트명</label>
						<div class="col-sm-8">
							<form:input class="form-control" path="projName" />
						</div>
					</div>
					<div class="row mb-3">
						<label for="example-text-input" class="col-sm-4 col-form-label">프로젝트설명</label>
						<div class="col-sm-8">
							<form:textarea class="form-control" path="projCntnt" />
						</div>
					</div>
					<div class="row mb-3">
						<label for="example-date-input" class="col-sm-4 col-form-label">시작일자</label>
						<div class="col-sm-8">
							<form:input class="form-control" type="date" path="projStrtDt" />
						</div>
					</div>
					<div class="row mb-3">
						<label for="example-date-input" class="col-sm-4 col-form-label">만료일자</label>
						<div class="col-sm-8">
							<form:input class="form-control" type="date" path="projEndDt" />

						</div>
					</div>
					<div class="row mb-3">
						<label for="example-date-input" class="col-sm-4 col-form-label">팀원</label>
						<div class="col-sm-8">
							<div id="memDiv">
								<button type='button' class='btn btn-outline-info waves-effect waves-light membtn' data-empid='${user.username }' style='display: none;'>
	       						<i class='ri-close-line align-middle me-2'></i></button>
								<form:hidden path="projMemList" value="${user.username }" />
							</div>
							<p class="addMem">추가하기</p>
							<div id="tree" class="bstreeview"></div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" id="okBtn" class="btn btn-primary">확인</button>
				</div>
				<sec:csrfInput />
			</form:form>
		</div>
	</div>
</div>

<%@ include file="detailWork.jsp" %>

<script src="/resources/js/project.js"></script>

<script type="text/javascript">
	var backColor =["#00b2ff", "#00b01c", "#fd7900", "#402a9d"]
	var Slider = function(id, _web, _tab, _mobile, spacing){
		  var containerWidth = 0;
		  var sliderItemWidth = 0;
		  var totalCount = 0;
		  var spacing = spacing || 10;
		  var display = _web;
		  var left = 0;
		  var interval;

		  var DOM = {
		    container: function(id){
		      var dom = document.querySelector('#'+id);
		      dom.className = 's-container';
		      dom.style.position = 'relative';
		      dom.style.overflow = 'hidden';
		      return dom;
		    },
		    slider: function(container){
		      totalCount = container.children.length;

		      var dom = document.createElement('div');
		      dom.className = 'slider'
		      dom.style.position = 'relative';
		      dom.style.overflow = 'hidden';
		      dom.style.height = '20%';
		      dom.style.left = 0;
		      dom.style.transition = 'left .5s';
		      return dom;
		    }
		  }

		  // DOM 만들기
		  var container = DOM.container(id);
		  var slider = DOM.slider(container);
		  var temp = container.innerHTML;
		  container.innerHTML = '';
		  slider.innerHTML = temp;
		  container.appendChild(slider);
		  var items = document.querySelector('#'+ id + ' .slider').children;
		  for(var i=0; i<items.length; i++){
		    items[i].style.float = 'left';
		    items[i].style.height = '100%';
		    items[i].style.width = (sliderItemWidth-spacing)+ 'px';
// 		    console.log(backColor[Math.floor(Math.random() * backColor.length)]);
		    items[i].style.borderLeft = '8px solid ' + backColor[Math.floor(Math.random() * backColor.length)];
		    items[i].style['margin-right'] = spacing+'px'; // 간격
		  }

		  // 화면 사이즈 수정시 발생하는 이벤트
		  function resize(){
		    left = 0;
		    document.querySelector('#'+ id + ' .slider').style.left = left + 'px';

		    var innerWidth = window.innerWidth;
		    if(innerWidth >= 1000){
		      setDisplayCount(_web);
		    }else if(innerWidth < 1000 && innerWidth >= 768) {
		      setDisplayCount(_tab);
		    }else if (innerWidth < 768) {
		      setDisplayCount(_mobile);
		    }
		    
		    if(display === 1){
		      spacing = 0;
		      var items = document.querySelector('#'+ id + ' .slider').children;
		      for(var i=0; i<items.length; i++){
		        items[i].style.width = sliderItemWidth + 'px';
		        items[i].style['margin-right'] = 0 + 'px'; // 간격
		      }
		    }
		  }

		  // 디스플레이 갯수 설정 함수
		  function setDisplayCount(count) {
		    display = count;

		    containerWidth = container.offsetWidth + spacing;
		    sliderItemWidth = containerWidth / display;

		    document.querySelector('#'+ id + ' .slider').style.width = totalCount * sliderItemWidth + spacing * totalCount + 'px';
		    var items = document.querySelector('#'+ id + ' .slider').children;
		    for(var i=0; i<items.length; i++){
		      items[i].style.width = (sliderItemWidth-spacing)+ 'px';
		    }
		  }

		  // 반응형 디스플레이 갯수 조절
		  var isResponsive = _tab != undefined && _mobile != undefined;
		  if(isResponsive){
		    window.onresize = resize;
		  }
		  resize();


		  return {
		    setDisplayCount: setDisplayCount,
		    move: function(index){
		      left = (-1) * sliderItemWidth * index;
		      document.querySelector('#'+ id + ' .slider').style.left = left + 'px';
		    },
		    prev: function(){
		      left += sliderItemWidth;
		      var limit = 0;
		      if(left > limit){
		        left = limit;
		      }
		      document.querySelector('#'+ id + ' .slider').style.left = left + 'px';
		    },
		    next: function(){
		      left -= sliderItemWidth;
		      var limit = (-1) * sliderItemWidth * (totalCount - display);
		      if(left < limit){
		        left = limit;
		      }
		      document.querySelector('#'+ id + ' .slider').style.left = left + 'px';
		    },
		    auto: function(){
		      clearInterval(interval);
		      interval = setInterval(function(){
		        left -= sliderItemWidth;
		        var limit = (-1) * sliderItemWidth * (totalCount - display);
		        if(left < limit){
		          left = 0;
		        }
		        document.querySelector('#'+ id + ' .slider').style.left = left + 'px';
		      }, 20000)
		    },
		    stop: function(){
		      clearInterval(interval);
		    }
		  }
		}
		
		// id, _web, _tab, _mobile, spacing
		var slider = new Slider('slider', 4, 3, 1, 50);
		slider.auto();
	
	$(function() {
		$('#projInsertModal').on('hide.bs.modal', function (e) {
			  $(".modal-backdrop").remove();
		})
		
		// 시연용 데이터
		$(".modal-title").on("click", function(){
			$("#projName").val("투게터 프로젝트");
			$("#projCntnt").val("투게터 프로젝트 입니다.");
			$("#projStrtDt").val("2021-04-21");
			$("#projEndDt").val("2021-05-21");
		})
		
		// 업무목록 출력
		mainWorkList("get", 1 , "get");
		mainWorkList("give", 1 , "give");
		mainWorkList("issue", 1 , "issue");
		
		$("#insertBtn").on("click", function() {
// 			var win = window.open("/project/projInsert", "projInsert", "width=500,height=600");
			$('#projInsertModal').modal('show');
			
		});
// 		$("#okBtn").on("click", function() {
// 			$('#projInsertModal').modal('hide')
// 		})
		
		$(".projDetail").on("click", function(){
			
			var projId = $(this).data("projid");
			location.href = "/project/home?projId="+projId;
		})
		
		// 팀원추가 클릭시 조직도 보여짐
		$(".addMem").on("click", function(){
// 			$("#jojikdoModal").modal("show");

			$("#projInsertModal #tree").show();
		})
		
		// 조직도에서 직원 클릭시 
		$(document).on("click", ".emp", function(){
			var empName  = $(this).data("empname");
			var empid  = $(this).data("empid");
			var memlist = [];
	        
	        memlist = $(".membtn");
			console.log(memlist);
			
	        // 중복이름 선택시 리턴
	        for (var i = 0; i < memlist.length; i++) {
	            if (empid == $(memlist).data("empid")) {
	            	alert("이미 선택했습니다.");
	                return false;
	            }
	        }
// 			console.log("test :  ", $(p_mngr));
// 			console.log("test :  ", $(p_mngr).data("empid"));
	        // 이름들어간 버튼 만들기
	        var btn = "<button type='button' class='btn btn-outline-info waves-effect waves-light membtn' data-empid='" + $(this).data("empid")+"'>";
	        btn += "<i class='ri-close-line align-middle me-2'></i>";
	        btn += empName;
	        btn += "</button>";
	        // 선택한 이름 VO에 들어갈 수 있게 히든으로 넣어놓기
	        btn += '<input id="projMemList" name="projMemList" value="'+ $(this).data("empid")+'" data-workmngrnm="' + empName +
	            '" type="hidden">';
	            console.log("btn", btn)
			console.log('$("#memDiv")', $("#memDiv"))
	        $("#memDiv").append(btn);
		})
		
		$(document).on("click", ".ri-close-line", function(){
			var memBtn = $(this).parents(".btn")[0];
			console.log(memBtn);
	        var memNm = $(memBtn).text();
	        // 히든 없애기
	        $(memBtn).parents("#memDiv").find("input[data-workMngrNm=" + memNm + "]").remove();
	        // 버튼 없애기
	        $(memBtn).remove();
			
		})
		

		
		var v_treeBtnValue = "treeAll";
		$.ajax({
			url: "/common/treeList",
			type: "POST",
			contentType : "application/json; charset=utf-8",
			data: JSON.stringify({
				"treeSelect" : v_treeBtnValue
			}),
			success: function(res) {
				console.log(res);
				$("#treeContainer").css("display","block");
				var v_result = "";
				var v_index = 0;
				$.each(res,function(i,v){
					if(v.topDeptId != null && v.topDeptId != 'DEP00'){
						v_result += '	<div href="#tree-item-'+(v_index++)+'" class="list-group-item" data-toggle="collapse" style="padding-left: 1.25rem;" aria-expanded="true">';
						v_result += '		<i class="state-icon fa-angle-down fa"></i>'+v.topDeptName;
						v_result += '	</div>';
						v_result += '	<div class="list-group collapse" id="tree-item-'+(v_index-1)+'" style="">';
						
						$.each(v.deptList,function(i1,v1){
								v_result += '	<div href="#tree-item-'+(v_index++)+'" class="list-group-item " data-toggle="collapse" style="padding-left: 2.5rem;">';
								v_result += '		<i class="state-icon fa fa-angle-right"></i>'+v1.deptName+'';
								v_result += '	</div>';
								v_result += '	<div class="list-group collapse" id="tree-item-'+(v_index-1)+'">';
								$.each(v1.employeeList,function(i2,v2){
									v_result += ' 	<div data-empid="'+v2.empId+'" data-empname="'+v2.empName+'" href="#tree-item-'+(v_index++)+'" class="list-group-item emp" data-toggle="collapse" style="padding-left: 3.75rem;">';
									if(v2.empName == null){
										v_result += ' 		(직원 없음)';	
									}else{
										v_result += ' 		'+v2.empName+'('+v2.cmmnGroupName+')';
									}
									v_result += ' 	</div>';
								})
								v_result += ' 	</div>';
						})
						v_result += '	</div>';
					}
				})
				$("#projInsertModal #tree").html(v_result);
				
			},
			error: function(xhr) {
				alert(xhr.status)
			},
			beforeSend: function (xhr) {
	                xhr.setRequestHeader(header, token)
			},
			dataType: "json"
		})

		

	})
	</script>
