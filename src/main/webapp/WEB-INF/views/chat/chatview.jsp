<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<style>
.chatIcon{
	margin-left: 50px;
}
.card{
/* 	height: 60vh; */
}
#divChatData, .tab-content{
	height: 60vh;
}
.tab-content{
	overflow:auto
}
</style>
<link href="/resources/css/bstreeview.min.css" rel="stylesheet" type="text/css" />
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>

<sec:authentication property="principal.user" var="user"/>

<div class="d-lg-flex">
    <div class="chat-leftsidebar me-lg-4">
        <div class="card">
            <div class="card-body p-4">
                <div class="search-box chat-search-box pb-4">
                    <div class="position-relative">
                        <input type="text" class="form-control" placeholder="Search...">
                        <i class="mdi mdi-magnify search-icon"></i>
                    </div>
                </div>

                <div class="chat-leftsidebar-nav">
                    <ul class="nav nav-pills nav-justified">
                        <li class="nav-item">
                            <a href="#chat" id="tab-chat"  data-bs-toggle="tab" aria-expanded="true"
                                class="nav-link active">
                                <span>채팅방</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#group" id="jojikdo" data-bs-toggle="tab" aria-expanded="false" class="nav-link" data-val="treeAll">
                                <span>조직도</span>
                            </a>
                        </li>
<!--                         <li class="nav-item"> -->
<!--                             <a href="#contact" data-bs-toggle="tab" aria-expanded="false" class="nav-link"> -->
<!--                                 <span>Contacts</span> -->
<!--                             </a> -->
<!--                         </li> -->
                    </ul>
					
					
                    <div class="tab-content py-4"> 
                        <div class="tab-pane show active" id="tab-content">
                            <div id="chat-content">
<!--                                 <h5 class="font-size-16 mb-3">Online</h5> -->
                                <ul class="list-unstyled chat-list" id="chatUi">
                                
                                <!-- bangList 시작 -->
                                <c:forEach var="bang" items="${bangList }">
                                    <li class="active chatbang" data-chatbangid="${bang.chatbangId }">
                                    <a>
	                                    <div class="d-flex">
	                                        <div class="align-self-center me-3">
	                                            <i class="mdi mdi-circle text-success font-size-10"></i>
	                                        </div>
	                                        <c:forEach var="employeeVO" items="${bang.employeeVO }">
												<c:if test="${employeeVO.empId != user.username }">
			                                        <div class="thumb size30 rounded-circle avatar-xs" 
														style="background-image: url('${employeeVO.empPhoto }');  background-size: cover;"></div>
												</c:if>
	                                        </c:forEach>
	                                        <div class="flex-grow-1 overflow-hidden">
	                                            <h6 class="chatMem text-truncate m-2">
												<c:forEach var="employeeVO" items="${bang.employeeVO }">
													<c:if test="${employeeVO.empId != user.username }">
		                                        	${employeeVO.empName }
		                                        	</c:if>
		                                        </c:forEach>
												</h6>
<!-- 	                                            <p class="text-truncate mb-0">Hey! there I'm available  </p> -->
	                                        </div>
	
<!-- 	                                        <div class="font-size-11">05 min</div> -->
		                                    <div>
			                                    <i class="ri-close-line fa-lg chatDel" ></i>
		                                    </div>
	                                    </div>
                                    </a>
                                    </li>
                                </c:forEach>
                                <!-- bangList 끝 -->
                                </ul>
                            </div>
                        </div>
                    </div> 
                    
                </div>
            </div>
        </div>
    </div>

    <div class="w-100 user-chat" >
    <c:if test="${param.chatbangId != null}">
        <div class="card">
            <div class="p-4 border-bottom ">
                <div class="row">
                    <div class="col-md-4 col-9">
                        <h5 class="chatbangMem font-size-15 mb-1 text-truncate"></h5>
                        <p class="text-muted mb-0 text-truncate"><i
                                class="mdi mdi-circle text-success font-size-10 align-middle me-1"></i>
                            Active now</p>
                    </div>
                    <div class="col-md-8 col-3">
                        <ul class="list-inline user-chat-nav text-end mb-0">
                            <li class="list-inline-item d-none d-sm-inline-block">
                                <div class="dropdown">
                                    <button class="btn nav-btn dropdown-toggle" type="button"
                                        data-bs-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                        <i class="mdi mdi-magnify font-size-18"></i>
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-md">
                                        <form class="p-3">
                                            <div class="m-0">
                                                <div class="input-group">
                                                    <input type="text" class="form-control"
                                                        placeholder="Search ..."
                                                        aria-label="Recipient's username">
                                                    <button class="btn btn-primary" type="submit"><i
                                                            class="mdi mdi-magnify"></i></button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </li>
                            <li class="list-inline-item  d-none d-sm-inline-block">
                                <div class="dropdown">
                                    <button class="btn nav-btn dropdown-toggle" type="button"
                                        data-bs-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                        <i class="mdi mdi-cog-outline font-size-18"></i>
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-end">
                                        <a class="dropdown-item" href="#">View Profile</a>
                                        <a class="dropdown-item" href="#">Clear chat</a>
                                        <a class="dropdown-item" href="#">Muted</a>
                                        <a class="dropdown-item" href="#">Delete</a>
                                    </div>
                                </div>
                            </li>

                            <li class="list-inline-item">
                                <div class="dropdown">
                                    <button class="btn nav-btn dropdown-toggle" type="button"
                                        data-bs-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                        <i class="mdi mdi-dots-horizontal font-size-18"></i>
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-end">
                                        <a class="dropdown-item" href="#">Action</a>
                                        <a class="dropdown-item" href="#">Another action</a>
                                        <a class="dropdown-item" href="#">Something else</a>
                                    </div>
                                </div>
                            </li>

                        </ul>
                    </div>
                </div>
            </div>


            <div class="px-lg-2" >
                <div id="divChatData" class="chat-conversation p-3 my-4" data-simplebar>
                    <!-- 메신저 내용 -->
                    <ul class="list-unstyled chat-list" id="chatData">
                    	<!-- 저장된 내용 가져오기 -->

                    	<c:forEach var="msg" items="${chatMsgList }">
                    	<c:if test="${msg.chatWrtr == user.username}">
	                    	<li class="right">
                    	</c:if>
                    	<c:if test="${msg.chatWrtr != user.username}">
	                    	<li class="left">
                    	</c:if>
                    	
		                        <div class="conversation-list">
		                            <div class="d-flex">
		                                <div class="flex-grow-1 arrow-right me-3">
		                                    <div class="ctext-wrap">
		                                        <div class="conversation-name">${msg.wrtrName }</div>
		                                        <p>
		                                            ${msg.chatCntnt }
		                                        </p>
		                                        <fmt:formatDate value="${msg.chatWrtDt }" var="chatWrtDt" pattern="hh:mm"/>
		                                        <p class="chat-time mb-0"><i
		                                                class="mdi mdi-clock-outline align-middle me-1"></i>
		                                            ${chatWrtDt }</p>
		                                    </div>
		                                </div>
										<div class="thumb size40 rounded-circle avatar-xs" 
											style="background-image: url('${msg.wrtrPhoto }');  background-size: cover;"></div>
		                            </div>
		                        </div>
		                    </li>
                    	</c:forEach>
                    </ul>
                </div>
                
                <div class="p-3 chat-input-section">
                    <div class="row">
                        <div class="col">
                            <div class="position-relative">
                                <input type="text"  id="message" class="form-control chat-input"
                                   onkeypress="if(event.keyCode==13){webSocket.sendChat();}" placeholder="Enter Message...">
                                <div class="chat-input-links">
                                    <ul class="list-inline mb-0">
                                        <li class="list-inline-item" id="tooltip-containeremoji">
                                            <a href="#" data-bs-container="#tooltip-containeremoji"
                                                data-bs-toggle="tooltip" data-bs-placement="top"
                                                title="Emoji">
                                                <i class="mdi mdi-emoticon-happy-outline"></i>
                                            </a>
                                        </li>

                                        <li class="list-inline-item" id="tooltip-containerimages">
                                            <a href="#" data-bs-container="#tooltip-containerimages"
                                                data-bs-toggle="tooltip" data-bs-placement="top"
                                                title="Images">
                                                <i class="mdi mdi-file-image-outline"></i>
                                            </a>
                                        </li>
                                        <li class="list-inline-item" id="tooltip-containerfiles">
                                            <a href="#" data-bs-container="#tooltip-containerfiles"
                                                data-bs-toggle="tooltip" data-bs-placement="top"
                                                title="Add Files">
                                                <i class="mdi mdi-file-document-outline"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="button" id="btnSend" onclick="webSocket.sendChat()"
                                class="btn btn-primary btn-rounded chat-send w-md waves-effect waves-light">
                                <span class="d-none d-sm-inline-block me-2">Send</span>
                                <i class="mdi mdi-send"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    </div>
</div>
<script type="text/javascript">
	
	
	var token = $("#token").val();
	var header = $("#header").val();
	var userId = $("#userId").val();
	
	function insertBang(empId){
// 		console.log(empId);
		var empList = [];
		empList.push(empId);
		empList.push(userId);
// 		console.log(empList);
		var data = {};
		data.empList = empList;
// 		console.log(JSON.stringify(data));
// 		return false;
		$.ajax({
	        url: "/chat/insertBang",
	        type: "POST",
	        contentType: "application/json; charset=utf-8",
            data: JSON.stringify(data),
            success: function (res) {
                console.log(res["chatbangId"]);
				var chatbangId = res["chatbangId"];
				location.href='/chat.do?chatbangId='+chatbangId;
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
	
	function scroll(){
		if($('#divChatData .simplebar-content-wrapper').length > 0){
			$('#divChatData .simplebar-content-wrapper')[0].scrollTo(0,$('#divChatData .simplebar-content-wrapper')[0].scrollHeight);
			
		}
	}
	
	var webSocket = {
			init: function(param) {
				this._url = param.url;
				this._initSocket();
			},
			sendChat: function() {
				this._sendMessage('${param.chatbangId}', 'CMD_MSG_SEND', $('#message').val());
				$('#message').val('');
				scroll()
			},
			sendEnter: function() {
				this._sendMessage('${param.chatbangId}', 'CMD_ENTER', $('#message').val());
				$('#message').val('');
				scroll()
			},
			receiveMessage: function(msgData) {
				var msg ='';
				
				// 정의된 CMD 코드에 따라서 분기 처리
				if(msgData.cmd == 'CMD_MSG_SEND') {
					if(msgData.userId == userId){
						msg +='<li class="right">';
					}else{
						msg +='<li class="left">';
					}
					msg +='<div class="conversation-list">';
					msg +='<div class="d-flex">';
					msg +='<div class="flex-grow-1 arrow-right me-3">';
					msg +='<div class="ctext-wrap">';
					msg +='<div class="conversation-name">'+msgData.userNm+'</div>';
					msg +='<p>';
					msg += msgData.msg;
					msg +='</p>';
					msg +='<p class="chat-time mb-0"><iclass="mdi mdi-clock-outline align-middle me-1"></i>';
					msg += msgData.date ;
					msg +='</p></div>';
					msg +='</div>';
					msg +=' <div class="thumb size40 rounded-circle avatar-xs"'; 
					msg +=' style="background-image: url('+msgData.userPhoto+');  background-size: cover;"></div>';
				
					msg +='</div>';
					msg +='</div>';
					msg +='</li>';
					$('#chatData').append(msg);
					scroll();
				}
				// 입장
				else if(msgData.cmd == 'CMD_ENTER') {
				}
				// 퇴장
				else if(msgData.cmd == 'CMD_EXIT') {					
				}
			},
			closeMessage: function(str) {
				$('#chatData').append('<div>' + '연결 끊김 : ' + str + '</div>');
			},
			disconnect: function() {
				this._socket.close();
			},
			_initSocket: function() {
				this._socket = new SockJS(this._url);
				this._socket.onopen = function(evt) {
					webSocket.sendEnter();
				};
				this._socket.onmessage = function(evt) {
					webSocket.receiveMessage(JSON.parse(evt.data));
				};
				this._socket.onclose = function(evt) {
					webSocket.closeMessage(JSON.parse(evt.data));
				}
			},
			_sendMessage: function(chatbangId, cmd, msg) {
				var msgData = {
						chatbangId : chatbangId,
						cmd : cmd,
						msg : msg
				};
				var jsonData = JSON.stringify(msgData);
				this._socket.send(jsonData);
			}
	};
		
	$(function() {
		var token = $("#token").val();
		var header = $("#header").val();
		
		webSocket.init({ url: '<c:url value="/chat" />' });
		
		scroll();
		
		var chatbangId = "${param.chatbangId}";
		if(chatbangId != ""){
// 			console.log($(".chatbang[data-chatbangid="+chatbangId+"]").find(".chatMem").text());
			$(".chatbangMem").text($(".chatbang[data-chatbangid="+chatbangId+"]").find(".chatMem").text());
		}

		
		$("#btnclose").on("click", function(){
			location.href='/login';
		});
		
		// 채팅방 클릭시 채팅방 입장
		$(".chatbang").on("click", function(){
			var chatbangId = $(this).data("chatbangid");
			location.href='/chat.do?chatbangId='+chatbangId;
		});
		
		// 채팅방 나가기 클릭시 채팅방 삭제
		$(".chatDel").on("click", function(){
			var conf = confirm("채팅을 지우시겠습니까?")
			
			if(conf){
				var chatbangId = $(this).parents(".chatbang").data("chatbangid");
				event.stopPropagation();
				console.log(chatbangId);
				$.ajax({
	                url: "/chat/bangDelete",
	                type: "POST",
	                data: {
	                    'chatbangId': chatbangId
	                },
	                success: function (res) {
	                    console.log(res)
	                    console.log($(".chatbang[data-chatbangid="+chatbangId+"]"))
						$(".chatbang[data-chatbangid="+chatbangId+"]").remove();;
	
	                },
	                error: function (xhr) {
	                    alert(xhr.status)
	
	                },
					beforeSend: function (xhr) {
		                xhr.setRequestHeader(header, token)
					},
	                dataType: "json"
				})
			}else{
				return false;
			}
			
		});
		
		
		// 
		$("#tab-chat").on("click",function(){
			$("#chat-content").show();
			$("#jojikdo-content").remove();
		})
		
		// 조직도의 채팅아이콘 클릭시
		$(document).on("click", ".chatIcon", function(){
			var empId = $(this).siblings($("#empId")).val();

			$.ajax({
                url: "/chat/bangCheck",
                type: "GET",
                data: {
                    'empId': empId
                },
                success: function (res) {
//                     console.log(res)
                    if(res == ""){
//                     	console.log("test")
                    	insertBang(empId);
                    	
                    }else{
                    	// 챗 탭 클릭
                    	$("#tab-chat").trigger("click");
                    	// 해당 방 클릭
                    	$(".chatbang[data-chatbangid="+res+"]").trigger("click");
                    }

                },
                error: function (xhr) {
                    alert(xhr.status)

                },
                dataType: "text"
			})
			
		})
			
		// 조직도
		$("#jojikdo").on("click",function(){
			var v_treeBtnValue = $(this).data("val");
			$("#chat-content").hide();
			
			if($("#jojikdo-content").length > 0){
				return;
			}
			
			$.ajax({
				url: "/common/treeList",
				type: "POST",
				contentType : "application/json; charset=utf-8",
				data: JSON.stringify({
					"treeSelect" : v_treeBtnValue
				}),
				success: function(res) {
// 					console.log(res);
					$("#treeContainer").css("display","block");
					var v_result = '<div id="jojikdo-content">';
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
										v_result += ' 		<input type="hidden" id="empId" name"empId value="'+v2.empId+'"> ';
										v_result += ' 		<span class="empName">'+v2.empName+'</span>('+v2.cmmnGroupName+')<i class="state-icon fa fa-comment chatIcon"></i> ';
									}
									v_result += ' 	</div>';
								})
								v_result += ' 	</div>';
							})
							v_result += '	</div>';
						}
					})
					v_result += '	</div>';
					$("#tab-content").append(v_result);
					
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
	});
</script>
