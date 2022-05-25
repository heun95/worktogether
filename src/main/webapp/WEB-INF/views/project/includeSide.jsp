<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="mb-4">
	<button type="button" id="insertWorkBtn"
		class="btn btn-dark btn-rounded waves-effect waves-light">
		업무추가</button>
</div>    
<div class=" mb-4">
    <label class="form-label h6">업무구분</label>

    <div class="form-check mb-2">
        <input type="radio" id="radio3" name="division" class="form-check-input sideBox" value="all"  checked="">
        <label class="form-check-label" for="radio3">전체업무</label>
    </div>
    
    <div class="form-check mb-2">
        <input type="radio" id="radio1" name="division" class="form-check-input sideBox" value="get">
        <label class="form-check-label" for="radio1">요청업무</label>
    </div>

    <div class="form-check mb-2">
        <input type="radio" id="radio2" name="division" class="form-check-input sideBox" value="give">
        <label class="form-check-label" for="radio2">요청한 업무</label>
    </div>

</div>

<div class="mb-3 my-4">
	<label class="form-label h6">상태</label>
	
    <div class="form-check mb-2">
        <input type="checkbox" name="wkState" class="form-check-input input-mini sideBox" id="request" value="요청" checked>
        <label class="form-check-label" for="request">요청<span id="requestSpan"></span></label>
    </div>

    <div class="form-check mb-2">
        <input type="checkbox" name="wkState"  class="form-check-input input-mini sideBox" id="progress" value="진행" checked>
        <label class="form-check-label" for="progress">진행<span id="progressSpan"></span></label>
    </div>

    <div class="form-check mb-2">
        <input type="checkbox" name="wkState"  class="form-check-input input-mini sideBox" id="issue" value="이슈" checked>
        <label class="form-check-label" for="issue">이슈<span id="issueSpan"></span></label>
    </div>

    <div class="form-check mb-2">
        <input type="checkbox" name="wkState" class="form-check-input input-mini sideBox" id="complete" value="완료" checked>
        <label class="form-check-label" for="complete">완료<span id="completeSpan"></span></label>
    </div>
</div>

<div class="mb-3 my-4">
	<label class="form-label h6">우선순위</label>

    <div class="form-check mb-2">
        <input type="checkbox" name="priority" class="form-check-input input-mini sideBox" id="low" value="낮음" checked>
        <label class="form-check-label" for="low">낮음</label>
    </div>

    <div class="form-check mb-2">
        <input type="checkbox" name="priority" class="form-check-input input-mini sideBox" id="nomal" value="보통" checked>
        <label class="form-check-label" for="nomal">보통</label>
    </div>
	
    <div class="form-check mb-2">
        <input type="checkbox" name="priority" class="form-check-input input-mini sideBox" id="important" value="높음" checked>
        <label class="form-check-label" for="important">높음</label>
    </div>
	
    <div class="form-check mb-2">
        <input type="checkbox" name="priority" class="form-check-input input-mini sideBox" id="emergency" value="긴급" checked>
        <label class="form-check-label" for="emergency">긴급</label>
    </div>
</div>
