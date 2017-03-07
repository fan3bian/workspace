<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<script type="text/javascript" charset="utf-8">
$(function(){
	searchForm = $('#crpmgr_searchform').form();
	var crptype_data = [{"value":"1","text":"机房联系人"},{"value":"2","text":"入驻单位联系人"},{"value":"3","text":"设备厂商联系人"}];
	
	datagrid = $('#crpmgr_datagrid').datagrid({
		url:'${pageContext.request.contextPath}/crMgr/getCRStuff.do',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		/* fit:true, */
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'crpid',
		sortName:'crpname',
		sortOrder:'asc',
		frozenColumns:[[ 
			{field:'ck',checkbox:true} 
		]],
		columns:[[{
			title:'人员编码',
			field:'crpid',
			width:50,
			hidden:true
		},{
			title:'部门单位',
			field:'unit',
			width:100,
			sortable:true
		},{
			title:'职务',
			field:'duty',
			width:50,
			hidden:true
		},{
			title:'人员类型',
			field:'crptype',
			width:100,
			formatter:function(value,row,index){
			    for(var i = 0; i < crptype_data.length; i++){
			        if (crptype_data[i].value == value){
			            return crptype_data[i].text;
			        }
			    }
			},
			editor:{
				type:'combobox',
				options:{
					data:crptype_data,
					valueField:"value",
					textField:"text"
				}
			}
		},{
			title:'姓名',
			field:'crpname',
			width:100,
			sortable:true
		},{
			title:'性别',
			field:'gender',
			width:100,
			hidden:true
		},{
			title:'固定电话',
			field:'telphone',
			width:100
		},{
			title:'手机号码',
			field:'mobile',
			width:100
		},{
			title:'传真',
			field:'fax',
			width:100
		},{
			title:'身份证号',
			field:'idcard',
			width:120
		},{
			title:'邮箱',
			field:'email',
			width:100
		},{
			title:'备注1',
			field:'mark1',
			width:100,
			hidden:true
		},{
			title:'备注2',
			field:'mark2',
			width:100,
			hidden:true
		},{
			title:'操作',
			field:'ops',
			width:100,
			formatter: function(value,rowData,rowIndex){
				var str='';
				str += '<a onclick="showCRPDetailFun(\''+rowData.crpid+'\');">详情</a>';
				return str;
			}
		}]]
	});
	
	searchFun=function(){
		datagrid.datagrid('load',icp.serializeObject(searchForm));
	};
	cleanSearchFun=function(){
		searchForm.find('input').val('');
		datagrid.datagrid('load',{});
	};
	
	addStuffFun=function(){
		$('#stuff_add_addForm input').val('');
		$('#crptype').combobox('setValue','1');
		$("#stuff_add_dialog").dialog('open');
	};
	delStuffFun=function(){
		var rows = datagrid.datagrid('getSelections');
		if(rows.length > 0){
			$.messager.confirm('请确认','您确定要删除当前所有选择的项目吗?',function(b){
				if(b){
					var ids = [];
					for(var i =0;i<rows.length;i++){
						ids.push(rows[i].crpid);
					}
					$.ajax({
						url:'${pageContext.request.contextPath}/crMgr/deleteCRStuff.do',
						data:{
							crpids: ids.join(',')
						},
						cache:false,
						dataType:"json",
						success:function(r){
							if(r && r.success){
								datagrid.datagrid('acceptChanges');
								$.messager.show({
									msg:r.msg,
									title:'提示'
								});
							}else{
								datagrid.datagrid('rejectChanges');
								$.messager.alert('错误',r.msg,'error');
							}
							datagrid.datagrid('unselectAll');
							datagrid.datagrid('load');
						}
					});
				}
			});
		}else{
			$.messager.alert('提示','请选择要删除的记录！','error');
		}
	};
	updateStuffFun=function(){
		var rows = datagrid.datagrid('getSelections');
		if(rows.length == 1){	//回显内容	
			$("#ucrpid").val(rows[0].crpid);
			
			var ctValue = rows[0].crptype;
			if(ctValue == 1){
				$("#ucrptype").combobox('setValue','1');
				$("#ucrptype").combobox('setText','机房联系人');
				$("#ucrptype").combobox('select',1);
			}
			if(ctValue == 2){
				$("#ucrptype").combobox('setValue','2');
				$("#ucrptype").combobox('setText','入驻单位联系人');
				$("#ucrptype").combobox('select',2);
			}
			if(ctValue == 3){
				$("#ucrptype").combobox('setValue','3');
				$("#ucrptype").combobox('setText','设备厂商联系人');
				$("#ucrptype").combobox('select',3);
			}
			$("#uunit").val(rows[0].unit);
			$("#uduty").val(rows[0].duty);
			$("#utelphone").val(rows[0].telphone);
			$("#ufax").val(rows[0].fax);
			$("#ucrpname").val(rows[0].crpname);
			var gender = rows[0].gender;			//性别
			if(gender==0){
				$("#umale").attr("checked",true);
			}else{
				$("#ufemale").attr("checked",true);
			}
			$("#umobile").val(rows[0].mobile);
			$("#uidcard").val(rows[0].idcard);
			$("#uemail").val(rows[0].email);
			$("#umark1").textbox('setText',rows[0].mark1);
			$("#umark2").textbox('setText',rows[0].mark2);
			
			$('#stuff_update_dialog').dialog('open');
		}else{
			$.messager.alert('提示','请选择一条记录修改！','error');
		}
		datagrid.datagrid('unselectAll');	//取消所有的选中状态
	};
	
	showCRPDetailFun=function(crpid){
		$.ajax({
			url:'${pageContext.request.contextPath}/crMgr/getCRStuffVo.do',
			data:{
				crpid: crpid
			},
			cache:false,
			dataType:"json",
			success:function(r){
				var o = r.obj;
				if(r && r.success){
					if(o.crptype == 1){
						$('#dcrptype').html('机房联系人');
					}
					if(o.crptype == 2){
						$('#dcrptype').html('入驻单位联系人');
					}
					if(o.crptype == 3){
						$('#dcrptype').html('设备厂商联系人');
					}
					$('#dunit').html(o.unit);
					$('#dduty').html(o.duty);
					$('#dtelphone').html(o.telphone);
					$('#dfax').html(o.fax);
					$('#dcrpname').html(o.crpname);
					if(o.gender == 0){
						$('#dgender').html('男');
					}
					if(o.gender == 1){
						$('#dgender').html('女');
					}
					$('#dmobile').html(o.mobile);
					$('#didcard').html(o.idcard);
					$('#demail').html(o.email);
					$('#dmark1').html(o.mark1);
					$('#dmark2').html(o.mark2);
				}
				datagrid.datagrid('unselectAll');
				$('#stuff_detail_dialog').dialog('open');
			}
		});
		
	};
});
</script>

<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
		<form id="crpmgr_searchform">
			<table>
				<tr>
					<td>名称：<input class="easyui-textbox" name="sechCndtn" data-options="prompt:'姓名/手机号/身份证号/部门单位'" style="width:180px;height:28px;border:false"></td>
					<td>&nbsp;人员类型：<select class="easyui-combobox" name="stuffType" data-options="panelHeight:'auto',required:true,editable:false" style="width:150px;height:28px;border:false">
						<option value="0">全部</option>
						<option value="1">机房联系人</option>
						<option value="2">入驻单位联系人</option>
						<option value="3">设备厂商联系人</option>
						</select>
					</td>
					<td style="float:right">&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="cleanSearchFun()">重置</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="addStuffFun()">增加</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="delStuffFun()">删除</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="updateStuffFun()">修改</a>&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div data-options="region:'center',border:false" style="background:#eee;">
		<table id="crpmgr_datagrid" style="background:#eee;width:100%;"></table>
	</div>
</div>

<jsp:include page="crMgrAddDialog.jsp"></jsp:include>
<jsp:include page="crMgrUpdateDialog.jsp"></jsp:include>
<jsp:include page="crpMgrDetail.jsp"></jsp:include>
