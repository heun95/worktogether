<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="kr">

    <head>
         
        <meta charset="utf-8" />
        <title>워크To게더</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
        <meta content="Themesdesign" name="author" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="/resources/dist/assets/images/logo.png">
		
        <!-- jquery.vectormap css -->
		<link href="/resources/dist/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />

        <!-- Bootstrap Css -->
        <link href="/resources/dist/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
        
        <!-- Icons Css -->
        <link href="/resources/dist/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        
        <!-- App Css-->
        <link href="/resources/dist/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
        
		<!-- 조직도 CSS -->
		<link href="/resources/css/bstreeview.min.css" rel="stylesheet" type="text/css" />
				
		<!-- 스윗알러트 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        
        <!-- 제이쿼리 -->
        <script src="/resources/dist/assets/libs/jquery/jquery.min.js"></script>
		
				

    </head>

    <body data-topbar="dark" >
    
    <sec:authentication property="principal.user" var="user"/>
<%-- 	<input type="hidden" id="user" value="${user}"> --%>
<%-- 	<input type="hidden" id="userNm" value="${user.empName}"> --%>
	<c:forEach var="employeeAuthList" items="${user.employeeAuthList}" varStatus="status"> 
		<input type="hidden" class="userRole" value="${user.employeeAuthList[status.index].auth}">
	</c:forEach>
<%-- 	<input type="hidden" class="userRole" value="${user.employeeAuthList[0].auth}"> --%>
	<input type="hidden" id="userId" value="${user.username }">
	<input type="hidden" id="userPhoto" value="${user.atchPath }">
	<input type="hidden" id="token" value="${_csrf.token }">
	<input type="hidden" id="header" value="${_csrf.headerName }">
	
    <!-- <body data-layout="horizontal" data-topbar="dark"> -->

        <!-- Begin page -->
        <div id="layout-wrapper">
            <tiles:insertAttribute name="header" />
            

            <!-- ========== Left Sidebar Start ========== -->
            <tiles:insertAttribute name="aside" />
            <!-- Left Sidebar End -->

            

            <!-- ============================================================== -->
            <!-- Start right Content here -->
            <!-- ============================================================== -->
            <div class="main-content">

                <div class="page-content">
                    <div class="container-fluid">
                        
                     <tiles:insertAttribute name="body" />    
                       
                    </div><!-- end row -->
                    
                </div>
                <!-- End Page-content -->
               
                <tiles:insertAttribute name="footer" />  
                
                    
                
            </div>
            <!-- end main content-->

        </div>
        <!-- END layout-wrapper -->

        <!-- Right Sidebar -->
        <div class="right-bar">
            <div data-simplebar class="h-100">
                <div class="rightbar-title d-flex align-items-center px-3 py-4">
            
                    <h5 class="m-0 me-2">Settings</h5>

                    <a href="javascript:void(0);" class="right-bar-toggle ms-auto">
                        <i class="mdi mdi-close noti-icon"></i>
                    </a>
                </div>

                <!-- Settings -->
                <hr class="mt-0" />
                <h6 class="text-center mb-0">Choose Layouts</h6>

                <div class="p-4">
                    <div class="mb-2">
                        <img src="/resources/dist/assets/images/layouts/layout-1.jpg" class="img-fluid img-thumbnail" alt="layout-1">
                    </div>

                    <div class="form-check form-switch mb-3">
                        <input class="form-check-input theme-choice" type="checkbox" id="light-mode-switch" checked>
                        <label class="form-check-label" for="light-mode-switch">Light Mode</label>
                    </div>
    
                    <div class="mb-2">
                        <img src="/resources/dist/assets/images/layouts/layout-2.jpg" class="img-fluid img-thumbnail" alt="layout-2">
                    </div>
                    <div class="form-check form-switch mb-3">
                        <input class="form-check-input theme-choice" type="checkbox" id="dark-mode-switch" data-bsStyle="/resources/dist/assets/css/bootstrap-dark.min.css" data-appStyle="/resources/dist/assets/css/app-dark.min.css">
                        <label class="form-check-label" for="dark-mode-switch">Dark Mode</label>
                    </div>
    
                    <div class="mb-2">
                        <img src="/resources/dist/assets/images/layouts/layout-3.jpg" class="img-fluid img-thumbnail" alt="layout-3">
                    </div>
                    <div class="form-check form-switch mb-5">
                        <input class="form-check-input theme-choice" type="checkbox" id="rtl-mode-switch" data-appStyle="/resources/dist/assets/css/app-rtl.min.css">
                        <label class="form-check-label" for="rtl-mode-switch">RTL Mode</label>
                    </div>

            
                </div>

            </div> <!-- end slimscroll-menu-->
        </div>
        <!-- /Right-bar -->
		
        <!-- Right bar overlay-->
        <div class="rightbar-overlay"></div>
        
       	<!-- 조직도 적용될 스크립트 -->
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

        <!-- JAVASCRIPT -->
        <script src="/resources/dist/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="/resources/dist/assets/libs/metismenu/metisMenu.min.js"></script>
        <script src="/resources/dist/assets/libs/simplebar/simplebar.min.js"></script>
        <script src="/resources/dist/assets/libs/node-waves/waves.min.js"></script>

        <!-- jquery.vectormap map -->
        <script src="/resources/dist/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.min.js"></script>
        <script src="/resources/dist/assets/libs/admin-resources/jquery.vectormap/maps/jquery-jvectormap-us-merc-en.js"></script>
        
        <!-- App js -->
        <script src="/resources/dist/assets/js/app.js"></script>
        
	
    </body>
</html>
