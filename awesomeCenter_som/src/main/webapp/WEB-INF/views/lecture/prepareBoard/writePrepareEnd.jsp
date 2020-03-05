<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
  <script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

	if(${n==1}) {
		alert("글쓰기 성공!!");
		location.href="<%=ctxPath%>/prepareBoard.to?class_seq=${class_seq}";
	}
	else {
		alert("글쓰기 실패");
		location.href="<%=ctxPath%>/prepareBoard.to?class_seq=${class_seq}";
	}

</script>