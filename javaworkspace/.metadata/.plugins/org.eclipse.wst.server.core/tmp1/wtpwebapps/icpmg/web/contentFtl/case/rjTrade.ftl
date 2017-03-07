<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <#if customerCase??>
    <title>${customerCase.casetitle}</title>
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
						<li><a href="../lst/government_1.html">医药卫生行业</a></li>
						<li><a href="../lst/education_1.html">教育行业</a></li>
						<li><a href="../lst/finance_1.html">民政行业</a></li>
						<li><a href="../lst/health_1.html">公安行业</a></li>
						<li><a href="../lst/politics_1.html">工商行业</a></li>
						<li><a href="../lst/environment_1.html">水利行业</a></li>
						<li><a href="../lst/agriculture_1.html">食药监行业</a></li>
						<li><a href="../lst/geology_1.html">电子商务</a></li>
						<li><a class='active' href="../lst/software_1.html">电子政务</a></li>
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
						<a href="../lst/government_1.html">解决方案</a>
						<b>电子政务</b>
					</div>
				</div>

				<div class="container-cell">
					<div class="case-detail">
					<#if customerCase??>
						<h2>${customerCase.casetitle}</h2>
						<h3>方案概述</h3>
						<p>${customerCase.customerintroduce}</p>
						<h3>方案架构</h3>
						<p>${customerCase.companystructure}</p>
						<h3>方案价值</h3>
						<p>${customerCase.companyvalue}</p>
					</#if>
					</div>
                 
				</div>

			</div>
			<!-- 右侧 end -->
			<div class="clear"></div>

		</div>
	</div>

  <#include "../footer.html">
</body>