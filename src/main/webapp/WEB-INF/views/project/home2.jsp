<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
.pageTitle {position: fixed; left: 0; top: 0; width: 100%; height: 52px; line-height: 52px; color: #fff; text-align: center; background: #111;}
#container {padding: 52px 3% 0;}
#container .block {padding: 20px; min-height: 500px;}
#container .block p {line-height: 22px; color: #fff; font-size: 16px; font-weight: 600;}
#container .block:nth-child(2n+1) {background: #999;}
#container .block:nth-child(2n) {background: #222;}
</style>
<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
			
				<%@ include file="includeTab.jsp" %>
				
				<div id="container">
				    <div class="block">
				        <p>
				            Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatem mollitia accusamus sequi ipsa, rerum nam laboriosam, ipsam aperiam deleniti beatae expedita id quisquam veritatis corporis, voluptates ducimus molestiae eum adipisci.
				        </p>
				    </div>
				    <div class="block">
				        <p>
				            Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatem mollitia accusamus sequi ipsa, rerum nam laboriosam, ipsam aperiam deleniti beatae expedita id quisquam veritatis corporis, voluptates ducimus molestiae eum adipisci.
				        </p>
				    </div>
				    <!-- 반복 -->
				</div>
				
				
			</div>
		</div>
	</div>
</div>
<script>
var count = 0;
//스크롤 바닥 감지
window.onscroll = function(e) {
    //추가되는 임시 콘텐츠
    //window height + window scrollY 값이 document height보다 클 경우,
    if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
    	//실행할 로직 (콘텐츠 추가)
        count++;
        var addContent = '<div class="block"><p>'+ count +'번째로 추가된 콘텐츠</p></div>';
        //article에 추가되는 콘텐츠를 append
        $('#container').append(addContent);
    }
};
</script>