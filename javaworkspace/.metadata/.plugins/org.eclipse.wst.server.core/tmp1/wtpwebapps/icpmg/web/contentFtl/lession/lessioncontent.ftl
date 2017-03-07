<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
     <#if lession??>
    <title>${lession.lessiontitle}</title>
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
						<li><a class='active' href="../../lst/lession/lession_1.html">新手课堂</a></li>
						<li><a href="../../lst/qa/qa_1.html">技术问答</a></li>
						<li><a href="../../lst/api/api_1.html">API文档</a></li>
					</ul>
				</div>
			</div>
			<!-- 左侧 end -->
			
			<!-- 右侧  -->
			<div class="container-right">
				
				<!-- 面包屑 -->
				<div class="container-guid">
					<div>
						<span><img src="../../../images/n-06.jpg" alt=""></span>
						<a href="../../../home.html">首页</a>
						<a href="../../lst/lession/lession_1.html">服务社区</a>
						<b>新手课堂</b>
					</div>
				</div>

				<div class="container-cell">
					<#if lession??>
					<div class="service-detail">
						<h2>${lession.lessiontitle}</h2>
						 ${lession.lessioncontent} 				 
						<#if lession.lessionfileurl??>
						<a target="_blank" href="../../../downloads${lession.lessionfileurl}">查看附件</a>
						</#if>
					</div>
                    </#if>
				</div>

			</div>
			<!-- 右侧 end -->
			<div class="clear"></div>

		</div>
	</div>

	  <#include "../footer.html">
</body>
</html>