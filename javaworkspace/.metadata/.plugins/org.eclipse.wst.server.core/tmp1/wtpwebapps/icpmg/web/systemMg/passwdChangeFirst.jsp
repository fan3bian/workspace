<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String contextPath = request.getContextPath();
 %>

<style type="text/css">
.register{background:#fff;width:400px;margin:0 auto;overflow:hidden;padding:30px 10px 20px 20px;}
.register .line{margin-bottom:5px;width:100%;overflow:hidden;float:left;}
.register .line label{display:inline-block;width:120px;text-align:right;}
.register .line label span{color:#ff3030;padding:0px 5px;}
.register .line input{width:200px;}
fieldset{color:#333; border:#06c dashed 1px;}
</style>
<script type="text/javascript" src="<%=contextPath%>/js/validate.js"></script>
<script type="text/javascript" charset="utf-8">
	function passwdChangeCheckF(){
		var isValid = false;
		isValid = $('#passwdChangeFirst_Form').form('validate');
		return isValid;
	}
</script>
<div id="passwdChangeFirst_dialog" class="easyui-dialog" style="display: none;width:530px;height:260px" data-options="title:'首次登陆，请修改密码',modal:true,inline:false,closed:true,closable:false,buttons:[{
				text:'取消',
				handler:function(){
					$('#passwdChange_Form input').val('');
					$('#passwdChangeFirst_dialog').dialog('close');
					$.post('<%=basePath %>/userMgr/logout.do',function(){ window.location.reload(); });	
				}
			},{
				text:'保存',
				handler:function(){
					if(passwdChangeCheckF()){
						$('#passwdChangeFirst_Form').form('submit',{
							url:'${pageContext.request.contextPath}/authMgr/changePasswd.do',
							onSubmit:function(){
						           var flag = passwdChangeCheckF();
						           if(!flag){
						            return flag;  
						           }
						           return true;
						         },
							success:function(r){
									
								var obj = eval('('+r+')');
								if(obj.success){
									$('#passwdChangeFirst_dialog').dialog('close');
									$.messager.alert('提示','密码修改成功，请重新登录','info',function(){
										$.post('<%=basePath %>/userMgr/logout.do',function(){ window.location.reload(); });	
									});
								}else{
									$.messager.alert('提示',obj.msg+'修改失败，请重新修改');
								}
							}
						});		
					}
				}
			}]">
	<div class="register" >
		<div>您修改的当前用户帐号<span style="color:#FF910C">${sessionUser.email}</span></div>
		<form id="passwdChangeFirst_Form" method="post">
			<fieldset>
				<legend><span style="color:#06c;font-weight:800;background:#fff;">密码修改</span></legend>
				<input type="hidden" id="passwdChangeFirst_email" name="passwdChange_email" value=""/>
				<div class="line">
					<label><span>*</span>旧密码：</label>
					<input type="password" class='easyui-textbox text' name="passwdOld" data-options="required:true,missingMessage:'请输入旧密码'"/>
				</div>
				<div class="line">
					<label><span>*</span>新密码：</label>
					<input type="password" class='easyui-textbox text' id="passwdNew" name="passwdNew" data-options="required:true,validType:['pwdrange[6,16]','passCheck'],missingMessage:'请输入新密码'"/>
				</div>
				<div class="line">
					<label><span>*</span>确认新密码：</label>
					<input type="password" class='easyui-textbox text' name="repasswd" data-options="required:true,validType:['equalTo[\'#passwdChangeFirst_Form input[name=passwdNew]\']','passCheck'],missingMessage:'确认新密码'"/>
				</div>
			</fieldset>
		</form>
	</div>
</div>