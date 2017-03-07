<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String operType = request.getParameter("operType")==null?"":request.getParameter("operType").toString();//工单拆分 子流程 实施操作标记 gdcf
String operFlowSign = "2";//1资源申请，2资源变更
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>资源变更实施</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery-1.8.3.min.js" charset="utf-8"></script>
	<link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/default/easyui.css" type="text/css">
    <link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/icon.css" type="text/css">
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>/js/sockjs-0.3.min.js"></script>
  </head>
  <body >
  	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/orderlist/order-fq.css">
     	<div> 
			<table id="dg_resourceChange"  style="width:100%" height='auto'>
				<thead>
				<tr>
					<th data-options="field:'detailid',width:30,align:'center'">序号</th>
					<th data-options="field:'useunitname',width:100,align:'center'">所属单位</th>
					<th data-options="field:'pname',width:90,align:'center'">服务名称</th>
					<th data-options="field:'neid',width:130,align:'center'">实例名称</th>
					<th data-options="field:'appname',width:70,align:'center'">应用</th>
					<th data-options="field:'oldconfigure',width:100,align:'center'">原有规格</th>
					<th data-options="field:'newconfigure',width:100,align:'center'">变更规格</th>
					<th data-options="field:'networktype',width:60,align:'center'">网络类型</th>
					<th data-options="field:'tnumber',width:30,align:'center'">数量</th>
					<th data-options="field:'operatetype',width:50,align:'center',formatter:operTypeFormater">操作类型</th>
					<th data-options="field:'impusername',width:45,align:'center'">实施人</th>
					<th data-options="field:'status',width:40,align:'center',formatter:statusformater">状态</th>
					<th data-options="field:'statusT',width:40,align:'center',formatter:operformater">操作</th>
				</tr>
				</thead>
			</table>
     	 </div>
     	 
    <div id="serviceWindow3">
    </div>
    
    <div id="serviceWindow4">
    </div>
    
    <!-- 其他弹出层1 -->
    <div id="serviceWindowZybgSs_other" style="dispaly:none;">
    	<!-- 占位 -->
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 10px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
    	<div class="lcy-window-item">
            <div class="lcy-window-item-body">
                <textarea id="configSs" style="width: 500px;height:170px; " disabled></textarea>
            </div>
            <div class="lcy-window-item-header">规格配置</div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body">
                <textarea id="remarkSs" style="width: 500px;height: 170px; "></textarea>
            </div>
            <div class="lcy-window-item-header">实施信息</div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 5px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                <ul id="networkSs_other">
                    <li value="10001">政务外网</li>
                    <li value="10002">互联网</li>
                </ul>
                </ul>
            </div>
            <div class="lcy-window-item-header">网络</div>
        
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 5px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                 <input id="resourceappSs_other" style="width: 320px;height: 30px; "disabled>
            </div>
            <div class="lcy-window-item-header">应用名称</div>
        </div>
         <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 10px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
    	<div class="lcy-window-item" >
            <div class="lcy-window-item-body" >
                <div class="add-sub" >
                    <input class="input-num" id="inptNumSs" type="text" value="1" style="border-left:1px solid #ddd;border-right:1px solid #ddd;width:50px !important;" disabled />
               		&nbsp;<span id="danwei"></span>
                </div>
            </div>
            <div class="lcy-window-item-header">数量</div>
        </div>
       <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 30px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
    
    </div>
    <!-- 其他弹出层 结束 -->
    <!-- 云硬盘实施 -->
 	<div id="yypbg_window">
 	<style>
	 	.hjb-textbox{margin-left: 0px;
		margin-right: 0px;
		padding-top: 6px;
		padding-bottom: 6px;
		width: 212px;font-size: 12px;
		border:1px solid #ddd;
		margin: 0;
		padding: 4px;
		vertical-align: middle;
		outline-style: none;
		resize: none;
		
		border-radius: 5px 5px 5px 5px;}
		.not-allowed{background: #eee;
    	cursor: not-allowed;}
	</style>
	     <form id="yyp_form">
	     	<div class="order_resourcepool" style="margin: 15px 25px 15px 25px">
	            <label for="storeName" style="display:inline-block;width:80px;">硬盘名称:</label>   
	           	<input id="storeName" style="width: 222px;height: 30px; "  name="storeName"  readonly="readonly"  autocomplete="off" class="hjb-textbox not-allowed">
	        	<!-- <input id="platformid" type="hidden">
	        	<input id="storeinfo" type="hidden"> -->
	        </div>
	        <div class="order_resourcepool" style="margin: 15px 25px 15px 25px">
	            <label for="storeNum" style="display:inline-block;width:80px;">硬盘容量(G):</label>   
	           	<input  id="storeNum" style="width: 222px;height: 30px; "  name="storeNum"  autocomplete="off" class="hjb-textbox">
	        </div>
	        <!-- <div class="order_resourcepool" style="margin: 15px 25px 15px 25px">
	            <label for="attachNeid" style="display:inline-block;width:80px;">挂载云服务器:</label>   
	           	<input id="attachNeid" style="width: 222px;height: 30px; " autocomplete="off" class="hjb-textbox">
	        </div> -->
	        <!-- <div class="order_resourcepool" style="margin: 15px 25px 15px 25px">
	           	<label for="ipaddress" style="display:inline-block;width:80px;">云服务器IP:</label>   
	           	<input  id="ipaddress" style="width: 222px;height: 30px; "  name="ipaddress" autocomplete="off" class="hjb-textbox not-allowed">
	        </div> -->
	     </form>
    </div>
    
 
 	<%--实施任务指派选择人员弹框  start--%>
 	<div id="assignUserWindowRc" style="padding:3px 0px;">
	    <table class="" width="100%">
	        <tr>
	            <td align="right" width="20%" style="padding-top:10px; padding-bottom:10px;">姓名：</td>
	            <td align="left" width="80%" style="padding-top:10px; padding-bottom:10px;">
	                <input type="text"  id="searchName" name="searchName" class="ty-top-input" style="width: 120px;">
	                <a href="javascript:void(0);" id="userQueryBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="queryUserDg()">查询</a>
					<a href="javascript:void(0);" id="userResetBtn" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="queryChongzhi()">重置</a>
	            </td>
	        </tr>
	    </table>
        <div style="overflow-y: !important;" id="dgDivRc">
        	<style>#dgDivRc input[type=checkbox]{width:auto!important;}</style>
			<table  id="dg_assignUserRc" width="100%" border="0" cellpadding="0" cellspacing="0" >
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true,align:'center',width:'60px'"></th>
						<th data-options="field:'uname',align:'center',width:'80px'">姓名</th>
						<th data-options="field:'sysname',align:'center',width:'150px'">部门</th>
						<th data-options="field:'email',align:'center',width:'140px'">邮箱</th>
						<th data-options="field:'mobile',align:'center',width:'80px'">手机</th>
					</tr>
				</thead>
			</table>
        </div>
     </div>
     <%--实施任务指派选择人员弹框 end--%>   
  
  <script type="text/javascript">
       var rowObject;//实施页面，列表数据
  	   var netWorkI = 0;//全局变量，控制网络类型li标签移除样式
	   var resourcepoolurl="${pageContext.request.contextPath}/vmconfig/queryResourcePool.do";
	   var instancesnetworkurl="${pageContext.request.contextPath}/vmconfig/queryVlan.do";
	   var row;
	   var ws = null;
	   var url = null;
	   var transports = [];
	   updateUrl('/icpmg/sockjs/echo');
	   connect();
  
	   var windowHtml3 = $('#serviceWindow3').html();
	   function updateUrl(urlPath) {
			if (urlPath.indexOf('sockjs') != -1) {
				url = urlPath;
			} else {
				if (window.location.protocol == 'http:') {
					url = 'ws://' + window.location.host + urlPath;
				} else {
					url = 'wss://' + window.location.host + urlPath;
				}
			}
		} 
  
	  function connect() {
	      	if(window.eventactive){
		    	window.eventactive.close();
			 	window.eventactive=null;
			}
			if (!url) {
				alert('Select whether to use W3C WebSocket or SockJS');
				return;
			}
			ws = (url.indexOf('sockjs') != -1) ? new SockJS(url, undefined, {
				protocols_whitelist : transports
			}) : new WebSocket(url);
	        window.eventactive = ws;
			ws.onopen = function() {
	          
			};
			ws.onmessage = function(event) {
			var data = event.data;
			var data =  JSON.parse(data);
			var info = data.msg;
			if(data.flag=="success"){
		    var displayname = data.vmname;
		     $.messager.alert('提示',displayname+"销毁成功!","info");
		     $('#dg_resourceChange').datagrid('reload');
		    }
		    else if(data.flag=="fail"){
		      $.messager.alert('提示',displayname+"销毁失败!","info");
		      $('#dg_resourceChange').datagrid('reload');
		    }
		    else {
		    
		    $.messager.alert('提示',info,"info");
		    $('#dg_resourceChange').datagrid('load', {});
		   
			};
		    }
			ws.onclose = function(event) {
	 
			};
		}
	
	  	//实施列表
		$('#dg_resourceChange').datagrid({
		       rownumbers:false,
		       striped:true,
		       nowarp:false,
		       scrollbarSize: 0,
		       singleSelect: true,
			   sortName:'detailid',
			   sortOrder:'asc',
			   url:'<%=basePath%>/resourcechange/findResourceChangeToDo.do?transferid=<%=request.getParameter("transferid")%>&operType=<%=operType%>',
			   method:'post',
			   loadMsg:'数据装载中......',
			   fitColumns:true,
			   idField:'detailid',
			   onLoadSuccess: function (data) {
					$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
			    }
		 })
		
	 //状态
	 function statusformater(value,row,index){
			switch (value) {
				case "1":
					return "实施成功";
				case "3":
					return "实施失败";
				case "2":
					return "实施中";
				case "0":
					return "未完成";
				case "4":
					return "待实施";
				case "5":
					return "驳回";
				case "6":
					return "废弃";
			}
	  }
	  	
	 //操作
     function operformater(value, row, index){ 
		switch (value) {
			case "1":
				return "";
			case "3":
				return "<a  style=\"color:red;cursor:pointer;\" onclick=\"resourceOperType('" + index + "');\">实施</a>";
			case "2":
				return "";
			case "0":
				if('<%=operType%>' == "gdcfAssign"){//工单拆分，指派实施人员
					return "<a  style=\"color:green;cursor:pointer;\" onclick=\"assignResourceToDo('" + index+"','"+value + "');\">指派</a>";
				}else{
					return "<a  style=\"color:green;cursor:pointer;\" onclick=\"resourceOperType('" + index + "');\">实施</a>";
				}
			case "4":
				if('<%=operType%>' == "gdcf"){//工单拆分，实施人员实施
					return "<a  style=\"color:green;cursor:pointer;\" onclick=\"resourceOperType('" + index+"','"+value + "','<%=operType%>');\">实施</a>";
				}else{//实施经理页面
					return "";
				}
			case "5":
				/*
				return "驳回"+"  |  "+"<a  style=\"color:red;cursor:pointer;\" onclick=\"feiqi('" + index+"','"+value + "');\">废弃</a>"+
						"  |  "+"<a  style=\"color:green;cursor:pointer;\" onclick=\"assignResourceToDo('" + index+"','"+value + "');\">重新指派</a>";*/
			  return  "<a  style=\"color:green;cursor:pointer;\" onclick=\"assignResourceToDo('" + index+"','"+value + "');\">重新指派</a>";
			case "6":
				return "";
			case "7":
			return "<span style='color:#ccc'>实施</span>";
		}
     }
    
	 //操作类型
	 function operTypeFormater(value,row,index){
		 switch(value){
			 case "1":
				 return "变更";
			 case "2":
				 return "注销";
		 }
	 }
  		
	//统一弹层配置--其他弹层
	$('#serviceWindowZybgSs_other').dialog({
 	    width: 820,
        //height: 540,
        closed: true,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: function() {
            	var remark = $("#remarkSs").val();
            	$.ajax({
  				  type:'post',
  				  url:'${pageContext.request.contextPath}/resourcechange/resourceChangeOperateOther.do',
  				  data:{
  					  flowid:'<%=request.getParameter("transferid")%>',
  					  updateorderid:row['updateorderid'],
  					  detailid:row['detailid'],
  					  neid:row['neid'],
  					  shopid:row['shopid'],
  					  newconfigure:row['newconfigure'],
  					  tnumber:row['tnumber'],
  					  status:row['status'],
  					  newtprice:row['newtprice'],
  					  stepno:row['stepno'],
  					  operatetype:row['operatetype'],
  				  	  newtprice:row['newtprice'],
  				  	  remark:remark,
  				  	  measureunit:row['measureunit'],
  				  	  operType:'<%=operType%>'
  				  },
  				  beforeSend: function(){
  					$('#serviceWindowZybgSs_other').dialog('close');
  	                 load("正在实施，请稍等。。。");
  	              },
  				  success:function(retr){
  					  $("#remarkSs").val("");
  				  	  var data = JSON.parse(retr);
  				  	  disLoad("操作完成");
  				  	  $.messager.alert('消息',data.msg);
  				  	  $('#dg_resourceChange').datagrid('reload');
  				  }
  			  });
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
            	$("#remarkSs").val("");
                $('#serviceWindowZybgSs_other').dialog('close');
            }
        }]
    });
	
	  //操作
	  function resourceOperType(index){
		  row = $('#dg_resourceChange').datagrid('getData').rows[index];
		   $('#dg_resourceChange').datagrid('updateRow',{
			index: index,
			row: {
				statusT: '7', 
			}
		});
	      var operatetype = row['operatetype'];//1变更，2注销
	      var shopId = row['shopid'];
	      if(shopId == "200001"){//云服务器
	    	  if(operatetype == "1"){//云服务器变更实施
		    	  $.ajax({
					  type:'post',
					  url:'${pageContext.request.contextPath}/vm/resourchangeOperUpdateVm.do',
					  data:{
						  serverid:row['neid'],
					  	  flowid: '<%=request.getParameter("transferid")%>',
					  	  detailid:row['detailid'],
					  	  newconfigure:row['newconfigure'],
					  	  cpunum:row['cpunum'],
					  	  memnum:row['memnum'],
					  	  disknum:row['disknum'],
					  	  updateorderid: row['updateorderid'],
					  	  stepno:row['stepno'],
					  	  newtprice:row['newtprice'],
					  	  operType:'<%=operType%>'
					  },
					  beforeSend: function(){
		                 //load("正在实施，请稍等。。。");
		              },
					  success:function(retr){
					  	  var data = JSON.parse(retr);
					  	  disLoad("操作完成");
					  	  $.messager.alert('消息',data.msg);
					  	  $('#dg_resourceChange').datagrid('reload');
					  }
				  });
		      }else{//云服务器注销实施
		    	  $.ajax({
					  type:'post',
					  url:'${pageContext.request.contextPath}/vm/resourchangeOperDelVm.do',
					  data:{
						  serverid:row['neid'],
						  updateorderid:row['updateorderid'],
						  detailid:row['detailid'],
						  neid:row['neid'],
						  stepno:row['stepno'],
						  operatetype:row['operatetype'],
						  flowid: '<%=request.getParameter("transferid")%>',
						  operType:'<%=operType%>'
						  
					  },
					  beforeSend: function(){
		                 //load("正在实施，请稍等。。。");
		              },
					  success:function(retr){
					  	  var data = JSON.parse(retr);
					  	  disLoad("操作完成");
					  	  $.messager.alert('消息',data.msg);
					  	  $('#dg_resourceChange').datagrid('reload');
					  	  
					  }
				  });
		      }
	      }else if(shopId == "200005"){//云硬盘
	    	  if(operatetype == "1"){//云硬盘变更实施
	    		  $('#yypbg_window').dialog({
		  	            closed: false,
		  	            title: "云硬盘变更",
		  	            top:"20px" ,
		           });
	    		  <%-- var neid = row['neid'];
	    		  var unitid = '';
	    		  var platformid = '';
	    		  var networktypeid = '';
	    		  var orderid = '';
	    		  var detailid = '';
	    		  $.ajax({
		   				type:'post',
		   				url:'<%=basePath%>/indisk/getUnitInfo.do?neid='+neid,
		   				async: false,//使用同步的方式,true为异步方式
		   			    dataType:'json',
		   			 	success:function(data){
		   			 		unitid = data.unitid;
		   			 		networktypeid = data.networktypeid;
		   			 		platformid = data.platformid;
		   			 		orderid = data.orderid;
		   			 		detailid = data.detailid;
		   			 	}
		   			});
		   	       $('#attachNeid').combobox({			   
		   				valueField:'serverid',
		   			    textField:'displayname',
		   				panelWidth: 222, 
		   		   }); --%>
	    		   var confInfo = row.newconfigure;//容量：3
		   	       //var confInfoArray = new Array();
		   	       //confInfoArray = confInfo.split(";");
		   	       //var name = confInfoArray[0].split(":")[1];
		   	       //var serverid = confInfoArray[2].split(":")[1];//挂载云服务器
		   	       var store = confInfo.split(":")[1];//容量
		   	       //var storeinfo = confInfoArray[4].split(":")[1];//描述
		   	       $("#storeName").val(row.neid);
		   	       $("#storeNum").val(store);
		   	       //$("#attachNeid").val(serverid);
		   	      
		   	       //$("#storeinfo").val(storeinfo);
		   		   
	            	<%-- var detailid = row.detailid;
	            	var _ipaddr;
		   			$.ajax({
		   				type:'post',
		   				url:'<%=basePath%>/vm/queryVmById.do?serverid='+serverid,
		   				async: false,//使用同步的方式,true为异步方式
		   			    dataType:'json',
		   			 	success:function(data){
		   			 		_ipaddr = data.ipaddr
		   				 	$('#ipaddress').val(_ipaddr);
		   			 	}
		   			}); --%>
		   		   	 //var networktypeid = row.networkid;
		   		     /* $('#attachNeid').combobox({
		   				url: '${pageContext.request.contextPath}/vm/queryVmsByUnitid.do?unitid='+unitid+'&platformid='+platformid+'&networktypeid='+networktypeid,
		   				valueField:'serverid',
		   			    textField:'displayname',
		   				panelWidth: 222, 
		   				formatter: function(row){
		   					var s = '<span>' + row.displayname + '</span><br/>' +
		   					'<span style="color:#888">' + row.ipaddr + '</span>';
		   					return s;
		   				},
		   				onLoadSuccess: function(){
		   					$('#attachNeid').combobox('setValue', serverid);
		   				},
		   			    onSelect: function(rec){
		   			    	if(rec.serverid != serverid){
		     				  	$.ajax({
		     				  		type: 'post',
		     				  		url: '${pageContext.request.contextPath}/indisk/getCount.do',
		     				  		data: {serverid: rec.serverid},
		     				  		success: function(data){
		     				  			var _data = JSON.parse(data);
		     				  			if(_data.total > 1){
		     				  				$.messager.alert('消息','该服务器已挂载两个，请选择其他服务器'); 
		     				  				$('#attachServer').combobox('setValue', attachNeid);
		     				  			} else {
			   								$('#attachServerid').val(rec.serverid);
			   								$('#attachServername').val(rec.servername);
			   								$('#ipaddress').val(rec.ipaddr);
		     				  			}
		     				  		}
		     				  	});
		   			    	}else{
		   			    		$('#ipaddress').val(_ipaddr);
		   			    	}
		   				}
		   			}); */
	    		  
	    		  	
	    	  }else{//云硬盘注销实施
	    		  $.messager.confirm('提示','您确定要注销当前选择的云硬盘吗?',function(b){
	    		  	  if(b){
			    		  $.ajax({
							  type:'post',
							  url:'${pageContext.request.contextPath}/indisk/cancelIndisk.do',
							  data:{
								  diskid: row['neid'],
								  updateorderid: row['updateorderid'],
								  detailid: row['detailid'],
								  stepno: row['stepno'],
								  operatetype: row['operatetype'],
								  flowid: '<%=request.getParameter("transferid")%>',
								  operType:'<%=operType%>'
							  },
							  beforeSend: function(){
				                 //load("正在实施，请稍等。。。");
				              },
							  success:function(retr){
							  	  disLoad("操作完成");
							  	  $('#dg_resourceChange').datagrid('reload');
							  }
						  });
	    		  	  }else{
	    		  		  $('#dg_resourceChange').datagrid('reload');
	    		  	  }
	    	  	  });
	    	  }
	      }else{//非云服务器
	    	  excuteOther(row);
	      }
	  }
	 
	  //注销事件
	  function resourceDelete(index){
		  row = $('#dg_resourceChange').datagrid('getData').rows[index];
	  }
	  
	  //其他资源操作-非服务器资源实施
	  function excuteOther(row){
	      if(row['operatetype'] == "1"){//变更
	    	  /*
	    	  $('#networkSs_other li').eq(netWorkI).removeClass('active');
        	  
	    	  $("#configSs").val(row['newconfigure']);
	      	  var newnetworktype = row['networktype'];
	    	  var objli = document.getElementById('networkSs_other').getElementsByTagName("li");
	          for(var i=0;i<objli.length;i++){
		          if(objli[i].textContent == newnetworktype){
		        	  $('#networkSs_other li').eq(i).addClass('active');
		        	  netWorkI = i;
		          }
	          }
	      	  $("#inptNumSs").val(row['tnumber']);
	      	  $("#danwei").text(row['measureunit']);
	      	  $("#resourceappSs_other").val(row['appname']);
	    	  $('#serviceWindowZybgSs_other').dialog({
	    		  top:50,
	              closed: false,
	              increment: 1,
	              height: 540,
	              title: row['pname']
	           });*/
	    	  var dialog = parent.icp.modalDialog({
	               title : row['pname'],
	               width:820,
	               draggable:true,
	               url:'${pageContext.request.contextPath}/web/resourceChange/resourceChangeOtherOperate.jsp?'
	               		 	+'transferid=<%=request.getParameter("transferid")%>&configSs='+encodeURI(encodeURI(row.newconfigure))
	               		 	+'&networktype='+encodeURI(encodeURI(row.networktype))+'&tnumber='+row.tnumber+'&danwei='+encodeURI(encodeURI(row.measureunit))
	               		 	+'&appname='+encodeURI(encodeURI(row.appname))+'&detailid='+row.detailid+'&operType=<%=operType%>',
	               buttons: [{
	            	text: '确定',
	            	iconCls: 'icon-ok',
	           	 	handler: function() {
		            	  var stepsno = "<%=request.getParameter("stepno")%>";
				          var flowsid = "<%=request.getParameter("transferid")%>";
		                  dialog.find('iframe').get(0).contentWindow.submitForm(dialog,row,stepsno,flowsid);
	
		           		 }
	        		}, {
		            	text: '取消',
		           		iconCls: 'icon-cancel',
		            	handler: function() {
		               	dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
		           	 }
	        	}]
	         });
	      }else{//注销
	      
	    
	      if(row['shopid']=='200061') {
	         
	        $.post('${pageContext.request.contextPath}/resourcechange/resourceChangeOperateFW.do',
			   		{
					  flowid: '<%=request.getParameter("transferid")%>',
					  updateorderid:row['updateorderid'],
					  detailid:row['detailid'],
					  neid:row['neid'],
					  shopid:row['shopid'],
					  newconfigure:row['newconfigure'],
					  status:row['status'],
					  newtprice:row['newtprice'],
					  stepno:row['stepno'],
					  operatetype:row['operatetype'],
				  	  newtprice:row['newtprice'],
				  	  remark:"",
				  	  measureunit:row['measureunit'],
				  	  operType:'<%=operType%>'
				  },function(){});
	       } 
	       else{
	    	  $.ajax({
				  type:'post',
				  url:'${pageContext.request.contextPath}/resourcechange/resourceChangeOperateOther.do',
				  data:{
					  flowid: '<%=request.getParameter("transferid")%>',
					  updateorderid:row['updateorderid'],
					  detailid:row['detailid'],
					  neid:row['neid'],
					  shopid:row['shopid'],
					  newconfigure:row['newconfigure'],
					  status:row['status'],
					  newtprice:row['newtprice'],
					  stepno:row['stepno'],
					  operatetype:row['operatetype'],
				  	  newtprice:row['newtprice'],
				  	  remark:"",
				  	  measureunit:row['measureunit'],
				  	  operType:'<%=operType%>'
				  },
				  beforeSend: function(){
	                 load("正在实施，请稍等。。。");
	              },
				  success:function(retr){
				  	  var data = JSON.parse(retr);
				  	  disLoad("操作完成");
				  	  $.messager.alert('消息',data.msg);
				  	  $('#dg_resourceChange').datagrid('reload');
				  	  
				  }
			  });
	        
	        }
	       
	      }
	  }
	 function load(msg) {  
	     $("<div class=\"datagrid-mask\"></div>").css({ display: "block", width: "100%", height: $(window).height() }).appendTo("body");  
	     $("<div class=\"datagrid-mask-msg\"></div>").html(msg).appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });  
 	 } 
	 //取消加载层  
	 function disLoad() {  
	     $(".datagrid-mask").remove();  
	     $(".datagrid-mask-msg").remove();  
	 }
	
    //云硬盘
    $('#yypbg_window').dialog({
 	    width: 400,
        height: 230,
        closed: true,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        
        buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: function() {
            	//var serverid = $("#attachNeid").combobox('getValue');//云服务器id
            	//var platformid = $("#platformid").val();//平台
            	var displayname = $("#storeName").val();//名称
            	var disknum = $("#storeNum").val();//容量
            	//var description = $("#storeinfo").val();//描述
             	//基本信息	 
			 	var unitid = row.useunitid;
             	var unitname = row.useunitname;
             	var projectid =row.proid;
             	var projectname = row.proname;
             	var userid =row.userid;
             	var shopname = row.shopname;
             	var shopid = row.shopid;
             	var typeid = row.typeid;
             	var flowid = "<%=request.getParameter("transferid")%>";
             	var stepno = "<%=request.getParameter("stepno")%>";
             	var updateorderid = row.updateorderid;
             	var detailid = row.detailid;
             	var networkid = row.networkid;
             	var network = row.network;
             	var newconfigure = row.newconfigure;
             	var operType = "<%=operType%>";
             	var diskid = row.neid;
            	$.post('${pageContext.request.contextPath}/indisk/changeIndisk.do',{
            			displayname:displayname,disknum:disknum,unitid:unitid,userid:userid,typeid:typeid,diskid:diskid,
            	 		flowid:flowid,updateorderid:updateorderid,detailid:detailid,newconfigure:newconfigure,
            	 		stepno:stepno,shopid:shopid,shopname:shopname,projectid:projectid,projectname:projectname,
            	 		networkid:networkid,network:network,unitname:unitname,operType:operType
            	 	},function(){});
            	 	modifyFlag = 0;
                $('#yypbg_window').dialog('close');
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#yypbg_window').dialog('close');
                $('#dg_resourceChange').datagrid('reload');
           	 }
        }]
    });
 	// 弹层4
    $('#serviceWindow4').dialog({
        title: "实施",
        width: 640,
        height: 350,
        closed: true,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: function() {
                var iprow = $('.table-yy tr').length;
                var obj=[];
                for(var j=1;j<iprow;j++){
                      var internet = {};
                     
                      internet.outnetip = $('.table-yy tr').eq(j).find('.j-input').eq(0).val();
                      internet.equipmentname = $('.table-yy tr').eq(j).find('.j-input').eq(1).val();
                      internet.equipmenttype = $('.table-yy tr').eq(j).find('.j-input').eq(2).val();
                      internet.networkport = $('.table-yy tr').eq(j).find('.j-input').eq(3).val();
                      internet.innetip = $('.table-yy tr').eq(j).find('.j-input').eq(4).val();
                      internet.reflectport = $('.table-yy tr').eq(j).find('.j-input').eq(5).val();
                      
                      internet.bandwidth = $('.table-yy tr').eq(j).find('.j-input').eq(6).val();
                      obj.push(internet);
               }
               var jsonstr1 = JSON.stringify(obj);
               var jsonstr2 = JSON.stringify(row);
               var stepno = "<%=request.getParameter("stepno")%>";
			   var flowid = "<%=request.getParameter("transferid")%>";
			   $.post('${pageContext.request.contextPath}/workorder/internetIPOper.do',
			   		{jsonstr1:jsonstr1,jsonstr2:jsonstr2,
			   			stepno:stepno,flowid:flowid,operType:'<%=operType%>'},function(){});
               
                $('#serviceWindow4').dialog('close');
                $('#serviceWindow4').html("");
                
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#serviceWindow4').dialog('close');
            }
        }]
    });
 
  	// 弹层3
    $('#serviceWindow3').dialog({
        title: "实施",
        width: 843,
        height: 350,
        closed: true,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        buttons: [{
            text: '确定',
            conCls: 'icon-ok',
            handler: function() {
                var iprow = $('.table-yy tr').length;
                var obj=[];
                for(var j=1;j<iprow;j++){
                      var internet = {};
                      internet.iptype = $('.table-yy tr').eq(j).find('.j-input').eq(0).val();
                      internet.outnetip = $('.table-yy tr').eq(j).find('.j-input').eq(1).val();
                      internet.equipmentname = $('.table-yy tr').eq(j).find('.j-input').eq(2).val();
                      internet.equipmenttype = $('.table-yy tr').eq(j).find('.j-input').eq(3).val();
                      internet.networkport = $('.table-yy tr').eq(j).find('.j-input').eq(4).val();
                      internet.innetip = $('.table-yy tr').eq(j).find('.j-input').eq(5).val();
                      internet.reflectport = $('.table-yy tr').eq(j).find('.j-input').eq(6).val();
                      internet.modelname = $('.table-yy tr').eq(j).find('.j-input').eq(7).val();
                      internet.bandwidth = $('.table-yy tr').eq(j).find('.j-input').eq(8).val();
                      obj.push(internet);
               }
               var jsonstr1 = JSON.stringify(obj);
               var jsonstr2 = JSON.stringify(row);
               var stepno = "<%=request.getParameter("stepno")%>";
			   var flowid = "<%=request.getParameter("transferid")%>";
			   $.post('${pageContext.request.contextPath}/workorder/internetIPOper.do',{jsonstr1:jsonstr1,jsonstr2:jsonstr2,stepno:stepno,flowid:flowid},function(){});
               
               $('#serviceWindow3').dialog('close');
               $('#serviceWindow3').html("");
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#serviceWindow3').dialog('close');
            }
        }]
    });

    $(document).on("click", "#serviceWindow3 .j-toadd", function() {
        var clonestr = '  <div class="j-com"><p class="lcy-com">    <label for="">互联网IP</label>    <input class="lcp-input-ip" style="height: 21px; width: 80px;" /></p><p class="lcy-com">    <label for="">类型</label>    <select name="" id="">        <option value="">请选择</option><option value="">联通</option>  <option value="">移动</option><option value="">电信</option>  </select></p><p class="lcy-com">    <label for="">宽带</label>    <input class="j-numberbox" style="height: 21px; width: 80px;" /></p><p class="lcy-com">    <label for="">绑定内网IP</label>    <input class="lcp-input-ip" style="height: 21px; width: 80px;" /></p>                    <a href="javascript:void(0)" class="tosub j-tosub">-</a>                </div>'
        $('#serviceWindow3  .j-line').append(clonestr);
        $("#serviceWindow3  .j-tosub").css({
            display: 'inline-block'
        });
        $('#serviceWindow3  .j-com:last').find('.j-tosub').hide();
        $('#serviceWindow3   .j-com:last').find('.j-numberbox').numberbox({
            min: 0,
            max: 20,
            precision: 0
        });
        $('#serviceWindow3').css({
            height: 'auto'
        });

    });
    
    $(document).on("click", ".j-tosub", function() {
        $.messager.confirm('提示', '确定要删除吗?', function(r) {
            if (r) {
                $(this).parents('.j-com').remove();
                $(".window-shadow").css({
                    height: 'auto'
                });
            }
        });
        $(this).parents('.j-com').remove();
    })
     
       //datagrid悬浮框处理
	$.extend($.fn.datagrid.methods, {
        /**
         * 开打提示功能
         * @param {} jq
         * @param {} params 提示消息框的样式
         * @return {}
         */
        doCellTip: function(jq, params){
            function showTip(data, td, e){
                if ($(td).text() == "") 
                    return;
                data.tooltip.text($(td).text()).css({
                    top: (e.pageY + 10) + 'px',
                    left: (e.pageX + 20) + 'px',
                    'z-index': $.fn.window.defaults.zIndex,
                    display: 'block'
                });
            };
            return jq.each(function(){
                var grid = $(this);
                var options = $(this).data('datagrid');
                if (!options.tooltip) {
                    var panel = grid.datagrid('getPanel').panel('panel');
                    //var fields=$(this).datagrid('getColumnFields',false);////获取列
                    var defaultCls = {
                        'border': '1px solid #333',
                        'padding': '2px',
                        'color': '#333',
                        'background': '#f7f5d1',
                        'position': 'absolute',
                        'max-width': '200px',
						'border-radius' : '4px',
						'-moz-border-radius' : '4px',
						'-webkit-border-radius' : '4px',
                        'display': 'none'
                    }
                    var tooltip = $("<div id='celltip'></div>").appendTo('body');
                    tooltip.css($.extend({}, defaultCls, params.cls));
                    options.tooltip = tooltip;
                    panel.find('.datagrid-body').each(function(){
                        var delegateEle = $(this).find('> div.datagrid-body-inner').length ? $(this).find('> div.datagrid-body-inner')[0] : this;
                        $(delegateEle).undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove').delegate('td', {
                            'mouseover': function(e){
                                if (params.delay) {
                                    if (options.tipDelayTime) 
                                        clearTimeout(options.tipDelayTime);
                                    var that = this;
                                    options.tipDelayTime = setTimeout(function(){
                                        showTip(options, that, e);
                                    }, params.delay);
                                }
                                else {
                                    showTip(options, this, e);
                                }
                                
                            },
                            'mouseout': function(e){
                                if (options.tipDelayTime) 
                                    clearTimeout(options.tipDelayTime);
                                options.tooltip.css({
                                    'display': 'none'
                                });
                            },
                            'mousemove': function(e){
								var that = this;
                                if (options.tipDelayTime) 
                                    clearTimeout(options.tipDelayTime);
                                //showTip(options, this, e);
								options.tipDelayTime = setTimeout(function(){
                                        showTip(options, that, e);
                                    }, params.delay);
                            }
                        });
                    });
                    
                }
                
            });
        },
        /**
         * 关闭消息提示功能
         *
         * @param {}
         *            jq
         * @return {}
         */
        cancelCellTip: function(jq){
            return jq.each(function(){
                var data = $(this).data('datagrid');
                if (data.tooltip) {
                    data.tooltip.remove();
                    data.tooltip = null;
                    var panel = $(this).datagrid('getPanel').panel('panel');
                    panel.find('.datagrid-body').undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove')
                }
                if (data.tipDelayTime) {
                    clearTimeout(data.tipDelayTime);
                    data.tipDelayTime = null;
                }
            });
        }
    });
 
	$(document).on('click','.j-input',function(){
		$(this).css("border","1px solid #ddd");
	});

	$(document).on('blur','.j-input',function(){
		$(this).css("border","1px solid #fff");
	});


    function productFormatter2(value) {
        for (var i = 0; i < optionType.length; i++) {
            if (optionType[i].productid == value) return optionType[i].name;
        }
        return value;
    }
   
    //选择实施人员弹框
    $('#assignUserWindowRc').dialog({
        title: "选择实施人",
        width: 750,
        height: 350,
        closed: true,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: function() {
            	var rows = $('#dg_assignUserRc').datagrid('getChecked');
            	if(rows.length != 1) {
					$.messager.alert('消息', '请选择一个实施人员！','info');
					return;
				}
            	var userRow = $('#dg_assignUserRc').datagrid('getSelected');
            	var userId = userRow.email;
            	var userName =userRow.uname;
            	
            	//基本信息	 
             	var flowid = "<%=request.getParameter("transferid")%>";
             	var orderid = rowObject.updateorderid;
             	var detailid = rowObject.detailid;
             	
            	$.post('${pageContext.request.contextPath}/workSplit/workAssign.do',{
            		userId:userId,userName:userName,flowid:flowid,orderid:orderid,detailid:detailid,
            		operFlowSign:'<%=operFlowSign%>'
        	 	},function(data){
        	 		if(data == true || data == "true"){
        	 			$.messager.alert('提示', "指派成功！");
        	 		}else{
        	 			$.messager.alert('提示', "指派失败，请重新指派！");
        	 		}
        	 		$('#dg_resourceChange').datagrid('reload');
        	 	});
            	
                $('#assignUserWindowRc').dialog('close');

            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#assignUserWindowRc').dialog('close');
            }
        }]
    });
    
	//工单实施指派
    function assignResourceToDo(index,status){
    	rowObject = $('#dg_resourceChange').datagrid('getData').rows[index];
    	//console.info('%O ',rowObject);
    	loadUserData("");
    	
    	$("#userQueryBtn").linkbutton( {
		   iconCls:'icon-search',
		   plain:true
		});
		$("#userResetBtn").linkbutton({
			iconCls:'icon-redo',
			plain:true
		});
		
    	$("#assignUserWindowRc").dialog({
    		closed:false
    	});
    }
    
    //实施人员列表查询
    function queryUserDg(){
    	var searchName = $("#searchName").val();
    	loadUserData(searchName);
    }
    
    //实施人员列表查询重置按钮
    function queryChongzhi(){
    	$("#searchName").val("");
    	loadUserData("");
    }
    
    //实施人员列表数据
    function loadUserData(searchName){
    	$('#dg_assignUserRc').datagrid({
			rownumbers:false,
			border:true,
			striped:true,
			//sortName:'email',
			//sortOrder:'asc',
			nowarp:false,
			singleSelect:false,
			method:'post',
			loadMsg:'数据装载中......',
			fitColumns:true,
			idField:'email',
			pagination:true,
			pageSize:5,
			pageList:[5,10,20],
	    	singleSelect:true,
	    	url:'${pageContext.request.contextPath}/authMgr/getUsersByRole.do?roleids=1000000075',//工单拆分实施角色(实施人员)
		    queryParams:{uname:searchName},
		    onLoadSuccess:function(data){  
		    	var pageopt = $('#dg_assignUserRc').datagrid('getPager').data("pagination").options;
				var  _pageSize = pageopt.pageSize;//每页分页条数
				var  _rows = $('#dg_assignUserRc').datagrid("getRows").length;//当前页实际条数
				var total = pageopt.total; //显示的查询的总数
				if (_pageSize >= 5) {
					for(i=5;i>_rows;i--){
						//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
						$(this).datagrid('appendRow', {email:''  })
					}
					$('#dg_assignUserRc').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    	total: total,
				     });
				}else{
					//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
					$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				}
				//设置不显示复选框
		        var rows = data.rows;
		        if (rows.length) {
					 $.each(rows, function (idx, val) {
						if(val.email==''){ 
							//dgDivRc为datagrid上一层的div id
							$('#dgDivRc  input:checkbox').eq(idx+1).css("display","none");
							 
						}
					}); 
		        }
				$('.j-variation').linkbutton({
                    iconCls: 'icon-variation',
                    plain: true
                });
                $('.j-cancellation').linkbutton({
                    iconCls: 'icon-cancellation',
                    plain: true
                });
            }
    	});
    }

    //废弃操作
    function feiqi(index,status){
    	rowObject = $('#dg_resourceChange').datagrid('getData').rows[index];
    	//基本信息	 
     	var flowid = "<%=request.getParameter("transferid")%>";
     	var stepno = "<%=request.getParameter("stepno")%>";
     	var orderid = rowObject.updateorderid;
     	var detailid = rowObject.detailid;
        $.messager.confirm('提示','确定要废弃吗？',function(r){
			if(r){
				$.post('${pageContext.request.contextPath}/workSplit/workFeiqi.do',{
            		flowid:flowid,stepno:stepno,orderid:orderid,detailid:detailid,operFlowSign:'<%=operFlowSign%>'
        	 	},function(data){
        	 		if(data == true || data == "true"){
        	 			$.messager.alert('提示', "操作成功！");
        	 		}else{
        	 			$.messager.alert('提示', "操作失败，请重新操作！");
        	 		}
        	 		  $('#dg_resourceChange').datagrid('reload');
        	 	});
			}        	 
        });
    }
  </script>
</body>
</html>
