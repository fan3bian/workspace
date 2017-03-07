<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <title>浪潮</title>
	<link rel="stylesheet" type="text/css" media="screen" href="../../../../styles/util.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="../../../../styles/gather.css" />
	<script type="text/javascript" src="../../../../scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="../../../../scripts/slide.js"></script>
	<script type="text/javascript" src="../../../../scripts/TweenMax.min.js"></script>
	<script type="text/javascript" src="../../../../scripts/myScroll.js"></script>
	<script type="text/javascript" src="../../../../scripts/util.js"></script>
	<script type="text/javascript" src="../../../../scripts/gather.js"></script>
</head>
<body>		
			<!-- 右侧  -->
				<div class="container-right" style="margin-right:50px">
				
				<!-- 面包屑 -->
				<div class="container-guid">
					<div>
						<span><img src="../../../../images/n-06.jpg" alt=""></span>
						<a href="#">首页</a>
						<a href="#">服务社区</a>
						<b>技术问答</b>
					</div>
				</div>

				<div class="container-cell">
					
					<div class="service-detail">
					<#if qa??>
						<h2>${qa.question}</h2>
						 ${qa.answer}
					 
						</#if>
					</div>


				</div>

			</div>
			<!-- 右侧 end -->
			<div class="clear"></div>

	 
 

</body>