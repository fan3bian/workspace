<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/icp/include/taglib.jsp"%>
<head></head>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <body>
		<style type="text/css">
.register{background:#fff;width:400px;margin:0 auto;overflow:hidden;padding:30px 10px 20px 20px;}
.register .line{margin-bottom:5px;width:100%;overflow:hidden;float:left;}
.register .line label{display:inline-block;width:120px;text-align:right;}
.register .line label span{color:#ff3030;padding:0px 5px;}
.register .line input{width:200px;}
fieldset{color:#333; border:#06c dashed 1px;}
</style>
		<div class="register">
		<div>您修改的当前用户帐号<span style="color:#FF910C">${sessionUser.email}</span></div>
		<form id="passwdChange_Form" method="post">
			<fieldset>
				<legend><span style="color:#06c;font-weight:800;background:#fff;">密码修改</span></legend>
				<input type="hidden" id="passwdChange_email" name="passwdChange_email" value="${sessionUser.email}"/>
				<div class="line">
					<label><span>*</span>旧密码：</label>
					<input type="password" class='easyui-textbox text' name="passwdOld" data-options="required:true,missingMessage:'请输入旧密码'"/>
				</div>
				<div class="line">
					<label><span>*</span>新密码：</label>
					<input type="password" class='easyui-textbox text' name="passwdNew" data-options="required:true,validType:'pwdrange[6,16]',missingMessage:'请输入新密码'"/>
				</div>
				<div class="line">
					<label><span>*</span>确认新密码：</label>
					<input type="password" class='easyui-textbox text' name="repasswd" data-options="required:true,validType:'equalTo[\'#passwdChange_Form input[name=passwdNew]\']',missingMessage:'确认新密码'"/>
				</div>
			</fieldset>
		</form>
	</div>
	<script type="text/javascript" charset="utf-8">
	function passwdChangeCheck(){
		var isValid = false;
		isValid = $('#passwdChange_Form').form('validate');
		return isValid;
	}
</script>
  </body>
</html>
