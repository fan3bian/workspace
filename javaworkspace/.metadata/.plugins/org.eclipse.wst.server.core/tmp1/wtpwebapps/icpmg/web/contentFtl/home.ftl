<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="description" content="浪潮云是中国政务云市场领导者，也是国家工信部首批认证通过的“可信云”,提供云服务器、云数据库、云托管等服务,中国政务云市场占有率第一。" />
		<meta name="keywords" content="浪潮云，云服务，云服务器" />
		<title>浪潮云服务|客户门户首页</title>
		<link href="/icpmg/icp/portal/styles/web.css" rel="stylesheet"
			type="text/css" />
		<link rel="stylesheet" href="/icpmg/icp/portal/styles/util.css"
			type="text/css" />
		<!-- 鼠标悬停提示 -->
		<link rel="stylesheet"
			href="/icpmg/icp/portal/tcdetail/tip-skyblue/tip-skyblue.css"
			type="text/css" />
		<link href="/icpmg/icp/portal/css/style.css" type="text/css"
			rel="stylesheet" />
		<script type="text/javascript"
			src="/icpmg/icp/portal/scripts/jquery-1.9.1.min.js"></script>
		<script type="text/javascript"
			src="/icpmg/icp/portal/scripts/slide.js"></script>
		<script type="text/javascript"
			src="/icpmg/icp/portal/scripts/jwplayer.js"></script>
		<script type="text/javascript"
			src="/icpmg/icp/portal/scripts/TweenMax.min.js"></script>
		<script type="text/javascript" src="/icpmg/icp/portal/scripts/util.js"></script>
		<script type="text/javascript"
			src="/icpmg/icp/portal/scripts/gather.js"></script>
		<script type="text/javascript"
			src="/icpmg/icp/portal/scripts/myScroll.js"></script>
		<script type="text/javascript"
			src="/icpmg/icp/portal/tcdetail/jquery.poshytip.js"></script>
			
			
	</head>
	<body>
		<#include "head.html">

		<div class="banner">
			<div class="bd">
				<ul>
					<li>
						<img src="/icpmg/icp/portal/images/banner0.jpg" />
					</li>

					<li>
						<img src="/icpmg/icp/portal/images/banner00.jpg" />
					</li>

					<li>
						<img src="/icpmg/icp/portal/images/banner000.jpg" />
					</li>
				</ul>
			</div>
			<div class="hd">
				<a class="on" href="javascript:void(0);"><img class="on"
						src="/icpmg/icp/portal/images/btn-slideon.png"> <img
						class="off" src="/icpmg/icp/portal/images/btn-slide.png"> </a>
				<a href="javascript:void(0);"><img class="on"
						src="/icpmg/icp/portal/images/btn-slideon.png"> <img
						class="off" src="/icpmg/icp/portal/images/btn-slide.png"> </a>
				<a href="javascript:void(0);"><img class="on"
						src="/icpmg/icp/portal/images/btn-slideon.png"> <img
						class="off" src="/icpmg/icp/portal/images/btn-slide.png"> </a>
			</div>
		</div>

		<div class="main-bg-blue" style="height: 242px;">
			<div class="main index-padding">
				<div class="news-main"> 
					<h3 class="h3">
						最新动态
					</h3>
					<h2 class="h2">
						最新动态
					</h2>
					<div class="new-moving" style="margin-left:28px;">
						<div class="act-img">
						<a href="/icpmg/icp/portal/news/lst/website_1.html">
						   <img src="/icpmg/icp/portal/images/index/news2.png" />
						</a>
							
						</div>
						<ul class="word">
                                                                                        <#list newsList as News>
                                                                                        <#if News??>
							<li class="hot">
								<a href="/icpmg/icp/portal/news/content/${News.newsid}.html"><span
									class="time">[${News.publishtime}]</span>${News.newstitle}</a><span
									class='hot-icon'>HOT</span>
							</li>
						          </#if>
                                                                                        </#list>
						</ul>
					</div>
					<div class="new-moving">
						<div class="act-img">
						<a href="/icpmg/icp/portal/notice/lst/notice/notice_1.html">
						   <img src="/icpmg/icp/portal/images/index/changelog2.png" />
						</a>
						
						</div>
						<ul class="word">
                                                                                        <#list noticeList as NgcMessageVo>
                                                                                        <#if NgcMessageVo??>
							<li class="hot">
								<a href="/icpmg/icp/portal/notice/content/notice/notice_${NgcMessageVo.titleid}.html"><span
									class="time">[${NgcMessageVo.ctime}]</span>${NgcMessageVo.title}</a><span
									class='hot-icon'>重要</span>
							</li>
                                                                                        </#if>
                                                                                        </#list>
						</ul>
					</div>
					<div class="new-moving">
						<div class="act-img">
						<a href="/icpmg/icp/portal/notice/lst/docs/docs_1.html">
						  <img src="/icpmg/icp/portal/images/index/safe2.png" />
						</a>
						
						</div>
						<ul class="word">
                                                                                <#list docsList as FileQueryVo>
                                                                                 <#if FileQueryVo??>
							<li class="hot">
								<a href="/icpmg/icp/portal/downloads/标准规范${FileQueryVo.fileurl}" target="_blank"><span
									class="time">[${FileQueryVo.ctime}]</span>《${FileQueryVo.filename}》</a>
									<span class='hot-icon'>HOT</span>
							</li>
                                                                                 </#if>
                                                                                </#list>

						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="main-bg-blue" style="height: 312px;">
			<div class="main index-padding dt">
				<h2 class="h2">
					产品&服务
					<a href="/icpmg/icp/portal/product/00.html" class="more">更多></a>
				</h2>
				<h3 class="h3">
					产品&服务
				</h3>
				<div class="product-wear">
					<div class="product-sort">
						<div class="sort-name">
							<i class="icon-jisuan"></i> 计算
							<i class="caret-blue bottom"></i>
						</div>
						<ul class="product-list">
							<li>
								<a href="/icpmg/icp/portal/product/100001.html"> <i></i> <span>云服务器</span>
									<cite>InServer</cite> </a>
							</li>
							<li>
								<a href="/icpmg/icp/portal/product/100002.html"> <i></i> <span>负载均衡</span>
									<cite>InSLB</cite> </a>
							</li>

						</ul>
					</div>
					<div class="product-sort">
						<div class="sort-name">
							<i class="icon-net"></i> 存储
							<i class="caret-blue bottom"></i>
						</div>
						<ul class="product-list">
							<li>
								<a href="/icpmg/icp/portal/product/100003.html"> <i></i> <span>云盘</span>
									<cite>InPan</cite> </a>
							</li>
                                                                                        <li>
								<a href="/icpmg/icp/portal/product/100009.html"> <i></i> <span>云存储</span>
									<cite>InFile</cite> </a>
							</li>

						</ul>
					</div>
					<div class="product-sort">
						<div class="sort-name">
							<i class="icon-cdn"></i> 容灾
							<i class="caret-blue bottom"></i>
						</div>
						<ul class="product-list">
							<li>
								<a href="/icpmg/icp/portal/product/100007.html"> <i></i> <span>云容灾</span>
									<cite>InCDR</cite> </a>
							</li>
							

						</ul>
					</div>
					<div class="product-sort">
						<div class="sort-name">
							<i class="icon-data"></i> IDC
							<i class="caret-blue bottom"></i>
						</div>
						<ul class="product-list">
							<li>
								<a href="/icpmg/icp/portal/product/100006.html"> <i></i> <span>云托管</span>
									<cite>InHosting</cite> </a>
							</li>
							<li>
								<a href="/icpmg/icp/portal/product/100005.html"> <i></i> <span>云加速</span>
									<cite>InCDN</cite> </a>
							</li>

						</ul>
					</div>
					<div class="product-sort">
						<div class="sort-name">
							<i class="icon-server"></i> 应用
							<i class="caret-blue bottom"></i>
						</div>
						<ul class="product-list">
							<li>
								<a href="/icpmg/icp/portal/product/100004.html"> <i></i> <span>舆情分析</span>
									<cite>InPSA</cite> </a>
							</li>

						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="main-bg-blue" >
			<div class="main index-padding dt">
				<h2 class="h2">
					解决方案
					<a href="/icpmg/icp/portal/case/lst/government_1.html" class="more">更多></a>
				</h2>
				<h3 class="h3">
					解决方案
				</h3><!--
		<div class="main-bg-blue">
			--><div class="case-box">
				<div class="line"></div>
				<div class="container">
					<!--<h1>
						解决方案
					</h1>
					<div class="tip">
						他们正在用浪潮云服务，也许您像他们一样需要浪潮云服务，期待您的加入。
					</div>
					--><ul class="links">
						<li class="links-a">
							<a href="/icpmg/icp/portal/case/lst/government_1.html"><span>医药卫生行业</span>
							</a>
						</li>
						<li class="links-b">
							<a href="/icpmg/icp/portal/case/lst/education_1.html"><span>教育行业</span>
							</a>
						</li>
						<li class="links-c">
							<a href="/icpmg/icp/portal/case/lst/finance_1.html"><span>民政行业</span>
							</a>
						</li>
						<li class="links-d">
							<a href="/icpmg/icp/portal/case/lst/agriculture_1.html"><span>食药监行业</span>
							</a>
						</li>
						<li class="links-e">
							<a href="/icpmg/icp/portal/case/lst/health_1.html"><span>公安行业</span>
							</a>
						</li>
						<li class="links-f">
							<a href="/icpmg/icp/portal/case/lst/software_1.html"><span>电子政务</span>
							</a>
						</li>
					</ul>

				</div>
			</div>
			</div>
		</div>

		<#include "footer.html">
	</body>
</html>