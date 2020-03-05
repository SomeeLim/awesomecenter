<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/lectureDetail.css" />
 <script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("#subject").focus();
		
		<%-- === #153. 스마트에디터 구현 시작 === --%> 
		//전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
	        sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        }
	    });
	    <%-- === 스마트에디터 구현 끝 === --%> 
	    
		//쓰기버튼
		$("#btnWrite").click(function(){
			
			<%-- === 스마트에디터 구현 시작 === --%> 
			//id가 content인 textarea에 에디터에서 대입
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); 
	        <%-- === 스마트에디터 구현 끝 === --%> 
			
			// 글제목 유효성 검사
			var subjectval = $("#subject").val().trim();
			if(subjectval == "") {
				alert("글제목을 입력하세요!!");
				return;
			}
			
		/* 
		    // 글내용 유효성 검사
			var contentval = $("#content").val().trim();
			if(contentval == "") {
				alert("글내용을 입력하세요!!");
				return;
			} 
		*/
		
		<%-- === 스마트에디터 구현 시작 === --%>
		//스마트에디터 사용시 무의미하게 생기는 p태그 제거
        var contentval = $("#content").val();
	        
        // === 확인용 ===
        // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
        // "<p>&nbsp;</p>" 이라고 나온다.
        
        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
        // 글내용 유효성 검사 
        if(contentval == "" || contentval == "<p>&nbsp;</p>") {
        	alert("글내용을 입력하세요!!");
        	return;
        }
        
        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
        contentval = $("#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
    	/*    
              대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
        ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
                     그리고 뒤의 gi는 다음을 의미합니다.

        	g : 전체 모든 문자열을 변경 global
        	i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
    	*/    
        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환 
        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
    
        $("#content").val(contentval);
	 	<%-- === 스마트에디터 구현 끝 === --%>
	 	
	 	// 폼을 submit
		var frm = document.prepareFrm;
		frm.method = "POST"; // 파일을 첨부할 경우이라면 반드시 POST 이어야만 가능하다. GET이라면 파일첨부가 안되어진다.
		frm.action = "<%= ctxPath%>/editPreEnd.to";
		frm.submit();

		});
		
	});
	
	
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
			<div id="writeTable">
				<form name="prepareFrm" enctype="multipart/form-data">
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
								<td colspan="3" style="padding: 15px 0; text-align: justify; padding-left: 15px;"><input id="subject" name="preTitle" type="text" size="100" value="${preboardvo.preTitle}" /></td>
							</tr>
							<tr>
								<td style="background-color: rgb(244,244,244);">내용</td>
								<td colspan="3" style="text-align: justify; padding-left: 15px;"><textarea id="content" name="preContent" cols="104" rows="12" >${preboardvo.preContent}</textarea></td>
							</tr>
							<tr>
								<td style="background-color: rgb(244,244,244);">기존 첨부파일</td>
								<td colspan="3" style="text-align: left; padding-left: 15px;"><span>기존 첨부파일 ${preboardvo.preOrgFilename}</span></td>
							</tr>
							<tr>
								<td style="background-color: rgb(244,244,244);">첨부파일 수정</td>
								<td colspan="3" style="text-align: left; padding-left: 15px;"><input type="file" name="attach" /></td>
							</tr>
							<tr style="border: none;">
								<td colspan="4" style="border: none; padding: 50px 0;"><span class="writeBtn" id="btnWrite">수정</span>
								&nbsp;&nbsp;&nbsp;
								<span class="writeBtn" onclick="javascript:history.back();">취소</span></td>
							</tr>
						</tbody>
					</table>
					<input type="hidden" name="fk_class_seq" value="${lecturevo.class_seq}" />
					<input type="hidden" name="preSeq" value="${preboardvo.preSeq}" />
				</form>
			</div>
		</div>
	</div>	
		
</body>
