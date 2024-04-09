<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<jsp:include page="/layout/link.jsp" />
<jsp:include page="/layout/mainLink.jsp" />
</head>
<body>
	<style>
/* 커스텀 오버레이 */
.my-place {
	padding: 12px 24px;
	background-color: cornflowerblue;
	border-radius: 10px;
	color: white;
	font-size: 20px;
}

.container {
	width: 800px;
	margin: 100px auto;
}

input {
	width: calc(100% - 10px);
	height: 40px;
	font-size: 20px;
}

.input-box {
	display: flex;
	flex-direction: column;
	row-gap: 5px;
	margin: 40px auto;
}

.btn {
	border: none;
	background-color: cornflowerblue;
	color: white;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
}
</style>
</head>
<h1 class="title">오시는 길</h1>

<div class="container">
	<div class="input-box">
		<input type="text" name="name" id="name" placeholder="위치 이름">
		<input type="text" name="address" id="address" placeholder="주소 입력">
		<button id="btn" class="btn">검색</button>
		<button id="my-location" class="btn">현재 위치</button>
	</div>
	<div id="map" style="width: 800px; height: 500px; margin: 0 auto;"></div>
	<p id="position"></p>
</div>

<!-- ✅ 라이브러리 포함 : &libraries=services -->
<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=abaf959f0308dd8f0e1b462dc9e26639&libraries=services"></script>
<script>
	// 위도 : 37.49100953576117, 경도 : 126.72047625631083
	let lat = 37.49100953576117 // 위도
	let lon = 126.72047625631083 // 경도

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		// 에러
		center : new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
		level : 1, // 지도의 확대 레벨
		mapTypeId : kakao.maps.MapTypeId.ROADMAP
	// 지도종류
	};

	// 지도를 생성한다 
	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 지도에 마커를 생성하고 표시한다
	var marker = new kakao.maps.Marker({
		position : new kakao.maps.LatLng(lat, lon), // 마커의 좌표
		map : map
	// 마커를 표시할 지도 객체
	});

	// 지도 클릭 이벤트를 등록한다 (좌클릭 : click, 우클릭 : rightclick, 더블클릭 : dblclick)
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		console.log('지도에서 클릭한 위치의 좌표는 ' + mouseEvent.latLng.toString()
				+ ' 입니다.');

		let position = document.getElementById('position')
		// 위도,경도 정보
		let latlng = mouseEvent.latLng
		let lat = latlng.getLat() // 위도
		let lng = latlng.getLng() // 경도
		//let msg = `위도 : ${lat}, 경도 : ${lng}`

		//position.innerHTML = msg
	});

	// 커스텀 오버레이를 생성하고 지도에 표시한다
	// 에러
	var customOverlay = new kakao.maps.CustomOverlay({
		map : map,
		content : '<div class="my-place">더조은학교</div>',
		position : new kakao.maps.LatLng(lat, lon), // 커스텀 오버레이를 표시할 좌표
		xAnchor : 0.5, // 컨텐츠의 x 위치
		yAnchor : 0
	// 컨텐츠의 y 위치
	});
</script>
<script>
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	function searchAddress(name, address) {

		// 주소로 좌표를 검색합니다
		geocoder
				.addressSearch(
						address,
						function(result, status) {

							// 정상적으로 검색이 완료됐으면 
							if (status === kakao.maps.services.Status.OK) {

								var coords = new kakao.maps.LatLng(result[0].y,
										result[0].x);

								// 결과값으로 받은 위치를 마커로 표시합니다
								var marker = new kakao.maps.Marker({
									map : map,
									position : coords
								});

								// 인포윈도우로 장소에 대한 설명을 표시합니다
/* 								var infowindow = new kakao.maps.InfoWindow(
										{
											content : `<div style="width:150px;text-align:center;padding:6px 0;"
													   >${address}</div>`
										});
								infowindow.open(map, marker); */

								// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
								map.setCenter(coords);
							}
						});

	}
</script>
<script>
	document.addEventListener("DOMContentLoaded", function() {

		const $address = document.getElementById('address')

		$address.addEventListener('keyup', function(event) {
			const $name = document.getElementById('name')
			const name = $name.value
			const value = $address.value
			if (event.keyCode == '13') {
				searchAddress(name, value)
			}
		})

		const $btn = document.getElementById('btn')

		$btn.addEventListener('click', function() {
			const $name = document.getElementById('name')
			const $address = document.getElementById('address')
			const name = $name.value
			const value = $address.value
			searchAddress(name, value)
		})

		// 현재 위치 버튼 클릭
		let myLocation = document.getElementById('my-location')

		myLocation.addEventListener('click',
				function() {
					getLocation()
					var latlng = new kakao.maps.LatLng(positionObj.lat,
							positionObj.lng);
					map.setCenter(latlng)
				})

	})

	// navigator 객체로, 위도/경도 값 가져오기
	function getLocation() {
		if (navigator.geolocation) {
			// getCurrentPosition(콜백함수)
			navigator.geolocation.getCurrentPosition(showPosition);
		} else {
			document.getElementById("location").innerHTML = "Geolocation is not supported by this browser.";
		}
	}

	var positionObj = {
		lat : lat, // 위도
		lng : lon, // 경도
	}
	function showPosition(position) {
		var latitude = position.coords.latitude; // 위도
		var longitude = position.coords.longitude; // 경도
		// alert(`위도 : ${latitude}, 경도 : ${longitude}`)
		positionObj.lat = latitude
		positionObj.lng = longitude
	}
</script>

</body>
</html>









