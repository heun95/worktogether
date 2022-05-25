<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!-- 조직도에 필요한 CSS와 JS  -->
<link href="/resources/css/bstreeview.min.css" rel="stylesheet" type="text/css" />
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<button type="button" class="treeBtn" value="treeSome">조직도 조회(직원없는 부서 제외)</button>
<button type="button" class="treeBtn" value="treeAll">조직도 조회(전부)</button>

<div class="container" id="treeContainer" style="display:none;">
  <div class="content">
	<div class="col-md-4 pt-5">
		<div id="tree" class="bstreeview"></div>
	</div>
  </div>
</div>

<script>
$(function(){
	var token = "${_csrf.token }";
	var header = "${_csrf.headerName }";
	
	$(".treeBtn").on("click",function(){
		var v_treeBtnValue = $(this).val();
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
								v_result += '	<div href="#tree-item-'+(v_index++)+'" class="list-group-item" data-toggle="collapse" style="padding-left: 2.5rem;">';
								v_result += '		<i class="state-icon fa fa-angle-right"></i>'+v1.deptName+'';
								v_result += '	</div>';
								v_result += '	<div class="list-group collapse" id="tree-item-'+(v_index-1)+'">';
								$.each(v1.employeeList,function(i2,v2){
									v_result += ' 	<div href="#tree-item-'+(v_index++)+'" class="list-group-item" data-toggle="collapse" style="padding-left: 3.75rem;">';
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
				$("#tree").html(v_result);
				
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
})
</script>

<!-- 부서 조회(전부) 시작 - 수경 -->
<hr>
<button type="button" class="treeDepartBtn" value="treeAll">부서 조회(전부)</button>

<div class="container" id="treeDepartContainer" style="display:none;">
  <div class="content">
	<div class="col-md-4 pt-5">
		<div id="treeDepart" class="bstreeview"></div>
	</div>
  </div>
</div>
<script>
$(function(){
	var token = "${_csrf.token }";
	var header = "${_csrf.headerName }";
	
	$(".treeDepartBtn").on("click",function(){
		var v_treeBtnValue = $(this).val();
		$.ajax({
			url: "/common/treeList",
			type: "POST",
			contentType : "application/json; charset=utf-8",
			data: JSON.stringify({
				"treeSelect" : v_treeBtnValue
			}),
			success: function(res) {
				console.log(res);
				$("#treeDepartContainer").css("display","block");
				var v_result = "";
				var v_index = 0;
				$.each(res,function(i,v){
					if(v.topDeptId != null && v.topDeptId != 'DEP00'){
						v_result += '	<div href="#tree-item-'+(v_index++)+'" class="list-group-item" data-toggle="collapse" style="padding-left: 1.25rem;" aria-expanded="true">';
						v_result += '		<i class="state-icon fa-angle-down fa"></i>'+v.topDeptName;
						v_result += '	</div>';
						v_result += '	<div class="list-group collapse" id="tree-item-'+(v_index-1)+'" style="">';
						
						$.each(v.deptList,function(i1,v1){
								v_result += '	<div href="#tree-item-'+(v_index++)+'" class="list-group-item" data-toggle="collapse" style="padding-left: 2.5rem;">';
								v_result += '		'+v1.deptName+'';
								v_result += '	</div>';
								v_result += '	<div class="list-group collapse" id="tree-item-'+(v_index-1)+'">';
								v_result += ' 	</div>';
						})
						v_result += '	</div>';
					}
				})
				$("#treeDepart").html(v_result);
				
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
})
</script>
<!-- 부서 조회(전부) 끝 - 수경 -->

