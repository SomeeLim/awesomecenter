<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/lectureDetail.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("#myModal").hide();
		
		$(".likeHeart").hide();

		$("#introTeacher").click(function() {
			
			let career = $("#introTeacher").text();
			
			if(career == "경력보기") {
				let html = "<td></td><td id='career' colspan='2'>${teacherMap.teacher_career1}<br/>${teacherMap.teacher_career2}</td>";
		
				$("#introTeacherTR").html(html);
				$("#introTeacher").text("정보닫기");
			}
			
			else if(career == "정보닫기") {
				
				$("#introTeacherTR").html("");
				$("#introTeacher").text("경력보기");
			}
			
		});

		
		$(".prepareTitle").click(function() {
			
			$(this).css("opacity","100%");
			$(".reviewTitle").css("opacity","50%");
			
		});

		
		$(".reviewTitle").click(function() {
			
			$(this).css("opacity","100%");
			$(".prepareTitle").css("opacity","50%");
			
		});
		
			
		// 하트 눌렀는지 안눌렀는지 ~~~~
		$.ajax({
			
			url:"<%=ctxPath%>/checkHeart.to",
			type : "POST",
			data:{"class_seq":"${lecturevo.class_seq}"},
			method:"POST",
			dataType:"JSON",
			success:function(json){

				if(json.n=="0") {
					
					$(".disLikeHeart").show();
					$(".likeHeart").hide();
					
				}
				else if(json.n=="1") {
					
					$(".disLikeHeart").hide();
					$(".likeHeart").show();
	
				}

				
			},
			
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
		// 수강후기 총 갯수 가져오기
		$.ajax({
			
			url:"<%=ctxPath%>/checkReviewNum.to",
			type : "POST",
			data:{"class_seq":"${lecturevo.class_seq}"},
			dataType:"JSON",
			success:function(json){
				
				var num = "(" + json.number +")";
				
				$("#reviewNum").html(num);
				
			},
			
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
		// 수강후기 가져오기
		$.ajax({
			
			url:"<%=ctxPath%>/getReviewDetail.to",
			type : "POST",
			data:{"class_seq":"${lecturevo.class_seq}"},
			dataType:"JSON",
			success:function(json){
				
				var html = "";
				
				$.each(json, function(index, item) {
					
					html += "<li><a id='reviewLecAnchor' href='reviewDetail.to?reviewno="+item.REVIEWNO+"'>";
					html += "<div id='reviewLecDetail'>["+item.class_semester+"]&nbsp;"+item.class_title+"</div>";
					html += "<div id='reviewLecTitle'>"+item.SUBJECT+"</div>";
					html += "<div style='font-size:9pt; color:rgb(145,145,145);'><span style='color:black; font-size:10pt;'>"+item.USERNAME+"</span>&nbsp;&nbsp;&nbsp;<span>"+item.WDATE+"</span></div>";
					html += "</a></li>";
					
				});
				
				$("#reviewUL").html(html);
			},
			
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
			
		$("#facebookShare").on("click", function(){
			
			var class_seq = '${lecturevo.class_seq}';
			
			var currenURL = jQuery(location).attr('href');
			var link = encodeURIComponent(currenURL);  
			console.log(link);
			
			window.open("https://www.facebook.com/sharer/sharer.php"
						+"?u="+currenURL
						, "_blank"
						, 'width=600,height=400,resizable=yes,scrollbars=yes'
						);
			
		});
		
		$("#naverShare").on("click", function(){
			
			var currenURL = jQuery(location).attr('href');
			var link = encodeURIComponent(currenURL);  
			console.log(link);
			
			window.open("http://share.naver.com/web/shareView.nhn?url="
						+link+'&title='+encodeURIComponent(document.title)
						, "_blank"
						, 'width=600,height=400,resizable=yes,scrollbars=yes'
						);

			
		});
		
	$("#kakaoShare").on("click", function(){
			
			var currenURL = jQuery(location).attr('href');
			var link = encodeURIComponent(currenURL);  
			console.log(link);
			
			window.open("https://story.kakao.com/s/share?url="
						+link
						, "_blank"
						, 'width=600,height=400,resizable=yes,scrollbars=yes'
						);
			
		});
		
		

	}); // end of $(document).ready ---------------
	
	function goCart() {
		
		var class_seq = ${lecturevo.class_seq};
	
		var frm = document.cartForm;
		frm.class_seq.value = class_seq;
		frm.method = "GET";
		frm.action = "cart.to";
		frm.submit();

	}
	
	function goPayment() {
		
		var class_seq = ${lecturevo.class_seq};
		
		var frm = document.cartForm;
		frm.class_seq.value = class_seq;
		frm.method = "POST";
		frm.action = "payment.to";
		frm.submit();
		
	}
	
	function likeLecture() {
		
		var class_seq = ${lecturevo.class_seq};
		
		$.ajax({
			
			url:"<%=ctxPath%>/likeLecture.to",
			type : "POST",
			data:{"class_seq":class_seq},
			method:"POST",
			dataType:"JSON",
			success:function(json){
				
				if(json.login!=null) {
					alert(json.login);
				}
				else {
					
					$(".disLikeHeart").hide();
					$(".likeHeart").show();
					
				}
				
				
			},
			
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
				
		
	}
	
	function dislikeLecture() {
		
		var class_seq = ${lecturevo.class_seq};
		
		$.ajax({
			
			url:"<%=ctxPath%>/dislikeLecture.to",
			type : "POST",
			data:{"class_seq":class_seq},
			method:"POST",
			dataType:"JSON",
			success:function(json){
				
				if(json.login!=null) {
					alert(json.login);
				}
				else {
					
					$(".likeHeart").hide();
					$(".disLikeHeart").show();
					
				}
				
				
			},
			
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});

	}
	
	function goWaiting() {
		
		var class_seq = ${lecturevo.class_seq};
		console.log(class_seq); 
		
		var frm = document.cartForm;
		frm.class_seq.value = class_seq;
		frm.method = "POST";
		frm.action = "registerWait.to";
		frm.submit();
		
	}
	
	function goCheckPrepare() {
		
		javascript:location.href="<%=ctxPath%>/prepareBoard.to?class_seq=${lecturevo.class_seq}";
		
	}
	
	function urlClipCopy() {
		
		var tempElem = document.createElement('textarea');
		tempElem.value = window.document.location.href;  
		document.body.appendChild(tempElem);

		tempElem.select();
		document.execCommand("copy");
		document.body.removeChild(tempElem);
		alert("URL이 클립보드에 복사되었습니다"); 
		
	}
	
</script>
	
<body id="lectureDetail_body">

	<div id="lectureDetailContainer">
	
		<div id = "pay_nvar" align="right" style = "margin: 40px 0;">
		   <div><i class = "fa fa-home"></i></div>
		   <div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">수강신청</div>
		   <div>수강결제</div>
		</div>
		
		<c:if test="${lecturevo.class_status==1}">
			<span id="onApply">
				접수중
			</span>
		</c:if>
		<c:if test="${lecturevo.class_status==0}">
			<span id="onWait">
				대기접수
			</span>
		</c:if>
		<c:if test="${lecturevo.class_status==2}">
			<span id="closeApply">
				접수마감
			</span>	
		</c:if>		
		<span class="ageCategory">
			${lecturevo.cate_code}강좌
		</span>
		<span id="classCategory">
			${lecturevo.cate_name}
		</span>
		
		<div id="lecDetailTitleDIV" style="width: 1200px;">
			<h1 id='lectureDetailTitle' style='display: inline-block;'>${lecturevo.class_title }</h1>
			<img class='selectHeart disLikeHeart' src='resources/images/lectureDetail-disselectedheart.png' onclick="likeLecture()"/>
			<img class='selectHeart likeHeart' src='resources/images/lectureDetail-selectedheart.png' onclick='dislikeLecture()' />
		</div>

		<div id="lectureDetailContent">
			<div id="introLectureDetail">
				<h3>강좌소개</h3>
				<div style="text-align: center; padding-top: 15px;">
					<img id="lectureDetailPicture" src="resources/images_lecture/${lecturevo.class_photo }" />
					<br/>
					<span id="lectureDetailExplanation">
						${lecturevo.class_content }
					</span>
				</div>
				<div id="cautionLectureDetail">
					<span style="font-size: 12pt;">수강 접수시 유의사항</span><br/>
					<br/>
					1. 회원정보에서 핸드폰 번호를 꼭 다시 한 번 확인 해 주세요.<br/>
					
					2. 환불요청시 10일 전(前)까지이며, 개강 이후에는 수업 참여여부와 상관없이<br/>
					   &nbsp;&nbsp;&nbsp; [평생교육시설 운영법]에 의거해 처리됩니다.<br/>
					   &nbsp;&nbsp;&nbsp;*대기접수시 접수신청은 신청가능 여부 연락 후 1일 내에 결제해주셔야 신청가능합니다.<br/>
					
					3. 본인이 아닌 자녀 및 가족 등록 시 가족등록 시에도 회원가입 수강자명으로 등록됩니다.<br/>
					
					4. 대기접수 신청시 수강취소가 불가합니다.<br/>
					
					5. 수강신청 인원이 미달될 경우 강좌가 폐강 될수 있으며, 폐강시 수강료는 전액 환불해 드립니다.<br/>
					
					6. 공예/요리 등 재료 준비가 필요한 강좌는 재료비가 강사님께 현금납부됩니다.<br/>
					
					7. 영유아 강좌는 아이와 보호자 1인만 참여 가능합니다.<br/>
					
					8. 수강자 외 형제, 자매나 보호자 1인 이상의 참여는 불가하오니, 이 점 양해부탁드립니다.<br/>
				</div>
			</div>
			<div id="infoLectureDetail">
				<table>
					<tr>
						<td style="font-weight: bold;">지점</td>
						<td colspan="2">본점</td>
					</tr>
					<tr>
						<td style="font-weight: bold;">월</td>
						<td colspan="2">${lecturevo.class_semester }</td>
					</tr>
					<tr>
						<td style="font-weight: bold;">강사명</td>
						<td>${lecturevo.teacher_name }</td>
						<td>
							<span id="introTeacher" style="border: solid lightgray 1px; padding: 5px 14px; cursor: pointer; font-size: 9pt; float: right; width: 80px;">경력보기</span>
						</td>
					</tr>
					<tr id="introTeacherTR">
					</tr>
					<tr>
						<td style="font-weight: bold;">수강기간</td>
						<td colspan="2">${lecturevo.class_startDate}&nbsp;~&nbsp;${lecturevo.class_endDate}</td>
					</tr>
					<tr>
						<td style="font-weight: bold;">수강시간</td>
						<td colspan="2">(${lecturevo.class_day })&nbsp;&nbsp;${lecturevo.class_time }</td>
					</tr>
					<tr>
						<td style="font-weight: bold;">강의정원</td>
						<td colspan="2">${lecturevo.class_personnel }&nbsp;명</td>
					</tr>
					<tr>
						<td style="font-weight: bold;">강의실</td>
						<td colspan="2">${lecturevo.class_place }&nbsp;강의실</td>
					</tr>
					<tr>
						<td style="font-weight: bold;">수강료</td>
						<td colspan="2"><fmt:formatNumber value="${lecturevo.class_fee}" pattern="###,###" />&nbsp;원</td>
					</tr>
					<tr>
						<td style="font-weight: bold;">재료비</td>
						<td colspan="2">
							<c:if test="${lecturevo.class_subFee == 0}">
								<span>-</span>
							</c:if>
							<c:if test="${lecturevo.class_subFee > 0}">
								<fmt:formatNumber value="${lecturevo.class_subFee}" pattern="###,###" />&nbsp;원
							</c:if>
						</td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"><span id="checkPrepare" onclick="goCheckPrepare()">수업자료 확인하기</span></td>
					</tr>
					<%-- 
					<tr>
						<td style="font-weight: bold;">수강생 통계</td>
						<td>
							<!-- 차트 모달:s -->
							<div id="listFilter">
							<div class="popup" style="cursor: pointer;">
								<span style="border: solid lightgray 1px; padding: 5px 14px; cursor: pointer; font-size: 9pt; width: 80px;" data-toggle="modal" data-target="#myModal">보기</span>
							</div>
							</div>
							
							  <!-- The Modal -->
							  <div class="modal fade" id="myModal" style="position: absolute; background-color: white; border: solid 1px black; top: 1035px; border-radius: 10pt;">
							    <div class="modal-dialog modal-lg">
							      <div class="modal-content">
							      <!-- 
							        Modal Header
							        <div class="modal-header">
							          <h4 class="modal-title"></h4>
							          
							        </div> -->
							        
							        <!-- Modal body -->
							        <div class="modal-body">
										<figure class="highcharts-figure">
										    <jsp:include page="../member/chart/lectureChart.jsp" />
										</figure>
							        </div>
							        <!-- 
							        Modal footer
							        <div class="modal-footer">
							          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
							        </div>
							         -->
							      </div>
							    </div>
							  </div>
				<!-- 차트 모달:e -->
							
						</td>
					</tr>
					--%>
					<tr>
						<td style="font-weight: bold;">접수기간</td>
						<td colspan="2">${register_term}</td>
					</tr>
					<tr>
						<td style="font-weight: bold;">문의처</td>
						<td colspan="2">02-1544-9970</td>
					</tr>
					<tr>
						<td style="font-weight: bold;">공유하기</td>
						<td colspan="2">
							<span style="font-size: 9pt; color: rgb(113,113,113); padding: 5px 10px; border: solid 1px rgb(181,181,181); background-color: white; cursor: pointer;" onclick="urlClipCopy()">URL복사</span>
							<img src="resources/images/LectureDetail_Facebook_icon.png" id="facebookShare" style="width: 28px; height: 28px; cursor: pointer;" >
							<img src="resources/images/LectureDetail_naver_icon.png" id="naverShare" style="width: 35px; height: 35px; cursor: pointer;" >
							<img src="resources/images/LectureDetail_kakao.png" id="kakaoShare" style="width: 30px; height: 30px; cursor: pointer;" />
						
						</td>
					</tr>
					
				</table>
				<div style="text-align: center; margin-top: 8px;">
					<c:if test="${lecturevo.class_status==1}">
						<span class="statusRegisterSpan"><span style="font-size: 20pt; color: red;">접수중</span>입니다</span>
					</c:if>
					<c:if test="${lecturevo.class_status==0}">
						<span class="statusRegisterSpan"><span style="font-size: 20pt; color: red;">대기접수</span>입니다</span>
					</c:if>
					<c:if test="${lecturevo.class_status==2}">
						<span class="statusRegisterSpan"><span style="font-size: 20pt; color: red;">접수마감</span>입니다</span>
					</c:if>
				</div>			
			</div>
			
		</div>
		<div id="detailGoBtn">
			<a href="javascript:history.back();"><span id="goLectureList">목록</span></a>
			<form name="cartForm">
				<input name="class_seq" type="hidden" />
			</form>
			<c:if test="${lecturevo.class_status==1}">
				<span id="goCart" onclick="goCart();">장바구니 담기</span>
				<span id="goRegister" onclick="goPayment()">신청하기</span>					
			</c:if>
			<c:if test="${lecturevo.class_status==0}">
				<span id="goWhite">#### ##</span>
				<span id="goWaiting" onclick="goWaiting()">대기접수하기</span>
			</c:if>	
			<c:if test="${lecturevo.class_status==2}">
				<span id="goWhite">#### ##</span>
				<span id="goWhite">#### ##</span>
			</c:if>	
	
			
			
		</div>
	</div>
	
	<div id="boradLectureDetail">
		<div id="boardContainer">
			
			<span class="boardTitle reviewTitle">수강후기&nbsp;<span id="reviewNum" style="color: red;"></span></span>
			<a href="<%=ctxPath %>/boardmenu4.to"><span style="font-size: 10pt; color: rgb(121,121,121); float: right; margin-bottom: -40px; margin-right:40px; cursor: pointer;">수강후기메뉴에서 더 보기 ▶</span></a>
			<br/>
			
			<div id="reviewDIV">
				<ul id="reviewUL">
										
				</ul>
			</div>
			
		</div>
	</div>
	
</body>
