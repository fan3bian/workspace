<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>

<style type="text/css">
body {
	margin-left: 10px;
	margin-top: 30px;
	margin-right: 10px;
}

.bg .header {
	font-family: "华文细黑", "时尚中黑简体", "微软雅黑";
	font-size: 18px;
	background-color: #36C;
	height: 60px;
	color: #FFF;
	text-align: center;
	font-weight: bolder;
}

.bg table {
	
}

.bg table tr td strong {
	
}

.bg table tr {
	background-color: #39C;
	font-size: 18px;
}

.bg table tr td {
	background-color: #FFF;
	font-size: 16px;
}
</style>
<script>
	function issure(){
		$("#details").parent().dialog('close');
	}
</script >
<div id="details" class="bg">
	<div style="height:10px"></div>

	<table width="95%" border="1" cellpadding="0" cellspacing="0"
		bordercolor="#999999" align="center">
		<tr align="center" class="header">
			<th height="60" colspan="6" bgcolor="#0B52D7" class="header" scope="col">客户需求表（域名申请）</th>
		</tr>
		<tr>
			<th colspan="6" align="left" scope="col">用户及应用信息</th>
		</tr>
		<tr>
			<td width="15%" align="center">用户单位</td>
			<td width="30%" align="center">${coprInfoVo.cmpyname}</td>
			<td colspan="2" align="center">业务应用</td>
			<td colspan="2" align="center">${coprInfoVo.bizlic}</td>
		</tr>
		<tr>
			<td align="center">联系人</td>
			<td align="center">${coprInfoVo.uname}</td>
			<td width="14%" align="center">联系电话</td>
			<td width="10%" align="center">${coprInfoVo.mobile}</td>
			<td width="6%" align="center">邮箱</td>
			<td width="15%" align="center">${coprInfoVo.email}</td>
		</tr>
	</table>
	<table width="95%" border="1" cellpadding="0" cellspacing="0"
		bordercolor="#999999" align="center">
		<tr align="left">
			<th colspan="7" scope="col">域名申请</th>
		</tr>
		<tr>
			<td align="center"><strong>工作域</strong></td>
			<td align="center"><strong>应用名</strong></td>
			<td align="center"><strong>IP</strong></td>
			<td align="center"><strong>域名等级</strong></td>
			<td align="center"><strong>域名</strong></td>
		</tr>

		<c:if test="${fn:length(bmdFlowdnVos) > 0}"> 
			<c:forEach items="${bmdFlowdnVos}" var="vo">
				<tr align="center">
					<td>${vo.workplace}</td>
					<td>${vo.appname}</td>
					<td>${vo.ip}</td>
					<td>
						<c:if test="${vo.level eq '2'}">二级域名</c:if> 
						<c:if test="${vo.level eq '3'}">三级域名</c:if>
					</td>
			 
					<td>${vo.domain}</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
					
	<div style="height:20px"></div>
	<input type="hidden" name="flowid" id="flowid" value="${flowid}" /> 
	<div align="center">
		<a href="#" onClick="javascript:issure();" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">关闭</a>
	</div>
</div>
