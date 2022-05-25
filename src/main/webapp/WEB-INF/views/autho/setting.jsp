<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 커스텀 CSS -->
<link rel="stylesheet" href="/resources/css/autho.css" type="text/css"/>

<div class="row m-1">
	<h3 class="h3 mb-2 text-gray-800" style="color: #6c6ff5">전자결재 설정</h3>
</div>

<div class="row m-1">
	<div class="card overflow-hidden card-h-100">
		<div class="card-body pt-5" id="j-card">
			<form action="/autho/signInsert" method="post" enctype="multipart/form-data">
			<sec:csrfInput/>
			<div class="row gx-10 mb-3">
				<div class="col-md-4">
					<input type="file" id="uploadFile" name="uploadFile" class="form-control"/>
					<label for="uploadFile" class="form-label mt-2">서명을 등록해주세요. 서명은 이미지(png)로 저장됩니다.</label>
				</div>
				<div class="col-md-3" id="imgs_wrap" style="width:220px; height:80px;">
					<img src="${attachVO.atchPath}" style="width:100%; height:100%;">
				</div>
				<div class="col-md-2">
					<button id="signBtn" type="button" class="btn btn-outline-primary">서명등록</button> 
				</div>
				<div class="col-md-3">
				</div>
			</div>
			</form>
		</div>
	</div>
</div>
<script>
$(function(){
	
	
	$("#uploadFile").on("change",handleImgsFilesSelect);
	
	$("#signBtn").on("click",function(){
		var v_uploadFile = $("#uploadFile").val();
		if(v_uploadFile == ""){
			alert("서명을 등록해주세요.");
			return false;
		}
		$("form").submit();
	})
	
	if("${param.settingA}" == "A"){
		alert("서명이 등록되었습니다.");
	}
	
})

function handleImgsFilesSelect(e){
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			alert("이미지만 가능합니다.");
			$("#uploadFile").val("");
			return false;
		}
		console.log("filesArr",filesArr);
		//각 이미지를 reader로 읽어들임
		var reader = new FileReader();
		reader.onload = function(e){
			var img_html = "<img src=\"" + e.target.result + "\" style='width:100%; height:100%;'  />";
			$("#imgs_wrap").html("");
			$("#imgs_wrap").append(img_html);
		}
		reader.readAsDataURL(f);
	})
}
</script>



