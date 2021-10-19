


# MMIS (군 급식 정보 체계)
![Logo](https://github.com/osamhack2021/APP_AI_MMIS_teamMMIS/blob/main/assets/logo_white_background.jpg)


## 프로잭트 소개
 최신화된 기술환경에 맞춰 인트라넷 및 수기 식에 머물러 있는 군 급식 정보 및 식수 인원 파악, 불취식신청 등의 행정 처리를 일반 스마트폰에서 처리할 수 있는 플랫폼이다. 본 플랫폼은 군 급식을 이용하는 사용자를 위한 앱과 이를 관리할 수 있는 관리자 웹, 그리고 각 부대의 알맞은 식단을 구성할 수 있는 AI 모델로 이루어져 있다. 본 플랫폼을 통해 부대별 급식 현황을 지속 모니터링하는 시스템을 구축하고, 급식 관련 의견 게시를 활성화하여 최종적으로 음식물 쓰레기 줄이기, 급식 정보 접근성 향상, 부실급식 문제해결 및 급식 질 개선 등을 목표로 한다. 


## 총 프로젝트 구성
### 사용자 모바일 앱
- 군장병들을 위한 급식 정보 모바일 앱이다. 민간에서 이용되고 있는 고등학교 급식앱 "김급식"을 모티프로 군에 알맞는 급식 정보와 기능들을 제공할 수 있게 제작하였다. 
- 미리 체계상에 저장되어 있는 군번과 비밀번호로 로그인 가능하며, 본인이 갖고 있는 알레르기 정보를 입력하면, 그 성분이 포함된 메뉴에 대한 정보를 앱에서 제공한다. 
- 군장병들은 앱을 활용하여, 각 날의 급식 메뉴, 영양정보, 알레르기 정보 등을 확인할 수 있다. 
- 매 끼니마다 불취식 신청/ 취식 신청을 편리하게 할 수 있도록 UI를 구성하였다. 
- 부대 급식 자랑 색션을 두어, 부대에서 제공하는 급식에 대한 사진을 공유할 수 있다. 
- 급식 관련된 공지사항, 건의사항, 설문조사를 할 수 있게 UI를 구성하였다. 
- 각 끼니별, 메뉴별로 선호도 조사를 할 수 있게 하였다. 

### 관리자 웹
- 부대별 급식 담당자를 위한 관리자 웹이다. 
- 사용자 모바일 앱을 통해 사용자가 입력한 데이터를 토대로, 식수 인원, 메뉴 관련 선호도 등 부대 장병들 의견, 설문조사, 공지사항 게시, 건의사항 답변 등을 할 수 있다. 
- 식단 구성을 도와주는 인공지능을 토대로, 선호도, 영양에 적합한 식단 조합을 구성할 수 있다. 

### 식단 구성을 도와주는 인공지능

1. 새로운 메뉴를 제공해주는 인공지능 
- 체계상의 저장된 메뉴와 고등학교의 메뉴를 인공지능을 통해 비슷한 메뉴끼리 분류를 해서 새로운 메뉴를 추천해 주는 모델입니다. 예들들어 국방부 식단에 계란찜이 좋은 평가를 받았을 때 인공지능에 계란찜과 비슷한 메뉴를 추천해 달라고 하면 계란 후라이나 계란 수란 등의 열량과 메뉴 이름면에서 비슷한 메뉴를 추천해 줍니다.

2. 조합 평가 인공지능
- 새로운 메뉴 조합이 있을 시 그 조합의 종합점수를 산출합니다. 새로운 메뉴나 기존의 메뉴를 다른 조합으로 한 끼니를 만들었을 때 그 한 끼니의 종합 평가를 점수를 산출해 내는 모델입니다. 기존 조합의 평가 점수는 한 끼니의 별점 점수를 활용하고 인공지능 학습을 통해 새로운 조합의 점수가 더 높은 점수가 나오면 그 조합을 추천해 줍니다.

## 서비스 플로우
![myapp flow](https://github.com/osamhack2021/APP_AI_MMIS_teamMMIS/blob/main/assets/myapp_flow.jpg)
![admin flow](https://github.com/osamhack2021/APP_AI_MMIS_teamMMIS/blob/main/assets/admin_flow.jpg)

## 컴퓨터 구성 / 필수 조건 안내 (Prerequisites)
1. ECMAScript 6 지원 브라우저 사용
2. 브라우저 지원 버전:
- Chrome
3. 앱 지원 버전:
- Andriod
- IOS

## 기술 스택 (Technique Used) 
### Artificial Intelligence

<table>
<tbody>
    <tr>
        <td>
            <div align="center"><a href="https://www.python.org" target="_blank"> <img src="https://www.python.org/static/img/python-logo@2x.png" alt="python" height="40"/> </a><br>Python</br></div>
        </td>
        <td>
            <div align="center"><a href="https://www.tensorflow.org/" target="_blank"> <img src="https://www.gstatic.com/devrel-devsite/prod/vfe8af62599ec445552c3fb43608c37ff46463c9fce3b14d8ee63b2e71edddffd/tensorflow/images/lockup.svg?dcb_=0.6050776491075445" alt="tensorflow" height="40"/> </a><br>Tensorflow</br></div>
        </td>
        <td>
            <div align="center"><a href="https://keras.io/" target="_blank"> <img src="https://keras.io/img/logo.png" alt="keras" height="40"/> </a><br>Keras</br></div>
        </td>
    </tr>
</tbody>
</table>

### Web Front-end

<table>
<tbody>
    <tr>
        <td>
            <div align="center"><a href="https://flutter.dev/" target="_blank"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg" alt="flutter" width="40" height="40"/> </a><br>Flutter</br></div>
        </td>
        <td>
            <div align="center"><a href="https://gradle.org/" target="_blank"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/gradle/gradle-plain.svg" alt="gradle" width="40" height="40"/> </a><br>Gradle</br></div>
        </td>
        <td>
            <div align="center"><a href="https://www.w3.org/html/" target="_blank"> <img src="https://devicons.github.io/devicon/devicon.git/icons/html5/html5-original-wordmark.svg" alt="html5" width="40" height="40"/> </a><br>Html5</div>
        </td>
    </tr>
</tbody>
</table>

### Web Back-end

<table>
<tbody>
    <tr>
        <td>
            <div align="center"><a href="https://git-scm.com/" target="_blank"> <img src="https://www.vectorlogo.zone/logos/git-scm/git-scm-icon.svg" alt="git" width="40" height="40"/> </a><br>Git</div>
        </td>
        <td>
            <div align="center"><a href="https://www.mysql.com/" target="_blank"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original-wordmark.svg" alt="mysql" width="40" height="40"/> </a><br>MySQL</br></div>
        </td>
        <td>
            <div align="center"><a href="https://flask.palletsprojects.com/en/2.0.x/" target="_blank"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flask/flask-original.svg" alt="flask" width="40" height="40"/> </a><br>Flask</br></div>
        </td>
    </tr>
</tbody>
</table>


## 설치 안내 (Installation Process)

<p>step1. MMIS 저장소를 클론합니다.</p>

```bash
$ git clone https://github.com/osamhack2021/APP_AI_MMIS_teamMMIS.git
```
<br>
<p>step2. 클론한 폴더로 이동하고 패키지를 설치합니다.</p>


```bash
// 클라이언트 패키지 설치
$ cd /workspaces/APP_AI_MMIS_TEAMMMIS/??
$ yarn install
$ yarn add next

// 서버 패키지 설치
$ cd /workspaces/APP_AI_MMIS_TEAMMMIS/??
$ yarn install
```
<br>


## 프로젝트 사용법 (Getting Started)


## 팀 정보 (Team Information)
- 최윤호 (potatohead12@gmail.com), Github Id: potatohead12
- 문철운 (heiyin315@gmail.com), Github Id: cjfdns007
- 성민 (pho0570@gmail.com), Github Id: mini-777
- 성준혁 (sungjjh9707@gmail.com), Github Id: sungjjss9707
- 최민호 (minhochoi.korea@gmail.com), Github Id: Paspachu
- 홍유찬 (hychan0709@gmail.com), Github Id: onlyshine

## 저작권 및 사용권 정보 (Copyleft / End User License)
 * [MIT](https://github.com/osam2020-WEB/Sample-ProjectName-TeamName/blob/master/license.md)

