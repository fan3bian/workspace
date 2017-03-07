<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="org.apache.struts2.ServletActionContext " %>
<%@ page import="com.inspur.icpmg.util.WebLevelUtil " %>

<%
String path = request.getContextPath();	

String userid = WebLevelUtil.getUserId(ServletActionContext.getRequest());
String username = WebLevelUtil.getUser(ServletActionContext.getRequest()).getUname();
String phone =  WebLevelUtil.getUser(ServletActionContext.getRequest()).getMobile();
String roid = WebLevelUtil.getRoleId(ServletActionContext.getRequest());

%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/validate.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/workOrder/workorder.css"/>

<script type="text/javascript">
function createAndSend(){
	document.getElementById('jspdo').value="create";
	document.getElementById('regionname').value=$('#regionid').combobox('getText');
	if ($('#editForm').form('validate')) {
		$('#submitBtn').linkbutton('disable');
		$('#editForm').form('submit',{
		    url:'<%=path%>/createServer.do',
		    onSubmit: function(){
		    },
		    success:function(data){
				if(data=="success"){
				$('#centerTab').load('<%=path%>/web/businessMg/workOrderMg/OrderMenu.jsp');
				}
				alert("创建成功！！！");
				$('#submitBtn').linkbutton('enable');
		    }
		});
	}
}
function saveAndSend(){
	document.getElementById('jspdo').value="save";
	document.getElementById('regionname').value=$('#regionid').combobox('getText');
	if ($('#editForm').form('validate')) {
		$('#saveBtn').linkbutton('disable');
		$('#editForm').form('submit',{
		    url:'<%=path%>/createServer.do',
		    onSubmit: function(){
		    },
		    success:function(data){
				if(data=="success"){
				$('#centerTab').load('<%=path%>/web/businessMg/workOrderMg/OrderMenu.jsp');
				}
				alert("保存成功！！！");
				$('#saveBtn').linkbutton('enable');
		    }
		});
	}
}
</script>

<div class="easyui-layout" fit="true" style="overflow-y: hidden" scroll="no">
	<form id="editForm" style="padding: 5px;" method="post" >
		<div style="padding:0 5px 0 5px;margin:10px 5px 0 40px;width: 95%;">
		    <strong>
		      	<a href="#" onclick="javascript:saveAndSend()" class="easyui-linkbutton" id="saveBtn" data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;&nbsp; 
		  		<a href="#" onclick="createAndSend()" class="easyui-linkbutton" id="submitBtn" data-options="iconCls:'icon-search'">提交</a>
			</strong>
		</div>
		<div id="main_frame" style="overflow:auto">
			<!-- 业务主键 -->
					
			<%-- <input type="hidden" name="cuserid"  id="cuserid" value="<%=userid%>" />
			<input type="hidden" name="steproleid"  id="steproleid" value="${vo.steproleid}" />
			<input type="hidden" name="flowtype"  id="flowtype" value="${vo.flowtype}" />
			<input type="hidden" name="shopid"  id="shopid" value="${vo.shopid}" />
			<input type="hidden" name="yesNextop"  id="yesNextop" value="${vo.yesNextop}" />
			<input type="hidden" name="stepname"  id="stepname" value="${vo.stepname}" />
			<input type="hidden" name="stepno"  id="stepno" value="${vo.stepno}" />
			<input type="hidden" name="modelname"  id="modelname" value="${vo.modelname}" />
			<input type="hidden" name="modelid"  id="modelid" value="${vo.modelid}" />
			<input type="hidden" name="stepnum"  id="stepnum" value="${vo.stepnum}" />
			<input type="hidden" name="modelver"  id="modelver" value="${vo.modelver}" />
			<input type="hidden" name="ftable"  id="ftable" value="${vo.ftable}" />
			<input type="hidden" name="fstatusid"  id="fstatusid" value="${vo.fstatusid}" />
			<input type="hidden" name="fstatus"  id="fstatus" value="${vo.fstatus}" />
			<input type="hidden" name="jspdo"  id="jspdo" value="" />
			<input type="hidden" name="regionname"  id="regionname" value="" /> --%>
			
			<!-- 工单号 -->
			<table id="toptable" align="center" style="width:90%">
				<caption  class="TicketTitle" ><strong><font class="Titlefont">政府用户注册申请</font></strong></caption>
			</table>
	
			<table class="wotable" align="center" style="width:90%">
				<tr>
					<td class="FieldLabel2" style="border-top:none !important;"><strong>工单标题</strong></td>
					<td class="FieldInput2" style="border-top:none !important;">
					<strong><input type="text" class="easyui-validatebox" data-options="required:true,validType:'length[4,50]'" name="flowname" id="flowname" style="width: 600px ! important; height: 25px;"/><font color="red">*</font></strong> </td>
				</tr>
			</table>
			
			<table class="wotable" align="center" style="width:90%">
				<tr>
					<td class="FieldLabel"><strong> 工单编号</strong></td>
					<td class="FieldInput">
						<strong><input type="text" id="flowtypename" name="flowtypename" value="${vo.flowtypename}" readonly="readonly" 
							style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;">
						</strong> 
					</td>
					<td class="FieldLabel"><strong> 订单编号</strong></td>
					<td class="FieldInput">
						<strong><input type="text" id="orderid" name="orderid" class="easyui-validatebox" data-options="required:true,validType:'englishOrNum'" 
							style="width: 200px ! important; height: 25px;"/>
						</strong>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="border-top:none !important;" ><strong>工单类别</strong></td>
					<td class="FieldInput" style="border-top:none !important;" >
						<strong><input type="text" id="cusername" name="cusername" value="<%=username%>" readonly="readonly" 
							style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;"></strong>
					</td>
					<td class="FieldLabel" style="border-top:none !important;" ><strong> 工单创建时间</strong></td>
					<td class="FieldInput" style="border-top:none !important;" >
						<strong><input type="text" id="phone" name="phone"  value="<%=phone%>" readonly="readonly" 
							style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;"></strong>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" ><strong> 创建人名称</strong></td>
					<td class="FieldInput" >
						<strong><input type="text" id="dorolename" name="dorolename" value="${vo.dorolename}" readonly="readonly" 
							style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;"></strong>
					</td>
				    <td class="FieldLabel" ><strong> 产品名称</strong></td>
					<td class="FieldInput" >
						<strong><input type="text" id="flowid" name="flowid" value="${vo.flowid}" readonly="readonly" 
							style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;"></strong>
					</td>
				</tr>
			</table>
			<table class="wotable" align="center" style="margin-top:15px;width:90%">
				<tr>
					<td class="FieldLabel"><strong>联系人部门</strong></td>
					<td class="FieldInput">
						<strong><input type="text" id="shopname" name="shopname" class="easyui-validatebox" data-options="required:true" readonly="readonly" value="${vo.shopname}" 
							style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;"/></strong>
					</td>
					<td class="FieldLabel"><strong>联系人</strong></td>
					<td class="FieldInput">
						<strong><input type="text" id="shopname" name="shopname" class="easyui-validatebox" data-options="required:true" readonly="readonly" value="${vo.shopname}" 
							style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;"/>
						</strong>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><strong>联系电话</strong></td>
					<td class="FieldInput">
						<strong>
							<input type="text" id="shopname" name="shopname" class="easyui-validatebox" data-options="required:true" readonly="readonly" value="${vo.shopname}" 
							style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;"/>
						</strong>
					 </td>
	                <td class="FieldLabel"><strong>注册邮箱</strong></td>
					<td class="FieldInput">
						<strong><input type="text" id="shopname" name="shopname" class="easyui-validatebox" data-options="required:true" readonly="readonly" value="${vo.shopname}" 
							style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;"/></strong>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><strong>手机号码</strong></td>
					<td class="FieldInput">
						<strong><input id="memnum" style="height: 25px;" name="memnum" class="easyui-validatebox" data-options="required:true,validType:'mone'"/></strong>
					</td>
	                <td class="FieldLabel"><strong>单位地址</strong></td>
					<td class="FieldInput">
						<strong><input id="intrabw" style="height: 25px;" name="intrabw" class="easyui-validatebox" data-options="required:true,validType:'mone'"/></strong>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><strong>父帐号</strong></td>
					<td class="FieldInput">
						<strong><input id="disknum" style="height: 25px;" name="disknum" class="easyui-validatebox" data-options="required:true,validType:'mone'"/></strong>
					</td>
	                <td class="FieldLabel"><strong>系统名称</strong></td>
					<td class="FieldInput">
						<strong><input id="interbw" style="height: 25px;" name="interbw" class="easyui-validatebox" data-options="required:true,validType:'mone'"/></strong>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><strong>用户名称</strong></td>
					<td class="FieldInput">
						<strong><input id="strnum" style="height: 25px;" name="strnum" class="easyui-validatebox" data-options="required:true,validType:'mone'"/></strong>
					</td>
	                <td class="FieldLabel"><strong>单位名称</strong></td>
					<td class="FieldInput">
						<strong><input id="ipnum" style="height: 25px;" name="ipnum" class="easyui-validatebox" data-options="required:true,validType:'integ'"/></strong>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><strong>帐号类型（1：父帐号，2：子帐号）</strong></td>
					<td class="FieldInput">
						<strong><input id="servernum" name="servernum" class="easyui-validatebox" data-options="required:true,validType:'integ'" style="height: 25px;"/></strong>
					</td>
				</tr>
			</table>
			<table class="wotable" align="center" style="width:90%">		
				<tr>
					<td  class="FieldLabel2" style="border-top:none !important;" ><strong>备注 <font color="red">(Max 500)</font></strong></td>
					<td class="FieldInput2" style="border-top:none !important;" ><strong><textarea rows="5" cols="100" name="snote"></textarea></strong></td>
				</tr>
			</table>
		</div>
	</form>
</div>