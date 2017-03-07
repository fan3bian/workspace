<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<div style="margin-left:20px;margin-top:5px;">
	<span style="font-weight:bold;">基本信息</span>
	<div style="margin-top:10px;margin-bottom:40px;">
		<p style="width:auto;float:left;">名称：${rmdVmVo.serverid}</p>
		<p class="vmstatus" style="width:auto;margin-left:30px;float:left;">
		状态：
		<c:if test="${rmdVmVo.curstat eq 'Running'}">运行中</c:if>
		<c:if test="${rmdVmVo.curstat eq 'Stopped'}">停止</c:if>
		<c:if test="${rmdVmVo.curstat eq 'Stopping'}">正在停止</c:if>
		<c:if test="${rmdVmVo.curstat eq 'Starting'}">启动中</c:if>
		<c:if test="${rmdVmVo.curstat eq 'Destroyed'}">已删除</c:if>
		<c:if test="${rmdVmVo.curstat eq 'Expunging'}">正在销毁</c:if>
		</p>
		<p style="width:auto;margin-left:30px;float:left;">单位：${rmdVmVo.unitname}</p>
		<%-- <p style="width:auto;margin-left:30px;float:left;">名称：${rmdVmVo.displayname}</p> --%>
		<p style="width:auto;margin-left:30px;float:left;">应用名称：${rmdVmVo.appname}</p>
	</div>
    <div style="margin-top:10px;margin-bottom:30px;">
        <p class="vmstatus" style="width:auto;float:left;">
                  所属宿主机：
           <c:out value="${rmdVmVo.hostid}"></c:out>
        </p>

    </div>
	<div style="clear:both;margin-bottom: 10px"></div>
	<span style="font-weight:bold">基础配置</span>
	<div style="margin-top:10px;margin-bottom:15px;">
		<table>
			<tbody>
				<tr>
					<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;height:30px;width:120px;">CPU：${rmdVmVo.cpunum} 核</td>
					<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;width:150px;">内存：${rmdVmVo.memnum} GB</td>
					<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;width:220px;">操作系统：${rmdVmVo.osname}</td>
				</tr>
				<tr>
					<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;height:30px;">杀毒软件：<c:choose><c:when test="${rmdVmVo.antivirus eq '1'}">使用</c:when><c:when test="${rmdVmVo.antivirus eq '0'}">未使用</c:when><c:otherwise>${rmdVmVo.antivirus}</c:otherwise></c:choose></td>
					<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;">数据盘：${rmdVmVo.data} G</td>
				</tr>
			</tbody>
		</table>
	</div>
<%-- 	<span style="font-weight:bold;">内网IP</span>
	<div style="margin-top:5px;margin-bottom:15px;">
		<c:forEach items="${vmNetworkVos}" var="vo">${vo.ip}；</c:forEach>
	</div> --%>
	<span style="font-weight:bold;margin-top:40px;">IP端口映射</span>
	<div style="margin-top:5px;margin-bottom:20px;">
		<table>
		<c:forEach items="${vmNetworkVos}" var="vo">
			<thead>
				<tr>
					<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;height:30px;width:120px;">内网IP</th>
					<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">内网端口</th>
					<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">域名</th>
					<c:if test="${vo.networktype eq '0001'}">
					
					  <th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">外网IP</th>
					</c:if>
					<c:if test="${vo.networktype eq '0002'}">
					  <th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">联通IP</th>
					  <th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">电信IP</th>
					</c:if>
					
					<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">外网端口</th>
				</tr>
			</thead>
			<tbody>
				 
				<tr>
					<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;height:30px;width:120px;">${vo.interaip}</td>
					<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;">${vo.interaport}</td>
					<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;">${vo.domainname}</td>
					<c:if test="${vo.networktype eq '0001'}">
					
					  <th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">${vo.interipgov}</th>
					</c:if>
					<c:if test="${vo.networktype eq '0002'}">
					  <th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">${vo.interipunincom}</th>
					  <th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">${vo.interiptelecom}</th>
					</c:if>
					 
					<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;">${vo.interport}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div style="">
		<c:if test="${rmdVmVo.platformid eq 'vmware'}">
	    <a id="vmdetail_migrate_btn" href="javascript:void(0);" class="easyui-linkbutton" style="float:right;margin-right:10px;" onclick="migrate('${rmdVmVo.serverid}','${rmdVmVo.servername}');">虚机迁移</a>
		</c:if>
		<a id="vmdetail_open_btn" href="javascript:void(0);" class="easyui-linkbutton" style="float:right;margin-right:10px;" onclick="openConsole('${rmdVmVo.serverid}');">连接管理终端</a>
		<c:if test="${rmdVmVo.curstat eq 'Running'}">
		<a id="vmdetail_shutdown_btn" href="javascript:void(0);" class="easyui-linkbutton" style="float:right;margin-right:10px;" onclick="operate('${rmdVmVo.serverid}', 'shutdown','${rmdVmVo.servername}')">停      止</a>
		<a id="vmdetail_restart_btn" href="javascript:void(0);" class="easyui-linkbutton" style="float:right;margin-right:10px;" onclick="operate('${rmdVmVo.serverid}', 'restart','${rmdVmVo.servername}')">重      启</a>
		</c:if>
		<c:if test="${rmdVmVo.curstat eq 'Stopped'}">
		<a id="vmdetail_start_btn" href="javascript:void(0);" class="easyui-linkbutton" style="float:right;margin-right:10px;" onclick="operate('${rmdVmVo.serverid}', 'start','${rmdVmVo.servername}')">启     动</a>
		</c:if>
	</div>
	<form id="vm_operate" method="post"></form>
</div>
<script type="text/javascript">
	var basePath = "${pageContext.request.contextPath}";
</script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/web/resourceMg/vm/js/vmdetail.js"></script>