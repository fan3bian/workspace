<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body >
<script type="text/javascript">
var editor;
var grid;
	var toolbar = [{
		text:'新增',
		iconCls:'icon-add',
		handler:function(){ 	
			var dialog = parent.icp.modalDialog({
							title : '新增填报信息',
							url : '${pageContext.request.contextPath}/web/oil/addOilResearch.jsp',
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
							}]
						});
			
		}
	},{
		text:'删除',
		iconCls:'icon-remove',
		handler:function(){
			var rows = $('#grid').datagrid('getChecked');
			if(rows.length<1){
				$.messager.alert('消息','请至少选择一条记录！'); 
				return; 
			}
			var ids = "";
			$.each(rows,function(index,object){ ids += object.company + "," + object.ctime + ";"; });
			$.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
				  if(r){ 
				  	$.ajax({
				  		type : 'post',
				  		url:'${pageContext.request.contextPath}/oil/delOilResearchInfo.do',
				  		data:{ids:ids},
				  		success:function(retr){
				  			var data =  JSON.parse(retr); 
				  			$.messager.alert('消息',data.msg);  
				  			if(data.success){
					    		$('#grid').datagrid('unselectAll');
					    		$('#grid').datagrid('reload',icp.serializeObject($('#ordercofig_searchform')));
					    	} 
				  		}
				  	});
				  }
			 });
		}
	}];

$(document).ready(function() {
	loadDataGrid();
});
function loadDataGrid(){
	grid = $('#grid').datagrid({
		//rownumbers:false,
		border:false,
		//striped:true,
		scrollbarSize:0,
		//singleSelect:false,
		method:'post',
		loadMsg:'数据装载中......',
		fitColumns:true,
		nowarp:false,
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		toolbar:toolbar,    
	    url:'${pageContext.request.contextPath}/oil/queryOilResearchInfo.do', 
	    frozenColumns:[[ 
	        			{field:'ck',checkbox:true} 
	    ]],
	    columns:[[
	              { title:'单位', field:'company', width:100, align:'center' },
	              { title:'创建时间', field:'ctime', width:30, align:'center', hidden:'true' },
	              { title:'人员', field:'submitperson', width:40, align:'center' },
	              { title:'提交时间', field:'stime', width:40, align:'center' },
	              { title:'资料详实程度', field:'dlevel', width:50, align:'center' },
	              { title:'排名', field:'ranking', width:20, align:'center' },
	              { title:'注意项目', field:'iprojects', width:60, align:'center' },
	              { 
	            	  title:'附件', 
	            	  field:'url', 
	            	  width:30, 
	            	  align:'center',
	            	  formatter: function(value,rowData,rowIndex){
	            		  return "<a target='_blank' href=\""+'${pageContext.request.contextPath}' + rowData.url + "\" >下载</a>";
	  	  			  }
	               }
		]]}); 
}
function searchDataGrid(){
	$('#grid').datagrid('load',icp.serializeObject($('#ordercofig_searchform')));
};
</script>
<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
		<form id="ordercofig_searchform">
			<table >
				<tr>
					<td>单位：<input class="easyui-textbox" name="company" id="company" style="width:160px;height:30px;border:false"/></td>
					<td>&nbsp;&nbsp;人员：<input class="easyui-textbox" name="submitperson" id="submitperson" style="width:160px;height:30px;border:false"/></td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="$('#ordercofig_searchform input').val('');$('#company').textbox('clear');$('#submitperson').textbox('clear');$('#grid').datagrid('load',{});">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table title="" style="width:100%;"  id="grid"></table>
	</div>  
</div>
</body>

