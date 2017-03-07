<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <title>产品简介|产品导航</title>
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
	<link href="/icpmg/icp/portal/css/style.css" type="text/css" rel="stylesheet" />
</head>
<body>
<#include "../head.html">
	<div class="container-wrap">
		<div class="container">
			<!-- 左侧 -->
			<div class="container-left">
				<div class="sub-menu">
					<ul>
						<li>
								<a href="00.html">产品导航</a>
						</li>
						<#list ptypeList as ptypeVO>
							<li>
							<a href="javascript:void(0)" class="${ptypeVO.close}">${ptypeVO.name}</a>
							<ol style="${ptypeVO.display};">
  							<#list ptypeVO.productList as productVO>
     							<li><a  class="${productVO.active}" href="${productVO.pid}.html">${productVO.pname}</a></li>
  							</#list>
  							</ol>
  							</li>
						</#list>
					</ul>
				</div>
			</div>
			<!-- 左侧 end -->
			
			<!-- 右侧  -->
			<div class="container-right">
				
				<!-- 面包屑 -->
				<!-- <div class="container-guid">
					<div>
						<span><img src="../images/up/product/n-06.jpg" alt=""></span>
						<a href="#">首页</a>
						<a href="#">解决方案</a>
						<b>政府行业</b>
					</div>
				</div> -->

				<div class="container-cell">
						<div class="product-total">
						<ul class="item-1">
							<li class="li-1">
								<a href="#"><img src="../images/up/product/icon-5.png" alt="">
								<span>云监控</span></a>
							</li>
							<li class="li-2">
								<a href="#"><img src="../images/up/product/icon-6.png" alt="">
								<span>云防护</span></a>
							</li>
							<li class="li-3">
								<a href="#"><img src="../images/up/product/icon-7.png" alt="">
								<span>云分发</span></a>
							</li>
						</ul>

						<ul class="item-ul item-2">
							<li class="li-1">
								<a href="100006.html"><img src="../images/up/product/yuntuoguan.png" alt="">
								<span>云托管</span></a>
							</li>
							<li class="li-2">
								<a href="#"><img src="../images/up/product/yunjiasu.png" alt="">
								<span>云加速</span></a>
							</li>
						</ul>

						<ul class="item-ul item-3">
							<li class="li-1">
								<a href="100003.html"><img src="../images/up/product/yunpan.png" alt="">
								<span>云盘</span></a>
							</li>
							<li class="li-2">
								<a href="100009.html"><img src="../images/up/product/yuncunchu.png" alt="">
								<span>云存储</span></a>
							</li>
							<li class="li-2">
								<a href="#"><img src="../images/up/product/kuaicunchu.png" alt="">
								<span>块存储</span></a>
							</li>
						</ul>

						<ul class="item-ul item-4">
							<li class="li-1">
								<a href="100001.html"><img src="../images/up/product/icon-14.png" alt="">
								<span>云服务器</span></a>
							</li>
							<li class="li-2">
								<a href="100002.html"><img src="../images/up/product/icon-13.png" alt="">
								<span>负载均衡</span></a>
							</li>
							<li class="li-2">
								<a href="100008.html"><img src="../images/up/product/wulizhuji.png" alt="">
								<span>物理主机</span></a>
							</li>
						</ul>

						<ul class="item-ul item-5">
							<li class="li-1">
								<a href="#"><img src="../images/up/product/icon-16.png" alt="">
								<span>关系型数据库</span></a>
							</li>
							<li class="li-2">
								<a href="#"><img src="../images/up/product/icon-17.png" alt="">
								<span>非关系型数据库</span></a>
							</li>
						</ul>

						<ul class="item-ul item-6">
							<li class="li-1">
								<a href="100004.html"><img src="../images/up/product/icon-18.png" alt="">
								<span>舆情监控</span></a>
							</li>
							<li class="li-3">
								<a href="#"><img src="../images/up/product/icon-20.png" alt="">
								<span>视频会议</span></a>
							</li>
						</ul>
						<ul class="item-ul item-7">
						<li class="li-1">
								<a href="100007.html"><img src="../images/up/product/yunrongzai.png" alt="">
								<span>云容灾</span></a>
							</li>
							<li class="li-2">
								<a href="#"><img src="../images/up/product/yunbeifen.png" alt="">
								<span>云备份</span></a>
							</li>
							<li class="li-2">
								<a href="#"><img src="../images/up/product/yunshuanghuo.png" alt="">
								<span>云双活</span></a>
							</li>
						</ul>
					</div>

				</div>

			</div>
			<!-- 右侧 end -->
			<div class="clear"></div>

		</div>
	</div>
<#include "../head.html">
</body>