<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.45vh{
	height: 45vh;
}
</style>
<h1 class="h3 mb-2 text-gray-800" style="color: #6c6ff5">
<img src="/resources/images/home.png" style=" width: 45px; height: 45px; margin-bottom: 10px; margin-right: 10px;"/>Main Page</h1>
<div class="row" >
    <div class="card-header py-1">
        <h6 class="m-0 font-weight-bold text-primary" >
     	   최근 메일이 4개씩 보여지며 + 버튼을 통해 각 메일함으로 이동 할 수 있습니다.</h6>
    </div>
<div class="col-lg-6">
    <div class="card "  >
        <div class="card-body" style="height: 38vh"> 
       		<c:set var="row" value="Nocheck"/> 
       		<c:set var="row1" value="recheck"/>
            <h4 class="m-0 font-weight-bold text-primary">받은메일
            <img src="/resources/images/email.png" style="width: 35px; height: 35px;margin-left: 10px;margin-bottom: 3px;"/>
            <input type="button" value="+" style="float: right;margin-right: 10px;background: none;"
            onclick="location.href='/email/reMailBox'" />
            </h4> 
            <p>총 <font style="color: red; font-size: 1.2em;">${recheck}</font>개가 보관되어 있습니다.
           	(<img src="/resources/images/notice.png"style="width: 25px; height: 25px;margin-left: 3px;margin-bottom: 5px;"/>
           	미확인 <font style="color: red; font-size: 1.2em;">${Nocheck}</font>개 )</p>
            <div class="table-responsive"  style="overflow-y: scroll;height:25vh;">
                <table class="table table-primary mb-0" style="text-align: center;">
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>발신자 ID &nbsp;| 이 름</th>
                            <th style="text-align: left;">제목</th>
                            <th>수신일자</th>
                        </tr>
                    </thead>
					<c:forEach var="row" items="${relist}" varStatus="status">
                    <tbody>
                        <tr >
                            <th>${status.count}</th>
                            <td>${row.emailSendId}&nbsp;| ${row.empName }</td>
                            <td style="text-align: left; width:40%;">${row.emailTitle}</td>
                            <td><fmt:formatDate value="${row.emailWrtDt}"  pattern="yyyy-MM-dd  hh:mm"/></td>
                        </tr>
                    </tbody>
					</c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="col-lg-6" >
    <div class="card " >
        <div class="card-body" style="height: 38vh">
        	<c:set var="row" value="sendcheck" />
            <h4 class="m-0 font-weight-bold text-primary" >보낸 메일
            <img src="/resources/images/email.png" style="width: 35px; height: 35px;margin-left: 10px;margin-bottom: 5px;"/>
            <input type="button" value="+" style="float: right; margin-right: 10px;background: none;"
            onclick="location.href='/email/sendMailBox'"/>
            </h4>
            <p>총 <font style="color: red; font-size: 1.2em;">${sendcheck}</font>개가 보관되어 있습니다. </p>
                <div class="table-responsive" style="overflow-y: scroll;height:25vh;">
                    <table class="table table-info mb-0" style="text-align: center;">
                        <thead>
                            <tr>
                                <th>NO</th>
                                <th>수신자 ID &nbsp;| 이 름</th>
                                <th style="text-align: left;">제목</th>
                                <th>작성일자</th>
                            </tr>
                        </thead>
					<c:forEach var="row" items="${sendlist}" varStatus="status">
                    <tbody>
                        <tr>
                            <th>${status.count }</th>
                            <td>${row.emailRcvId }&nbsp;| ${row.empName }</td>
                            <td style="text-align: left; width:40%;">${row.emailTitle }</td>
                            <td><fmt:formatDate value="${row.emailWrtDt}"  pattern="yyyy-MM-dd  hh:mm"/></td>
                        </tr>
                    </tbody>
					</c:forEach>
                    </table>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- 임시보관함, 휴지통 시작  -->
<div class="row" >
<div class="col-lg-6">
    <div class="card " >
        <div class="card-body" style="height: 38vh">
        	<c:set var="row" value="unsentcheck"/>
            <h4 class="m-0 font-weight-bold text-primary">임시보관
            <img src="/resources/images/email.png" style="width: 35px; height: 35px;margin-left: 10px;margin-bottom: 5px;"/>
            <input type="button" value="+" style="float: right;margin-right: 10px;background: none;"
            onclick="location.href='/email/unsentMailBox'"/>
            </h4>   
            <p>총 <font style="color: red; font-size: 1.2em;">${unsentcheck}</font>개가 보관되어 있습니다.</p>
            
            <div class="table-responsive"  style="overflow-y: scroll;height:25vh;">
                <table class="table table-primary mb-0" style="text-align: center;">
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>수신자 ID &nbsp;| 이 름</th>
                            <th style="text-align: left; width:40%;">제목</th>
                            <th>작성일자</th>
                        </tr>
                    </thead>
					<c:forEach var="row" items="${unsentlist}" varStatus="status">
                    <tbody>
                        <tr>
                            <th>${status.count }</th>
                            <td>${row.emailRcvId }&nbsp;| ${row.empName }</td>
                            <td style="text-align: left;">${row.emailTitle }</td>
                            <td><fmt:formatDate value="${row.emailWrtDt}"  pattern="yyyy-MM-dd  hh:mm"/></td>
                            
                        </tr>
                    </tbody>
					</c:forEach>
                </table>
            </div>

        </div>
    </div>
</div>

<div class="col-lg-6" >
    <div class="card ">
        <div class="card-body " style="height: 38vh" >
        	<c:set var="row" value="trashcheck"/>
            <h4 class="m-0 font-weight-bold text-primary">휴지통
            <img src="/resources/images/trashbox.png" style="width: 35px; height: 35px;margin-left: 10px;margin-bottom: 5px;"/>
            <input type="button" value="+" style="float: right; margin-right: 10px;background: none;"
            onclick="location.href='/email/trashMailBox'"/>
            </h4>
            <p>총 <font style="color: red; font-size: 1.2em;">${trashcheck}</font>개가 보관되어 있습니다.</p>
           
                <div class="table-responsive" style="overflow-y: scroll;height:25vh;">
                    <table class="table table-info mb-0" style="text-align: center;">
                        <thead>
                            <tr>
                                <th>NO</th>
                                <th>수신자 ID &nbsp;| 이 름</th>
                                <th style="text-align: left;">제목</th>
                                <th>삭제일자</th>
                            </tr>
                        </thead>
 					<c:forEach var="row" items="${trashlist}" varStatus="status">
                    <tbody>
                        <tr>
                            <th>${status.count }</th>
                            <td>${row.emailRcvId }&nbsp;| ${row.empName }</td>
                            <td style="text-align: left; width:40%;">${row.emailTitle }</td>
                            <td><fmt:formatDate value="${row.emailDelDt}"  pattern="yyyy-MM-dd  hh:mm"/></td>
                        </tr>
                    </tbody>
					</c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
