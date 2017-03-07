<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<head>
<body>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/web/indisk/css/indisk.css" />
	<script type="text/javascript">
	var flagck = 0;
	var indiskQosToolbar = [
		{
			text:'创建',
			iconCls:'icon-add',
			handler:function(){ 
				$('#createDiskQosWindow').show();
				$('#createDiskQosWindow').dialog('open');
				$('#createDiskQosform').form('clear');
			}
		},
		{
			text:'规格管理',
			iconCls:'icon-modify',
			handler:function() { 
				var rows = $('#qosGrid').datagrid('getChecked');
				if(rows.length != 1) {
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				if(rows[0].id){	
					$('#qosId').val(rows[0].id);
					$('#qosName').val(rows[0].name);
					$('#createQosName').text(rows[0].name);
					loadSpecGrid(rows[0].id, rows[0].name);
					
					$('#specWindow').show();
					$('#specWindow').dialog('open');
				}
			}
		},
		{
			text:'删除',
			iconCls:'icon-delete',
			handler:function(){ 
				var rows = $('#qosGrid').datagrid('getChecked');
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
		   				  		url: '${pageContext.request.contextPath}/indisk/deleteDiskQos.do',
		   				  		data: {id: ids.join(',')},
		   				  		success: function(data){
		   				  			var _data = JSON.parse(data); 
		   				  			$.messager.alert('消息',_data.msg);  
		   				  		$('#qosGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		   				  		}
		   				  	});
	   				    }
	   			    });
				}
			}
		}];
	               
	$(document).ready(function() {
		loadQosGrid();
		$.extend($.fn.validatebox.defaults.rules, {    
		    qosExist: {    
		        validator: function(value){
		        	var isExist = false;
				  	$.ajax({
				  		type: 'post',
				  		async: false,
				  		url: '${pageContext.request.contextPath}/indisk/queryDiskQos.do',
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
		        message: 'Qos已存在，请重新录入！'   
		    }    
		}); 
	});
	
	// 查询结果
	function loadQosGrid(){
		$('#qosGrid').datagrid({
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
			toolbar : indiskQosToolbar,
		    url:'${pageContext.request.contextPath}/indisk/queryDiskQosList.do',
		    onLoadSuccess: function (data) {
		    	var pageopt = $('#qosGrid').datagrid('getPager').data("pagination").options;
			      var  _pageSize = pageopt.pageSize;
			      var  _rows = $('#qosGrid').datagrid("getRows").length;
			      var total = pageopt.total;
			      if (_pageSize >= 10) {
			         for(var i=10;i>_rows;i--){
			            $(this).datagrid('appendRow', {status :''  });
			         }
			         $('#qosGrid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    		total: total,
				     });
			       
			      }else{
			         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			      }
			      var rows = data.rows;
			      if (rows.length) {
						 $.each(rows, function (idx, val) {
							if   (val.status ==''){ 
								$('#qosGrid_div  input:checkbox').eq(idx+1).css("display","none");
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
						$("#qosGrid").datagrid('uncheckRow', idx);
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
		$('#qosGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
	}
	
	function reset(){
		$('#conditionForm input').val('');
		$('#qosGrid').datagrid('load',{});
	}
	
	function closeCreateDiskQosDialog(){
		$('#createDiskQosWindow').dialog('close');
	}
	
	
	/**
	*  消费者
	*/
	function consumerformater(value, row, index) {
		switch (value) {
			case "front-end":
				return "前台";
			case "back-end":
				return "后台";
	        case "both":
				return "前后两端";
		}
	}
	
	/**
	*  规格
	*/ 
	function qosSpecsformater(value, row, index) {
		if(row.id) {
			var qosSpecs = [];
		  	$.ajax({
		  		type: 'post',
		  		async: false,
		  		url: '${pageContext.request.contextPath}/indisk/queryDiskSpecsList.do',
		  		data: {
		  			qosId: row.id,
		  			page: 0,
		  			rows: 1000
		  		},
		  		success: function(data){
		  			var _data = JSON.parse(data); 
		  			var rows = _data.rows;
		  			if(rows&&rows.length>0){
			  			for(var i=0; i< rows.length; i++){
			  				qosSpecs.push(' [' + rows[i].specKey + ':' 
			  				                 + rows[i].specValue + '] ');
			  			}
		  			}
		  		}
			});
		  	
			return qosSpecs.join(',');
		}
	}
	
	/* 
	*  云硬盘Qos规格创建 
	*/
	function createDiskQos(){
		$("#createDiskQosform").form('submit',{
		    url: '${pageContext.request.contextPath}/indisk/createDiskQos.do',
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
	            if(!flag){
	                return flag; 
	            }
		    },
		    success: function(data){
		    	var _data =  JSON.parse(data); 
		    	$.messager.alert('消息',_data.msg);
		    	closeCreateDiskQosDialog();
		    	$('#qosGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		    }
	    });
	}
	</script>
	
	<script type="text/javascript">
	var specflagck = 0;
	var indiskSpecToolbar = [
		{
			text:'创建',
			iconCls:'icon-add',
			handler:function(){ 
				$('#createDiskSpecWindow').show();
				$('#createDiskSpecWindow').dialog('open');
				$('#specKey').textbox('setValue','');
				$('#specValue').textbox('setValue','');
			}
		},
		{
			text:'删除',
			iconCls:'icon-delete',
			handler:function(){ 
				var rows = $('#specGrid').datagrid('getChecked');
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
		   				  		url: '${pageContext.request.contextPath}/indisk/deleteDiskSpec.do',
		   				  		data: {id: ids.join(',')},
		   				  		success: function(data){
		   				  			var _data = JSON.parse(data); 
		   				  			$.messager.alert('消息',_data.msg);  
		   				  		$('#specGrid').datagrid('load');
		   				  		}
		   				  	});
	   				    }
	   			    });
				}
			}
		}];
	               
	// 查询结果
	function loadSpecGrid(qosId, qosName){
		$('#specGrid').datagrid({
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
			queryParams:{
				qosId: qosId,
				qosName: qosName
			},
			toolbar : indiskSpecToolbar,
		    url:'${pageContext.request.contextPath}/indisk/queryDiskSpecsList.do',
		    onLoadSuccess: function (data) {
		    	var pageopt = $('#specGrid').datagrid('getPager').data("pagination").options;
			      var  _pageSize = pageopt.pageSize;
			      var  _rows = $('#specGrid').datagrid("getRows").length;
			      var total = pageopt.total;
			      if (_pageSize >= 10) {
			         for(var i=10;i>_rows;i--){
			            $(this).datagrid('appendRow', {status :''  });
			         }
			         $('#specGrid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    		total: total,
				     });
			       
			      }else{
			         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			      }
			      var rows = data.rows;
			      if (rows.length) {
						 $.each(rows, function (idx, val) {
							if   (val.status ==''){ 
								$('#specGrid_div  input:checkbox').eq(idx+1).css("display","none");
							}
						}); 
			      }
			 },
			 onClickRow: function (rowIndex, rowData) {
				if   (rowData.status ==''){
					 $(this).datagrid('unselectRow', rowIndex);
				}else{
					specflagck=0;
				}
				if(specflagck ==1){
					$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
				}
			}, 
			onCheckAll: function(rows) {
				specflagck = 1;
				$.each(rows, function (idx, val) {
					if   (val.status ==''){
						$("#specGrid").datagrid('uncheckRow', idx);
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
				});
			}, 
			onUncheckAll: function(rows) {
				specflagck = 0;
			}
		}); 
	}
	
	function closeCreateDiskSpecDialog(){
		$('#createDiskSpecWindow').dialog('close');
	}
	
	/* 
	*  云硬盘规格创建 
	*/
	function createDiskSpec(){
		$("#createDiskSpecform").form('submit',{
		    url: '${pageContext.request.contextPath}/indisk/createDiskSpec.do',
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
	            if(!flag){
	                return flag; 
	            }
		    },
		    success: function(data){
		    	var _data =  JSON.parse(data); 
		    	$.messager.alert('消息',_data.msg);
		    	closeCreateDiskSpecDialog();
		    	$('#specGrid').datagrid('load');
		    }
	    });
	}
	
	$(function(){
	   $('#specWindow').dialog({
	       onBeforeClose:function(){ 
	    	   $('#qosGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
	       }
	   });
	});
	
	$(function(){
		// 云硬盘Qos规格创建
	    $('#createDiskQosWindow').dialog({
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
	            	createDiskQos();
	            }
	        }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function() {
	                $('#createDiskQosWindow').dialog('close');
	            }
	        }]
	    });
	    $.parser.parse('#createDiskQosWindow'); 
	    
		// 云硬盘规格创建
	    $('#createDiskSpecWindow').dialog({
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
	            	createDiskSpec();
	            }
	        }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function() {
	                $('#createDiskSpecWindow').dialog('close');
	            }
	        }]
	    });
	    $.parser.parse('#createDiskSpecWindow'); 
	});
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;background-color: #eee;margin-bottom:10px;">
			<form id="conditionForm">
				<table >
					<tr>
						<td>Qos规格名称：<input class="easyui-textbox" name="name"
								style="width:120px;height:30px;border:false">
						
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset();">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="qosGrid_div">
			<table title="" style="width:100%;"  id="qosGrid">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',width:50,align:'center',hidden:true">编号</th>
						<th data-options="field:'name',width:50,align:'center'">名称</th>
						<th data-options="field:'consumer',width:50,align:'center',formatter:consumerformater">消费者</th>
						<th data-options="field:'qosSpecs',width:60,align:'left',formatter:qosSpecsformater">规格 </th>
					</tr>
				</thead>
			</table>
		</div>  
	</div>
	
	<!-- 云硬盘Qos规格创建   start -->
	<div id="createDiskQosWindow" class="easyui-window" title="创建Qos规格" data-options="closed:true,cache : false,modal: true" style="width:600px;height:350px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="createDiskQosform" method="post" enctype="multipart/form-data" >
					<div class="level-1">
						<p>Qos规格名称</p>
						<div class="infor-left">
							<input name="name" class="easyui-textbox" data-options="required:true,missingMessage:'请输入Qos规格名称',validType:'qosExist'" style="width:300px;height:30px;margin-left:8px;background: #ccc" />
						</div>
					</div>
					<div class="level-1">
						<p>消费者</p>
						<div class="infor-left">
							<select name="consumer" id="consumer" class="easyui-combobox"  data-options="required:true,missingMessage:'消费者',prompt:'请选择'"  style="width:300px;height:30px;margin-left:8px;">
							    <option value="back-end">后端</option>
							    <option value="front-end">前端</option>
							    <option value="both">前后两端</option>
						    </select>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 云硬盘Qos规格创建   end -->
	
	
	<div id="specWindow" class="easyui-window" title="规格管理" data-options="closed:true,cache : false,modal: true" style="width:800px;height:500px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
			<div data-options="region:'center',border:false" id="specGrid_div">
				<table title="" style="width:100%;"  id="specGrid">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'id',width:50,align:'center',hidden:true">编号</th>
							<th data-options="field:'qosId',width:50,align:'center',hidden:true">Qos编号</th>
							<th data-options="field:'qosName',width:50,align:'center'">Qos名称</th>
							<th data-options="field:'specKey',width:50,align:'center'">键</th>
							<th data-options="field:'specValue',width:50,align:'center'">值</th>
						</tr>
					</thead>
				</table>
			</div>  
		</div>
	</div>
	
	<!-- 云硬盘规格创建   start -->
	<div id="createDiskSpecWindow" class="easyui-window" title="创建规格" data-options="closed:true,cache : false,modal: true" style="width:600px;height:350px;padding:5px;top:50px;display:none;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="createDiskSpecform" method="post" enctype="multipart/form-data" >
					<input id="qosId" type="hidden" name="qosId">
					<input id="qosName" type="hidden" name="qosName">
					<div class="level-1">
						<p>类型名称</p>
						<div class="infor-left">
							<span id="createQosName" class="text-lh"></span>
						</div>
					</div>
					<div class="level-1">
						<p>键</p>
						<div class="infor-left">
							<input id="specKey" name="specKey" class="easyui-textbox" data-options="required:true,missingMessage:'请输入规格键名称',validType:['nameInput','maxLength[20]'],prompt:'不得超过20字'" style="width:300px;height:30px;margin-left:8px;background: #ccc" />
						</div>
					</div>
					<div class="level-1">
						<p>值</p>
						<div class="infor-left">
							<input id="specValue" name="specValue" class="easyui-textbox" data-options="required:true,missingMessage:'请输入规格键值',validType:['nameInput','maxLength[20]'],prompt:'不得超过20字'" style="width:300px;height:30px;margin-left:8px;background: #ccc" />
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 云硬盘规格创建   end -->
	
</body>