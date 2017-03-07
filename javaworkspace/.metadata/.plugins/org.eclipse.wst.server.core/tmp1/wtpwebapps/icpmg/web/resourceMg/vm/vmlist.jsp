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
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery-1.8.3.min.js"></script> --%>

<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery.easyui.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery.blockUI.js"></script>
<link href="${pageContext.request.contextPath}/easyui-1.4/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/easyui-1.4/themes/icon.css" rel="stylesheet" type="text/css" /> --%>
<script type="text/javascript">
var grid;
var connParam;
var connPlattype;
var serveridArray = new Array();
var statusTimeout;
var datacenter;
var cluster;

$(document).ready(function() {
	loadDataGrid();
	setTimeout(initServerIdArray,10*1000);
	statusTimeout = setTimeout(checkStatusChange,30*1000);
});

function initServerIdArray(){
	  //首先加载状态为5的serverid到serveridArray中
	   $.ajax({  
       url:'${pageContext.request.contextPath}/vm/vmlist.do?flowid=' + '<%=request.getParameter("transferid")%>',
    type:'post',  
    async: false,
    dataType:'json',  
    success:function(data){      	
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
	    url:'${pageContext.request.contextPath}/vm/vmlist.do?flowid=' + '<%=request.getParameter("transferid")%>'
	 }); 
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

	if((null == value || "" == value) && row.isimage == '1'){
	    return "<a href=\"javascript:void(0);\" onclick=\"createDialog4(\'" + row.imageid + "\', \'" + row.cpunum + "\', \'" + row.memnum + "\', \'" + row.disknum + "\', \'" + row.detailid + "\', \'" + row.cuserid + "\');\">由镜像创建</a>";
	}
	else if(null == value || "" == value){
		return "<a href=\"javascript:void(0);\" onclick=\"createDialog(\'" + row.cpunum + "\', \'" + row.memnum + "\', \'" + row.disknum + "\', \'" + row.detailid + "\', \'" + row.cuserid + "\');\">创建</a>";
	}else if('2' == value){
		return "<a href=\"javascript:void(0);\" onclick=\"createDialog3(\'" + row.uuid + "\', \'" + row.detailid + "\', \'" + row.cuserid + "\');\">修改</a>";
	}else if('3' == value){
		return "<a href=\"javascript:void(0);\" onclick=\"createDialog2(\'" + row.uuid + "\', \'" + row.detailid + "\', \'" + row.cuserid + "\');\">销毁</a>";
	}else if('4' == value){
		return "创建成功";
	}else if('5' == value){
		return "请稍候";
	}else if('-1' == value){
	    return "<a href=\"javascript:void(0);\" onclick=\"createDialog(\'" + row.cpunum + "\', \'" + row.memnum + "\', \'" + row.disknum + "\', \'" + row.detailid + "\', \'" + row.cuserid + "\');\">创建失败</a>";
	}else if('-2' == value){
	    return "<a href=\"javascript:void(0);\" onclick=\"startDialog(\'" + row.uuid + "\');\">启动失败</a>";
	}
	
} 
function startDialog(serverid){
	jQuery.ajax( {
		url : "${pageContext.request.contextPath}/vm/operate.do",
		data : {'type' : 'start', 'neid' : serverid, 'nename' : serverid},
		type : "post",
		cache : false,
		dataType : "json",
		success : function() {
			$.messager.alert('提示', '启动请求已发送，请稍候。。。。。。', 'info');
		}
	});
	
}
 
function createDialog4(imageid,cpunum, memnum, disknum, detailid,serveruserid){
   
	$('#vmCreateForm').form('clear');
	$('#cpunum').textbox('setValue', cpunum).textbox('setText', cpunum);
	$('#memnum').textbox('setValue', memnum).textbox('setText', memnum);
	//$('#template').combobox('setValue', imageid).textbox('setText', imageid);
	$('#disknum').textbox('setValue', disknum).textbox('setText', diskformater(disknum));
	$('#detailid_').val(detailid);
	$('#serveruserid_').val(serveruserid);
	platformComboboxImg(imageid);
	$('#w').window('open');
}
function createDialog3(serverid, detailid,serveruserid){
	$('#vmCreateForm3').form('clear');
	jQuery.ajax( {
		url : "${pageContext.request.contextPath}/jsonvm/getVmChanges.do",
		data : {'serverid' : serverid},
		type : "post",
		cache : false,
		dataType : "json",
		success : function(result) {
			debugger;
			var change = result.change;
			var current = result.current;
			if(change.cpunum != current.cpunum){
				document.getElementById("cpu_tr").style.display = "";
				$('#change_cpu').textbox('setValue', change.cpunum);
				$('#current_cpu').textbox('setValue', current.cpunum); 
			}
			if(change.memnum != current.memnum){
				document.getElementById("mem_tr").style.display = "";
				$('#change_mem').textbox('setValue', change.memnum);
				$('#current_mem').textbox('setValue', current.memnum); 
			}
			if(change.disknum != current.disknum){
				document.getElementById("disk_tr").style.display = "";
				$('#change_disk').textbox('setValue', change.disknum).textbox('setText', diskformater(change.disknum));
				$('#current_disk').textbox('setValue', current.disknum).textbox('setText', diskformater(current.disknum)); 
			}
			if(change.interbw != current.interbw){
				document.getElementById("interbw_tr").style.display = "";
				$('#change_interbw').textbox('setValue', change.interbw);
				$('#current_interbw').textbox('setValue', current.interbw); 
			}
			if(change.interport != current.interport){
				document.getElementById("interport_tr").style.display = "";
				$('#change_interport').textbox('setValue', change.interport);
				$('#current_interport').textbox('setValue', current.interport); 
			}
			if(change.imode != current.imode){
				document.getElementById("imode_utr").style.display = "";
				document.getElementById("imode_mtr").style.display = "";
				document.getElementById("imode_ttr").style.display = "";
			}
			
			$('#serverid3_').val(serverid);
			$('#detailid3_').val(detailid);
			$('#w3').window('open');
		}
	});
	
}
function createDialog2(serverid, detailid,serveruserid){
	$('#vmCreateForm2').form('clear');
	$('#serverid2_').val(serverid);
	$('#detailid2_').val(detailid);
	$('#w2').window('open');
}
function createDialog1(imode, serverid, interbw, interport, detailid,serveruserid){
	$('#vmCreateForm1').form('clear');
	jQuery.ajax( {
		url : "${pageContext.request.contextPath}/jsonvm/getVmIntraip.do",
		data : {'serverid' : serverid},
		type : "post",
		cache : false,
		dataType : "json",
		success : function(result) {
			$('#intraip').textbox('setValue', result.intraip).textbox('setText', result.intraip);
			$('#interbw').textbox('setValue', interbw).textbox('setText', interbw);
			$('#interport').textbox('setValue', interport).textbox('setText', interport);
			$('#serverid_').val(serverid);
			$('#detailid1_').val(detailid);
			$('#imode').val(imode);
			$('#w1').window('open');
		}
	});
}
function createDialog(cpunum, memnum, disknum, detailid,serveruserid){
	$('#vmCreateForm').form('clear');
	$('#cpunum').textbox('setValue', cpunum).textbox('setText', cpunum);
	$('#memnum').textbox('setValue', memnum).textbox('setText', memnum);
	$('#disknum').textbox('setValue', disknum).textbox('setText', diskformater(disknum));
	$('#detailid_').val(detailid);
	$('#serveruserid_').val(serveruserid);
	platformCombobox();
	$('#w').window('open');
}
//虚拟平台下拉框for镜像
function platformComboboxImg(imageid){
  
 var serveruserid = $('#serveruserid_').val();
	$('#platform').combobox({    
	    url:'${pageContext.request.contextPath}/vm/getPlatformVo.do?serveruserid=' + serveruserid+'&imageid='+imageid,    
	    valueField:'value',    
	    textField:'platformname',
    	onSelect: function(rec){  
    		$.blockUI({
		               message: "<h2>请求已发送,请稍后......</h2>",
		              css: {zIndex:'10001', color:'#fff', border:'3px solid #aaa', backgroundColor:'#CCCCCC' },
		              overlayCSS: {opacity:'0.0'}
		             }); 
    		
    	     connParam = rec.value;
    	     connPlattype = rec.plattype;
    	     $('#platform_').val(rec.platformid); 
    		//datacenterCombobox(rec.value,rec.plattype);
    		// 
    	     getparams(imageid);
    	     $('#datacenter').combobox('setValue',datacenter).textbox('setText', datacenter);
    		//
    		if('vmware' == rec.plattype){
    			var as = document.getElementsByName('vmdis');
    			for(var i=0; i<as.length; i++){
    				as[i].style.display = '';
    			}
    		    $('#clusterField').children().remove();
    		    $('#hostField').children().remove();
    		    $('#storageField').children().remove();
    		    
    		     $('#clusterField').append("<input id=\"cluster\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:true,editable:false,panelHeight:'auto'\"/>");
    			 $('#hostField').append("<input id=\"host\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:true,editable:false,panelHeight:'auto'\"/>");
    			 $('#storageField').append("<input id=\"storage\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:true,editable:false,panelHeight:'auto'\"/>");
    		}else if('cloudstack' == rec.plattype){
    			var as = document.getElementsByName('vmdis');
    			for(var i=0; i<as.length; i++){
    				as[i].style.display = 'none';
    			}
    			$('#clusterField').children().remove();
    		    $('#hostField').children().remove();
    		    $('#storageField').children().remove();
    		    
    			 $('#clusterField').append("<input id=\"cluster\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:false,editable:false,panelHeight:'auto'\"/>");
    			 $('#hostField').append("<input id=\"host\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:false,editable:false,panelHeight:'auto'\"/>");
    			 $('#storageField').append("<input id=\"storage\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:false,editable:false,panelHeight:'auto'\"/>");
    		}
    		
    		$.parser.parse($('#clusterField'));
    		$.parser.parse($('#hostField'));
    		$.parser.parse($('#storageField'));
    		
    		$('#template').combobox('setValue', imageid).textbox('setText', imageid);
    		if('cloudstack' == rec.plattype){
    			networkCombobox(datacenter);
    		}else if('vmware' == rec.plattype){
    			$('#cluster').combobox('setValue', cluster).textbox('setText', cluster);
    			hostCombobox(cluster);
    		} 
 		   	$.unblockUI();	     
        }
	}); 

}
 
 function getparams(images){

  	 jQuery.ajax({
		url : "${pageContext.request.contextPath}/vm/getImageVo.do",
		data : {
			'imageid' : images
		},
		type : "post",
		cache : false,
		async:false, 
	    dataType:"json",
		success : function(result) {
			  datacenter = result[0].datacenter;
			  cluster = result[0].cluster;
			}
	});
}  
//虚拟平台下拉框
function platformCombobox(){
   var serveruserid = $('#serveruserid_').val();
	$('#platform').combobox({    
	    url:'${pageContext.request.contextPath}/vm/getRmcVmPlatformVos.do?serveruserid=' + serveruserid,    
	    valueField:'value',    
	    textField:'platformname',
    	onSelect: function(rec){  
    		$.blockUI({
		               message: "<h2>请求已发送,请稍后......</h2>",
		              css: {zIndex:'10001', color:'#fff', border:'3px solid #aaa', backgroundColor:'#CCCCCC' },
		              overlayCSS: {opacity:'0.0'}
		             }); 
    		
    	     connParam = rec.value;
    	     connPlattype = rec.plattype;
    	     $('#platform_').val(rec.platformid); 
    	    
    		 datacenterCombobox(rec.value,rec.plattype);
  		
    		if('vmware' == rec.plattype){
    			var as = document.getElementsByName('vmdis');
    			for(var i=0; i<as.length; i++){
    				as[i].style.display = '';
    			}
    		    $('#clusterField').children().remove();
    		    $('#hostField').children().remove();
    		    $('#storageField').children().remove();
    		    
    		     $('#clusterField').append("<input id=\"cluster\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:true,editable:false,panelHeight:'auto'\"/>");
    			 $('#hostField').append("<input id=\"host\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:true,editable:false,panelHeight:'auto'\"/>");
    			 $('#storageField').append("<input id=\"storage\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:true,editable:false,panelHeight:'auto'\"/>");
    		}else if('cloudstack' == rec.plattype){
    			var as = document.getElementsByName('vmdis');
    			for(var i=0; i<as.length; i++){
    				as[i].style.display = 'none';
    			}
    			$('#clusterField').children().remove();
    		    $('#hostField').children().remove();
    		    $('#storageField').children().remove();
    		    
    			 $('#clusterField').append("<input id=\"cluster\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:false,editable:false,panelHeight:'auto'\"/>");
    			 $('#hostField').append("<input id=\"host\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:false,editable:false,panelHeight:'auto'\"/>");
    			 $('#storageField').append("<input id=\"storage\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:false,editable:false,panelHeight:'auto'\"/>");
    		}
    		
    		$.parser.parse($('#clusterField'));
    		$.parser.parse($('#hostField'));
    		$.parser.parse($('#storageField'));
        }
	}); 
}
//数据中心下拉框
function datacenterCombobox(data,plattype){
  var serveruserid = $('#serveruserid_').val();
  var platformid = $('#platform_').val();
	$('#datacenter').combobox({    
	    url:'${pageContext.request.contextPath}/vm/getdatacenter.do',    
	    valueField:'id',    
	    textField:'id',
	    onBeforeLoad: function(param){
		 param.data = data;
		 param.plattype = plattype;
		 param.serveruserid = serveruserid;
		 param.platformid = platformid;
	    },	    
	    onLoadSuccess:function(){
	    
	    	$.unblockUI();
	    },	    	        
    	onSelect: function(rec){ 
    	   
		     templateCombobox(rec.id);
 		   
    		if('cloudstack' == plattype){
    			networkCombobox(rec.id);
    		}else if('vmware' == plattype){
    			clusterCombobox(rec.id);
    		}
		  		
        }

	}); 
}
//集群下拉框
function clusterCombobox(data){
  var serveruserid = $('#serveruserid_').val();
   var platformid = $('#platform_').val();
	$('#cluster').combobox({    
	    url:'${pageContext.request.contextPath}/vm/getcluster.do',    
	    valueField:'id',    
	    textField:'id',
	    onBeforeLoad: function(param){
		 param.datacenter = data;
		 param.connParam = connParam;
		 param.plattype = connPlattype;
		 param.serveruserid = serveruserid;
		 param.platformid = platformid;
	    },	 
    	onSelect: function(rec){
    	   
    		hostCombobox(rec.id);
        }
	}); 
}
//模板下拉框
function templateCombobox(data){
  
  var serveruserid = $('#serveruserid_').val();
   var platformid = $('#platform_').val();
	$('#template').combobox({    
	    url:'${pageContext.request.contextPath}/vm/gettemplate.do',      
	    valueField:'id',    
	    textField:'id',
	    onBeforeLoad: function(param){
		 param.datacenter = data;
		 param.connParam = connParam;
		 param.plattype = connPlattype;
		 param.serveruserid = serveruserid;
		 param.platformid = platformid;
	    }	 
	}); 
  
}
//宿主机下拉框
function hostCombobox(data){
  var serveruserid = $('#serveruserid_').val();
   var platformid = $('#platform_').val();
	$('#host').combobox({    
	    url:'${pageContext.request.contextPath}/vm/gethost.do',    
	    valueField:'id',    
	    textField:'id',
	    onBeforeLoad: function(param){
		 param.cluster = data;
		 param.datacenter = $('#datacenter').combobox('getValue');
		 param.connParam = connParam;
		 param.plattype = connPlattype;
		 param.serveruserid=serveruserid;
		 param.platformid = platformid;
	    },	 
    	onSelect: function(rec){  
    		storageCombobox(rec.id);
    		networkCombobox(rec.id);
        }
	}); 
}
//存储下拉框
function storageCombobox(data){
  var serveruserid = $('#serveruserid_').val();
    var platformid = $('#platform_').val();
	$('#storage').combobox({    
	    url:'${pageContext.request.contextPath}/vm/getstorage.do',      
	    valueField:'id',    
	    textField:'id',
	    onBeforeLoad: function(param){
		 param.host = data;
		 param.connParam = connParam;
		 param.plattype = connPlattype;
		 param.serveruserid=serveruserid;
		 param.platformid = platformid;
	    }	 
	}); 
}
//网络下拉框
function networkCombobox(data){
  var serveruserid = $('#serveruserid_').val();
    var platformid = $('#platform_').val();
	$('#network').combobox({    
	    url:'${pageContext.request.contextPath}/vm/getnetwork.do',      
	    valueField:'id',    
	    textField:'id',
	    onBeforeLoad: function(param){
		 param.host = data;
		 param.connParam = connParam;
		 param.plattype = connPlattype;
		 param.serveruserid=serveruserid;
		 param.platformid = platformid;
	    },	
	    onSelect: function(rec){  
	    	//$('#network1').val(rec.id);
        }
	}); 
}
//提交按钮
function ok(){
	if($('#vmCreateForm').form('validate')){
		 $('#vmCreateForm').form('submit', {
					url : '${pageContext.request.contextPath}/vm/saveVmFirst.do',
					onSubmit : function(param) {
						param.datacenter = $('#datacenter').combobox('getValue'); 
						param.cluster = $('#cluster').combobox('getValue');
						param.host = $('#host').combobox('getValue');
						param.storage = $('#storage').combobox('getValue');
						param.network = $('#network').combobox('getValue');
						param.template = $('#template').combobox('getValue');
						param.cpunum = $('#cpunum').textbox('getValue');
						param.memnum = $('#memnum').textbox('getValue');
						param.disknum = $('#disknum').textbox('getValue');
						param.displayname = $('#displayname').textbox('getValue');
						param.description = $('#description').textbox('getValue');
						param.flowid = $('#flowid').val();
						param.detailid = $('#detailid_').val();
						param.platform = $('#platform_').val();
						param.connparam =  connParam;
						param.connplattype = connPlattype;
						param.serveruserid = $('#serveruserid_').val();
					},
					success : function(retr) {
						var _data = $.parseJSON(retr);
						if (_data.success) {
							$.messager.alert('提示', _data.msg, 'info');
							serveridArray.push(_data.obj);
						} else {
							$.messager.alert('提示', _data.msg, 'error');
						}
						$('#w').window('close');
						$('#vmlist_grid').datagrid('reload');
					}
		}); 
	}
}
//网络配置提交按钮
function ok1(){
	if($('#vmCreateForm1').form('validate')){
		$('#vmCreateForm1').form('submit', {
					url : '${pageContext.request.contextPath}/vm/saveVmSecond.do',
					onSubmit : function(param) {
						var bw = $('#interbw').textbox('getValue');
						var port = $('#interport').textbox('getValue');
						if(-1 != bw.indexOf("：") || -1 != bw.indexOf("；") || -1 != port.indexOf("：") || -1 != port.indexOf("；")){
							$.messager.alert('提示', '请使用英文格式分隔符！', 'error');
							return false;
						}
						
						var bwArr = bw.split(";");
						var portArr = port.split(";");
						if(-1 == bw.indexOf("联通") || -1 == bw.indexOf("移动") || -1 == bw.indexOf("电信")
								|| -1 == port.indexOf("联通") || -1 == port.indexOf("移动") || -1 == port.indexOf("电信")
								|| "联通" != bwArr[0].split(":")[0] || "移动" != bwArr[1].split(":")[0] || "电信" != bwArr[2].split(":")[0]
								|| "联通" != portArr[0].split(":")[0] || "移动" != portArr[1].split(":")[0] || "电信" != portArr[2].split(":")[0]){
							$.messager.alert('提示', '请按照格式要求顺序：联通、移动、电信！', 'error');
							return false;
						}
						
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
						param.detailid = $('#detailid1_').val();
						param.imode = $('#imode').val();
					},
					success : function(retr) {
						var _data = $.parseJSON(retr);
						if (_data.success) {
							$.messager.alert('提示', _data.msg, 'info');
						} else {
							$.messager.alert('提示', _data.msg, 'error');
						}
						$('#w1').window('close');
						$('#vmlist_grid').datagrid('reload'); 
					}
		});
	} 
}
//销毁按钮
function ok2(){
	$('#vmCreateForm2').form('submit', {
				url : '${pageContext.request.contextPath}/vm/delVm.do',
				onSubmit : function(param) {
					param.serverid = $('#serverid2_').val();
					param.flowid = $('#flowid').val();
					param.detailid = $('#detailid2_').val();
				},
				success : function(retr) {
					var _data = $.parseJSON(retr);
					if (_data.success) {
						$.messager.alert('提示', _data.msg, 'info');
					} else {
						$.messager.alert('提示', _data.msg, 'error');
					}
					$('#w2').window('close');
					$('#vmlist_grid').datagrid('reload'); 
				}
	});
}
//修改提交按钮
function ok3(){
	$('#vmCreateForm3').form('submit', {
				url : '${pageContext.request.contextPath}/vm/changeVm.do',
				onSubmit : function(param) {
					var port = $('#change_interport').textbox('getValue');
					if("" != port){
						if(-1 != port.indexOf("：") || -1 != port.indexOf("；")){
							$.messager.alert('提示', '请使用英文格式分隔符！', 'error');
							return false;
						}
						
						var portArr = port.split(";");
						if(-1 == port.indexOf("联通") || -1 == port.indexOf("移动") || -1 == port.indexOf("电信")
								|| "联通" != portArr[0].split(":")[0] || "移动" != portArr[1].split(":")[0] || "电信" != portArr[2].split(":")[0]){
							$.messager.alert('提示', '请按照格式要求顺序：联通、移动、电信！', 'error');
							return false;
						}
					}
					
					param.interport = $('#change_interport').textbox('getValue');
					param.uip = $('#uip_').textbox('getValue');
					param.uintraip = $('#uintraip_').textbox('getValue');
					param.uintraport = $('#uintraport_').textbox('getValue');
					param.mip = $('#mip_').textbox('getValue');
					param.mintraip = $('#mintraip_').textbox('getValue');
					param.mintraport = $('#mintraport_').textbox('getValue');
					param.tip = $('#tip_').textbox('getValue');
					param.tintraip = $('#tintraip_').textbox('getValue');
					param.tintraport = $('#tintraport_').textbox('getValue');
					param.serverid = $('#serverid3_').val();
					param.flowid = $('#flowid').val();
					param.detailid = $('#detailid3_').val();
					$.blockUI({
		               message: "<h2>请求已发送,请稍后......</h2>",
		              css: {zIndex:'10001', color:'#fff', border:'3px solid #aaa', backgroundColor:'#CCCCCC' },
		              overlayCSS: {opacity:'0.0'}
		             });
					
				},
				success : function(retr) {
					$.unblockUI();
					var _data = $.parseJSON(retr);
					if (_data.success) {
						$.messager.alert('提示', _data.msg, 'info');
					} else {
						$.messager.alert('提示', _data.msg, 'error');
					}
					$('#w3').window('close');
					$('#vmlist_grid').datagrid('reload'); 
				}
	});
}
//提交按钮 这个方法用于创建vm完成，或者创建网络完成，或者其他操作完成后进行的提交
function ok4(){
	jQuery.ajax( {
		url : "${pageContext.request.contextPath}/jsonvm/befConfirmflow.do",
		data : {
			'flowid' : $('#flowid').val(), 
			'stepno' : $('#stepno').val(),
			/* 'ftp_address' : $('#ftp_address').val(),
			'ftp_username' : $('#ftp_username').val(),
			'ftp_pass' : $('#ftp_pass').val(),
			'vpn_address' : $('#vpn_address').val(),
			'vpn_username' : $('#vpn_username').val(),
			'vpn_pass' : $('#vpn_pass').val()*/
			} ,
		type : "post",
		cache : false,
		dataType : "json",
		success : function(retr) {
			if (retr.success) {
				$.messager.alert('提示', retr.msg, 'info');
			} else {
				$.messager.alert('提示', retr.msg, 'error');
			}
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
					<th data-options="field:'uuid',width:30,align:'center',hidden:'true'">序号</th>
					<th data-options="field:'isimage',width:30,align:'center',hidden:'true'">镜像</th>
					<th data-options="field:'detailid',width:30,align:'center'">序号</th>
					<th data-options="field:'cpunum',width:40,align:'center'">CPU(核)</th>
					<th data-options="field:'memnum',width:40,align:'center'">内存(G)</th>
					<th data-options="field:'disknum',width:90,align:'center',formatter:diskformater">硬盘(G)</th>
					<th data-options="field:'osname',width:100,align:'center'">操作系统</th>
					<th data-options="field:'imode',width:60,align:'center'">接入模式</th>
					<th data-options="field:'interbw',width:110,align:'center'">公网带宽(M)</th>
					<th data-options="field:'interport',width:200,align:'center'">公网端口</th>
					<th data-options="field:'status',width:60,align:'center',formatter:optionformater">操作</th>
				</tr>
			</thead>
		</table>
		<!-- <table id="data_table4" align="center" style="width:100%">
			<tr>
				<td class="FieldLabel2">ftp访问地址：</td>
				<td class="FieldInput2" style="width:25%;"><input id="ftp_address" class="easyui-textbox" style="height:30px;"/></td>
				<td class="FieldLabel2" style="width:15%;">用户名：</td>
				<td class="FieldInput2" style="width:25%;"><input id="ftp_username" class="easyui-textbox" data-options="height:30"/></td>
				<td class="FieldLabel2">密码：</td>
				<td class="FieldInput2" style="width:25%;"><input id="ftp_pass" class="easyui-textbox" data-options="height:30"/></td>
			</tr>
			<tr>
				<td class="FieldLabel2">vpn访问地址：</td>
				<td class="FieldInput2" style="width:25%;"><input id="vpn_address" class="easyui-textbox" style="height:30px;"/></td>
				<td class="FieldLabel2" style="width:15%;">用户名：</td>
				<td class="FieldInput2" style="width:25%;"><input id="vpn_username" class="easyui-textbox" data-options="height:30"/></td>
				<td class="FieldLabel2">密码：</td>
				<td class="FieldInput2" style="width:25%;"><input id="vpn_pass" class="easyui-textbox" data-options="height:30"/></td>
			</tr>
		</table> -->
	</div>
	<%--<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
		<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="ok4();" style="width:80px">提交</a>
		<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#dd').dialog('close');" style="width:80px">取消</a>
	</div>--%>
</div>
<div id="w3" class="easyui-window" title="云服务器修改配置" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save',inline:true" style="width:900px;height:400px;padding:5px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;">
			<form id="vmCreateForm3" method="post">
			<input type="hidden" id="serverid3_"/>
			<input type="hidden" id="detailid3_"/>
			<input type="hidden" id="serveruserid3_"/>
			<table id="data_table3" align="center" style="width:100%">
				<tr id="cpu_tr" style="display:none;">
					<td class="FieldLabel2">CPU(申请)：</td>
					<td class="FieldInput2" style="width:25%;"><input id="change_cpu" class="easyui-textbox" data-options="height:30,editable:false"/></td>
					<td class="FieldLabel2" style="width:15%;">CPU(当前)：</td>
					<td class="FieldInput2" colspan="3" style="width:25%;"><input id="current_cpu" class="easyui-textbox" data-options="height:30,editable:false"/></td>
				</tr>
				<tr id="mem_tr" style="display:none;">
					<td class="FieldLabel2">内存(申请)：</td>
					<td class="FieldInput2" style="width:25%;"><input id="change_mem" class="easyui-textbox" data-options="height:30,editable:'false'"/></td>
					<td class="FieldLabel2" style="width:15%;">内存(当前)：</td>
					<td class="FieldInput2" colspan="3" style="width:25%;"><input id="current_mem" class="easyui-textbox" data-options="height:30,editable:false"/></td>
				</tr>
				<tr id="disk_tr" style="display:none;">
					<td class="FieldLabel2">数据盘(申请)：</td>
					<td class="FieldInput2" style="width:25%;"><input id="change_disk" class="easyui-textbox" data-options="height:30,editable:'false'"/></td>
					<td class="FieldLabel2" style="width:15%;">数据盘(当前)：</td>
					<td class="FieldInput2" colspan="3" style="width:25%;"><input id="current_disk" class="easyui-textbox" data-options="height:30,editable:false"/></td>
				</tr>
				<tr id="interbw_tr" style="display:none;">
					<td class="FieldLabel2">公网带宽(申请)：</td>
					<td class="FieldInput2" style="width:25%;"><input id="change_interbw" class="easyui-textbox" data-options="height:30,editable:false"/></td>
					<td class="FieldLabel2" style="width:15%;">公网带宽(当前)：</td>
					<td class="FieldInput2" colspan="3" style="width:25%;"><input id="current_interbw" class="easyui-textbox" data-options="height:30,editable:false"/></td>
				</tr>
				<tr id="interport_tr" style="display:none;">
					<td class="FieldLabel2">公网端口(申请)：</td>
					<td class="FieldInput2" style="width:25%;"><input id="change_interport" class="easyui-textbox" data-options="height:30"/></td>
					<td class="FieldLabel2" style="width:15%;">公网端口(当前)：</td>
					<td class="FieldInput2" colspan="3" style="width:25%;"><input id="current_interport" class="easyui-textbox" data-options="height:30,editable:false"/></td>
				</tr>
				<tr id="imode_utr" style="display:none;">
					<td class="FieldLabel2">联通公网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="uip_" class="easyui-textbox" style="height:30px;"/></td>
					<td class="FieldLabel2" style="width:15%;">内网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="uintraip_" class="easyui-textbox" data-options="height:30,prompt:'联通公网对应内网IP'"/></td>
					<td class="FieldLabel2">内网端口：</td>
					<td class="FieldInput2" style="width:25%;"><input id="uintraport_" class="easyui-textbox" data-options="height:30,prompt:'联通公网对应内网端口'"/></td>
				</tr>
				<tr id="imode_mtr" style="display:none;">
					<td class="FieldLabel2">移动公网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="mip_" class="easyui-textbox" style="height:30px;"/></td>
					<td class="FieldLabel2" style="width:15%;">内网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="mintraip_" class="easyui-textbox" data-options="height:30,prompt:'移动公网对应内网IP'"/></td>
					<td class="FieldLabel2">内网端口：</td>
					<td class="FieldInput2" style="width:25%;"><input id="mintraport_" class="easyui-textbox" data-options="height:30,prompt:'移动公网对应内网端口'"/></td>
				</tr>
				<tr id="imode_ttr" style="display:none;">
					<td class="FieldLabel2">电信公网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="tip_" class="easyui-textbox" style="height:30px;"/></td>
					<td class="FieldLabel2" style="width:15%;">内网IP：</td>
					<td class="FieldInput2" style="width:25%;"><input id="tintraip_" class="easyui-textbox" data-options="height:30,prompt:'电信公网对应内网IP'"/></td>
					<td class="FieldLabel2">内网端口：</td>
					<td class="FieldInput2" style="width:25%;"><input id="tintraport_" class="easyui-textbox" data-options="height:30,prompt:'电信公网对应内网端口'"/></td>
				</tr>
			</table>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="ok3();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#w3').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
<div id="w2" class="easyui-window" title="云服务器销毁" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save',inline:true" style="width:500px;height:200px;padding:5px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;">
			<form id="vmCreateForm2" method="post">
			<input type="hidden" id="serverid2_"/>
			<input type="hidden" id="detailid2_"/>
			<input type="hidden" id="serveruserid2_"/>
			请确认该云服务器已关机的状态下进行销毁操作，确认需要销毁吗？
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="ok2();" style="width:80px">确认</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#w2').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
<div id="w1" class="easyui-window" title="云服务器网络配置" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save',inline:true" style="width:900px;height:400px;padding:5px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;">
			<form id="vmCreateForm1" method="post">
			<input type="hidden" id="serverid_"/>
			<input type="hidden" id="imode"/>
			<input type="hidden" id="detailid1_"/>
			<input type="hidden" id="serveruserid1_"/>
			<table id="data_table1" align="center" style="width:100%">
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
			</table>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="ok1();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#w1').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
<div id="w" class="easyui-window" title="创建云服务器" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save',inline:true" style="width:900px;height:400px;padding:5px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;">
			<form id="vmCreateForm" method="post" data-options="novalidate:true">
			<input type="hidden" id="platform_"/>
			<input type="hidden" id="detailid_"/>
			<input type="hidden" id="serveruserid_"/>
			<table id="data_table" align="center" style="width:100%">
				<tr>
					<td class="FieldLabel2">虚拟平台：</td>
					<td class="FieldInput2"><input id="platform" class="easyui-combobox" style="height:30px;" data-options="required:true,editable:false,panelHeight:'auto'"/></td>
					<td class="FieldLabel2">数据中心：</td>
					<td class="FieldInput2"><input id="datacenter" class="easyui-combobox" style="height:30px;" data-options="required:true,editable:false,panelHeight:'auto'"/></td>
				</tr>
				<tr name="vmdis">
					<td class="FieldLabel2" style="">集&emsp;&emsp;群：</td>
					<td class="FieldInput2" id="clusterField"><input id="cluster" class="easyui-combobox" style="height:30px;" data-options="required:true,editable:false,panelHeight:'auto'"/></td>
					<td class="FieldLabel2">宿主机：</td>
					<td class="FieldInput2" id="hostField"><input id="host" class="easyui-combobox" style="height:30px;" data-options="required:true,editable:false,panelHeight:'auto'"/></td>
				</tr>
				<tr>
					<td class="FieldLabel2">网&emsp;&emsp;络：</td>
					<td class="FieldInput2"><input id="network" class="easyui-combobox" style="height:30px;" data-options="required:true,editable:false,panelHeight:'auto'"/></td>
					<td class="FieldLabel2">模&emsp;&emsp;板：</td>
					<td class="FieldInput2"><input id="template" class="easyui-combobox" style="height:30px;" data-options="required:true,editable:false,panelHeight:'auto'"/></td>
				</tr>
				<tr>
					<td class="FieldLabel2" name="vmdis">存&emsp;&emsp;储：</td>
					<td class="FieldInput2" name="vmdis" id="storageField"><input id="storage" class="easyui-combobox" style="height:30px;" data-options="required:true,editable:false,panelHeight:'auto'"/></td>
					<td class="FieldLabel2">数据盘：</td>
					<td class="FieldInput2"><input id="disknum" class="easyui-textbox" style="height:30px;" data-options="editable:false"/></td>
				</tr>
				<tr>
					<td class="FieldLabel2">CPU：</td>
					<td class="FieldInput2"><input id="cpunum" class="easyui-textbox" style="height:30px;" data-options="editable:false"/></td>
					<td class="FieldLabel2">内存：</td>
					<td class="FieldInput2"><input id="memnum" class="easyui-textbox" style="height:30px" data-options="editable:false"/></td>
				</tr>
				<tr>
					<td class="FieldLabel2">实例名称：</td>
					<td class="FieldInput2"><input id="displayname" class="easyui-textbox" style="height:30px;" data-options="required:true"/></td>
					<td class="FieldLabel2">实例描述：</td>
					<td class="FieldInput2"><input id="description" style="height:53px;" class="easyui-textbox" data-options="multiline:true" /></td>
				</tr>
			</table>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="ok();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#w').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>

<!-- jx -->

</body>
