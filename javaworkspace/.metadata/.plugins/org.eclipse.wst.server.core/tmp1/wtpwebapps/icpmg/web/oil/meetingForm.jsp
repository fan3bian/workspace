<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String meetingid = request.getParameter("meetingid");
	if (meetingid == null) {
		meetingid = "";
	}
%>

<body>
	<jsp:include page="../inc.jsp"></jsp:include>
	
	<script type="text/javascript">

var closeWindows = function($dialog) {
	$dialog.dialog('destroy');
}

var submitForm = function($dialog, $gridLession, $pjq) {

	submitSave($dialog, $gridLession, $pjq);

}
var submitSave = function($dialog, $gridLession, $pjq) {
	if ($('#tableform').form('validate')) {
	
		//$('#saveBtn').linkbutton('disable');
		var content = document.getElementById("lessionFile").value;
		if ( content.length==0 || content== null || content=="undefined" || content=='') { 
		
			$pjq.messager.alert('提示', '请选择要上传附件！', 'info'); 
			
           return false;
            }else{
		$('#tableform')
				.form(
						'submit',
						{
							url : '${pageContext.request.contextPath}/oil/meetingsSaveOrUpdate.do',
							onSubmit : function() {

							},
							success : function(retr) {
								//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
							

							var _data = $.parseJSON(retr);
						
							if (_data.success) {
							
								$pjq.messager.alert('提示', _data.msg, 'info');
								$gridLession.datagrid('unselectAll');
								$gridLession.datagrid('load');
								$dialog.dialog('destroy');
							} else {
								$pjq.messager.alert('提示', _data.msg, 'error');
							}

						}
						});
		//$("#details").parent().dialog('destroy');
	}
	}
}
</script>

	<style type="text/css">
.FieldInput2 {
	width: 77%;
	height: 30px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}

.FieldLabel2 {
	width: 23%;
	height: 30px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
</style>
	<div id="details" class="easyui-layout"
		data-options="fit:true,border:false">
		<div data-options="region:'center',border:false"
			style="padding: 10px;">
			<form id="tableform" method="post" enctype="multipart/form-data">
				<input id="meetingid" name="meetingid" value="<%=meetingid%>"
					type="hidden" />

				<table align="center" style="width: 100%">

					<tr>
						<td class="FieldLabel2" style="border-top:  !important;">
							会议主题：
						</td>
						<td class="FieldInput2">
							<input id="meetingname" style="height: 30px; width: 300px;"
								name="meetingname" class="easyui-validatebox"
								data-options="required:true,validType:'length[1,60]'" />
							<font color="red">*</font>
						</td>

					</tr>
					<tr>
						<td class="FieldLabel2">
							会议时间：
						</td>
						<td class="FieldInput2">
							<input class="easyui-datebox" editable="false" name="mtimg"
								id="mtimg" style="width: 130px; height: 30px; border: false" data-options="required:true" >
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel2">
							参会人员：
						</td>
						<td class="FieldInput2">
							<textarea id="persons" name="persons"
								style="width: 80%; height: 60px;" class="easyui-validatebox"
								data-options="required:true"></textarea><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel2">
							内容概述：
						</td>
						<td class="FieldInput2">
							<textarea id="content" name="content"
								style="width: 80%; height: 100px;" class="easyui-validatebox"
								data-options="required:true,validType:'length[1,512]'"></textarea><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel2">
							附件：
						</td>
						<td class="FieldInput2">
						<input type="file" id="lessionFile" style="height: 30px; width: 300px;" name="lessionFiles" value="" />
						<font color="red">请选择相关附件*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel2">
							备注：
						</td>
						<td class="FieldInput2">
							<textarea id="iprojects" name="iprojects"
								style="width: 80%; height: 60px;" class="easyui-validatebox"
								></textarea>
						</td>
					</tr>
				</table>
			</form>
		</div>

	</div>
</body>
<script type="text/javascript">
$(function() {
	
	if ($(':input[name="meetingid"]').val().length > 0) {

		$.ajax( {
			type : 'post',
			url : '${pageContext.request.contextPath}/oil/getMeetingById.do',
			data : {
				leId : $(':input[name="meetingid"]').val()
			},
			success : function(retr) {
				var _data = eval('(' + retr + ')');

				if (_data[0].meetingid != "") {

					$("#meetingname").val(_data[0].meetingname);
					$("#mtimg").datebox('setValue',_data[0].mtimg);
					$("#persons").val(_data[0].persons);
					$("#content").val(_data[0].content);
					if (_data[0].iprojects != "") {
					$("#iprojects").val(_data[0].iprojects);
					}

				}
			}
		});
	}
})
</script>