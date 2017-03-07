<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contactid = request.getParameter("contactid");
	if (contactid == null) {
		contactid = "";
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
		
		$('#tableform')
				.form(
						'submit',
						{
							url : '${pageContext.request.contextPath}/oil/contactSaveOrUpdate.do',
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
</script>

	<style type="text/css">
.FieldInput2 {
	width: 27%;
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
		data-options="fit:true,border:false" >
		<div data-options="region:'center',border:false"
			style="padding: 10px;">
			<form id="tableform" method="post" enctype="multipart/form-data">
				<input id="contactid" name="contactid" value="<%=contactid%>"
					type="hidden" />

				<table align="center" style="width: 100%">

					<tr>
						<td class="FieldLabel2" style="border-top:  !important;">
							联系人：
						</td>
						<td class="FieldInput2">
							<input id="cname" style="height: 30px; width: 200px;"
								name="cname" class="easyui-validatebox"
								data-options="required:true" />
							<font color="red">*</font>
						</td>
						<td class="FieldLabel2" style="border-top:  !important;">
							工号：
						</td>
						<td class="FieldInput2">
							<input id="jobnumber" style="height: 30px; width: 200px;"
								name="jobnumber" class="easyui-validatebox"
								data-options="required:true" />
							<font color="red">*</font>
						</td>

					</tr>
					<tr>
						<td class="FieldLabel2">
							联系电话：
						</td>
						<td class="FieldInput2">
							<input id="phone" style="height: 30px; width: 200px;"
								name="phone" class="easyui-validatebox"
								data-options="required:true" />
							<font color="red">*</font>
						</td>
						<td class="FieldLabel2">
							邮箱：
						</td>
						<td class="FieldInput2">
							<input id="email" style="height: 30px; width: 200px;"
								name="email" class="easyui-validatebox"
								data-options="required:true" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel2">
							一级部门：
						</td>
						<td class="FieldInput2">
							<input id="punitname" style="height: 30px; width: 200px;"
								name="punitname" class="easyui-validatebox"
								data-options="required:true" />
							<font color="red">*</font>
						</td>
						<td class="FieldLabel2">
							二级部门：
						</td>
						<td class="FieldInput2">
							<input id="unitname" style="height: 30px; width: 200px;"
								name="unitname" class="easyui-validatebox"
								data-options="required:true" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel2">
							三级部门：
						</td>
						<td class="FieldInput2">
							<input id="sunitname" style="height: 30px; width: 200px;"
								name="sunitname" class="easyui-validatebox"
								data-options="required:true" />
							<font color="red">*</font>
						</td>
						<td class="FieldLabel2">
							
						</td>
						<td class="FieldInput2">
							
						</td>
					</tr>
					<tr>
						<td class="FieldLabel2">
							工作方向：
						</td>
						<td colspan="3" class="FieldInput2">
							<textarea id="duty" name="duty"
								style="width: 80%; height: 100px;" class="easyui-validatebox"
								data-options="required:true"></textarea><font color="red">*</font>
						</td>
					</tr>
				</table>
			</form>
		</div>

	</div>
</body>
<script type="text/javascript">
$(function() {
	
	if ($(':input[name="contactid"]').val().length > 0) {

		$.ajax( {
			type : 'post',
			url : '${pageContext.request.contextPath}/oil/getContactById.do',
			data : {
				leId : $(':input[name="contactid"]').val()
			},
			success : function(retr) {
				var _data = eval('(' + retr + ')');

				if (_data[0].contactid != "") {

					$("#cname").val(_data[0].cname);
					$("#phone").val(_data[0].phone);
					$("#email").val(_data[0].email);
					$("#jobnumber").val(_data[0].jobnumber);
					$("#punitname").val(_data[0].punitname);
					$("#unitname").val(_data[0].unitname);
					$("#sunitname").val(_data[0].sunitname);
					$("#duty").val(_data[0].duty);

				}
			}
		});
	}
})
</script>