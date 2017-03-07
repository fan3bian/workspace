<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <title>浪潮</title>
		<link rel="stylesheet" type="text/css" media="screen" href="../../styles/util.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="../../styles/gather.css" />
	<script type="text/javascript" src="../../scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="../../scripts/slide.js"></script>
	<script type="text/javascript" src="../../scripts/TweenMax.min.js"></script>
	<script type="text/javascript" src="../../scripts/myScroll.js"></script>
	<script type="text/javascript" src="../../scripts/util.js"></script>
	<script type="text/javascript" src="../../scripts/gather.js"></script>
	<style type="text/css">
	 .news-detail{
	   width:75%;
	   overflow:hidden;
	   margin:0 auto;
	 }
	</style>
</head>
<body>


	<div class="container-wrap">
		 <div class="container">
        
                <#if news??> 
				<div class="container-guid">
					<div>
						<span><img src="../../images/n-06.jpg" alt=""></span>
						<a href="#">首页</a>
						<a href="#">新闻动态</a>
						<b>${news.newstype}</b>
					</div>
				</div>

				<div class="container-cell">
					
					<div class="news-wrap">
						<div class="news-detail">
							 <h2>${news.newstitle}</h2>
							 ${news.newscontent}							
						</div>
					</#if>	
					</div>

				</div>

			</div>
			<!-- 右侧 end -->
			<div class="clear"></div>

		</div>
	</div>
</body>