<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
select{
	width:10.5%;
	height:30px;
}
.FieldInput3 {
	width:12%;
	height: 30px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}
.FieldLabel3 {
	width:8%;
	height: 30px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align:left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
</style>	
<script type="text/javascript">
 var flagck = 0;  //  初始化为0
var grid;
var dnattoolbar = [
						{
							text:'新增端口映射',
							iconCls:'icon-add',
							handler:function(){ 
								$('#dnatw').panel({title:"新增端口映射"});// 新增时将标题重置为“新增端口映射” zhanghl 20161018
								$('#dnatCreateForm').form('clear');
								dnat_getTransferaddr();
								//$("[name='ha'][value='0']").attr("checked",true);
								$("#vrid").combobox("setValue","trust-vr");
								$("#daddrtype_dnat").combobox("setValue","1");
								$("#serviceid").combobox("setValue","Any");
								$('#dnat_optype').val('add');
								$('#transferaddrtype').textbox({disabled:false});
								$('#transferaddr').textbox({disabled:false});
								$('#transferport').textbox({disabled:false});
								$("#transferaddrtype").combobox("setValue","1"); 
								$('#daddr_').textbox('setValue',$("#tabs_connip").val());
								$('#dnatw').window('open');
							}
						}
                       ];
$(document).ready(function() {
	loaddnatGrid();
});
//查询结果
function loaddnatGrid(){
	grid = $('#dnat_grid').datagrid({
		rownumbers: false,
        checkOnSelect: true,
        selectOnCheck: true,
        scrollbarSize: 0,
        border: false,
        striped : true,
        nowarp: false,
        singleSelect: false,
        method: 'post',
        loadMsg: '数据装载中......',
        fitColumns: true,

        pagination: true,
        pageSize: 10,
        pageList: [5, 10, 20, 30, 40, 50],
		toolbar:dnattoolbar,    
	    url:'${pageContext.request.contextPath}/security/queryDnatList.do?securityid=' + $("#tabs_security_id").val(),
	    onLoadSuccess : function(data) {
			var pageopt = $('#dnat_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var _rows = $('#dnat_grid').datagrid("getRows").length;
			 var total = pageopt.total; //显示的查询的总数
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {operation : ''})
				}
				$('#dnat_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
									    		total: total,
									    	});
				
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
			 
			 
			$('.j-open').linkbutton({
                iconCls: 'icon-open',
                plain: true
   		    });
			$('.j-close').linkbutton({
                iconCls: 'icon-close',
                plain: true
   		    });
			$('.j-delete').linkbutton({
                iconCls: 'icon-delete',
                plain: true
   		    });
			$('.j-modify').linkbutton({
                iconCls: 'icon-modify',
                plain: true
   		    });
			$('.j-insiderelease').linkbutton({
                iconCls: 'icon-insiderelease',
                plain: true
   		    });
			$('.j-outsiderelease').linkbutton({
                iconCls: 'icon-outsiderelease',
                plain: true
   		    });
			// 新增端口映射弹层
	        $('#dnatw').dialog({
	            title: "新增端口映射",
	            width: 650,
	            height: 420,
	            closed: true,
	            modal: true,
	            collapsible: false,
	            minimizable: false,
	            maximizable: false,
	            resizable: false,
	            buttons: [{
                    text: '提交',
                    iconCls: 'icon-ok',
                    handler: function() {
                    	adddnat();
                    }
                }, {
                    text: '取消',
                    iconCls: 'icon-cancel',
                    handler: function() {
                        $('#dnatw').window('close');
                    }
                }]
	        });
		}
	 }); 
}
//操作列格式化
function dnatformatter(value, row, index) {
	if(!value){
		return "";
	}
	var str = "";var statestr='';
	if(row.state=='1'){
		statestr ="<a href=\"javascript:void(0);\" onclick=\"dnat_turnONOFF(\'"
			+ row.dnatid + "\', \'" + row.vrid + "\', \'" + row.vrname + "\', \'" + row.state 
			+ "\');\" title=\"关闭\" class=\"j-close\"></a>";
	}else if(row.state=='0'){
		statestr ="<a href=\"javascript:void(0);\" onclick=\"dnat_turnONOFF(\'"
			+ row.dnatid + "\', \'" + row.vrid + "\', \'" + row.vrname + "\', \'" + row.state 
			+ "\');\" title=\"开启\" class=\"j-open\"></a>";
	}
	
	var str1 = "<span class=\"gproducts-partingline\">|</span><a href=\"javascript:void(0);\" onclick=\"showDnatEdit(\'"
			+ row.dnatid + "\', \'" + row.vrid + "\', \'" + row.saddrtype  + "\', \'" + row.saddr+ "\', \'" 
			+ row.daddrtype + "\', \'" + row.daddr + "\', \'" + row.serviceid  + "\', \'" + row.transferaddrtype+ "\', \'" 
			+ row.transferaddr + "\', \'" + row.transferport + "\', \'" + row.ha  + "\', \'" + row.description+ "\', \'" 
			+ "\');\" title=\"编辑\" class=\"j-modify\"></a><span class=\"gproducts-partingline\">|</span><a href=\"javascript:void(0);\" onclick=\"dnatdelbefore(\'"
			+ row.dnatid + "\', \'" + row.vrid + "\', \'" + row.vrname +  "\', \'" + row.transferaddr +  "\');\" title=\"删除\" class=\"j-delete\"></a>"; 
	
	if(row.appnettype=='1'){
		 str = "互联网发布";
	}else if(row.appnettype=='2'){
		 str = "内网发布";
	}else{
		 str = "<span class=\"gproducts-partingline\">|</span><a href=\"javascript:void(0);\" onclick=\"dnatappnettype1(\'" 
	 			+ row.daddr + "\', \'" + row.serviceid +"\');\" title=\"内网发布\" class=\"j-insiderelease\"></a><span class=\"gproducts-partingline\">|</span><a href=\"javascript:void(0);\" onclick=\"dnatappnettype0(\'" 
				+ row.transferaddr + "\', \'" + row.transferport + "\', \'" + row.daddr + "\', \'" + row.securityid   + "\', \'" + row.dnatid   + "\', \'" + row.serviceid   + "\');\" title=\"互联网发布\" class=\"j-outsiderelease\"></a>"; 
	 }
	
    return statestr+str1;//暂时删除str 屏蔽互联网发布入口
} 

function dnatappnettype0(transferaddr,transferport,daddr,securityid,dnatid,serviceid) {
	debugger;
	$('#appnettype0').form('clear');
	$.ajax({  
		url:'${pageContext.request.contextPath}/security/querydaddr.do',
			  	type:'post',  
			    async: false,
			    data: {transferaddr:transferaddr,transferport:transferport},    
			    dataType:'json',  
			    success:function(data){ 
			   		if(data.daddr !=null && data.daddr != ''){
			   			$('#dnat_daddr').textbox('setValue', data.daddr);
						$('#dnat_dport').textbox('setValue', data.dport);
						$('#dnat_daddr').textbox({disabled:true});
						$('#dnat_dport').textbox({disabled:true});
						$('#save_type').val('modify'); //修改
						$('#nat_manip').val(data.manip); 
						
						$('#serverip').val(transferaddr); 
						$('#backport').val(transferport); 
			   		}else{
			   			$('#dnat_daddr').textbox({disabled:false,value:""});
			   			$('#dnat_dport').textbox({disabled:false,value:""});
			   			$('#save_type').val('add'); //新增
			   		}
			    }	    
			});
	$('#dnatid').val(dnatid); 
	$('#securityid').val(securityid); 
	$("#dnat_saddr").combobox("setValue","Any");
	$('#dnat_transferaddr').textbox('setValue', $("#tabs_connip").val());
	$('#dnat_transferport').textbox('setValue', 8080);  //暂时默认dnat只挂载一个负载均衡或vm，端口暂为8080
	$('#appnettype0').window('open');
}
function dnatappnettype1(daddr,serviceid) {
	var mg = daddr+":8080";  //由于端口映射服务没有配置功能而默认Any ，所以端口目前默认8080
	$.messager.alert('提示', "已经发布的应用需要重新公布访问地址为"+mg, 'info');
}

function dnat_changestate(value){
	if(value=='0')
		return "停用";
	else if(value=='1')
		return "启用";
}
function dnat_turnONOFF(dnatid,vrid,vrname,state){
	$.ajax({
		url:"${pageContext.request.contextPath}/security/dnatOnOff.do",
		type:"post",
		async:false,
		data:{
			objectid:$("#tabs_service_id").val(),
			displayname:$("#tabs_displayname").val(),
			dnatid:dnatid,
			securityid:$("#tabs_security_id").val(),
			state:state,
			vrid:vrid,
			vrname:vrname,
			manip:$("#tabs_manip").val()
			},
		dataType:"json",
		success:function(data){
		  	if (data.success){    
	        	$.messager.alert('提示信息',data.msg, 'info');
	        } else{
	        	$.messager.alert('提示信息',data.msg, 'error'); 
	        }
		  	$('#dnat_grid').datagrid('reload');
		}
	});
}
//修改配置前获取信息展示
function showDnatEdit(dnatid, vrid, saddrtype,saddr,daddrtype,daddr,serviceid,transferaddrtype,transferaddr,transferport,ha,description){
	$('#dnatCreateForm').form('clear');
	$('#transferaddrtype').textbox({disabled:true});
	$('#transferaddr').textbox({disabled:true});
	$('#transferport').textbox({disabled:true});
	$('#dnatid').val(dnatid);
	$('#vrid').combobox('select',vrid);
	$('#daddrtype_dnat').combobox('select',daddrtype);
	$('#daddr_').textbox('setValue',daddr);
	$('#serviceid').textbox('setValue',serviceid);
	$('#transferaddrtype').combobox('select',transferaddrtype);
	$('#transferaddr').combobox('select',transferaddr);
	$('#transferport').textbox('setValue',transferport);
	//$("[name='ha'][value="+ha+"]").attr("checked",true);
	$('#dnat_description').textbox('setValue',description);
	$('#dnatw').panel({title:"修改端口映射"});
	$('#dnat_optype').val('edit');
	$('#transferaddr_typeid').val('');
	$('#dnatw').window('open');
	
}
//删除操作
function dnatdelbefore(dnatid, vrid,vrname,transferaddr){
	$.messager.confirm('系统提示信息', '当前配置删除后不可恢复，请谨慎操作，确定删除吗？', function(r){
		 if (r){
			$('#dnatManForm').form('submit',{
			    url:'${pageContext.request.contextPath}/security/delDnat.do', 
			    onSubmit : function(param) {
			    	param.securityid = $("#tabs_security_id").val(); 
			    	param.objectid = $("#tabs_service_id").val();
			    	param.displayname = $("#tabs_displayname").val();
			    	param.manip = $("#tabs_manip").val(); 
					param.dnatid=dnatid;
					param.vrid =vrid;
					param.vrname=vrname;
					param.transferaddr=transferaddr;
				},
			    success:function(result){
			    	var data = eval('(' + result + ')'); 
			        if (data.success){    
			        	$.messager.alert('提示信息',data.msg, 'info');
			        } else{
			        	$.messager.alert('提示信息',data.msg, 'error'); 
			        } 
			        $('#dnat_grid').datagrid('reload');
			    }
			});
		} 
	});

}
//新增dnat策略
function adddnat(){
	var vrid =$("#vrid").textbox("getValue");
	if(vrid == null || vrid == ""){
		$.messager.alert('提示信息','虚拟路由器不可为空！', 'info');
		return;
	}
	var daddrtype =$("#daddrtype_dnat").textbox("getValue");
	if(daddrtype == null || daddrtype == "" ){
		$.messager.alert('提示信息','目的地址不可为空！', 'info');
		return;
	}
	var daddr =$("#daddr_").textbox("getValue");
	var patrn = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	if(!patrn.exec(daddr)){
		 $.messager.alert('提示信息','目的地址ip不符合格式要求', 'info');
		 return;
	}
	
	var serviceid =$("#serviceid").textbox("getValue");
	if(serviceid == null || serviceid == ""){
		$.messager.alert('提示信息','服务不可为空！', 'info');
		return;
	}
	var transferaddrtype =$("#transferaddrtype").textbox("getValue");
	if(transferaddrtype == null || transferaddrtype == "" ){
		$.messager.alert('提示信息','映射到地址不可为空！', 'info');
		return;
	}
	var transferaddr =$('#transferaddr').combobox('getValue');
	if(!patrn.exec(transferaddr)){
		 $.messager.alert('提示信息','映射地址ip不符合格式要求', 'info');
		 return;
	}
	var transferport =$("#transferport").textbox("getValue");
	if(transferport == null || transferport == ""){
		$.messager.alert('提示信息','端口映射不可为空！', 'info');
		return;
	}
	$('#dnatCreateForm').form('submit',{
		url:'${pageContext.request.contextPath}/security/saveDnat.do',
		onSubmit:function(param){
			param.objectid=$("#tabs_service_id").val();
			param.securityid=$("#tabs_security_id").val();
			param.manip=$("#tabs_manip").val();
			param.displayname=$("#tabs_displayname").val();
			param.vrname=$('#vrid').combobox('getText');
			param.saddrtype="0";
			param.saddr="Any";
			param.servicename=$('#serviceid').combobox('getText');
			param.transfer="0";//状态 0:开启
			param.istransferport="1";
			param.transferaddr=transferaddr;
			
			param.daddrtype=daddrtype;
			param.daddr=daddr;
			param.serviceid=serviceid;
			
			param.transferaddrtype=transferaddrtype;
			param.transferaddr=transferaddr;
			param.transferport=transferport;
			param.ha=0;
			param.gateway=$("#tabs_funip").val();//当前vfw的业务地址作为被防护负载均衡新网关
			//	pingtrack tcptrack tcpport dnatlog dnatorder
		},
		success:function(result){
			var data = eval('(' + result + ')'); 
			var transferaddr_typeid =  $('#transferaddr_typeid').val();
	        if (data.success && transferaddr_typeid =="LB"){   //防护资源是负载均衡
	        	$.messager.alert('提示信息',data.msg, 'info');
	        }else if (data.success && transferaddr_typeid =="VM"){    //若被防护资源是云服务器，需要生成脚本供用户下载
	        	$.messager.alert('提示信息',data.msg, 'info',function(){
				    $('#gw').window('open');
	        	});
	        	
	        }else if(data.success){ //端口映射修改成功(transferaddr_typeid无类型即为修改操作)
	        	$.messager.alert('提示信息',data.msg, 'info');
	        }else{
	        	$.messager.alert('提示信息',data.msg, 'error'); 
	        } 
	        $('#dnatw').window('close');
	        $('#dnat_grid').datagrid('reload');
		}
	});
//	不将代码写在此处的原因是：form.('submit')方式，默认为同步。会先执行下列，后执行succss返回函数，这时会从浏览器缓存中加在数据
//	 $('#dnatw').window('close');
//    $('#dnat_grid').datagrid('reload');
	
}

//云服务器修改网关脚本下载
/*function updateVmGateway(serverid){
	var serviceid =  $('#lb_lbid').val();
	$('#gw').form('clear');
	$.ajax({  
		url:'${pageContext.request.contextPath}/security/generateGwScript.do',
			  	type:'post',  
			    async: false,
			    data: {serverid:serverid},    
			    dataType:'json',  
			    success:function(data){ 
			    	alert(data);
			    }	    
			});
	$('#gw').window('open');
}
*/

//获取该用户权限下的vm或lb列表
function dnat_getTransferaddr(){
	$('#transferaddr').combobox({  
	    url:'${pageContext.request.contextPath}/security/queryLbOrVm.do?securityid=' + $("#tabs_security_id").val(),     
		type: 'post',	   
	    valueField:'sip',    
	    textField:'sip',
    	onSelect: function(rec){  
    		if(rec != null){
    			$('#transferaddr_typeid').val(rec.typeid);
	    		$('#resource_manip').val(rec.ipaddr);
	    		$('#resource_sip').val(rec.sip);
	    		$('#resource_neid').val(rec.neid);
    		}
        }
	});
}

function dnat_saveAppnettype(){ 
	var daddr = $('#dnat_daddr').textbox('getValue');
	var dport = $('#dnat_dport').textbox('getValue');
	var transferaddr = $('#dnat_transferaddr').textbox('getValue');
	var transferport = $('#dnat_transferport').textbox('getValue');
	var description = $('#dnat_description').textbox('getValue');
	
	var listtype = $('#dnat_listtype').combobox('getValue');
	var saddr = $('#dnat_saddr').combobox('getValue');
	var optype = $('#save_type').val();
	var nat_manip = $('#nat_manip').val();
	var securityid = $('#securityid').val();
	var dnatid = $('#dnatid').val();
	
	var serverip = $('#serverip').val();
	var backport = $('#backport').val();
	$('#appnetForm').form('submit',{
	    url:'${pageContext.request.contextPath}/security/saveInternetPub.do', 
	    onSubmit : function(param) {
	    	param.objectid=$("#tabs_service_id").val();
			param.daddr=daddr;
			param.dport=dport;
			param.transferaddr=transferaddr;
			param.transferport=transferport;
			param.description=listtype;
			param.listtype=listtype;
			param.saddr=saddr;
			param.optype=optype;
			param.optype=optype;
			param.description=description;
			param.manip=nat_manip;
			param.dnatid=dnatid;
			param.securityid=securityid; 
			
			param.serverip=serverip; //后端服务器ip
			param.backport=backport; //后端服务器端口
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.success) {
				loaddnatGrid();
			} else {
				$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
			}
			$('#appnettype0').window('close');
	    }
	});
}

//vm类型生成网关修改脚本下载
function downloadFile(){
	var serverid =  $('#resource_neid').val();
	var sip = $('#resource_sip').val();
	$.ajax({  
		url:'${pageContext.request.contextPath}/security/generateGwScript.do',
			  	type:'post',  
			    async: false,
			    data: {serverid:serverid,sip:sip,gateway:$("#tabs_funip").val()},    //vfw的业务地址作为防护资源的新网关
			    dataType:'text',
			    success:function(data){ 
			    	if(data != ''){
			    		data = '${pageContext.request.contextPath}'+data;
			    		window.open(data,'_blank');
			    	}
			    }	    
			});
}

</script>
<form id="dnatManForm"></form>
<div data-options="region:'center',border:false">
	<div data-options="region:'center',border:false" id="addid">
	<table title="" style="width:100%;"  id="dnat_grid">
		<thead>
			<tr><!--状态、操作  -->
				<th data-options="field:'dnatid',width:10,align:'center'">ID</th>
				<th data-options="field:'state',width:10,align:'center',formatter:dnat_changestate">状态</th>
				<th data-options="field:'saddr',width:20,align:'center'">源地址（原始）</th>	
				<th data-options="field:'daddr',width:20,align:'center'">目的地址（原始）</th>
				<th data-options="field:'serviceid',width:15,align:'center'">服务</th>
				<th data-options="field:'transferaddr',width:20,align:'center'">转换为</th>
				<th data-options="field:'transferport',width:10,align:'center'">端口</th>
				<!--  <th data-options="field:'ha',width:10,align:'center'">HA组</th>-->
				<th data-options="field:'dnatlog',width:25,align:'center'">日志</th>
				<th data-options="field:'description',width:25,align:'center'">描述</th>
				<!--  <th data-options="field:'securityid',width:30,align:'center',formatter:appnettypeformater">应用网络类型</th>-->
				<th data-options="field:'servicename',width:20,align:'center',formatter:dnatformatter">操作</th>
			</tr>
		</thead>
	</table>
	</div>
</div>  
<div id="dnatw" class="easyui-window pop" title="新增端口映射" data-options="closed:true" >
	
		<div style="padding:0 10px ">
			<form id="dnatCreateForm" method="post" data-options="novalidate:true">
				<input type="hidden" id="transferaddr_typeid" name="transferaddr_typeid">
				<input type="hidden" id="resource_manip" name="resource_manip">
				<input type="hidden" id="resource_sip" name="resource_sip">
				<input type="hidden" id="resource_neid" name="resource_neid">
				<div class="item2">
                <div class="item-title">IP地址符合条件时</div>
                <table style="width:100%;border:0"  class="table-layout">
                    <tr>
                        <td width="20%" align="right">
                                                                           虚拟路由器：
                        </td>
                        <td width="33%">
                            <select id="vrid" name="vrid" class="easyui-combobox" style="width: 150px;" data-options="panelHeight:'auto',editable:false,valueField: 'value',textField: 'text',data: [{ text: 'trust-vr',value: 'trust-vr'}] ">
                                <option value="001">请选择</option>
                            </select>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                                                                           目的地址：
                        </td>
                        <td>
                            <select id="daddrtype_dnat" name="daddrtype"class="easyui-combobox" style="width: 150px;" data-options="panelHeight:'auto',editable:false,valueField: 'value',textField: 'text',data: [{ text:'IP地址',value:'1' }],disabled:true">
                                <option value="001">请选择</option>
                            </select>
                        </td>
                        <td>
                            <input id="daddr_" name="daddr" class="easyui-textbox" style="width: 150px;" data-options="panelHeight:'auto',disabled:true">
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                                                                           服务：
                        </td>
                        <td>
                            <select id="serviceid" name="serviceid" class="easyui-combobox" style="width: 150px;" data-options="panelHeight:'auto',editable:false,valueField: 'value',textField: 'text',data: [{ text:'Any',value:'Any' }],disabled:true ">
                                <option value="001">请选择</option>
                            </select>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </div>
				<div class="item2">
                <div class="item-title">映射</div>
                <table style="width:100%;border:0" class="table-layout">
                    <tr>
                        <td width="20%" align="right">
                                                                           映射到地址：
                        </td>
                        <td width="33%">
                            <select id="transferaddrtype" name="transferaddrtype" class="easyui-combobox" style="width: 150px;" data-options="panelHeight:'auto',editable:false,valueField: 'value',textField: 'text',data: [{ text:'IP地址',value:'1'}] ">
                                <option value="001">请选择</option>
                            </select>
                        </td>
                        <td>
                            <input type="text" id="transferaddr" class="easyui-combobox" style="width: 150px;" data-options="editable:false,panelHeight:'200'">
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                                                                        端口映射：
                        </td>
                        <td>
                            <input id="transferport" name="transferport" class="easyui-numberbox" style="width: 150px;" value="8080">
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </div>
				<div class="item2">
                <div class="item-title">描述</div>
                <table style="width:100%;border:0" class="table-layout">
                   <!--  <tr>
                        <td width="20%" align="right">
                            HA组：
                        </td>
                        <td>
                            &nbsp;<input type="radio" name="ha" value="0"/>0
						    &nbsp;<input type="radio" name="ha" value="1"/>1
                        </td>
                    </tr> -->
                    <tr>
                        <td width="20%" align="right">
                                                                          描述：
                        </td>
                        <td>
                            <input id="dnat_description" name="description" class="easyui-textbox" style="width: 300px;" />
                        </td>
                    </tr>
                </table>
            </div>
				<input type="hidden" id="dnat_optype" name="dnat_optype" />
				<input type="hidden" id="dnatid" name="dnatid" />
			</form>
		</div>
	
</div>
<div id="appnettype0" class="easyui-window" title="互联网发布" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save',singleSelect:true" 
style="width:480px;height:350px;padding:5px;top:57px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="appnetForm" method="post" data-options="novalidate:true">
			<input type="hidden" id="save_type" name="save_type">
			<input type="hidden" id="nat_manip" name="nat_manip"> 
			<input type="hidden" id="securityid" name="securityid">
			<input type="hidden" id="serverip" name="serverip">
			<input type="hidden" id="backport" name="backport">
			<table align="center" style="width:100%">
				 <!-- 	
				 <tr>
					<td class="FieldLabel2">名称：</td>
					<td class="FieldInput2">
						<input id="listname3" class="easyui-textbox" data-options="required:true,missingMessage:'此处为必填项'" style="height:30px;width:160px;" disabled/>
						<font color="red">*</font>
					</td>
				</tr>
				 -->
				<tr>
					<td class="FieldLabel2">源地址：</td>
					<td class="FieldInput2">	
						<select id="dnat_saddr" class="easyui-combobox" style="height:30px;width:160px;" data-options="editable:false,panelHeight:'auto'"></select>
						<font color="red">*</font>
					</td> 
				</tr>
				<tr>
					<td class="FieldLabel2">目的地址：</td>
					<td class="FieldInput2"> 
						<input id="dnat_daddr" class="easyui-textbox"	 style="height:30px;width:160px;"  />
						<font color="red">*</font>
					</td>
				</tr>                
				<tr>
					<td class="FieldLabel2">目的端口：</td>
					<td class="FieldInput2">
						<input id="dnat_dport" class="easyui-textbox"	 style="height:30px;width:160px;"  />
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">协议名称：</td>
					<td class="FieldInput2">
						<select id="dnat_listtype" class="easyui-combobox"  style="height:30px;width:160px;">   
						    <option value="HTTP">HTTP</option>   
						    <option value="TCP">TCP</option>   
						    <option value="HTTPS">HTTPS</option>   
						</select>  
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">转换地址：</td>
					<td class="FieldInput2">
						<input id="dnat_transferaddr" class="easyui-textbox"	 style="height:30px;width:160px;" disabled />
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">转换端口：</td>
					<td class="FieldInput2">
						<input id="dnat_transferport" class="easyui-textbox"  style="height:30px;width:160px;" disabled/>
						<font color="red">*</font>
					</td>
				</tr>
				<tr >
					<td class="FieldLabel2">描述信息：</td>
					<td class="FieldInput2">
						<input id="dnat_description" name="description" class="easyui-textbox" style="width:160px;height:22px;"/>
					</td>
				</tr>
			</table>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="dnat_saveAppnettype();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#appnettype0').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>

<div id="gw" class="easyui-window" title="修改网关" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save'" style="width:600px;height:200px;padding:5px;top:127px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center',border:false" style="padding:10px;">
			<form id="dnatCreateForm" method="post" data-options="novalidate:true">
				<div id="gw_tip" style="margin-top:15px;height: 50px">
					<p style="font-size:15px;margin-left: 30px">为保证安全产品正常使用必须修改被防护资源网关，  请点击下载获取脚本并于云服务器中执行！</p>
	     	    </div>
	     	    <div  data-options="region:'south',border:false" style="margin-top:30px;text-align:right;padding:5px 0 ;">
	     	    	<a class="easyui-linkbutton" data-options="iconCls:'icon-save'"  href="javascript:void(0)" onclick="downloadFile()" style="width:130px">下载</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="$('#gw').window('close');" style="width:130px">已知晓</a>
				</div>
			</form>
		</div>
		
	</div>
</div>
</body>