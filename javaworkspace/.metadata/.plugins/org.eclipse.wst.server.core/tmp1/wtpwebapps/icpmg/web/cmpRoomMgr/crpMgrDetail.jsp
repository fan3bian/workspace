<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.inspur.icpmg.cmpRoomMg.vo.CRStuffInfoVo" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String crpvo = request.getParameter("crpvo");
%>
<style type="text/css">
.dialogWrapper{background:#fff;width:750px;margin:0 auto;overflow:hidden;padding:30px 10px 20px 20px;}
.dialogWrapper .left{width:350px;float:left;margin-right:10px;overflow:hidden;}
.dialogWrapper .line{margin-bottom:5px;width:100%;overflow:hidden;float:left;}
.dialogWrapper .line label{display:inline-block;width:120px;text-align:left;}
.dialogWrapper .line2{margin-bottom:5px;width:700px;overflow:hidden;float:left;}
.dialogWrapper .left .line .clor{color:#ff3030}
.dialogWrapper .line2 .clor{color:#ff3030}
</style>

<div id="stuff_detail_dialog" class="easyui-dialog" data-options="title:'详细信息',modal:true,inline:false,closed:true,draggable:true,resizable:true,closable:false,buttons:[{
	text:'取消',
	handler:function(){
		$('#stuff_detail_dialog').dialog('close');
	}
}]">
	<div class="dialogWrapper">
		<div class="left">
			<div class="line">
				<label class="clor">人员类型：</label>
				<label id="dcrptype"></label>
			</div>
			<div class="line">
				<label class="clor">部门单位：</label>
				<label id="dunit"></label>
			</div>
			<div class="line">
				<label class="clor">职务：</label>
				<label id="dduty"></label>
			</div>
			<div class="line">
				<label class="clor">固定电话：</label>
				<label id="dtelphone"></label>
			</div>
			<div class="line">
				<label class="clor">传真：</label>
				<label id="dfax"></label>
			</div>
		</div>
		<div class="left">
			<div class="line">
				<label class="clor">姓名：</label>
				<label id="dcrpname"></label>
			</div>
			<div class="line">
				<label class="clor">性别：</label>
				<label id="dgender"></label>
			</div>
				<div class="line">
				<label class="clor">手机号码：</label>
				<label id="dmobile"></label>
			</div>
			<div class="line">
				<label class="clor">身份证号：</label>
				<label id="didcard"></label>
			</div>
			<div class="line">
				<label class="clor">邮箱：</label>
				<label id="demail"></label>
			</div>
		</div>
		<div class="line2">
			<label class="clor">备注1：</label>
			<label id="dmark1" style="width:563,height:100"></label>
		</div>
		<div class="line2">
			<label class="clor">备注2：</label>
			<label id="dmark2" style="width:563,height:100"></label>
		</div>
	</div>	
</div>
