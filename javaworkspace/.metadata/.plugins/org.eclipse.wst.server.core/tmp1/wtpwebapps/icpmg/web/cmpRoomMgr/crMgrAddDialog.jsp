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
.dialogWrapper .line .crptype{width:200px;}

fieldset{color:#333; border:#06c dashed 1px;}
</style>

<script type="text/javascript" charset="utf-8">
//表单提交时验证
function addStuffCheck(){
	//var value = $('#crptype').combobox('getValue');
	//var text = $('#crptype').combobox('getText');
	if(stuff_add_addForm.male[0].checked){
		$('#gender').val('0');	
	}
	if(stuff_add_addForm.male[1].checked){
		$('#gender').val('1');
	}
	var isValid = false;
	isValid = $('#stuff_add_addForm').form('validate');
	if(!isValid){
		return isValid;
	}
	return isValid;
}
</script>

<div id="stuff_add_dialog" class="easyui-dialog" data-options="title:'增加机房联系人',modal:true,inline:false,closed:true,draggable:true,resizable:true,closable:false,buttons:[{
				text:'取消',
				handler:function(){
					$('#stuff_add_addForm input').val('');
					$('#stuff_add_dialog').dialog('close');
				}
			},{
				text:'保存',
				handler:function(){
					if(addStuffCheck()){
						$('#stuff_add_addForm').form('submit',{
							url:'${pageContext.request.contextPath}/crMgr/addCRStuff.do',
							success:function(r){
								var obj = jQuery.parseJSON(r);
								if(obj.success){
									$('#stuff_add_dialog').dialog('close');
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
		<form id="stuff_add_addForm" method="post">
			<fieldset>
				<legend><span style="color:#06c;font-weight:800;background:#fff;">联系人基本信息</span></legend>
				<input type="hidden" id="crpid" name="crpid">
				<div class="left">
					<div class="line">
						<label><span>*</span>人员类型：</label>
						<select class="easyui-combobox crptype" id="crptype" name="crptype" 
							data-options="editable:false,required:true,panelHeight:100">
							<option value="1" selected="selected">机房联系人</option>
							<option value="2">入驻单位联系人</option>
							<option value="3">设备厂商联系人</option>
						</select>
					</div>
					<div class="line">
						<label><span>*</span>部门单位：</label>
						<input type="text" class='easyui-textbox' id="unit" name="unit" data-options="prompt:'联系人部门',validType:'length[2,30]',missingMessage:'请输入联系人部门'" />
					</div>
					<div class="line">
						<label>职务：</label>
						<input type="text" class='easyui-textbox' id="duty" name="duty" data-options="prompt:'职务',validType:'length[2,30]',missingMessage:'请输入联系人职务'"/>
					</div>
					<div class="line">
						<label>固定电话：</label>
						<input type="text" class='easyui-textbox' id="telphone" name="telphone" data-options="prompt:'固定电话',validType:'mobileAndTel',missingMessage:'请输入固定电话'"/>
					</div>
					<div class="line">
						<label>传真：</label>
						<input type="text" class='easyui-textbox' id="fax" name="fax" data-options="prompt:'传真',validType:'fax',missingMessage:'请输入传真'" />
					</div>
				</div>
				<div class="left">
					<div class="line">
						<label><span>*</span>姓名：</label>
						<input type="text" class='easyui-textbox' id="crpname" name="crpname" data-options="required:true,prompt:'姓名',validType:'length[2,10]',missingMessage:'有效长度2-10'"/>
					</div>
					<div class="line">
						<label><span>*</span>性别：</label>
						<!-- <input type="radio" id="male" name="male" value="0" style="width:20px;line-height:20px;" checked/><sapn style="width:20px">男</sapn>
						<input type="radio"　id="female" name="male" value="1" style="width:20px;line-height:20px;"/><span style="width:20px;">女</span>
						<input type="hidden" id="gender" name="gender" /> -->
						<input type="radio" name="male" value="0" style="width:20px;line-height:20px;" checked/><span style="width:80px;">男</span>
						<input type="radio" name="male" value="1" style="width:20px;line-height:20px;"/><span style="width:80px;">女</span>
						<input type="hidden" id="gender" name="gender" />
					</div>
	 				<div class="line">
						<label><span>*</span>手机号码：</label>
						<input type="text" class='easyui-textbox' id="mobile" name="mobile" data-options="required:true,prompt:'手机号',validType:'Mobile',missingMessage:'请输入手机号'"/>
					</div>
					<div class="line">
						<label><span>*</span>身份证号：</label>
						<input type="text" class='easyui-textbox' id="idcard" name="idcard" data-options="required:true,prompt:'身份证号',validType:'idCode',missingMessage:'身份证号'"/>
					</div>
					<div class="line">
						<label>邮箱：</label>
						<input type="text" class='easyui-textbox' id="email" name="email" data-options="prompt:'邮箱',validType:['email','length[10,30]'],missingMessage:'请输入邮箱'" />
					</div>
				</div>
				<div class="line">
					<label>备注1：</label>
					<input type="text" class='easyui-textbox' id="mark1" name="mark1" data-options="width:563,height:100,multiline:true,validType:'length[0,200]'"/>
				</div>
				<div class="line">
					<label>备注2：</label>
					<input type="text" class='easyui-textbox' id="mark2" name="mark2" data-options="width:563,height:100,multiline:true,validType:'length[0,200]'"/>
				</div>
			</fieldset>
		</form>
	</div>	
</div>
