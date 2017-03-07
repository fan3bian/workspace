<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
             <meta name="description" content="" />
             <meta name="keywords" content="" />
    <title>通知公告|公告信息</title>
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
    <style type="text/css">
      .inner-news dl dd.infor1,.inner-news dl dd.infor2,.inner-news dl dd.infor3,.inner-news dl dd.infor4,.inner-news dl dd.infor0{padding-top:10px;font-size:14px;}
    </style>
    
	<script type="text/javascript">
      function pageQuery(page) {
	   
	  location.href ="notice_"+page+".html";
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
						<li><a class='active' href="../notice/notice_1.html">公告信息</a></li>
						<li><a href="../docs/docs_1.html">标准规范</a></li>
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
						<a href="notice_1.html">通知公告</a>
						<b>公告信息</b>
					</div>
				</div>

				<div class="container-cell">
					<div class="inner-news">
					<#if page??>
					  <#list page as notice>
						<dl>
							<dd class="title"><a href="../../content/notice/notice_${notice.titleid}.html">${notice.title}</a></dd>
							<dd class="infor${notice_index}">${notice.content}</dd>
							<dd class="date">${notice.ctime}</dd>
						</dl>
						<script type="text/javascript">
	               $(function(){
	
	                var text=  $(".infor${notice_index}").text();
                
                      if(text.length>100){
                         $(".infor${notice_index}").text(text.substring(0,100)+"...");
                         }
	
				})
			</script>
			</#list>
						</#if>
			</div>
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