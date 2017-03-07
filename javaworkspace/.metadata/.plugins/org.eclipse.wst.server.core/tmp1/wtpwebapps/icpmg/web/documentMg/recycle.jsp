<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<body>
	<style type="text/css">
		.datagrid-header td,
		.datagrid-body td,
		.datagrid-footer td {
		  border-width: 0 0px 1px 0;
		  border-style: dotted;
		  margin: 0;
		  padding: 0;
		}
	</style>
	<script type="text/javascript">
		var url;
		$(document).ready(function() {
			url = '${pageContext.request.contextPath}/documentMg/recycleList.do';
			loadDataGrid(url);
		});
		//文档查询
		function loadDataGrid(url) {
			//debugger;
			$('#dg').datagrid(
					{
						rownumbers : false,
						border : false,
						striped : true,
						scrollbarSize : 0,
						sortName : 'fileid',
						sortOrder : 'asc',
						singleSelect : true,
						method : 'post',
						fit:true,
						loadMsg : '数据装载中......',
						fitColumns : true,
						pagination : false,
						pageSize : 10,
						pageList : [ 5, 10, 20, 30, 40, 50 ],
						url : url
					});
			}
			function searchDataGrid() {
				$('#dg').datagrid('load',icp.serializeObject($('#recycle_searchform')));
			}; 
			//文件夹名称 前加图片
			function nameformater(value, row, index) {
				var _fileid = row['fileid']
				switch (row.type) {
				case "1":
					return "<img src='${ctx}/images/files.png'/>"+"&nbsp;"+value;
				case "2":
					if(row['filetype']!=0){						
						var filename = row.filename.substring(13);
						return "<img src='${ctx}/images/wenben.png'/>"+"&nbsp;"+filename; 
					}else{
						var filename = row.filename;
						return "<img src='${ctx}/images/wenben.png'/>"+"&nbsp;"+filename;
					}
				}
			} 
			//回收站  按钮选项
			$(function(){
				//还原
				restoreFun=function(){
					var rows = $('#dg').datagrid('getSelections');
					if(rows.length<1)
					{
						$.messager.alert('消息','请至少选择一条记录！'); 
						return; 
					}
					var fileids = "";
					$.each(rows,function(index,object){
						fileids += object.fileid+",";
					});
					$.messager.confirm('确认','您确认想要还原选中记录吗？',function(r){
						if(r){
							$.ajax({
								type:'post',
								url:'${pageContext.request.contextPath}/documentMg/restoreFile.do',
								data:{fileids:fileids},
								success:function(retr){
									var data = JSON.parse(retr);
									$.messager.alert('消息',data.msg);
									if(data.success)
							    	{
							    		$('#dg').datagrid('unselectAll');
							    		$('#dg').datagrid('load',
												icp.serializeObject($('#recycle_searchform')));
							    	} 
								}
							});
						}
					});
				};
				//清空
				deleteFun=function(){
					var rows = $('#dg').datagrid('getSelections');
					if(rows.length<1)
					{
						$.messager.alert('消息','请至少选择一条记录！'); 
						return; 
					}
					var fileids = "";
					var parentid = rows[0].fileid;
					$.each(rows,function(index,object){
						fileids += object.fileid+",";
					});
					$.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){
						if(r){
							$.ajax({
								type:'post',
								url:'${pageContext.request.contextPath}/documentMg/deleteRecyFile.do',
								data:{fileids:fileids,parentid:parentid},
								success:function(retr){
									var data = JSON.parse(retr);
									$.messager.alert('消息',data.msg);
									if(data.success)
							    	{
							    		$('#dg').datagrid('unselectAll');
							    		$('#dg').datagrid('load',
												icp.serializeObject($('#recycle_searchform')));
							    	} 
								}
							});
						}
					});
				};
			}) 
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:50px 20px 20px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="background:#eee;height:40px;border:false">
			<form id="recycle_searchform">
				<table>
					<tr>
						<td style="float:right">&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-huanyuan',plain:true" onclick="restoreFun()">还原</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-delete',plain:true" onclick="deleteFun()">清空</a>&nbsp;
						</td>
					</tr>
				</table>
			</form>	
		</div>
		<div data-options="region:'center',border:false">
			<table title="" style="width:100%" id="dg">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'fileid',width:30,align:'left',hidden:true"></th>
						<th data-options="field:'filetype',width:30,align:'left',hidden:true"></th>
						<th data-options="field:'filename',width:100,align:'left',formatter:nameformater">名称</th>
						<th data-options="field:'size',width:30,align:'left'">大小</th>
					 	<th data-options="field:'ctime',width:40,align:'left'">删除时间</th>
					 	<th data-options="field:'type',width:40,align:'left',hidden:true">类型</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</body>
