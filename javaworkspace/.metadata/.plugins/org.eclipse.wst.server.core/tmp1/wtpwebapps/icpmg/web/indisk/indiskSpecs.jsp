<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<head>
<body>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/web/indisk/css/indisk.css" />
	<script type="text/javascript">
	var flagck = 0;
	var indiskSpecToolbar = [
		{
			text:'创建',
			iconCls:'icon-add',
			handler:function(){ 
				$('#createDiskSpecWindow').show();
				$('#createDiskSpecWindow').window('open');
				$('#createDiskSpecform').form('clear');
			}
		},
		{
			text:'修改',
			iconCls:'icon-modify',
			handler:function() { 
				var rows = $('#specGrid').datagrid('getChecked');
				if(rows.length != 1) {
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				if(rows[0].id){				
					$('#updateDiskSpecWindow').show();
					$('#updateDiskSpecform').form('clear');
					
 					$("#updateId").val(rows[0].id);
					$("#updateName").textbox('setValue',rows[0].name);
					$("#updateDescription").textbox('setValue',rows[0].description);
					
					$('#updateDiskSpecWindow').window('open');
				}
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
		   				  		$('#specGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		   				  		}
		   				  	});
	   				    }
	   			    });
				}
			}
		}];
	               
	$(document).ready(function() {
		loadSpecGrid();
	});
	
	// 查询结果
	function loadSpecGrid(){
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
			toolbar : indiskSpecToolbar,
		    url:'${pageContext.request.contextPath}/indisk/queryDiskSpecList.do',
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
						$("#specGrid").datagrid('uncheckRow', idx);
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
		$('#specGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
	}
	
	function reset(){
		$('#conditionForm input').val('');
		$('#specGrid').datagrid('load',{});
	}
	
	function closeCreateDiskSpecDialog(){
		$('#createDiskSpecWindow').window('close');
	}
	
	function closeUpdateDiskSpecDialog(){
		$('#updateDiskSpecWindow').window('close');
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
		    	$('#specGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		    }
	    });
	}
	
	/* 
	*  云硬盘规格更新
	*/
	function updateDiskSpec(){
		$("#updateDiskSpecform").form('submit',{
		    url: '${pageContext.request.contextPath}/indisk/updateDiskSpec.do',
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
	            if(!flag){
	                return flag; 
	            }
		    },
		    success: function(data){
		    	var _data =  JSON.parse(data); 
		    	$.messager.alert('消息',_data.msg);
		    	closeUpdateDiskSpecDialog();
		    	$('#specGrid').datagrid('load',icp.serializeObject($('#conditionForm')));
		    }
	    });
	}
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;background-color: #eee;margin-bottom:10px">
			<form id="conditionForm">
				<table >
					<tr>
						<td>规格名称：<input class="easyui-textbox" name="name"
								style="width:120px;height:30px;border:false">
						
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset();">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="specGrid_div">
			<table title="" style="width:100%;"  id="specGrid">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',width:50,align:'center',hidden:true">编号</th>
						<th data-options="field:'name',width:50,align:'center'">名称</th>
						<th data-options="field:'consumer',width:50,align:'center'">消费者</th>
						<th data-options="field:'description',width:60,align:'center'">规格 </th>
					</tr>
				</thead>
			</table>
		</div>  
	</div>
	
	<!-- 云硬盘规格创建   start -->
	<div id="createDiskSpecWindow" class="easyui-window" title="创建云硬盘规格" data-options="closed:true,cache : false,iconCls:'icon-save',modal: true" style="width:600px;height:350px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="createDiskSpecform" method="post" enctype="multipart/form-data" >
					<div class="level-1">
						<p>规格名称</p>
						<div class="infor-left">
							<input name="name" class="easyui-textbox" data-options="required:true,missingMessage:'请输入规格名称',validType:['nameInput','maxLength[20]'],prompt:'不得超过20字'" style="width:200px;height:30px;margin-left:8px;background: #ccc" />
						</div>
					</div>
					<div class="level-1">
						<p>消费者</p>
						<div class="infor-left">
							<input name="description" class="easyui-textbox" style="width:200px;height:30px;margin-left:8px;"/>
						</div>
					</div>
				</form>
				<div class="bottom">
					<div class="indisk-button" >
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="createDiskSpec();">保存 </a> 
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeCreateDiskSpecDialog();">取消 </a> 
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 云硬盘规格创建   end -->
	
	<!-- 云硬盘规格修改   start -->
	<div id="updateDiskSpecWindow" class="easyui-window" title="修改云硬盘规格" data-options="closed:true,cache : false,iconCls:'icon-save',modal: true" style="width:600px;height:350px;padding:5px;display:none; top:50px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:5px;">
				<form id="updateDiskSpecform" method="post" enctype="multipart/form-data" >
					<input id="updateId" type="hidden" name="id" />
					<div class="level-1">
						<p>规格名称</p>
						<div class="infor-left">
							<input id="updateName" name="name" class="easyui-textbox" data-options="required:true,missingMessage:'请输入规格名称',validType:['nameInput','maxLength[20]'],prompt:'不得超过20字'" style="width:200px;height:30px;margin-left:8px;background: #ccc" />
						</div>
					</div>
					<div class="level-1">
						<p>规格描述</p>
						<div class="infor-left">
							<input id="updateDescription" name="description" class="easyui-textbox" style="width:200px;height:30px;margin-left:8px;"/>
						</div>
					</div>
				</form>
				<div class="bottom">
					<div class="indisk-button" >
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="updateDiskSpec();">保存 </a> 
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeUpdateDiskSpecDialog();">取消 </a> 
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 云硬盘规格修改   end -->
</body>