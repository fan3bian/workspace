<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>

<body>
	<style type="text/css">
		.FieldInput2 {
			width:77%;
			height:25px;
		    background-color: #FFFFFF;
			font: normal 12px tahoma, arial, helvetica, sans-serif;
		    text-align: left;
		    word-wrap: break-word;
		    padding-top:0px !important;
		    padding-bottom:0px !important;
		    border:#BCD2EE 1px solid !important;  
		}
		.FieldLabel2 {
			width:23%;
			height:25px;
		    background-color: #F0F8FF;
			font: normal 12px tahoma, arial, helvetica, sans-serif;
		    text-align: left;
		    word-wrap: break-word;
		    padding-top:0px !important;
		    padding-bottom:0px !important;
		    padding-right:10px !important;
		    border:#BCD2EE 1px solid !important;  
		}
	</style>
	<script type="text/javascript">
		var toolbar = [{
			text:'增加',
			iconCls:'icon-add',
			handler:function()
			{
				debugger;
				$("#fid").val('');
				$("#fname").val('');
				$("#hname").val('#');
				$("#fic").val('default.png');
				$("#isvalidcheck").attr("checked",true);
				$("#isvalid").val('1');
				$('#w').window('open');
			}
		},{
			text:'删除',
			iconCls:'icon-remove',
			handler:function()
			{
				var rows = $('#dg').datagrid('getChecked');
				if(rows.length<1)
				{
					$.messager.alert('消息','请至少选择一条记录！'); 
					return; 
				}
				if(rows[0].fid){
					var fids = "";
					 $.each(rows,function(index,object){
					 	fids+=object.fid+",";
	   				 });
	   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
	   				  if (r){ 
	   				  	$.ajax({
	   				  		type : 'post',
	   				  		url:urlrootpath+'/authMgr/delFunction.do',
	   				  		data:{fid:fids},
	   				  		success:function(retr){
	   				  			var data =  JSON.parse(retr); 
	   				  			$.messager.alert('消息',data.msg);  
					  			if(data.success)
						    	{
						    		$('#dg').datagrid('unselectAll');
						    		$('#dg').datagrid('reload',icp.serializeObject($('#funcmgr_searchform')));
						    		
						    	} 
	   				  		}
	   				  	});
	   				  }
	   				 });
				}
			}
		},{
			text:'修改',
			iconCls:'icon-modify',
			handler:function()
			{
				debugger;
				var rows = $('#dg').datagrid('getChecked');
				if(rows.length!=1)
				{
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				if(rows[0].fid){				
					$("#fid").val(rows[0].fid);
					$("#fname").val(rows[0].fname);
					$("#hname").val(rows[0].hname);
					$("#fic").val(rows[0].fic);
					$("#isvalidcheck").attr("checked",true);
					if(rows[0].isvalid==1)
						{
							$("#isvalidcheck").attr("checked",true);
							$("#isvalid").val('1');
						}else
						{
								$("#isvalidcheck").attr("checked",false);	
								$("#isvalid").val('0');
						}
					$('#w').window('open');
				}
				
			}
		}];
		
		$(document).ready(function() {
			//$("#mm").hide();
			loadDataGrid();
			//loadOrgTree();
			//loadOrgTree(roleid);
		});
		function loadDataGrid()
			{
				$('#dg').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					sortName:'fname',
					sortOrder:'asc',
					nowarp:false,
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					idField:'fid',
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/authMgr/getAllFunction.do',
				    onLoadSuccess: function (data) {
					      var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
					      var  _pageSize = pageopt.pageSize;
					      var  _rows = $('#dg').datagrid("getRows").length
					      if (_pageSize >= 10) {
					         for(i=10;i>_rows;i--){
					            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
					            $(this).datagrid('appendRow', {operation:''  })
					         }
					         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
					      }else{
					         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
					         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					      }
					 }
					}); 
				
			}
			
		function searchDataGrid(){
			$('#dg').datagrid('load',icp.serializeObject($('#funcmgr_searchform')));
		};
		function statusformater(value,row,index)
		 {
		 	
			switch (value) {
							case 1:
								return "<span style=\"color:green\">在用</span>";
							case 0:
								return "<span style=\"color:red\">停用</span>";
							}
		 }
		 function submitSave()
		 {
		 	$('#tableform').form('submit',{
		    url:urlrootpath+'/authMgr/addorupdateFunction.do', 
		    onSubmit: function(){
		    	if($("#fname").attr("value")==null || $.trim($("#fname").attr("value"))=="" )
		    	{
		    		$.messager.alert('消息',"功能名称不能为空!");  
		    		return false;
		    	}
		    	if($("#hname").attr("value")==null || $.trim($("#hname").attr("value"))=="" )
		    	{
		    		$.messager.alert('消息',"URL不能为空!");  
		    		return false;
		    	}
		    	$("#isvalid").val($("#isvalidcheck").attr("checked")?1:0);
		    	$("#ename").val( $("#fname").attr("value"));
		    },
		    success:function(retr){
		    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
		    	var _data =  JSON.parse(retr); 
		    	//alert("success: "+_data.success);
		    	$.messager.alert('消息',_data.msg);  
				if(_data.success){
					$('#dg').datagrid('reload',icp.serializeObject($('#funcmgr_searchform')));
		    	}
		    
		    }
		});
		 	$('#w').window('close');
		 
		 }
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="background:#eee;height:30px;width:100%;overflow:hidden;">
			<form id="funcmgr_searchform">
				<tr  class="tableForm datagrid-toolbar">
					<td>功能名称：<input class="easyui-textbox" name="fname"  id="searchfname" style="width:200px;height:30px;border:false"></td>
					<td>&nbsp;&nbsp;状态：<select  id="searchisvalid" class="easyui-combobox" name="isvalid" data-options="panelHeight:'auto',required:true,editable:false" style="width:120px;height:30px;">
							<option value="2" selected>全部</option>
							<option value="1">在用</option>
							<option value="0">停用</option>
							</select>
					</td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="$('#funcmgr_searchform input').val('');$('#searchfname').textbox('clear');$('#searchisvalid').combobox('select', 2);$('#dg').datagrid('load',{});">重置</a>
					</td>
				</tr>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table title="" style="width:100%;"  id="dg">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'fid',hidden:true"></th>
						<th data-options="field:'fname',width:120,align:'center',sortable:true">功能名称</th>
						<th data-options="field:'hname',width:200,align:'center'">URL</th>
						<th data-options="field:'fic',width:200,align:'center'">前置图标</th>
						<th data-options="field:'isvalid',width:80,align:'center',formatter:statusformater">状态</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="w" class="easyui-window" title="功能项维护" data-options="closed:true,iconCls:'icon-save',inline:true" style="width:500px;height:220px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center'" style="padding:10px;">
					<form id="tableform" method="post">
							<input id="fid" name="fid" type="hidden"  />
							<input id="appid" name="appid"  type="hidden" value="1" />
							<input id="ename" name="ename"  type="hidden" value="1" />
							<input id="isvalid" name="isvalid"  type="hidden" />
						<table align="center"  style="width:80%">
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									功能名称：</td>
								<td class="FieldInput2"><input id="fname"
									style="height:25px" name="fname" class="easyui-validatebox"
									data-options="required:true" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2">URL：</td>
								<td class="FieldInput2"><input id="hname"
									style="height:25px" name="hname" class="easyui-validatebox"
									data-options="required:true" value="#" /><font color="red">*（相对路径）</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">前置图标：</td>
								<td class="FieldInput2"><input id="fic"
									style="height:25px" name="fic" class="easyui-validatebox"
									data-options="required:true" value="default.png" /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">是否有效：</td>
								<td class="FieldInput2"><input id="isvalidcheck"
									type="checkbox" checked="checked" /></td>
							</tr>
						</table>
					</form>
				</div>
				<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="submitSave();" style="width:80px">确定</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#w').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
	</div>
</body>