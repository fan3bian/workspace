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
			url = '${pageContext.request.contextPath}/documentMg/myShareList.do';
			loadDataGrid();
		});
		//文档查询
		function loadDataGrid() {
			$('#dg').datagrid(
					{
						rownumbers : false,
						border : false,
						striped : true,
						scrollbarSize : 0,
						sortName : 'proid',
						sortOrder : 'asc',
						singleSelect : false,
						method : 'post',
						loadMsg : '数据装载中......',
						fitColumns : true,
						fit:true,
						pagination : false,
						pageSize : 10,
						pageList : [ 5, 10, 20, 30, 40, 50 ],
						url : url
					});
			}
		
			//文件夹名称 前加图片
			function nameformater(value, row, index) {
				var _proid = row['proid']
				var filename = row.filename;
				return "<img src='${ctx}/images/wenben.png' onclick='showDetail("+_proid+")' />"+"&nbsp;"+filename;
			} 
			
			//按钮选项
			$(function(){
				//取消分享
				cancelShareFun=function(){
					var rows = $('#dg').datagrid('getSelections');
					if(rows.length<1)
					{
						$.messager.alert('消息','请至少选择一条记录！'); 
						return; 
					}
						var fileids = "";
						 $.each(rows,function(index,object){
							 fileids+=object.fileid+",";
		   				 });
		   				 $.messager.confirm('确认','您确认想要取消分享选中记录吗？',function(r){   
		   				  if (r){ 
		   				  	$.ajax({
		   				  		type : 'post',
		   						url:'${pageContext.request.contextPath}/documentMg/cancelShare.do',
		   				  		data:{fileids:fileids},
		   				  		success:function(retr){
		   				  			var data =  JSON.parse(retr); 
		   				  			$.messager.alert('消息',data.msg);  
						  			if(data.success)
							    	{
							    		$('#dg').datagrid('unselectAll');
							    		$('#dg').datagrid('reload');
							    	} 
		   				  		}
		   				  	});
		   				  }
		   			});
				};
			})
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:50px 20px 20px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="background:#eee;height:40px;overflow:hidden;border:false">
			<form id="share_searchform">
				<table>
					<tr>
						<td style="float:right">&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-fanhui',plain:true,disabled:true" >返回</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-upload',plain:true,disabled:true" >上传</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-download',plain:true,disabled:true" >下载</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:90px;height:35px" data-options="iconCls:'icon-share',plain:true" onclick="cancelShareFun()">取消分享</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:100px;height:35px" data-options="iconCls:'icon-addfiles',plain:true,disabled:true" >新建文件夹</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-delete',plain:true,disabled:true" >删除</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:80px;height:35px" data-options="iconCls:'icon-rename',plain:true,disabled:true" >重命名</a>&nbsp;
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
						<th data-options="field:'filename',width:100,align:'left',formatter:nameformater">名称</th>
						<th data-options="field:'size',width:30,align:'left'">大小</th>
						<th data-options="field:'ctime',width:40,align:'left'">分享时间</th>
						<th data-options="field:'sharestatus',width:30,align:'left',hidden:true"></th>
						
					</tr>
				</thead>
			</table>
		</div>
	</div>
</body>
