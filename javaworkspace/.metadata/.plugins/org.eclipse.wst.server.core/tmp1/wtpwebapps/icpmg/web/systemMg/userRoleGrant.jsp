<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<script type="text/javascript">
function saveUserRoleGrant(){
	var fact_nodes = $('#fact_role_tree').tree('getChecked');
	var hollow_nodes = $('#hollow_role_tree').tree('getChecked');
	var ids = [];
	if(fact_nodes.length != 1){
		$.messager.alert('提示','实角色只能选择一个！','info');
		return;
	}
	for(i=0;i<fact_nodes.length;i++){
		ids.push(fact_nodes[i].id);
	}
	for(i=0;i<hollow_nodes.length;i++){
		ids.push(hollow_nodes[i].id);
	}
	$.post('${pageContext.request.contextPath}/authMgr/saveUserRoleGrand.do',{
		id : $('#user_email_id').val(),
		ids : ids.join(',')
	},function(result){
		if(result && result.success){
			$('#user_roleGrantDialog').dialog('close');
			$.messager.show({
				msg:result.msg,
				title:'成功'
			});
		}else{
			$.messager.alert('提示','分配角色失败！','error');
		}
	},'json');
};
</script>
<div id="user_roleGrantDialog" class="easyui-dialog" data-options="title:'用户角色授权',modal:true,closed:true,closable:false,width:400,height:400,buttons:[{
		text:'取消',
		handler:function(){
			$('#user_roleGrantDialog').dialog('close');
		}
	},{
		text:'保存',
		handler:function(){
			saveUserRoleGrant();
		}
	}]">
	<input id="user_email_id" name="email" readonly="readonly" type="hidden" />
	<div id="role_tabs" class="easyui-tabs">
		<div title="所有实角色">
			<fieldset>
				<!-- <legend>所属实角色:</legend> -->
				<ul id="fact_role_tree"></ul>
			</fieldset>
			<h2 style="color:red">注：实角色只能选择一个</h2>
		</div>
		<div title="所有虚角色">
			<fieldset>
				<!-- <legend>所属虚角色:</legend> -->
				<ul id="hollow_role_tree"></ul>
			</fieldset>
		</div>
	</div>
</div>