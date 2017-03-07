<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
     <#if notice??>
    <title>${notice.title}</title>
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
						<li><a class='active' href="../../lst/notice/notice_1.html">公告信息</a></li>
						<li><a href="../../lst/docs/docs_1.html">标准规范</a></li>
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
						<a href="../../lst/notice/notice_1.html">通知公告</a>
						<b>公告信息</b>
					</div>
				</div>

				<div class="container-cell">
					<#if notice??>
					<div class="service-detail">
						<h2>${notice.title}</h2>
						 ${notice.content} 				 
						<#if notice.filepath??>
                                                <#if notice.filepath != "">
						<a target="_blank" href="../../../downloads${notice.filepath}">查看附件</a>
                                                </#if>
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