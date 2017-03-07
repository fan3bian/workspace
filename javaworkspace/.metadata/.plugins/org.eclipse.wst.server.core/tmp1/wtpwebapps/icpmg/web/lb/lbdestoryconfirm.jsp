<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/web/inc.jsp" %>
<style type="text/css">
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
			$('#tableform_lbcancel').form('submit',
				{
					url : '${pageContext.request.contextPath}/vm/saveVmSnapshot.do',
					onSubmit : function() {
						$.blockUI({
							message : "<h2>请求已发送,请稍后......</h2>",
							css : {color : '#fff',border : '3px solid #aaa',backgroundColor : '#CCCCCC'},
							overlayCSS : {opacity : '0.0'}
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
							
							$("#lbdestory_").hide();
					    	$("#lb_status").text("状态：已删除");
						} else {
							$pjq.messager.alert('提示', _data.msg, 'error');
							$dialog.dialog('destroy');
						}
					}
		});
	}
</script>
<body>		 
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" style="padding:10px;">
		<form id="tableform_lbcancel" method="post">
			<input type="hidden" name="lbid_cancel" value="<%=request.getParameter("lbid")%>"/>
			<table align="center"  style="width:100%">
				<tr>
					<td class="FieldLabel2" style="border-top:!important;">当前资源释放之后将无法恢复，请谨慎操作，确定释放该资源吗？</td>
				</tr>
			</table>
		</form>
	</div>
</div>	
</body>
