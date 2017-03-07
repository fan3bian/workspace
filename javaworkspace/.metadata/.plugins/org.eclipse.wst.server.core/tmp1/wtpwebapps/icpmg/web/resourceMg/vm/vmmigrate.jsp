<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/web/inc.jsp" %>
<%@ include file="/icp/include/taglib.jsp"%>
<style type="text/css">
	.FieldInput2 {
		width:77%;
		height:30px;
	    background-color: #FFFFFF;
		font: normal 12px tahoma, arial, helvetica, sans-serif;
	    text-align: left;
	    word-wrap: break-word;
	    padding-top:0px !important;
	    padding-bottom:0px !important;
	    border:#BCD2EE 1px solid !important;  
	}
	.FieldLabel2 {
		width:23%;
		height:30px;
	    background-color: #F0F8FF;
		font: normal 12px tahoma, arial, helvetica, sans-serif;
	    text-align: left;
	    word-wrap: break-word;
	    padding-top:0px !important;
	    padding-bottom:0px !important;
	    padding-right:10px !important;
	    border:#BCD2EE 1px solid !important;  
	}
</style>
<script type="text/javascript">
var basePath = "${pageContext.request.contextPath}";
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/web/resourceMg/vm/js/vmmigrate.js"></script>

<body>		 
<div id="details" class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" style="padding:10px;">
		<form id="tableform" method="post">
			<br><input type="hidden" id="migServerid" name="serverid" value="<%=request.getParameter("serverid")%>"/>
			<input type="hidden" id="migServername" name="servername" value="<%=request.getParameter("servername")%>"/>
		<c:if test="${curstat eq 'Running'}"><label><input class="migoper" name="migoper" type="radio" value="1" checked="checked" />迁移主机 </label>&nbsp;&nbsp;  <label><input class="migoper" name="migoper" type="radio" value="2" />迁移存储 </label></c:if>
		<c:if test="${curstat eq 'Stopped'}"><label><input class="migoper" name="migoper" type="radio" value="1" checked="checked" />迁移主机 </label>&nbsp;&nbsp;  <label><input class="migoper" name="migoper" type="radio" value="2" />迁移存储 </label>&nbsp;&nbsp; <label><input class="migoper" name="migoper" type="radio" value="3" />迁移主机和存储 </label></c:if>
		<c:if test="${curstat eq 'Stopping'}"><label><input class="migoper" name="migoper" type="radio" value="1" checked="checked" />迁移主机 </label>&nbsp;&nbsp;  <label><input class="migoper" name="migoper" type="radio" value="2" />迁移存储 </label>&nbsp;&nbsp; <label><input class="migoper" name="migoper" type="radio" value="3" />迁移主机和存储 </label></c:if>
		<c:if test="${curstat eq 'Starting'}"><label><input class="migoper" name="migoper" type="radio" value="1" checked="checked" />迁移主机 </label>&nbsp;&nbsp;  <label><input class="migoper" name="migoper" type="radio" value="2" />迁移存储 </label></c:if>
		<c:if test="${curstat eq 'Destroyed'}"><label><input class="migoper" name="migoper" type="radio" value="1" checked="checked" />迁移主机 </label>&nbsp;&nbsp;  <label><input class="migoper" name="migoper" type="radio" value="2" />迁移存储 </label>&nbsp;&nbsp; <label><input class="migoper" name="migoper" type="radio" value="3" />迁移主机和存储 </label></c:if>
		<c:if test="${curstat eq 'Expunging'}"><label><input class="migoper" name="migoper" type="radio" value="1" checked="checked" />迁移主机 </label>&nbsp;&nbsp;  <label><input class="migoper" name="migoper" type="radio" value="2" />迁移存储 </label>&nbsp;&nbsp; <label><input class="migoper" name="migoper" type="radio" value="3" />迁移主机和存储 </label></c:if>
			
			<table id="migrateTable" align="center"  style="width:100%">			
				<tr>
					<td class="FieldLabel2" style="border-top:!important;">集群内主机：</td>
					<td class="FieldInput2"><select class="text" id="vmipparam" name="vmipparam" style="width:350px; padding:0px; height:30px;">
							<option value="">请选择</option>
							
						<c:forEach items="${hostList}" var="vo">
							<option value="${vo}">${vo}</option>
							
							</c:forEach>
						</select><font id="migrateSelectIpTip"color="red" style="display:none">&emsp;请选择主机</font></td>
				</tr>
			</table>
		</form>
	</div>
</div>	
</body>
