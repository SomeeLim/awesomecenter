<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/lectureDetail.css" />

<script type="text/javascript">

	$(document).ready(function(){
		
		// ~~~ 체크박스 ~~~
		
		
		$("#checkall").click(function(){
	        //클릭되었으면
	        if($("#checkall").prop("checked")){
	            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
	            $("input[name=check]").prop("checked",true);
	            //클릭이 안되있으면
	        }else{
	            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
	            $("input[name=check]").prop("checked",false);
	        }
	    })
	    
	    $("input:checkbox[name=check]").click(function() {
			
	    	 $('input:checkbox[name="check"]').each(function() {

	    	      if(!$(this).prop("checked")) {
	    	    	  $("#checkall").prop("checked",false);
	    	      }

	    	 });

		});
		
		// 검색어 유지하기...
		
		var searchType = '${searchType}';
		var searchWord = '${searchWord}';
		
		if(searchType != null || searchType != "") {
			$("select[name=searchType]").val(searchType);
		}
		
		if(searchWord != null || searchWord != "") {
			$("input[name=searchWord]").val(searchWord);
		}
		
		// 엔터시 검색
		$("input[name=searchWord]").keydown(function(event) {
			if(event.keyCode == 13){
				event.preventDefault();
				searchPre();
			}
		});
	
		
	});
	
	function deletePreBoard() {
		
		var deleteWrite = new Array();
		
		$("input:checkbox[name=check]:checked").each(function() {
				
			deleteWrite.push(	$(this).val() );
			
		});
			
		for(var i in deleteWrite) {
			console.log(i+"."+deleteWrite[i]);
		}
		
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
	
	function searchPre() {
		
		var frm = document.preSearchFrm;
		frm.action = "<%= ctxPath %>/prepareBoard.to";
		frm.submit();
		
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
			<div id="preapareTable">
				<table>
					<thead>
						<tr style="border: none;">
							<td colspan="3"  style=" width:65%; text-align: left; border: none;">
								<form name="preSearchFrm"> 
									<select name="searchType" id="searchType" style="height: 28px;">
										<option value="">전체보기</option>
										<option value="preTitle">글제목</option>
										<option value="preContent">글내용</option>
									</select>
									&nbsp;
									<input type="text" name="searchWord" placeholder=" 검색어를 입력하세요" />
									&nbsp;
									<span id="searchPre" onclick="searchPre()">검색</span>
									<input type="hidden" name="class_seq" value="${lecturevo.class_seq}" />
								</form>
							</td>
							
							<td colspan="2" style="width:30%;border: none; text-align: right;">
								<c:if test="${sessionScope.loginuser.userid == 'adminta' }">
									<a href='<%=ctxPath%>/writePrepare.to?class_seq=${lecturevo.class_seq}'><span id="writePre">글쓰기</span></a>
									&nbsp;
									<span id="deletePre" onclick="deletePreBoard();">삭제</span>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="background-color: rgb(244,244,244);">강사명</td>
							<td>${lecturevo.teacher_name}</td>
							<td style="background-color: rgb(244,244,244);">강의기간</td>
							<td>${lecturevo.class_startDate}&nbsp;~&nbsp;${lecturevo.class_endDate}</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 5%; background-color: rgb(244,244,244);"><input type="checkbox" id="checkall" /></td>
							<td style="width: 10%; background-color: rgb(244,244,244);">글번호</td>
							<td style="width: 45%;">글제목</td>
							<td style="width: 15%;">작성자</td>
							<td style="width: 20%;">작성일자</td>
						</tr>
						<c:if test="${empty preboardList}">
							<tr>
								<td style="text-align: center; padding: 10px 0;" colspan="5"> 
									게시글이 존재하지 않습니다.
								</td>
							</tr>
						</c:if>
						<c:if test="${not empty preboardList}">
							<c:forEach var="pre" items="${preboardList}">
								<tr>
									<td style="width: 5%; background-color: rgb(244,244,244);"><input type="checkbox" name="check" value="${pre.preSeq}" /></td>
									<td style="width: 10%; background-color: rgb(244,244,244);">${pre.rno}</td>
									<td style="width: 45%; cursor: pointer;"><a href='<%=ctxPath%>/showPreContents.to?class_seq=${lecturevo.class_seq}&preSeq=${pre.preSeq}'>${pre.preTitle}&nbsp;<span style='color:rgb(157,157,157)'>[${pre.preCommentCount}]</span></a></td>
									<td style="width: 15%;">${pre.teacher_name}</td>
									<td style="width: 20%;">${pre.preWriteDate }</td>
								</tr>
							</c:forEach>
						</c:if>
						
						
						<tr style="border: none;">
							<td style="border: none; text-align: right;"></td>
							<td colspan="3" style="border: none;"> 
								<c:if test="${not empty preboardList}">
									${pageBar} 
								</c:if> 
							</td>
							<td style="border: none; text-align: right;"><a href='<%=ctxPath%>/lectureDetail.to?class_seq=${lecturevo.class_seq}'><span id="detailLec">강좌상세</span></a></td>
						</tr> 
					</tbody>
				</table>
			</div>
		</div>
	</div>	
		
</body>
