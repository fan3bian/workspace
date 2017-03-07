<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery.blockUI.js"></script>
<link href="${pageContext.request.contextPath}/easyui-1.4/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/easyui-1.4/themes/icon.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

var grid;
$(function(){
	loadDataGrid();
});
function loadDataGrid(){
	grid = $('#se_grid').datagrid({
		rownumbers : false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		method : 'post',
		loadMsg : '数据装载中......',
		fitColumns : true,
		singleSelect:true,
		toolbar:[{
			text:'提交',
			iconCls: 'icon-save',
			handler:ok4
		},'-', {
			iconCls: 'icon-cancel',
			text: '关闭',
			handler: function () {
				var mainTab =  window.parent.$("#centerTab").find("#tabs");
				var currentTab = mainTab.tabs("getSelected");
				var index =mainTab.tabs('getTabIndex',currentTab);
				mainTab.tabs('close',index);
			}
		}],
	    url:'${pageContext.request.contextPath}/security/securitylist.do?flowid=' + '<%=request.getParameter("transferid")%>'
	 }); 
}
function typeformatter(value){
	if(value=="10001"){
		return "标准";
	}else if(value=="10002"){
		return "高级";
		
	}
}
function funtypeformatter(value) {
	var fArr = value.split(",");
	var temp = "";
	for(var i=0; i<fArr.length; i++){
		if(fArr[i] == "1"){
		  temp += "防火墙" + ",";
		}else if(fArr[i] == "2"){
			temp += "病毒过滤" + ",";
		}else if(fArr[i] == "3"){
			temp += "入侵防御" + ",";
		}else if(fArr[i] == "4"){
			temp +=  "WAF"+ ",";
		}else if(fArr[i] == "5"){
			temp +=  "VPN"+ ",";
		}
	}
	return temp.substring(0, temp.length-1);
}
function optionformatter(value, row, index) {
    if("1" == value){
        return "<a href=\"javascript:void(0);\" onclick=\"opendialog(\'"+row.detailid+"\','"+row.cuserid+"\','"+row.orderid+"\')\">修改网络配置</a>";
    }else{
        return "<a href=\"javascript:void(0);\" onclick=\"opendialog(\'"+row.detailid+"\','"+row.cuserid+"\','"+row.orderid+"\')\">网络配置</a>";
    }
}
function opendialog(detailid,cuserid,orderid){
    $('#vmCreateForm1').form('clear');
	$('#w1').window({
        onOpen:function(){
            $("#detailid1_").val(detailid);
            $("#orderid1_").val(orderid);
            $("#serveruserid_").val(cuserid);
        }
    }).window('open');
	platformCombobox();
}
function platformCombobox() {
	var serveruserid = $('#serveruserid_').val();
	$('#platform').combobox(
					{url : '${pageContext.request.contextPath}/vm/getRmcVmPlatformVos.do?serveruserid='
								+ serveruserid,
						valueField : 'value',
						textField : 'platformname',
						onSelect : function(rec) {
							$.blockUI({
								message : "<h2>请求已发送,请稍后......</h2>",
								css : {
									zIndex : '10001',
									color : '#fff',
									border : '3px solid #aaa',
									backgroundColor : '#CCCCCC'
								},
								overlayCSS : {
									opacity : '0.0'
								}
							});

							connParam = rec.value;
							connPlattype = rec.plattype;
							$('#platform_').val(rec.platformid);
							datacenterCombobox(rec.value, rec.plattype);

							if ('vmware' == rec.plattype) {
								var as = document.getElementsByName('vmdis');
								for ( var i = 0; i < as.length; i++) {
									as[i].style.display = '';
								}
								$('#clusterField').children().remove();
								$('#hostField').children().remove();
							/* 	$('#storageField').children().remove(); */

								$('#clusterField').append(
												"<input id=\"cluster\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:true,editable:false,panelHeight:'auto'\"/>");
								$('#hostField').append(
												"<input id=\"host\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:true,editable:false,panelHeight:'auto'\"/>");
								/* $('#storageField').append(
												"<input id=\"storage\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:true,editable:false,panelHeight:'auto'\"/>");*/
							} else if ('cloudstack' == rec.plattype) {
								var as = document.getElementsByName('vmdis');
								for ( var i = 0; i < as.length; i++) {
									as[i].style.display = 'none';
								}
								$('#clusterField').children().remove();
								$('#hostField').children().remove();
								/* $('#storageField').children().remove(); */

								$('#clusterField').append(
												"<input id=\"cluster\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:false,editable:false,panelHeight:'auto'\"/>");
								$('#hostField').append(
												"<input id=\"host\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:false,editable:false,panelHeight:'auto'\"/>");
								/* $('#storageField').append(
												"<input id=\"storage\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:false,editable:false,panelHeight:'auto'\"/>"); */
							}
							$.parser.parse($('#clusterField'));
							$.parser.parse($('#hostField'));
							$.parser.parse($('#storageField'));
						}
					});
}
//数据中心下拉框
function datacenterCombobox(data, plattype) {
	var serveruserid = $('#serveruserid_').val();
	var platformid = $('#platform_').val();
	$('#datacenter').combobox({
		url : '${pageContext.request.contextPath}/vm/getdatacenter.do',
		valueField : 'id',
		textField : 'id',
		onBeforeLoad : function(param) {
			param.data = data;
			param.plattype = plattype;
			param.serveruserid = serveruserid;
			param.platformid = platformid;
		},
		onLoadSuccess : function() {
			$.unblockUI();
		},
		onSelect : function(rec) {
			//templateCombobox(rec.id);
			if ('cloudstack' == plattype) {
				networkCombobox(rec.id);
			} else if ('vmware' == plattype) {
				clusterCombobox(rec.id);
			}
		}
	});
}
//集群下拉框
function clusterCombobox(data) {
	var serveruserid = $('#serveruserid_').val();
	var platformid = $('#platform_').val();
	$('#cluster').combobox({
		url : '${pageContext.request.contextPath}/vm/getcluster.do',
		valueField : 'id',
		textField : 'id',
		onBeforeLoad : function(param) {
			param.datacenter = data;
			param.connParam = connParam;
			param.plattype = connPlattype;
			param.serveruserid = serveruserid;
			param.platformid = platformid;
		},
		onSelect : function(rec) {
			hostCombobox(rec.id);
		}
	});
}
//模板下拉框
/* function templateCombobox(data) {
	var serveruserid = $('#serveruserid_').val();
	var platformid = $('#platform_').val();
	$('#template').combobox({
		url : '${pageContext.request.contextPath}/vm/gettemplate.do',
		valueField : 'id',
		textField : 'id',
		onBeforeLoad : function(param) {
			param.datacenter = data;
			param.connParam = connParam;
			param.plattype = connPlattype;
			param.serveruserid = serveruserid;
			param.platformid = platformid;
		}
	});
} */
//宿主机下拉框
function hostCombobox(data) {
	var serveruserid = $('#serveruserid_').val();
	var platformid = $('#platform_').val();
	$('#host').combobox({
		url : '${pageContext.request.contextPath}/vm/gethost.do',
		valueField : 'id',
		textField : 'id',
		onBeforeLoad : function(param) {
			param.cluster = data;
			param.datacenter = $('#datacenter').combobox('getValue');
			param.connParam = connParam;
			param.plattype = connPlattype;
			param.serveruserid = serveruserid;
			param.platformid = platformid;
		},
		onSelect : function(rec) {
			//storageCombobox(rec.id);
			networkCombobox(rec.id);
		}
	});
}
//存储下拉框
/* function storageCombobox(data) {
	var serveruserid = $('#serveruserid_').val();
	var platformid = $('#platform_').val();
	$('#storage').combobox({
		url : '${pageContext.request.contextPath}/vm/getstorage.do',
		valueField : 'id',
		textField : 'id',
		onBeforeLoad : function(param) {
			param.host = data;
			param.connParam = connParam;
			param.plattype = connPlattype;
			param.serveruserid = serveruserid;
			param.platformid = platformid;
		}
	});
} */
//网络下拉框
/* function networkCombobox(data) {
	var serveruserid = $('#serveruserid_').val();
	var platformid = $('#platform_').val();
	$('#network').combobox({
		url : '${pageContext.request.contextPath}/vm/getnetwork.do',
		valueField : 'id',
		textField : 'id',
		onBeforeLoad : function(param) {
			param.host = data;
			param.connParam = connParam;
			param.plattype = connPlattype;
			param.serveruserid = serveruserid;
			param.platformid = platformid;
		},
		onSelect : function(rec) {
			//$('#network1').val(rec.id);
		}
	});
} */
function networkCombobox(data) {
	var serveruserid = $('#serveruserid_').val();
	var platformid = $('#platform_').val();
	$.ajax({
		type : "post",
		async : false,
		dataType : "json",
		url :"${pageContext.request.contextPath}/vm/getnetwork.do",
		data : {
			'host' : data,
			'connParam' :connParam,
			'plattype':connPlattype,
			'serveruserid':serveruserid,
			'platformid':platformid
		},
		success : function(data) {
			$('#funvlan').combobox({
				data:data,
				valueField : 'id',
				textField : 'id',
				onSelect : function(rec) {
				}
			});
			$('#manvlan').combobox({
				data:data,
				valueField : 'id',
				textField : 'id',
				onSelect : function(rec) {
				}
			});
			$('#connvlan').combobox({
				data:data,
				valueField : 'id',
				textField : 'id',
				onSelect : function(rec) {
				}
			});
		}
	});
}
function securityNetworkPre(){
	if ($('#vmCreateForm1').form('validate')) {
		$('#vmCreateForm1').form('submit',	{
			url : '${pageContext.request.contextPath}/security/securityNetworkPre.do',
			onSubmit : function(param) {
				param.manip = $('#manip').textbox('getValue');//管理ip
				param.funip = $('#funip').textbox('getValue');//业务ip
				param.connip = $('#connip').textbox('getValue');//外连ip
				param.manvlan = $('#manvlan').combobox('getValue');
				param.funvlan = $('#funvlan').combobox('getValue');
				param.connvlan = $('#connvlan').combobox('getValue');
			//	param.serverid = $('#serverid1_').val();
				param.flowid = $('#flowid').val();
				param.detailid = $('#detailid1_').val();
				param.orderid =$('#orderid1_').val();
			},
			success : function(retr) {
				var _data = $.parseJSON(retr);
				if (_data.success) {
					$.messager.alert('提示', _data.msg,
							'info');
				} else {
					$.messager.alert('提示', _data.msg,
							'error');
				}
				$('#w1').window('close');
				$('#se_grid').datagrid('reload');
			}
		});
	}
}
function ok4(){
	jQuery.ajax( {
		url : "${pageContext.request.contextPath}/jsonvm/befConfirmflow.do",
		data : {
			'flowid' : $('#flowid').val(),
			'stepno' : $('#stepno').val()
		} ,
		type : "post",
		cache : false,
		dataType : "json",
		success : function(retr) {
			if (retr.success) {
				$.messager.alert('提示', retr.msg, 'success');
				$("#savebutton").linkbutton('disable');
			} else {
				$.messager.alert('提示', retr.msg, 'error');
			}
	/* 		var mainTab =  window.parent.$("#centerTab").find("#tabs");
			var currentTab = mainTab.tabs("getSelected");
			var index =mainTab.tabs('getTabIndex',currentTab);
			mainTab.tabs('close',index); */
			$('#dd').dialog('close');
		}
	});
}
</script>
  <body>
   <div class="easyui-layout" data-options="fit:true,border:false">
		<input type="hidden" id="flowid" name="flowid" value="<%=request.getParameter("transferid")%>"/>
		<input type="hidden" id="stepno" name="stepno" value="<%=request.getParameter("stepno")%>"/>
		<div data-options="region:'center',border:false">
			<table title="" style="width:100%;" id="se_grid">
				<thead>
					<tr>
						<th data-options="field:'detailid',width:30,align:'center'">序号</th>
						<th data-options="field:'shopid',width:30,align:'center',formatter:typeformatter">规格</th>
						<th data-options="field:'cpunum',width:40,align:'center'">CPU(核)</th>
						<th data-options="field:'memnum',width:40,align:'center'">内存(G)</th>
						<th data-options="field:'osname',width:100,align:'center'">操作系统</th>
						<th data-options="field:'regionid',width:60,align:'center',hidden:'true'">区域编码</th>
						<th data-options="field:'regionname',width:60,align:'center'">区域</th>
						<th data-options="field:'funtype',width:90,align:'center',formatter:funtypeformatter">开通服务</th>
						<th data-options="field:'status',width:60,align:'center',formatter:optionformatter">操作</th>
					</tr>
				</thead>
			</table>
		</div>
   <div id="w1" class="easyui-window" title="云安全网络预置"
		data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save',inline:true"
		style="width:800px;height:400px;padding:5px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center'" style="padding:10px;">
				<form id="vmCreateForm1" method="post">
					<!-- <input type="hidden" id="serverid1_" /> -->
					<input type="hidden" id="detailid1_" />
					<input type="hidden" id="orderid1_" />
					<input type="hidden" id="serveruserid_" />
					<input type="hidden" id="platform_" />
					<table id="data_table1" style="width:100%">
						<tr>
							<td class="FieldLabel2">虚拟平台：</td>
							<td class="FieldInput2"><input id="platform"
								class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
							<td class="FieldLabel2">数据中心：</td>
							<td class="FieldInput2"><input id="datacenter"
								class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
						</tr>
						<tr>
							<td class="FieldLabel2" style="">集&emsp;&emsp;群：</td>
							<td class="FieldInput2" id="clusterField"><input
								id="cluster" class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
							<td class="FieldLabel2">宿主机：</td>
							<td class="FieldInput2" id="hostField"><input id="host"
								class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
						</tr>
						<tr>
							<td class="FieldLabel2" style="width:15%;">管理网络：</td>
							<td class="FieldInput2" style="width:25%;">
								<input id="manvlan" class="easyui-combobox" data-options="required:true,height:30" />
							</td>
							<td class="FieldLabel2" style="width:15%;">管理IP：</td>
							<td class="FieldInput2" style="width:25%;">
								<!-- <input id="manip" class="easyui-textbox" data-options="height:30,prompt:'管理IP'" /> -->
								<input id="manip" class="easyui-textbox" data-options="required:true,height:30" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel2" style="width:15%;">内联网络：</td>
							<td class="FieldInput2" style="width:25%;">
								<input id="funvlan" class="easyui-combobox" data-options="required:true,height:30" />
							</td>
							<td class="FieldLabel2" style="width:15%;">内联IP：</td>
							<td class="FieldInput2" style="width:25%;">
								<input id="funip" class="easyui-textbox" data-options="required:true,height:30"/>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel2" style="width:15%;">外连网络：</td>
							<td class="FieldInput2" style="width:25%;">
								<input id="connvlan" class="easyui-combobox" data-options="required:true,height:30" />
							</td>
							<td class="FieldLabel2" style="width:15%;">外连IP：</td>
							<td class="FieldInput2" style="width:25%;">
								<input id="connip" class="easyui-textbox" data-options="required:true,height:30"/>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div data-options="region:'south',border:false"
				style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
					href="javascript:void(0)" onclick="securityNetworkPre();" style="width:80px">提交</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
					href="javascript:void(0)" onclick="$('#w1').window('close');"
					style="width:80px">取消</a>
			</div>
		</div>
	</div>
	</div>
  </body>
</html>
