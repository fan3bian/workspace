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
			url = '${pageContext.request.contextPath}/documentMg/shareFileList.do';
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
						fit : true,
						pagination : false,
						pageSize : 10,
						pageList : [ 5, 10, 20, 30, 40, 50 ],
						url : url
					});
			}

			//文件夹名称 前加图片
			function nameformater(value, row, index) {
				switch (row.type) {
					case "1":
						return "<img src='${ctx}/images/files.png' />"+"&nbsp;"+value;
					case "2":
						var filename = row.filename;
						return "<img src='${ctx}/images/wenben.png' />"+"&nbsp;"+filename; 
				}
			} 
			//获取字段unitname字段最后一个值，即为文件来源
			function unitformater(value, row, index) {
					var sourceUnit = row.unitname.split(",");
					return sourceUnit[sourceUnit.length-1];
			}
			//共享文档  按钮选项
			$(function(){
				//下载
				downloadFun=function(){
					var rows = $('#dg').datagrid('getChecked');
					if(rows.length!=1){
						$.messager.alert('消息','请选择一个文件进行下载！'); 
						return; 
					}
					var fileid = rows[0].fileid;
					$("#filename").val(rows[0].filename);
					$("#fileurl").val(rows[0].fileurl);
					$.ajax({
						type : 'post',
						url : '${ctx}/documentMg/downSharefile.do',
						data:{
 				  		  fileid:fileid
 				  		},
 				  		dataType:'text',
 				  		async: false,
   				  		success:function(result){
   				  			url = '${ctx}/'+result;
				  		    var temp = url.split(".");
				  		    var str = temp[temp.length-1];
				  		    if(str=="doc"||str=="docx"||str=="xls"||str=="xlsx"){
				  		    	window.location.href = url;
				  		    }else{
				  		    	window.open(url);
				  		    }
   				  		}
					});
				}
			})
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:50px 20px 20px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="background:#eee;height:40px;overflow:hidden;border:false">
			<form id="share_searchform">
				<table>
					<tr>
						<td style="float:right">&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-fanhui',plain:true,disabled:true">返回</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-upload',plain:true,disabled:true">上传</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-download',plain:true" onclick="downloadFun()">下载</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-share',plain:true,disabled:true">分享</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:100px;height:35px" data-options="iconCls:'icon-addfiles',plain:true,disabled:true">新建文件夹</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-delete',plain:true,disabled:true">删除</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:80px;height:35px" data-options="iconCls:'icon-rename',plain:true,disabled:true">重命名</a>&nbsp;
						</td>
					</tr>
				</table>
			</form>	
		</div>
		<div data-options="region:'center',border:false" style="overflow_y:scroll;">
			<table title="" style="width:100%" id="dg">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'fileid',width:30,align:'left',hidden:true"></th>
						<th data-options="field:'filename',width:100,align:'left',formatter:nameformater">名称</th>
						<th data-options="field:'unitname',width:45,align:'left',formatter:unitformater">文件来源</th>
						<th data-options="field:'ctime',width:40,align:'left'">分享时间</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</body>
