<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
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
		var url;
		$(document).ready(function() {
			url = '${pageContext.request.contextPath}/documentMg/projectList.do';
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
						pagination : false,
						pageSize : 10,
						pageList : [ 5, 10, 20, 30, 40, 50 ],
						toolbar : toolbar,
						url : url
					});
			}
			function searchDataGrid() {
				$('#dg').datagrid('load',icp.serializeObject($('#project_searchform')));
			}; 
			/* //类型
			function typeformater(value, row, index) {
				switch (value) {
					case "1":
						return "<span>文件夹</span>";
					case "2":
						return "<span>文件</span>";
				}
			}  */
			
			//文件夹名称 前加图片
			function nameformater(value, row, index) {
				var _proid = row['proid']
				return "<img src='${ctx}/images/files.png' onclick='showDetail("+_proid+")' />"+"&nbsp;"+value;
			} 
			
			//文档管理 全部文件  按钮选项
			$(function(){

			})
	</script>
	          <div class="easyui-layout" data-options="fit:true,border:false"
					style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
				<div data-options="region:'north',border:false"
					style="height:40px;overflow:hidden;">
					<form id="project_searchform">
						<table>
							<tr>
								<td style="float:right">&nbsp;
									<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-upload',plain:false" onclick="backFun()">返回</a>&nbsp;
									<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-upload',plain:false" onclick="uploadFileFun()">上传</a>&nbsp;
									<a href="javascript:void(0);" class="easyui-linkbutton" style="width:100px;height:35px" data-options="iconCls:'icon-addfiles',plain:false" onclick="addFolderFun()">新建文件夹</a>&nbsp;
									<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-download',plain:false" onclick="shareFileFun()">分享</a>&nbsp;
									<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-download',plain:false" onclick="downloadFileFun()">下载</a>&nbsp;
									<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-delete',plain:false" onclick="deleteFileFun()">删除</a>&nbsp;
									<a href="javascript:void(0);" class="easyui-linkbutton" style="width:80px;height:35px" data-options="iconCls:'icon-rename',plain:false" onclick="updateNameFun()">重命名</a>&nbsp;
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
								<th data-options="field:'proid',width:30,align:'left',hidden:true"></th>
								<th data-options="field:'proname',width:80,align:'left',formatter:nameformater">项目名称</th>
								<th data-options="field:'ctime',width:40,align:'left'">修改时间</th>
								<th data-options="field:'cuserid',width:40,align:'left'">修改人</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
</body>
