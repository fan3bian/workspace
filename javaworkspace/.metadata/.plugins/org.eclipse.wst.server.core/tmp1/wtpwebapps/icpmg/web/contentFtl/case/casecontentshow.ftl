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
</head>
<body>
	<div class="container-wrap">
		<div class="container">	
			<div class="container-right">	
				<!-- 面包屑 -->
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
		</div>
	</div>
</body>