<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>浪潮</title>
	<link rel="stylesheet" type="text/css" media="screen" href="../../../styles/util.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="../../../styles/gather.css" />
	<script type="text/javascript" src="../../../scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="../../../scripts/slide.js"></script>
	<script type="text/javascript" src="../../../scripts/TweenMax.min.js"></script>
	<script type="text/javascript" src="../../../scripts/myScroll.js"></script>
	<script type="text/javascript" src="../../../scripts/util.js"></script>
	<script type="text/javascript" src="../../../scripts/gather.js"></script>
</head>
<body>

	<div class="container-wrap">
		<div class="container">

			<div class="container-right">

				<div class="container-cell">
					<!-- 面包屑 -->
		 
					<div class="inner-service">
					<div class="product-details">
					   <#if api??>
						<p><font size="5px">${api.interfacename}</font></p>
						<p><font style="font-weight:bold;" size="5px"> ${api.functionshow}</font></p>
						${api.apicontent}
						 <#if api.apifile??>
						   <a>相关附件下载</a>
						 </#if>
						</#if>

					</div>

				 

				</div>

			</div>
			<!-- 右侧 end -->
			<div class="clear"></div>

		</div>
	</div>
</div>
			 
</body>