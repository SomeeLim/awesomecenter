<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/cart.css" />

<script type="text/javascript">

	$(document).ready(function() {
		
		$("#checkall").prop("checked",true);
		$("input[name=check]").prop("checked",true);
		
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
	    
		
	});
	
	function deleteCart() {
		
		var deleteLecture = new Array();
		
		$("input:checkbox[name=check]:checked").each(function() {
				
			deleteLecture.push(	$(this).val() );
			
		});
			
		for(var i in deleteLecture) {
			console.log(i+"."+deleteLecture[i]);
		}
		
		var data = {"deleteLecture":deleteLecture};
		
		$.ajax({
			
			url:"<%=ctxPath%>/deleteCart.to",
			data:data,
			dataType:"JSON",
			success:function(json){
				
				alert(json.msg);
				
				location.href = "<%=ctxPath%>/cart.to";
				
			},
			
			error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
		});
		
	}
	
	function deleteAllCart() {
		
		var deleteLecture = new Array();
		
		$("input:checkbox[name=check]").each(function() {
				
			deleteLecture.push(	$(this).val() );
			
		});
		
		for(var i in deleteLecture) {
			console.log(i+"."+deleteLecture[i]);
		}
		
		var data = {"deleteLecture":deleteLecture};
		
		$.ajax({
			
			url:"<%=ctxPath%>/deleteCart.to",
			data:data,
			dataType:"JSON",
			success:function(json){
				
				alert(json.msg);
				
				location.href = "<%=ctxPath%>/cart.to";
				
			},
			
			error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
		});
		
	}
	
	function goPayment() {
		
		var deleteLecture = new Array();
		
		$("input[name=check]:checked").each(function() {
				
			deleteLecture.push(	$(this).val() );
			
		});
		
		var frm = document.goPayFrm;
		frm.deleteLecture.value=deleteLecture;
		frm.method = "POST";
		frm.action = "payment.to";
		frm.submit();		
		
	}

</script>

<body id="cart_body">

<div id="cartContainer">

<div style="width: 75%; margin: 0 auto;">
	<div id = "pay_nvar" align="right" style = "margin: 40px 0;">
	   <div><i class = "fa fa-home"></i></div>
	   <div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">수강신청</div>
	   <div>수강결제</div>
	</div>
</div>

<div align="center" id="cart_h2">
   <h2>장바구니</h2>
</div>

<div id="cartTable">
	<table>
		<thead id="cartThead">
			<tr>
				<td colspan="6" style="padding-bottom: 10px;">
					<span id="explainationCart" style="font-size: 10pt; color: gray; text-decoration: none; ">*수강신청 할 강좌를 선택 후 ‘수강 결제하기’를 클릭하시면 수강신청이 가능합니다.</span>
				</td>
			</tr>
			<tr id="cartTheadTR" style= " background-color: #f4f4f4">
				<th>
					<input type="checkbox" id="checkall" /> 
				</th>
				<th colspan="2">강좌정보</th>
				<th>수강인원</th>
				<th>강사</th>
				<th>수강료</th>
				<th>접수상태</th>
			</tr>
		</thead>
		<tbody id="cartTbody">
			<c:if test="${empty cartList}">
				<tr>
					<td colspan = "7" style="padding: 60px 0; text-align: center;">현재 장바구니에 강좌가 존재하지 않습니다.</td> 
				</tr>
			</c:if>
			<c:if test="${not empty cartList}">
				<c:forEach var="cartvo" items="${cartList}">
					
					<tr class="cartTbodyTR">
						<td>
							<input type="checkbox" name="check" value="${cartvo.cart_seq}" />  
						</td>
						<td style="width: 160px;">
							<img class="cartTbodyImg" src="resources/images_lecture/${cartvo.class_photo}" />
						</td>
						<td class="cartTbodyInfo">
							<span style="font-size: 12pt; cursor: pointer;">${cartvo.class_title}</span><br/>
							<div style="color: rgb(204, 204, 204); font-size: 11pt;">
								<span>${cartvo.class_semester}</span>&nbsp;&nbsp;<span>${cartvo.class_startDate}&nbsp;~&nbsp;${cartvo.class_endDate}</span><br/>
								<span>(${cartvo.class_day})</span>&nbsp;&nbsp;<span>${cartvo.class_time}</span><br/>
							</div>
						</td>
						<td>
							<span>${cartvo.class_personnel}</span>
						</td>
						<td>${cartvo.teacher_name}</td>
						<td><fmt:formatNumber value="${cartvo.class_fee}" pattern="###,###" />&nbsp;원</td>
						<td style="text-align: center;">
							<c:if test="${cartvo.class_status ==1 }">
								<span style="background-color: #e12a29; color: white; font-size: 10pt; float: center; padding: 5px 10px;">접수중</span>
							</c:if>
							<c:if test="${cartvo.class_status ==0 }">
								<span style="background-color: rgb(254, 112, 31); color: white; font-size: 10pt; float: center; padding: 5px 10px;">대기접수</span>
							</c:if>
							<c:if test="${cartvo.class_status ==2 }">
								<span style="background-color: black; color: white; font-size: 10pt; float: center; padding: 5px 10px;">접수완료</span>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
		<tfoot id="cartTfoot">
			<tr style= " background-color: #f4f4f4">
				<td colspan="4" style="text-align:left; padding-left: 36px;"> 
					<span class="deleteLecture" onclick="deleteCart()">선택강좌 삭제</span>&nbsp;&nbsp;
					<span class="deleteLecture" onclick="deleteAllCart()">장바구니 비우기</span>
				</td>
				<c:set var = "sum" value = "0" />
				<c:forEach var="cartvo" items="${cartList}">
					<c:set  var= "sum" value="${sum + cartvo.class_fee}" />
				</c:forEach>
				<td colspan="3" style="font-size: 12pt; text-align: right; padding-right: 27px; color: rgb(102,102,102)">
					선택강좌&nbsp;&nbsp;<span style="color: rgb(224, 40, 46); font-size: 16pt; font-weight: bold;">${fn:length(cartList) }</span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 8pt;">|</span>&nbsp;&nbsp;&nbsp;&nbsp;총 결제금액&nbsp;&nbsp;<span style="color: rgb(224, 40, 46); font-size: 16pt; font-weight: bold;"><fmt:formatNumber value="${sum}" pattern="###,###" /></span>&nbsp;&nbsp;원
				</td>
			</tr>
		</tfoot>
	</table>
</div>

<div id="cartMoreLecture">
	<a href='lectureApply.to'>강좌더보기</a>
</div>
<form name="goPayFrm">
	<input type="hidden" name="deleteLecture" />
</form>
<div id="cartGoPayment" onclick="goPayment()">
	수강결제하기
</div>

</div>
