<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
<style type="text/css">
.customer-product-close {
  position: absolute;
  top: 50%;
  margin-top: -8px;
  height: 16px;
  overflow: hidden;
  background: url('${pageContext.request.contextPath}/easyui-1.4/themes/default/images/panel_tools.png') no-repeat -16px 0px;
}
.FieldInput2 {
	width: 31%;
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
	width: 19%;
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
					text : '新增',
					iconCls : 'icon-add',
					handler : function() { 
						$("#windowaddrecordstatus").val('');
						$("#windowaddequipid").val('');
						$("#windowaddcabinetcode").val('');
						$("#windowaddlowlocation").val('');
						$("#windowaddhighlocation").val('');
						
						$("#windowaddcabinetcode").removeAttr("readonly");
						$("#windowaddlowlocation").removeAttr("readonly");
						$("#windowaddhighlocation").removeAttr("readonly");

						$("#windowaddomodel").val('');
						$("#windowaddequiroom").val('龙奥云中心');
						$("#windowaddequiunit").val('');
						$("#windowaddequiprev").val('');
						$("#windowaddequichase").val('');
						$("#windowaddequiconfig").textbox('clear');
						$("#windowaddequielectric").textbox('clear');
						$("#windowaddequiremark").textbox('clear');
						$("#windowaddnetworktype").combobox('select','外网');
						$("#windowaddequistatus").combobox('select','2');
						var equitype = $('#windowaddequitype').combobox('getData');
 						$("#windowaddequitype").combobox('select',equitype[0].id);
 						var vendor = $('#windowaddequivendor').combobox('getData');
 						$("#windowaddequivendor").combobox('select',vendor[0].id);
 						$("#windowaddrecordmark").textbox('clear');
 						
						//$('#searchequistatus').combobox('select','-1');
						$('#windowadd').window('open');
					}
				},
				{
					text : '变更',
					iconCls : 'icon-modify',
					handler : function() {
						debugger;
						var rows = $('#dg').datagrid('getChecked');
						if(rows.length!=1)
						{
							$.messager.alert('消息','请选择一条记录！'); 
							return; 
						}
						if(rows[0].equistatus==4)
						{
							$.messager.alert('消息','该设备已下架！'); 
							return; 
						}
						if(rows[0].equistatus==3)
						{
							$("#windowaddrecordstatus").val("4");
						}else
						{
							$("#windowaddrecordstatus").val("2");
						}
						$("#windowaddequipid").val(rows[0].equipid);
						
						$("#windowaddcabinetcode").val(rows[0].cabinetcode);
						$("#windowaddlowlocation").val(rows[0].lowlocation);
						$("#windowaddhighlocation").val(rows[0].highlocation);
						
						$("#windowaddcabinetcode").attr("readonly","readonly");
						if(rows[0].lowlocation)
						{
							$("#windowaddlowlocation").attr("readonly","readonly");
							$("#windowaddhighlocation").attr("readonly","readonly");
						}
						$("#windowaddomodel").val(rows[0].omodel);
						$("#windowaddequiroom").val(rows[0].equiroom);
						$("#windowaddequiunit").val(rows[0].equiunit);
						$("#windowaddequiprev").val(rows[0].equiprev);
						$("#windowaddequichase").val(rows[0].equichase);
						//$("#windowaddequiconfig").val(rows[0].equiconfig);
						$("#windowaddequiconfig").textbox('setText',rows[0].equiconfig);
						$("#windowaddequielectric").textbox('setText',rows[0].equielectric);
						//$("#windowaddequielectric").val(rows[0].equielectric);
						$("#windowaddequiremark").textbox('setText',rows[0].equiremark);
						//$("#windowaddequiremark").val(rows[0].equiremark);
						$("#windowaddnetworktype").combobox('select',rows[0].networktype);
						$("#windowaddequistatus").combobox('select',rows[0].equistatus);
 						$("#windowaddequitype").combobox('select',rows[0].equitype);
 						$("#windowaddequivendor").combobox('select',rows[0].equivendor);
 						$("#windowaddrecordmark").textbox('clear');
						//$('#searchequistatus').combobox('select','-1');
						$('#windowadd').window('open');
					}
				},
				{
					text : '移柜',
					iconCls : 'icon-move',
					handler : function() {
							$('#windowmoveform input').val('');
							$('#windowmovenotes').textbox('clear');
							$('#windowmove').window('open');
					}
				},
				{
					text : '移机',
					iconCls : 'icon-moveto',
					handler : function() {
							var rows = $('#dg').datagrid('getChecked');
							if(rows.length!=1)
							{
								$.messager.alert('消息','请选择一条记录！'); 
								return; 
							}
							if(rows[0].equistatus==4)
							{
								$.messager.alert('消息','该设备已下架！'); 
								return; 
							}
							$('#windowmovetoform input').val('');
							$("#windowmovetoequipid").val(rows[0].equipid);
							$("#windowmovetofromcabinetcode").val(rows[0].cabinetcode);
							$("#windowmovetofromlowlocation").val(rows[0].lowlocation);
							$("#windowmovetofromhighlocation").val(rows[0].highlocation);
							$("#windowaddequiunit").val(rows[0].equiunit);
							//$('#windowmovetoform input').val('');
							$('#windowmovetonotes').textbox('clear');
							$('#windowmoveto').window('open');
					}
				},
				{
					text : '撤出',
					iconCls : 'icon-remove',
					handler : function() {
							var rows = $('#dg').datagrid('getChecked');
							if(rows.length<1)
							{
								$.messager.alert('消息','请至少选择一条记录！'); 
								return; 
							}
							$("#windowdelnotes").textbox('clear');
							$('#windowdel').window('open');
						}
				},
				{
					text : '全部维护记录',
					iconCls : 'icon-all',
					handler : function() {
							reviewRecord('');
						}
				}];
		$(document).ready(function() {
			
			loadDataGrid();
			loadComboData();
		});
		function loadComboData()
		{
			$('#searchequistatus').combobox({ 
				data: [{
					id: '-1',
					name: '请选择'
				},{
					id: '1',
					name: '未通电'
				},{
					id: '2',
					name: '正常'
				},{
					id: '3',
					name: '返修'
				},{
					id: '4',
					name: '下架'
				}],   
			    valueField:'id',    
			    textField:'name'
			}); 
			
			$("#searchequistatus").combobox('select','-1');
			$('#windowaddnetworktype').combobox({ 
				data: [{
					id: '外网',
					name: '外网',
				},{
					id: '内网',
					name: '内网'
				}],   
			    valueField:'id', 
			    textField:'name'
			}); 
			$('#windowaddnetworktype').combobox({ 
				data: [{
					id: '外网',
					name: '外网',
				},{
					id: '内网',
					name: '内网'
				}],   
			    valueField:'id', 
			    textField:'name'
			}); 
			 $('#windowaddequiname').combobox({
                    valueField: 'id',
                    textField: 'name'
             });
			$('#windowaddequitype').combobox({    
			    url:'${pageContext.request.contextPath}/asset/getEquipType.do',    
			    valueField:'id',    
			    textField:'name',
			   	onSelect: function (record) {
			   		$.ajax({  
					    url:'${pageContext.request.contextPath}/asset/getEquipName.do',  
					    type:'post',  
					    async: false,  
					    dataType:'json', 
					    data:{id:record.id},
					    success:function(data){ 
					    	
					   		$('#windowaddequiname').combobox('loadData',data);
					   		 var data = $('#windowaddequiname').combobox('getData');
 							$("#windowaddequiname").combobox('select',data[0].id);
					    } 
					});
			   		//$('#windowaddequiname').combobox('reload', '${pageContext.request.contextPath}/asset/getEquipName.do?id=' + record.id);
                   // var data = $('#windowaddequiname').combobox('getData');
 					//$("#windowaddequiname").combobox('select',data[0].id);
                }  
			});
			$('#windowaddequistatus').combobox({ 
				data: [{
					id: '1',
					name: '未通电'
				},{
					id: '2',
					name: '正常'
				},{
					id: '3',
					name: '返修'
				}],   
			    valueField:'id',    
			    textField:'name'
			});  
			$('#windowaddequivendor').combobox({    
			    url:'${pageContext.request.contextPath}/asset/getEquipVendor.do',    
			    valueField:'id',    
			    textField:'name',
			});
			
			$('#viewprevtype').combobox({ 
				data: [{
					id: '-1',
					name: '请选择'
				},{
					id: '1',
					name: '新增'
				},{
					id: '2',
					name: '变更'
				},{
					id: '3',
					name: '移柜'
				},{
					id: '4',
					name: '返修'
				},{
					id: '5',
					name: '撤出'
				},{
					id: '6',
					name: '修改'
				}],   
			    valueField:'id',    
			    textField:'name'
			}); 
		}
		function loadDataGrid() {
			$('#dg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'cabinetcode',
								sortOrder : '',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								//idField : 'pid',
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbar,
								url : '${pageContext.request.contextPath}/asset/equipManageList.do'
							});

		}
			function isNum(s) {
				var regu = "^[0-9]*$";
				//var regu = "^([0-9]*[.0-9])$"; // 小数测试
				var re = new RegExp(regu);
				if (s.search(re) != -1)
					return true;
				else
					return false;
			}
			function searchDataGrid() {
				
				if($('#searchlowlocation').val())
				{
					if(!$('#searchcabinetcode').val())
					{
						$.messager.alert('消息',"请填写机柜号！");  
			    		return false ;
					}else
					{
						if(!isNum($('#searchlowlocation').val()))
						{
							$.messager.alert('消息',"上架U位号必须为数字！");  
			    		return false;
						}
					}
				}
				$('#dg').datagrid('load',
					icp.serializeObject($('#equip_searchform')));
			};
			function recordDataGrid()
			{
				
				$('#recorddg').datagrid('load',
					icp.serializeObject($('#record_searchform')));
			}
			function isstatusformater(value, row, index) {
				switch (value) {
						case "1":
							return "<span style=\"color:gray\">未通电</span>";
						case "2":
							return "<span style=\"color:green\">正常</span>";
						case "3":
							return "<span style=\"color:red\">返修</span>";
						case "4":
							return "<span style=\"color:yellow\">下架</span>";
						}
			} 
			function istypeformater(value, row, index) {
				switch (value) {
						case "1":
							return "<span style=\"color:blue\">新增</span>";
						case "2":
							return "<span style=\"color:blue\">变更</span>";
						case "3":
							return "<span style=\"color:blue\">移柜</span>";
						case "4":
							return "<span style=\"color:blue\">返修</span>";
						case "5":
							return "<span style=\"color:blue\">撤出</span>";
						case "6":
							return "<span style=\"color:blue\">修改</span>";
						}
			} 
			function isrecordformater(value, row, index) {
				
				return "<a style=\"color:blue;cursor:pointer\" onclick=\"reviewRecord('"+ value + "');\">查看</a>";
			} 
			
			function reviewRecord(value)
			{
				$("#viewequipid").val(value);
				$("#viewprevtype").combobox('select','-1');
				$('#recorddg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'recordid',
								sortOrder : '',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								//idField : 'pid',
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								//toolbar : toolbar,
								queryParams: {
									equipid: value,
								},
								url : '${pageContext.request.contextPath}/asset/equipRecordList.do'
					});
					$('#windowview').window('open');
			}
			function submitSave()
			{
		 		$('#equipaddform').form('submit',{
			    url:'${pageContext.request.contextPath}/asset/saveEquipment.do', 
			    onSubmit: function(){
			    	
			    	if($("#windowaddcabinetcode").attr("value")==null || $.trim($("#windowaddcabinetcode").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"机柜号不能为空!");  
			    		return false;
			    	}
			    	if($("#windowaddlowlocation").attr("value")==null || $.trim($("#windowaddlowlocation").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"上架U位不能为空!");  
			    		return false;
			    	}debugger;
			    	if(!isNum($('#windowaddlowlocation').val()))
						{
							$.messager.alert('消息',"上架U位必须为数字！");  
			    		return false;
					}
					if($("#windowaddhighlocation").attr("value")==null || $.trim($("#windowaddhighlocation").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"设备高度不能为空!");  
			    		return false;
			    	}
			    	if(!isNum($('#windowaddhighlocation').val()))
						{
							$.messager.alert('消息',"设备高度必须为数字！");  
			    		return false;
					}
			    	if($("#windowaddomodel").attr("value")==null || $.trim($("#windowaddomodel").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"设备型号不能为空!");  
			    		return false;
			    	}
			    	if($("#windowaddequiunit").attr("value")==null || $.trim($("#windowaddequiunit").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"所属单位不能为空!");  
			    		return false;
			    	}
			    	if(	$("#windowaddrecordstatus").val()=='2')
						{
							if($("#windowaddequistatus").combobox('getValue')=='3')
							{
								$("#windowaddrecordstatus").val("4");
							}
						
						}else if($("#windowaddrecordstatus").val()=='')
						{
							$("#windowaddrecordstatus").val("1");
						}
			    },
			    success:function(retr){
			    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
			    	var _data =  JSON.parse(retr); 
			    	//alert("success: "+_data.success);
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('load',
						icp.serializeObject($('#equip_searchform')));
						$('#windowadd').window('close');
			    	}
			    }
			});
			}
			function submitDel()
			{
				var rows = $('#dg').datagrid('getChecked');
							if(rows.length<1)
							{
								$.messager.alert('消息','请至少选择一条记录！'); 
								return; 
							}
							var equipids = "";
							var low = "";
							var high = "";
							var conbinet = "";
							var notes = $("#windowdelnotes").val();
							var flag =false;
							 $.each(rows,function(index,object){
							 	if(object.equistatus==4)
								{
									flag =true;
									return false;
								}
							 	equipids+="'"+object.equipid+"',";
							 	conbinet+=object.cabinetcode+",";
							 	low+=object.lowlocation+",";
							 	high+=object.highlocation+",";
			   				 });
			   				 if(flag)
			   				 {
			   				 	$.messager.alert('消息','选择项中存在已下架设备！'); 
								return; 
			   				 }
			   				 $.messager.confirm('确认','您确认想要撤出选中设备吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/asset/delEquipment.do',
			   				  		data:{equipids:equipids,conbinet:conbinet,low:low,high:high,notes:notes},
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#equip_searchform')));
								    		$('#windowdel').window('close');
								    	} 
			   				  		}
			   				  	});
			   				  }
			   			 });
			}
			function submitMove()
			{
				 	$.messager.confirm('确认','您确认想要移柜吗？',function(r){   
			   				  if (r){ 
			   				  	$('#windowmoveform').form('submit',{
								    url:'${pageContext.request.contextPath}/asset/moveEquipment.do', 
								    onSubmit: function(){
								    	
								    	if($("#windowmovefromcabinetcode").attr("value")==null || $.trim($("#windowmovefromcabinetcode").attr("value"))==""||$("#windowmovetocabinetcode").attr("value")==null || $.trim($("#windowmovetocabinetcode").attr("value"))==""  )
								    	{
								    		$.messager.alert('消息',"机柜号不能为空!");  
								    		return false;
								    	}
								    },
								    success:function(retr){
								    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
								    	var _data =  JSON.parse(retr); 
								    	//alert("success: "+_data.success);
								    	$.messager.alert('消息',_data.msg);  
										if(_data.success){
											$('#dg').datagrid('load',
											icp.serializeObject($('#equip_searchform')));
											$('#windowmove').window('close');
								    	}
								    }
								});
			   				  }
			   			 });
			}
				function submitMoveTo()
			{
				 	$.messager.confirm('确认','您确认想要移机吗？',function(r){   
			   				  if (r){ 
			   				  		$('#windowmovetoform').form('submit',{
								    url:'${pageContext.request.contextPath}/asset/moveEquipmentTo.do', 
								    onSubmit: function(){
								    	
								    	if($("#windowmovetofromcabinetcode").attr("value")==null || $.trim($("#windowmovetofromcabinetcode").attr("value"))==""||$("#windowmovetotocabinetcode").attr("value")==null || $.trim($("#windowmovetotocabinetcode").attr("value"))==""  )
								    	{
								    		$.messager.alert('消息',"机柜号不能为空!");  
								    		return false;
								    	}
								    	if($("#windowmovetotohighlocation").attr("value")==null || $.trim($("#windowmovetotohighlocation").attr("value"))==""
								    	||$("#windowmovetotolowlocation").attr("value")==null || $.trim($("#windowmovetotolowlocation").attr("value"))=="")
								    	{
								    		$.messager.alert('消息',"上架U位或者设备高度不能为空!");  
								    		return false;
								    	}
								    	if(!isNum($('#windowmovetotohighlocation').val())&&!isNum($('#windowmovetotolowlocation').val()))
											{
												$.messager.alert('消息',"上架U位或者设备高度必须为数字！");  
								    		return false;
										}
								    },
								    success:function(retr){
								    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
								    	var _data =  JSON.parse(retr); 
								    	//alert("success: "+_data.success);
								    	$.messager.alert('消息',_data.msg);  
										if(_data.success){
											$('#dg').datagrid('load',
											icp.serializeObject($('#equip_searchform')));
											$('#windowmoveto').window('close');
								    	}
								    }
								});
			   				  }
			   			 });
			}
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height:30px;overflow:hidden;">
			<form id="equip_searchform">
				<table>
					<tr>
						<td>机柜号：<input class="easyui-textbox" name="cabinetcode"
							id="searchcabinetcode" style="width:160px;height:30px;border:false"></td>
						<td>U位：<input class="easyui-textbox" name="lowlocation"
							id="searchlowlocation" style="width:160px;height:30px;border:false"></td>
						<td>设备状态：<input id="searchequistatus" name="equistatus" style="height:30px" /></td>
						<td>设备名称：<input class="easyui-textbox" name="equiname"
							id="searchequiname" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#equip_searchform input').val('');$('#searchequistatus').combobox('select','-1');$('#dg').datagrid('load',{});">重置</a>
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
						<th data-options="field:'cabinetcode',width:30,align:'center'">机柜号</th>
						<th data-options="field:'lowlocation',width:40,align:'center'">上架U位</th>
						<th data-options="field:'highlocation',width:40,align:'center'">设备高度（U）</th>
						<th data-options="field:'equiname',width:60,align:'center'">设备名称</th>
						<th data-options="field:'omodel',width:60,align:'center'">设备型号</th>
						<th data-options="field:'equitype',width:40,align:'center'">设备类型</th>
						<th data-options="field:'equivendor',width:20,align:'center'">厂家</th>
						<th data-options="field:'networktype',width:25,align:'center'">网络类型</th>
						<th data-options="field:'equiunit',width:65,align:'center'">所属单位</th>
						<th data-options="field:'equistatus',width:20,align:'center',formatter:isstatusformater">状态</th>
						<th data-options="field:'equiremark',width:80,align:'center'">备注</th>
						<th data-options="field:'equipid',width:25,align:'center',formatter:isrecordformater">维护记录</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	
	<div id="windowadd" class="easyui-window" title="设备" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:800px;height:500px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="equipaddform" method="post" enctype="multipart/form-data">
						<input id="windowaddequipid" name="equipid" type="hidden" />
						<input id="windowaddrecordstatus" name="recordstatus" type="hidden" />
						<table align="center" style="width:100%">
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									机柜号：</td>
								<td class="FieldInput2"><input id="windowaddcabinetcode" name="cabinetcode" style="height:30px;"/><font color="red">*</font>
								</td>
								<td class="FieldLabel2"></td>
								<td class="FieldInput2"></td>
							</tr>
							<tr>
								<td class="FieldLabel2">上架U位：</td>
								<td class="FieldInput2"><input id="windowaddlowlocation" name="lowlocation" style="height:30px" />U<font color="red">*</font></td>
								<td class="FieldLabel2">设备高度（U）：</td>
								<td class="FieldInput2"><input id="windowaddhighlocation" name="highlocation" style="height:30px" />U<font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">设备类型：</td>
								<td class="FieldInput2"><input id="windowaddequitype" name="equitype" style="height:30px" /><font color="red">*</font></td>
								<td class="FieldLabel2">设备名称：</td>
								<td class="FieldInput2"><input id="windowaddequiname" name="equiname" style="height:30px" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">设备厂家：</td>
								<td class="FieldInput2"><input id="windowaddequivendor" name="equivendor" style="height:30px" /><font color="red">*</font></td>
								<td class="FieldLabel2">设备型号：</td>
								<td class="FieldInput2"><input id="windowaddomodel" name="omodel" style="height:30px" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">网络类型：</td>
								<td class="FieldInput2"><input id="windowaddnetworktype" name="networktype" style="height:30px" /></td>
								<td class="FieldLabel2">所属机房：</td>
								<td class="FieldInput2"><input id="windowaddequiroom" name="equiroom" style="height:30px" value="龙奥云中心" /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">所属单位：</td>
								<td class="FieldInput2"><input id="windowaddequiunit" name="equiunit" style="height:30px;width:230px" /><font color="red">*</font></td>
								<td class="FieldLabel2">维护单位：</td>
								<td class="FieldInput2"><input id="windowaddequiprev" name="equiprev" style="height:30px;width:230px" /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">设备状态：</td>
								<td class="FieldInput2"><input id="windowaddequistatus" name="equistatus" style="height:30px" /></td>
								<td class="FieldLabel2">采购时间：</td>
								<td class="FieldInput2"><input id="windowaddequichase" class="easyui-datebox" name="equichase" style="height:30px" /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">设备配置：</td>
								<td class="FieldInput2"><input id="windowaddequiconfig"
									style="height:75px;width: 260px" name="equiconfig" class="easyui-textbox" data-options="multiline:true" /></td>
								<td class="FieldLabel2">电源配置：</td>
								<td class="FieldInput2"><input id="windowaddequielectric"
									style="height:75px;width: 260px" name="equielectric" class="easyui-textbox" data-options="multiline:true" />
							</tr>
							
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									备注：</td>
								<td class="FieldInput2"><input id="windowaddequiremark"
									style="height:75px;width: 260px" name="equiremark"
									class="easyui-textbox"
									data-options="multiline:true" /></td>
								<td class="FieldLabel2" style="border-top:!important;">
									变更记录：</td>
								<td class="FieldInput2"><input id="windowaddrecordmark"
									style="height:75px;width: 260px" name="notes"
									class="easyui-textbox"
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
						onclick="$('#windowadd').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
		<div id="windowdel" class="easyui-window" title="下架" data-options="closed:true,iconCls:'icon-save',inline:true"
				style="width:500px;height:220px;padding:5px;">
				<div class="easyui-panel" data-options="fit:true,border:false">
						<form id="windowdelform" method="post" enctype="multipart/form-data">
							<table align="center" style="width:100%">
								<tr>
									<td class="FieldLabel2" style="border-top:!important;">
										备注：</td>
									<td class="FieldInput2"><input id="windowdelnotes"
										style="height:125px;width: 260px" name="notes"
										class="easyui-textbox"
										data-options="multiline:true" /></td>
								</tr>
							</table>
						</form>
						<div data-options="region:'south',border:false"
							style="text-align:right;padding:5px 0 0;">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
								id="saveBtn" href="javascript:void(0)" onclick="submitDel();"
								style="width:80px">确定</a> <a class="easyui-linkbutton"
								data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
								onclick="$('#windowdelnotes').textbox('clear');$('#windowdel').window('close');" style="width:80px">取消</a>
						</div>
			</div>
		</div>
		<div id="windowview" class="easyui-window" title="维护记录" data-options="closed:true,iconCls:'icon-save',inline:true"
				style="width:800px;height:500px;padding:5px;">
				<div class="easyui-layout" data-options="fit:true,border:false">
						<div data-options="region:'north',border:false"
							style="height:30px;overflow:hidden;">
							<form id="record_searchform">
								<input id="viewequipid" name="equipid" type="hidden" />	
								<table>
									<tr>
										<td>维护人：<input class="easyui-textbox" name="prevperson"
											id="viewprevperson" style="width:160px;height:30px;border:false"></td>
										<td>维护方式：<input id="viewprevtype" name="prevtype" style="height:30px" /></td>
										<td>&nbsp;&nbsp;<a href="javascript:void(0);"
											class="easyui-linkbutton" data-options="iconCls:'icon-search'"
											onclick="recordDataGrid()">查询</a>&nbsp;&nbsp; <a
											href="javascript:void(0);" class="easyui-linkbutton"
											data-options="iconCls:'icon-redo'"
											onclick="$('#viewprevperson').val('');$('#viewprevtype').combobox('select','-1');$('#recorddg').datagrid('load',icp.serializeObject($('#record_searchform')));">重置</a>
										</td>
									</tr>
								</table>
							</form>
						</div>
						<div data-options="region:'center',border:false">
							<table title="" style="width:100%;" id="recorddg">
								<thead>
									<tr>
										<th data-options="field:'ck',checkbox:true"></th>
										<th data-options="field:'cabinetcode',width:30,align:'center'">机柜号</th>
										<th data-options="field:'lowlocation',width:40,align:'center'">上架U位</th>
										<th data-options="field:'highlocation',width:40,align:'center'">设备高度（U）</th>
										<th data-options="field:'prevperson',width:40,align:'center'">维护人</th>
										<th data-options="field:'prevtype',width:30,align:'center',formatter:istypeformater">维护类型</th>
										<th data-options="field:'prevtime',width:50,align:'center'">维护时间</th>
										<th data-options="field:'ramark',width:80,align:'center'">备注</th>
									</tr>
								</thead>
							</table>
						</div>
			</div>
		</div>
		<div id="windowmove" class="easyui-window" title="移柜" data-options="closed:true,iconCls:'icon-save',inline:true"
				style="width:400px;height:280px;padding:5px;">
				<div class="easyui-panel" data-options="fit:true,border:false">
						<form id="windowmoveform" method="post" enctype="multipart/form-data">
							<table align="center" style="width:100%">
									<tr>
										<td class="FieldLabel2" style="border-top:!important;">
											机柜  从：</td>
										<td class="FieldInput2"><input id="windowmovefromcabinetcode" name="fromcabinetcode" style="height:30px;"/><font color="red">*</font>
										</td>
									</tr>
									<tr>
									<td class="FieldLabel2" style="border-top:!important;">
											  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;到：</td>
										<td class="FieldInput2"><input id="windowmovetocabinetcode" name="tocabinetcode" style="height:30px;"/><font color="red">*</font>
										</td>
									</tr>
								<tr>
									<td class="FieldLabel2" style="border-top:!important;">
										备注：</td>
									<td class="FieldInput2"><input id="windowmovenotes"
										style="height:125px;width: 260px" name="notes"
										class="easyui-textbox"
										data-options="multiline:true" /></td>
								</tr>
							</table>
						</form>
						<div data-options="region:'south',border:false"
							style="text-align:right;padding:5px 0 0;">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
								id="saveBtn" href="javascript:void(0)" onclick="submitMove();"
								style="width:80px">确定</a> <a class="easyui-linkbutton"
								data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
								onclick="$('#windowmoveform input').val('');$('#windowmovenotes').textbox('clear');$('#windowmove').window('close');" style="width:80px">取消</a>
						</div>
			</div>
		</div>
		<div id="windowmoveto" class="easyui-window" title="移机" data-options="closed:true,iconCls:'icon-save',inline:true"
				style="width:680px;height:320px;padding:5px;">
				<div class="easyui-panel" data-options="fit:true,border:false">
						<form id="windowmovetoform" method="post" enctype="multipart/form-data">
							<input id="windowmovetoequipid" name="equipid" type="hidden" />
							<table align="center" style="width:100%">
									<tr>
										<td class="FieldLabel2" style="border-top:!important;">
											机柜 从：</td>
										<td class="FieldInput2"><input id="windowmovetofromcabinetcode" name="fromcabinetcode" style="height:30px;" readonly/><font color="red">*</font>
										</td>
										<td class="FieldLabel2" style="border-top:!important;">
											到：</td>
										<td class="FieldInput2"><input id="windowmovetotocabinetcode" name="tocabinetcode" style="height:30px;"/><font color="red">*</font>
										</td>
									</tr>
									<tr>
										<td class="FieldLabel2" style="border-top:!important;">
											上架U位 从：</td>
										<td class="FieldInput2"><input id="windowmovetofromlowlocation" name="fromlowlocation" style="height:30px;" readonly /><font color="red">*</font>
										</td>
										<td class="FieldLabel2" style="border-top:!important;">
											到：</td>
										<td class="FieldInput2"><input id="windowmovetotolowlocation" name="tolowlocation" style="height:30px;"/><font color="red">*</font>
										</td>
									</tr>
									<tr>
										<td class="FieldLabel2" style="border-top:!important;">
											设备高度（U） 从：</td>
										<td class="FieldInput2"><input id="windowmovetofromhighlocation" name="fromhighlocation" style="height:30px;" readonly /><font color="red">*</font>
										</td>
										<td class="FieldLabel2" style="border-top:!important;">
											到：</td>
										<td class="FieldInput2"><input id="windowmovetotohighlocation" name="tohighlocation" style="height:30px;"/><font color="red">*</font>
										</td>
									</tr>
								<tr>
									<td class="FieldLabel2" style="border-top:!important;">
										备注：</td>
									<td class="FieldInput2" colspan=3 ><input id="windowmovetonotes"
										style="height:125px;width: 260px" name="notes"
										class="easyui-textbox"
										data-options="multiline:true" /></td>
								</tr>
							</table>
						</form>
						<div data-options="region:'south',border:false"
							style="text-align:right;padding:5px 0 0;">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
								id="saveBtn" href="javascript:void(0)" onclick="submitMoveTo();"
								style="width:80px">确定</a> <a class="easyui-linkbutton"
								data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
								onclick="$('#windowmovetoform input').val('');$('#windowmovetonotes').textbox('clear');$('#windowmoveto').window('close');" style="width:80px">取消</a>
						</div>
			</div>
		</div>
</body>

