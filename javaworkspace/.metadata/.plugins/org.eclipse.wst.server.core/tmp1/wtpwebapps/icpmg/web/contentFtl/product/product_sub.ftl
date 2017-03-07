<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <title>产品简介|${secondTitle}|${thirdTitle}</title>
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
				
				<div class="container-cell">
					<div class="pro-wrap">
						<div class="intro-wrap">
							<img src="../images/up/product/${subProductVO.image}" alt="">
						</div>
						<#if (subProductVO.pfvo?size>0) >
							<div class="pro-advantage cf">
								<#list subProductVO.pfvo as fl>
								<dl>
									<dt>
										<img src="../images/up/product/${fl.image}" alt="">
									</dt>
									<dd>
										<h2>${fl.name}
										<#if fl.ftip??>
											<a target="_blank" href="${fl.fturl}">${fl.ftip}</a>
										</#if>
										</h2>
										<p>${fl.discription}</p>
									</dd>
								</dl>
								</#list>
							</div>
						</#if>
						<#if (subProductVO.pcvo?size>0) >
						<div class="hash-wrap">
							<ul class="hash-ul cf">
								<#list subProductVO.pcvo as cl>
								<li <#if cl.position == "1">class="first on"</#if>>
									<a href="javascript:void(0)">${cl.name}</a>
								</li>
								</#list>
							</ul>
						</div>
						<#list subProductVO.pcvo as cl>
							<div class="productIntor product-content">
							<a class="link" hidefocus=""> </a>
							<div class="product-title">
								<h2>${cl.name}<span><#if cl.ftip??>${cl.ftip}</#if></span></h2>
							</div>
							<#if cl.type == "1">
								<div class="detail">
									${cl.discription}
									<#if cl.image??&&cl.image!="">
											<img src="../images/up/product/${cl.image}" alt="">
									</#if>
								</div>
							<#elseif cl.type == "2">
								<a href="../images/up/product/${cl.image}" target="_blank" class="down-manual">${cl.discription}</a>
							</#if>
							</div>
						</#list>
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