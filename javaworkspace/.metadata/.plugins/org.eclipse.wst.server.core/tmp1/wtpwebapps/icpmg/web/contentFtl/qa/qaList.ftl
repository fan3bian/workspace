<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>服务社区|技术问答</title>
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
	 
	<script type="text/javascript">
      function pageQuery(page) {
	   
	  location.href ="qa_"+page+".html";
   }
   
	</script>
</head>
<body>
<#include "../head.html">

	<div class="container-wrap">
		<div class="container">

			<!-- 左侧 -->
			<div class="container-left">
				<div class="inside-menu">
					<ul>
						<li><a href="../lession/lession_1.html">新手课堂</a></li>
						<li><a class='active' href="../qa/qa_1.html">技术问答</a></li>
						<li><a href="../api/api_1.html">API文档</a></li>
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
						<a href="../lession/lession_1.html">服务社区</a>
						<b>技术问答</b>
					</div>
				</div>

				<div class="container-cell">
					 <#if page??>
					 <#list page as qas>
					<div class="inner-faq">
						<ul>
							<li><p>${qas_index+1+newsPage.currentNum}. ${qas.question}</p><a href="../../content/qa/qa_${qas.qaid}.html" class="detail">点击查看 +</a></li>
						</ul>
					</div>
                 </#list>
			    </#if>
					<div class="inner-page">
					<div>
					<table width="100%" align="center" >
						<tr>
                    <td align="center">
					页次&nbsp;<font color="red">${newsPage.currentPage}/${(newsPage.totalPage)?c}</font>
                    &nbsp;&nbsp;每页&nbsp;<font color="red">${newsPage.perNum}</font>&nbsp;条&nbsp;&nbsp;共&nbsp;
                    <font color="red">${(newsPage.totalNum)?c}</font>&nbsp;条</td>
                    <td align="center">
				   <#if (newsPage.currentPage>1)>
                   	 <a  href='#' onClick='pageQuery(1)' >&nbsp;&nbsp;最前页&nbsp;</a>
                     <a  href='#' onClick="pageQuery(${newsPage.currentPage-1})"  >上一页</a>
                    </#if>
                    <#if newsPage.currentPage==1>
                   		 &nbsp;&nbsp;最前页&nbsp;上一页
                    </#if>
                    <#if (newsPage.currentPage<newsPage.totalPage) >
                     <a  href='#' onClick='pageQuery(${newsPage.currentPage+1})' >&nbsp;&nbsp;下一页&nbsp;</a>
                     <a  href='#' onClick="pageQuery(${newsPage.totalPage})"  >最后页</a>
                    </#if>
                    <#if newsPage.currentPage==newsPage.totalPage>
    			         &nbsp;&nbsp;下一页&nbsp;最后页
       			    </#if>
       			     </td>
                   </tr>
                 </table>
						</div>
					</div>

				</div>

			</div>
			<!-- 右侧 end -->
			<div class="clear"></div>

		</div>
	</div>

	  <#include "../footer.html">
</body>