<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<head>
<body>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/web/indisk/css/indisk.css" />
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
	   	    $('#snapshotGrid').datagrid('reload',icp.serializeObject($('#conditionForm')));
		};
		ws.onclose = function(event) {
 
		};
	}
	</script>
	<script type="text/javascript">
	var flagck = 0;
	var indiskSnapshotToolbar = [
 		{
			text:'从快照创建硬盘',
			iconCls:'icon-add',
			handler:function() { 
				var rows = $('#snapshotGrid').datagrid('getChecked');
				if(rows.length != 1) {
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				if(rows[0].id){				
					$('#createDiskFromSnapshotWindow').show();
					$('#createDiskFromSnapshotWindow').dialog('open');
					$('#createDiskFromSnapshotForm').form('clear');
					
 					$("#snapshotCreateDiskId").val(rows[0].diskId);
 					$("#snapshotCreateDiskTypeId").val(rows[0].diskTypeId);
 					$("#snapshotCreateDiskSnapshotId").val(rows[0].id);
 					$("#snapshotCreateDiskSnapshotName").val(rows[0].name);
 					$("#snapshotCreateDiskPlatformid").val(rows[0].platformid);
 					
					$("#snapshotCreateDiskSnapshotDisplayname").text(rows[0].displayname);
					$("#snapshotCreateDiskNum").text(rows[0].snapshotNum);
					
					$("#disDiskNum").val(rows[0].snapshotNum);
					$("#disDiskNum").parents(".j-xtp-item").find('.j-silde').slider(
				        'setValue', rows[0].snapshotNum
				    );
					$("#disDiskNum").parents(".j-xtp-item").find('.j-silde').slider({
						min: rows[0].snapshotNum,
						rule: [rows[0].snapshotNum, 2000]
					});
					
					$('#attachServer').combogrid({
						panelWidth: 550, 
						url: '${pageContext.request.contextPath}/indisk/queryVms.do',
						idField:'serverid',
					    textField:'displayname',
					    queryParams:{
					    	diskId: rows[0].diskId
					    },
					    columns:[[    
					              {field:'serverid',title:'编号',width:150,hidden:true},    
					              {field:'displayname',title:'服务器名称',width:150},    
					              {field:'servername',title:'服务器编码',width:250},    
					              {field:'ipaddr',title:'IP地址',width:120}    
					          ]],
					    onSelect: function(){ 
					    	var _selected = $('#attachServer').combogrid('grid').datagrid('getSelected'); 
		   				  	$.ajax({
		   				  		type: 'post',
		   				  		url: '${pageContext.request.contextPath}/indisk/getCount.do',
		   				  		data: {serverid: _selected.serverid},
		   				  		success: function(data){
		   				  			var _data = JSON.parse(data);
		   				  			if(_data.total > 1){
		   				  				$.messager.alert('消息','该服务器已挂载两个，请选择其他服务器'); 
		   				  			} else {
										$('#attachServerid').val(_selected.serverid);
										$('#attachServername').val(_selected.servername);
		   				  			}
		   				  		}
		   				  	});
						}
					});
				}
			}
		},
		{
			text:'删除',
			iconCls:'icon-delete',
			handler:function(){ 
				var rows = $('#snapshotGrid').datagrid('getChecked');
				if(rows.length != 1){
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				
				if(rows[0].id){				
	   				$.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
	   				    if (r){ 
		   				  	$.ajax({
		   				  		type: 'post',
		   				  		url: '${pageContext.request.contextPath}/indisk/deleteIndiskSnapshot.do',
		   				  		data: {
		   				  			id: rows[0].id,
		   				  			platformid: rows[0].platformid,
		   				  			name: rows[0].name
		   				  		},
		   				  		success: function(data){
		   				  			var _data = JSON.parse(data); 
		   				  			$.messager.alert('消息',_data.msg);  
		   				  		$('#snapshotGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		   				  		}
		   				  	});
	   				    }
	   			    });
				}
			}
		}];
	               
	$(document).ready(function() {
		loadDataGrid();
	});
	
	//查询结果
	function loadDataGrid(){
		$('#snapshotGrid').datagrid({
			rownumbers : false,
			border : false,
			striped : true,
			scrollbarSize : 0,
			method : 'post',
			loadMsg : '数据装载中......',
			fitColumns : true,
			pagination : true,
			pageSize:10,
			pageList:[10, 20, 30, 40, 50],
			toolbar : indiskSnapshotToolbar,
		    url:'${pageContext.request.contextPath}/indisk/queryDiskSnapshotsList.do',
		    onLoadSuccess: function (data) {
		    	var pageopt = $('#snapshotGrid').datagrid('getPager').data("pagination").options;
			      var  _pageSize = pageopt.pageSize;
			      var  _rows = $('#snapshotGrid').datagrid("getRows").length;
			      var total = pageopt.total;
			      if (_pageSize >= 10) {
			         for(var i=10;i>_rows;i--){
			            $(this).datagrid('appendRow', {status :''  });
			         }
			         $('#snapshotGrid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    		total: total,
				     });
			       
			      }else{
			         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			      }
			      var rows = data.rows;
			      if (rows.length) {
						 $.each(rows, function (idx, val) {
							if   (val.status ==''){ 
								$('#snapshotGrid_div  input:checkbox').eq(idx+1).css("display","none");
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
			}, 
			onCheckAll: function(rows) {
				flagck = 1;
				$.each(rows, function (idx, val) {
					if   (val.status ==''){
						$("#snapshotGrid").datagrid('uncheckRow', idx);
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
				});
			}, 
			onUncheckAll: function(rows) {
				flagck = 0;
			}
		}); 
	}
	
	function searchDataGrid(){
		$('#snapshotGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
	}
	
	function reset(){
		$('#conditionForm input').val('');
		$('#snapshotGrid').datagrid('load',{});
	}
	
	function closeCreateDiskSnapshotDialog(){
		$('#createDiskSnapshotWindow').dialog('close');
	}
	
	function closeCreateDiskFromSnapshotDialog(){
		$('#createDiskFromSnapshotWindow').dialog('close');
	}
	
	/* 
	*  云硬盘快照创建 
	*/
	function createDiskFromSnapshot(){
		$("#createDiskFromSnapshotForm").form('submit',{
		    url: '${pageContext.request.contextPath}/indisk/createIndiskFromSnapshot.do',
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
	            if(!flag){
	                return flag; 
	            }
		    },
		    success: function(data){
		    	var _data =  JSON.parse(data); 
		    	$.messager.alert('消息',_data.msg);
		    	closeCreateDiskFromSnapshotDialog();
		    }
	    });
	}
	
	/* 
	*  根据云硬盘ID获取名称
	*/
	function diskformater(value, row, index){
		var displayname;
		if(row.diskId){
		  	$.ajax({
		  		type: 'post',
		  		async: false,
		  		url: '${pageContext.request.contextPath}/indisk/queryDiskById.do',
		  		data: {diskid: row.diskId},
		  		success: function(data){
		  			var _data = JSON.parse(data); 
		  			if(_data.obj){
			  			displayname = _data.obj.displayname;
		  			}
		  		}
			});
		}
		
		return displayname;
	}
	
	$(function(){
		// 云硬盘类型创建
	    $('#createDiskFromSnapshotWindow').dialog({
	 	    width: 700,
	        height: 400,
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
	            	createDiskFromSnapshot();
	            }
	        }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function() {
	                $('#createDiskFromSnapshotWindow').dialog('close');
	            }
	        }]
	    });
	    $.parser.parse('#createDiskFromSnapshotWindow'); 
	});
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;background-color: #eee;margin-bottom:10px">
			<form id="conditionForm">
				<table >
					<tr>
						<td>硬盘快照名称：<input class="easyui-textbox" name="name"
								style="width:120px;height:30px;border:false">
						
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset();">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="snapshotGrid_div">
			<table title="" style="width:100%;"  id="snapshotGrid">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',width:50,align:'center',hidden:true">编号</th>
						<th data-options="field:'name',width:50,align:'center',hidden:true">快照neid</th>
						<th data-options="field:'diskTypeId',width:50,align:'center',hidden:true">类型编号</th>
						<th data-options="field:'displayname',width:50,align:'center'">快照名称</th>
						<th data-options="field:'diskId',width:50,align:'center',hidden:true">硬盘编码</th>
						<th data-options="field:'diskDisplayname',width:50,align:'center',formatter:diskformater">硬盘名称</th>
						<th data-options="field:'snapshotNum',width:50,align:'center',hidden:true">快照容量(G)</th>
						<th data-options="field:'description',width:60,align:'center'">快照描述</th>
						<th data-options="field:'ctime',width:50,align:'center'">创建时间</th>
					</tr>
				</thead>
			</table>
		</div>  
	</div>
	
	<!-- 从快照创建硬盘   start -->
	<div id="createDiskFromSnapshotWindow" class="easyui-window" title="从快照创建硬盘" data-options="closed:true,cache : false,modal: true" style="width:600px;height:350px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="createDiskFromSnapshotForm" method="post" enctype="multipart/form-data" >
					<input id="snapshotCreateDiskId" type="hidden" name="diskId" />
					<input id="snapshotCreateDiskTypeId" type="hidden" name="diskTypeId" />
					<input id="snapshotCreateDiskSnapshotId" type="hidden" name="id" />
					<input id="snapshotCreateDiskSnapshotName" type="hidden" name="name" />
					<input id="attachServername" type="hidden" name="servername" />
					<input id="attachServerid" type="hidden" name="serverid" />
					<input id="snapshotCreateDiskPlatformid" type="hidden" name="platformid" />
					
					<div class="pop" >
				        <div class="item3" style="padding:0">
				            <div class="tc-table">
				                <table width="480" border="0" cellpadding="0" cellspacing="0" class="table-layout" style="table-layout: fixed;">
				                    <tbody>
				                        <tr>
				                            <td align="right">已选择快照：</td>
				                            <td align="left" colspan="3">
				                               <span id="snapshotCreateDiskSnapshotDisplayname" class="text-lh"></span>
				                            </td>
				                        </tr>
				                        <tr>
				                            <td align="right">快照容量：</td>
				                            <td align="left" colspan="3">
				                               <span id="snapshotCreateDiskNum" class="text-lh"></span><span class="text-lh">GB</span>
				                            </td>
				                        </tr>
				                        <tr>
				                            <td align="right"><span class="must-star">*</span>硬盘名称：</td>
				                            <td align="left" colspan="3">
				                               <input name="disDiskDisplaynme" class="easyui-textbox" data-options="required:true,missingMessage:'请输入硬盘名称',validType:['nameInput','maxLength[20]'],prompt:'不得超过20字'" style="width:170px;"/>
				                            </td>
				                        </tr>
				                        <tr>
				                            <td align="right"><span class="must-star">*</span>挂载服务器：</td>
				                            <td align="left" colspan="3">
				                                <input id="attachServer" name="serverdisplayname" class="easyui-textbox"  data-options="required:true,missingMessage:'请选择服务器'"  type="text" class="shadow-input" style="width: 170px; "/>
				                            </td>
				                        </tr>
				                        <tr>
				                           	<td align="right">硬盘容量：</td>
				                            <td align="left" colspan="3">
				                            	<div class="j-xtp-item item-sildebox" style="width: 400px">
											        <!-- 滑块 -->
											        <div class="j-silde"></div>
											        <!-- 滑块右侧 -->
											        <div class="item-right">
											            <input id="disDiskNum" name="disDiskNum" type="text" class="j-value" /><span>GB</span>
											        </div> 
												</div>
				                            </td>
				                        </tr>
				                        <tr>
				                           	<td align="right">硬盘描述：<br><span style='color:#f00'>(少于100字)</span></td>
				                            <td align="left" colspan="3">
				                                <textarea name="disDiskDescription" style="width: 95%; height: 90px" class="shadow-input textarea"></textarea>
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
	<!-- 从快照创建硬盘   end -->
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/web/indisk/js/sliderbar.js"></script>
</body>