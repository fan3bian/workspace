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

<div id="access_detail_dialog" class="easyui-dialog" data-options="title:'详细信息',modal:true,inline:false,closed:true,draggable:true,resizable:true,closable:false,buttons:[{
	text:'取消',
	handler:function(){
		$('#access_detail_dialog').dialog('close');
	}
}]">
	<div class="dialogWrapper">
		<div class="left">
			<div class="line">
				<label class="clor">姓名：</label>
				<label id="dcraname"></label>
			</div>
			<div class="line">
				<label class="clor">性别：</label>
				<label id="dagender"></label>
			</div>
			<div class="line">
				<label class="clor">手机号码：</label>
				<label id="damobile"></label>
			</div>
			<div class="line">
				<label class="clor">单位部门：</label>
				<label id="daunit"></label>
			</div>
			<div class="line">
				<label class="clor">职务：</label>
				<label id="daduty"></label>
			</div>
			<div class="line">
				<label class="clor">邮箱：</label>
				<label id="daemail"></label>
			</div>
		</div>
		<div class="left">
			<div class="line">
				<label class="clor">证件类型：</label>
				<label id="didtype"></label>
			</div>
			<div class="line">
				<label class="clor">证件号码：</label>
				<label id="daidcard"></label>
			</div>
			<div class="line">
				<label class="clor">携带物品：</label>
				<label id="dgoods"></label>
			</div>
			<div class="line">
				<label class="clor">陪同人员：</label>
				<label id="dentourage"></label>
			</div>
			<div class="line">
				<label class="clor">进入时间：</label>
				<label id="dintime"></label>
			</div>
			<div class="line">
				<label class="clor">离开时间：</label>
				<label id="douttime"></label>
			</div>
		</div>
		<div class="line2">
			<label class="clor">备注：</label>
			<label id="dmark" style="width:563,height:100"></label>
		</div>
	</div>	
</div>
