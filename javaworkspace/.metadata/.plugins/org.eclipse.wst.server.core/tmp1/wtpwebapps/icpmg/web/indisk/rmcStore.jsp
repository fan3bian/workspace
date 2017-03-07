<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<head>
<body>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/web/indisk/css/indisk.css" />
	<script type="text/javascript">
	var flagck = 0;
	var storeToolbar = [
		{
			text:'创建',
			iconCls:'icon-add',
			handler:function(){ 
				$('#createStoreWindow').show();
				$('#createStoreWindow').window('open');
				$('#createStoreForm').form('clear');
			}
		},
		{
			text:'修改',
			iconCls:'icon-modify',
			handler:function() { 
				var rows = $('#storeGrid').datagrid('getChecked');
				if(rows.length != 1) {
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				if(rows[0].id){				
					$('#updateStoreWindow').show();
					$('#updateStoreForm').form('clear');
					
 					$("#updateId").val(rows[0].id);
					$("#updateName").textbox('setValue',rows[0].name);
					$("#updateDatacenter").textbox('setValue',rows[0].datacenter);
					$("#updateDisplayname").textbox('setValue',rows[0].displayname);
					$("#updateDescription").textbox('setValue',rows[0].description);
					
					$("#updateNetworktypeid").textbox('setValue',rows[0].networktypename);
					$("#updatePlatform").textbox('setValue',rows[0].platformname);
					
 					$("#updateNetworktypename").val(rows[0].networktypename);
 					$("#updatePlatformid").val(rows[0].platformid);
 					$("#updatePlatformname").val(rows[0].platformname);
 					$("#updatePlattype").val(rows[0].plattype);
 					$("#updateDescription").val(rows[0].description);
					
					$('#updateStoreWindow').window('open');
				}
			}
		},
		{
			text:'删除',
			iconCls:'icon-delete',
			handler:function(){ 
				var rows = $('#storeGrid').datagrid('getChecked');
				if(rows.length<1){
					$.messager.alert('消息','请至少选择一条记录！'); 
					return; 
				}
				
				if(rows[0].id){				
					var ids = [];
					$.each(rows,function(index,row){
						ids.push(row.id);
	   				});
	   				$.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
	   				    if (r){ 
		   				  	$.ajax({
		   				  		type: 'post',
		   				  		url: '${pageContext.request.contextPath}/indisk/deleteStore.do',
		   				  		data: {id: ids.join(',')},
		   				  		success: function(data){
		   				  			var _data = JSON.parse(data); 
		   				  			$.messager.alert('消息',_data.msg);  
		   				  			$('#storeGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		   				  		}
		   				  	});
	   				    }
	   			    });
				}
			}
		}];
	               
	$(document).ready(function() {
		loadGrid();
	});
	
	// 查询结果
	function loadGrid(){
		$('#storeGrid').datagrid({
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
			toolbar : storeToolbar,
		    url:'${pageContext.request.contextPath}/indisk/queryStoreList.do',
		    onLoadSuccess: function (data) {
		    	var pageopt = $('#storeGrid').datagrid('getPager').data("pagination").options;
			      var  _pageSize = pageopt.pageSize;
			      var  _rows = $('#storeGrid').datagrid("getRows").length;
			      var total = pageopt.total;
			      if (_pageSize >= 10) {
			         for(var i=10;i>_rows;i--){
			            $(this).datagrid('appendRow', {status :''  });
			         }
			         $('#storeGrid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    		total: total,
				     });
			       
			      }else{
			         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			      }
			      var rows = data.rows;
			      if (rows.length) {
						 $.each(rows, function (idx, val) {
							if   (val.status ==''){ 
								$('#storeGrid_div  input:checkbox').eq(idx+1).css("display","none");
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
						$("#storeGrid").datagrid('uncheckRow', idx);
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
		$('#storeGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
	}
	
	function reset(){
		$('#conditionForm input').val('');
		$('#storeGrid').datagrid('load',{});
	}
	
	function closeCreateStoreDialog(){
		$('#createStoreWindow').window('close');
	}
	
	function closeUpdateStoreDialog(){
		$('#updateStoreWindow').window('close');
	}
	
	/* 
	*  存储创建 
	*/
	function createStore(){
		$("#createStoreForm").form('submit',{
		    url: '${pageContext.request.contextPath}/indisk/createStore.do',
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
	            if(!flag){
	                return flag; 
	            }
		    },
		    success: function(data){
		    	var _data =  JSON.parse(data); 
		    	$.messager.alert('消息',_data.msg);
		    	closeCreateStoreDialog();
		    	$('#storeGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		    }
	    });
	}
	
	/* 
	*  存储更新
	*/
	function updateStore(){
		$("#updateStoreForm").form('submit',{
		    url: '${pageContext.request.contextPath}/indisk/updateStore.do',
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
	            if(!flag){
	                return flag; 
	            }
		    },
		    success: function(data){
		    	var _data =  JSON.parse(data); 
		    	$.messager.alert('消息',_data.msg);
		    	closeUpdateStoreDialog();
		    	$('#storeGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		    }
	    });
	}
	
	$(function(){
		// 存储创建
	    $('#createStoreWindow').dialog({
	 	    width: 600,
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
	            	createStore();
	            }
	        }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function() {
	                $('#createStoreWindow').dialog('close');
	            }
	        }]
	    });
	    $.parser.parse('#createStoreWindow'); 
	    
		// 存储修改
	    $('#updateStoreWindow').dialog({
	 	    width: 600,
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
	            	updateStore();
	            }
	        }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function() {
	                $('#updateStoreWindow').dialog('close');
	            }
	        }]
	    });
	    $.parser.parse('#updateStoreWindow'); 
	});
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;background-color: #eee;margin-bottom:10px">
			<form id="conditionForm">
				<table >
					<tr>
						<td>存储名称：<input class="easyui-textbox" name="name"
								style="width:120px;height:30px;border:false">
						
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset();">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="storeGrid_div">
			<table title="" style="width:100%;"  id="storeGrid">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',width:30,align:'center',hidden:true">编号</th>
						<th data-options="field:'name',width:30,align:'center'">名称</th>
						<th data-options="field:'displayname',width:30,align:'center'">显示名称</th>
						<th data-options="field:'datacenter',width:30,align:'center'">数据中心</th>
						<th data-options="field:'networktypeid',width:30,align:'center',hidden:true">网络编号</th>
						<th data-options="field:'networktypename',width:30,align:'center'">网络</th>
						<th data-options="field:'platformid',width:30,align:'center',hidden:true">平台编号</th>
						<th data-options="field:'platformname',width:30,align:'center'">平台</th>
						<th data-options="field:'plattype',width:30,align:'center',hidden:true">平台类型</th>
						<th data-options="field:'description',width:50,align:'center'">描述 </th>
					</tr>
				</thead>
			</table>
		</div>  
	</div>
	
	<!-- 存储创建   start -->
	<div id="createStoreWindow" class="easyui-window" title="创建存储" data-options="closed:true,cache : false,iconCls:'icon-save',modal: true" style="width:600px;height:450px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="createStoreForm" method="post" enctype="multipart/form-data" >
					<div class="level-1">
						<p>存储名称</p>
						<div class="infor-left">
							<input name="name" class="easyui-textbox" data-options="required:true,missingMessage:'请输入存储名称',validType:['nameInput','maxLength[20]'],prompt:'不得超过20字'" style="width:300px;height:30px;margin-left:8px;background: #ccc" />
						</div>
					</div>
					<div class="level-1">
						<p>显示名称</p>
						<div class="infor-left">
							<input name="displayname" class="easyui-textbox" data-options="required:true,missingMessage:'请输入存储显示名称',validType:['nameInput','maxLength[20]'],prompt:'不得超过20字'" style="width:300px;height:30px;margin-left:8px;background: #ccc" />
						</div>
					</div>
					<div class="level-1">
						<p>数据中心</p>
						<div class="infor-left">
							<input name="datacenter" class="easyui-textbox" style="width:300px;height:30px;margin-left:8px;background: #ccc" />
						</div>
					</div>
					<div class="level-1">
						<p>网络</p>
						<div class="infor-left">
						    <input class="easyui-combobox" name="networktypeid" id="createNetworktypeid" style="width:300px;height:30px;align-text:center"
									data-options="required:true,missingMessage:'请选择网络',prompt:'请选择',
									panelHeight:100,
					                valueField: 'value',
					                textField: 'label',
					                data: [{
					                	label: '政务外网',
					                	value: '0001'
					                },{
					                	label: '互联网',
					                	value: '0002'
					                }],
									onSelect: function(rec){ 
											$('#createNetworktypename').val(rec.label);
									}
									"/>
							<input type="hidden" name="networktypename" id="createNetworktypename" ></input>		
						</div>
					</div>
					<div class="level-1">
						<p>平台</p>
						<div class="infor-left">
							<input class="easyui-combobox" id="createPlatform" style="width:300px;height:30px;align-text:center"
									data-options="required:true,missingMessage:'请选择平台',prompt:'请选择',
									panelHeight:100,
									url:'${pageContext.request.contextPath}/vmconfig/queryPlatform.do',
					                valueField: 'platformid',
					                textField: 'platformname',
									onSelect: function(rec){ 
									        var _data = rec.platformid.split(',');
											$('#createPlatformid').val(_data[0]);
											$('#createPlatformname').val(rec.platformname);
											$('#createPlattype').val(_data[2]);
									}
									"/>
							<input type="hidden" name="platformid" id="createPlatformid" ></input>		
							<input type="hidden" name="platformname" id="createPlatformname" ></input>		
							<input type="hidden" name="plattype" id="createPlattype" ></input>		
						</div>
					</div>
					<div class="level-1">
						<p>备注</p>
						<div class="infor-left">
							<input name="description" class="easyui-textbox" style="width:300px;height:30px;margin-left:8px;"/>
						</div>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<!-- 存储创建   end -->
	
	<!-- 存储修改   start -->
	<div id="updateStoreWindow" class="easyui-window" title="修改存储" data-options="closed:true,cache : false,iconCls:'icon-save',modal: true" style="width:600px;height:350px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="updateStoreForm" method="post" enctype="multipart/form-data" >
					<input type="hidden" id="updateId" name="id"/>
					<div class="level-1"> 
						<p>存储名称</p>
						<div class="infor-left">
							<input name="name" id="updateName" class="easyui-textbox" data-options="required:true,missingMessage:'请输入存储名称',validType:['nameInput','maxLength[20]'],prompt:'不得超过20字'" style="width:300px;height:30px;margin-left:8px;background: #ccc" />
						</div>
					</div>
					<div class="level-1">
						<p>显示名称</p>
						<div class="infor-left">
							<input name="displayname" id="updateDisplayname" class="easyui-textbox" data-options="required:true,missingMessage:'请输入存储显示名称',validType:['nameInput','maxLength[20]'],prompt:'不得超过20字'" style="width:300px;height:30px;margin-left:8px;background: #ccc" />
						</div>
					</div>
					<div class="level-1">
						<p>数据中心</p>
						<div class="infor-left">
							<input name="datacenter" id="updateDatacenter" class="easyui-textbox" style="width:300px;height:30px;margin-left:8px;background: #ccc" />
						</div>
					</div>
					<div class="level-1">
						<p>网络</p>
						<div class="infor-left">
						    <input class="easyui-combobox" name="networktypeid" id="updateNetworktypeid" style="width:300px;height:30px;align-text:center"
									data-options="required:true,missingMessage:'请选择网络',prompt:'请选择',
									panelHeight:100,
					                valueField: 'value',
					                textField: 'label',
					                data: [{
					                	label: '政务外网',
					                	value: '0001'
					                },{
					                	label: '互联网',
					                	value: '0002'
					                }],
									onSelect: function(rec){ 
											$('#updateNetworktypename').val(rec.label);
									}
									"/>
							<input type="hidden" name="networktypename" id="updateNetworktypename" ></input>		
						</div>
					</div>
					<div class="level-1">
						<p>平台</p>
						<div class="infor-left">
							<input class="easyui-combobox" id="updatePlatform" style="width:300px;height:30px;align-text:center"
									data-options="required:true,missingMessage:'请选择平台',prompt:'请选择',
									panelHeight:100,
									url:'${pageContext.request.contextPath}/vmconfig/queryPlatform.do',
					                valueField: 'platformid',
					                textField: 'platformname',
									onSelect: function(rec){ 
									        var _data = rec.platformid.split(',');
											$('#updatePlatformid').val(_data[0]);
											$('#updatePlatformname').val(rec.platformname);
											$('#updatePlattype').val(_data[2]);
									}
									"/>
							<input type="hidden" name="platformid" id="updatePlatformid" ></input>		
							<input type="hidden" name="platformname" id="updatePlatformname" ></input>		
							<input type="hidden" name="plattype" id="updatePlattype" ></input>		
						</div>
					</div>
					<div class="level-1">
						<p>备注</p>
						<div class="infor-left">
							<input id="updateDescription" name="description" class="easyui-textbox" style="width:300px;height:30px;margin-left:8px;"/>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 存储修改   end -->
</body>