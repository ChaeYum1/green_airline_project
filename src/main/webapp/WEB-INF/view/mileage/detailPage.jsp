<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<style>
.tbl_prdinfo {
	border-collapse: collapse;
	border: 1px solid gray;
	font-size: 12pt;;
	font-family: 'Malgun Gothic';
	width: 100%;
}

.tbl_prdinfo .tbl_prdinfo_tit {
	height: 61px;
	text-align: center;
	font-weight: 700;
	font-size: 14pt
}

.tbl_prdinfo .tbl_prdinfo_tit>th {
	background: rgb(217, 217, 217);
}

.tbl_prdinfo td {
	border: 1px solid gray;
	padding: 10px;
	line-height: 1.6em;
}

.tbl_prdinfo .td_sub_tit {
	text-align: center;
	font-weight: 600;
}

#amount {
	font-size: 15px;
	border: none;
	width: 10px;
	margin: 0 5px 0 5px;
	border: none;
}

.btn-light {
	font-weight: bold;
}

#buyButton {
	margin-top: 10px;
	width: 100%;
}

#optionList {
	height: 40px;
	width: 100%;
	margin: 10px 0;
	background-color: rgb(243, 243, 243);
	border: none;
}

.prd_info {
	display: flex;
	margin: 50px 0;
}

.productImg {
	width: 400px;
	height: 400px;
}

img {
	margin-left: 30px;
}

.left--container {
	margin-left: 100px;
}

.small {
	padding: 3px;
	padding-left: 7px;
}

.modal--btn {
	margin-top: 10px;
	width: 100%;
}

.delete--btn {
	margin: 10px 0;
}

.total--mileage {
	margin-right: 360px;
}

#spanPrice {
	font-weight: bold;
	font-size: 25px;
}

.tab_head li {
	width: 24.9%;
	float: left;
	text-align: center;
	background-color: rgb(217, 217, 217);
	margin-right: 1px;
	height: 50px;
	padding-top: 10px;
	height: 50px;
}

.email {
	width: 50%;
	background-color: rgb(243, 243, 243);
	border: 1px solid #ccc;
}

.btn_number_box {
	display: flex;
	justify-content: space-between;
}

.minus, .plus {
	border: 1px solid #ccc;
	font-size: 17px;
	width: 30px;
	height: 30px;
	background-color: white;
	border-radius: 50%;
	padding: 0;
}

.tab_wrap3 {
    position: relative;
}
.tab_wrap3 .tab_content {
    width: 100%;
    padding-top: 45px;
}
.inner{
	margin-top: 30px;
}
.tab_cont{
width: 100%;
}
.tab_head--li{
	display:block;
}
.call--back--div{
	text-align: center;
	margin: 10px;
    border: none;

    
}
.callback{
width: 160px;
	 border: none;
	 background-color: #8ABBE2;
	 border-radius: 5px;
    color: white;
    font-size: 20px;
    margin-right: 20px;
        height: 50px;
}
</style>


<!-- 여기 안에 쓰기 -->
<main>

	<div class="container">
		<div class="prd_detail mar_to50">
			<!-- 상품 정보영역 -->
			<div class="prd_info">
				<img alt="" class="productImg" src="/uploadImage/${shopProduct.productImage}">
				<div class="left--container">
					<h1 class="title">[${shopProduct.brand}] ${shopProduct.name}</h1>
					<hr>
					<%-- <img alt="" class="productImg" src="/uploadImage/${shopProduct.productImage}"> --%>

					<div class="mileage">
						<c:choose>
							<c:when test="${principal.userRole == '관리자'}">
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${principal == null}">
										<p class="desc">
											<a href="/login" class="btn_arrow flow-action-login">로그인</a> 을 하시면 마일리지를 확인하실 수 있습니다.
										</p>
									</c:when>
									<c:otherwise>
										<p>
											현재 마일리지 : <span class="">${mileage.balanceNumber()}</span>
										</p>
										<span class="myMileage" style="display: none">${mileage.balance}</span>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>



					</div>

					<!-- 상품 선택영역 -->
					<form name="frmDefault" id="frmDefault" method="post" action="/product/buyProduct">
						<div class="select_area">
							<select id="optionList" title="상품 선택">
								<option value="">옵션을 선택해주세요.</option>

								<option value="001">[${shopProduct.brand}] ${shopProduct.name} | ${shopProduct.count}개 남음</option>

							</select>


							<div class="selected_prd 001" style="display: none;">
								<div class="tit">
									<p>
										<span class="type">[${shopProduct.brand}] ${shopProduct.name} ㅣ <fmt:formatNumber value="${shopProduct.price}" pattern="#,###" /> 마일
										</span>
									</p>
								</div>
								<div class="quantity">
									<div class="btn_number_box small">
										<div>
											<button type="button" class="btn btn-light minus">-</button>
											<input type="text" name="amount" title="상품 개수" value="1" readonly="readonly" id="amount">
											<button type="button" class="btn btn-light plus">+</button>
										</div>
										<a href="#none" class="btn_delete"><span class="material-symbols-outlined hidden"> close </span></a>
									</div>
								</div>

							</div>
						</div>
						<div class="price">
							<span class="num each_mile" style="display: none">${shopProduct.price}</span>




							<dl class="total_mile">
								<dd>
									<strong class="total--mileage">총 필요 마일리지</strong> <span class="num" id="spanPrice"><fmt:formatNumber value="${shopProduct.price}" pattern="#,###" /> </span> 마일
									<!-- input hidden 으로 변경된 값 넣어서 xml에 보내기  useMileage -> productPrice로 변경-->
									<input type="text" value="${shopProduct.price}" name="productPrice" id="productPrice">

								</dd>
							</dl>

							<div class="btn_area">



								<c:choose>
									<c:when test="${principal != null}">
										<div id="inputEmail">
											<input type="text" name="email" placeholder="이메일을 입력 해주세요" class="email"> <input type="hidden" name="gifticonImageName" value="${shopProduct.gifticonImage}">
										</div>

										<br>
										<c:choose>
											<c:when test="${principal.userRole == '관리자'}">
												<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">수정</button>
											</c:when>
											<c:otherwise>
												<button type="submit" class="buyButton btn btn-light" id="buyButton">구매</button>
												<!-- <button type="submit" class="buyButton btn btn-light" id="buyButton">구매하기 버튼으로 만들꺼임</button> -->
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<a href="/login" class="btn_arrow flow-action-login">로그인 페이지로 이동</a>
									</c:otherwise>
								</c:choose>

							</div>
						</div>
						<input type="hidden" name="productId" value="${shopProduct.id}"> <input type="hidden" name="description" value="[${shopProduct.brand}] ${shopProduct.name}"> <input type="hidden"
							name="hiddenCount" value="${shopProduct.count}">
					</form>
				</div>

				<!-- 상품 선택영역 -->

			</div>
			<!--// 상품 정보영역 -->
			<!-- Button to Open the Modal -->

			<!-- The Modal -->
			<div class="modal" id="myModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">상품 수정</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">
							<form action="/product/update" method="post" enctype="multipart/form-data">
								<input type="text" value="${shopProduct.brand}" name="brand"> <input type="text" value="${shopProduct.name}" name="name"> <input type="text" value="${shopProduct.count}"
									name="count"> <input type="text" value="${shopProduct.price}" name="price"> <input type="file" class="form-control-file border" name="file"> <input type="file"
									class="form-control-file border" name="file2"> <input type="hidden" value="${shopProduct.id}" name="id">
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="submit">수정</button>
							<a href="/product/delete/${shopProduct.id}" class="">제품 삭제</a>
							</form>
						</div>

					</div>
				</div>
			</div>

		</div>
		<!-- 상품정보 탭 -->
		<div class="tab_wrap3">
			<ul class="tab_head t4">
				<li class="on"><a href="#none" class="tab_head--li" onclick="toggleTab(0);"><span>상품정보</span></a></li>
				<li><a href="#none" class="tab_head--li" onclick="toggleTab(1);"><span>사용안내</span></a></li>
				<li><a href="#none" class="tab_head--li" onclick="toggleTab(2);"><span>상품 정보제공 고시</span></a></li>
				<li><a href="#none" class="tab_head--li" onclick="toggleTab(3);"><span>연장/환불 안내</span></a></li>
			</ul>
			<div class="tab_content">
				<div id="tab1" class="tab_cont on">
					<div class="inner">
						<!-- 상품 정보 내용 -->
						<table class="tbl_prdinfo">
							<colgroup>
								<col style="width: 200px;">
								<col>
							</colgroup>
							<thead>
								<tr class="tbl_prdinfo_tit">
									<th colspan="2" class="NamoSE_border_show">상품 상세 정보</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="td_sub_tit">상품정보</td>
									<td>-</td>
								</tr>
								<tr>
									<td class="td_sub_tit">사용방법</td>
									<td><span style="color: red;"> - 교환 유효기간은 발행일로부터 365일입니다. 연장 가능합니다.</span><br></td>
								</tr>
								<tr>
									<td class="td_sub_tit">주의사항</td>
									<td>- 메뉴변경 불가할인, 이벤트 적용 및 포인트 적립 불가일부 백화점 및 특수매장 사용불가</td>
								</tr>
								<tr>
									<td class="td_sub_tit">사용불가매장</td>
									<td>- 서울/경기/인천 : 스타필드고양PK마켓점, 인천공항점, 파주첼시아울렛점, 이대ECC점, 영종대교휴게소점, 덕평자연휴게소점, 일산벨라시타점, 마포일진빌딩점, 도이치오토월드점, CGV고양행신점, CGV부천점, CGV평촌점, CGV평택점<br> - 그외 지역 : 부산센텀점, 천안신세계점, 신세계대구점, 대구이월드점,
										신세계마산점, 대명델피노점, CGV청주율량점, 서천국립생태원점, 상록리조트점, CGV목포평화광장점, CGV포항점, CGV대구스타디움점, CGV광주금남로점, CGV제주점<br> - 특수매장 : 미군부대 입점매장, 전국 이마트24 편의점 입점매장 ▶<a
										href="http://smoothieking.webmaker21.kr/inquiry/couponNotice.php">홈페이지 가기</a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div id="tab2" class="tab_cont">
					<div class="inner">
						<!-- 사용안내 내용 -->
						<table class="tbl_prdinfo">
							<colgroup>
								<col style="width: 200px;">
								<col>
							</colgroup>
							<thead>
								<tr class="tbl_prdinfo_tit">
									<th colspan="2" class="NamoSE_border_show">weekly deals 사용 설명</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="td_sub_tit">사용안내</td>
									<td>- 그린항공 홈페이지 &gt; 그린클럽 &gt; 마일리지 사용몰 &gt; Weekly Deals에서 마일리지 공제<br> - 주문내역을 SMS로 발송 후, 수신 문자 내역을 해당 매장에서 확인 후 사용<br> <br> 문자가 미수신된 경우 아래와 같이 휴대폰 확인 부탁드립니다.<br>
										- 데이터 차단 (wi-fi 사용) 혹은 데이터 제한 요금제 사용 여부 확인 부탁드립니다.<br> - 휴대폰 스팸 설정 여부 확인 부탁드립니다. (통신사에 요청했거나, 단말기내 스팸 문구 설정)<br> - 수신 번호가 15XX, 060, 070으로 시작하는 경우 스팸 차단 가능성이 있습니다.<br> - 그 외
										특정 문구 사용시 단말기내 스팸 보관함으로 필터링 될 수 있습니다.<br> - 전원이 꺼져 있거나, 망 이외의 지역에 있는지 확인 부탁드립니다.<br> - 구형 스마트폰 단말기 및 기타 단말기 오류 등으로 인해 수신을 못할 수 있습니다.<br> - 문자 발송까지 시간이 다소 소요됩니다.<br> 위 사항
										확인하시고 상품 구매 24시간 경과 후에도 문자가 미수신된 경우 고객센터로 연락 주시기 바랍니다. <br> <br> <a href="http://gishow.kr/voc"> ▶ 접속 URL: gishow.kr/voc</a><br> - 간편하게 수신자 휴대폰번호 인증만으로 [쿠폰수신내역 조회 및 MMS 재발송] 이
										가능합니다.
									</td>
								</tr>
								<tr>
									<td class="td_sub_tit">그린클럽 <br> 문의
									</td>
									<td>-&nbsp;고객센터: 1588-8180<br> - 운영시간: 평일 09:00~18:00 (주말/공휴일 휴무)
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div id="tab3" class="tab_cont">
					<div class="inner">
						<!-- 상품 정보제공 고시 내용 -->
						<table class="tbl_prdinfo">
							<colgroup>
								<col style="width: 200px;">
								<col>
							</colgroup>
							<thead>
								<tr class="tbl_prdinfo_tit">
									<th colspan="2" class="NamoSE_border_show">상품 정보제공 고시</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="td_sub_tit">발행자</td>
									<td>㈜케이티알파</td>
								</tr>
								<tr>
									<td class="td_sub_tit">유효기간</td>
									<td>- 공정거래위원회 모바일상품권 신유형 표준약관에 근거합니다.<br> - 90일 또는 365일 (각 상품의 유효기간 다르니 상품설명에서 확인하시길 바랍니다.)<br> - 일부 상품의 경우, 유효기간 제한될 수 있습니다.
									</td>
								</tr>
								<tr>
									<td class="td_sub_tit">이용조건</td>
									<td>- 상품설명에서 기간연장 불가 안내가 명시돼 있는 경우 기간 연장은 불가합니다.<br> - 유효기간 이내에만 연장 가능하며 기존 유효기간에서 3개월씩 최대 5년이내 연장 가능합니다.<br> - 쿠폰 유효기간 만료시 기간연장은 불가하며 환불만 가능합니다.
									</td>
								</tr>
								<tr>
									<td class="td_sub_tit">지급보증</td>
									<td>본 기프티쇼는 지급보증 및 보증보험계약 없이 ㈜케이티알파의 신용으로 발행합니다.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div id="tab4" class="tab_cont">
					<div class="inner">
						<!-- 연장/환불 안내 내용 -->
						<table class="tbl_prdinfo">
							<colgroup>
								<col style="width: 200px;">
								<col>
							</colgroup>
							<thead>
								<tr class="tbl_prdinfo_tit">
									<th colspan="2" class="NamoSE_border_show">연장/환불 정보</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="td_sub_tit" rowspan="3">연장/환불<br> 조건 및 방법
									</td>
									<td>[연장]<br> * 상품정보에서 연장 가능한 상품인지 확인할 수 있습니다.<br> * 유효기간 이내에만 연장 가능하며, 기존 유효기간에서 3개월씩 최대 5년이내 연장 가능합니다.<br> * 쿠폰 유효기간 만료시 기간연장은 불가하며 환불만 가능합니다.<br> * 연장 방법<br> :
										그린항공 홈페이지 &gt; 그린클럽 &gt; 마일리지사용몰 &gt; 마일리지사용몰 구매내역 &gt; 주문상세에서 직접 연장
									</td>
								</tr>
								<tr>
									<td>[환불]<br> * 쿠폰의 유효기간 이내에 사용하지 못하신 경우, 5년 이내에 환불이 가능하며 결제 금액의 100%를 환불해 드립니다.<br> * <span style="text-decoration: underline;">환불 시 유효기간이 만료된 마일리지는 자동 소멸</span> 되오니 주의 부탁
										드립니다.<br> * 환불 방법<br> - 쿠폰 유효기간 이내: 그린항공 홈페이지 &gt; 그린클럽 &gt; 마일리지사용몰 &gt; 마일리지사용몰 구매내역에서 직접 취소<br> - 쿠폰 유효기간 만료 및 연장된 쿠폰: 그린 고객센터 문의(1588-8180)
									</td>
								</tr>
								<tr>
									<td>연장 및 환불 관련 문의는 그린 고객센터로 연락하여 주시기 바랍니다.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="call--back--div">
	<a href="/product/productMain/clasic" class="callback">목록 페이지 이동</a>
	</div>
</main>
<script type="text/javascript">
		/* 옵션 선택하면 구매하기 버튼 숨기기 */
		let buyBtn = $("#buyButton").hide();
		let inputEmail = $("#inputEmail").hide();

/* 제품 옵션, 구매 버튼 보이게 */
	$("#optionList").on("change", function() {
		let selectedOption = $(this).val();
		buyBtn.show();
		inputEmail.show();
		if ($.trim(selectedOption) != "") {
			$(".selected_prd").hide();
			$(".selected_prd." + selectedOption).first().show();
			
		}

		$(this).val("");
	});
	
	
	// 삭제 버튼 클릭 시
	$(".btn_delete").on("click", function() {
		let countInput = $("input[name='amount']");
		let priceElement = $(".price .num.each_mile");
		let totalPriceElement = $(".total_mile .num");
		let initialPrice = parseInt(priceElement.text());
		
		$("#optionList option").eq(0).attr("selected", true);
		buyBtn.hide();
		inputEmail.hide();
		countInput.val(1);
		totalPriceElement.text(initialPrice);
		/* $(this).parent().hide(); */
		$('.selected_prd').hide();
		
	});
	
	
	// 수량 증가 버튼 클릭 시
	document.querySelector('.plus')
			.addEventListener(
					'click',
					function() {
						let minusTarget = document
						.querySelector('.minus');
						
						let target = document
								.querySelector('.plus');
						let countInput = document
								.querySelector('input[name="amount"]');
						let countValue = parseInt(countInput.value); 
						console.log('countValue : '+countValue)
						let priceElement = document
								.querySelector('.price .num.each_mile');
						let totalPriceElement = document
								.querySelector('.total_mile .num');
						let price = parseInt(priceElement.textContent);
						console.log('price : ' + price)
						 let hiddenPrice = document
								.querySelector('input[name="productPrice"]'); 
						let hiddenCount = document
						.querySelector('input[name="hiddenCount"]');
						
						if (countValue < 5) {
							countInput.value = countValue + 1;
							totalPriceElement.textContent = priceToString(price
									* (countValue + 1));
							hiddenPrice.value = price * (countValue + 1);
							hiddenCount.value = ${shopProduct.count} - countInput.value
							
							minusTarget.disabled = false;
						}else if(countValue == 5){
							alert('최대 5개 까지 선택 가능합니다');
						}
						if(${shopProduct.count} == countValue){
							countInput.value = countValue;
							 target.disabled = true;
							alert('최대수량입니다');
							
						}
					});

	// 수량 감소 버튼 클릭 시
	document.querySelector('.minus')
			.addEventListener(
					'click',
					function() {
						let target = document
						.querySelector('.plus');
						let minusTarget = document
						.querySelector('.minus');
						let countInput = document
								.querySelector('input[name="amount"]');
						let countValue = parseInt(countInput.value);
						let priceElement = document
								.querySelector('.price .num.each_mile');
						let totalPriceElement = document
								.querySelector('.total_mile .num');
						let price = parseInt(priceElement.textContent);
						let hiddenPrice = document
								.querySelector('input[name="productPrice"]');
						let hiddenCount = document
						.querySelector('input[name="hiddenCount"]');
						
						if (countValue > 1) {
							countInput.value = countValue - 1;
							totalPriceElement.textContent = priceToString(price
									* (countValue - 1));
							hiddenPrice.value = priceToString(price * (countValue - 1));
							hiddenCount.value = ${shopProduct.count} - countInput.value
							console.log(hiddenPrice.value);							
							target.disabled = false;
						} else if (countValue > 0) {
							minusTarget.disabled = true;
							alert('최소 1개는 선택 해야합니다');
						}
					});
	function priceToString(price1) {
	    return price1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
	
	
	/* 마일리지 비교 */
	document.querySelector('.buyButton')
			.addEventListener('click',
					function() {
				let email = $('.email').val();
				let exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
				let myMileage = document
				.querySelector('.myMileage').innerHTML;
				 let total = $('#productPrice').val();
				 console.log(total);
				 let amount = $('#amount').val(); 
				let hiddenCount = document
				.querySelector('input[name="hiddenCount"]');
				
				if(parseInt(myMileage) < parseInt(total) || email == null|| exptext.test(email)==false){
					console.log(myMileage)
					console.log(total*amount)
					
					alert('마일리지가 부족 합니다');
					 event.preventDefault();
					 location.reload();
				}
				/* if(email == null){
					alert('이메일을 입력 하세요');
					 event.preventDefault();
					 location.reload();
					} */
				
				/* if(exptext.test(email)==false){

				//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			

				alert("이메일형식이 올바르지 않습니다.");
				event.preventDefault();
				 location.reload();

			return false;
				} */
			});
	var tabContents = document.getElementsByClassName("tab_cont");
    for (var i = 1; i < tabContents.length; i++) {
        tabContents[i].style.display = "none";
    }
	 function toggleTab(tabIndex) {
		 	
	        // 모든 탭 내용 숨기기
	        var tabContents = document.getElementsByClassName("tab_cont");
	        for (var i = 0; i < tabContents.length; i++) {
	            tabContents[i].style.display = "none";
	        }
	        // 선택한 탭 내용 보이기
	        var selectedTab = document.getElementById("tab" + (tabIndex + 1));
	        console.log(selectedTab)
	        selectedTab.style.display = "block";
	        
	    }

	 
	
</script>


<input type="hidden" name="menuName" id="menuName" value="마일리지샵">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>