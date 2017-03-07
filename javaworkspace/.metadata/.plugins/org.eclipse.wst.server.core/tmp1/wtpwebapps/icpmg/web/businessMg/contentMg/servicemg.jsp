<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
	<div id="tabs" class="easyui-tabs" style="width:100%;background:#eee" data-options="tabWidth:112, border:false,fit:true" >
	<div id="tabs-1" title="新手课堂" data-options="fit:true" style="padding:10px;background:#eee" >
		<script type="text/javascript">
		var flagck = 0;  //  初始化为0
  	    var editor;
  		var gridLession;
		var toolbar = [{
			text:'增加',
			iconCls:'icon-add',
			handler:function()
			{
			 var dialog = parent.icp.modalDialog({
			 title : '添加新手课堂',
			 url : '${pageContext.request.contextPath}/'+'web/businessMg/contentMg/lessionForm.jsp',
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
				dialog.find('iframe').get(0).contentWindow.submitForm(dialog, gridLession, parent.$);
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
			iconCls:'icon-delete',
			handler:function()
			{
				var rows = $('#dg').datagrid('getChecked');
				if(rows.length<1)
				{
					$.messager.alert('消息','请至少选择一条记录！'); 
					return; 
				}
				var lessionid= "";
				 $.each(rows,function(index,object){
				 	lessionid+=object.lessionid+",";
   				 });
   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/content/lessionDel.do',
   				  		data:{lessionids:lessionid},
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg);  
				  			if(data.success)
					    	{
					    		$('#dg').datagrid('unselectAll');
					    		$('#dg').datagrid('reload',icp.serializeObject($('#ordercofig_searchform')));
					    		
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
				var rows = $('#dg').datagrid('getSelections');
				if(rows.length==1)
				{
				var dialog = parent.icp.modalDialog({
				title : '修改新手课堂',
				url : '${pageContext.request.contextPath}/'+'web/businessMg/contentMg/lessionForm.jsp?lessionid=' + rows[0].lessionid,
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
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog,gridLession,parent.$);
					}
					},{
					text : '取消',
					iconCls:'icon-cancel',
					handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
						dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
					}
					}]
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
   				  		url:'${pageContext.request.contextPath}/content/toLessionHtml.do',
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg);  
				  			if(data.success)
					    	{
					    		$('#dg').datagrid('unselectAll');
					    		$('#dg').datagrid('reload',icp.serializeObject($('#ordercofig_searchform')));
					    		
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
			   gridLession=$('#dg').datagrid({
					rownumbers:false,
					border:false,
				    autoRowHeight:false,
					striped:true,
					scrollbarSize:0,
					sortName:'publishtime',
					sortOrder:'desc',
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					idField:'lessionid',
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/content/lessionList.do',
				     onLoadSuccess: function (data) {
				      var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
				      var  _pageSize = pageopt.pageSize;
				      var  _rows = $('#dg').datagrid("getRows").length;
				      var total = pageopt.total; //显示的查询的总数
				      if (_pageSize >= 10) {
				         for(i=10;i>_rows;i--){
				            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
				            $(this).datagrid('appendRow', {delflg:''  });
				         }
				         
				         $('#dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
													if   (val.delflg==''&&val.delflg!='0'){  
														$('#lessionsid  input:checkbox').eq(idx+1).css("display","none");
														 
													}
												}); 
									      }
				      
				      
				 },
				 
				 //没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.delflg==''&&rowData.delflg!='0'){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
					$('#lessionsid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck = 1;
							$.each(rows, function (idx, val) {
								if (val.delflg==''&&val.delflg!='0'){
									$("#dg").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('#lessionsid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
								}
							});
					},
									
					onUncheckAll: function(rows) {
						flagck = 0;
					}  
				       
					}); 
				
			}
			
		function searchLessionDataGrid(){
			$('#dg').datagrid('load',icp.serializeObject($('#ordercofig_searchform')));
		};
		
		 	function statusformater(value,row,index)
		 {
		 
			switch (value) {
							case 2:
								return "<span style=\"color:green\">未通过</span>";
							case 1:
								return "<span style=\"color:green\">已审核</span>";
							case 0:
								return "<span style=\"color:red\">待审核</span>";
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
						<td>标题：<input class="easyui-textbox" name="lessionname"  id="lessionname" style="width:160px;height:30px;border:false"></td>
							<td>&nbsp;&nbsp;状态：<select class="easyui-combobox" name="lesstatus" id="lesstatus" data-options="panelHeight:'auto',required:true,editable:false" style="width:120px;height:30px;">
								<option value="3" selected>全部</option>
								<option value="1">已审核</option>
								<option value="0">待审核</option>
								<option value="2">未通过</option>
								</select>
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchLessionDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="$('#ordercofig_searchform input').val('');$('#lessionname').textbox('clear');$('#lesstatus').combobox('select','3');$('#dg').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="lessionsid">
		<table title="" style="width:100%;"  id="dg">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'lessionid',width:100,align:'center',sortable:true">编码</th>
				<th data-options="field:'lessiontitle',width:210,halign:'center'">标题</th>
				<th data-options="field:'publishtime',width:160,halign:'center',sortable:true">发表时间</th>
				<th data-options="field:'lessionintroduce',width:180,halign:'center'">内容简介</th>
				<th data-options="field:'lessioncontent',width:260,halign:'center'">课堂内容</th>
				<th data-options="field:'lessionauthor',width:70,halign:'center'">编辑人</th>
				<th data-options="field:'edittime',width:160,halign:'center',hidden:true">修改时间</th>
				<th data-options="field:'editperson',width:70,halign:'center',hidden:true">修改人</th>
				<th data-options="field:'lessionimage',width:100,halign:'center'">图片地址</th>
				<th data-options="field:'lessionfileurl',width:100,halign:'center',hidden:true">文件地址</th>
				<th data-options="field:'lessionstatus',width:80,align:'center',hidden:true,formatter:statusformater">标志</th>
				<th data-options="field:'checktime',width:160,halign:'center',hidden:true">审核时间</th>
				<th data-options="field:'delflg',width:80,align:'center',formatter:validformater">删除位</th>
			</tr>
	 </thead>
  </table>
 </div>  
</div>
		
	</div>
	<div id="tabs-2" title="技术问答" data-options="selected:true" style="padding:10px;background:#eee">
      <script type="text/javascript">
      	var flagck1 = 0;  //  初始化为0
      	
  	    var editor;
  		var gridqa;
		var toolbar = [{
			text:'增加',
			iconCls:'icon-add',
			handler:function()
			{
			 var dialog = parent.icp.modalDialog({
			 title : '添加技术问答',
			 url : '${pageContext.request.contextPath}/'+'web/businessMg/contentMg/qaForm.jsp',
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
				dialog.find('iframe').get(0).contentWindow.submitForm(dialog, gridqa, parent.$);
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
			iconCls:'icon-delete',
			handler:function()
			{
				var rows = $('#dg_qa').datagrid('getChecked');
				if(rows.length<1)
				{
					$.messager.alert('消息','请至少选择一条记录！'); 
					return; 
				}
				var qaid="";
				 $.each(rows,function(index,object){
				 	qaid+=object.qaid+",";
   				 });
   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/content/qaDel.do',
   				  		data:{qaids:qaid},
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg);  
				  			if(data.success)
					    	{
					    		$('#dg_qa').datagrid('unselectAll');
					    		$('#dg_qa').datagrid('reload',icp.serializeObject($('#qacofig_searchform')));
					    		
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
				var rows = $('#dg_qa').datagrid('getSelections');
				if(rows.length==1)
				{
				var dialog = parent.icp.modalDialog({
				title : '修改技术问答',
				url : '${pageContext.request.contextPath}/'+'web/businessMg/contentMg/qaForm.jsp?qaid=' + rows[0].qaid,
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
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog,gridqa,parent.$);
					}
					},{
					text : '取消',
					iconCls:'icon-cancel',
					handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
						dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
					}
					}]
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
   				  		url:'${pageContext.request.contextPath}/content/toQaHtml.do',
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg);  
				  			if(data.success)
					    	{
					    		$('#dg_qa').datagrid('unselectAll');
					    		$('#dg_qa').datagrid('reload',icp.serializeObject($('#qacofig_searchform')));
					    		
					    	} 
   				  		}
   				  	});
   				  }
   				 });
			
			}
		}];
		
		$(document).ready(function() {
			
			loadQaDataGrid();
			
		});
		function loadQaDataGrid()
			{
			 gridqa=$('#dg_qa').datagrid({
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
					idField:'qaid',
					autoRowHeight:false,
					nowrap:true,
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/content/QAList.do',
				    onLoadSuccess: function (data) {
				      var pageopt = $('#dg_qa').datagrid('getPager').data("pagination").options;
				      var  _pageSize = pageopt.pageSize;
				      var  _rows = $('#dg_qa').datagrid("getRows").length;
				      var total = pageopt.total; //显示的查询的总数
				      
				      if (_pageSize >= 10) {
				         for(i=10;i>_rows;i--){
				            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
				            $(this).datagrid('appendRow', {delflg:''  });
				         }
				         
				          $('#dg_qa').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
													if   (val.delflg==''&&val.delflg!='0'){  
														$('#qasid  input:checkbox').eq(idx+1).css("display","none");
														 
													}
												}); 
									      }
				      
				      
				 },
				 
				 //没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.delflg==''&&rowData.delflg!='0'){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck1=0;
					}
					//判断时候已经有全部选择
					if(flagck1==1){
					$('#qasid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck1 = 1;
							$.each(rows, function (idx, val) {
								if (val.delflg==''&&val.delflg!='0'){
									$("#dg_qa").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('#qasid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
								}
							});
					},
									
					onUncheckAll: function(rows) {
						flagck1 = 0;
					}   
				 
				  
					}); 
				
			}
			
		function searchQaDataGrid(){
			$('#dg_qa').datagrid('load',icp.serializeObject($('#qacofig_searchform')));
		};

		 	function statusqaformater(value,row,index)
		 {
		 
			switch (value) {
							case 2:
								return "<span style=\"color:green\">未通过</span>";
							case 1:
								return "<span style=\"color:green\">已审核</span>";
							case 0:
								return "<span style=\"color:red\">待审核</span>";
							}
		 }
		  	function validqaformater(value,row,index)
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
			<form id="qacofig_searchform">
				<table >
					<tr>
						<td>问题：<input class="easyui-textbox" name="questions"  id="questions" style="width:160px;height:30px;border:false"></td>
							<td>&nbsp;&nbsp;状态：<select class="easyui-combobox" name="status" id="status" data-options="panelHeight:'auto',required:true,editable:false" style="width:120px;height:30px;">
								<option value="3" selected>全部</option>
								<option value="1">已审核</option>
								<option value="0">待审核</option>
								<option value="2">未通过</option>
								</select>
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchQaDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="$('#qacofig_searchform input').val('');$('#questions').textbox('clear');$('#status').combobox('select','3');$('#dg_qa').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="qasid">
		<table title="" style="width:100%;" id="dg_qa">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'qaid',width:100,align:'center',sortable:true">编码</th>
				<th data-options="field:'question',width:210,halign:'center'">问题</th>
				<th data-options="field:'publishtime',width:130,halign:'center',sortable:true">发表时间</th>
				<th data-options="field:'answer',width:300,halign:'center'">答案</th>
				<th data-options="field:'publishperson',width:70,halign:'center'">发布人</th>
				<th data-options="field:'edittime',width:160, halign:'center',hidden:true">修改时间</th>
			    <th data-options="field:'editperson',width:70, halign:'center',hidden:true">修改人</th>
				<th data-options="field:'state',width:80,align:'center',hidden:true,formatter:statusqaformater">审核状态</th>
				<th data-options="field:'delflg',width:80,align:'center' ,formatter:validqaformater">删除位</th>				
				<th data-options="field:'checkperson',width:80,hidden:true,align:'center'">审核人</th>
				<th data-options="field:'checktime',width:130,hidden:true,halign:'center'">审核时间</th>
			</tr>
	 </thead>
  </table>
 </div>  
</div>
	
	</div>
	<div id="tabs-3" title="API文档" style="padding:10px;width:100%;height:100%;background:#eee">
	
			<script type="text/javascript">
			
		 var flagck2 = 0;  //  初始化为0
 
  	    var editor;
  		var gridapi;
		var toolbar = [{
			text:'增加',
			iconCls:'icon-add',
			handler:function()
			{
			 var dialog = parent.icp.modalDialog({
			 title : '添加API文档',
			 url : '${pageContext.request.contextPath}/'+'web/businessMg/contentMg/apiForm.jsp',
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
				dialog.find('iframe').get(0).contentWindow.submitForm(dialog, gridapi, parent.$);
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
			iconCls:'icon-delete',
			handler:function()
			{
				var rows = $('#dg_api').datagrid('getChecked');
				if(rows.length<1)
				{
					$.messager.alert('消息','请至少选择一条记录！'); 
					return; 
				}
				var apid="";
				 $.each(rows,function(index,object){
				 	apid+=object.id+",";
   				 });
   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/content/apiDel.do',
   				  		data:{apids:apid},
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg);  
				  			if(data.success)
					    	{
					    		$('#dg_api').datagrid('unselectAll');
					    		$('#dg_api').datagrid('reload',icp.serializeObject($('#apicofig_searchform')));
					    		
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
				var rows = $('#dg_api').datagrid('getSelections');
				if(rows.length==1)
				{
				var dialog = parent.icp.modalDialog({
				title : '修改API文档',
				url : '${pageContext.request.contextPath}/'+'web/businessMg/contentMg/apiForm.jsp?apid=' + rows[0].id,
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
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog,gridapi,parent.$);
					}
					},{
					text : '取消',
					iconCls:'icon-cancel',
					handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
						dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
					}
					}]
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
   				  		url:'${pageContext.request.contextPath}/content/toApiHtml.do',
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg);  
				  			if(data.success)
					    	{
					    		$('#dg_api').datagrid('unselectAll');
					    		$('#dg_api').datagrid('reload',icp.serializeObject($('#apicofig_searchform')));
					    		
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
			 gridapi=$('#dg_api').datagrid({
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
					idField:'id',
					autoRowHeight:false,
					nowrap:true,
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/content/apiList.do',
				    onLoadSuccess: function (data) {
				      var pageopt = $('#dg_api').datagrid('getPager').data("pagination").options;
				      var  _pageSize = pageopt.pageSize;
				      var  _rows = $('#dg_api').datagrid("getRows").length;
				      var total = pageopt.total; //显示的查询的总数
				      if (_pageSize >= 10) {
				         for(i=10;i>_rows;i--){
				            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
				            $(this).datagrid('appendRow', {delflg:''  });
				         }
				          $('#dg_api').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
													if   (val.delflg==''&&val.delflg!='0'){  
														$('#apiid  input:checkbox').eq(idx+1).css("display","none");
														 
													}
												}); 
									      }
				      
				      
				 },
				 
				 //没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.delflg==''&&rowData.delflg!='0'){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck2=0;
					}
					//判断时候已经有全部选择
					if(flagck2 ==1){
					$('#apiid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck2 = 1;
							$.each(rows, function (idx, val) {
								if (val.delflg==''&&val.delflg!='0'){
									$("#dg_api").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('#apiid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
								}
							});
					},
									
					onUncheckAll: function(rows) {
						flagck2 = 0;
					}  
				   
					}); 
				
			}
			
		function searchDataGrid(){
			$('#dg_api').datagrid('load',icp.serializeObject($('#apicofig_searchform')));
		};

		 	function statusformater(value,row,index)
		 {
		 
			switch (value) {
							case 2:
								return "<span style=\"color:green\">未通过</span>";
							case 1:
								return "<span style=\"color:green\">已审核</span>";
							case 0:
								return "<span style=\"color:red\">待审核</span>";
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
			<form id="apicofig_searchform">
				<table >
					<tr>
						<td>功能说明：<input class="easyui-textbox" name="functionshows"  id="functionshows" style="width:160px;height:30px;border:false"></td>
							<td>&nbsp;&nbsp;状态：<select class="easyui-combobox" name="apistatus" id="apistatus" data-options="panelHeight:'auto',required:true,editable:false" style="width:120px;height:30px;">
								<option value="3" selected>全部</option>
								<option value="1">已审核</option>
								<option value="0">待审核</option>
								<option value="2">未通过</option>
								</select>
								
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="$('#apicofig_searchform input').val('');$('#functionshows').textbox('clear');$('#apistatus').combobox('select','3');$('#dg_api').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="apiid">
		<table title="" style="width:100%;" id="dg_api">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'id',width:100,align:'center',sortable:true">编码</th>
				<th data-options="field:'typename',width:130,halign:'center'">API分类名称</th>
				<th data-options="field:'apifile',width:160,hidden:true, halign:'center'">文件地址</th>
				<th data-options="field:'interfacename',width:180,halign:'center'">接口名称</th>
				<th data-options="field:'functionshow',width:180,halign:'center'">功能说明</th>
				<th data-options="field:'publishtime',width:130,halign:'center',sortable:true">发表时间</th>
				<th data-options="field:'apicontent',width:210,hidden:true,halign:'center'">示例</th>
				<th data-options="field:'publishperson',width:70,halign:'center'">发布人</th>
				<th data-options="field:'edittime',width:160,hidden:true, halign:'center'">修改时间</th>
			    <th data-options="field:'editperson',width:70,hidden:true, halign:'center'">修改人</th>
				<th data-options="field:'state',width:80,align:'center',hidden:true,formatter:statusformater">审核状态</th>
				<th data-options="field:'delflg',width:80,align:'center' ,formatter:validformater">删除位</th>				
				<th data-options="field:'checkperson',width:80,hidden:true,align:'center'">审核人</th>
				<th data-options="field:'checktime',width:130,hidden:true,halign:'center'">审核时间</th>
			</tr>
	 </thead>
  </table>
 </div>  
</div>
</div>
</div>
		
</body>