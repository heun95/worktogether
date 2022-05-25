<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<form class="user" method="post" action="/login">

<div id="back" class="authentication-bg d-flex align-items-center min-vh-100 py-5">
   
		<div class="container">
		
            <div class="row">
                <div class="col-lg-12">
                    <div class="text-center">
                        <a href="index.html" class="d-block auth-logo">
<!--                             <img src="assets/images/logo-dark.png" alt="" height="24" class="logo logo-dark mx-auto"> -->
<!--                             <img src="assets/images/logo-light.png" alt="" height="24" class="logo logo-light mx-auto"> -->
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6 col-xl-5">
                <div class="p-4">
                    <div class="card overflow-hidden mt-2">
                        <div class="auth-logo text-center bg-primary position-relative">
                            <div class="img-overlay"></div>
                            <div class="position-relative pt-4 py-5 mb-1">
                            <img src="/resources/dist/assets/images/logo.png" style="width:30px; height:30px;">
                                <br>
                                <h5 class="text-white">WORK TOGETHER</h5>
                           
                            <p class="text-white-50 mb-0">Sign in to continue to work together.</p>
                            </div>
                        </div>
                        <div class="card-body position-relative">
		       <div class="p-4 mt-n5 card rounded">
				<div class="row">
					<div class="col-sm-12 mb-3">
					   <label for="username" class="form-label">ID</label>
			 	       <input type="text" name="username" value="EMPL00005" class="form-control form-control-user" id="username" />
					</div>
					<div class="col-sm-12 mb-3">
						<label for="password" class="form-label">PASSWORD</label>
				        <input type="password" name="password" value="1234" class="form-control form-control-user" id="password" />
<!-- 				        <input type="password" name="password2" value="1234" class="form-control form-control-user" id="password2" /> -->
					</div>
					&nbsp;&nbsp;
				    <button id="btn" type="submit" class="btn btn-primary btn-user btn-block ">
				        Login
				    </button>
				    &nbsp;
				    <button id="face" type="button" class="btn btn-success btn-user btn-block ri-user-smile-line">
				        Face Id
				    </button>
				    
				</div>   
			    <sec:csrfInput/>
			    <hr />
					
					</div>
			       </div>
			    </div>
				
    <div class="mt-5 text-center">
       
        <p>© <script>document.write(new Date().getFullYear())</script>worktogether.</p>
    	</div>
   	  </div>
     </div>
    </div>
</div>
</div>
</form>
<script>
	$(function(){
		if(${param.success=='true'}){
			console.log("test");
			$("#btn").trigger('click'); 	
		}
		$("#face").on("click", function(){
			window.open("https://027b-1-212-157-146.ngrok.io", "face", "width=500,height=600");
		})
	})
</script>

<style>
.authentication-bg {
    height: 100vh;
    background-size: cover;
    background-position: center;
}

back{
 height: 100vh;
}

.container-fluid{
 padding:0px;
 margin:0px;
}

ri-user-smile-line{
width:10px;
height: 10px;
}
</style>
