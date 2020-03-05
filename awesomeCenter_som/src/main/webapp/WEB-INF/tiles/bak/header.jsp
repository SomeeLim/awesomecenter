<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/header.css" />
<script type="text/javascript">
$(document).ready(function(){
	
	/* 주메뉴 Hover */
	$("#gnb > ul > li").hover(function(){
		$('.depth2').slideDown(0);
		$(this).find('ul').first().addClass('on');
		$('#myheader').addClass('bodyDim');
		$(this).find('ul').first().css('padding-top','22px');
		$("#header").addClass('overlay');
		
	},function(){
		$('.depth2').slideUp(0);
		$(this).find('ul').first().removeClass('on');
		$('#myheader').removeClass('bodyDim');
		$(this).find('ul').first().css('padding-top','25px');
		$("#header").removeClass('overlay');
	});
	
	/* 로그인 버튼 Hover */
	$(".utilityMenu > ul > li.login").hover(function(){
		$(".utilityMenu .loginMenu").css('display','block');
	},function(){
		$(".utilityMenu .loginMenu").css('display','none');
	});
	
	
	/* 검색버튼 이벤트 */
	$(".utilityMenu a.search").click(function(){
		$(".utilityMenu .topSearchArea").addClass('open');
	});
	
	$(".utilityMenu .topSearchArea").hover(function(){
		
	},function(){
		$(".utilityMenu .topSearchArea").removeClass('open');
	});
	
	
});
</script>

<div id="header">
     <!-- headerArea : s -->
    <div class="headerArea" id="headerArea">
        <h1 class="logo"><a class="hm_a" href="<%=ctxPath%>/main.to"><span class="blind">으뜸문화센터</span></a></h1>
        <!-- gnb : s -->
        <div id="gnb">
            <h2 class="blind">주메뉴</h2>
            <ul>
                <li><a class="hm_a" href="#">수강신청</a>
                    <ul class="depth2">
                        <li class="mainMenu"><a class="hm_a" href="#">강좌검색</a></li>
                        <li class="mainMenu"><a class="hm_a" href="#">추천강좌</a></li>
                        <li class="mainMenu"><a class="hm_a" href="#">인기강좌</a></li>
                        <li class="mainMenu"><a class="hm_a" href="#">강좌스케줄</a></li>
                        <li class="mainMenu"><a class="hm_a" href="#">온라인 신청 가이드</a></li>
                    </ul>
                    
                </li>
                <li><a class="hm_a" href="#">이용안내</a>
                    <ul class="depth2">
                        <li class="mainMenu"><a class="hm_a" href="#">센터찾기</a></li>
                        <li class="mainMenu"><a class="hm_a" href="#">Q&A</a></li>
                        <li class="mainMenu"><a class="hm_a" href="#">1:1 채팅</a></li>
                        <li class="mainMenu"><a class="hm_a" href="#">E-카탈로그</a></li>
                    </ul>
                </li>
                <li><a class="hm_a" href="#">커뮤니티</a>
                    <ul class="depth2">
                        <li class="mainMenu"><a class="hm_a" href="/awesomecenter/boardmenu.to">공지사항</a></li>
                        <li class="mainMenu"><a class="hm_a" href="#">이벤트</a></li>
                        <li class="dnone mainMenu"><a class="hm_a" href="#">개설희망</a></li>
                        <li class="mainMenu"><a class="hm_a" href="#">수강후기</a></li>
                    </ul>
                </li>
                <li><a class="hm_a" href="#">MY문화센터</a>
                    <ul class="depth2 no_lecturer" id="no_lecturer">
                        <li><a class="hm_a" href="#">마이페이지</a>
                            <ul class="depth3">
                                <li><a class="hm_a" href="#">-회원정보변경</a></li>
                                <li><a class="hm_a" href="#">-장바구니</a></li>
                                <li><a class="hm_a" href="#">-수강내역조회</a></li>
                                <li><a class="hm_a" href="#">-대기자조회</a></li>
                                <li><a class="hm_a" href="#">-나의활동내역</a></li>
                                
                            </ul>
                        </li>
                            
                        <li><span class="adminMenu">관리자 메뉴</span>
                            <ul class="depth3">
                                <li><a class="hm_a" href="/awesomecenter/adminMemberList.to">-회원리스트</a></li>
                                <li><a class="hm_a" href="#">-강좌리스트</a></li>
                                <li><a class="hm_a" href="#">-커뮤니티</a></li>
                                <li><a class="hm_a" href="#">-강좌등록</a></li>
                                <li><a class="hm_a" href="/awesomecenter/adminMemberChartTest.to">-매출/통계</a></li>
                            </ul>
                        </li>
                        
                    </ul>
                    
                </li>
            </ul>
        </div>
        <!-- gnb : e -->
        <!-- utilityMenu : s -->
        <div class="utilityMenu" >
            <ul>
                <li class="login hm_utilli">
		        	<a class="hm_a" href="javascript:goLogin()"><span>로그인</span></a>
		        	<div class="loginMenu">
                        <ul>
                            <li><a class="hm_a" href="#">회원정보변경</a></li>
                            <li><a class="hm_a" href="#">수강내역조회</a></li>
                            <li><a class="hm_a" href="#">대기자조회</a></li>
                            <li><a class="hm_a" href="#">나의수강후기</a></li>
                            <li><a class="hm_a" href="#">수강증</a></li>
                            <li class="line"><a class="hm_a" href="#none" onclick="goLogout(); return false;">로그아웃</a></li>
                        </ul>
                    </div>
                </li>
                <li class="hm_utilli"><a class="hm_a" href="#"><span>E-전단</span></a></li>
                <li class="hm_utilli"><a class="hm_a" href="#"><span>강사&middot;제휴신청</span></a></li>
                <li class="ico"><a href="#" class="cart hm_a"><span class="blind">장바구니</span><span id="dUserCartCount">0</span></a></li>
                <li class="ico"><a href="#" class="search hm_a"><span class="blind">검색</span></a>
                    <div class="topSearchArea">
                        <input type="text" id="qText" name="qText" title="검색어 입력" placeholder="검색어를 입력해 주세요"><a href="#" id="qTextSearch" class="btnSearch"><span>검색</span></a>
                    </div>
                </li>
            </ul>
        </div>
        <!-- utilityMenu : e -->
    </div>
    <!-- headerArea : e -->
</div>