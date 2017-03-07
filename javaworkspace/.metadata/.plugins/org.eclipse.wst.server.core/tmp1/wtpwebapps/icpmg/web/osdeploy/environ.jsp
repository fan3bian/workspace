<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<script>
	var content ="${pageContext.request.contextPath}";
</script>
<script type="text/javascript" src="${ctx}/web/osdeploy/js/osdeploy.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/web/osdeploy/css/osdeploy.css" type="text/css"/>
<script type="text/javascript">
	function newEnviron(){
		var environName =$('#environ').textbox('getValue').trim();
		var networkTypeId =$('#networkType').textbox('getValue');
		var networkTypeName =$('#networkType').textbox('getText');
		if(!environName){
			$.messager.alert('警告',"请填写名称！","warning");
            return false;
		}
		if(!networkTypeName){
			$.messager.alert('警告',"请选择应用场景！","warning");
            return false;
		}
		$.ajax({
			type:'post',
			url :'${pageContext.request.contextPath}/osdeploy/newEnviron.do',
			data:{
				environName:environName,
				networkTypeId:networkTypeId,
				networkTypeName:networkTypeName
			},
			async:false,
			dataType:'json',
			success:function(data){
				if(data.success){
					$.messager.alert('消息',data.msg,'info');
				}else{
					$.messager.alert('错误',data.msg,'error');
				}
			},
			error:function(){}
		});
		$('#new_environ_win').dialog('close');
		var topWindow = window.parent;
		//topWindow.location.herf="${pageContext.request.contextPath}/web/osdeploy/host.jsp";
		topWindow.$('#centerTab').panel({
			href:'${pageContext.request.contextPath}/osdeploy/queryEnvironList.do?'
		});
	}
	function tranferEnvironMg(environId,environName){
		
		window.$('#centerTab').panel({
			href:'${pageContext.request.contextPath}/osdeploy/enterEnviron.do?environId='+environId
		});
		$("#titletd").append("<span class=\"title\"> > "+environName+"</span>");
	}
</script>
<div class="env-content">
	<c:forEach items="${OsDeployEnvironVos}" var="vo">
	<div class="card" onclick="tranferEnvironMg('${vo.environid}','${vo.environname}')">
		<div class="card-top"><h4>${vo.environname}</h4></div>
		<div class="card-bottom">
			<div class="cell"><span class="value"><em>${vo.hostnum}</em></span><span class="item">主机总数</span></div>
			<div class="cell"><span class="value"><em>${vo.controlnum}</em></span><span class="item">控制节点</span></div>
			<div class="cell"><span class="value"><em>${vo.computenum}</em></span><span class="item">计算节点</span></div>
			<div class="cell"><span class="value"><em>${vo.storagenum}</em></span><span class="item">存储节点</span></div>
		</div>
	</div>
	</c:forEach>
	<div id="new_card" class="new-card">
		<div class="plus"><span>+</span></div>
		<div class="word">新建环境</div>
	</div>
</div>
<div id="new_environ_win" class="easyui-dialog" title="新建环境" style="width:400px;padding:10px;"
	data-options="closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false,buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: newEnviron        
         }, {
            text: '关闭',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#new_environ_win').dialog('close');
            }
        }]">
		<div style="height:100px;padding:10px;" >
			<form id="new_host_form">
				<div class="input-group">
					<label for=""class="control-label">名称:</label>
					<div class="control-input">
						<input id="environ" name="environ" class="stdtxt easyui-textbox" data-options="height:24,required:false,validType:'length[0,64]',missingMessage:'必填项'"/>
					</div>
				</div>
				<div class="input-group">
					<label for=""class="control-label">应用场景:</label>
					<div class="control-input">
						<input id="networkType" name="networkType" class="stdtxt easyui-combobox" data-options="height:24,required:false,validType:'length[0,64]',missingMessage:'必填项'"/>
					</div>
				</div>
			</form>
		</div>
</div>
