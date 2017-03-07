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
	if ($('#tableform').form('validate')) {
	var content = document.getElementById("file").value;
		if ( content.length==0 || content== null || content=="undefined" || content=='') { 
		
			$pjq.messager.alert('提示', '请选择要上传附件！', 'info'); 
			
           return false;
            }else{
		$('#tableform').form(
				'submit',
				{
					url : '${pageContext.request.contextPath}/oil/saveOilResearchInfo.do',
					onSubmit : function() {},
					success : function(retr) {
						var _data = $.parseJSON(retr);
						if (_data.success) {
							$pjq.messager.alert('提示', _data.msg, 'info');
							$grid.datagrid('unselectAll');
							$grid.datagrid('load');
							$dialog.dialog('destroy');
						} else {
							$pjq.messager.alert('提示', _data.msg, 'error');
						}
					}
				});
	}
	}
}
</script>
<body>		 
<div id="details" class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" style="padding:10px;">
		<form id="tableform" method="post" enctype="multipart/form-data">
			<table align="center"  style="width:100%">
				<tr>
					<td class="FieldLabel2" style="border-top:!important;">单位：</td>
					<td class="FieldInput2"><input id="company" style="height:30px;width:300px;" name="company" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel2" style="border-top:!important;">人员：</td>
					<td class="FieldInput2"><input id="submitperson" style="height:30px;width:300px;" name="submitperson" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel2" style="border-top:!important;">提交时间：</td>
					<td class="FieldInput2"><input id="stime" style="height:30px;width:300px;" name="stime" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel2" style="border-top:!important;">资料详实程度：</td>
					<td class="FieldInput2"><input id="dlevel" style="height:30px;width:300px;" name="dlevel" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<td class="FieldLabel2" style="border-top:!important;">排名：</td>
					<td class="FieldInput2"><input id="ranking" style="height:30px;width:300px;" name="ranking" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<td class="FieldLabel2" style="border-top:!important;">注意项目：</td>
					<td class="FieldInput2"><input id="iprojects" style="height:30px;width:300px;" name="iprojects" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<td class="FieldLabel2">附件：</td>
					<td class="FieldInput2"><input type="file" id="file" style="height: 30px; width: 300px;" name="file" value="" /><font color="red">选择文件*</font></td>
				</tr>
			</table>
		</form>
	</div>
</div>	
</body>
