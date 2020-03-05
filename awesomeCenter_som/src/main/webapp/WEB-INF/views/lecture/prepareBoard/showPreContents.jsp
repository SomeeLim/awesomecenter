<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/lectureDetail.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$(".replyTR").hide();
		$(".editTR").hide();
		
		/* 
		// 엔터시 댓글 등록
		$("#commnetIn").keydown(function(event) {
			if(event.keyCode == 13){
				event.preventDefault();
				writeComments();
			}
		});
		
		// 엔터시 답글 등록
		$("#commnetReplyIn").keydown(function(event) {
			if(event.keyCode == 13){
				event.preventDefault();
				writeReplyComment();
			}
		});
		
		// 엔터시 수정
		$("#commnetEditIn").keydown(function(event) {
			if(event.keyCode == 13){
				event.preventDefault();
				editReplyComment();
			}
		}); */
		
	});
	
	function openIngPop() {
		
		window.open("<%=ctxPath%>/imgPopUP.to?preFileName=${preboardvo.preFileName}", "${preboardvo.preFileName}", "scrollbars=yes,width=417,height=385,top=10,left=20");
		
	}
	
	function deletePre() {
		
		var deleteWrite = new Array();
		
		deleteWrite.push( '${preboardvo.preSeq}' );
		
		var data = {"deleteWrite":deleteWrite};
		
		$.ajax({
			
			url:"<%=ctxPath%>/deletePreBoard.to",
			data:data,
			dataType:"JSON",
			success:function(json){
				
				alert(json.msg);
				
				location.href = "<%=ctxPath%>/prepareBoard.to?class_seq=${lecturevo.class_seq}";
				
			},
			
			error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
		});
		
	}
	
	function modifyPre() {
		
		javascript:location.href="<%=ctxPath%>/editPre.to?class_seq=${lecturevo.class_seq}&preSeq=${preboardvo.preSeq}";
		
	}
	
	// 댓글 작성하기
	function writeComments() {
		
		var commnetIn = $("#commnetIn").val();
		
		if(commnetIn == null || commnetIn == "") {
			alert("내용을 입력하세요");
			return;
		}
		
		var secretChk = $("input[name=secretChk]").is(":checked");
		var secret = "";
		if(secretChk == true) {
			secret = "1";
		}
		else {
			secret = "0";
		}

		
		$.ajax({
			
			url:"<%=ctxPath%>/writePreComment.to",
			data:{"fk_class_seq":'${lecturevo.class_seq}',"fk_preSeq":'${preboardvo.preSeq}',
				  "preComContent":commnetIn,"secret":secret },
			dataType:"JSON",
			success:function(json){
				
				javascript:history.go(0);
				
				
			},
			
			error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
		});
		
	}
	
	function writeReply(num, secret) {
		
		// 답글 입력창 꺼내기
		if($("#reply"+num).css("display") == "none"){
			$("#reply"+num).show();
		}
		else {
			$("#reply"+num).hide();
		}
		
		// 원글 비밀글이면 비밀글로 보내기
		if(secret == '1') {
			$("input[name=secretReChk]").prop("checked", true);
		} 
		else if(secret == '0') {
			$("input[name=secretReChk]").prop("checked", false);
		} 	
		
		$("#commnetReplyIn").val("");
		
	}
	
	function writeReplyComment(num, preComSeq, preComGroupno, fk_preComseq, preComdepthno) {
		
		var commnetIn = $("#reply"+num).find("#commnetReplyIn").val();
		
		if(commnetIn == null || commnetIn == "") {
			alert("내용을 입력하세요");
			return;
		}
		
		var secretChk = $("input[name=secretReChk]").is(":checked");
		var secret = "";
		if(secretChk == true) {
			secret = "1";
		}
		else {
			secret = "0";
		}
		
		
		
		$.ajax({
			
			url:"<%=ctxPath%>/writePreReply.to",
			data:{"fk_class_seq":'${lecturevo.class_seq}',"fk_preSeq":'${preboardvo.preSeq}',
				  "preComContent":commnetIn,"secret":secret, "preComGroupno":preComGroupno, 
				  "fk_preComseq":fk_preComseq, "preComdepthno":preComdepthno, "preComSeq":preComSeq},
			dataType:"JSON",
			success:function(json){
				
				javascript:history.go(0);
				
				
			},
			
			error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
		});
		
	}
	
	function simpleLock(preComSeq, secret) {
		
		$.ajax({
			
			url:"<%=ctxPath%>/simpleLock.to",
			data:{"fk_class_seq":'${lecturevo.class_seq}',"fk_preSeq":'${preboardvo.preSeq}',
				  "preComSeq":preComSeq, "secret":secret},
			dataType:"JSON",
			success:function(json){
				
				javascript:history.go(0);
				
				
			},
			
			error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
		});
		
		
	}
	
	function editReply(num, secret) {
		
		// 답글 입력창 꺼내기
		if($("#edit"+num).css("display") == "none"){
			$("#edit"+num).show();
		}
		else {
			$("#edit"+num).hide();
		}
		
		// 원글 비밀글이면 비밀글로 보내기
		if(secret == '1') {
			$("input[name=secretEdChk]").prop("checked", true);
		} 
		else if(secret == '0') {
			$("input[name=secretEdChk]").prop("checked", false);
		} 	
		
	}
	
	function editReplyComment(num,preComSeq, preComGroupno, fk_preComseq, preComdepthno) {
		
		var commnetIn = $("#edit"+num).find("#commnetEditIn").val();
		
		if(commnetIn == null || commnetIn == "") {
			alert("내용을 입력하세요");
			return;
		}
		
		var secretChk = $("input[name=secretEdChk]").is(":checked");
		var secret = "";
		if(secretChk == true) {
			secret = "1";
		}
		else {
			secret = "0";
		}
		
		
		
		$.ajax({
			
			url:"<%=ctxPath%>/editPreReply.to",
			data:{"fk_class_seq":'${lecturevo.class_seq}',"fk_preSeq":'${preboardvo.preSeq}',
				  "preComContent":commnetIn,"secret":secret, "preComGroupno":preComGroupno, 
				  "fk_preComseq":fk_preComseq, "preComdepthno":preComdepthno, "preComSeq":preComSeq},
			dataType:"JSON",
			success:function(json){
				
				javascript:history.go(0);
				$("#commnetEditIn").val("");
				
			},
			
			error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
		});
		
	}

	function deleteReply(preComSeq, preComdepthno,fk_preSeq) {
		
		$.ajax({
			
			url:"<%=ctxPath%>/deletePreReply.to",
			data:{"preComSeq":preComSeq,"preComdepthno":preComdepthno,"preSeq":fk_preSeq},
			dataType:"JSON",
			success:function(json){
				
				javascript:history.go(0);
				
			},
			
			error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
		});
		
	}
	
	
</script>
	
<body id="lectureDetail_body">


	<div id="lectureDetailContainer">
	
		<div id = "pay_nvar" align="right" style = "margin: 40px 0;">
		   <div><i class = "fa fa-home"></i></div>
		   <div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">수강신청</div>
		   <div>수강결제</div>
		</div>
		
		<span id="onApply">
			${lecturevo.class_semester}
		</span>
		<span class="ageCategory">
			${lecturevo.cate_code}강좌
		</span>
		<span id="classCategory">
			${lecturevo.cate_name}
		</span>
		
		<div id="lecDetailTitleDIV" style="width: 1200px;">
			<h1 id='lectureDetailTitle' style='display: inline-block;'>${lecturevo.class_title }</h1>
		</div>

		<div id="lectureDetailContent" style="margin-bottom: 20px;">
			&nbsp;&nbsp;&nbsp;<h2 style="word-spacing: -10px; margin-left: 120px;">수업자료</h2>
			<div id="preapareContentsTable">
				<table>
					<thead>
						<tr>
							<td style="background-color: rgb(244,244,244); width: 15%;">강사명</td>
							<td>${lecturevo.teacher_name}</td>
							<td style="background-color: rgb(244,244,244); width: 15%;">수강기간</td>
							<td>${lecturevo.class_startDate}&nbsp;~&nbsp;${lecturevo.class_endDate}</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="background-color: rgb(244,244,244); padding: 15px 0;">제목</td>
							<td colspan="3" style="padding: 15px 0; text-align: left; padding-left: 15px;">${preboardvo.preTitle}</td>
						</tr>
						
							
							
						<c:if test="${not empty preboardvo.preFileName}">
							<tr>
								<td style="background-color: rgb(244,244,244);">
									첨부파일
								</td>
								<td colspan="3" style="text-align: left; padding-left: 15px;">
								<img id="uploadImg" src="resources/files/${preboardvo.preFileName}" style="max-width: 400px; max-height: 300px; cursor: pointer;" onclick="openIngPop()" />
								</td>
							</tr>
						</c:if> 
							
						
						<tr>
							<td style="background-color: rgb(244,244,244);">내용</td>
							<td colspan="3" style="text-align: left; padding-left: 15px;">${preboardvo.preContent}</td>
						</tr>	
						<tr>
							<td style="background-color: rgb(244,244,244);">작성일자</td>
							<td colspan="3" style="text-align: left; padding-left: 15px;">${preboardvo.preWriteDate}</td>
						</tr>		
						<tr style="border: none;">
							<td colspan="3" style="border: none; text-align: left; padding-top: 40px;">
								<c:if test="${sessionScope.loginuser.userid == 'adminta' }">
									<span id="modifyWrite" onclick="modifyPre()">수정</span>
									&nbsp;
									<span id="deleteWrite" onclick="deletePre();">삭제</span>
								</c:if>
							</td>
							<td style="border: none; text-align: right; padding-top: 40px;">
								<a href='<%=ctxPath%>/prepareBoard.to?class_seq=${lecturevo.class_seq}'><span id="goToList">목록으로</span></a>
							</td> 
						</tr>		
					</tbody>
				</table>				
			</div>
			<div id="preapareCommentsTable">
				&nbsp;&nbsp;&nbsp;<h2 style="word-spacing: -10px; margin-left: 90px; text-align: left;">COMMENTS<span style="margin-left: 3px;">(${preboardvo.preCommentCount})</span></h2>
				<div align="center">
					<table style="margin-left: 50px;"> 
						<c:if test="${empty commentList}">
						
						</c:if>
						<c:if test="${not empty commentList}">
							<c:forEach var="precommentvo" items="${commentList}" varStatus="num">
								<tr>
									<td style="text-align: center; padding-top: 15px;">
									<c:if test="${precommentvo.preComStatus == 0 }">
											
									</c:if>
									<%-- 비밀댓글일 경우 : 작성자 --%>
									<c:if test="${precommentvo.preComStatus == 1 }">
										<c:if test="${precommentvo.preComSecret == 1}">
											<%-- 비밀댓글일 경우 : 작성자 (관리자) >> 모든 작성자의 이름을 볼 수 있다. --%>
											<c:if test="${sessionScope.loginuser.userid == 'adminta'}">
												<c:if test="${precommentvo.fk_USERNO == '53'}">
													${lecturevo.teacher_name}
												</c:if>
												<c:if test="${precommentvo.fk_USERNO != '53'}">
													<c:set var="TextValue" value="${precommentvo.username}"/>
													<c:out value="${fn:substring(TextValue,0,1) }" />
													* 
													<c:out value="${fn:substring(TextValue,2,3) }" />
												</c:if>
											</c:if>
											<%-- 비밀댓글일 경우 : 작성자 (일반회원) >> 내 글과 댓글만 볼 수 있다. --%>
											<c:if test="${sessionScope.loginuser.userid != 'adminta'}">
												<%-- 1. 일반글인 경우 --%>
												<c:if test="${precommentvo.preComdepthno == 0 }">
													<%-- 내가 쓴 글이라면! --%>
													<c:if test="${sessionScope.loginuser.userno == precommentvo.fk_USERNO}">
														<c:set var="TextValue" value="${precommentvo.username}"/>
														<c:out value="${fn:substring(TextValue,0,1) }" />
														* 
														<c:out value="${fn:substring(TextValue,2,3) }" />
													</c:if>
													
													<%-- 남이 쓴 글이라면! --%>
													<c:if test="${sessionScope.loginuser.userno != precommentvo.fk_USERNO}">
														익명
													</c:if>
												</c:if>
												<%-- 2. 댓글인 경우 --%>
												<c:if test="${precommentvo.preComdepthno == 1 }">
													<%-- 내가 쓴 비밀 댓글 --%>
													<c:if test="${sessionScope.loginuser.userno == precommentvo.fk_USERNO}">
														<c:set var="TextValue" value="${precommentvo.username}"/>
														<c:out value="${fn:substring(TextValue,0,1) }" />
														* 
														<c:out value="${fn:substring(TextValue,2,3) }" />
													</c:if>
													<c:if test="${sessionScope.loginuser.userno == precommentvo.orginuserno && sessionScope.loginuser.userno != precommentvo.fk_USERNO}">
														<c:set var="TextValue" value="${precommentvo.username}"/>
														<c:out value="${fn:substring(TextValue,0,1) }" />
														* 
														<c:out value="${fn:substring(TextValue,2,3) }" />
													</c:if>
													<c:if test="${sessionScope.loginuser.userno != precommentvo.orginuserno && sessionScope.loginuser.userno != precommentvo.fk_USERNO}">
														익명
													</c:if>
												</c:if>
											</c:if>
										</c:if>
										<%-- 비밀댓글이 아닌 경우 --%>
										<c:if test="${precommentvo.preComSecret == 0}">
											<c:if test="${precommentvo.fk_USERNO == '53'}">
												${lecturevo.teacher_name}
											</c:if>
											<c:if test="${precommentvo.fk_USERNO != '53'}">
												<c:set var="TextValue" value="${precommentvo.username}"/>
												<c:out value="${fn:substring(TextValue,0,1) }" />
												*
												<c:out value="${fn:substring(TextValue,2,3) }" />
											</c:if>
										</c:if>
									</c:if>
									</td>  
									<td style="text-align: left; padding-left: 72px; max-width: 650px; padding-top: 15px;">
									<%-- 답댓글일 경우 : 답변이미지 추가 --%>
									<c:if test="${precommentvo.preComStatus == 0 }">
										삭제된 댓글입니다	
									</c:if>	
									<c:if test="${precommentvo.preComStatus == 1 }">
										<c:if test="${precommentvo.preComdepthno == 1}">
											&nbsp;<img src="resources/images/prepare_reply.png" width="20px;" height="20px;" />
										</c:if>
										
										<%-- 비밀댓글일 경우 : 글내용 --%>
										<c:if test="${precommentvo.preComSecret == 1}">
											<%-- 비밀댓글일 경우 : 글내용 >> 관리자 (모든 글내용을 볼 수 있다.) --%>
											<c:if test="${sessionScope.loginuser.userid == 'adminta'}">
												${precommentvo.preComContent}
												&nbsp;&nbsp;
												<img src="resources/images/prepare_locl.png" onclick="simpleLock('${precommentvo.preComSeq}','${precommentvo.preComSecret }');" style="cursor: pointer; width: 15px; height: 20px;" />
												&nbsp;
												<span style="font-size: 9pt; color:rgb(227, 117, 94);">비밀글입니다.</span>
											</c:if>
											<%-- 비밀댓글일 경우 : 글내용 (일반회원) >> 내 글과 댓글만 볼 수 있다. --%>
											<c:if test="${sessionScope.loginuser.userid != 'adminta'}">
												<%-- 1. 일반글인 경우 --%>
												<c:if test="${precommentvo.preComdepthno == 0 }">
													<%-- 내가 쓴 글이라면! --%>
													<c:if test="${sessionScope.loginuser.userno == precommentvo.fk_USERNO}">
														${precommentvo.preComContent}
														&nbsp;&nbsp;
														<img src="resources/images/prepare_locl.png" onclick="simpleLock('${precommentvo.preComSeq}','${precommentvo.preComSecret }');"  style="cursor: pointer; width: 15px; height: 20px;" />
														&nbsp;
														<span style="font-size: 9pt; color:rgb(227, 117, 94);">비밀글입니다.</span>
													</c:if>
													
													<%-- 남이 쓴 글이라면! --%>
													<c:if test="${sessionScope.loginuser.userno != precommentvo.fk_USERNO}">
														비밀글입니다
													</c:if>
												</c:if>
												<%-- 2. 댓글인 경우 --%>
												<c:if test="${precommentvo.preComdepthno == 1 }">
													<%-- 내가 쓴 비밀 댓글 --%>
													<c:if test="${sessionScope.loginuser.userno == precommentvo.fk_USERNO}">
														${precommentvo.preComContent}
														&nbsp;&nbsp;
														<img src="resources/images/prepare_locl.png" onclick="simpleLock('${precommentvo.preComSeq}','${precommentvo.preComSecret }');" style="cursor: pointer; width: 15px; height: 20px;" />
														&nbsp;
														<span style="font-size: 9pt; color:rgb(227, 117, 94);">비밀글입니다.</span>
													</c:if>
													<c:if test="${sessionScope.loginuser.userno == precommentvo.orginuserno && sessionScope.loginuser.userno != precommentvo.fk_USERNO}">
														${precommentvo.preComContent}
														&nbsp;&nbsp;
														<span style="font-size: 9pt; color:rgb(227, 117, 94);">비밀글입니다.</span>
													</c:if>
													<c:if test="${sessionScope.loginuser.userno != precommentvo.orginuserno && sessionScope.loginuser.userno != precommentvo.fk_USERNO}">
														비밀글입니다
													</c:if>
												</c:if>
											</c:if>
										</c:if>
											
										<%-- 공개댓글일 경우 : 글내용 --%>
										<c:if test="${precommentvo.preComSecret == 0}">
											${precommentvo.preComContent}
											<c:if test="${sessionScope.loginuser.userno == precommentvo.fk_USERNO}">
												&nbsp;&nbsp;
												<img src="resources/images/prepare_locl.png" onclick="simpleLock('${precommentvo.preComSeq}','${precommentvo.preComSecret }');" style="cursor: pointer; width: 15px; height: 20px;" />
											</c:if>
										</c:if>
										<br/>
										<c:if test="${precommentvo.preComdepthno == 1}">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</c:if>
										<span style="font-size: 9pt; color:rgb(179,179,179);">${precommentvo.preComWriteDate}</span>
									</c:if>	
									</td>
									<%-- 답글수정삭제버튼 --%>
									<td style="padding-left: 18px; padding-top: 15px;">
									<c:if test="${precommentvo.preComStatus == 0 }">
											
									</c:if>
									<c:if test="${precommentvo.preComStatus == 1 }">
										<%-- 비밀댓글일 경우 : 작성자 --%>
										<c:if test="${precommentvo.preComSecret == 1}">
											<%-- 비밀댓글일 경우 : 작성자 (관리자) >> 모든 작성자의 이름을 볼 수 있다. --%>
											<c:if test="${sessionScope.loginuser.userid == 'adminta'}">
												<%-- 관리자는 모든 회원의 답글과 삭제가 가능하지만 수정은 불가능하다 --%>
												<c:if test="${precommentvo.fk_USERNO == '53'}"> <%-- 관리자댓글 --%>
													<span style="cursor: pointer;" onclick="writeReply('${num.index}','${precommentvo.preComSecret}');">답글</span>
													&nbsp;
													<span style="cursor: pointer;" onclick="editReply('${num.index}','${precommentvo.preComSecret}');">수정</span>
													&nbsp;
													<span style="cursor: pointer;" onclick="deleteReply('${precommentvo.preComSeq}','${precommentvo.preComdepthno}','${precommentvo.fk_preSeq}');">삭제</span>
												</c:if>
												<c:if test="${precommentvo.fk_USERNO != '53'}"> <%-- 다른사람댓글 --%>
													<span style="cursor: pointer; padding-left: 42px;" onclick="deleteReply('${precommentvo.preComSeq}','${precommentvo.preComdepthno}','${precommentvo.fk_preSeq}');">삭제</span>
												</c:if>
											</c:if>
											<%-- 비밀댓글일 경우 : 작성자 (일반회원) >> 내 글과 댓글만 볼 수 있다. --%>
											<c:if test="${sessionScope.loginuser.userid != 'adminta'}">
												<%-- 1. 일반글인 경우 --%>
												<c:if test="${precommentvo.preComdepthno == 0 }">
													<%-- 내가 쓴 글이라면! --%>
													<c:if test="${sessionScope.loginuser.userno == precommentvo.fk_USERNO}">
														<span style="cursor: pointer;" onclick="writeReply('${num.index}','${precommentvo.preComSecret}');">답글</span>
														&nbsp;
														<span style="cursor: pointer;" onclick="editReply('${num.index}','${precommentvo.preComSecret}');">수정</span>
														&nbsp;
														<span style="cursor: pointer;" onclick="deleteReply('${precommentvo.preComSeq}','${precommentvo.preComdepthno}','${precommentvo.fk_preSeq}');">삭제</span>
													</c:if>
													
													<%-- 남이 쓴 글이라면! --%>
													<c:if test="${sessionScope.loginuser.userno != precommentvo.fk_USERNO}">
														
													</c:if>
												</c:if>
												<%-- 2. 댓글인 경우 --%>
												<c:if test="${precommentvo.preComdepthno == 1 }">
													<%-- 내가 쓴 비밀 댓글 --%>
													<c:if test="${sessionScope.loginuser.userno == precommentvo.fk_USERNO}">
														<span style="cursor: pointer; padding-left: 25px;" onclick="editReply('${num.index}','${precommentvo.preComSecret}');">수정</span>
														&nbsp;
														<span style="cursor: pointer;" onclick="deleteReply('${precommentvo.preComSeq}','${precommentvo.preComdepthno}','${precommentvo.fk_preSeq}')">삭제</span>
													</c:if>
													<c:if test="${sessionScope.loginuser.userno == precommentvo.orginuserno && sessionScope.loginuser.userno != precommentvo.fk_USERNO}">
													</c:if>
													<c:if test="${sessionScope.loginuser.userno != precommentvo.orginuserno && sessionScope.loginuser.userno != precommentvo.fk_USERNO}">
														
													</c:if>
												</c:if>
											</c:if>
										</c:if>
										<%-- 비밀댓글이 아닌 경우 --%>
										<c:if test="${precommentvo.preComSecret == 0}">
											<c:if test="${sessionScope.loginuser.userid == 'adminta'}">
												<%-- 관리자는 모든 회원의 답글과 삭제가 가능하지만 수정은 불가능하다 --%>
												<c:if test="${precommentvo.fk_USERNO == '53'}"> <%-- 관리자댓글 --%>
													<c:if test="${precommentvo.preComdepthno == 0}">
														<span style="cursor: pointer;" onclick="writeReply('${num.index}','${precommentvo.preComSecret}');">답글</span>
														&nbsp;
														<span style="cursor: pointer;" onclick="editReply('${num.index}','${precommentvo.preComSecret}');">수정</span>
														&nbsp;
														<span style="cursor: pointer;" onclick="deleteReply('${precommentvo.preComSeq}','${precommentvo.preComdepthno}','${precommentvo.fk_preSeq}')">삭제</span>
													</c:if>
													<c:if test="${precommentvo.preComdepthno == 1 }">
														<span style="cursor: pointer; padding-left: 25px;" onclick="editReply('${num.index}','${precommentvo.preComSecret}');">수정</span>
														&nbsp;
														<span style="cursor: pointer;" onclick="deleteReply('${precommentvo.preComSeq}','${precommentvo.preComdepthno}','${precommentvo.fk_preSeq}')">삭제</span>
													</c:if>
												</c:if>
												<c:if test="${precommentvo.fk_USERNO != '53'}"> <%-- 다른사람댓글 --%>
													<c:if test="${precommentvo.preComdepthno == 0}">
														<span style="cursor: pointer; padding-left: 25px;" onclick="writeReply('${num.index}','${precommentvo.preComSecret}');">답글</span>
														&nbsp;
														<span style="cursor: pointer;" onclick="deleteReply('${precommentvo.preComSeq}','${precommentvo.preComdepthno}','${precommentvo.fk_preSeq}')">삭제</span>
													</c:if>
													<c:if test="${precommentvo.preComdepthno == 1 }">
														<span style="cursor: pointer; padding-left: 42px;" onclick="deleteReply('${precommentvo.preComSeq}','${precommentvo.preComdepthno}','${precommentvo.fk_preSeq}')">삭제</span>
													</c:if>
												</c:if>
											</c:if>
											<c:if test="${sessionScope.loginuser.userid != 'adminta'}">
												<c:if test="${precommentvo.fk_USERNO == sessionScope.loginuser.userno }">
													<c:if test="${precommentvo.preComdepthno == 0}">
														<span style="cursor: pointer;" onclick="writeReply('${num.index}','${precommentvo.preComSecret}');">답글</span>
														&nbsp;
														<span style="cursor: pointer;" onclick="editReply('${num.index}','${precommentvo.preComSecret}');">수정</span>
														&nbsp;
														<span style="cursor: pointer;" onclick="deleteReply('${precommentvo.preComSeq}','${precommentvo.preComdepthno}','${precommentvo.fk_preSeq}')">삭제</span>
													</c:if>
													<c:if test="${precommentvo.preComdepthno == 1 }">
														<span style="cursor: pointer; padding-left: 25px;" onclick="editReply('${num.index}','${precommentvo.preComSecret}');">수정</span>
														&nbsp;
														<span style="cursor: pointer;" onclick="deleteReply('${precommentvo.preComSeq}','${precommentvo.preComdepthno}','${precommentvo.fk_preSeq}')">삭제</span>
													</c:if>
												</c:if>
												<c:if test="${precommentvo.fk_USERNO != sessionScope.loginuser.userno }">
													<c:if test="${precommentvo.preComdepthno == 0}">
														<span style="cursor: pointer; padding-left: 42px;" onclick="writeReply('${num.index}','${precommentvo.preComSecret}');">답글</span>
													</c:if>
												</c:if>
											</c:if>
										</c:if>
											
									</c:if>	
									</td>
								</tr>
								<tr class="replyTR" id="reply${num.index}" style="display: none;">
									<td style="margin-left: 30px;">답글</td>
									<td >
										<textarea id="commnetReplyIn" cols="100" rows="2" placeholder="답글을 입력해 주세요" style="margin-top: 30px; margin-left: 50px;"></textarea>
										<br/>
										<div style="text-align: right; padding-right: 30px;">
											<span style="font-size: 9pt; color:rgb(179,179,179);">비밀글</span>&nbsp;<input name="secretReChk" type="checkbox" />
										</div>
									</td>
									<td style="cursor: pointer; padding-top: 29px;" onclick="writeReplyComment('${num.index}','${precommentvo.preComSeq}','${precommentvo.preComGroupno}','${precommentvo.fk_preComseq}','${precommentvo.preComdepthno}');"> 
										<span style="border: solid 1px rgb(187,187,187); padding: 25px 40px;">입력</span>
									</td>
								</tr>
								<tr class="editTR" id="edit${num.index}" style="display: none;">
									<td style="margin-left: 30px;">수정</td>
									<td >
										<textarea id="commnetEditIn" cols="100" rows="2" style="margin-top: 30px; margin-left: 50px;">${precommentvo.preComContent }</textarea>
										<br/>
										<div style="text-align: right; padding-right: 30px;">
											<span style="font-size: 9pt; color:rgb(179,179,179);">비밀글</span>&nbsp;<input name="secretEdChk" type="checkbox" />
										</div>
									</td>
									<td style="cursor: pointer; padding-top: 29px;" onclick="editReplyComment('${num.index}','${precommentvo.preComSeq}','${precommentvo.preComGroupno}','${precommentvo.fk_preComseq}','${precommentvo.preComdepthno}');"> 
										<span style="border: solid 1px rgb(187,187,187); padding: 25px 40px;">입력</span>
									</td>
								</tr>
								
							</c:forEach>
						</c:if>
						
						<tr style="text-align: center;">
							<td>
							</td>
							<td>
								<textarea id="commnetIn" cols="100" rows="2" placeholder="댓글을 입력해 주세요" style="margin-top: 30px; margin-left: 30px;"></textarea>
								<br/>
								<div style="text-align: right; padding-right: 30px;">
									<span style="font-size: 9pt; color:rgb(179,179,179);">비밀글</span>&nbsp;<input name="secretChk" type="checkbox" />
								</div>
							</td>
							<td style="cursor: pointer; padding-top: 29px;" onclick="writeComments();"> 
								<span style="border: solid 1px rgb(187,187,187); padding: 25px 40px;">입력</span>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>	
	
	
		
</body>
