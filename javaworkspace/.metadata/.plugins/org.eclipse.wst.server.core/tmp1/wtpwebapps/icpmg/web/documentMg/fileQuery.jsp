<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<body>
<style type="text/css">
.product-product-close {
  position: absolute;
  top: 50%;
  margin-top: -8px;
  height: 16px;
  overflow: hidden;
  background: url('${pageContext.request.contextPath}/easyui-1.4/themes/default/images/panel_tools.png') no-repeat -16px 0px;
}
.FieldInput2 {
	width: 75%;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}

.FieldLabel2 {
	width: 25%;
	height: 25px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}

</style>
	<script type="text/javascript">
		$(document).ready(function() {
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
						sortName : 'fileid',
						sortOrder : 'asc',
						singleSelect : true,
						method : 'post',
						loadMsg : '数据装载中......',
						fitColumns : true,
						pagination : true,
						pageSize : 10,
						pageList : [ 5, 10, 20, 30, 40, 50 ],
						toolbar : toolbar,
						url : '${pageContext.request.contextPath}/infopublish/fileList.do'
					});
			}
			function searchDataGrid() {
				$('#dg').datagrid('load',icp.serializeObject($('#file_searchform')));
			};

	</script>
	          <div class="easyui-layout" data-options="fit:true,border:false"
					style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
				<div data-options="region:'north',border:false"
					style="height:30px;overflow:hidden;">
					<form id="file_searchform">
						<table>
							<tr>
								<td>标题：
									<input class="easyui-textbox" name="filename"
									id="searchname" style="width:100px;height:30px;border:false">
									创建时间：<input class="easyui-datetimebox" name="starttime"
									id="starttime" style="width:140px;height:30px;border:false">
									到<input class="easyui-datetimebox" name="endtime"
									id="endtime" style="width:140px;height:30px;border:false">
								</td>
								<td>&nbsp;&nbsp;<a href="javascript:void(0);"
									class="easyui-linkbutton" data-options="iconCls:'icon-search'"
									onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
									href="javascript:void(0);" class="easyui-linkbutton"
									data-options="iconCls:'icon-redo'"
									onclick="$('#file_searchform input').val('');$('#searchname').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
								</td>
							</tr>
						</table>
					</form>	
				</div>
				<div data-options="region:'center',border:false">
					<table title="" style="width:100%;" id="dg">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'fileid',width:30,align:'center',hidden:true"></th>
								<th data-options="field:'filename',width:40,align:'center'">文件名</th>
								<th data-options="field:'cuserid',width:30,align:'center'">创建人</th>
								<th data-options="field:'ctime',width:40,align:'center'">创建时间</th>
								<th data-options="field:'fileurl',width:50,align:'center'">路径</th>
								<!-- <th data-options="field:'status',width:30,align:'center',formatter:operformater">操作</th> -->
							</tr>
						</thead>
					</table>
				</div>
			</div>
</body>
