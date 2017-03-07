<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
     <#if news??>
    <title>${news.newstitle}</title>
    </#if>
<link href="/icpmg/icp/portal/styles/web.css" rel="stylesheet"
			type="text/css" />
	<link rel="stylesheet" type="text/css" media="screen" href="/icpmg/icp/portal/styles/util.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="/icpmg/icp/portal/styles/gather.css" />
	<script type="text/javascript" src="/icpmg/icp/portal/scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/icpmg/icp/portal/scripts/slide.js"></script>
	<script type="text/javascript" src="/icpmg/icp/portal/scripts/TweenMax.min.js"></script>
	<script type="text/javascript" src="/icpmg/icp/portal/scripts/myScroll.js"></script>
	<script type="text/javascript" src="/icpmg/icp/portal/scripts/util.js"></script>
	<script type="text/javascript" src="/icpmg/icp/portal/scripts/gather.js"></script>
</head>
<body>
  <#include "../head.html">
	<div class="container-wrap">
		<div class="container">

			<!-- 左侧 -->
			<div class="container-left">
				<div class="inside-menu">
					<ul>
						<li><a class='active' href="../lst/website_1.html">动态新闻</a></li>
					</ul>
				</div>
			</div>
			<!-- 左侧 end -->
			
			<!-- 右侧  -->
			<div class="container-right">
				
				<!-- 面包屑 -->
				<div class="container-guid">
					<div>
						<span><img src="../../images/n-06.jpg" alt=""></span>
						<a href="../../home.html">首页</a>
						<a href="../lst/website_1.html">新闻动态</a>
						<b>动态新闻</b>
					</div>
				</div>

				<div class="container-cell">
					
					<div class="news-wrap">
						<div class="news-detail">
							<#if news??>
                             <h2>${news.newstitle}</h2>
                             ${news.newscontent}
                          </#if>					
						</div>
						<dl>
							<dt>新闻链接</dt>
							<dd><a href="../lst/website_1.html">动态新闻相关了解更多...</a></dd>
						</dl>
					</div>

				</div>

			</div>
			<!-- 右侧 end -->
			<div class="clear"></div>

		</div>
	</div>

<#include "../footer.html">
</body>