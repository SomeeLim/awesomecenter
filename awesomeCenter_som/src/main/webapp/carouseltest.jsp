<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <% String ctxPath = request.getContextPath(); %>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/main.css" />
  <style>
.carousel-inner > .item > img,
.carousel-inner > .item > a > img {
	width: 600px;
	margin: auto;
}

.carousel-control{
	position: relative;
	bottom: 13px;
	right: 10px;
	margin-right: 30px;
	z-index: 100;
}

.carousel-indicators li{
	border: 1px solid gray;
	background: gray;
}

.carousel-indicators{
	position: relative;
	bottom: 25px;
}

.carousel-indicators .active{
	border: solid 3px red;
}

.carousel-indicators li:hover{
	border: solid 3px red;
	background: #ffffff;
}

.lrControl{
	position: relative;
	left: 90px;
	bottom: 2px;
}
  
  
  </style>
</head>
<div id="main">
	<div id="leftArea"> 
		<div id="leftSubArea1"> 
<div id="carousel">
<div id="myCarousel" class="carousel slide" data-ride="carousel">
	<!-- Wrapper for slides -->
	<div class="carousel-inner" role="listbox">
	
		<div class="item active">
		<img src="/awesomecenter/resources/hmimages/carousel1.jpg" alt="Chania" width="400" height="300">
		</div>
		
		<div class="item">
		<img src="/awesomecenter/resources/hmimages/carousel2.jpg" alt="Chania" width="400" height="300">
		</div>
		
		<div class="item">
		<img src="/awesomecenter/resources/hmimages/carousel3.jpg" alt="Flower" width="400" height="300">
		</div>
		
		<div class="item">
		<img src="/awesomecenter/resources/hmimages/carousel4.jpg" alt="Flower" width="400" height="300">
		</div>
		
		<!-- Left and right controls -->
		<div class="lrControl" align="center">
		<a class="carousel-control" href="#myCarousel" role="button" data-slide="prev">
		<span style="color: red;"><</span>
		</a>
		<a class="carousel-control" href="#myCarousel" role="button" data-slide="next">
		<span style="color: red;">></span>
		</a>
		</div>
		
		<!-- Indicators -->
		<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>
		<li data-target="#myCarousel" data-slide-to="3"></li>
		</ol>
	</div> 
</div>
</div>
</div></div></div>
</body>
</html>
