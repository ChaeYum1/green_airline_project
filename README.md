![logo](https://github.com/moon335/tenco_shop_project/assets/124985978/d5eca6a3-8cd6-4ea6-a4a7-5ebc1776fcfe)


<br>
## [👋 프로젝트 소개 README](https://github.com/seoyounglee0105/green_airline_project/wiki)
<br>

## 1️⃣ 프로젝트 구조

```bash
📦src
 ┗ 📂main
   ┣ 📂java
   ┃ ┗ 📂com
   ┃   ┗ 📂green
   ┃     ┗ 📂airline
   ┃       ┃ ┣ 📂config
   ┃       ┃ ┗ 📂controller
   ┃       ┣ 📂dto
   ┃       ┃ ┣ 📂kakao
   ┃       ┃ ┣ 📂nation
   ┃       ┃ ┣ 📂request
   ┃       ┃ ┗ 📂response
   ┃       ┣ 📂enums
   ┃       ┣ 📂handler
   ┃       ┃ ┗ 📂exception
   ┃       ┣ 📂repository
   ┃       ┃ ┣ 📂interfaces
   ┃       ┃ ┗ 📂model
   ┃       ┣ 📂service
   ┃       ┗ 📂utils
   ┣ 📂resources
   ┃ ┣ 📂db
   ┃ ┣ 📂mapper
   ┃ ┗ 📂static
   ┃   ┣ 📂css
   ┃   ┃ ┗ 📂summerNote
   ┃   ┃   ┗ 📂font
   ┃   ┣ 📂images
   ┃   ┃ ┣ 📂airplane
   ┃   ┃ ┣ 📂baggage
   ┃   ┃ ┣ 📂board
   ┃   ┃ ┣ 📂gifticon
   ┃   ┃ ┣ 📂in_flight
   ┃   ┃ ┣ 📂like
   ┃   ┃ ┣ 📂product
   ┃   ┃ ┗ 📂ticket
   ┃   ┗ 📂js
   ┃     ┗ 📂summerNote
   ┃       ┗ 📂lang
   ┗ 📂webapp
     ┗ 📂WEB-INF
       ┗ 📂view
         ┣ 📂baggage
         ┣ 📂board
         ┣ 📂faq
         ┣ 📂in_flight
         ┣ 📂layout
         ┣ 📂manager
         ┣ 📂mileage
         ┣ 📂myPage
         ┣ 📂notice
         ┣ 📂ticket
         ┣ 📂user
         ┗ 📂voc

```

<br>

## 2️⃣ 프로젝트 개요

<br>

* 핵심 기능이 많은 프로젝트를 고민하다 예약, 환불, 외부 API를 활용할 수 있는
* 항공권 예약 사이트 선정
* 현행 시스템(아시아나 항공, 대한 항공 벤치마킹)

# 기능 구분
### Member

* 소셜 로그인 API, 항공권 예매 기능, 결제 및 환불 API
* 기내 서비스 조회 기능, 서비스 신청 기능, 여행일지 조회 기능
* 구글 맵 API, 마일리지 숍 구매 기능, 네이버 이메일 SMTP 프로토콜

### Manager
* 대시보드 조회, 회원관리, 항공권 관리 및 조회, 서비스 신청 관리 및 조회
* 여행일지 관리 및 조회, 마일리지 숍 관리 및 조회, 고객센터 관리 및 조회


<br>

## 3️⃣ ERD & 테이블 명세서
테이블 명세서 : https://docs.google.com/spreadsheets/d/1oaUxJ4CWKrVUvi02h9mYOwBL-raDCLswAQ5Qllws7Xw/edit#gid=0

<br>
<br>

![ERD Model](https://github.com/seoyounglee0105/green_airline_project/assets/124985978/3dc47f53-61da-4115-9644-3d19a8e3f185)


<br>
<br>


## 4️⃣ SiteMap
<br>

<table>
<tr>
 <td>User</td>
 <td>Manager</td>
 </tr>
<tr>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/872e19cf-262f-48aa-bd3a-338e88208be6"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/faa63d99-e44c-49d5-adf1-66d1dff62262"></td>
</tr>
</table>


## 4️⃣ 기능 - 회원

<br>

<table>
<tr>
<td>카카오 소셜 로그인</td>
<td>비밀번호 변경</td>
</tr>
<tr>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/8b4dbb54-cb86-4e52-9b80-9795dc45cfd1/img.gif"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/65af6941-116b-443b-bf6a-022582240feb/img.gif"></td>
</tr>
<tr>
<td>회원 정보 수정</td>
<td>특별 기내식</td>
</tr>
<tr>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/9fa448ae-b9d3-44d2-82e6-e0b535ad7033a/img.gif"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/d075854e-8ebc-46ce-b78a-1fa218e5fd9c/img.gif"></td>
</tr>
<tr>
<td>기내 서비스 조회</td>
<td>특별 기내식 신청</td>
</tr>
<tr>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/79470ee8-9b6d-42e3-877b-5b8e07bd3f84/img.gif"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/897ce8bb-06c2-4429-ad19-eb41716b5cd4/img.gif"></td>
</tr>
<tr>
<td>위탁 수하물 신청</td>
<td>공지사항</td>
</tr>
<tr>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/c07b2977-7795-47e1-b2ba-b796f8d009ef/img.gif"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/14721b13-882e-411b-b08a-00f1e11cbbc6/img.gif"></td>
</tr>
 <tr>
<td>자주 묻는 질문</td>
<td></td>
</tr>
 <tr>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/3caecebf-071d-44c8-b5a2-bec30083b58c/img.gif"></td>
<td><img src=""></td>
 </tr>
<tr>
<td></td>
<td></td>
</tr>
 <tr>
<td><img src=""></td>
<td><img src=""></td>
 </tr>
</table>


## 4️⃣ 기능 - 관리자
<br>

<table>
<tr>
<td>공지사항</td>
<td>자주 묻는 질문</td>
</tr>
<tr>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/7bea7e6a-0fab-4082-b406-446702474c90"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/f8fce7d1-ab33-4d66-b7d1-c4b03c7c94a0"></td>
</tr>
</table>
