<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <title>워크To게더</title>
    <!-- favicon.ico -->
    <link rel="icon" href="/resources/images/whale.ico">
    <!-- Custom fonts for this template-->
    <link href="/resources/sbadmin2/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <!-- Custom styles for this template-->
    <link href="/resources/sbadmin2/css/sb-admin-2.min.css" rel="stylesheet">
    
    <!-- Bootstrap core JavaScript-->
    <script src="/resources/sbadmin2/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/sbadmin2/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript -->
    <script src="/resources/sbadmin2/vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="/resources/sbadmin2/js/sb-admin-2.js"></script>

    <!-- Page level plugins -->
	<!-- <script src="/resources/sbadmin2/vendor/chart.js/Chart.min.js"></script> -->
	<!-- Page level custom scripts -->
	<!-- <script src="/resources/sbadmin2/js/demo/chart-area-demo.js"></script> -->
	<!-- <script src="/resources/sbadmin2/js/demo/chart-pie-demo.js"></script> -->
</head>

<body id="page-top">
    <!-- Page Wrapper 시작 -->
    <div id="wrapper">
        <!-- Aside(bar) 시작 -->
        <%-- <jsp:include page="../includes/aside.jsp"></jsp:include> --%>
        <!-- Aside(bar) 끝 -->
        <!-- Content Wrapper 시작 -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content 시작 -->
            <div id="content">
                <!-- Header(bar) 시작 -->
                <!-- Header(bar) 끝 -->
                <!-- body 시작 -->
                <div class="container-fluid">
					<tiles:insertAttribute name="body" />
                </div>
                <!-- body 끝-->
            </div>
            <!-- Main Content 끝 -->
            <!-- Footer 시작 -->
            <!-- Footer 끝 -->
        </div>
        <!-- Content Wrapper 끝 -->
    </div>
    <!-- Page Wrapper 끝 -->

    <!-- 모든 페이지에 적용될 스크립트 -->
    <script src="/resources/sbadmin2/js/sb-admin-2.js"></script>
    <script type="text/javascript">
	
	</script>
</body>
</html>