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
.dialogWrapper .line .idtype{width:200px;}

fieldset{color:#333; border:#06c dashed 1px;}
</style>

<script type="text/javascript" charset="utf-8">
function setIDCardDiv(){
	var value = $('#idtype').combobox('getValue');
	//var text = $('#idtype').combobox('getText');
	if(value == 2){
		$('#jszhdiv').show();
		$('#jgzhdiv').hide();
		$('#shfzhdiv').hide();
		$('#jszh').textbox({required:true});
		$('#jgzh').textbox({required:false});
		$('#idcard').textbox({required:false});
	}
	if(value == 3){
		$('#jgzhdiv').show();
		$('#jszhdiv').hide();
		$('#shfzhdiv').hide();
		$('#jszh').textbox({required:false});
		$('#jgzh').textbox({required:true});
		$('#idcard').textbox({required:false});
	}
	if(value ==1){
		$('#shfzhdiv').show();
		$('#jgzhdiv').hide();
		$('#jszhdiv').hide();
		$('#jszh').textbox({required:false});
		$('#jgzh').textbox({required:false});
		$('#idcard').textbox({required:true});
	}
}
//表单提交时验证
function addAccessCheck(){
	//var value = $('#idtype').combobox('getValue');
	//var text = $('#idtype').combobox('getText');
	if(crAccess_add_addForm.male[0].checked){
		$('#gender').val('0');	
	}
	if(crAccess_add_addForm.male[1].checked){
		$('#gender').val('1');
	}
	var isValid = false;
	isValid = $('#crAccess_add_addForm').form('validate');
	if(!isValid){
		return isValid;
	}
	return isValid;
}
</script>

<div id="crAccess_add_dialog" class="easyui-dialog" data-options="title:'增加进出机房人员记录',modal:true,inline:false,closed:true,draggable:true,resizable:true,closable:false,buttons:[{
				text:'取消',
				handler:function(){
					$('#crAccess_add_addForm input').val('');
					$('#crAccess_add_dialog').dialog('close');
				}
			},{
				text:'保存',
				handler:function(){
					if(addAccessCheck()){
						$('#crAccess_add_addForm').form('submit',{
							url:'${pageContext.request.contextPath}/crMgr/addCRAccessPersnl.do',
							success:function(r){
								var obj = jQuery.parseJSON(r);
								if(obj.success){
									$('#crAccess_add_dialog').dialog('close');
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
		<form id="crAccess_add_addForm" method="post">
			<!-- <fieldset> -->
				<!-- <legend><span style="color:#06c;font-weight:800;background:#fff;">机房出入记录</span></legend> -->
				<input type="hidden" id="craid" name="craid">
				<input type="hidden" id="gender" name="gender" value="0" />
				<div class="left">
					<div class="line">
						<label><span>*</span>姓名：</label>
						<input type="text" class='easyui-textbox' id="craname" name="craname" data-options="required:true,prompt:'访问人员姓名',validType:'length[2,10]',missingMessage:'有效长度2-10'"/>
					</div>
					<div class="line">
						<label><span>*</span>手机号码：</label>
						<input type="text" class='easyui-textbox' id="mobile" name="mobile" data-options="required:true,prompt:'手机号',validType:'Mobile',missingMessage:'请输入手机号'"/>
					</div>
					<div class="line">
						<label><span>*</span>单位部门：</label>
						<input type="text" class='easyui-textbox' id="unit" name="unit" data-options="prompt:'单位部门',validType:'length[2,30]',missingMessage:'请输入访问人员单位部门'" />
					</div>
					<div class="line">
						<label>职务：</label>
						<input type="text" class='easyui-textbox' id="duty" name="duty" data-options="prompt:'职务',validType:'length[2,30]',missingMessage:'请输入职务'"/>
					</div>
					<div class="line">
						<label>邮箱：</label>
						<input type="text" class='easyui-textbox' id="email" name="email" data-options="prompt:'邮箱',validType:['email','length[8,30]'],missingMessage:'请输入邮箱'" />
					</div>
				</div>
				<div class="left">
					<div class="line">
						<label><span>*</span>证件类型：</label>
						<input class="easyui-combobox idtype" id="idtype" name="idtype"
						 data-options="editable:false,panelHeight:100,valueField:'label',textField:'value',
						 	data:[{label:'1',value:'身份证'},{label:'2',value:'驾驶证'},{label:'3',value:'军官证'}],
						 	onSelect:function(){
						 		setIDCardDiv();
						 	}"/>
					</div>
					<div class="line" id="shfzhdiv">
						<label><span>*</span>证件号码：</label>
						<input type="text" class='easyui-textbox' id="idcard" name="idcard" data-options="required:true,prompt:'身份证号码',validType:'idCode',missingMessage:'身份证号'"/>
					</div>
					<div class="line" id="jszhdiv">
						<label><span>*</span>证件号码：</label>
						<input type="text" class='easyui-textbox' id="jszh" name="idcard_jszh" data-options="required:true,prompt:'驾驶证号码',validType:'jszCode',missingMessage:'驾驶证号码'"/>
					</div>
					<div class="line" id="jgzhdiv">
						<label><span>*</span>证件号码：</label>
						<input type="text" class='easyui-textbox' id="jgzh" name="idcard_jgzh" data-options="required:true,prompt:'军官证号码',validType:'jgzCode',missingMessage:'军官证号码'"/>
					</div>
					<div class="line">
						<label>陪同人员：</label>
						<input type="text" class='easyui-textbox' id="entourage" name="entourage" data-options="prompt:'陪同人员个数',validType:'number',missingMessage:'陪同人员数量'" />
					</div>
					<div class="line">
						<label>进入时间：</label>
						<input type="text" class='easyui-datetimebox' id="intime" name="intime" data-options="prompt:'进入时间',editable:false" />
					</div>
					<div class="line">
						<label>离开时间：</label>
						<input type="text" class='easyui-datetimebox' id="outtime" name="outtime" data-options="prompt:'离开时间',editable:false" />
					</div>
				</div>
				<div class="line">
						<label>事由：</label>
						<input type="text" class='easyui-textbox' id="thing" name="thing" data-options="width:563,height:100,multiline:true,validType:'length[0,200]'',missingMessage:'事由'"/>
				</div>
				<div class="line">
						<label>携带物品：</label>
						<input type="text" class='easyui-textbox' id="goods" name="goods" data-options="width:563,height:100,multiline:true,validType:'length[0,200]'',missingMessage:'携带物品'"/>
				</div>
				<div class="line">
					<label>备注：</label>
					<input type="text" class='easyui-textbox' id="mark" name="mark" data-options="width:563,height:100,multiline:true,validType:'length[0,200]'"/>
				</div>
			<!-- </fieldset> -->
		</form>
	</div>	
</div>
