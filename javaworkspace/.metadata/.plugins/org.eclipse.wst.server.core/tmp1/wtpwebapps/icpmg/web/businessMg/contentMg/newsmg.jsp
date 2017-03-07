<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>	
<body >
  	<script type="text/javascript">
  	
  		var flagck = 0;  //  初始化为0
  	
  		var editor;
  		var grid;
		var toolbar = [{
			text:'增加',
			iconCls:'icon-add',
			handler:function()
			{ 	
			var dialog = parent.icp.modalDialog({
			title : '添加新闻',
			url : '${pageContext.request.contextPath}/'+'web/businessMg/contentMg/newsForm.jsp',
			buttons : [{
				text : '预览',
				iconCls:'icon-search',
				handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
					dialog.find('iframe').get(0).contentWindow.onShows(parent.$);
				}
				},
				{
			text : '添加',
			iconCls:'icon-add',
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
			iconCls:'icon-delete',
			handler:function()
			{
				var rows = $('#grid').datagrid('getChecked');
				if(rows.length<1)
				{
					$.messager.alert('消息','请至少选择一条记录！'); 
					return; 
				}
				var newsid = "";
				 $.each(rows,function(index,object){
				 	newsid+=object.newsid+",";
   				 });
   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/content/newsDel.do',
   				  		data:{newsids:newsid},
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
				title : '修改新闻',
				url : '${pageContext.request.contextPath}/'+'web/businessMg/contentMg/newsForm.jsp?id=' + rows[0].newsid,
				buttons : [{
				     text : '预览',
					 iconCls:'icon-search',
					 handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
						dialog.find('iframe').get(0).contentWindow.onShows(parent.$);
					}
					},{
					text : '修改',
					iconCls:'icon-modify',
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
		    text:'生成HTML',
		    iconCls:'icon-html',
			handler:function()
			{
			   $.messager.confirm('确认','您确认想要生成HTML？如果有原文件将被覆盖',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/content/toNewsHtml.do',
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
					sortName:'publishtime',
					sortOrder:'desc',
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					nowarp:true,
					idField:'newsid',
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/content/newsList.do',
				    onLoadSuccess: function (data) {
				      var pageopt = $('#grid').datagrid('getPager').data("pagination").options;
				      var  _pageSize = pageopt.pageSize;
				      var  _rows = $('#grid').datagrid("getRows").length;
				      var total = pageopt.total; //显示的查询的总数
				      if (_pageSize >= 10) {
				         for(i=10;i>_rows;i--){
				            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
				            $(this).datagrid('appendRow', {isvalid:''  });
				         }
				         
				          $('#grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
									    		total: total,
									    	});
				         
				         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
				      }else{
				         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
				         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				      }
				      
					  var rows = data.rows;
				      if (rows.length) {
							 $.each(rows, function (idx, val) {
							
								if(val.isvalid==''&&val.isvalid!='0'){  
									$('#newid  input:checkbox').eq(idx+1).css("display","none");
									 
								}
								
							}); 
				      }
				      
				      
				 },
				 
				 //没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.isvalid==''&&rowData.isvalid!='0'){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
					$('#newid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck = 1;
							$.each(rows, function (idx, val) {
								if (val.isvalid==''&&val.isvalid!='0'){
									$("#grid").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
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
			$('#grid').datagrid('load',icp.serializeObject($('#ordercofig_searchform')));
		};
		 
		function statusformater(value,row,index)
		 {
		 
			switch (value) {
							case 2:
								return "<span style=\"color:red\">未通过</span>";
							case 1:
								return "<span style=\"color:green\">已审核</span>";
							case 0:
								return "<span style=\"color:green\">待审核</span>";
							}
		 }
		 function validformater(value,row,index)
		 {
		 
			switch (value) {
							case 1:
								return "<span style=\"color:green\">有效</span>";
							 
							case 0:
								return "<span style=\"color:red\">无效</span>";
							}
		 }
		
</script>
 <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
 	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;">
			<form id="ordercofig_searchform">
				<table >
					<tr>
						<td>标题：<input class="easyui-textbox" name="newsname"  id="newsname" style="width:160px;height:30px;border:false"></td>
							<td>&nbsp;&nbsp;状态：<select class="easyui-combobox" name="status" id="status" data-options="panelHeight:'auto',editable:false" style="width:120px;height:30px;">
								<option value="3" selected>全部</option>
								<option value="0">待审核</option>
								<option value="2">未通过</option>
								</select>
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="$('#ordercofig_searchform input').val('');$('#newsname').textbox('clear');$('#status').combobox('select','3');$('#grid').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="newid">
		<table title="" style="width:100%;"  id="grid">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'newsid',width:100,align:'center',sortable:true">新闻编码</th>
				<th data-options="field:'newstitle',width:130,halign:'center'">新闻标题</th>
				<th data-options="field:'newsintroduce',width:210,halign:'center'">新闻概述</th>
				<th data-options="field:'publishperson',width:70,halign:'center'">发布人</th>
				<th data-options="field:'publishtime',width:130,halign:'center',sortable:true">发布时间</th>
				<th data-options="field:'newscontent',width:210,hidden:true,halign:'center'">新闻内容</th>
				<th data-options="field:'edittime',width:160,hidden:true,halign:'center'">修改时间</th>
			    <th data-options="field:'editperson',width:70,hidden:true,halign:'center'">修改人</th>
				<th data-options="field:'newsphotoaddr',width:160,hidden:true,halign:'center'">图片地址</th>
				<th data-options="field:'newstype',width:80,hidden:true,halign:'center'">新闻类型</th>
				<th data-options="field:'newsview',width:80,align:'center',hidden:true,sortable:true">点击量</th>
				<th data-options="field:'checktime',width:130,hidden:true,halign:'center'">审核时间</th>
				<th data-options="field:'checkperson',width:80,hidden:true,align:'center'">审核人</th>
				<th data-options="field:'status',width:80,align:'center',hidden:true,formatter:statusformater">新闻状态</th>
				<th data-options="field:'isvalid',width:80,align:'center',formatter:validformater">是否有效</th>
				
			</tr>
		 </thead>
  	 </table>
 	 </div>  
	</div>
</body>

