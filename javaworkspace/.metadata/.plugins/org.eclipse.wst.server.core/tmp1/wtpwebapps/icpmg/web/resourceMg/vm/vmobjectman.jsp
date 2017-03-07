<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<body>	
<div id="vm_tabs" class="easyui-tabs" style="width:100%;" data-options="tabWidth:112,fit:true,border:false" >
	<input type="hidden" id="tabs_vmid" value="${rmdVmVo.serverid}"/>
	<div id="tabs0" title="资源详情" data-options="fit:true,selected:true" style="padding:10px;background:#eee" >
		<jsp:include page="vmDetail.jsp" />
	</div>
	<div id="tabs1" title="磁盘信息" data-options="fit:true" style="padding:10px;background:#eee" >
		<jsp:include page="vmmandisk.jsp" />
	</div>
	<!-- <div id="tabs2" title="运行监控" data-options="fit:true" style="padding:10px;background:#eee" >
		<div id="vm_alarm" style="overflow:hidden;"></div> -->
	</div>
	<c:if test="${rmdVmVo.platformid eq 'vmware'}">
	<div id="tabs3" title="快照管理" data-options="fit:true" style="padding:10px;background:#eee;overflow:hidden;" >
		<div id="vm_snapshot" style="overflow:hidden;"></div>
	</div>
	</c:if>
</div>	
<script type="text/javascript">
	$(document).ready(function() {
		$('#vm_tabs').tabs({
			border : false,
			onSelect : function(title, index) {
				if (index == 3) {//快照管理
					$("#vm_snapshot").panel({
						href : '${pageContext.request.contextPath}/web/resourceMg/vm/vmsnapshot.jsp?vmid=' + $("#tabs_vmid").val()
					});
				}/* else if (index == 2) {//运行监控
					$("#vm_alarm").panel({
						href : '${pageContext.request.contextPath}/web/resourceMg/vm/vmmanalarm.jsp'
					});
				} */
			}
		});
	}); 
</script>
</body>
