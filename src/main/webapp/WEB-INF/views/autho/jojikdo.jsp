<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!-- 커스텀 CSS -->
<link href="/resources/css/bstreeview.min.css" rel="stylesheet" type="text/css" />

  <div class="container">
    <div class="content">
        <div class="col-md-4 pt-5">
			<div id="tree" class="bstreeview"></div>
		</div>
      </div>
    </div>
  <hr>

<script>
$(function(){
	function workList(){
		$.ajax({
			url: "/autho/treeList",
			type: "GET",
			contentType : "application/json; charset=utf-8",
// 			data: JSON.stringify({
//				'empId' : "EMPL00004"
// 			}),
			success: function(res) {
				console.log(res);
				var v_result = "";
				var v_index = 0;
				$.each(res,function(i,v){
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
							v_result += ' 		'+v2.empName+'('+v2.cmmnGroupName+')';
							v_result += ' 	</div>';
						})
						v_result += ' 	</div>';
					})
					v_result += '	</div>';
				})
				$("#tree").html(v_result);
			},
			error: function(xhr) {
				alert(xhr.status)
			},
			dataType: "json"
		})
	}
	workList();
})
</script>

<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<script>
	try {
	  fetch(new Request("https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js", { method: 'HEAD', mode: 'no-cors' })).then(function(response) {
	    return true;
	  }).catch(function(e) {
	    var carbonScript = document.createElement("script");
	    carbonScript.src = "//cdn.carbonads.com/carbon.js?serve=CK7DKKQU&placement=wwwjqueryscriptnet";
	    carbonScript.id = "_carbonads_js";
	    document.getElementById("carbon-block").appendChild(carbonScript);
	  });
	} catch (error) {
	  console.log(error);
	}
</script>

<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-36251023-1']);
  _gaq.push(['_setDomainName', 'jqueryscript.net']);
  _gaq.push(['_trackPageview']);
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>

<ins class="adsbygoogle adsbygoogle-noablate" data-adsbygoogle-status="done" style="display: none !important;" data-ad-status="unfilled"><ins id="aswift_1_expand" tabindex="0" title="Advertisement" aria-label="Advertisement" style="border: none; height: 0px; width: 0px; margin: 0px; padding: 0px; position: relative; visibility: visible; background-color: transparent; display: inline-table;"><ins id="aswift_1_anchor" style="border: none; height: 0px; width: 0px; margin: 0px; padding: 0px; position: relative; visibility: visible; background-color: transparent; display: block;"><iframe id="aswift_1" name="aswift_1" style="left:0;position:absolute;top:0;border:0;width:undefinedpx;height:undefinedpx" sandbox="allow-forms allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts allow-top-navigation-by-user-activation" frameborder="0" marginwidth="0" marginheight="0" vspace="0" hspace="0" allowtransparency="true" scrolling="no" src="https://googleads.g.doubleclick.net/pagead/ads?client=ca-pub-2783044520727903&amp;output=html&amp;adk=1812271804&amp;adf=3025194257&amp;lmt=1589762290&amp;plat=9%3A32776%2C16%3A8388608%2C17%3A32%2C24%3A32%2C25%3A32%2C30%3A1081344%2C32%3A32&amp;plas=370x726_l%7C390x726_r&amp;format=0x0&amp;url=file%3A%2F%2F%2FC%3A%2FUsers%2FPC-14%2FDownloads%2Ftree-list-bootstrap%2Ftree-list-bootstrap%2Findex.html&amp;ea=0&amp;flash=0&amp;pra=7&amp;wgl=1&amp;uach=WyJXaW5kb3dzIiwiMTAuMC4wIiwieDg2IiwiIiwiOTkuMC40ODQ0Ljc0IixbXSxudWxsLG51bGwsIjY0IixbWyIgTm90IEE7QnJhbmQiLCI5OS4wLjAuMCJdLFsiQ2hyb21pdW0iLCI5OS4wLjQ4NDQuNzQiXSxbIkdvb2dsZSBDaHJvbWUiLCI5OS4wLjQ4NDQuNzQiXV1d&amp;dt=1647825103076&amp;bpp=1&amp;bdt=185&amp;idt=1&amp;shv=r20220316&amp;mjsv=m202203140101&amp;ptt=9&amp;saldr=aa&amp;abxe=1&amp;prev_slotnames=2780937993&amp;nras=1&amp;correlator=6472200818856&amp;frm=20&amp;pv=1&amp;ga_vid=2011620991.1647825103&amp;ga_sid=1647825103&amp;ga_hid=1001212733&amp;ga_fc=0&amp;u_tz=540&amp;u_his=1&amp;u_h=1080&amp;u_w=1920&amp;u_ah=1040&amp;u_aw=1920&amp;u_cd=24&amp;u_sd=1&amp;dmc=8&amp;adx=-12245933&amp;ady=-12245933&amp;biw=1920&amp;bih=880&amp;scr_x=0&amp;scr_y=0&amp;eid=44759876%2C44759927%2C44759842%2C42531397%2C44750774%2C31065636%2C44760495%2C31065656%2C21067496&amp;oid=2&amp;pvsid=4234336018201234&amp;pem=191&amp;tmod=977900211&amp;uas=0&amp;nvt=1&amp;eae=2&amp;fc=1920&amp;brdim=0%2C0%2C0%2C0%2C1920%2C0%2C1920%2C1040%2C1920%2C880&amp;vis=1&amp;rsz=%7C%7Cs%7C&amp;abl=NS&amp;fu=32768&amp;bc=31&amp;ifi=2&amp;uci=a!2&amp;fsb=1&amp;dtd=11" data-google-container-id="a!2" data-load-complete="true"></iframe></ins></ins></ins><iframe src="https://www.google.com/recaptcha/api2/aframe" width="0" height="0" style="display: none;"></iframe><iframe id="google_esf" name="google_esf" src="https://googleads.g.doubleclick.net/pagead/html/r20220316/r20190131/zrt_lookup.html" style="display: none;"></iframe>