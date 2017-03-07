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
			<th height="60" colspan="6" bgcolor="#0B52D7" class="header" scope="col">产品注销订单</th>
		</tr>
		 <tr >
      <th colspan="5" align="left" class="bg" scope="col">第一部分：配置信息</th>
    </tr>
		<tr align="left">
			<td colspan="5" scope="col">负载均衡配置</td>
		</tr>
		<tr>
			<td align="center"><strong>负载均衡序号</strong></td>
			<td align="center"><strong>实例名称</strong></td>
			<td align="center"><strong>实例类型</strong></td>
			<td align="center"><strong>最大连接数</strong></td>
			<td align="center"><strong>区域</strong></td>
		</tr>

		<c:if test="${fn:length(bmdFlowLbVos) > 0}">
			<c:forEach items="${bmdFlowLbVos}" var="vo">
				<tr align="center">
					<td>${vo.detailid}</td>
					<td>${vo.displayname}</td>
					<td>
						<c:if test="${vo.instatype eq '1'}">私有网络</c:if> 
						<c:if test="${vo.instatype eq '2'}">私有网络</c:if>
					</td>
					<td>${vo.connnum}</td>
					<td>${vo.regionname}</td>
				</tr>
				<tr>
					<td align="center"><strong>操作类型</strong></td>
					<td align="center"><strong>CPU（核）</strong></td>
					<td align="center"><strong>内存（G)</strong></td>
					<td align="center"><strong>硬盘(G)</strong></td>
					<td align="center"><strong>操作系统</strong></td>
				</tr>
				<tr>
					<td align="center">产品注销</td>
					<td align="center">${vo.cpunum}</td>
					<td align="center">${vo.memnum}</td>
					<td align="center">${vo.disknum}</td>
					<td align="center">${vo.osname}</td>
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
