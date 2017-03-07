<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" >

<html>
<head>
	<title>浪潮</title>
	<%@ include file="/icp/include/indexImport.jsp"%>
	
</head>

<body>
<div class="header header_index">
	<div class="container">
		<div class="logo"><img src="${ctx}/icp/portal/images/logo/logo1.png"  height="26px;" width="169px;"></a></div>
		<div class="top-tel">全国服务热线：400-607-6657</div>
		<div class="top-right">
			<div class="top-right-left fll">
				<c:if test="${sessionUser != null}">
				<a href="javascript:void(0);" onclick="openurl('${ctx}/userinfo/userMainInfo.do')">${sessionUser.uname}</a>
				</c:if>
				<c:if test="${sessionUser == null}">
					<%-- <a href="javascript:void(0);" onclick="openurl('${ctx}/icp/register/reg01.jsp')" target="_blank">注册</a> --%>
					<a href="${ctx}/icp/register/reg01.jsp" target="_blank">注册</a>
					<div class="line"></div>
					<%-- <a href="javascript:void(0);" onclick="openurl('${ctx}/icp/login.html')">登录</a> --%>
					<a href="${ctx}/login.html" target="_blank">登录</a>
				</c:if>
			</div>
			<div class="line"></div>
			<div class="search">
				<form>
					<label>快速搜索</label>
					<input type="text" id="searchvalue" name="searchvalue" onkeydown="EnterPress()"/>
					<input type="button" value="" onclick="opensearch()"/>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">

   function openurl(url){
      parent.location.replace(url);
   }
   function opensearch(){
      var searchvalue = document.getElementById("searchvalue").value;
      //alert(searchvalue);
      window.open('${ctx}/search.do?searchvalue='+encodeURI(encodeURI(searchvalue)));
      
   }
   function EnterPress(e){ 
	var e = e || window.event; 
	if(e.keyCode == 13){ 
	  opensearch();
	} 
   } 
   </script>
</html>

