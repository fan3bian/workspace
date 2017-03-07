<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>

<body>
	<style type="text/css">
.FieldInput2 {
	width: 77%;
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
	width: 23%;
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
			//loadOrgTree();
			//loadOrgTree(roleid);
		});
		
		function loadDataGrid() {
			$('#dg').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					sortName:'email',
					sortOrder:'asc',
					nowarp:false,
					singleSelect:true,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					idField:'email',
					pagination:true,
					pageSize:10,
					pageList:[10,20,30,40,50],
				    url:'${pageContext.request.contextPath}/authMgr/getAllAuthUser.do',  
				    onSelect : function(rowIndex, rowData) {
									loadOrgTable(rowData.email);
								},
								onLoadSuccess : function(data) {
									if(data.total!=0)
									{
										$(this).datagrid('selectRow', 0);
									}else
									{
										$('#authdataGrid').datagrid('loadData', { total: 0, rows: [] });
									}
									
								} 
					}); 
		
		}
		function searchDataGrid()
		{
			$('#dg').datagrid('clearSelections');
			$('#dg').datagrid('reload',icp.serializeObject($('#userauth_searchform')));
		}
		function loadOrgTable(email)
		{
				$('#authdataGrid').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					nowarp:false,
					singleSelect:true,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
				    url:'${pageContext.request.contextPath}/authMgr/getUserDataAuth.do?email='+email,  
				    onSelect : function(rowIndex, rowData) {
									//loadOrgTable(rowData.email);
								},
					onLoadSuccess : function(data) {
						loadComboData();
					},
					onClickCell:function(rowIndex, field, value)
					{
						if("operator"==field)
						{
							whereRemove(rowIndex);
						}
						
					}
					}); 
		}
		 function whereRemove(rowIndex)
		 {
		 		var all = $("#authdataGrid").datagrid("getRows").length;
		 	   if(rowIndex==0 && all>1)
		 	   {
		 		$('#authdataGrid').datagrid('updateRow',{index:1,row:{character:'',chartran:''}});
		 		
		 	   }
		 	   $('#authdataGrid').datagrid('deleteRow',rowIndex);  
		 }
		 
		function rowformater(value,row,index)
		 {var str = '';
		 str += '<img src=\"${pageContext.request.contextPath}/images/btndel.png\" title="删除"/>';
		 return str;
		 }
		 function loadComboData()
			{
			
			$('#chars').combobox({ 
				data: [{
					id: 'and',
					name: '并且'
				},{
					id: 'or',
					name: '或者'
				}],   
			    valueField:'id',    
			    textField:'name'  
			}); 
			$('#chars').combobox('setValue', 'and');

			$('#oper').combobox({ 
				data: [{
					id: '=',
					name: '等于'
				},{
					id: '!=',
					name: '不等于'
				},{
					id: 'in',
					name: '包含'
				},{
					id: 'not in',
					name: '不包含'
				}],   
			    valueField:'id',    
			    textField:'name'  
			});
			$('#oper').combobox('setValue', '=');
		$('#property').combobox({ 
				data: [{
					id: 'neid',
					name: '资源'
				},{
					id: 'poolid',
					name: '资源池'
				},{
					id: 'roomid',
					name: '机房'
				},{
					id: 'cityid',
					name: '地市'
				},{
					id: 'provid',
					name: '省'
				},{
					id: 'nodeid',
					name: '节点'
				},{
					id: 'Suserid',
					name: '子账户'
				},{
					id: 'Puserid',
					name: '父账户'
				},{
					id: 'roleid',
					name: '角色'
				}],
			    onChange: function (n, o) {
                   $('#value').textbox('setValue','');
                   $('#value').textbox('setText','');
                },   
			    valueField:'id',    
			    textField:'name'  
			});
				$('#property').combobox('setValue', 'Suserid'); 			
		}
		function showSelectWin()
		{
			 $('#condiSearch').textbox({onClickButton:function()
			 {
			 	$('#condiSearchTable').datagrid('clearChecked');
			 	$('#condiSearchTable').datagrid('reload',{
						condi: $('#property').combobox('getValue'),
						condiSearch: this.value
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
					pageSize:10,
					pageList:[10,20,30,40,50],
				    url:'${pageContext.request.contextPath}/authMgr/getCondiByCondi.do',
				    queryParams: {
						condi: $('#property').combobox('getValue'),
						condiSearch: $('#condiSearch').textbox('getValue')
					}
				    
					}); 
		}
		function submitSave()
		{
			var rows  = $('#condiSearchTable').datagrid('getSelections');
			if(rows.length==0)
			{
			$.messager.alert('消息','请至少选择一项！'); 
					return;
			}
			var opersv = $('#oper').combobox('getValue');
			if(opersv=="=" || opersv=="!=")
			{
				if(rows.length>1)
				{
					$.messager.alert('消息','运算符为等于或者不等于时，只能选择一项！'); 
					return;
				}
			}
			var values = "";
			var text = "";
			$.each(rows,function(index,object){
				 	values+="'"+object.id+"'"+",";
				 	text+=object.name+"\r\n";
   				 });
   			values=values.substring(0,values.length-1);
   			text=text.substring(0,text.length-2);
            $('#value').textbox('setText',text);	
            $('#valuehidden').val(values);
            $('#condiSearchTable').datagrid('clearChecked');
   			$('#condiSearch').textbox('setValue','');
            $('#condiSearch').textbox('setText','');
			$('#w').window('close');
		}
		function cancel()
		{
			$('#condiSearchTable').datagrid('clearChecked');
		    $('#condiSearch').textbox('setValue','');
            $('#condiSearch').textbox('setText','');
			$('#w').window('close');
		}
		function addToGrid()
		{
			var condisv = $('#valuehidden').val();
			var condist = $('#value').textbox('getText');
			if(""==condist)
			{
				$.messager.alert('消息','运算值不能为空！'); 
				return;
			}
			var length = $('#authdataGrid').datagrid('getRows');
			var character = "";
			var chartran = "";
			if(length!=0)
			{
				character = $('#chars').combobox('getValue');
				chartran = $('#chars').combobox('getText');
			}
			var condition  = "";
			var trans ="";
			var opersv = $('#oper').combobox('getValue');
			var operst = $('#oper').combobox('getText');
			
			condist = condist.replaceAll("\r\n",",");
			var property =  $('#property').combobox('getText');
			var connp="";
			var conno="";
			if(property.length==2)
			{
				connp = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			}else if(property.length==1)
			{
				connp="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			}else 
			{
				connp="&nbsp;&nbsp;";
			}
			if(operst.length==2)
			{
				conno="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			}else
			{
				conno="&nbsp;&nbsp;";
			}
			if(opersv=="not in" || opersv=="in")
			{
				condisv="("+condisv+")";
				condist = "("+condist+")";
			}	
			condition= $('#property').combobox('getValue')+' '+$('#oper').combobox('getValue')+' '+condisv;
			trans = property+connp+operst+conno+condist;
			$('#authdataGrid').datagrid('insertRow',{
					//index: length,	// 索引从0开始
					row: {
					character: character,
					chartran: chartran,
					condition: condition,
					trans:trans,
					operator:''
					}
			});
		}
		function condiSave()
		{
				$('#tableform').form('submit',{
		    		url:urlrootpath+'/authMgr/addorupdateAuthData.do', 
		   			onSubmit: function(){
		   				if($('#dg').datagrid('getSelected'))
		   				{
		   					$('#emailss').val($('#dg').datagrid('getSelected').email);
		   				}else
		   				{
		   					$.messager.alert('消息','请选择一个用户！'); 
				    		return false;
		   				}
		   				
		   				//alert($('#email').val());
				    	var rows = $('#authdataGrid').datagrid('getRows');
				    	if(rows<1)
				    	{
				    		$.messager.alert('消息','数据权限至少有一条！'); 
				    		return false;
				    	}
				    	var sql = "";
				    	$.each(rows,function(index,object){
				 				sql+=$.trim(object.character)+' '+object.condition+' ';
   				 		});
   				 		$('#wheresql').val(sql.substring(1,sql.length-1));
				    },
				    success:function(retr){
				    	var _data =  JSON.parse(retr); 
				    	$.messager.alert('消息',_data.msg);  
				    }
				});
		 
		}
		function norestrictions()
		{
			$('#authdataGrid').datagrid('loadData', { total: 0, rows: [] });
			$('#authdataGrid').datagrid('insertRow',{
					//index: length,	// 索引从0开始
					row: {
					character: '',
					chartran: '',
					condition: '1=1',
					trans:'不限制',
					operator:''
					}
			});
		}
	</script>
	<div class="easyui-layout" data-options="border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px; width:100%;height:93%">
		
			<div class="easyui-layout" data-options="region:'west',split:true,border:false" title=""
				style="width:34%;">
					<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
					<form id="userauth_searchform">
						<table class="tableForm datagrid-toolbar">
							<tr>
								<td>用户编码：<input class="easyui-textbox" name="email"  id="email" style="width:200px"></td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()"></a>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div data-options="region:'center',split:true,border:false" title=""
				style="">
				<table id="dg" title="" style="width:95%;"
					data-options="">
					<thead>
						<tr>
							<th data-options="field:'email',width:30,sortable:true">用户编码</th>
							<th data-options="field:'uname',width:30,align:'center'">用户名称</th>
						</tr>
					</thead>
				</table>
				</div>
			</div>
			<div class="easyui-layout" data-options="region:'center',split:true,border:false"
					style="width:60%;">
						<div data-options="region:'north',split:true,border:false" title="" style="padding:5px 5px 5px 5px;margin:10px 5px 10px 40px;width:100%;height:50%">
						<div style="height:10%">
						<a href="#" onClick="javascript:condiSave();"
							class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
						</div>
						<div style="height:10px"></div>
						<div style="height:90%">
						<form id="tableform" method="post">
							<input id="emailss" name="emailss" type="hidden" />
							<input id="wheresql" name="wheresql"  type="hidden" />
						<table id="authdataGrid" title="" style="width:95%;"
							data-options="">
							<thead>
								<tr>
									<th data-options="field:'character',hidden:true"></th>
									<th data-options="field:'chartran',width:20,align:'center'">运算符</th>
									<th data-options="field:'condition',hidden:true"></th>
									<th data-options="field:'trans',width:60">条件</th>
									<th data-options="field:'operator',width:20,align:'center',formatter:rowformater">操作</th>
								</tr>
							</thead>
						</table>
					</form>
						</div>
						
					</div>
					<div data-options="region:'center',split:true,border:false" title="" style="width:100%;height:50%">
						<div style="padding:5px 5px 5px 5px;margin:10px 5px 10px 40px;"><a href="#" onClick="javascript:addToGrid();"
							class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增</a> <a href="#" onClick="javascript:norestrictions();"
							class="easyui-linkbutton" data-options="iconCls:'icon-add'">不限制</a>
						</div>
						<div style="height:10px"></div>
						<table align="center" name="" style="width:80%">
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									运算符：</td>
								<td class="FieldInput2"><select class="easyui-combobox" id="chars" name="chars" style="height:25px;width:50%;"></select>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2">属性：</td>
								<td class="FieldInput2"><select style="height:25px;width:50%;" class="easyui-combobox" id="property"
									name="property">
								</select></td>
							</tr>
							<tr>
								<td class="FieldLabel2">操作符：</td>
								<td class="FieldInput2"><select style="height:25px;width:50%;" class="easyui-combobox" id="oper"
									name="oper">
								</select></td>
							</tr>
							<tr>
								<td class="FieldLabel2">值：</td>
								<td class="FieldInput2"><input class="easyui-textbox" id="value" name="value" data-options="multiline:true,readonly:true,editable:false" value="" style="width:50%;height:100px">
									<a href="#" onClick="javascript:showSelectWin();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
									<input type="hidden" id="valuehidden" value="">
								</td>
							</tr>
						</table>
					</div>
			</div>
			<div id="w" class="easyui-window" title="条件查询" data-options="closed:true,iconCls:'icon-save',inline:true" style="width:500px;height:500px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center'" style="padding:10px;">
					<table class="">
							<tr>
								<td><input id = "condiSearch" class="easyui-textbox" data-options="buttonIcon:'icon-search'" style="width:150px"> 
								</td>
							</tr>
					</table>
					<table id="condiSearchTable" title="" style="width:95%;" data-options="">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'id',hidden:true"></th>
							<th data-options="field:'name',width:30,align:'center'">名称</th>
						</tr>
					</thead>
				</table>
				</div>
				<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="submitSave();" style="width:80px">确定</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="cancel();" style="width:80px">取消</a>
				</div>
			</div>
		</div>		
	</div>
	
</body>