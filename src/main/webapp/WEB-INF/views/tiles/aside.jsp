<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Francois+One&display=swap" rel="stylesheet">

<style>

</style>

<!-- Sidebar -->
<div class="vertical-menu">

	<!-- LOGO -->
	<div class="navbar-brand-box">
		<a href="/" class="logo logo-dark"> <span class="logo-sm">
				<img src="/resources/dist/assets/images/logo.png" alt="" height="22">&ensp;
				<span style="display:inline-block;position:relative;top:5px;">Work Togther</span>
		</span> <span class="logo-lg"> <img
				src="/resources/dist/assets/images/logo.png" alt="" height="22">
		</span>
		</a>
		<a href="/" class="logo logo-light">
	        <span class="logo-sm">
	            <img src="/resources/dist/assets/images/mainlogo.png" alt="" height="25">
	        </span>
	        <span class="logo-lg">
	            <img src="/resources/dist/assets/images/mainlogo.png" alt="" height="25">
	        </span>
        </a>
	</div>

	<!-- 	<button type="button" -->
	<!-- 		class="btn btn-sm px-3 font-size-16 header-item waves-effect vertical-menu-btn"> -->
	<!-- 		<i class="fa fa-fw fa-bars"></i> -->
	<!-- 	</button> -->

	<div data-simplebar class="sidebar-menu-scroll">

		<!--- Sidemenu -->
		<div id="sidebar-menu">
			<!-- Left Menu Start -->
			<ul class="metismenu list-unstyled" id="side-menu">
				<li><a href="javascript: void(0);" class="waves-effect"
					onclick="f_autho()"> <i class="ri-file-list-line"></i> <span>전자결재</span>
				</a>
					<ul class="sub-menu" aria-expanded="true">
						<li><a href="/autho/main" class="">메인페이지</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/autho/create" class="">작성하기</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/autho/tempDoc" class="">임시 보관함</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/autho/receiveDoc" class="">받은 결재함</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/autho/sendDoc" class="">보낸 결재함</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/autho/setting" class="">전자결재 설정</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
					</ul></li>


				<li><a href="/project" class="waves-effect"> <i
						class="ri-shopping-bag-line"></i> <span>프로젝트</span>
				</a></li>


				<li><a href="javascript: void(0);" onclick="f_record()"
					class="waves-effect"> <i class="ri-user-2-line"></i> <span>근태관리</span>
				</a>
					<ul class="sub-menu" aria-expanded="true">
<!-- 						<li><a href="/attendance/recordMain" class="">출근/퇴근하기</a> -->
<!-- 							<ul class="sub-menu" aria-expanded="true"> -->
<!-- 							</ul></li> -->

						<li><a href="/attendance/state" class="">근태현황</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>

						<li><a href="/attendance/apply" class="">신청현황</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
					</ul></li>
					
				<!-- 인사팀으로 로그인했을때 -->
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li><a href="/human/list" class="waves-effect"> <i
							class="ri-red-packet-line"></i> <span>인사관리</span>
					</a></li>
				</sec:authorize>
				
				<li><a href="javascript: void(0);" class=" waves-effect"> <i
						class=" ri-vidicon-line"></i> <span>회의</span>
				</a>
					<ul class="sub-menu" aria-expanded="true">
						<li><a href="/meeting/schedule" class="">회의일정</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/meeting/ingConference" class="">진행중 회의</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/meeting/endConference" class="">종료된 회의</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/meeting/room" class="">회의실 현황</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>

						<li><a href="/meeting/videoConference" class="">화상 회의</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
					</ul></li>


				<li><a href="/schedule/main" class=" waves-effect"> <i
						class="fas fa-calendar-alt"></i> <span>일정</span>
				</a>
					<ul class="sub-menu" aria-expanded="true">

					</ul></li>

				<li><a href="javascript: void(0);" class="waves-effect"
					onclick="f_mail()"> <i class="ri-mail-line"></i> <span>메일</span>
				</a>
					<ul class="sub-menu" aria-expanded="true">
						<li><a href="/email/mainPage" class="">Main Page</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/email/sendMail" class="">메일작성</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/email/reMailBox" class="">받은 메일함</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/email/sendMailBox" class="">보낸 메일함</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/email/unsentMailBox" class="">임시 보관함</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
						<li><a href="/email/trashMailBox" class="">휴지통</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
					</ul></li>


				<li><a href="/chat" class=" waves-effect"> <i
						class="ri-message-3-line"></i> <span>메신저</span>
				</a>
					<ul class="sub-menu" aria-expanded="true">

					</ul></li>

				<li><a href="javascript: void(0);" class=" waves-effect"> <i
						class="ri-question-answer-line"></i> <span>커뮤니티</span>
				</a>
					<ul class="sub-menu" aria-expanded="true">
						<li><a href="/community/list" class="">자유게시판</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>

						<li><a href="/community/list2" class="">익명게시판</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
					</ul></li>

				<li><a href="javascript: void(0);" class=" waves-effect"> <i
						class="fas fa-bullhorn"></i> <span>공지사항</span>
				</a>
					<ul class="sub-menu" aria-expanded="true">
						<li><a href="/notice/list" class="">공지사항</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>

						<li><a href="/qna/list" class="">Q&A</a>
							<ul class="sub-menu" aria-expanded="true">
							</ul></li>
					</ul></li>

			</ul>
		</div>
		<!-- Sidebar -->
	</div>
</div>

<!-- End of Sidebar -->

<script type="text/javascript">
	function f_autho() {
		location.href = "/autho/main";
	}
	function f_mail() {
		location.href = "/email/mainPage";
	}
// 	function f_record() {
// 		location.href = "/attendance/recordMain";
// 	}
</script>
