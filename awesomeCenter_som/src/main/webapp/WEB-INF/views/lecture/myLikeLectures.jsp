<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/myLikeLecture.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
	$(function(){
		
		$("#totalLikeCnt").hide();
		$("#countCode").hide();
		
		// 카테고리별 상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션에 대해 초기값 호출  
		likeListFnc("1");
		
		// HIT상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션의 이벤트 등록하기 
		$("#btnMore").click(function(){
			
			likeListFnc($(this).val());
			
		});		
		
	});
	
	var len = 8; 
	// HIT 상품 "더보기..." 버튼을 클릭할때 보여줄 상품의 갯수(단위)크기 
	
	function likeListFnc(start) {
		
		$.ajax({
			
			url:"<%= ctxPath%>/myLikeLecturesList.to",
			//	type:"GET",
			data:{"start":start
		    	 ,"len":len},
		    dataType:"JSON",
		    success:function(json){
		    	
				var html = "<ul>";
		    	
		    	if(json.length == 0) {
		    		
		    		var noList ="<div align='center'>";
		    		noList += "<span style='font-size:20pt; letter-spacing: -3px;'>지금 관심강좌를 등록해보세요!</span><br/><br/><br/>";
		    		noList += "<a href='lectureApply.to' style='text-decoration: none; color:black; '><span style='text-decoration: none; font-size:15pt; padding:15px 30px; background-color:rgb(228,225,223); letter-spacing: -3px; color:black; cursor:pointer;'>강좌검색으로 가기</span></a>";
		    		noList += "<div>";
		    		
		    		$("#noList").html(noList);
		    		$("#btnMore").hide();
		    		
		    	}
		    	else {
		    		$.each(json, function(index, item){

			    			
		    			html += "<li>";
		    			html += "<a href='lectureDetail.to?class_seq="+item.CLASS_SEQ+"'>";
		    			html += "<div class='prodItem'>";
		    			html += "<div class='thum'>";
		    			html += "<img class='lecListPic' src='resources/images_lecture/"+item.CLASS_PHOTO+"' />";
		    			html += "</div>";
		    			html += "<div class='lecInfo'>";
		    			html += "<div>";
		    			
		    			if(item.CLASS_STATUS==1)
		    				html += "<span class='onApply'>접수중</span>";
		    			else if(item.CLASS_STATUS==0)
		    				html += "<span class='onWait'>대기접수</span>";
	    				else if(item.CLASS_STATUS==2)
		    				html += "<span class='closeApply'>접수마감</span>";
		    			html += "<span class='detailAge'>"+item.cate_code+"강좌</span><span class='detailCat'>"+item.cate_name+"</span>";
		    			html += "</div>";
		    			html += "<div class='lecTitleDIV'>";
		    			html += "<span id='lecTitle'>"+item.CLASS_TITLE+"</span></div>";
		    			html += "<div id='lecDetailInfo'>";
		    			html += "<span class='detailInfoSpan'>"+item.TEACHER_NAME+"</span>&nbsp;&nbsp;";
		    			html += "<span class='detailInfoSpan'>"+item.CLASS_SEMESTER+"</span>&nbsp;&nbsp;";
		    			html += "<span class='detailInfoSpan'>("+ item.CLASS_DAY+")&nbsp;&nbsp;"+item.CLASS_TIME+"</span><br/>";
		    			html += "<span style='color: black; font-size: 11pt;'>"+item.CLASS_FEE+"&nbsp;원</span>&nbsp;&nbsp;<span class='detailInfoSpan'>(총 4회)</span>";
		    			html += "</div></div></a></li>";
		    			html += "</li>";
			    			
		    		});
		    		
		    		html += "</ul>";
		    		
		    		// HIT 상품 결과를 출력하기
		    		$("#pictureList").append(html);
		    		
					// 더로드하기... 버튼의 value 속성에 값을 지정하기
		    		$("#btnMore").val(parseInt(start)+len);

					// countCode 에 지금까지 출력된 상품의 갯수를 누적해서 기록한다. 
		    		$("#countCode").text( parseInt($("#countCode").text()) + json.length);
		    		
		    		if( $("#countCode").text() == $("#totalLikeCnt").text() ) { 
		    			$("#btnMore").hide();
		    		}
		    		
		    	}
		    	
									
		    	
		    	
		    	
		    },
		    
		    error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
	}
	
</script>

	<div id="container_kdh">
		<div id="content_kdh">
		
			<div class="menu_kdh">
				<a href="#" class="material-icons atag">home</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">My문화센터</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">마이페이지</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">회원정보변경</a>
			</div>
			
			<div class="main_kdh memberModify_kdh">
				<h2 class="name_kdh h2"><span>${sessionScope.loginuser.username}님</span><span style="font-size: 23pt;">의&nbsp;&nbsp;관심강좌&nbsp;&nbsp;목록</span></h2>
				
				<div id="pictureList"></div>
				<div id="noList"></div>
				<br/> 
				<div align="center">
					<button type="button" id="btnMore" value="" class="theload"  >더 보기</button>
				</div>
				<span id="totalLikeCnt">${totalLikeCnt}</span>
				<span id="countCode">0</span>
			</div>
		</div>
	</div>
