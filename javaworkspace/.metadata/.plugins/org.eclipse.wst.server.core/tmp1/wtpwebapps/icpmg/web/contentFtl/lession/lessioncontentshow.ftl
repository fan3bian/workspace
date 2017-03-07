<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
	<div class="container-wrap">
		<div class="container">

			<!-- 左侧 -->
			 
			<!-- 左侧 end -->
			
			<!-- 右侧  -->
			<div class="container-right">
				
				<!-- 面包屑 -->
				<div class="container-guid">
					<div>
					  <span><img src="../../../../images/n-06.jpg" alt=""></span>
						<a>首页</a>
						<a>服务社区</a>
						<b>新手课堂</b>
					</div>
				</div>

				<div class="container-cell">
					
					<#if lession??>
					<div class="service-detail">
						<h2>${lession.lessiontitle}</h2>
						${lession.lessioncontent}
						 
						<#if lession.lessionfileurl??>
						  <a>点击下载</a>
						</#if>
					</div>
                    </#if>
				</div>

			</div>
			<!-- 右侧 end -->
			<div class="clear"></div>

		</div>
	</div>

</body>