<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<jsp:useBean id="now" class="java.util.Date"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>浪潮云服务</title>

<meta http-equiv="refresh" content="3600">
<%@ include file="/icp/include/import.jsp"%>

<%
	String contextPath = request.getContextPath();	
%>

<script type="text/javascript">

	//$.parser.onComplete 当解析器完成解析动作的时候触发。
	$.parser.onComplete = function(){
		
		//统计资源
		resourceOverview();
					
	}
	
	
	//统计资源
	function resourceOverview(){
		$.ajax({
		  		type : 'post',
		  		url:'<%=contextPath%>/resourceOverview.do',		  		
		  		success:function(result){		  				
		  				var obj = eval("("+result+")");		  						  				
		  				
		  				$("#resourcenum").html(obj.mapResource.resourcenum);
		  				$("#resourcerunnum").html(obj.mapResource.resourcerunnum);
		  				$("#resourcestopnum").html(obj.mapResource.resourcestopnum);
		  				$("#messagenum").html(obj.mapResource.messagenum);
		  				$("#usersnum").html(obj.mapResource.usersnum);
		  				$("#projectfilesnum").html(obj.mapResource.projectfilesnum);
		  				$("#otherfilesnum").html(obj.mapResource.otherfilesnum);
		  				$("#appnum").html(obj.mapResource.appnum);
		  				$("#projectnum").html(obj.mapResource.projectnum);
		  		}
		  	});
		
	}
	
</script>
</head>
<body>

<div class="container-wrap">
	<div class="container center-container">
		<!-- 左侧 -->
		<div class="container-left center-left">
				<div class="center-menu">
				<div class="left_top">
					<div class="left_top_left"> <img src="${ctx}/icp/style/images/admin1.png"/>
        				<div class="left_top_left_tit">账户信息</div>
     				</div>
     				
     				<div class="left_top_right">
				        <div class="date">
				          <p><font size="5px"><fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy-MM-dd" /><br/><fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="EEEE" /></font></p>
				          <br/>
				          <span>上次登录时间：2016-01-26 20:36:45</span> 
				        </div>
      				</div>      								
				</div>				
				
				<div class="left_second">
					<p>${sessionUser.uname}，欢迎你！<br/>
    				<span>${sessionUser.sysname}</span></p>
   			 	</div>
   			 	
   			 	<br/>
   			 	
	   			 <div class="left_third">
				    <div class="left_third_one" style=" border-right:1px solid #eee;">
				    <a href="#"><p><span>45</span><br/>子账户</p></a></div>
				     <div class="left_third_one" style=" border-right:1px solid #eee;">
				     <a href="#"><p><span>6</span><br/> 消息</p></a></div>
				     <div class="left_third_one"><a href="#"><p><span>8</span><br/>待审批</p></a></div>
	    		 </div>	    		 
		    		<div class="left_forth">状态：
		    		<c:if test="${sessionUser.status eq '1'}">待验证</c:if>
					<c:if test="${sessionUser.status eq '2'}">待审核</c:if>
					<c:if test="${sessionUser.status eq '3'}">正常</c:if>
					<c:if test="${sessionUser.status eq '4'}">注销</c:if>
		    		</div>
				    <div class="left_five">用户：${sessionUser.email}</div>
				    <div class="left_five">手机：${sessionUser.mobile}</div> 
				    
				 <div class="left_button"><a href="#">修改密码</a></div>
			    		           
			</div>
		</div>
		<!-- 左侧 end   -->
		<!-- 右侧  -->
		<div class="container-right">
			<div class="container-cell">
				<div class="box-wrap">
					<form id="conditionForm"  method="post">
					<input type="hidden" id="status" name="status"/>
					</form>
					<ul class="cf">
						<li class="user">
							<p style="padding-top:100px;padding-left:40px;font-size:60px"><span id="projectnum"></span></p>
							
						</li>
						<li class="account">
							<p style="padding-top:100px;padding-left:40px;font-size:20px">总数：<span id="resourcenum"></span></p>
							<p style="padding-left:40px;font-size:20px">运行：<span id="resourcerunnum"></span> </p>
							<p style="padding-left:40px;font-size:20px">关闭：<span id="resourcestopnum"></span> </p>
							
						</li>
						<li class="order">
							<p style="padding-top:100px;padding-left:40px;font-size:60px"><span id="appnum"></span> </p>
						</li>
						<li class="product">
							<p style="padding-top:100px;padding-left:30px;font-size:20px">项目文档：<span id="projectfilesnum"></span> </p>
							<p style="padding-left:30px;font-size:20px">其他文档：<span id="otherfilesnum"></span> </p>
							
						</li>
						<li class="res">
							<p style="padding-top:100px;padding-left:40px;font-size:60px"><span id="usersnum"></span> </p>
						</li>
						<li class="suggest">
							<p style="padding-top:100px;padding-left:40px;font-size:60px"><span id="messagenum"></span> </p>
						</li>
						
					</ul>
					
				</div>
			</div>
		</div>
		<!-- 右侧 end -->
		<div class="clear"></div>
	</div>
</div>		

<div class="popup" id="popup">
	 <div class="xq box" > 
	</div>  
</div>

</body>
</html>
