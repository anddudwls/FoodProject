<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 지도 --%>

<div id="map_wrap">
	<div id="map" style="width:100%;height:64vh;"></div>

	<div id="list_wrap">
		<ul id="restaurantList"></ul>
		<div id="pagination"></div>
	</div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=456480c2802de2d30304037c5341696f&libraries=services"></script>
<script>

// 목록 창 숨기기
hideList();


// 지도 생성
var mapContainer = document.getElementById("map");
var mapOption = {
	center: new kakao.maps.LatLng(37.50062, 127.03644),
	level: 8
};

var map = new kakao.maps.Map(mapContainer, mapOption);


// 마커 배열
var markers = [];


// 인포윈도우 생성
var infowindow = new kakao.maps.InfoWindow({
	removable: true,
	zIndex: 1
});


// 장소 검색 객체 생성
var places = new kakao.maps.services.Places();


// 장소 검색 함수
function restaurantSearch() {
	var mapKeyword = document.getElementById("mapKeyword").value;
	
	if(!mapKeyword.replace(/^\s+|\s+$/g, '')) {
		alert("검색어를 입력해주세요.");
		return false;
	}
	
	mapKeyword = mapKeyword + "맛집";
	
	places.keywordSearch(mapKeyword, restaurantSearchCB);
}


// 검색 완료 시 호출되는 콜백함수
function restaurantSearchCB(data, status, pagination) {
	if (status === kakao.maps.services.Status.OK) {
		// 목록 창 보여주기
		showList();
		
		// 검색 결과 보여주기
		displayRestaurant(data);
		
		// 페이지 번호 보여주기
		displayPagination(pagination);
		
	} else if(status === kakao.maps.services.Status.ZERO_RESULT) {
        alert("검색 결과가 없습니다.");
        return;
	}
}


// 검색 결과 보여주는 함수
function displayRestaurant(place) {
	var listEl = document.getElementById("restaurantList");
	var listWrap = document.getElementById('list_wrap');
	var bounds = new kakao.maps.LatLngBounds();
	var fragment = document.createDocumentFragment();
	
	removeElement(listEl);
	
	// 지도의 마커 제거
	removeMarker();
	
	// 검색 결과 생성
	for(var i = 0; i < place.length; i++) {
		var position = new kakao.maps.LatLng(place[i].y, place[i].x);
		var marker = addMarker(position, i);
		var itemEl = getListItem(place[i], i);
		
		bounds.extend(position);
		
		// 마커와 목록에 인포윈도우 이벤트
		infowindowEvent(marker, itemEl, place[i]);
		
		fragment.appendChild(itemEl);
	}
	
	// 검색 결과 목록에 추가
	listEl.appendChild(fragment);
	
	// 스크롤 맨 위로
	listWrap.scrollTop = 0;
	
	// 검색 장소 기준으로 지도 범위 재설정
	map.setBounds(bounds);
}


// 지도에 마커 생성하는 함수
function addMarker(position, idx) {
	// 마커 이미지 설정
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png";
	var imageSize = new kakao.maps.Size(36, 37);
	var imageOption = {
		spriteSize : new kakao.maps.Size(36, 691),
		spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10),
		offset: new kakao.maps.Point(13, 37)
	};
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	
	// 마커 설정
	var marker = new kakao.maps.Marker({
		position: position,
		image: markerImage
	});
	
	// 지도에 마커 생성
	marker.setMap(map);
	
	// 배열에 마커 추가
	markers.push(marker);
	
	return marker;
}


// 지도의 마커 제거하는 함수
function removeMarker() {
	for(var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	markers = [];
}


// 검색 결과를 엘리먼트로 반환하는 함수
function getListItem(place, idx) {
	var element = document.createElement("li");
	var itemStr = "<span class='markerbg marker_" + (idx + 1) + "'></span>" +
		"<div class='info'>" +
		"<span class='placeName'>" + place.place_name + "</span>";
		
	if(place.road_address_name) {
		itemStr += "<span>" + place.road_address_name + "</span>" +
			"<span>" + place.address_name + "</span>";
	} else {
		itemStr += "<span>" + place.address_name + "</span>";
	}
	
	itemStr += "<span class='tel'>Tel : " + place.phone + "</span>" +
		"</div>";
	
	element.innerHTML = itemStr;
	element.className = "listItem";
	
	return element;
}


// 페이지 번호 표시하는 함수
function displayPagination(pagination) {
	var paginationEl = document.getElementById("pagination");
	var fragment = document.createDocumentFragment();
	var i;
	
	// 기존의 페이지 번호 삭제
	removeElement(paginationEl);
	
	for(i = 1; i <= pagination.last; i++) {
		var element = document.createElement("a");
		element.href = "#";
		element.innerHTML = i;
		
		if(i === pagination.current) {
			element.className = "on";
		} else {
			element.onclick = (function(i) {
				return function() {
					pagination.gotoPage(i);
				}
			})(i);
		}
		
		fragment.appendChild(element);
	}
	
	paginationEl.appendChild(fragment);
}


// 엘리먼트 제거하는 함수
function removeElement(element) {
	while(element.hasChildNodes()) {
		element.removeChild(element.lastChild);
	}
}


// 인포윈도우 이벤트 함수
function infowindowEvent(marker, itemEl, place) {
	kakao.maps.event.addListener(marker, "click", function() {
		displayInfowindow(marker, place);
	});
	
	itemEl.onmouseover = function() {
		displayInfowindow(marker, place);
	}
	
	itemEl.onmouseout = function() {
		infowindow.close();
	}
}


// 인포윈도우 생성하는 함수
function displayInfowindow(marker, place) {
	var info = "<div style='padding: 5px; font-size: 14px;'><div>" + place.place_name + "</div>" +
		"<a href='https://map.kakao.com/link/map/" + place.place_name + ", " + place.y + ", " + place.x + "' target='_blank' style='color: blue'>길찾기</a></div>";
	
	infowindow.setContent(info);
	infowindow.open(map, marker);
}


// 목록 창 숨기기
function hideList() {
	var list = document.getElementById("list_wrap");
	
	list.style = "display: none"
}


// 목록 창 보여주기
function showList() {
	var list = document.getElementById("list_wrap");
	
	list.style = "";
}

</script>