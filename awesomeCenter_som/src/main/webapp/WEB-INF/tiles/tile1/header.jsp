<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	
	$("#qText").keydown(function(event) {
		
		if(event.keyCode == 13){
			
			goHeaderSearch();
			
		}
		
	});
	
	$(".loginBtn").click(function(){
    	//var newURL = window.location.protocol + "/" + window.location.host + "/" + window.location.pathname;
    	var newURL = window.location.pathname;
    	$("#newURL").val(newURL);
    	var frm = document.newURLfrm;
    	frm.action = "<%=ctxPath%>/login.to";
    	frm.submit();
   	});
	
});

	function goHeaderSearch() {
	
		if($("#qText").val().trim() == ""){
			
			alert("검색어를 입력하세요.");
			return;
		}
		
		$("form[name=HSearchFrm]").submit();
	}

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
                        <li class="mainMenu"><a class="hm_a" href="<%= ctxPath %>/lectureApply.to">강좌검색</a></li>
                        <li class="mainMenu"><a class="hm_a" href="<%= ctxPath %>/recomLec.to">추천강좌</a></li>
                        <li class="mainMenu"><a class="hm_a" href="<%= ctxPath %>/populLec.to">인기강좌</a></li>
                        <li class="mainMenu"><a class="hm_a" href="<%= ctxPath %>/lectureSchedule.to">강좌스케줄</a></li>
                        <li class="mainMenu"><a class="hm_a" href="<%= ctxPath %>/information/onlineGuide.to">온라인 신청 가이드</a></li>
                    </ul>
                    
                </li>
                <li><a class="hm_a" href="#">이용안내</a>
                    <ul class="depth2">
                        <li class="mainMenu"><a class="hm_a" href="<%= ctxPath %>/centerplace.to">센터찾기</a></li>
                        <li class="mainMenu"><a class="hm_a" href="<%= ctxPath%>/QnA/FAQList.to">FAQ</a></li>
                        <li class="mainMenu"><a class="hm_a" href="<%= ctxPath%>/FlowPaper/Publications/awesome_catalog_pdf/index.html">E-카탈로그</a></li>
                    </ul>
                </li>
                <li><a class="hm_a" href="#">커뮤니티</a>
                    <ul class="depth2">
                        <li class="mainMenu"><a class="hm_a" href="/awesomecenter/boardmenu.to">공지사항</a></li>
                        <li class="mainMenu"><a class="hm_a" href="/awesomecenter/boardmenu2.to">이벤트</a></li>
                        <li class="mainMenu"><a class="hm_a" href="/awesomecenter/boardmenu3.to">개설희망</a></li>
                        <li class="mainMenu"><a class="hm_a" href="<%= ctxPath%>/boardmenu4.to">수강후기</a></li>
                    </ul>
                </li>
                <li><a class="hm_a" href="#">MY문화센터</a>
                	<c:if test="${sessionScope.loginuser.userid == 'admin'}">
                    	<ul class="depth2 no_lecturer admin" id="no_lecturer">
                    </c:if>
                    <c:if test="${sessionScope.loginuser.userid != 'admin'}">
                    	<ul class="depth2 no_lecturer" id="no_lecturer">
                    </c:if>
                    
                        <li><a class="hm_a" href="<%= ctxPath%>/member/mypage.to">마이페이지</a>
                            <ul class="depth3">
                                <li><a class="hm_a" href="<%= ctxPath%>/member/mypage.to">-회원정보변경</a></li>
                                <li><a class="hm_a" href="<%= ctxPath%>/cart.to">-장바구니</a></li>
                                <li><a class="hm_a" href="<%= ctxPath%>/member/lectureList.to">-수강내역조회</a></li>
                                <li><a class="hm_a" href="<%= ctxPath%>/member/waitingList.to">-대기자조회</a></li>
                                <c:if test="${sessionScope.loginuser.userid != 'admin'}">
                                <li><a class="hm_a" href="/awesomecenter/QnA/QnAList.to">-나의문의내역</a></li>
                                </c:if>
                                
                            </ul>
                        </li>
                        <c:if test="${sessionScope.loginuser.userid == 'admin'}">
                        <li><span class="adminMenu">관리자 메뉴</span>
                            <ul class="depth3">
                                <li><a class="hm_a" href="/awesomecenter/adminMemberList.to">-회원리스트</a></li>
                                <li><a class="hm_a" href="/awesomecenter/lectureListAdmin.to">-강좌리스트</a></li>
                                <li><a class="hm_a" href="/awesomecenter/teacherListAdmin.to">-강사리스트</a></li>
                                <li><a class="hm_a" href="/awesomecenter/registerLectureAdmin.to">-강좌등록</a></li>
                                <li><a class="hm_a" href="/awesomecenter/registerTeacherAdmin.to">-강사등록</a></li>
                                <li><a class="hm_a" href="/awesomecenter/adminMemberChartTest.to">-매출/통계</a></li>
                                <li><a class="hm_a" href="/awesomecenter/QnA/QnAList.to">-문의내역</a></li>
                            </ul>
                        </li>
                        </c:if>
                    </ul>
                </li>
            </ul>
        </div>
        <!-- gnb : e -->
        <!-- utilityMenu : s -->
        <div class="utilityMenu" >
            <ul>
                <%--<li class="login hm_utilli"> --%>
                	<c:if test="${empty sessionScope.loginuser}">
                		<li class="hm_utilli">
		        		<a class="hm_a loginBtn"><span style="cursor: pointer;">로그인</span></a>
		        		<form name="newURLfrm">
		        			<input type="hidden" id="newURL" name="newURL" />
		        		</form>
		        	</c:if>
		        	
		        	<c:if test="${!empty sessionScope.loginuser}">
		        		<li class="login hm_utilli">
		        		<a class="hm_a" href="#"><span>${sessionScope.loginuser.username }</span></a>
		        	</c:if>
		        	<div class="loginMenu">
                        <ul>
                           <li><a class="hm_a" href="<%= ctxPath%>/member/mypage.to">회원정보변경</a></li>
                            <li><a class="hm_a" href="<%= ctxPath%>/member/lectureList.to">수강내역조회</a></li>
                            <li><a class="hm_a" href="<%= ctxPath%>/member/waitingList.to">대기자조회</a></li>
                            <li><a class="hm_a" href="<%= ctxPath%>/member/review.to">나의수강후기</a></li>
                            <li><a class="hm_a" href="<%= ctxPath%>/myLikeLectures.to">좋아요</a></li>
                            <li class="line"><a class="hm_a" href="<%=ctxPath%>/logout.to" >로그아웃</a></li>
                        </ul>
                    </div>
                </li>
                <li class="hm_utilli"><a class="hm_a" href="<%= ctxPath%>/FlowPaper/Publications/awesome_catalog_pdf/index.html"><span>E-전단</span></a></li>
                <!-- <li class="hm_utilli"><a class="hm_a" href="#"><span>강사&middot;제휴신청</span></a></li> -->
                <li class="ico"><a href="<%=ctxPath%>/cart.to" class="cart hm_a"><span class="blind">장바구니</span></a></li>
                <li class="ico"><a href="#" class="search hm_a"><span class="blind">검색</span></a>
                    <div class="topSearchArea">
                    	<form name="HSearchFrm" method = "POST" action = "<%=ctxPath%>/search.to">
                        	<input type="text" id="qText" name="searchWord" title="검색어 입력" placeholder="검색어를 입력해 주세요">
                        	 <a id="qTextSearch" class="btnSearch" onclick = "goHeaderSearch();"><span>검색</span></a>
                        </form>
                    </div>
                </li>
            </ul>
        </div>
        <!-- utilityMenu : e -->
    </div>
    <!-- headerArea : e -->
</div>