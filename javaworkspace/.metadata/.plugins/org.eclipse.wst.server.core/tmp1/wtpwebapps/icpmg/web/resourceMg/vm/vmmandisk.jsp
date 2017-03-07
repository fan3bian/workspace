<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<%@ include file="/icp/include/taglib.jsp"%>
<table title="" style="width:100%;">
	<thead>
		<tr style="background-color: #81BFF1;">
			<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;height:30px;width:120px;">磁盘名称</th>
<!-- 			<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">所属用户</th> -->
			<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">平台名称</th>
			<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">磁盘容量(G)</th>
			<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">磁盘类型</th>
			<!-- <th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">挂载点</th> -->
			<th style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">状态</th>
		</tr>
	</thead>
	<tbody>

		<c:forEach items="${disks}" var="vo" >
		<tr style="background-color: #FFFFFF;">
			<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;height:30px;width:120px;">${vo.displayname}</td>	
		<%-- 	<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">${vo.userid}</td> --%>
			<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">${vo.platformid}</td>
			<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">${vo.disknum}</td>	
			<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;"><c:if test="${vo.disktype eq 'ROOT'}">系统盘</c:if><c:if test="${vo.disktype eq 'DATADISK'}">数据盘</c:if></td>
			<!-- <td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;">${vo.mountpoint}</td> -->
			<td style="text-align:center;padding-left:10px;border: 1px solid #95B8E7;width:120px;"><c:if test="${vo.curstat eq 'Ready'}">可使用</c:if><c:if test="${vo.curstat eq 'Allocated'}">已挂载</c:if></td>	
		</tr>
		</c:forEach>
	</tbody>
</table>

