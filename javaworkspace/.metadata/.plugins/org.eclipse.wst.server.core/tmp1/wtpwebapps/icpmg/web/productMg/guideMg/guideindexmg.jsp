<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
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
		var toolbar = [
				{
					text : '增加',
					iconCls : 'icon-add',
					handler : function() { 
						$("#windowflag").val('1');
						$("#windowisvalid").val('1');
						$("#windowpid").val('');
						$("#windowpname").val('');
						$("#windowcolnum").val('');
						$("#windowimagefile").val('');
						$("#windowhtmlpage").val('');
						$("#windownotes").val('');
						$("#isvalidcheck").attr("checked",true);
						$("#ismodelcheck").attr("checked",false);
						$("#searchuser").show();
						$('#window').window('open');
					}
				},
				{
					text : '修改',
					iconCls : 'icon-modify',
					handler : function() {
						var rows = $('#dg').datagrid('getChecked');
						if(rows.length!=1)
						{
							$.messager.alert('消息','请选择一条记录！'); 
							return; 
						}
						
						//$("#windowstatus").val(rows[0].status);
						$("#windowflag").val('2');
						if(rows[0].isvalid==1)
						{
							$("#isvalidcheck").attr("checked",true);
							$("#windowisvalid").val('1');
						}else
						{
							$("#isvalidcheck").attr("checked",false);	
							$("#windowisvalid").val('0');
						}
						if(rows[0].ismodel==1)
						{
							$("#ismodelcheck").attr("checked",true);
							$("#windowismodel").val('1');
						}else
						{
							$("#ismodelcheck").attr("checked",false);	
							$("#windowismodel").val('0');
						}
						$("#searchuser").hide();
						$("#windowpid").val(rows[0].pid);
						$("#windowpname").val(rows[0].pname);
						$("#windowcolnum").val(rows[0].colnum);
						$("#windowimagefile").val(rows[0].imagefile);
						$("#windowhtmlpage").val(rows[0].htmlpage);
						$("#windownotes").val(rows[0].notes);
						$('#window').window('open');
					}
				},
				{
					text : '删除',
					iconCls : 'icon-remove',
					handler : function() {
							var rows = $('#dg').datagrid('getChecked');
							if(rows.length<1)
							{
								$.messager.alert('消息','请至少选择一条记录！'); 
								return; 
							}
							
							var pids = "";
							 $.each(rows,function(index,object){
							 	pids+="'"+object.pid+"',";
			   				 });
			   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/product/delGuideIndex.do',
			   				  		data:{pids:pids},
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#guideindex_searchform')));
								    		
								    	} 
			   				  		}
			   				  	});
			   				  }
			   				 });
						}
				},
				{
					text : '预览首页',
					iconCls : 'icon-ok',
					handler : function() {
							$.ajax({
								type : 'post',
								url : '${pageContext.request.contextPath}/product/toHomeTmpHtml.do',
								success : function(retr) {
									var data = JSON
											.parse(retr);
									$.messager
											.alert(
													'消息',
													data.msg);
									if (data.success) {
												window.open('${pageContext.request.contextPath}/'+data.obj , '_blank') ;
											}
										}
									});
							}
				},
				{
					text : '生成首页',
					iconCls : 'icon-reload',
					handler : function() {
						$.messager.confirm(
										'确认',
										'您确认想要生成HTML？原来文件将被覆盖',
										function(r) {
											if (r) {
												$.ajax({
															type : 'post',
															url : '${pageContext.request.contextPath}/product/toHomeHtml.do',
															success : function(retr) {
																var data = JSON.parse(retr);
																$.messager.alert('消息', data.msg);
															}
														});
											}
										});

					}
				} ];
		$(document).ready(function() {
			
			loadDataGrid();

		});
		function loadDataGrid() {
			$('#dg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'pid',
								sortOrder : 'asc',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								//idField : 'pid',
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbar,
								url : '${pageContext.request.contextPath}/product/guideIndexList.do'
							});

		}
			
			function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#guideindex_searchform')));
			};
			function isvalidformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:green\">在用</span>";
							case "0":
								return "<span style=\"color:red\">停用</span>";
							}
			} 
			function isNum(s) {
				var regu = "^([0-9]*)$";
				//var regu = "^([0-9]*[.0-9])$"; // 小数测试
				var re = new RegExp(regu);
				if (s.search(re) != -1)
				return true;
				else
				return false;
			}
			function submitSave()
			{
		 		$('#guideindexform').form('submit',{
			    url:'${pageContext.request.contextPath}/product/saveGuideIndex.do', 
			    onSubmit: function(){
			    	
			    	if($("#windowpid").attr("value")==null || $.trim($("#windowpid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"产品编码不能为空!");  
			    		return false;
			    	}
			    	
			    	if($("#windowcolnum").attr("value")==null || $.trim($("#windowcolnum").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"排序不能为空!");  
			    		return false;
			    	}
			    	if(!isNum($("#windowcolnum").attr("value")))
			    	{
			    		$.messager.alert('消息',"排序必须为数字!");  
			    		return false;
			    	}
			    	debugger;
			    	if($("#windowimagefile").val())
					{
						if($("#windowimagefiles").val())
						{
							var bizlic = $("#windowimagefiles").val();
							var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();
							if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
								$.messager.alert('消息', "请选择一张图片【jpg/jpeg/png/gif】！");
								return false;
							}
						}
					}
					else 
					{
						if(!$("#windowimagefiles").val())
						{
							$.messager.alert('消息',"请选择一张图片【jpg/jpeg/png/gif】！");  
			    			return false;
						}else
						{
							var bizlic = $("#windowimagefiles").val();
							var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();
							if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
								$.messager.alert('消息', "请选择一张图片【jpg/jpeg/png/gif】！");
								return false;
							}
						}
					}
												
			    	if($("#windowhtmlpage").attr("value")==null || $.trim($("#windowhtmlpage").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"对应页面不能为空!");  
			    		return false;
			    	}
			    	$("#windowisvalid").val($("#isvalidcheck").attr("checked")?1:0);
			    	$("#windowismodel").val($("#ismodelcheck").attr("checked")?1:0);
			    },
			    success:function(retr){
			    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
			    	var _data =  JSON.parse(retr); 
			    	//alert("success: "+_data.success);
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('load',
							icp.serializeObject($('#guideindex_searchform')));
						$('#window').window('close');
			    	}
			    }
			});
			}
			function showSelectWin()
			{
				 $('#condiSearch').textbox({onClickButton:function()
				 {
				 	$('#condiSearchTable').datagrid('clearChecked');
				 	$('#condiSearchTable').datagrid('reload',{
							pname: this.value
							});
				 }});
				 condiSearchTableLoad();
				 $('#w').window('open');
			}
			function condiSearchTableLoad()
		{
			$('#condiSearchTable').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					nowarp:false,
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					pagination:true,
					pageSize:5,
					pageList:[5,10,20,30,40,50],
				    url:'${pageContext.request.contextPath}/product/getProductAndMeal.do'
					}); 
		}
		function writeToInput()
		{
			var rows  = $('#condiSearchTable').datagrid('getSelections');
			if(rows.length!=1)
			{
			$.messager.alert('消息','请选择一项！'); 
					return;
			}
            $('#windowpid').val(rows[0].id);
            $('#windowpname').val(rows[0].name);
           
            if(rows[0].model==1)
			{
				$("#ismodelcheck").attr("checked",true);
				$("#windowismodel").val('1');
			}else
			{
				$("#ismodelcheck").attr("checked",false);	
				$("#windowismodel").val('0');
			}
            $('#condiSearchTable').datagrid('clearChecked');
   			$('#condiSearch').textbox('setValue','');
            $('#condiSearch').textbox('setText','');
			$('#w').window('close');
		}
		function modelformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:blue\">是</span>";
							case "0":
								return "<span style=\"color:blue\">否</span>";
						}
		}
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height:30px;overflow:hidden;">
			<form id="guideindex_searchform">
				<table>
					<tr>
						<td>套餐名称：<input class="easyui-textbox" name="pname"
							id="searchpname" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#guideindex_searchform input').val('');$('#searchpname').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
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
						<th data-options="field:'pid',width:60,align:'center'">产品编码</th>
						<th data-options="field:'pname',width:60,align:'center'">产品名称</th>
						<th data-options="field:'ismodel',width:60,align:'center',formatter:modelformater">复合类产品</th>
						<th data-options="field:'colnum',width:60,align:'center'">排序</th>
						<th data-options="field:'imagefile',width:60,align:'center'">导购图例</th>
						<th data-options="field:'isvalid',width:60,align:'center',formatter:isvalidformater">状态</th>
						<th data-options="field:'htmlpage',width:60,align:'center'">对应页面</th>
						<th data-options="field:'notes',width:60,align:'center'">导购摘要</th>
					
					</tr>
				</thead>
			</table>
		</div>
	</div>	
	<div id="window" class="easyui-window" title="导购" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:420px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="guideindexform" method="post" enctype="multipart/form-data" >
						<input id="windowflag" name="flag" type="hidden" value="0" />
						<input id="windowisvalid" name="isvalid"  type="hidden" />
						<input id="windowismodel" name="ismodel"  type="hidden" />
						<table align="center" style="width:100%">

							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									产品编码：</td>
								<td class="FieldInput2"><input id="windowpid" name="pid" style="height:30px;" readonly /><font color="red">*</font>
								<a href="#" id="searchuser" onClick="javascript:showSelectWin();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a></td>
							</tr>
							<tr>
								<td class="FieldLabel2">产品名称：</td>
								<td class="FieldInput2"><input id="windowpname" name="pname" style="height:30px" readonly /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">复合产品：</td>
								<td class="FieldInput2"><input id="ismodelcheck"
									type="checkbox" checked="checked" disabled /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">排序：</td>
								<td class="FieldInput2"><input id="windowcolnum" name="colnum" style="height:30px"/><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">是否有效：</td>
								<td class="FieldInput2"><input id="isvalidcheck"
									type="checkbox" checked="checked" /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">图片：</td>
								<td class="FieldInput2"><input id="windowimagefiles" type="file"
									style="height:25px" 
									name="imagefiles" /><font
									color="red">选择一个图片*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">图片路径：</td>
								<td class="FieldInput2"><input id="windowimagefile" style="height:25px" name="imagefile" readonly/></td>
							</tr>
							<tr>
								<td class="FieldLabel2">对应页面：</td>
								<td class="FieldInput2"><input id="windowhtmlpage" style="height:25px" name="htmlpage"/><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									导购摘要：</td>
								<td class="FieldInput2"><input id="windownotes"
									style="height:75px;width: 260px" name="notes"
									data-options="multiline:true" /></td>

							</tr>
						</table>
					</form>
				</div>
				<div data-options="region:'south',border:false"
					style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
						id="saveBtn" href="javascript:void(0)" onclick="submitSave();"
						style="width:80px">确定</a> <a class="easyui-linkbutton"
						data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
						onclick="$('#window').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
		<div id="w" class="easyui-window" title="条件查询" data-options="closed:true,iconCls:'icon-save',inline:true" style="width:500px;height:250px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center'" style="padding:10px;">
					<table class="">
							<tr>
								<td><input id ="condiSearch" class="easyui-textbox" data-options="buttonIcon:'icon-search'" style="width:150px"> 
								</td>
							</tr>
					</table>
					<table id="condiSearchTable" title="" style="width:95%;" data-options="">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'id',width:30,align:'center'">产品编码</th>
							<th data-options="field:'name',width:30,align:'center'">产品名称</th>
							<th data-options="field:'model',width:30,align:'center',formatter:modelformater">复合产品</th>
						</tr>
					</thead>
				</table>
				</div>
				<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="writeToInput();" style="width:80px">确定</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#condiSearch').textbox('setValue','');$('#condiSearch').textbox('setText','');$('#w').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
</body>

