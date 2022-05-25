<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html lang="kr">
    <head>
        <meta charset="utf-8" />
        <title>워크To게더</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
        <meta content="Themesdesign" name="author" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="/resources/dist/assets/images/favicon.ico">

        <!-- jquery.vectormap css -->
        <link href="/resources/dist/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />

        <!-- Bootstrap Css -->
        <link href="/resources/dist/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
        <!-- Icons Css -->
        <link href="/resources/dist/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <!-- App Css-->
        <link href="/resources/dist/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />

        <script src="/resources/dist/assets/libs/jquery/jquery.min.js"></script>
		<style>
		
		</style>
    </head>

    <body data-topbar="dark">
    
    <!-- <body data-layout="horizontal" data-topbar="dark"> -->

        <!-- Begin page -->
       <div class="container-fluid">
                        
        	<tiles:insertAttribute name="content" />   
       
       </div>

        <div class="rightbar-overlay"></div>

        <!-- JAVASCRIPT -->

        <script src="/resources/dist/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="/resources/dist/assets/libs/metismenu/metisMenu.min.js"></script>
        <script src="/resources/dist/assets/libs/simplebar/simplebar.min.js"></script>
        <script src="/resources/dist/assets/libs/node-waves/waves.min.js"></script>

        
        <!-- apexcharts -->
<!--         <script src="/resources/dist/assets/libs/apexcharts/apexcharts.min.js"></script> -->

        <!-- jquery.vectormap map -->
        <script src="/resources/dist/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.min.js"></script>
        <script src="/resources/dist/assets/libs/admin-resources/jquery.vectormap/maps/jquery-jvectormap-us-merc-en.js"></script>

<!--         <script src="/resources/dist/assets/js/pages/dashboard.init.js"></script> -->

        <!-- App js -->
        <script src="/resources/dist/assets/js/app.js"></script>
    </body>
</html>



