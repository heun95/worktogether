<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- <link href="https://fonts.googleapis.com/css2?family=Dongle&display=swap" rel="stylesheet"> -->
<style>
#mainform{
	background-color:#D9E5FF;
	width: 15%;
	height: 30vh;
	margin-bottom: 50px;
	margin-right:20px;
	float: left;
}

#writeform{
	background-color:#D9E5FF;
}
#WrtDt{
	margin-left:10px;
	font-family: 'Dongle', sans-serif;
	font-size: 0.8em;
	margin-top: 15px;
	
}

body{ -ms-overflow-style: none; } 
::-webkit-scrollbar { display: none; } 
/*특정 부분 스크롤바 없애기*/ 
.box{ -ms-overflow-style: none; } 
.box::-webkit-scrollbar{ display:none; }

</style>
<button data-toggle="modal" data-target="#writeModal" 
		onclick="writeMemo(this)" class="btn btn-primary " style="margin-bottom: 20px;">메모 작성</button>
<img src="/resources/images/write.png" style="width: 50px; height: 50px; margin-bottom:23px;"/>

<div class="box"  style="overflow-y: scroll;">
	<c:forEach var="row" items="${list}" >
		<div class="mainbox" style="width: 99%;" data-memoid="${row.memoId}" >
			<form id="mainform" >
				<p id="WrtDt" >작성일 | <fmt:formatDate value="${row.memoWrtDt}"  pattern="yyyy-MM-dd  hh:mm"/>
				<button  type="button" onclick="delcheck(this)" class="text-primary" style="margin-bottom:10px; float: right;background: none;border: 0;outline: 0;">
						 <i class="mdi mdi-trash-can font-size-18" ></i>
				</button>
				</p>
				
				<textarea id ="one" rows="10" onclick="updateform(this)" style="background: none; border: none;
							color:purple;text-align: center; margin-left: 10px;width: 95%;">${row.memoCntnt}</textarea>
							
				<div id="updatediv" style="display:none;">
					<div class="updatecntnt"   style="margin-bottom: 10px;">
						<textarea id="updateTextarea" class="form-control form-control-sm" rows="6" >${row.memoCntnt}</textarea>
					</div>
					<div class="editablebuttons editable-buttons-bottom" style="float: right;margin-right: 10px;">
					<button type="button" onclick="updateMemo(this)" class="btn btn-success editable-submit btn-sm waves-effect waves-light"><i class="mdi mdi-check"></i></button>
					<button type="button" onclick="back(this)" class="btn btn-danger editable-cancel btn-sm waves-effect waves-light"><i class="mdi mdi-close"></i></button>
					</div>
				</div>
			</form>
		</div>
	</c:forEach>
</div>


<script>
function back(backbtn){
	$(backbtn).parents(".mainbox").find("#one").show();
	$(backbtn).parents(".mainbox").find("#updatediv").hide();
}

function updateform(select){
	$(select).parents(".mainbox").find("#one").hide();
	$(select).parents(".mainbox").find("#updatediv").show();
}

function writeMemo(writebtn){
	$("#writeModal").modal("show");
}

function updateMemo(updatedata){
	var memoId=$(updatedata).parents(".mainbox").data("memoid");
 	var memoCntnt=$(updatedata).closest(".mainbox").find(".updatecntnt").find("#updateTextarea").val();
 	
	console.log(memoId);
	console.log(memoCntnt);

	$.ajax({
		url : "/memo/updateMemo",
		data :{
			"memoId" : memoId,
			"memoCntnt" : memoCntnt
		},
		type : "get",
		success : function(data){
			console.log();
			if(data=="success"){
				alert("메모가 수정되었습니다.");
				$(updatedata).parents(".mainbox").find("#one").text(memoCntnt);
				$(updatedata).parents(".mainbox").find("#one").show();
				$(updatedata).parents(".mainbox").find("#updatediv").hide();
			}else{
				alert("메모수정실패");
			}
		},
		error : function(xhr){
			alert("수정과정중 오류발생...")
		},
		dataType : "text"
	});
}

function delcheck(data){
	if (confirm("정말 삭제하시겠습니까??") == true){    //확인
        var form = document.test;
        delMemo(data);
        form.submit();
      }else{   //취소
        return;
    }
}

function delMemo(btn){
	
	console.log($(btn).parents(".mainbox").data("memoid"));
	var memoId=$(btn).parents(".mainbox").data("memoid");

	$.ajax({
		url : "/memo/deleteMemo",
		data :{
			"memoId" : memoId
		},
		type : "get",
		success : function(data){
			console.log();
			
			if(data=="success"){
				alert("선택한 메모가 삭제되었습니다.");
				
				location.href = "/memo/selectMemo";
			}else{
				alert("메모삭제실패");
			}
		},
		error : function(xhr){
			alert("오류...")
		},
		dataType : "text"
	});
}
</script>

<!-- Modal 시작 -->
<div class="modal fade" id="writeModal">
  <div class="modal-dialog">
    <div class="modal-content">
	  <div class="modal-header" style="background:#D9E5FF; ">
		<button type="button" class="btn-close" data-bs-dismiss="modal"
			aria-label="Close"></button>
	 </div>
      <div class="modal-body" style="background:#D9E5FF; ">
			<form:form action="/memo/writeMemo" method="post" modelAttribute="memoVO" id="writeform">
					<h1 onclick="autowrite()" style="text-align: center;color: #6495ED">MEMO
					<img src="/resources/images/memo.png" style="width: 50px; height: 50px; margin-bottom:10px;margin: 10px;"/></h1>  
						
					<div class="form-group" style="width: 96%; margin:auto;margin-bottom:10px; display:block; border: 3px solid #90AFFF;">
						<form:textarea id="memoCntnt" path="memoCntnt" class="form-control" 
						rows="10" name="memoCntnt" style="height:auto;text-align:center;"
				        placeholder="내용입력" required="required"></form:textarea>
					</div>
					<div  class="text-center">
					<button type="submit" id="memowrite" style="margin: 10px;"
					class="btn btn-outline-primary waves-effect waves-light">메모 저장</button>
					<button type="reset" 
					class="btn btn-outline-primary waves-effect waves-light">다시작성</button>
					</div>
			</form:form>      	
      </div>
    </div>
  </div>
</div>
<!-- Modal 끝 -->

<script>
function autowrite(){
	$("#memoCntnt").val("4월 20일에 리허설 진행 후 21일 발표 예정 22일 수료식 ")
}
$(function(){
	$('#writeModal').on('hide.bs.modal', function (e) {
	    $(".modal-backdrop").remove();
	})
})
</script>	
	
