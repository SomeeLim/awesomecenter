<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>으뜸문화센터</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.0.min.js" ></script>

<style type="text/css">
body{
	margin: 0;
}

#myheader {
    left: 0;
    right: 0;
    min-width: 1160px;
    width: 100%;
    background: #fff;
    height: 95px;
    border-bottom: 1px solid #ccc;
    z-index: 100;
}

</style>
 	
</head>
<body>
	<div id="mycontainer">
	
	<div id="myheader">
		<tiles:insertAttribute name="header" />
	</div>
		
	<div id="mycontent">
		<tiles:insertAttribute name="content" />
	</div>
		
	<div id="myfooter">
		<tiles:insertAttribute name="footer" />
	</div>
	
	</div>
</body>
</html>