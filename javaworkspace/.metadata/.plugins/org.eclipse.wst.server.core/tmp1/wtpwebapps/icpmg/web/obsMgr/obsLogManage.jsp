<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<body>
	<div id="obs_tabs" class="easyui-tabs" style="width:100%;margin-left:20px;" data-options="fit:true" >
		<div id="tabs0" title="用户操作日志" data-options="fit:true,select:true" style="padding:21px 0px;background:#eee" >
<!-- 			<div id="obs_user_log_panel" class="easyui-panel" > -->
<!-- 			</div> --><jsp:include page="obsUserLog.jsp" />
		</div>
		<div id="tabs1" title="系统异常日志" data-options="fit:true" style="padding:21px 0px;background:#eee" >
			<div id="obs_sys_log_panel" class="easyui-panel" ></div>
		</div>
	</div>	
	<script>
	$(function(){
		$('#obs_tabs').tabs({
			border : false,
			onSelect : function(title, index) {
				 if (index == 0) {//服务监听配置
					 loadUserLogGrid();
				 }if (index == 1) {//后端服务器配置
					$("#obs_sys_log_panel").panel({
						href : '${pageContext.request.contextPath}/web/obsMgr/obsSysLog.jsp'
					});
				}
			}
		});
	});
</script>
</body>
