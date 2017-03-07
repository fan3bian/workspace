<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<div class="header nav" style="padding: 0 0;min-width:1349px;">
	<div style="float:left;display:inline;width:91px;height:128px;background:url(${ctx}/icp/images/head01.png) repeat-x;"></div>
	<div id="head02" style="float:left;display:inline;height:128px;background:url(${ctx}/icp/images/head.png);">
		<div class="logo" style="margin-top:18px;"><img alt="" style="width:164px;height:87px;" src="${ctx}${sessionUser.logofile}"></div>
		<div id="nav" class="top-right" style="width:991px;margin-right:88px;">
			<div style="float:left;margin-top:15px;">
				<a class="name" style="font-size:30px;font-weight:bold;color:white;">${sessionUser.sysname}</a>
			</div>
			<div class="top-right-left fll" style="margin-top:0px;float:right;">
				<a href="${ctx}/userinfo/userMainInfo.do" style="margin-top:10px;"><img src="${ctx}/icp/images/head03.png" alt=""></a>
				<div class="line" style="width: 0px; height: 0px;"></div> 
				<a href="${ctx}/icp/portal/home.html" style="margin-top:10px;"><img src="${ctx}/icp/images/head05.png" alt=""></a>
				<div class="line" style="width: 0px; height: 0px;"></div> 
				<a href="${ctx}/uu/logout.do" style="margin-top:10px;"><img src="${ctx}/icp/images/head07.png" alt=""></a>
			</div>
			<div class="clear"></div>
			<ul class="center-nav" style="margin-top:20px;margin-bottom:16px;">
			<c:forEach items="${menuList}" var="vo">
			<li style="padding-left:50px;"><a class="colnav" id="${vo.mId}" href="javascript:void(0);" name="${ctx}/${vo.hName}" style="font-size:17px;color:white;">${vo.fName}</a>

			</li>
				<input type="hidden" id="parentid" name="parentid" >
			</c:forEach>
			</ul>
		</div>
	</div>
</div> 
<script type="text/javascript">
$(function() {

	$(".center-nav").children("li").children("a").click(function(){
		console.log($(this).attr("href"))
		<%--${ctx}/${vo.hName}--%>
		$("#parentId").val($(this).attr("id"))
		window.location.href=$(this).attr("name");
	})

	var scrollW = $(window).width();
	var width = scrollW - 91;
	var navw;
	if(scrollW <= 1349){
		width = 1349 - 91;
		navw = 991;
	}else{
		navw = scrollW - 358;
	}
	document.getElementById('head02').style.width = width + 'px';
	document.getElementById('nav').style.width = navw + 'px';
	
	window.onresize=function(){
		var scrollW = $(window).width();
		var width = scrollW - 91;
		var navw;
		if(scrollW <= 1349){
			width = 1349 - 91;
			navw = 991;
		}else{
			navw = scrollW - 358;
		}
		document.getElementById('head02').style.width = width + 'px';
		document.getElementById('nav').style.width = navw + 'px';
	}; 
	//鼠标滑过移开变色
	$(".colnav").hover(
		function () {
			$(this).css("color","#FE9400");
		},
		function () {
			$(this).css("color","white");
		}
	); 
});
</script>



