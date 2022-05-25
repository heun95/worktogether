<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<script src="/resources/js/html2canvas.js"></script>


<!-- 전체 부분-->
<button onclick=bodyShot()>bodyShot</button>
<!-- 일부분 부분-->
<button onclick=partShot()>partShot</button>

<div class="container" id='container'>
	jdsakfjdsalkfjdsalkfjdsalkfjsdalkfjsladk
</div>
<!-- 결과화면을 그려줄 canvas -->
<canvas id="canvas" width="900" height="600"
	style="border: 1px solid #d3d3d3;"></canvas>

<script type="text/javascript">
function bodyShot() {
	html2canvas(document.body)
	.then(
		function (canvas) {
			drawImg(canvas.toDataURL('image/png'));
			saveAs(canvas.toDataURL(), 'file-name.png');
			}).catch(function (err) {
			console.log(err);
			});
}

function partShot() {
		html2canvas(document.getElementById("container"))
		.then(
			function (canvas) {
				drawImg(canvas.toDataURL('image/jpeg'));
				saveAs(canvas.toDataURL(), 'file-name.jpg');
				}).catch(function (err) {
				console.log(err);
				});
	}

function drawImg(imgData) {
	console.log(imgData);
	return new Promise(function reslove() {
	//내가 결과 값을 그릴 canvas 부분 설정
	var canvas = document.getElementById('canvas');
	var ctx = canvas.getContext('2d');
	ctx.clearRect(0, 0, canvas.width, canvas.height);
	var imageObj = new Image();
	imageObj.onload = function () {
		ctx.drawImage(imageObj, 10, 10);
		};
		imageObj.src = imgData;
		}, function reject() { });
	}
	
function saveAs(uri, filename) {
	var link = document.createElement('a');
	if (typeof link.download === 'string') {
		link.href = uri;
		link.download = filename;
		document.body.appendChild(link);
		link.click();
		document.body.removeChild(link);
	} else {
		window.open(uri);
	}
}
</script>
