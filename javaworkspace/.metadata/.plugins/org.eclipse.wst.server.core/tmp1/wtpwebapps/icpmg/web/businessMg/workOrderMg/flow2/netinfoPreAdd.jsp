<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body>
<style type="text/css">
.FieldInput2 {
	width:30%;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
}
.FieldLabel2 {
	width:20%;
	height: 25px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
#data_table input{margin-left:0px !important}
#data_table1 input{margin-left:0px !important}
#data_table3 input{margin-left:0px !important}
/* #data_table4 input{margin-left:0px !important} */
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery-1.8.3.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery.easyui.min.js" ></script>
<link href="${pageContext.request.contextPath}/easyui-1.4/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/easyui-1.4/themes/icon.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
var grid;
var connParam;
var connPlattype;
var serveridArray = new Array();
var statusTimeout;

$(document).ready(function() {
	loadDataGrid();
	//setTimeout(initServerIdArray,10*1000);
	//statusTimeout = setTimeout(checkStatusChange,30*1000);
});

function initServerIdArray(){
	  //首先加载状态为5的serverid到serveridArray中
	   $.ajax({  
       url:'${pageContext.request.contextPath}/vm/vmlist.do?flowid=' + '<%=request.getParameter("transferid")%>',
    type:'post',  
    async: false,
    dataType:'json',  
    success:function(data){      	
    	debugger; 
    	if(data.rows){
              for(var idx = 0 ;idx < data.rows.length; idx ++){
              	  var rowdata = data.rows[idx];
              	  if(rowdata.status == '5'){
              	       if(serveridArray.indexOf(rowdata.uuid)<0){
              	  	   serveridArray.push(rowdata.uuid);
              	  	   }
              	  }
              }
    	}
    	 
    }  
});
}

function checkStatusChange(){
	debugger;
   var serverIds ;
   if(serveridArray.length == 0){
     statusTimeout = setTimeout(arguments.callee,30*1000);
      return;
   }
   if(serveridArray.length == 1){
   	   if(serveridArray[0] == ""){
   	   	   statusTimeout = setTimeout(arguments.callee,30*1000);
   	   	    return;
   	   }else{
   	   	  serverIds = serveridArray[0];
   	   }
   }else{
   	      serverIds = serveridArray.join(",");
   }
   
   if(!serverIds){
   	  statusTimeout = setTimeout(arguments.callee,30*1000);
   	   return;
   }
   
//   window.alert("timeInterval:" + serverIds);
   
   $.ajax({  
    url:'${pageContext.request.contextPath}/vm/checkvmstatus.do',
    type:'post',  
    async: false,
    data: {param1: serverIds},  
    dataType:'json',  
    success:function(data){      	
    	debugger; 
    	if(data.success){
    	   //首先清空数组
          serveridArray.length = 0;
           //data.obj是返回的当前未创建成功的Server 
    	  var unExistServerids = data.obj;
    	  if(unExistServerids == ""){
    	  	  //如果没有数据返回，说明全部创建成功	
    	  }else{ 
    	  	  //如果有数据返回，说明还存在没有创建成功的server, 需要更新数组 
    	  	  if(unExistServerids.indexOf(",") >= 0 ){
    	  	     serveridArray = unExistServerids.split(",");
    	  	  }else{
    	  	  	 serveridArray.push(unExistServerids);
    	  	  }
    	  }
    	  
    	  if(serverIds != unExistServerids){
    	  // 如果请求的数据和返回的数据不一样，说明已经有server创建成功了，需要重新加载表格里的数据
    	   $('#vmlist_grid').datagrid('load',{});
    	  }
    	}
    	 
     statusTimeout =  setTimeout(checkStatusChange,30*1000);
    }  
});
}

//查询结果
function loadDataGrid(){
	grid = $('#vmlist_grid').datagrid({
		rownumbers : false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		method : 'post',
		loadMsg : '数据装载中......',
		fitColumns : true,
		toolbar:[{
			text:'提交',
			id:"savebutton",
			iconCls: 'icon-save',
			handler:ok4
		},'-', {
			iconCls: 'icon-cancel',
			text: '关闭',
			id:"closebutton",
			handler: function () {
				var mainTab =  window.parent.$("#centerTab").find("#tabs");
				var currentTab = mainTab.tabs("getSelected");
				var index =mainTab.tabs('getTabIndex',currentTab);
				mainTab.tabs('close',index);
			}
		}],
	    url:'${pageContext.request.contextPath}/vm/vmlist.do?flowid=<%=request.getParameter("transferid")%>'
	 })
}
function diskformater(value) {
	var fArr = value.split(";");
	var temp = "";
	for(var i=0; i<fArr.length; i++){
		var sArr = fArr[i].split(",");
		if(sArr[1] && sArr[1] != "undefined"){
		  temp += sArr[1] + ",";
		}
	}
	return temp.substring(0, temp.length - 1);
}
function optionformater(value, row, index) {
    if("1" == value){

        return "<a href=\"javascript:void(0);\" onclick=\"editnetinfopre(\'"+row.detailid+"\','"+row.flowid+"\','"+row.orderid+"\')\">修改网络配置</a>";
    }else{
        return "<a href=\"javascript:void(0);\" onclick=\"opendialog(\'"+row.detailid+"\','"+row.orderid+"\')\">网络配置</a>";
    }
}

function editnetinfopre(_detailid,_flowid,_orderid){
	$('#vmCreateForm1').form('clear');
	jQuery.ajax( {
		url : "${pageContext.request.contextPath}/vm/getPreNetInfo.do",
		data: {
			'flowid': _flowid,
			'detailid': _detailid
		},
		type : "post",
		cache : false,
		dataType : "json",
		success : function(data) {
			var result = eval("("+data.msg+")");
			console.log($('#vlanid').textbox())
//			netseg: "172.168.1.203/254"
			$('#vlanid').textbox('setValue', result.vlanid).textbox('setText', result.vlanid);
			$('#netseg').textbox('setValue', result.netseg).textbox('setText', result.netseg);
			$('#intraip').textbox('setValue', result.intraip).textbox('setText', result.intraip);
			$('#interbw').textbox('setValue', result.interbw).textbox('setText', result.interbw);
			$('#interport').textbox('setValue', result.interport).textbox('setText', result.interport);
			$('#muser').textbox('setValue', result.username).textbox('setText', result.username);
			$('#mpass').textbox('setValue', result.password).textbox('setText', result.password);
//			$('#mpass').textbox('setValue', result.password).textbox('setText', result.password);
			var  arrunicom =   result.netinfounicom.split("-");
			$('#uip').textbox('setValue',arrunicom[0].split(":")[0]).textbox('setText',  arrunicom[0].split(":")[0]);
			$('#uintraip').textbox('setValue',arrunicom[1].split(":")[0]).textbox('setText',  arrunicom[1].split(":")[0]);
			$('#uintraport').textbox('setValue',arrunicom[1].split(":")[1]).textbox('setText',  arrunicom[1].split(":")[1]);

			var  arrmobile =   result.netinfomobile.split("-");
			$('#mip').textbox('setValue',arrmobile[0].split(":")[0]).textbox('setText',  arrmobile[0].split(":")[0]);
			$('#mintraip').textbox('setValue',arrmobile[1].split(":")[0]).textbox('setText',  arrmobile[1].split(":")[0]);
			$('#mintraport').textbox('setValue',arrmobile[1].split(":")[1]).textbox('setText',  arrmobile[1].split(":")[1]);

			var  arrtelecom =   result.netinfotelecom.split("-");
			$('#tip').textbox('setValue',arrtelecom[0].split(":")[0]).textbox('setText',  arrtelecom[0].split(":")[0]);
			$('#tintraip').textbox('setValue',arrtelecom[1].split(":")[0]).textbox('setText',  arrtelecom[1].split(":")[0]);
			$('#tintraport').textbox('setValue',arrtelecom[1].split(":")[1]).textbox('setText',  arrtelecom[1].split(":")[1]);

			var $vpnuser = result.vpnuser;
			var $vpnaddr = result.vpnaddr;
			$('#vpnaddr').textbox('setValue', $vpnaddr).textbox('setText',$vpnaddr);

			var $vpnusers = $vpnuser.split(';');
		
	       if($vpnusers.length==2){
			
         	if($vpnusers[0]!=""){
			  var vpnuserEach = $vpnusers[0].split("-");
			  $('#vpnuser1').textbox('setValue', vpnuserEach[0]).textbox('setText',vpnuserEach[0]);
			  $('#vpnpasswd1').textbox('setValue', vpnuserEach[1]).textbox('setText',vpnuserEach[1]);
			  } 
		 
		   }
		if($vpnusers.length==4){
			
     		 if($vpnusers[0]!=""){
			  var vpnuserEach = $vpnusers[0].split("-");
			  $('#vpnuser1').textbox('setValue', vpnuserEach[0]).textbox('setText',vpnuserEach[0]);
			  $('#vpnpasswd1').textbox('setValue', vpnuserEach[1]).textbox('setText',vpnuserEach[1]);
			  }
			 if($vpnusers[1]!=""){
			  var vpnuserEach = $vpnusers[1].split("-");
			  $('#vpnuser2').textbox('setValue', vpnuserEach[0]).textbox('setText',vpnuserEach[0]);
			  $('#vpnpasswd2').textbox('setValue', vpnuserEach[1]).textbox('setText',vpnuserEach[1]);
			 }
			if($vpnusers[2]!=""){
			  var vpnuserEach = $vpnusers[2].split("-");
			  $('#vpnuser3').textbox('setValue', vpnuserEach[0]).textbox('setText',vpnuserEach[0]);
			  $('#vpnpasswd3').textbox('setValue', vpnuserEach[1]).textbox('setText',vpnuserEach[1]);
			}
			}
		if($vpnusers.length==3){
			
     		 if($vpnusers[0]!=""){
			  var vpnuserEach = $vpnusers[0].split("-");
			  $('#vpnuser1').textbox('setValue', vpnuserEach[0]).textbox('setText',vpnuserEach[0]);
			  $('#vpnpasswd1').textbox('setValue', vpnuserEach[1]).textbox('setText',vpnuserEach[1]);
			  }
			 if($vpnusers[1]!=""){
			  var vpnuserEach = $vpnusers[1].split("-");
			  $('#vpnuser2').textbox('setValue',vpnuserEach[0]).textbox('setText',vpnuserEach[0]);
			  $('#vpnpasswd2').textbox('setValue', vpnuserEach[1]).textbox('setText',vpnuserEach[1]);
			 }
		
			}
			
		/* 	for(var i=1;i<$vpnusers.length;i++){
				var $vpnuserofEach = $vpnusers[i-1];
				var $vpnuserofEachSplit = $vpnuserofEach.split("-");
				/**
				 转义 晕了！勿动！后果自负 >o<
				 **/
			/* 	$("#data_table1").append("<tr><td class=\"FieldLabel2\" style=\"width:15%;\">帐号：</td><td class=\"FieldInput2\" style=\"width:25%;\">"
						+"<input id=\"vpnuser"+i+"\""+ " value =\""+ $vpnuserofEachSplit[0]+"\""
						+ "class=\"easyui-textbox\" data-options=\"height:30,prompt:'VPN帐号',required:true\"/></td><td class=\"FieldLabel2\">密码：</td><td class=\"FieldInput2\" style=\"width:25%;\">"
						+"<input id=\"vpnpasswd"+i+"\""+ " value =\""+ $vpnuserofEachSplit[1]+"\""
						+ "class=\"easyui-textbox\" data-options=\"height:30,prompt:'VPN密码',required:true\"/></td></tr>")
			} 
			*/ 

			$("#detailid").val(_detailid);
			$("#orderid").val(_orderid);
			/*  $('#imode').val(imode);*/
			$('#w1').window('open');
		}
	})

}


function opendialog(detailid,orderid){
    $('#vmCreateForm1').form('clear');
	$('#w1').window({
        onOpen:function(){
            $("#detailid").val(detailid);
            $("#orderid").val(orderid);
        }
    }).window('open');
}
//网络配置提交按钮
function addNetinfo(){
	/*$('#submitbutton').click(function(){
	alert("ppp");
	});*/
	
	/*$('#my-selector').bind('click', function() {
       $(this).unbind('click');
       alert('Clicked and unbound!');
});*/
	
	if($('#vmCreateForm1').form('validate')){
		$('#vmCreateForm1').form('submit', {
					url : '${pageContext.request.contextPath}/vm/saveNetInfoPre.do',
					onSubmit : function(param) {
						var bw = $('#interbw').textbox('getValue');
						var port = $('#interport').textbox('getValue');
						var vpnuser;
					   if(!$.trim($("#vpnuser1").val())=="" && !$.trim($("#vpnpasswd1").val())==""){
             	         			   
                          vpnuser += $("#vpnuser1").val()+"-"+$("#vpnpasswd1").val()+";";
					      // alert(vpnuser);
					   }  
					   if(!$.trim($("#vpnuser2").val())=="" && !$.trim($("#vpnpasswd2").val())==""){
             	         			   
                          vpnuser += $("#vpnuser2").val()+"-"+$("#vpnpasswd2").val()+";";
					      // alert(vpnuser);
					   }
					   if(!$.trim($("#vpnuser3").val())=="" && !$.trim($("#vpnpasswd3").val())==""){
             	           
             	          vpnuser += $("#vpnuser3").val()+"-"+$("#vpnpasswd3").val()+";";				   
                          //alert(vpnuser);
					   }
						if(-1 != bw.indexOf("：") || -1 != bw.indexOf("；") || -1 != port.indexOf("：") || -1 != port.indexOf("；")){
							$.messager.alert('提示', '请使用英文格式分隔符！', 'error');
							return false;
						}
						
						var bwArr = bw.split(";");
						var portArr = port.split(";");
                        console.log(bwArr);
                        console.log(portArr);
						if(-1 == bw.indexOf("联通") || -1 == bw.indexOf("移动") || -1 == bw.indexOf("电信")
								|| -1 == port.indexOf("联通") || -1 == port.indexOf("移动") || -1 == port.indexOf("电信")
								|| "联通" != bwArr[0].split(":")[0] || "移动" != bwArr[1].split(":")[0] || "电信" != bwArr[2].split(":")[0]
								|| "联通" != portArr[0].split(":")[0] || "移动" != portArr[1].split(":")[0] || "电信" != portArr[2].split(":")[0]){
							$.messager.alert('提示', '请按照格式要求顺序：联通、移动、电信！', 'error');
							return false;
						}
						param.vpnaddr = $('#vpnaddr').textbox('getValue');
						param.vpnuser = vpnuser;
						param.interbw = $('#interbw').textbox('getValue');
						param.interport = $('#interport').textbox('getValue');
						param.muser = $('#muser').textbox('getValue');
						param.mpass = $('#mpass').textbox('getValue');
						param.uip = $('#uip').textbox('getValue');
						param.uintraip = $('#uintraip').textbox('getValue');
						param.uintraport = $('#uintraport').textbox('getValue');
						param.mip = $('#mip').textbox('getValue');
						param.mintraip = $('#mintraip').textbox('getValue');
						param.mintraport = $('#mintraport').textbox('getValue');
						param.tip = $('#tip').textbox('getValue');
						param.tintraip = $('#tintraip').textbox('getValue');
						param.tintraport = $('#tintraport').textbox('getValue');
						param.intraip = $('#intraip').textbox('getValue');
						param.serverid = $('#serverid_').val();
						param.flowid = $('#flowid').val();
						param.detailid = $('#detailid').val();
						param.imode = $('#imode').val();
                        param.vlanid = $("#vlanid").val();
                        param.netseg = $("#netseg").val();
                        console.log(param);
					},
					success : function(retr) {
						var _data = $.parseJSON(retr);
						if (_data.success) {
							$.messager.alert('提示', _data.msg, 'success');
						} else {
							$.messager.alert('提示', _data.msg, 'error');
						}
						$('#w1').window('close');
						$('#vmlist_grid').datagrid('reload'); 
					}
		});
	} 
}
function ok4(){
	jQuery.ajax({
		url: "${pageContext.request.contextPath}/jsonvm/befConfirmflow.do",
		data: {
			'flowid': $('#flowid').val(),
			'stepno': $('#stepno').val()
			/* 'ftp_address' : $('#ftp_address').val(),
			 'ftp_username' : $('#ftp_username').val(),
			 'ftp_pass' : $('#ftp_pass').val(),
			 'vpn_address' : $('#vpn_address').val(),
			 'vpn_username' : $('#vpn_username').val(),
			 'vpn_pass' : $('#vpn_pass').val()*/
		},
		type: "post",
		cache: false,
		dataType: "json",
		success: function (retr) {
			if (retr.success) {
				$.messager.alert('提示', retr.msg, 'success');
				$("#savebutton").linkbutton('disable');
			} else {
				$.messager.alert('提示', retr.msg, 'error');
			}
			//alert(" ppp");

			$('#dd').dialog('close');
		}
	});
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<input type="hidden" id="flowid" name="flowid" value="<%=request.getParameter("transferid")%>"/>
	<input type="hidden" id="stepno" name="stepno" value="<%=request.getParameter("stepno")%>"/>
	<div data-options="region:'center',border:false">
		<table title="" style="width:100%;"  id="vmlist_grid">
			<thead>
				<tr>
					<th data-options="field:'uuid',width:30,align:'center',hidden:'true'">序号1</th>
					<th data-options="field:'detailid',width:30,align:'center'">序号</th>
					<th data-options="field:'cpunum',width:40,align:'center'">CPU(核)</th>
					<th data-options="field:'memnum',width:40,align:'center'">内存(G)</th>
					<th data-options="field:'disknum',width:90,align:'center',formatter:diskformater">硬盘(G)</th>
					<th data-options="field:'osname',width:100,align:'center'">操作系统</th>
					<th data-options="field:'imode',width:60,align:'center'">接入模式</th>
					<th data-options="field:'interbw',width:110,align:'center'">公网带宽(M)</th>
					<th data-options="field:'interport',width:200,align:'center'">公网端口</th>
					<th data-options="field:'hasPreNetInfo',width:60,align:'center',formatter:optionformater">操作</th>
				</tr>

			</thead>
		</table>


	</div>
<%--	<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
		<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="" style="width:80px">配置</a>
		<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="" style="width:80px">修改</a>
	</div>--%>
</div>

<div id="w1" class="easyui-window" title="云服务器网络配置" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save',inline:true" style="width:900px;height:400px;padding:5px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;">
			<form id="vmCreateForm1" method="post">
			<input type="hidden" id="serverid_" name="serverid"/>
			<input type="hidden" id="imode" name="imode"/>
			<input type="hidden" id="detailid" name="detailid"/>
                <input type="hidden" id="orderid" name="orderid"/>
			<input type="hidden" id="serveruserid1_"/>
			<table id="data_table1" align="center" style="width:100%">
				<tr>
					<td class="FieldLabel2">VLAN：</td>
					<td class="FieldInput2" style="width:25%;">
                        <input id="vlanid" name="vlanid"></td>
					<td class="FieldLabel2" style="width:15%;">网段：</td>
					<td class="FieldInput2" colspan="3" style="width:25%;">
                        <input id="netseg" class="easyui-textbox" data-options="height:30,required:true"/></td>
				</tr>
				<tr>
					<td class="FieldLabel2">公网带宽：</td>
					<td class="FieldInput2" style="width:25%;"><input id="interbw" class="easyui-textbox" data-options="height:30,required:true,prompt:'格式要求(联通:;移动:;电信:;)'"/></td>
					<td class="FieldLabel2" style="width:15%;">公网端口：</td>
					<td class="FieldInput2" colspan="3" style="width:25%;"><input id="interport" class="easyui-textbox" data-options="height:30,required:true,prompt:'格式要求(联通:;移动:;电信:;)'"/></td>
				</tr>
				<tr>
					<td class="FieldLabel2">管理账号：</td>
					<td class="FieldInput2" style="width:25%;"><input id="muser" class="easyui-textbox" data-options="height:30,required:true"/></td>
					<td class="FieldLabel2" style="width:15%;">密码：</td>
					<td class="FieldInput2" style="width:25%;"><input id="mpass" class="easyui-textbox" data-options="height:30,required:true"/></td>
					<td class="FieldLabel2" style="width:15%;">内网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="intraip" class="easyui-textbox" data-options="height:30,required:true,prompt:'多个地址用分号分隔'"/></td>
				</tr>
				<tr>
					<td class="FieldLabel2">联通公网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="uip" class="easyui-textbox" style="height:30px;"/></td>
					<td class="FieldLabel2" style="width:15%;">内网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="uintraip" class="easyui-textbox" data-options="height:30,prompt:'联通公网对应内网IP'"/></td>
					<td class="FieldLabel2">内网端口：</td>
					<td class="FieldInput2" style="width:25%;"><input id="uintraport" class="easyui-textbox" data-options="height:30,prompt:'联通公网对应内网端口'"/></td>
				</tr>
				<tr>
					<td class="FieldLabel2">移动公网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="mip" class="easyui-textbox" style="height:30px;"/></td>
					<td class="FieldLabel2" style="width:15%;">内网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="mintraip" class="easyui-textbox" data-options="height:30,prompt:'移动公网对应内网IP'"/></td>
					<td class="FieldLabel2">内网端口：</td>
					<td class="FieldInput2" style="width:25%;"><input id="mintraport" class="easyui-textbox" data-options="height:30,prompt:'移动公网对应内网端口'"/></td>
				</tr>
				<tr>
					<td class="FieldLabel2">电信公网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="tip" class="easyui-textbox" style="height:30px;"/></td>
					<td class="FieldLabel2" style="width:15%;">内网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="tintraip" class="easyui-textbox" data-options="height:30,prompt:'电信公网对应内网IP'"/></td>
					<td class="FieldLabel2">内网端口：</td>
					<td class="FieldInput2" style="width:25%;"><input id="tintraport" class="easyui-textbox" data-options="height:30,prompt:'电信公网对应内网端口'"/></td>
				</tr>
					<tr>
					<td class="FieldLabel2">VPN地址：</td>
					<td class="FieldInput2" style="width:25%;"><input id="vpnaddr" class="easyui-textbox" data-options="height:30"/></td>	
				    </tr>
				    <tr>
					  <td class="FieldLabel2" style="width:15%;">帐号：</td>
					  <td class="FieldInput2" style="width:25%;"><input id="vpnuser1" class="easyui-textbox" data-options="height:30,prompt:'VPN帐号'"/></td>
					  <td class="FieldLabel2">密码：</td>
					  <td class="FieldInput2" style="width:25%;"><input id="vpnpasswd1" class="easyui-textbox" data-options="height:30,prompt:'VPN密码'"/></td>
				    </tr>
				     <tr>
					  <td class="FieldLabel2" style="width:15%;">帐号：</td>
					  <td class="FieldInput2" style="width:25%;"><input id="vpnuser2" class="easyui-textbox" data-options="height:30,prompt:'VPN帐号'"/></td>
					  <td class="FieldLabel2">密码：</td>
					  <td class="FieldInput2" style="width:25%;"><input id="vpnpasswd2" class="easyui-textbox" data-options="height:30,prompt:'VPN密码'"/></td>
				    </tr>
				      <tr>
					  <td class="FieldLabel2" style="width:15%;">帐号：</td>
					  <td class="FieldInput2" style="width:25%;"><input id="vpnuser3" class="easyui-textbox" data-options="height:30,prompt:'VPN帐号'"/></td>
					  <td class="FieldLabel2">密码：</td>
					  <td class="FieldInput2" style="width:25%;"><input id="vpnpasswd3" class="easyui-textbox" data-options="height:30,prompt:'VPN密码'"/></td>
				    </tr>
			</table>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" id="submitbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)"  onclick="addNetinfo();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" id="cancelbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)"  onclick="$('#w1').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>

</body>
