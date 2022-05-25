<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="d-lg-flex">
    <div class="chat-leftsidebar me-lg-4">
        <div class="card">
            <div class="p-4">
                <div class="search-box chat-search-box pb-4">
                    <div class="position-relative">
                        <input type="text" class="form-control" placeholder="Search...">
                        <i class="mdi mdi-magnify search-icon"></i>
                    </div>
                </div>

                <div class="chat-leftsidebar-nav">
                    <ul class="nav nav-pills nav-justified">
                        <li class="nav-item">
                            <a href="#chat" data-bs-toggle="tab" aria-expanded="true"
                                class="nav-link active">
                                <span>Chat</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#group" data-bs-toggle="tab" aria-expanded="false" class="nav-link">
                                <span>Group</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#contact" data-bs-toggle="tab" aria-expanded="false" class="nav-link">
                                <span>Contacts</span>
                            </a>
                        </li>
                    </ul>
					
					
                    <div class="tab-content py-4"> 
                        <div class="tab-pane show active">
                            <div>
                                <h5 class="font-size-16 mb-3">Online</h5>
                                <ul class="list-unstyled chat-list">
                                
                                <!-- bangList 시작 -->
                                <c:forEach var="bang" items="${bangList }">
                                    <li class="active chatbang" data-chatbangid="${bang.chatbangId }">
	                                    <div class="d-flex">
	                                        <div class="align-self-center me-3">
	                                            <i class="mdi mdi-circle text-success font-size-10"></i>
	                                        </div>
	                                        <c:forEach var="employeeVO" items="${bang.employeeVO }">
	                                        <div class="align-self-center me-3">
	                                            <img src="${employeeVO.empPhoto }"
	                                                class="rounded-circle avatar-xs" alt="">
	                                        </div>
	                                        </c:forEach>
	
	                                        <div class="flex-grow-1 overflow-hidden">
	                                            <h5 class="text-truncate font-size-14 mb-1">Danish Zehen
	                                            </h5>
	                                            <p class="text-truncate mb-0">Hey! there I'm available
	                                            </p>
	                                        </div>
	                                        <div class="font-size-11">05 min</div>
	                                    </div>
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
</div>

<!-- DataTable -->
<script src="/resources/dist/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="/resources/dist/assets/js/pages/customdatatables.init.js"></script>

<!-- Buttons -->
<script src="/resources/dist/assets/libs/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-buttons-bs4/js/buttons.bootstrap4.min.js"></script>
<script src="/resources/dist/assets/libs/jszip/jszip.min.js"></script>
<script src="/resources/dist/assets/libs/pdfmake/build/pdfmake.min.js"></script>
<script src="/resources/dist/assets/libs/pdfmake/build/vfs_fonts.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-buttons/js/buttons.html5.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-buttons/js/buttons.print.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-buttons/js/buttons.colVis.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-select/js/dataTables.select.min.js"></script>

<!-- Responsive -->
<script src="/resources/dist/assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
<script src="/resources/dist/assets/libs/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>