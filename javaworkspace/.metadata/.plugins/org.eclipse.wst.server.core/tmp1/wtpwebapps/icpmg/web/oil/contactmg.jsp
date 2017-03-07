<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>	
<body >
  	<script type="text/javascript">
  		var editor;
  		var grid;
		var toolbar = [{
			text:'增加',
			iconCls:'icon-add',
			handler:function()
			{ 	
			var dialog = parent.icp.modalDialog({
			title : '添加联系人',
			 width: 900,
             height: 400,
             top:100,
			url : '${pageContext.request.contextPath}/'+'web/oil/contactForm.jsp',
			buttons : [{
			text : '添加',
			iconCls:'icon-ok',
			handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
				dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
			}
			},{
			text : '取消',
			iconCls:'icon-cancel',
			handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
				dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
			}
			} ]
			});
			
			}
		},{
			text:'删除',
			iconCls:'icon-remove',
			handler:function()
			{
				var rows = $('#grid').datagrid('getChecked');
				if(rows.length<1)
				{
					$.messager.alert('消息','请至少选择一条记录！'); 
					return; 
				}
				var contactid = "";
				 $.each(rows,function(index,object){
				 	contactid+=object.contactid+",";
   				 });
   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/oil/contactsDel.do',
   				  		data:{lessionids:contactid},
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg);  
				  			if(data.success)
					    	{
					    		$('#grid').datagrid('unselectAll');
					    		$('#grid').datagrid('reload',icp.serializeObject($('#ordercofig_searchform')));
					    		
					    	} 
   				  		}
   				  	});
   				  }
   				 });
			}
		},{
			text:'修改',
			iconCls:'icon-modify',
			handler:function()
			{
				var rows = $('#grid').datagrid('getSelections');
				if(rows.length==1)
				{
				var dialog = parent.icp.modalDialog({
				title : '修改联系人',
				width: 900,
	            height: 400,
	            top:100,
				url : '${pageContext.request.contextPath}/'+'web/oil/contactForm.jsp?contactid=' + rows[0].contactid,
				buttons : [{
					text : '修改',
					iconCls:'icon-ok',
					handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
					}
					},{
					text : '取消',
					iconCls:'icon-cancel',
					handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
						dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
					}
					} ]
				});
					//add(rows[0].newsid);
				}else {
					$.messager.alert('提示', '请选择一条记录！', 'error');
					return; 
				}
				
			}
		},{
				    id:'excelExport',
				    disabled:false,
					text : '导出',
					iconCls : 'icon-almexport',
					handler : function() {
						var rows = $('#grid').datagrid('getChecked');
						var pids = "";
						if(rows.length>0){
							$.each(rows,function(index,object){
							 	pids+="'"+object.contactid+"',";
			   				 });
							exportExcel(pids);
						}else{
							$.messager.alert('提醒','请选择至少一条信息导出');
						}
						 
					}
		}];
		
		$(document).ready(function() {
			
			loadDataGrid();
			
		});
		function loadDataGrid()
			{
				grid = $('#grid').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					scrollbarSize:0,
					sortName:'ctime',
					sortOrder:'desc',
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					nowarp:true,
					idField:'contactid',
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/oil/contactsList.do',   
					}); 
				
			}
			
		function searchDataGrid(){
			$('#grid').datagrid('load',icp.serializeObject($('#ordercofig_searchform')));
		};
		 
	
		 function validformater(value,row,index)
		 {
		 
			switch (value) {
							case 1:
								return "<span style=\"color:green\">有效</span>";
							 
							case 0:
								return "<span style=\"color:red\">无效</span>";
							}
		 }
		 
		 function exportExcel(pids){
				$('#ordercofig_searchform').form('submit',{
						url:'${pageContext.request.contextPath}/oil/exportExcel.do',
						onSubmit: function(param){
							param.contactid = pids;
							}
					});
		}
		
</script>
 <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
 	<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
			<form id="ordercofig_searchform">
				<table >
					<tr>
						<td>联系人：<input class="easyui-textbox" name="contactnames"  id="contactnames" style="width:160px;height:30px;border:false"></td>
						
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="$('#ordercofig_searchform input').val('');$('#contactnames').textbox('clear');$('#grid').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
		<table title="" style="width:100%;"  id="grid">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'contactid',width:100,hidden:true,halign:'center'">编码</th>
				<th data-options="field:'cname',width:130,halign:'center',sortable:true">联系人</th>
				<th data-options="field:'jobnumber',width:130,halign:'center',sortable:true">工号</th>
				<th data-options="field:'phone',width:100,halign:'center'">电话</th>
				<th data-options="field:'email',width:150,halign:'center'"> 邮箱</th>
				<th data-options="field:'punitname',width:100,halign:'center'">一级部门</th>
				<th data-options="field:'unitname',width:100,halign:'center'">二级部门</th>
				<th data-options="field:'sunitname',width:100,halign:'center'">三级部门</th>
				<th data-options="field:'duty',width:210,halign:'center'">工作方向</th>
				<th data-options="field:'ctime',width:80,hidden:true,halign:'center'">创建时间</th>
			    <th data-options="field:'userid',width:70,hidden:true,halign:'center'">创建人id</th>
				<th data-options="field:'username',width:80,hidden:true,halign:'center'">创建人</th>
				<th data-options="field:'delflg',width:80,hidden:true,align:'center',formatter:validformater">是否有效</th>
			</tr>
		 </thead>
  	 </table>
 	 </div>  
	</div>
</body>

