<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="org.apache.struts2.ServletActionContext " %>
<%@ page import="com.inspur.icpmg.util.WebLevelUtil " %>

<%
String path = request.getContextPath();	

String userid = WebLevelUtil.getUserId(ServletActionContext.getRequest());
String username = WebLevelUtil.getUser(ServletActionContext.getRequest()).getUname();
String phone =  WebLevelUtil.getUser(ServletActionContext.getRequest()).getMobile();
String roid = WebLevelUtil.getRoleId(ServletActionContext.getRequest());

System.out.println("roid="+roid);
System.out.println("userid="+userid);
System.out.println("username="+username);
System.out.println("phone="+phone);

%>
<html>
<head>
<title>工单创建</title>
<meta charset="UTF-8">


</head>
<body class="easyui-layout" fit="true" style="overflow-y: hidden" scroll="no">

<script type="text/javascript" src="${pageContext.request.contextPath}/js/validate.js"></script>
<script type="text/javascript">



function createAndSend(){
		document.getElementById('jspdo').value="create";
		
		document.getElementById('regionname').value=$('#regionid').combobox('getText');
		
		//document.getElementById('editForm').submit();
			if ($('#editForm').form('validate')) {
			
				$('#submitBtn').linkbutton('disable');
			$('#editForm').form('submit',{
		    url:'<%=path%>/createServer.do',
		    onSubmit: function(){
		    },
		    success:function(data){
				if(data=="success"){
				$('#centerTab').load('<%=path%>/web/businessMg/workOrderMg/OrderMenu.jsp');
				alert("创建成功！！！");
				}else {
				alert("创建失败！！！");
				}
				
				$('#submitBtn').linkbutton('enable');
		    }
		});
		}
		//$('#editForm').submit();
	}
	function saveAndSend(){
		document.getElementById('jspdo').value="save";
		document.getElementById('regionname').value=$('#regionid').combobox('getText');
		//document.getElementById('editForm').submit();
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
	//	$('#editForm').submit();
	}
</script>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/workOrder/workorder.css"/>
<form id="editForm" style="padding: 5px;" method="post" >


<div style="padding:0 5px 0 5px;margin:10px 5px 0 40px;width: 95%;">
    <strong>
      	<a href="#" onclick="javascript:saveAndSend()" class="easyui-linkbutton" id="saveBtn" data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;&nbsp; 
  		<!--<a href="#" onclick="javascript:createAndSend()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">提交</a>-->
  		<a href="#" onclick="createAndSend()" class="easyui-linkbutton" id="submitBtn" data-options="iconCls:'icon-search'">提交</a>
	</strong>
</div>
<div id="main_frame" style="overflow:auto">

<!--	<form id="editForm"    onsubmit="return false" style="padding: 5px;" >  -->
	
		<!-- 业务主键 -->
				
		<input type="hidden" name="cuserid"  id="cuserid" value="<%=userid%>" />
		<input type="hidden" name="steproleid"  id="steproleid" value="${vo.steproleid}" />
		<input type="hidden" name="flowtype"  id="flowtype" value="${vo.flowtype}" />
		<input type="hidden" name="shopid"  id="shopid" value="${vo.shopid}" />
		<input type="hidden" name="yesnextop"  id="yesnextop" value="${vo.yesnextop}" />
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
		<input type="hidden" name="regionname"  id="regionname" value="" />
				
		
		<!-- 工单号 -->
		
		
		<table id="toptable" align="center" style="width:90%">
			<caption  class="TicketTitle" ><strong><font class="Titlefont">云服务器申请</font></strong></caption>
		</table>
	
		<table class="wotable" align="center" style="width:90%">
			<tr>
				<td class="FieldLabel2" style="border-top:none !important;"><strong>工单标题</strong></td>
				<td class="FieldInput2" style="border-top:none !important;">
				<strong><input type="text" class="easyui-validatebox" data-options="required:true,validType:'length[0,50]'" name="flowname" id="flowname" style="width: 600px ! important; height: 25px;"/><font color="red">*</font></strong> </td>
			</tr>
		</table>
		<table class="wotable" align="center" style="width:90%">
		<tr>
				<td class="FieldLabel"><strong> 工单类型</strong></td>
				<td class="FieldInput"><strong><input type="text" name="flowtypename" id="flowtypename" readonly="readonly" style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;" value="${vo.flowtypename}"></strong> 
				 </td>

				<td class="FieldLabel"><strong> 订单编号</strong></td>
				<td class="FieldInput">
				<strong><input type="text" class="easyui-validatebox" data-options="required:true,validType:'englishOrNum'" name="orderid" id="orderid" style="width: 200px ! important; height: 25px;"/></strong></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="border-top:none !important;" ><strong> 创建人</strong></td>
				<td class="FieldInput" style="border-top:none !important;" ><strong><input type="text" name="cusername" id="cusername" readonly="readonly" style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;" value="<%=username%>"></strong> </td>
					
				<td class="FieldLabel" style="border-top:none !important;" ><strong> 创建人联系电话</strong></td>
				<td class="FieldInput" style="border-top:none !important;" ><strong><input type="text" name="phone" id="phone" readonly="readonly" style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;" value="<%=phone%>"></strong> </td>
			</tr>
			<tr>
				<td class="FieldLabel" ><strong> 创建人角色</strong></td>
				<td class="FieldInput" ><strong><input type="text" name="dorolename" id="dorolename" readonly="readonly" style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;" value="${vo.dorolename}"></strong> </td>
			    <td class="FieldLabel" ><strong> 工单编号</strong></td>
				<td class="FieldInput" ><strong><input type="text" name="flowid" id="flowid" readonly="readonly" style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;" value="${vo.flowid}"></strong> </td>
				</tr>
		</table>
		
		<table class="wotable" align="center" style="margin-top:15px;width:90%">
	   		
			
			
				<tr>
				<td class="FieldLabel"><strong> 产品名称</strong></td>
				<td class="FieldInput"><strong><input type="text" id="shopname" class="easyui-validatebox" data-options="required:true" name="shopname" style="border: medium none  ! important; background: transparent none repeat scroll 0% 0% ! important; -moz-background-clip: -moz-initial ! important; -moz-background-origin: -moz-initial ! important; -moz-background-inline-policy: -moz-initial ! important; height: 25px;" readonly="readonly" value="${vo.shopname}"/></strong></td>
				 

				<td class="FieldLabel"><strong> 操作系统</strong></td>
				<td class="FieldInput"><strong><select id="osname" name="osname" class="easyui-combobox" data-options="panelHeight:'auto',editable:false" style="width: 200px; margin-left: 5px; height: 25px;"> 
				<option value="CentOS5.8-64bit">CentOS5.8-64bit</option> 
				<option value="CentOS6.4-64bit">CentOS6.4-64bit</option> 
				<option value="CentOS6.5-64bit">CentOS6.5-64bit</option> 
				<option value="CentOS7.0-64bit">CentOS7.0-64bit</option> 
				<option value="WinServer08-64bit">WinServer08-64bit</option> 
				<option value="WinServer12-64bit">WinServer12-64bit</option>
				<option value="Windows7-64bit">Windows7-64bit</option>
				<option value="Ubuntu12.04">Ubuntu12.04</option>
				<option value="Ubuntu14.04">Ubuntu14.04</option>
				</select></strong></td>
			</tr>
			
				<tr>
				<td class="FieldLabel"><strong> CPU核数</strong></td>
				<td class="FieldInput">
				<strong><select id="cpunumSelect" name="cpunum" class="easyui-combobox" data-options="panelHeight:'auto',editable:false" style="width: 200px; margin-left: 5px; height: 25px;"> 
				<option value="1">1核</option> 
				<option value="2">2核</option> 
				<option value="4">4核</option> 
				<option value="8">8核</option>   
				<option value="16">16核</option>
				<option value="32">32核</option> 
				</select></strong>
				 </td>
                <td class="FieldLabel"><strong> 是否独立虚拟防火墙</strong></td>
				<td class="FieldInput"><strong><select id="fwnum" name="fwnum" class="easyui-combobox" data-options="panelHeight:'auto',editable:false" style="width: 200px; margin-left: 5px; height: 25px;"><option value="0">No</option><option value="1">Yes</option></select></strong></td>
							
			</tr>
			
			<tr>
				<td class="FieldLabel"><strong> 内存大小</strong></td>
				<td class="FieldInput"><strong><input id="memnum" style="height: 25px;" name="memnum" class="easyui-validatebox" data-options="required:true,validType:'mone'"/><font color="red">（GB）</font></strong> </td>
				
                <td class="FieldLabel"><strong> 内网带宽</strong></td>
				<td class="FieldInput"><strong><input id="intrabw" style="height: 25px;" name="intrabw" class="easyui-validatebox" data-options="required:true,validType:'mone'"/><font color="red">（M）</font></strong></td>
        

							</tr>
			
				<tr>
				<td class="FieldLabel"><strong> 硬盘大小</strong></td>
				<td class="FieldInput"><strong><input id="disknum" style="height: 25px;" name="disknum" class="easyui-validatebox" data-options="required:true,validType:'mone'"/><font color="red">（GB）</font></strong></td>

                <td class="FieldLabel"><strong> 公网带宽</strong></td>
				<td class="FieldInput"><strong><input id="interbw" style="height: 25px;" name="interbw" class="easyui-validatebox" data-options="required:true,validType:'mone'"/><font color="red">（M）</font></strong></td>


							</tr>
			
				<tr>
				<td class="FieldLabel"><strong> 存储大小</strong></td>
				<td class="FieldInput"><strong><input id="strnum" style="height: 25px;" name="strnum" class="easyui-validatebox" data-options="required:true,validType:'mone'"/><font color="red">（GB）</font></strong></td>
                
                <td class="FieldLabel"><strong> 公网IP个数</strong></td>
				<td class="FieldInput"><strong><input id="ipnum" style="height: 25px;" name="ipnum" class="easyui-validatebox" data-options="required:true,validType:'integ'"/><font color="red">（个）*</font></strong></td>
                
							</tr>
							
							<tr>
				<td class="FieldLabel"><strong> 订单时长</strong></td>
				<td class="FieldInput">
				<strong><select id="tlong" name="tlong" class="easyui-combobox" data-options="panelHeight:'auto',editable:false" style="width: 200px; margin-left: 5px; height: 25px;"> 
				<option value="1">1月</option>
				<option value="2">2月</option>
				<option value="3">3月</option>
				<option value="4">4月</option>
				<option value="5">5月</option>
				<option value="6">6月</option>
				<option value="7">7月</option> 
				<option value="8">8月</option> 
				<option value="9">9月</option> 
				<option value="12">12月</option>   
				<option value="24">24月</option>
				<option value="36">36月</option>  
				</select></strong>
				 </td>
                <td class="FieldLabel"><strong>服务器数量</strong></td>
				<td class="FieldInput"><strong><input id="servernum" style="height: 25px;" name="servernum" class="easyui-validatebox" data-options="required:true,validType:'integ'"/><font color="red">（台）*</font></strong></td>
			</tr>
			
				<tr>
				<td class="FieldLabel"><strong>区域名称</strong></td>
				<td class="FieldInput">
				<strong><select id="regionid" name="regionid" onchange="onSelectName(this.form)" class="easyui-combobox" data-options="panelHeight:'auto',editable:false" style="width: 200px; margin-left: 5px; height: 25px;"> 
				   <option value="00001">济南</option>
				   <option value="00002">绵阳</option>
				   </select></strong>
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
	
	</body>
	

</html>