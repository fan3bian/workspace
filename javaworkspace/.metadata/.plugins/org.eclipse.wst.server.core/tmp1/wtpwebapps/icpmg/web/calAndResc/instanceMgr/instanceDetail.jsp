<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	/* String csInstDetailVo = request.getParameter("csInstDetailVo"); */
	/* List<CSIPVo> csipList = csInstDetailVo.csipList; */
%>

<style type="text/css">
.dialogWrapper{background:#fff;width:750px;margin:0 auto;overflow:hidden;padding:30px 10px 20px 20px;}
</style>

<div id="instance_detail_dialog" class="easyui-dialog" data-options="title:'详细信息',modal:true,inline:false,closed:true,draggable:true,resizable:true,closable:false,buttons:[{
	text:'关闭',
	handler:function(){
		$('#instance_detail_dialog').dialog('close');
	}
}]">
	<div class="dialogWrapper">
		<div style="margin-left:20px;margin-top:5px;">
			<span style="font-weight:bold;">基本信息</span>
			<div style="margin-top:10px;margin-bottom:40px;">
				<p style="width:auto;float:left;">云服务器名称：${csInstDetailVo.servername}</p>
				<p style="width:auto;margin-left:30px;float:left;">所属用户：${csInstDetailVo.userid}</p>
				<p class="vmstatus" style="width:auto;margin-left:30px;float:left;">
					运行状态：
					<c:if test="${csInstDetailVo.curstat eq 'Running'}">运行中</c:if>
					<c:if test="${csInstDetailVo.curstat eq 'Stopped'}">停止</c:if>
					<c:if test="${csInstDetailVo.curstat eq 'Stopping'}">正在停止</c:if>
					<c:if test="${csInstDetailVo.curstat eq 'Starting'}">启动中</c:if>
					<c:if test="${csInstDetailVo.curstat eq 'Destroyed'}">已删除</c:if>
					<c:if test="${csInstDetailVo.curstat eq 'Expunging'}">正在销毁</c:if>
				</p>
				<%-- <p style="width:auto;margin-left:30px;float:left;">用途：${csInstDetailVo.description}</p> --%>
			</div>
			<div style="clear:both;"></div>
			<span style="font-weight:bold;">基础配置</span>
			<div style="margin-top:5px;margin-bottom:15px;">
				<table>
					<thead>
						<tr>
							<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">CPU核数</th>
							<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">内存</th>
							<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">云硬盘</th>
							<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">操作系统</th>
							<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">杀毒软件</th>
							<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">数据库</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;height:30px;width:120px;">${csInstDetailVo.cpunum} 核</td>
							<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;width:150px;">${csInstDetailVo.memnum} GB</td>
							<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;">${csInstDetailVo.disktotal} G</td>
							<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;width:220px;">${csInstDetailVo.osname}</td>
							<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;height:30px;">${csInstDetailVo.virus}
								<%-- <c:choose>
									<c:when test="${csInstDetailVo.antivirus eq '1'}">使用</c:when>
									<c:when test="${csInstDetailVo.antivirus eq '0'}">未使用</c:when>
									<c:otherwise>${csInstDetailVo.antivirus}</c:otherwise>
								</c:choose> --%>
							</td>
							<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;">${csInstDetailVo.idatabase}</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<span style="font-weight:bold;">IP地址信息</span>
			<div style="margin-top:5px;margin-bottom:15px;">
				<table>
				
				<thead>
					<tr>
						<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">网络名称</th>
						<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">IP地址</th>
						<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">子网掩码</th>
						<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">网关</th>
						<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">VLAN号</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${csInstDetailVo.csipList}" var="csipvo">
					<tr>
						<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">${csipvo.networkname}</td>
						<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">${csipvo.ip}</td>
						<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">${csipvo.subnetmark}</td>
						<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">${csipvo.gateway}</td>
						<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">${csipvo.vlan}</td>
					</tr>
					</c:forEach>
				</tbody>
				</table>
			</div>
			
			<span style="font-weight:bold;margin-top:40px;">端口信息</span>
			<div style="margin-top:5px;margin-bottom:20px;">
				<table>
					<thead>
						<tr>
							<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">接入模式</th>
							<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;height:30px;width:120px;">内网端口</th>
							<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">公网端口</th>
							<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">公网带宽(M)</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;">
								<c:if test="${vo.intermode eq '1'}">互联网</c:if>
								<c:if test="${vo.intermode eq '3'}">政务外网</c:if>
								<c:if test="${vo.intermode eq '2'}">政务专网</c:if>
							</td>
							<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;height:30px;width:120px;">${csInstDetailVo.intraport}</td>
							<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;">${vo.interport}</td>
							<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;">${vo.interbw}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>	
</div>
