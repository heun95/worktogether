<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--    <title>메일 전송하는 페이지 </title> -->
<!--    <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
   <!-- Bootstrap -->
<!--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"> -->
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
<!--    <script src="https://code.jquery.com/jquery.min.js"></script> -->
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

   <!-- 플러그인 참조 -->
   <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.js"></script>
   <script src="http://cdn.ckeditor.com/4.4.7/standard/ckeditor.js"></script>
   <script>
   $(function(){
	   CKEDITOR.replace('tttttest',{height : '120px'}
			  );
	   
   });
   
   $(function(){
	  $("#unsent").on("click",function(){
		  alert("임시저장의 경우 파일은 저장되지 않습니다.")
	  })
   });

   </script>
   <style type="text/css">
	@media ( min-width : 1300px) {
	.container {
		padding-top: 30px;
		padding-bottom: 40px;
		padding-left: 100px;
	}
	#form {
		width: 1300px;
	}
	
	.cke_contents{
		height: 380px;
	}
	
/* 	   .cke_contents{ */
/* 	min-height:350px; */
/* } */
}

</style>

    <!-- 내용영역 시작 -->
	<div  style="margin-bottom:10px; " >
	<h2 id="autowrite" onclick="autowrite()" class="m-0 font-weight-bold text-primary">메일작성하기
    <img src="/resources/images/mailwrite.png" style="width: 45px; height: 45px; margin-left: 10px;"/></h2>
	</div>
    <div class="container" style="float: left;" >
      <form:form class="form-horizontal" modelAttribute="emailVO" method="post" action="/email/sendMail" id="form" enctype="multipart/form-data">
        <fieldset>

          <div class="form-group">
            <label class="control-label col-sm-2" for="sender" >발신자아이디</label>
            <div class="col-sm-10" style="margin-bottom: 10px;">
              <form:input type="text" name="emailSendId" path="emailSendId" class="form-control"  />
            </div>
          </div>

          <div class="form-group" >
            <label class="control-label col-sm-2" for="receiver" style="width: 200px;">수신자아이디 <font color='red' style="font-size: 0.5em;">** 입력 필수</font></label>
            <div class="col-sm-10" style="margin-bottom: 10px;">
              <form:input id="emailRcvId" type="text" name="emailRcvId" path="emailRcvId" class="form-control" placeholder="받는 분의 아이디를 입력하세요." required="required"/>
            </div>
          </div>

          <div class="form-group" >
            <label class="control-label col-sm-2" for="subject" style="width: 200px;">메일 제목 <font color='red' style="font-size: 0.5em;">** 입력 필수</font></label>
            <div class="col-sm-10" style="margin-bottom: 10px;">
              <form:input id="emailTitle" type="text" name="emailTitle" path="emailTitle" class="form-control" placeholder="이메일의 제목을 입력하세요." required="required"/>
            </div>
          </div>

		  <div class="form-group">
	        	<input type="file" id="input_files" name="uploadFile" 
	        	class="btn btn-outline-primary waves-effect waves-light" style="margin-bottom: 20px;"/>
	        	<font color='blue'style="font-size: 0.5em;">&nbsp;&nbsp;** 선택 사항</font>
          </div>
          	
          <div class="form-group" >
            <label class="control-label col-sm-2" for="content">내용입력 <font color='red' style="font-size: 0.5em;">** 입력 필수</font></label>
            <div class="col-sm-10" >
              <form:textarea name="emailCntnt" path="emailCntnt" id="tttttest" ></form:textarea>
            </div>
          </div>

        </fieldset>
          <!-- 버튼 영역 -->
          <div class="form-actions text-right" style="margin-top: 20px;">
            <form:input type="submit"  path="emailTypeId" class="btn btn-outline-primary waves-effect waves-light" value="메일전송" />
            <form:input id="unsent" type="submit"  path="emailTypeId" class="btn btn-outline-primary waves-effect waves-light" value="임시저장" />
            <input type="reset" class="btn btn-outline-primary waves-effect waves-light" value="다시작성" />
          </div>
      </form:form>
    </div>

 <script>
 function autowrite(){
   $("#emailRcvId").val("EMPL00003");
   $("#emailTitle").val("서류확인 부탁드립니다. ");   
   CKEDITOR.instances.tttttest.setData("<span>저번주에 요청하셨던 서류입니다. 확인 후 답장부탁드립니다.</span>");
 }
 </script>  
