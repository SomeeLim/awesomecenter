<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/lectureApply.css" />

<script type="text/javascript">

	$(function() {
	
		$("input[name=searchLecWord]").keydown(function(event) {
			
			if(event.keyCode == 13){
				
				goSearchList();
				
			}
			
		});
		
		
		$("#lecture_menu ul li a").click(function() {
			
			$(this).addClass("action");
			
			$("#lecture_menu ul li a").not(this).removeClass("action");
			
		});
		
		$(".pagebar-btn").hover(function () {
			
			$(this).css("opacity", "100%");
			
			
			}, function() {
				
			$(this).css("opacity", "60%");
				
		});
		
		///////////////////////////////////////
		
		// 대분류 카테고리 불러오기
		$("select[name=cate_code]").change(function() {
			
			$.ajax({
				
				url : "<%= ctxPath%>/getLecCate.to",
				type : "GET",
				data : { "cate_code" : $(this).val()},
				dataType : "JSON",
				success : function(json){
					
					if(json.length > 0){
						
						var html = "";
						
						html += "<option value = ''>전체</option>";
						$.each(json, function(index, item) {
							
							html += "<option value = "+item.cate_no+">"+item.cate_name+"</option>";
							
						});
						
						$("select[name=cate_no]").html(html);
					}
					else {
						// 검색된 데이터가 존재하지 않는 경우
						
						$("select[name=cate_no]").html("<option value = ''>카테고리</option>");
					}
							
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
			});// ajax	       	
		
		});// select / change
		
		// 선택한 value값 다시 그대로 가져오기
		let cate_code = '${cate_code}';
		let cate_no = '${cate_no}';
		if(cate_code != null && cate_code == "성인") {
			
			$("select[name=cate_code]").val(cate_code);
			
			if(cate_no != null && cate_no == 1) {
				$("select[name=cate_no]").html("<option value = "+cate_no+">건강·댄스</option>");
			}
			else if(cate_no != null && cate_no == 2) {
				$("select[name=cate_no]").html("<option value = "+cate_no+">아트·플라워</option>");
			}
			else if(cate_no != null && cate_no == 3) {
				$("select[name=cate_no]").html("<option value = "+cate_no+">음악·악기</option>");
			}
			else if(cate_no != null && cate_no == 4) {
				$("select[name=cate_no]").html("<option value = "+cate_no+">쿠킹·레시피</option>");
			}
			else if(cate_no != null && cate_no == 5) {
				$("select[name=cate_no]").html("<option value = "+cate_no+">출산·육아</option>");
			}
			else if(cate_no != null && cate_no == 6) {
				$("select[name=cate_no]").html("<option value = "+cate_no+">어학·교양</option>");
			}
			
		}
		
		else if(cate_code != null && cate_code == "아동") {
			
			$("select[name=cate_code]").val(cate_code);
			
			if(cate_no != null && cate_no == 7) {
				$("select[name=cate_no]").html("<option value = "+cate_no+">창의·체험</option>");
			}
			else if(cate_no != null && cate_no == 8) {
				$("select[name=cate_no]").html("<option value = "+cate_no+">음악·미술·건강</option>");
			}
			else if(cate_no != null && cate_no == 9) {
				$("select[name=cate_no]").html("<option value = "+cate_no+">교육·오감발달</option>");
			}
			
		}
		
		var class_status = '${class_status}';
		if(class_status != null) {
			$("select[name=class_status]").val(class_status);
		}
		
		var class_semester = '${class_semester}';
		if(class_semester != null) {
			$("select[name=class_semester]").val(class_semester);
		}
		
		var class_day = '${class_day}';
		if(class_day != null) {
			$("select[name=class_day]").val(class_day);
		}
		
		var searchType = '${searchType}';
		if(searchType != null) {
			$("select[name=searchType]").val(searchType);
		}
		
		var searchWord = '${searchLecWord}';
		if(searchWord != null) {
			$("input[name=searchLecWord]").val(searchWord);
		}
		
		if('${listfilter}' !=null && '${listfilter}' == '1') {
			$("#uptodate").addClass("filterList");
			$("#listFilter").find('span').not("#uptodate").removeClass("filterList");
		}
		else if('${listfilter}' !=null && '${listfilter}' == '3') {
			$("#lowprice").addClass("filterList");
			$("#listFilter").find('span').not("#lowprice").removeClass("filterList");
		}
		else if('${listfilter}' !=null && '${listfilter}' == '4') {
			$("#highprice").addClass("filterList");
			$("#listFilter").find('span').not("#highprice").removeClass("filterList");
		}
		
		$("#listFilter").find('span').click(function() {
			
			$(this).addClass("filterList");
			$("#listFilter").find('span').not(this).removeClass("filterList");
			
			var listfilter = $(this).text();
			
			var frm = document.searchLecFrm;
			
			frm.method = "GET";
			frm.listfilter.value = listfilter;
			frm.action = "<%= ctxPath %>/lectureApply.to";
			
			frm.submit();
			
		});

		
	});// end of $(function() { });
	
	function goSearchList() {
		
		var listfilter = $("#listFilter").find('.filterList').text();
		
		$("#listFilter").find('.filterList').addClass("filterList");
		$("#listFilter").find('span').not('.filterList').removeClass("filterList");
		
		if($("input[name=searchLecWord]").val().trim() != "" && $("select[name=searchType]").val() == "" ){
			
			alert("검색어를 설정해주세요!");
			$("input[name=searchLecWord]").val("");
			return false;
			
		}
		
		var frm = document.searchLecFrm;
		
		frm.method = "GET";
		frm.listfilter.value = listfilter;
		frm.action = "<%= ctxPath %>/lectureApply.to";
		
		frm.submit();
		
	}

	/* function openInNewTab(url) {
		
		var win = window.open(url, '_blank');
		win.focus();
		
	} */

</script>

</head>

<div id = "lecture_body">
	<div id = "lectureList" >
		
		<div id = "lecture_nvar" align="right" style = "margin: 40px 0;">
		<!-- 	<div><img src = ""></div>
			<div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">수강신청</div>
			<div>강좌검색</div> -->
			
			<div>
				<a href = "<%=ctxPath%>/main.to"><img src = "<%=ctxPath%>/resources/images/Home.png" ></a>
			</div>
			<div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">
				<a href = "javascript:history.go(0);">수강신청</a>
			</div>
			<div>
				<a href = "javascript:history.go(0);">강좌검색</a>
			</div>
			
		</div>
		<div align="center" id = "lecture_h2">
			<h2>강좌검색</h2>
		</div>
		
		<div id = "lecture_menu">
			<ul>
				<li><a href = "<%= ctxPath %>/lectureApply.to" class = "action">강좌검색</a></li>
				<li><a href = "<%= ctxPath %>/recomLec.to">추천강좌</a></li> <!-- recomLec.to  -->
				<li><a href = "<%= ctxPath %>/populLec.to">인기강좌</a></li>	<!-- populLec.to  -->
				<li><a href = "<%= ctxPath %>/lectureSchedule.to">강좌스케줄</a></li>
			</ul>
		</div>
	
	</div>
		
	<div id = "realList">
		
		<div id = "searchLec">
			<form name="searchLecFrm" id = "searchLecFrm">
				<table>
					<tr>
						<td>
							<select class = "tnrkdeotkd" name = "cate_code">
								<option value = "">수강대상</option>
								<option value="성인">성인</option>
								<option value="아동">유아/아동</option>
								
							</select>
						</td>
						<td>
							<select class = "tnrkdeotkd" name = "cate_no" id = "cate_name">
								<option value = "">카테고리</option>
							</select>
						</td>
						<td>
							<select class = "tnrkdeotkd" name = "class_status">
								<option value = "">접수상태</option>
								<option value = "1">접수중</option>
								<option value = "2">접수마감</option>
								<option value = "0">대기등록</option>
							</select>
						</td>
						<td>
							<select class = "tnrkdeotkd" name = "class_semester">
								<option value = "">수강월</option>
								<c:forEach var="i" begin="1" end="12">
									<option value="${ i }월">${ i }월</option>
								</c:forEach>
							</select>
						</td>
						<td>
							<select class = "tnrkdeotkd" name = "class_day">
								<option value = "">수강요일</option>
								<option value="일">일요일</option>
								<option value="월">월요일</option>
								<option value="화">화요일</option>
								<option value="수">수요일</option>
								<option value="목">목요일</option>
								<option value="금">금요일</option>
								<option value="토">토요일</option>
							</select>
						</td>
					 	
						<td rowspan = "2" class = "searchbbbb" onclick = "goSearchList()" >
							<span style = "margin : 0 8px; cursor: pointer;" >검색</span>
						</td>
					 
					</tr>
					
					<tr>
						<td colspan = "1">
							<select  class = "tnrkdeotkd" name = "searchType">
								<option value = "" >검색어</option>
								<option value = "teacher_name">강사명</option>
								<option value = "class_title">강좌명</option>
							</select>
						</td>
						<td colspan="4" class = "tnrkdeotkdinput">
							<input type="text" name = "searchLecWord" class = "tnrkdeotkdinput" placeholder="강사명/강좌명을 입력하세요."/>
							<button type = "reset" id = "cancelBtn">X</button>
						</td>
					</tr>
				</table>
				<input type="hidden" name="listfilter" /> 
				<input type="hidden" name="currentShowPageNo" /> 
			</form>
		</div>
		
		<div id="listLec">
			<div id="listFilter">
				<span id="uptodate" style="cursor: pointer;">최신등록순</span>&nbsp;&nbsp;
				<span id="lowprice" style="cursor: pointer;">낮은 가격순</span>&nbsp;&nbsp;
				<span id="highprice" style="cursor: pointer;">높은 가격순</span>
			</div>
			
			<div id="pictureList">
				<ul>
					<c:forEach var="lecturevo" items="${lectureList}">
						<li>
							<a href='lectureDetail.to?class_seq=${lecturevo.class_seq}'>
							<div class="prodItem">
								<div class="thum">
									<img class="lecListPic" src="resources/images_lecture/${lecturevo.class_photo}" />
								</div>
								<div class="lecInfo">
									<div>
										<%-- 여기 css 땜에 한줄로 쭉 썼으니 지저분해도 이해 부탁합니다 ㅠㅠ --%>
										<c:if test="${lecturevo.class_status==1 }"><span class="onApply">접수중</span></c:if><c:if test="${lecturevo.class_status==0 }"><span class="onWait">대기접수</span></c:if><c:if test="${lecturevo.class_status==2 }"><span class="closeApply">접수마감</span></c:if><span class="detailAge">${lecturevo.cate_code}강좌</span><span class="detailCat">${lecturevo.cate_name}</span>
									</div>								
									<div class="lecTitleDIV">
										<span id="lecTitle">${lecturevo.class_title}</span>
									</div>
									<div id="lecDetailInfo">
										<span class="detailInfoSpan">${lecturevo.teacher_name}</span>&nbsp;&nbsp;
										<span class="detailInfoSpan">${lecturevo.class_semester}</span>&nbsp;&nbsp;
										<span class="detailInfoSpan">(${lecturevo.class_day})&nbsp;&nbsp;${lecturevo.class_time}</span><br/>
										<span style="color: black; font-size: 11pt;"><fmt:formatNumber value="${lecturevo.class_fee}" pattern="###,###" />&nbsp;원</span>&nbsp;&nbsp;<span class="detailInfoSpan">(총 4회)</span>
									</div>
								</div>
							</div>	
							</a>	
						</li>
					</c:forEach>			
				</ul>

			</div>
			<div class="pagination">
				${pageBar}
			</div>
		</div>
	
	</div>
</div>