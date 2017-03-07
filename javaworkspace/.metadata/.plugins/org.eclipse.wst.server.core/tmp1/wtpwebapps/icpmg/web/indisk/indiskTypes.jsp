<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<head>
<body>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/web/indisk/css/indisk.css" />
	<script type="text/javascript">
	var flagck = 0;
	var indiskTypeToolbar = [
		{
			text:'创建',
			iconCls:'icon-add',
			handler:function(){ 
				$('#createDiskTypeWindow').show();
				$('#createDiskTypeWindow').dialog('open');
				$('#createDiskTypeform').form('clear');
			}
		},
		{
			text:'关联QoS规格',
			iconCls:'icon-modify',
			handler:function(){ 
				var rows = $('#typeGrid').datagrid('getChecked');
				if(rows.length<1 || rows.length>1){
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				
				if(rows[0].id){				
					$('#bindQosWindow').show();
					
 					$("#bindTypeId").val(rows[0].id);
					$("#bindTypeName").text(rows[0].name);
					$("#bindQosId").combobox('setValue',rows[0].qosId);
					$("#bindQosName").val(rows[0].qosName);
					
					$('#bindQosWindow').dialog('open');
				}
			}
		},
		{
			text:'删除',
			iconCls:'icon-delete',
			handler:function(){ 
				var rows = $('#typeGrid').datagrid('getChecked');
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
		   				  		url: '${pageContext.request.contextPath}/indisk/deleteDiskType.do',
		   				  		data: {id: ids.join(',')},
		   				  		success: function(data){
		   				  			var _data = JSON.parse(data); 
		   				  			$.messager.alert('消息',_data.msg);  
		   				  		$('#typeGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		   				  		}
		   				  	});
	   				    }
	   			    });
				}
			}
		}];
	               
	$(document).ready(function() {
		loadDataGrid();
		$.extend($.fn.validatebox.defaults.rules, {    
		    typeExist: {    
		        validator: function(value){
		        	var isExist = false;
				  	$.ajax({
				  		type: 'post',
				  		async: false,
				  		url: '${pageContext.request.contextPath}/indisk/queryDiskType.do',
				  		data: {
				  			name: value,
				  		},
				  		success: function(data){
				  			var _data = JSON.parse(data); 
				  			if(_data.obj == null || typeof(_data.obj) == 'undefined'){
				  				isExist = true;
				  			}
				  		}
					});
				  	
		            return isExist;    
		        },    
		        message: '云硬盘类型已存在，请重新录入！'   
		    }    
		}); 
	});
	
	//查询结果
	function loadDataGrid(){
		$('#typeGrid').datagrid({
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
			toolbar : indiskTypeToolbar,
		    url:'${pageContext.request.contextPath}/indisk/queryDiskTypesList.do',
		    onLoadSuccess: function (data) {
		    	var pageopt = $('#typeGrid').datagrid('getPager').data("pagination").options;
			      var  _pageSize = pageopt.pageSize;
			      var  _rows = $('#typeGrid').datagrid("getRows").length;
			      var total = pageopt.total;
			      if (_pageSize >= 10) {
			         for(var i=10;i>_rows;i--){
			            $(this).datagrid('appendRow', {status :''  });
			         }
			         $('#typeGrid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    		total: total,
				     });
			       
			      }else{
			         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			      }
			      var rows = data.rows;
			      if (rows.length) {
						 $.each(rows, function (idx, val) {
							if   (val.status ==''){ 
								$('#typeGrid_div  input:checkbox').eq(idx+1).css("display","none");
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
						$("#typeGrid").datagrid('uncheckRow', idx);
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
		$('#typeGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
	}
	
	function reset(){
		$('#conditionForm input').val('');
		$('#typeGrid').datagrid('load',{});
	}
	
	function closeCreateDiskTypeDialog(){
		$('#createDiskTypeWindow').dialog('close');
	}
	
	function closeUpdateDiskTypeDialog(){
		$('#updateDiskTypeWindow').dialog('close');
	}
	
	function closeBindQosDialog(){
		$('#bindQosWindow').dialog('close');
	}
	
	/* 
	*  云硬盘类型创建 
	*/
	function createDiskType(){
		$("#createDiskTypeform").form('submit',{
		    url: '${pageContext.request.contextPath}/indisk/createDiskType.do',
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
	            if(!flag){
	                return flag; 
	            }
		    },
		    success: function(data){
		    	var _data =  JSON.parse(data); 
		    	$.messager.alert('消息',_data.msg);
		    	closeCreateDiskTypeDialog();
		    	$('#typeGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		    }
	    });
	}
	
	/* 
	*  云硬盘类型关联Qos
	*/
	function bindQos(){
		$("#bindQosform").form({
		    url: '${pageContext.request.contextPath}/indisk/bindQos.do',
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
	            if(!flag){
	                return flag; 
	            }
		    },
		    success: function(data){
		    	var _data =  JSON.parse(data); 
		    	$.messager.alert('消息',_data.msg);
		    	closeBindQosDialog();
	  		    $('#typeGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		    }
	    });
		$("#bindQosform").form('submit')
	}
	
	/* 
	*  云硬盘类型更新
	*/
	function updateDiskType(){
		$("#updateDiskTypeform").form('submit',{
		    url: '${pageContext.request.contextPath}/indisk/updateDiskType.do',
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
	            if(!flag){
	                return flag; 
	            }
		    },
		    success: function(data){
		    	var _data =  JSON.parse(data); 
		    	$.messager.alert('消息',_data.msg);
		    	closeUpdateDiskTypeDialog();
		    	$('#typeGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		    }
	    });
	}
	
	$(function(){
		// 云硬盘类型创建
	    $('#createDiskTypeWindow').dialog({
	 	    width: 600,
	        height: 250,
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
	            	createDiskType();
	            }
	        }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function() {
	                $('#createDiskTypeWindow').dialog('close');
	            }
	        }]
	    });
	    $.parser.parse('#createDiskTypeWindow'); 
	    
		// 关联Qos规格
	    $('#bindQosWindow').dialog({
	 	    width: 600,
	        height: 250,
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
	            	bindQos();
	            }
	        }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function() {
	                $('#bindQosWindow').dialog('close');
	            }
	        }]
	    });
	    $.parser.parse('#bindQosWindow'); 
	});
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;background-color: #eee;margin-bottom:10px">
			<form id="conditionForm">
				<table >
					<tr>
						<td>硬盘类型名称：<input class="easyui-textbox" name="name"
								style="width:120px;height:30px;border:false">
						
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset();">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="typeGrid_div">
			<table title="" style="width:100%;"  id="typeGrid">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',width:50,align:'center',hidden:true">编号</th>
						<th data-options="field:'name',width:50,align:'center'">硬盘类型名称</th>
						<th data-options="field:'qosId',width:50,align:'center',hidden:true">关联Qos规格</th>
						<th data-options="field:'qosName',width:50,align:'center'">关联Qos规格</th>
						<th data-options="field:'description',width:60,align:'center'">硬盘类型描述</th>
					</tr>
				</thead>
			</table>
		</div>  
	</div>
	
	<!-- 云硬盘类型创建   start -->
	<div id="createDiskTypeWindow" class="easyui-window" title="创建云硬盘类型" data-options="closed:true,cache : false,modal: true" style="width:600px;height:350px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="createDiskTypeform" method="post" enctype="multipart/form-data" >
					<div class="level-1">
						<p>硬盘类型名称</p>
						<div class="infor-left">
							<input name="name" class="easyui-textbox" data-options="required:true,missingMessage:'请输入硬盘类型名称',validType:'typeExist'" style="width:300px;height:30px;margin-left:8px;background: #ccc" />
						</div>
					</div>
					<div class="level-1">
						<p>硬盘类型描述</p>
						<div class="infor-left">
							<input name="description" class="easyui-textbox" style="width:300px;height:30px;margin-left:8px;"/>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 云硬盘类型创建   end -->
	
	<!-- 关联Qos规格   start -->
	<div id="bindQosWindow" class="easyui-window" title="关联Qos规格" data-options="closed:true,cache : false,modal: true" style="width:600px;height:350px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="bindQosform" method="post" enctype="multipart/form-data" >
					<input id="bindTypeId" type="hidden" name="id" />
					<div class="level-1">
						<p>类型名称</p>
						<div class="infor-left">
							<span id="bindTypeName" class="text-lh"></span>
						</div>
					</div>
					<div class="level-1">
						<p>Qos规格</p>
						<div class="infor-left">
							<input class="easyui-combobox" id="bindQosId" name="qosId" style="width:300px;height:30px;align-text:center"
									data-options="panelHeight:100,
									url:'${pageContext.request.contextPath}/indisk/queryAllDiskQos.do',
									valueField:'id',
									textField:'name',
									onSelect: function(rec){ 
											$('#bindQosName').val(rec.name);
									}
									"/>
							<input type="hidden" name="qosName" id="bindQosName" ></input>		
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 关联Qos规格   end -->
</body>