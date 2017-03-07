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

<html>
<head>
<title>工单创建</title>
<meta charset="UTF-8">
</head>
<body class="easyui-layout" fit="true" style="overflow-y: hidden" scroll="no">
<style type="text/css">
.rescAWrapper{background:#F0F8FF;width:900px;margin:0 auto;overflow:hidden;padding:20px 20px 20px 20px;}
.rescAWrapper .formbtn{margin:5px 0px 5px 0px;width: 100%;}
.rescAWrapper .title{text-align:center;border:#BCD2EE 1px solid;}
.rescAWrapper .title .titlefont{font-size:20px;color:#4048B0;font-family:"arial";}
.rescAWrapper .workOrderBody{margin:0px auto;padding:0px 0px 0px 0px;overflow:hidden;}
.rescAWrapper .workOrderBody .line{border:#BCD2EE 1px solid;width:896px;overflow:hidden;float:left;}
.rescAWrapper .workOrderBody .line label{border-right:#BCD2EE 1px solid;display:inline-block;width:15%;height:25px;text-align:center;vertical-align: middle;font: normal 14px tahoma, arial, helvetica, sans-serif;}
.rescAWrapper .workOrderBody .line .wbk{width:140px;height:25px;}
.rescAWrapper .workOrderBody .line .textlength{width:744px;}
.rescAWrapper .rescABody{margin:15px auto;overflow:hidden;padding:0px 0px 0px 0px;}
.rescAWrapper .rescABody .line{border:#BCD2EE 1px solid;width:896px;overflow:hidden;float:left;}
.rescAWrapper .rescABody .line label{border-right:#BCD2EE 1px solid;display:inline-block;width:15%;height:25px;text-align:center;vertical-align: middle;font: normal 14px tahoma, arial, helvetica, sans-serif;}
.rescAWrapper .rescABody .line .wbk{width:140px;height:25px;}
.rescAWrapper .rescABody .line .textlength{width:744px;}
.rescAWrapper .rescABody .line .checkboxline{width:84%;height:100px;float:right;text-align:left;}
.rescAWrapper .rescABody .line .purpose{width:15%;height:50px;border-right:#BCD2EE 1px solid;display:inline-block;text-align:center;vertical-align: middle;font: normal 14px tahoma, arial, helvetica, sans-serif;}
.rescAWrapper .rescABody .line .sqywlx{width:15%;height:100px;border-right:#BCD2EE 1px solid;display:inline-block;text-align:center;font: normal 14px tahoma, arial, helvetica, sans-serif;}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/validate.js"></script>
<script type="text/javascript">
function setCheckboxValues(){
	$('.rescABody .line .checkboxline input').each(function(index,element){
		if(element.checked){
			$(element).val("on");
		}else{
			$(element).val("off");
		}
	});
}
/* 提交按钮动作 */
function createAndSend(){
	document.getElementById('jspdo').value="create";
	/*setCheckboxValues();	检验设置各个checkbox的值*/
	var isValid = false;
	isValid = $('#resourceApplyForm').form('validate');
	if(isValid){
		$('#submitBtn').linkbutton('disable');
		$('#resourceApplyForm').form('submit',{
	    	url:'<%=path%>/createBusinessResApply.do',
	   		onSubmit: function(){
	    	},
	    	success:function(data){
	    		var obj = jQuery.parseJSON(data);
	    		if(obj.success){
					$('#centerTab').load('<%=path%>/web/businessMg/workOrderMg/OrderMenu.jsp');
				}
				$.messager.show({
					title:'提示',
					msg:obj.msg
				});
				$('#submitBtn').linkbutton('enable');
	    	}
		});
	}
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
<div class="rescAWrapper">
	<form id="resourceApplyForm" method="post" >
		<div class="formbtn">
	      	<!-- <a href="#" onclick="saveAndSend()" class="easyui-linkbutton" id="saveBtn" data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;&nbsp;  -->
	  		<a href="#" onclick="createAndSend()" class="easyui-linkbutton" id="submitBtn" data-options="iconCls:'icon-search'">提交</a>
		</div>
		<!-- 业务主键 -->
		<input type="hidden" name="cuserid"  id="cuserid" value="<%=userid%>" />
		<input type="hidden" name="steproleid"  id="steproleid" value="${braVo.steproleid}" />
		<input type="hidden" name="flowtype"  id="flowtype" value="${braVo.flowtype}" />
		<input type="hidden" name="shopid"  id="shopid" value="${braVo.shopid}" />
		<input type="hidden" name="shopname"  id="shopname" value="${braVo.shopname}" />
		<input type="hidden" name="yesNextop"  id="yesNextop" value="${braVo.yesNextop}" />
		<input type="hidden" name="stepname"  id="stepname" value="${braVo.stepname}" />
		<input type="hidden" name="stepno"  id="stepno" value="${braVo.stepno}" />
		<input type="hidden" name="modelname"  id="modelname" value="${braVo.modelname}" />
		<input type="hidden" name="modelid"  id="modelid" value="${braVo.modelid}" />
		<input type="hidden" name="stepnum"  id="stepnum" value="${braVo.stepnum}" />
		<input type="hidden" name="modelver"  id="modelver" value="${braVo.modelver}" />
		<input type="hidden" name="ftable"  id="ftable" value="${braVo.ftable}" />
		<input type="hidden" name="fstatusid"  id="fstatusid" value="${braVo.fstatusid}" />
		<input type="hidden" name="fstatus"  id="fstatus" value="${braVo.fstatus}" />
		<input type="hidden" name="jspdo"  id="jspdo" value="" />
		
		<div class="title"><span class="titlefont">政务云计算中心资源申请表</span></div>
		<div class="workOrderBody">
			<div class="line">
				<label>工单标题</label>
				<input type="text" class="easyui-textbox textlength" id="flowname" name="flowname" 
					data-options="prompt:'工单标题',validType:'length[2,30]',missingMessage:'请输入工单标题'"/>
			</div>
			<div class="line">
				<label>工单类型</label>
				<input type="text" class="easyui-textbox wbk" id="flowtypename" name="flowtypename" value="${braVo.flowtypename}" 
					data-options="prompt:'工单类型',validType:'length[2,10]',missingMessage:'请输入工单类型'"/>
				<label>工单编号</label>
				<input type="text" class='easyui-textbox wbk' id="flowid" name="flowid" value="${braVo.flowid}" 
					data-options="editable:false,prompt:'工单编号,自动生成',validType:'',missingMessage:'请输入工单编号'"/>
				<label>订单编号</label>
				<input type="text" class='easyui-textbox wbk' id="orderid" name="orderid" 
					data-options="prompt:'订单编号',validType:'',missingMessage:'请输入订单编号'" />
			</div>
			<div class="line">
				<label>创建人</label>
				<input type="text" class='easyui-textbox wbk' id="cusername" name="cusername" value="<%=username%>" 
					data-options="prompt:'创建人',validType:'',missingMessage:'请输入创建人'" />
				<label>创建人联系电话</label>
				<input type="text" class='easyui-textbox wbk' id="phone" name="phone" value="<%=phone%>" 
					data-options="prompt:'创建人',validType:'',missingMessage:'请输入创建人'" />
				<label>创建人角色</label>
				<input type="text" class='easyui-textbox wbk' id="dorolename" name="dorolename" value="${braVo.dorolename}" 
					data-options="prompt:'创建人角色',validType:'',missingMessage:'请输入创建人角色'" />
			</div>
		</div>
		
		<div class="rescABody">
			<div class="line">
				<label>单位名称</label>
				<%-- <select class="easyui-combobox" style="width:84%;height:25px"
					data-options="editable:false,panelHeight:200,
						url:'${pageContext.request.contextPath}/workorder/getUnitName.do?',
						valueField:'id',textField:'name',
						onSelect:function(node){
							jQuery('#unitname').val(node.name);
						}">
				</select> --%>
				<!-- <input type="hidden" id="unitname" name="unitname"/> -->
				
				<select class="easyui-combogrid" style="width:84%;height:25px" 
					data-options="editable:false,panelWidth:750,panelHeight:260,idField:'email',textField:'sysname',url:'${pageContext.request.contextPath}/workorder/getUnitName.do?',
						pagination:true,
						pageSize:5,
						pageList:[5,10,20],
						sortName:'sysname',
						sortOrder:'asc',
						columns:[[
							{field:'sysname',title:'单位名称',width:150,sortable:true},
							{field:'uname',title:'联系人',width:120,sortable:true},
                			{field:'mobile',title:'联系人电话',width:120,sortable:true},
							{field:'email',title:'联系人邮箱',width:150,sortable:true},
							
                			{field:'unitcontactperson',title:'信息化负责人',width:120,sortable:true},
                			{field:'pmobile',title:'负责人电话',width:120,sortable:true},
                			{field:'pemail',title:'负责人邮箱',width:150,sortable:true}
                		]],
                		onSelect:function(rowIndex,rowData){
               				jQuery('#unitname').val(rowData.sysname);
               				jQuery('#email').val(rowData.email);
               				
               				$('#infochief').textbox('setValue',rowData.unitcontactperson);
               				$('#infochief').textbox('setText',rowData.unitcontactperson);
               				$('#chiefphone').textbox('setValue',rowData.pmobile);
               				$('#chiefphone').textbox('setText',rowData.pmobile);
               				$('#chiefEmail').textbox('setValue',rowData.pemail);
               				$('#chiefEmail').textbox('setText',rowData.pemail);
               				$('#contactPerson').textbox('setValue',rowData.uname);
               				$('#contactPerson').textbox('setText',rowData.uname);
               				$('#contactPersonPhone').textbox('setValue',rowData.mobile);
               				$('#contactPersonPhone').textbox('setText',rowData.mobile);
               				$('#contactPersonEmail').textbox('setValue',rowData.email);
               				$('#contactPersonEmail').textbox('setText',rowData.email);
               			}">
            	</select>
            	<input type="hidden" id="unitname" name="unitname" />
            	<input type="hidden" id="email" name="email" />
			</div>
			<div class="line">
				<label>信息化负责人</label>
				<input type="text" class="easyui-textbox wbk" id="infochief" name="infochief" data-options="prompt:'信息化负责人',validType:'length[2,30]',missingMessage:'请输入负责人'"/>
				<label>负责人电话</label>
				<input type="text" class='easyui-textbox wbk' id="chiefphone" name="chiefphone" data-options="prompt:'负责人电话',validType:'mobileAndTel',missingMessage:'请输入负责人电话'"/>
				<label>负责人邮箱</label>
				<input type="text" class='easyui-textbox wbk' id="chiefEmail" name="chiefEmail" data-options="prompt:'负责人邮箱',validType:['email','length[10,64]'],missingMessage:'请输入负责人邮箱'">
			</div>
			<div class="line">
				<label>联系人</label>
				<input type="text" class="easyui-textbox wbk" id="contactPerson" name="contactPerson" data-options="prompt:'联系人',validType:'length[2,30]',missingMessage:'请输入联系人'"/>
				<label>联系人电话</label>
				<input type="text" class='easyui-textbox wbk' id="contactPersonPhone" name="contactPersonPhone" data-options="prompt:'联系人电话',validType:'mobileAndTel',missingMessage:'请输入联系人电话'"/>
				<label>联系人邮箱</label>
				<input type="text" class='easyui-textbox wbk' id="contactPersonEmail" name="contactPersonEmail" data-options="prompt:'联系人邮箱',validType:['email','length[10,64]'],missingMessage:'请输入联系人邮箱'">
			</div>
			<div class="line">
				<label>系统名称</label>
				<input type="text" class="easyui-textbox textlength" id="sysname" name="sysname" data-options="prompt:'系统名称',validType:'length[2,30]',missingMessage:'请输入系统名称'"/>
			</div>
			<div class="line">
				<div class="purpose">主要用途</div>
				<input type="text" class='easyui-textbox' id="purpose" name="purpose" 
					data-options="width:750,height:50,prompt:'主要用途，最多200字',multiline:true,validType:'length[0,200]',missingMessage:'请输入主要用途'"/>
			</div>
			<div class="line">
				<div class="checkboxline">
					<div>
						<input id="yfwq" name="yfwq" type="checkbox"/>云服务器
						<input id="yrz" name="yrz" type="checkbox" />云容灾
						<input id="zxy" name="zxy" type="checkbox" />专享云
						<input id="tgfw" name="tgfw" type="checkbox" />云托管
						<input id="ywwb" name="ywwb" type="checkbox" />运维和维保
						<input id="netacs" name="netacs" type="checkbox" />网络接入
						<input id="other1" name="other1" type="checkbox" />其它
					</div>
					<div>
						<input id="czxt" name="czxt" type="checkbox" />操作系统
						<input id="sjk" name="sjk" type="checkbox" />数据库
						<input id="fbd" name="fbd" type="checkbox" />防病毒
						<input id="zhjj" name="zhjj" type="checkbox" />中间件						
						<input id="ykfpt" name="ykfpt" type="checkbox" />云开发平台
						<input id="yyfzjh" name="yyfzjh" type="checkbox" />应用负载均衡
						<input id="other2" name="other2" type="checkbox" />其它
					</div>
					<div>
						<input id="szzsh" name="szzsh" type="checkbox" />数字证书服务
						<input id="jchzysjjh" name="jchzysjjh" type="checkbox" />基础信息数据交换
						<input id="dshjfx" name="dshjfx" type="checkbox" />大数据分析
						<input id="hlwshjcjfx" name="hlwshjcjfx" type="checkbox" />互联网数据采集及分析
						<input id="ymzhcjx" name="ymzhcjx" type="checkbox" />域名注册及解析
						<input id="zzhjzhdzhd" name="zzhjzhdzhd" type="checkbox" />自助建站及多终端应用
					</div>
					<div>
						<input id="wzhjc" name="wzhjc" type="checkbox" />网站监测
						<input id="other3" name="other3" type="checkbox" />其他
					</div>
					<div>
						<input id="dzyjyp" name="dzyjyp" type="checkbox" />电子邮件
						<input id="yqxx" name="yqxx" type="checkbox" />舆情信息
						<input id="ydbgpt" name="ydbgpt" type="checkbox" />移动办公平台
						<input id="wzhshpjs" name="wzhshpjs" type="checkbox" />网站和视频加速
						<input id="other4" name="other4" type="checkbox" />其他
					</div>
						
				</div>
				<!-- <label>申请业务类型</label> -->
				<div class="sqywlx">申请业务类型</div>
			</div>
			<div class="line">
				<input type="text" class='easyui-textbox' id="demand" name="demand" 
					data-options="width:895,height:100,prompt:'需求说明（详细说明申请业务类型、配置及数量，并附技术方案）,最多800字',
					multiline:true,validType:'length[0,800]'"/>
			</div>
		</div>
	</form>
</div>
</body>
</html>