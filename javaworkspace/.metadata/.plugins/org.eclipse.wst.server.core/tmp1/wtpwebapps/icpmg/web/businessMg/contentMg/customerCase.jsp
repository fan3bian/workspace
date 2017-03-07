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
			title : '添加方案',
			url : '${pageContext.request.contextPath}/'+'web/businessMg/contentMg/caseForm.jsp',
			buttons : [{
				text : '预览',
				iconCls:'icon-search',
				handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
					dialog.find('iframe').get(0).contentWindow.onShows(parent.$);
				}
				},{
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
				var caseid = "";
				 $.each(rows,function(index,object){
				 	caseid+=object.caseid+",";
   				 });
   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/content/delCustomerCase.do',
   				  		data:{caseids:caseid},
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
				title : '修改方案',
				url : '${pageContext.request.contextPath}/'+'web/businessMg/contentMg/caseForm.jsp?id=' + rows[0].caseid,
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
   				  		url:'${pageContext.request.contextPath}/content/toCaseHtml.do',
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
			
				grid=$('#grid').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					scrollbarSize:0,
					sortName:'edittime',
					sortOrder:'desc',
					nowarp:false,
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					idField:'caseid',
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/content/caseList.do',
				     onLoadSuccess: function (data) {
				      var pageopt = $('#grid').datagrid('getPager').data("pagination").options;
				      var  _pageSize = pageopt.pageSize;
				      var  _rows = $('#grid').datagrid("getRows").length;
				       var total = pageopt.total; //显示的查询的总数
				      
				      if (_pageSize >= 10) {
				         for(i=10;i>_rows;i--){
				            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
				            $(this).datagrid('appendRow', {isvalid:''  })
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
													if   (val.isvalid==''&&val.isvalid!='0'){  
														$('#customerCaseid  input:checkbox').eq(idx+1).css("display","none");
														 
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
					$('#customerCaseid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
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
			$('#grid').datagrid('load',icp.serializeObject($('#customercase_searchform')));
		};
		
		function statusformater(value,row,index)
		 {
		 
			switch (value) {
							case 2:
								return "<span style=\"color:red\">未通过</span>";
							case 1:
								return "<span style=\"color:green\">已审核</span>";
							case 0:
								return "<span style=\"color:red\">待审核</span>";
							}
		 }
		 function isvalidformater(value,row,index)
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
			<form id="customercase_searchform">
				<table >
					<tr>
						<td>方案标题：<input class="easyui-textbox" name="casetitles"  id="casetitles" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;状态：<select class="easyui-combobox" name="status" id="status" data-options="panelHeight:'auto',required:true,editable:false" style="width:120px;height:30px;">
								<option value="3" selected>全部</option>
								<option value="1">已审核</option>
								<option value="0">待审核</option>
								<option value="2">未通过</option>
								</select>
						</td>
						
						<td>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;	
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="$('#customercase_searchform input').val('');$('#casetitles').textbox('clear');$('#status').combobox('select','3');$('#grid').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="customerCaseid"> 
			<table title="" style="width:100%;"  id="grid">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'customerwords',hidden:true">客户感言</th>
						<th data-options="field:'companyoverview',hidden:true">公司概述</th>
						<th data-options="field:'companystructure',hidden:true">案例概述</th>
						<th data-options="field:'contentimage',hidden:true">内容图片</th>
						<th data-options="field:'companyvalue',hidden:true">应用价值</th>
						<th data-options="field:'needsolution',hidden:true">急需解决</th>
						<th data-options="field:'usedtime',hidden:true">使用时间</th>
						<th data-options="field:'auditperson',hidden:true">审核人</th>
						<th data-options="field:'audittime',hidden:true">审核时间</th>
						<th data-options="field:'auditopinion',hidden:true">审核意见</th>
						<th data-options="field:'caseid',width:60,align:'center',sortable:true">方案编码</th>
						<th data-options="field:'casetitle',width:100,align:'center'">方案标题</th>
				        <th data-options="field:'customername',hidden:true",width:100,align:'center'">客户名称</th>
						<th data-options="field:'customerlogo',width:100,align:'center',hidden:true">客户logo路径</th>
						<th data-options="field:'customerintroduce',hidden:true,width:100,align:'center'">方案简介</th>
						<th data-options="field:'products',width:60,hidden:true",align:'center'">使用产品</th>
						<th data-options="field:'tradename',width:50,align:'center'">行业类别</th>
						<th data-options="field:'status',width:80,hidden:true",align:'center',formatter:statusformater">案例状态</th>
						<th data-options="field:'editperson',align:'center'">编辑人</th>
						<th data-options="field:'edittime',width:70,align:'center',sortable:true">编辑时间</th>
						<th data-options="field:'isvalid',width:50,align:'center',formatter:isvalidformater">删除位</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</body>