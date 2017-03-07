<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<%@ page language="java" import="com.inspur.icpmg.util.WebLevelUtil"%>
<%@ page language="java" import="com.inspur.icpmg.systemMg.vo.UserEntity"%>
<%
	boolean hasRight = false;
	UserEntity ue = WebLevelUtil.getUser(request);
	String roleid = ue.getRoleid();
	System.out.println(roleid);
	if(roleid.contains("1000000050")||roleid.contains("1000000075")){
		hasRight = true;
	}
%>	
<body>
	<script type="text/javascript">
	  var ws = null;
	  var url = null;
	  var transports = [];
	  updateUrl('/icpmg/sockjs/echo');
	  connect();
	  
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
			
	        $.messager.alert('提示',info,"info");
	   	    $('#grid').datagrid('reload',addPageParams(icp.serializeObject($('#conditionForm'))));
		};
		ws.onclose = function(event) {
 
		};
	}
	</script>
	<script type="text/javascript">
	var flagck = 0;
	var indiskToolbar = [
		{
			text:'详情',
			iconCls:'icon-preview',
			handler:function() { 
				var rows = $('#grid').datagrid('getChecked');
				if(rows.length != 1) {
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				if(rows[0].diskid){				
					$('#previewDiskWindow').show();
					$('#previewDiskWindow').dialog('open');
					$('#previewDiskform').form('clear');
					
					$("#previewDiskid").text(getPlainText(rows[0].diskid));
					$("#previewDisplayname").text(getPlainText(rows[0].displayname));
					$("#previewServerid").text(getPlainText(rows[0].serverid));
					$("#previewIpaddr").text(getPlainText(rows[0].ipaddr));
					$("#previewAppname").text(getPlainText(rows[0].appname));
					$("#previewProjectname").text(getPlainText(rows[0].projectname));
					$("#previewUnitname").text(getPlainText(rows[0].unitname));
					$("#previewNetworktypename").text(getPlainText(rows[0].networktypename));
					$("#previewPlatformname").text(getPlainText(rows[0].platformname));
					$("#previewDescription").val(getPlainText(rows[0].description));
					$("#previewDisknum").text(getPlainText(rows[0].disknum));
					$("#previewCurstat").text(statusformater(getPlainText(rows[0].curstat)));
				}
			}
		},
		{
			id: 'modifyBtn',
			text:'修改名称',
			iconCls:'icon-modify',
			handler:function() { 
				var rows = $('#grid').datagrid('getChecked');
				if(rows.length != 1) {
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				if(rows[0].diskid){				
					$('#updateDiskWindow').show();
					$('#updateDiskWindow').dialog('open');
					$('#updateDiskform').form('clear');
					
 					$("#updateId").val(getPlainText(rows[0].diskid));
 					$("#updateDiskname").val(getPlainText(rows[0].diskname));
 					$("#updatePlatformid").val(getPlainText(rows[0].platformid));
					$("#updateDisplayname").val(getPlainText(rows[0].displayname));
					$("#updateDescription").val(getPlainText(rows[0].description));
					$("#updateDisknum").text(getPlainText(rows[0].disknum));
				}
			}
		 },
		{
			id: 'attachBtn',
			text:'挂载',
			iconCls:'icon-attach',
			handler:function(){ 
				var rows = $('#grid').datagrid('getChecked');
				if(rows.length<1 || rows.length>1){
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				
				if(rows[0].diskid){
					$('#attachDiskform').form('clear');
					$('#attachServer').combobox({
						url: '${pageContext.request.contextPath}/vm/queryVmsByUnitid.do?unitid=' 
								+ rows[0].unitid + '&platformid=' + rows[0].platformid 
								+ '&networktypeid=' + rows[0].networktypeid,
						valueField:'serverid',
					    textField:'displayname',
						panelWidth: 200, 
						formatter: function(row){
							var s = '<span>' + row.displayname + '</span><br/>' +
							'<span style="color:#888">' + row.ipaddr + '</span>';
							return s;
						},
					    onSelect: function(rec){ 
					    	if(rec.serverid != rows[0].serverid){
			   				  	$.ajax({
			   				  		type: 'post',
			   				  		url: '${pageContext.request.contextPath}/indisk/getCount.do',
			   				  		data: {serverid: rec.serverid},
			   				  		success: function(data){
			   				  			var _data = JSON.parse(data);
			   				  			if(_data.total > 1){
			   				  				$.messager.alert('消息','该服务器已挂载两个，请选择其他服务器');
			   				  				$('#attachServer').combobox('setValue', rows[0].serverid);
			   				  			} else {
											$('#attachServerid').val(rec.serverid);
											$('#attachServername').val(rec.servername);
			   				  			}
			   				  		}
			   				  	});
					    	}
						}
					});
					$("#attachDiskid").val(rows[0].diskid);
					$("#attachPlatformid").val(rows[0].platformid);
					$("#attachDiskname").val(rows[0].diskname);
					$("#attachDisplayname").text(rows[0].displayname);
					
					$('#attachDiskWindow').show();
					$('#attachDiskWindow').dialog('open');
				}
			}
		},
		{
			id: 'detachBtn',
			text:'卸载',
			iconCls:'icon-detach',
			handler:function(){ 
				var rows = $('#grid').datagrid('getChecked');
				if(rows.length<1 || rows.length>1){
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				
				if(rows[0].diskid){				
	   				$.messager.confirm('确认','您确认想要卸载该云硬盘吗？',function(r){   
	   				    if (r){ 
		   				  	$.ajax({
		   				  		type: 'post',
		   				  		url: '${pageContext.request.contextPath}/indisk/detachIndisk.do',
		   				  		data: {diskid: rows[0].diskid},
		   				  		success: function(data){
		   				  			var _data = JSON.parse(data); 
		   				  			$.messager.alert('消息',_data.msg);  
		   				  			$('#grid').datagrid({queryParams: addPageParams(icp.serializeObject($('#conditionForm')))});
		   				  		}
		   				  	});
	   				    }
	   			    });
				}
			}
		/*}, 
  		{
			text:'快照',
			id: 'snapshotBtn',
			iconCls:'icon-snapshot',
			handler:function(){ 
				var rows = $('#grid').datagrid('getChecked');
				if(rows.length<1 || rows.length>1){
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				if(rows[0].diskid){				
					$('#diskSnapshotWindow').show();
					$('#diskSnapshotWindow').dialog('open');
					$('#diskSnapshotForm').form('clear');
					
 					$("#snapshotDiskId").val(rows[0].diskid);
 					$("#snapshotDiskName").val(rows[0].diskname);
 					$("#snapshotPlatformid").val(rows[0].platformid);
 					$("#snapshotVolumetypeid").val(rows[0].volumetypeid);
 					$("#snapshotDiskNum").val(rows[0].disknum);
					$("#snapshotDisplayname").text(rows[0].displayname);
					$("#snapshotDiskNumLabel").text(rows[0].disknum);
				}
			}
		}, */
/* 		{
			id: 'deleteBtn',
			text:'删除',
			iconCls:'icon-delete',
			handler:function(){ 
				var rows = $('#grid').datagrid('getChecked');
				if(rows.length != 1){
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				
				if(rows[0].diskid){				
	   				$.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
	   				    if (r){ 
		   				  	$.ajax({
		   				  		type: 'post',
		   				  		url: '${pageContext.request.contextPath}/indisk/deleteIndisk.do',
		   				  		data: {
		   				  			diskid: rows[0].diskid,
		   				  			diskname: rows[0].diskname,
		   				  			platformid: rows[0].platformid
		   				  		},
		   				  		success: function(data){
		   				  			var _data = JSON.parse(data); 
		   				  			$.messager.alert('消息',_data.msg);  
		   				  			$('#grid').datagrid({queryParams: addPageParams(icp.serializeObject($('#conditionForm')))});
		   				  		}
		   				  	});
	   				    }
	   			    });
				}
			} */
		}];
	               
	$(document).ready(function() {
		var hasRight = '<%=hasRight%>';
		if(hasRight == true || hasRight == 'true' ){
			loadDataGrid();
		} else {
			indiskToolbar.splice(2,2);
			loadDataGrid();
		}
	});
	
	//查询结果
	function loadDataGrid(){
		$('#grid').datagrid({
			rownumbers : false,
			border : false,
			striped : true,
			singleSelect: true,
			scrollbarSize : 0,
			method : 'post',
			loadMsg : '数据装载中......',
			fitColumns : true,
			pagination : true,
			pageSize:10,
			pageList:[10, 20, 30, 40, 50],
			toolbar : indiskToolbar,
		    url:'${pageContext.request.contextPath}/indisk/queryDiskList.do',
		    onLoadSuccess: function (data) {
		    	var pageopt = $('#grid').datagrid('getPager').pagination("options");
			      var  _pageSize = pageopt.pageSize;
			      var  _rows = $('#grid').datagrid("getRows").length;
			      var total = pageopt.total;
			      if (_pageSize >= 10) {
			         for(var i=10;i>_rows;i--){
			            $(this).datagrid('appendRow', {status :''  });
			         }
			         $('#grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    		total: total,
				     });
			       
			      }else{
			         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			      }
			      var rows = data.rows;
			      if (rows.length) {
						 $.each(rows, function (idx, val) {
							if   (val.status ==''){ 
								$('#grid_div  input:checkbox').eq(idx+1).css("display","none");
							}
						}); 
			      }
			 },
			 onClickRow: function (rowIndex, rowData) {
				if   (rowData.status ==''){
					 $(this).datagrid('unselectRow', rowIndex);
				}else{
					flagck=0;
				}
				if(flagck ==1){
					$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
				}
				setBtnStat(rowData);
			}, 
			onCheck: function(rowIndex, rowData){
				setBtnStat(rowData);
			},
			onCheckAll: function(rows) {
				flagck = 1;
				$.each(rows, function (idx, val) {
					if (val.status == ''){
						$("#grid").datagrid('uncheckRow', idx);
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
				});
			}, 
			onUncheckAll: function(rows) {
				flagck = 0;
			}
		}); 
	}
	
	// 设置导航菜单状态
	function setBtnStat(rowData){
		if(rowData.plattype == 'openstack' && rowData.curstat == 'Ready'){
			$("#deleteBtn").linkbutton("enable");
			$("#attachBtn").linkbutton("enable");
			$("#attachBtn").linkbutton("enable");
			$("#detachBtn").linkbutton("disable"); 
		} else if(rowData.curstat == 'Allocated'){
			$("#deleteBtn").linkbutton("disable"); 
			$("#attachBtn").linkbutton("disable"); 
			$("#snapshotBtn").linkbutton("disable");
			$("#detachBtn").linkbutton("enable"); 
		} else if(rowData.curstat == 'Ready') {
			$("#detachBtn").linkbutton("disable"); 
			$("#deleteBtn").linkbutton("enable"); 
			$("#attachBtn").linkbutton("enable"); 
			$("#snapshotBtn").linkbutton("disable");
		} else {
			$("#detachBtn").linkbutton("enable"); 
			$("#deleteBtn").linkbutton("enable"); 
			$("#attachBtn").linkbutton("enable"); 
			$("#snapshotBtn").linkbutton("disable");
		}
	}
	
	function getPlainText(value){
		return (value == null || value == 'null') ? '' : value;
	}
	function searchDataGrid(){
		$('#grid').datagrid({queryParams: addPageParams(icp.serializeObject($('#conditionForm')))});
	}
	
	function addPageParams(params, options){
		var options = $('#grid').datagrid('getPager').pagination("options");
		params.pageNumber = options.pageNumber;
		params.pageSize = options.pageSize;
		
		return params;
	}
	
	function reset(){
		$('#conditionForm input').val('');
		$('#grid').datagrid('load',{});
	}
	
	// 获取服务器显示名称
	function serverformater(value, row, index) {
		var serverdisplayname = '';
		if(row.serverid){
		  	$.ajax({
		  		type: 'post',
		  		url: '${pageContext.request.contextPath}/vm/queryVmById.do',
		  		async: false,
		  		data: {serverid: row.serverid},
		  		success: function(data){
		  			var _data = JSON.parse(data); 
		  			if(_data.displayname){
		  				if(_data.ipaddr){
				  			serverdisplayname = _data.displayname 
				  				+ '/' + _data.ipaddr;
		  				} else {
		  					serverdisplayname = _data.displayname;
		  				}
		  			}
		  		}
		  	});
		}
	  	
	  	return serverdisplayname;
	}
	
	//状态格式
	function statusformater(value, row, index) {
		switch (value) {
			case "Ready":
				return "可使用";
			case "Allocated":
				return "已挂载";
	        case "close":
				return "已删除";
		}
	}
	
	//磁盘类型格式
	function disktypeformater(value, row, index) {
		switch (value) {
			case "ROOT":
				return "系统盘";
			case "DATADISK":
				return "数据盘";
		}
	}
	
	function closeUpdateDiskDialog(){
		$('#updateDiskWindow').dialog('close');
	}
	
	function closeAttachDiskDialog(){
		$('#attachDiskWindow').dialog('close');
	}
	
	function closeDiskSnapshotDialog(){
		$('#diskSnapshotWindow').dialog('close');
	}
	
	/* 
	*  云硬盘更新
	*/
	function updateDisk(){
		$("#updateDiskform").form('submit',{
		    url: '${pageContext.request.contextPath}/indisk/editIndisk.do',
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
	            if(!flag){
	                return flag; 
	            }
		    },
		    success: function(data){
		    	var _data =  JSON.parse(data); 
		    	$.messager.alert('消息',_data.msg);
		    	closeUpdateDiskDialog();
		    	$('#grid').datagrid({queryParams: addPageParams(icp.serializeObject($('#conditionForm')))});
		    }
	    });
	}
	
	/* 
	*  云硬盘挂载
	*/
	function attachDisk(){
		$("#attachDiskform").form('submit',{
		    url: '${pageContext.request.contextPath}/indisk/attachIndisk.do',
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
	            if(!flag){
	                return flag; 
	            }
		    },
		    success: function(data){
		    	var _data =  JSON.parse(data); 
		    	$.messager.alert('消息',_data.msg);
		    	closeAttachDiskDialog();
		    	$('#grid').datagrid({queryParams: addPageParams(icp.serializeObject($('#conditionForm')))});
		    }
	    });
	}
	
	/* 
	*  创建云硬盘快照 
	*/
	function createDiskSnapshot(){
		$("#diskSnapshotForm").form('submit',{
		    url: '${pageContext.request.contextPath}/indisk/createIndiskSnapshot.do',
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
	            if(!flag){
	                return flag; 
	            }
		    },
		    success: function(data){
		    	var _data =  JSON.parse(data); 
		    	$.messager.alert('消息',_data.msg);
		    	closeDiskSnapshotDialog();
		    }
	    });
	}
	
	$(function(){
	    
	    // 修改云硬盘
	    $('#updateDiskWindow').dialog({
	 	    width: 600,
	        height: 260,
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
	            	updateDisk();
	            }
	        }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function() {
	                $('#updateDiskWindow').dialog('close');
	            }
	        }]
	    });
	    $.parser.parse('#updateDiskWindow'); 
	    
	    
	    // 云硬盘挂载
	    $('#attachDiskWindow').dialog({
	 	    width: 520,
	        height: 160,
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
	            	if(!$("#attachServer").combobox('getValue')){
	            		$.messager.alert('警告','请选择要挂载的服务器');
	            	} else {
	            		attachDisk();
	            	}
	            }
	        }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function() {
	            	closeAttachDiskDialog();
	            }
	        }]
	    });
	    $.parser.parse('#attachDiskWindow'); 
	    
	    // 云硬盘快照
	    $('#diskSnapshotWindow').dialog({
	 	    width: 600,
	        height: 300,
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
	            	createDiskSnapshot();
	            }
	        }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function() {
	                $('#diskSnapshotWindow').dialog('close');
	            }
	        }]
	    });
	    $.parser.parse('#diskSnapshotWindow'); 
	    
	    // 云硬盘详情
	    $('#previewDiskWindow').dialog({
	 	    width: 700,
	        height: 380,
	        closed: true,
	        modal: true,
	        collapsible: false,
	        minimizable: false,
	        maximizable: false,
	        resizable: false,
	        buttons: [{
	            text: '关闭',
	            iconCls: 'icon-cancel',
	            handler: function() {
	                $('#previewDiskWindow').dialog('close');
	            }
	        }]
	    });
	    $.parser.parse('#previewDiskWindow'); 
	    
	});
	
	/**
	*  判断是否是Openstack平台
	**/
	function isOpenStackPlatform(platformid){
		var flag=false;
 	  	$.ajax({
	  		type: 'post',
	  		url: '${pageContext.request.contextPath}/indisk/queryPlatformById.do',
	  		data: {platformid: platformid},
	  		async: false,
	  		success: function(data){
	  			var _data = JSON.parse(data);
	  			if(_data.obj.plattype == "openstack"){
	  				flag = true;
	  			}
	  		}
	  	});
	  	return flag;
	}
	</script>
	
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;background-color: #eee;margin-bottom:10px">
			<form id="conditionForm">
				<table >
					<tr>
						<td>磁盘名称：<input class="easyui-textbox" name="displayname"
								style="width:120px;height:30px;border:false">
						
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset();">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="grid_div">
			<table title="" style="width:100%;"  id="grid">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'diskid',width:30,align:'center',hidden:true">实例名称</th>
						<th data-options="field:'displayname',width:20,align:'center'">硬盘名称</th>
						<th data-options="field:'serverid',width:30,align:'center'">所挂载云服务器</th>
						<th data-options="field:'servername',width:30,align:'center',hidden:true">所挂载云服务器</th>
						<th data-options="field:'ipaddr',width:30,align:'center'">所挂载云服务器IP</th>
						<th data-options="field:'disknum',width:20,align:'center'">硬盘容量(G)</th>
						<!-- <th data-options="field:'appname',width:20,align:'center'">应用</th> -->
						<th data-options="field:'networktypeid',width:30,align:'center',hidden:true">区域编号</th>
						<th data-options="field:'networktypename',width:15,align:'center'">区域</th>
						<th data-options="field:'projectid',width:20,align:'center',hidden:true">项目编号</th>
						<th data-options="field:'projectname',width:20,align:'center'">项目</th>
						<th data-options="field:'unitid',width:20,align:'center',hidden:true">使用单位编号</th>
						<th data-options="field:'unitname',width:25,align:'center'">使用单位</th>
						<th data-options="field:'platformname',width:20,align:'center',hidden:true">平台名称</th>
						<th data-options="field:'plattype',width:20,align:'center',hidden:true">平台类型</th>
						<th data-options="field:'platformid',width:20,align:'center',hidden:true">平台编号</th>
						<th data-options="field:'description',width:40,align:'center',hidden:true">硬盘描述</th>
						<th data-options="field:'volumetypeid',width:20,align:'center',hidden:true">硬盘类型编号</th>
						<th data-options="field:'disktype',width:20,align:'center',hidden:true">硬盘类型</th>
						<th data-options="field:'curstat',width:20,align:'center',formatter:statusformater">状态</th>
					</tr>
				</thead>
			</table>
		</div>  
	</div>
	
	<!-- 云硬盘详情   start -->
	<div id="previewDiskWindow" class="easyui-window" title="查看云硬盘详情" data-options="closed:true,cache : false,modal: true" style="width:600px;height:380px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="previewDiskform" method="post" enctype="multipart/form-data" >
				    <div class="pop">
				        <div class="item-wrap">
				            <div class="item2">
				                <div class="item-title">基本信息</div>
				                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout" style="table-layout: fixed;">
				                    <tbody>
				                        <tr>
				                            <td align="right" width="18%">实例名称：</td>
				                            <td align="left" width="32%" class="c999" style="overflow: hidden;word-wrap: break-word;">
				                              <span id ="previewDiskid" class="h19"></span>
				                            </td>
				                            <td align="right" width="19%">硬盘名称：</td>
				                            <td align="left" width="31%" class="c999" style="overflow: hidden;word-wrap: break-word;">
				                               <span id="previewDisplayname" class="h19"></span>
				                            </td>
				                        </tr>
				                        <tr>
				                        	<td align="right">所挂载云服务器：</td>
				                            <td align="left" class="c999" style="overflow: hidden;word-wrap: break-word;">
				                                <span id="previewServerid"></span>
				                            </td>
				                            <td align="right">所挂载云服务器IP：</td>
				                            <td align="left" class="c999">
				                                <span id="previewIpaddr" class="h19"></span>
				                            </td>
				                        </tr>
				                        <tr>
				                            <td align="right">项目：</td>
				                            <td align="left" class="c999" style="overflow: hidden;word-wrap: break-word;">
				                                <span id="previewProjectname"></span>
				                            </td>
				                            <td align="right">区域：</td>
				                            <td align="left" class="c999" style="overflow: hidden;word-wrap: break-word;">
				                                <span id="previewNetworktypename"></span>
				                            </td>
				                        </tr>
				                        <tr>
				                            <td align="right">使用单位：</td>
				                            <td align="left" class="c999">
				                                <span id="previewUnitname" class="h19"></span>
				                            </td>
				                        </tr>
				                        <tr>
				                            <td align="right">硬盘容量：</td>
				                            <td align="left" class="c999">
				                                <span id="previewDisknum"></span> <span>G</span>
				                            </td>
				                            <td align="right">硬盘状态：</td>
				                            <td align="left" class="c999">
				                                <span id="previewCurstat" class="h19"></span>
				                            </td>
				                        </tr>
				                        <tr>
				                            <td align="right">硬盘描述：</td>
				                            <td align="left" colspan="5" class="c999">
				                            	 <textarea id="previewDescription" style="height: 90px;color:#999;" class="shadow-input textarea" readonly></textarea>
				                            </td>
				                        </tr>
				                    </tbody>
				                </table>
				            </div>
				        </div>
				    </div>
				</form>
			</div>
		</div>
	</div>
	<!-- 云硬盘详情   end -->
	
	<!-- 云硬盘修改   start -->
	<div id="updateDiskWindow" class="easyui-window" title="修改云硬盘名称" data-options="closed:true,cache : false,modal: true" style="width:600px;height:260px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="updateDiskform" method="post" enctype="multipart/form-data" >
					<input id="updateId" type="hidden" name="diskid" />
					<input id="updateDiskname" type="hidden" name="diskname" />
					<input id="updatePlatformid" type="hidden" name="platformid" />
				    <div class="pop" >
				        <div class="item3" style="padding:0">
				            <div class="tc-table">
				                <table width="480" border="0" cellpadding="0" cellspacing="0" class="table-layout" style="table-layout: fixed;">
				                    <tbody>
				                        <tr>
				                            <td align="right" width="20%"><span class="must-star">*</span> 硬盘名称：</td>
				                            <td align="left" style="word-break: break-all; word-wrap: break-word;">
				                                <input id="updateDisplayname" name="displayname" class="shadow-input easyui-validatebox" style="width: 170px;" data-options="required:true,missingMessage:'请输入硬盘名称',validType:['nameInput','maxLength[20]'],prompt:'不得超过20字'" />
				                            </td>
				                        </tr>
				                        <tr>
				                            <td align="right" width="15%">硬盘容量：</td>
				                            <td align="left" class="c999">
				                               <span id="updateDisknum" class="text-lh"></span><span class="text-lh">GB</span>
				                            </td>
				                        </tr>
				                        <tr>
				                            <td align="right" width="15%">硬盘描述：</td>
				                            <td align="left" colspan="5" class="c999">
				                            	 <textarea id="updateDescription" style="height: 90px;color:#999;" class="shadow-input textarea" readonly></textarea>
				                            </td>
				                        </tr>
				                    </tbody>
				                </table>
				            </div>
				        </div>
				    </div>
				</form>
			</div>
		</div>
	</div>
	<!-- 云硬盘修改   end -->

	<!-- 云硬盘挂载   start -->
	<div id="attachDiskWindow" class="easyui-window" title="云硬盘挂载" data-options="closed:true,cache : false,modal: true" style="width:520px;height:160px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="attachDiskform" method="post" enctype="multipart/form-data" >
					<input type="hidden" name="diskid" id="attachDiskid" />
					<input type="hidden" name="platformid" id="attachPlatformid" />
					<input type="hidden" name="diskname" id="attachDiskname" />
					<input type="hidden" name="servername" id="attachServername" />
					<input type="hidden" name="serverid" id="attachServerid" />
					<div class="pop" >
				        <div class="item3" style="padding:0">
				            <div class="tc-table">
				                <table width="500" border="0" cellpadding="0" cellspacing="0" class="table-layout" style="table-layout: fixed;">
				                    <tbody>
				                        <tr>
				                            <td align="right" width="25%">硬盘名称：</td>
				                            <td align="left" width="75%" style="word-break: break-all; word-wrap: break-word;">
				                               <span id="attachDisplayname" class="text-lh"></span>
				                            </td>
				                        </tr>
				                        <tr>
				                            <td align="right"><span class="must-star">*</span>所挂载云服务器：</td>
				                            <td align="left" colspan="3">
				                                <input id="attachServer" name="serverdisplayname" class="easyui-textbox"  data-options="required:true,missingMessage:'请选择服务器'"  type="text" class="shadow-input" style="width: 170px; "/>
				                            </td>
				                        </tr>
				                    </tbody>
				                </table>
				            </div>
				        </div>
				    </div>
				</form>
			</div>
		</div>
	</div>
	<!-- 云硬盘挂载   end -->
	
	<!-- 云硬盘快照   start -->
	<div id="diskSnapshotWindow" class="easyui-window" title="创建云硬盘快照" data-options="closed:true,cache : false,modal: true" style="width:600px;height:300px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="diskSnapshotForm" method="post" enctype="multipart/form-data" >
					<input id="snapshotDiskId" type="hidden" name="diskId" />
					<input id="snapshotVolumetypeid" type="hidden" name="diskTypeId" />
					<input id="snapshotPlatformid" type="hidden" name="platformid" />
					<input id="snapshotDiskName" type="hidden" name="diskname" />
					<input id="snapshotDiskNum" type="hidden" name="snapshotNum" />
					<div class="pop" >
				        <div class="item3" style="padding:0">
				            <div class="tc-table">
				                <table width="480" border="0" cellpadding="0" cellspacing="0" class="table-layout" style="table-layout: fixed;">
				                    <tbody>
				                        <tr>
				                            <td align="right" width="20%">硬盘名称：</td>
				                            <td align="left">
				                               <span id="snapshotDisplayname" class="text-lh"></span>
				                            </td>
				                        </tr>
				                        <tr>
				                            <td align="right">硬盘容量：</td>
				                            <td align="left">
				                               <span id="snapshotDiskNumLabel" class="text-lh"></span><span class="text-lh">GB</span>
				                            </td>
				                        </tr>
				                        <tr>
				                            <td align="right"><span class="must-star">*</span>快照名称：</td>
				                            <td align="left">
				                               <input name="displayname" class="easyui-textbox" data-options="required:true,missingMessage:'请输入快照名称',validType:['nameInput','maxLength[20]'],prompt:'不得超过20字'" style="width:170px;"/>
				                            </td>
				                        </tr>
				                        <tr>
				                           	<td align="right">快照描述：<br><span style='color:#f00'>(少于100字)</span></td>
				                            <td align="left" colspan="3">
				                                <textarea name="description" style="width: 95%; height: 90px" class="shadow-input textarea"></textarea>
				                            </td>
				                        </tr>
				                    </tbody>
				                </table>
				            </div>
				        </div>
				    </div>
				</form>
			</div>
		</div>
	</div>
	<!-- 云硬盘快照   end -->
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/web/indisk/js/sliderbar.js"></script>
</body>