<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/web/inc.jsp" %>
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
var closeWindows = function($dialog) {
	$dialog.dialog('destroy');
}
var submitForm = function($dialog, $grid, $pjq) {
	submitSave($dialog, $grid, $pjq);
}
var submitSave = function($dialog, $grid, $pjq) {
			$('#tableform').form('submit',
				{
					url : '${pageContext.request.contextPath}/vm/saveVmSnapshot.do',
					onSubmit : function() {
					   $.blockUI({
		               message: "<h2>请求已发送,请稍后......</h2>",
		              css: {color:'#fff', border:'3px solid #aaa', backgroundColor:'#CCCCCC' },
		              overlayCSS: {opacity:'0.0'}
		             });
					},
					success : function(retr) {
					    $.unblockUI();
						var _data = $.parseJSON(retr);
						if (_data.success) {
							$pjq.messager.alert('提示', _data.msg, 'info');
							$grid.datagrid('unselectAll');
							$grid.datagrid('load');
							$dialog.dialog('destroy');
						} else {
							$pjq.messager.alert('提示', _data.msg, 'error');
							$dialog.dialog('destroy');
						}
					}
				});
}
</script>
<body>		 
<div id="details" class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" style="padding:10px;">
		<form id="tableform" method="post">
			<input type="hidden" name="serverid" value="<%=request.getParameter("serverid")%>"/>
			<table align="center"  style="width:100%">
				<tr>
					<td class="FieldLabel2" style="border-top:!important;">快照名称：</td>
					<td class="FieldInput2"><input id="displayname" style="height:30px;width:300px;" name="displayname" /><font color="red">默认值：快照创建时间</font></td>
				</tr>
			</table>
		</form>
	</div>
</div>	
</body>
