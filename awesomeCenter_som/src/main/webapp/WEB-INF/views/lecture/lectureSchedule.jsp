<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/lectureSchedule.css" />


<script type="text/javascript">

	$(function() {
	
		$("#lecture_menu ul li a").click(function() {
			
			$(this).addClass("action");
			
			$("#lecture_menu ul li a").not(this).removeClass("action");
			
		});
		
		changeSchedule();
		
		$(".selectDay").click(function() {
			
			$(this).addClass("selectedDay");
			
			$("#scheduleDayDIV span").not(this).removeClass("selectedDay");
			
			changeSchedule();
			
		});
		
		$(".selectCat").click(function() {
			
			$(this).addClass("selectedCat");
			
			$("#scheduleCatDIV span").not(this).removeClass("selectedCat");
			
			changeSchedule();
			
		});
		
		
	});
	
	function changeSchedule() {

		let selectedCat = $(".selectedCat").text();
		let selectedDay = $(".selectedDay").text();

		$.ajax({
			
			url:"<%=ctxPath%>/lectureScheduleJSON.to",
			data:{"selectedCat":selectedCat,"selectedDay":selectedDay},
			dataType:"JSON",
			success:function(json){
				
				let html = "<tr><th style='border-top: solid 1px black; width: 13%;'>구분</th>" +
						   "<th style='border-top: solid 1px black; width:28.5%;'>오전 09:00 ~ 12:00</th>" +
						   "<th style='border-top: solid 1px black; width:29%;'>오후 12:00 ~ 18:00</th>" +
						   "<th style='border-top: solid 1px black; width:29%;'>저녁 18:00 ~ 21:00</th></tr>";
						   
				
			    if(json.length == 0) {
			    	
			    	html += "<tr><td style='text-align:center; padding:10px 0;' colspan='4'>죄송합니다!<br/>해당 시간에는 수업이 없습니다</td></tr>";
			    	
			    }
			    else {
			    	
			    	var uniqueClass = [];
			    	
			    	$.each(json, function(number, place) {
			    				
	    				if($.inArray(place.class_place, uniqueClass) === -1) uniqueClass.push(place.class_place);
	    				
	    				console.log(uniqueClass);
			    				
			    	});
    				
			    	for(var i in uniqueClass) {
			    		
			    		// 강의실 A
				    	html += "<tr><th class='classPlace' style='background-color: white; text-align: center;'>"+uniqueClass[i]+"강의실</td>";

				    	// 오전 09:00 ~ 12:00 
		    			html += "<td><ul>";    			
		    			$.each(json, function(index, item) {
		    		 		if((item.class_time).substring(0,2) < 12 && item.class_place == uniqueClass[i]) {
		    		 			html += "<li style='font-size:9pt; color:rgb(150,150,150)'>(" + item.class_day + ")&nbsp;" + item.class_time + "<br/><a href='lectureDetail.to?class_seq="+item.class_seq+"'><span style='font-size:11pt; color:black;'>" + item.class_title +
		    		 					"</a></span></li>";
		    		 		}
		    			});
		    			html += "</ul></td>";
		    			
		    			// 오후 12:00 ~ 18:00
		    			html += "<td><ul>";
		    			$.each(json, function(index, item) {
		    		 		if( 12 <= (item.class_time).substring(0,2) && (item.class_time).substring(0,2) < 17 && item.class_place == uniqueClass[i]) {
		    		 			html += "<li style='font-size:9pt; color:rgb(150,150,150)'>(" + item.class_day + ")&nbsp;" + item.class_time + "<br/><a href='lectureDetail.to?class_seq="+item.class_seq+"'><span style='font-size:11pt; color:black;'>" + item.class_title +
    		 							"</a></span></li>";
		    		 		}
		    			});
		    			html += "</ul></td>";
		    			
		    			// 저녁 18:00 ~ 21:00
		    			html += "<td><ul>";
		    			$.each(json, function(index, item) {
		    		 		if((item.class_time).substring(0,2) >= 17 && item.class_place == uniqueClass[i]) {
		    		 			html += "<li style='font-size:9pt; color:rgb(150,150,150)'>(" + item.class_day + ")&nbsp;" + item.class_time + "<br/><a href='lectureDetail.to?class_seq="+item.class_seq+"'><span style='font-size:11pt; color:black;'>" + item.class_title +
    		 							"</a></span></li>";
		    		 		}
		    			});
		    			html += "</ul></th>";
				    	html += "</tr>";

			    		
			    	}
			    	
    				
				    	
			    	
			    }
			    	
			    	
			    
			
				$("#lecScheduleTable").html(html);
				
			},
			
			error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
		});
		
	}

</script>

</head>

<div id = "lecture_body">
	<div id = "lectureList" >
		
		<div id = "lecture_nvar" align="right" style = "margin: 40px 0;">
			<div>
				<a href = "<%=ctxPath%>/main.to"><img src = "<%=ctxPath%>/resources/images/Home.png" ></a>
			</div>
			<div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">
				<a href = "<%= ctxPath %>/lectureApply.to">수강신청</a>
			</div>
			<div>
				<a href = "javascript:history.go(0);">강좌스케쥴</a>
			</div>
			
		</div>
		<div align="center" id = "lecture_h2">
			<h2>강좌스케쥴</h2>
		</div>
		
		<div id = "lecture_menu">
			<ul>
				<li><a href = "<%= ctxPath %>/lectureApply.to" >강좌검색</a></li>
				<li><a href = "<%= ctxPath %>/recomLec.to">추천강좌</a></li> <!-- recomLec.to  -->
				<li><a href = "<%= ctxPath %>/populLec.to">인기강좌</a></li>	<!-- populLec.to  -->
				<li><a href = "<%= ctxPath %>/lectureSchedule.to" class = "action">강좌스케줄</a></li>
			</ul>
		</div>
	
	</div>
	
	<div id = "realList">
		<div id="scheduleContainer">
			<div id="scheduleCatDIV" style="float: left; padding-bottom: 14px;">
				<span class="selectCat selectedCat">전체</span>
				<span class="selectCat">성인강좌</span>
				<span class="selectCat">아동강좌</span>
			</div>
			
			<div id="scheduleDayDIV" style="float: right; padding-bottom: 14px;">
				<span class="selectDay selectedDay">월</span>
				<span class="selectDay">화</span>
				<span class="selectDay">수</span>
				<span class="selectDay">목</span>
				<span class="selectDay">금</span>
				<span class="selectDay">토</span>
				<span class="selectDay">일</span>
			</div>
			
			<div></div>
			
			<div>
				<table id="lecScheduleTable">
				</table>
			</div>
			
			<div align="center" style="text-decoration: underline; cursor: pointer; padding-bottom: 20px;" onclick="javascript:window.scrollTo(0,0)">맨 위로</div>
		</div>
		
	</div>	

</div>