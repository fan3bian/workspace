<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 %>
<style type="text/css">
.dialogWrapper{background:#fff;width:750px;margin:0 auto;overflow:hidden;padding:30px 10px 20px 20px;}
.dialogWrapper .left{width:350px;float:left;margin-right:10px;overflow:hidden;}
.dialogWrapper .line{margin-bottom:5px;width:100%;overflow:hidden;float:left;}
.dialogWrapper .line label{display:inline-block;width:120px;text-align:right;}
.dialogWrapper .line label span{color:#ff3030;padding:0px 5px;}
.dialogWrapper .line input{width:200px;}
.dialogWrapper .line .ucrptype{width:200px;}

fieldset{color:#333; border:#06c dashed 1px;}
</style>

<script type="text/javascript" charset="utf-8">
//表单提交时验证
function updateStuffCheck(){
	if(stuff_add_addForm.male[0].checked){
		$('#ugender').val('0');	
	}
	if(stuff_add_addForm.male[1].checked){
		$('#ugender').val('1');
	}
	var isValid = false;
	isValid = $('#stuff_update_Form').form('validate');
	if(!isValid){
		return isValid;
	}
	return isValid;
}
</script>

<div id="stuff_update_dialog" class="easyui-dialog" data-options="title:'修改机房联系人',modal:true,inline:false,closed:true,draggable:true,resizable:true,closable:false,buttons:[{
				text:'取消',
				handler:function(){
					$('#stuff_update_Form input').val('');
					$('#stuff_update_dialog').dialog('close');
				}
			},{
				text:'保存',
				handler:function(){
					if(updateStuffCheck()){
						$('#stuff_update_Form').form('submit',{
							url:'${pageContext.request.contextPath}/crMgr/updateCRStuff.do',
							success:function(r){
								var obj = jQuery.parseJSON(r);
								if(obj.success){
									$('#stuff_update_dialog').dialog('close');
								}
								$.messager.show({
									title:'提示',
									msg:obj.msg
								});
								datagrid.datagrid('load');
							}
						});		
					}
				}
			}]">
	<div class="dialogWrapper">
		<form id="stuff_update_Form" method="post">
			<fieldset>
				<legend><span style="color:#06c;font-weight:800;background:#fff;">联系人基本信息</span></legend>
				<input type="hidden" id="ucrpid" name="crpid">
				<div class="left">
					<div class="line">
						<label><span>*</span>人员类型：</label>
						<input class="easyui-combobox ucrptype" id="ucrptype" name="crptype"
						 data-options="editable:false,required:true,panelHeight:100,valueField:'label',textField:'value',
						 data:[{label:'1',value:'机房联系人'},{label:'2',value:'入驻单位联系人'},{label:'3',value:'设备厂商联系人'}]"/>
					</div>
					<div class="line">
						<label><span>*</span>部门单位：</label>
						<input type="text" class='easyui-validatebox' id="uunit" name="unit" data-options="prompt:'联系人部门',validType:'length[2,30]',missingMessage:'请输入联系人部门'" />
					</div>
					<div class="line">
						<label>职务：</label>
						<input type="text" class='easyui-validatebox' id="uduty" name="duty" data-options="prompt:'职务',validType:'length[2,30]',missingMessage:'请输入单位名称'"/>
					</div>
					<div class="line">
						<label>固定电话：</label>
						<input type="text" class='easyui-validatebox' id="utelphone" name="telphone" data-options="prompt:'固定电话',validType:'mobileAndTel',missingMessage:'请输入固定电话'"/>
					</div>
					<div class="line">
						<label>传真：</label>
						<input type="text" class='easyui-validatebox' id="ufax" name="fax" data-options="prompt:'传真',validType:'fax',missingMessage:'请输入传真'" />
					</div>
				</div>
				<div class="left">
					<div class="line">
						<label><span>*</span>姓名：</label>
						<input type="text" class='easyui-validatebox' id="ucrpname" name="crpname" data-options="required:true,prompt:'姓名',validType:'length[2,10]',missingMessage:'有效长度2-10'"/>
					</div>
					<div class="line">
						<label><span>*</span>性别：</label>
						<input type="radio" name="male" value="0" style="width:20px;line-height:20px;" checked/><span style="width:80px;">男</span>
						<input type="radio" name="male" value="1" style="width:20px;line-height:20px;"/><span style="width:80px;">女</span>
						<input type="hidden" id="ugender" name="gender" />
					</div>
	 				<div class="line">
						<label><span>*</span>手机号码：</label>
						<input type="text" class='easyui-validatebox' id="umobile" name="mobile" data-options="required:true,prompt:'手机号',validType:'Mobile',missingMessage:'请输入手机号'"/>
					</div>
					<div class="line">
						<label><span>*</span>身份证号：</label>
						<input type="text" class='easyui-validatebox' id="uidcard" name="idcard" data-options="required:true,prompt:'身份证号',validType:'idCode',missingMessage:'身份证号'"/>
					</div>
					<div class="line">
						<label>邮箱：</label>
						<input type="text" class='easyui-validatebox' id="uemail" name="email" data-options="prompt:'邮箱',validType:['email','length[10,30]'],missingMessage:'请输入邮箱'" />
					</div>
				</div>
				<div class="line">
					<label>备注1：</label>
					<input type="text" class='easyui-textbox' id="umark1" name="mark1" data-options="width:563,height:100,multiline:true,validType:'length[0,200]'"/>
				</div>
				<div class="line">
					<label>备注2：</label>
					<input type="text" class='easyui-textbox' id="umark2" name="mark2" data-options="width:563,height:100,multiline:true,validType:'length[0,200]'"/>
				</div>
			</fieldset>
		</form>
	</div>	
</div>
