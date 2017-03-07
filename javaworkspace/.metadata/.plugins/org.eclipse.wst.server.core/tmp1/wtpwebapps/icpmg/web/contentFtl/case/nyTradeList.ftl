<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <title>解决方案|食药监行业</title>
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
	<script type="text/javascript">
      function pageQuery(page) {
	  	location.href ="agriculture_"+page+".html";
   	  }
    </script>
<body>
  <#include "../head.html">

	<div class="container-wrap">
		<div class="container">

			<!-- 左侧 -->
			<div class="container-left">
				<div class="inside-menu">
				<ul>
					
					<ul>
						<li><a href="government_1.html">医药卫生行业</a></li>
						<li><a href="education_1.html">教育行业</a></li>
						<li><a href="finance_1.html">民政行业</a></li>
						<li><a href="health_1.html">公安行业</a></li>
						<li><a href="politics_1.html">工商行业</a></li>
						<li><a href="environment_1.html">水利行业</a></li>
						<li><a class='active' href="agriculture_1.html">食药监行业</a></li>
						<li><a href="geology_1.html">电子商务</a></li>
						<li><a href="software_1.html">电子政务</a></li>
					</ul>
					
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
						<a href="government_1.html">解决方案</a>
						<b>食药监行业</b>
					</div>
				</div>
					
				<div class="container-cell">
					<div class="inner-case">
						<#if page??>
						<#list page as customerCase>
						<ul>
							<li>
								<dl class="cf">
									<dt>
										<#if (customerCase.customerlogo)!="">
							<a href="${"../../case/content/"+"agriculture_"+customerCase.caseid}.html"><img src="${"../../images/up"+(customerCase.customerlogo)!"/pic-3.jpg"}" style="width: 166px; height: 122px;" alt=""></a>
							<#else>
							<a href="${"../../case/content/"+"agriculture_"+customerCase.caseid}.html"><img src="../../images/up/pic-3.jpg" style="width: 166px; height: 122px;" alt=""></a>
							</#if>
									</dt>
									<dd>
										<h2><a href="${"../../case/content/"+"agriculture_"+customerCase.caseid}.html">${customerCase.casetitle}</a></h2>
										<p>客户名称：${customerCase.customername}</p>
										
									</dd>
								</dl>
								<p class="infor${customerCase_index}"><span>方案概述:</span>${customerCase.customerintroduce}</p>
							</li> 
						</ul>
						<script type="text/javascript">
	$(function(){
	
	   var text=  $(".infor${customerCase_index}").text();
                
                      if(text.length>100){
                         $(".infor${customerCase_index}").text(text.substring(0,100)+"...");
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