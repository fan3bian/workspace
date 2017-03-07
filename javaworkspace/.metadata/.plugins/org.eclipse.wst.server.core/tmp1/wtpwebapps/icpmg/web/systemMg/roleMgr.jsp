<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="com.inspur.icpmg.util.WebLevelUtil"%>
<%@ page language="java" import="com.inspur.icpmg.systemMg.vo.UserEntity"%>
<%String contextPath = request.getContextPath();%>
<%
	String muser = null;
	UserEntity ue = WebLevelUtil.getUser(request);
	if(ue != null){
		if(ue.getAlias() != null){
			muser = ue.getAlias();
		}else{
			muser = ue.getEmail();
		}
	}
%>
<style type="text/css">
	.tableForm{
	}
	.tableForm th{
		text-align:right;
	}
	.tableForm td input{
		width:150px;
		text-align:left;
	}
</style>
<script type="text/javascript" charset="utf-8">
icp.ns('icp.admin.role');
$(function(){
	icp.admin.role.searchForm = $('#rolemgr_searchform').form();
	var roletype_data = [{"value":"1","text":"实角色"},{"value":"0","text":"虚角色"}];
	var usertype_data = [{"value":"1","text":"超级用户"},{"value":"2","text":"普通用户"}];
	var datalevel_data = [{"value":"1","text":"资源"},{"value":"2","text":"机房"},{"value":"3","text":"地市"},{"value":"4","text":"省"},{"value":"5","text":"节点"},
		{"value":"6","text":"子帐号"},{"value":"7","text":"父帐号"},{"value":"8","text":"角色"},{"value":"9","text":"全部"}];
	var isvalid_data = [{"value":"1","text":"在用"},{"value":"0","text":"停用"}];
	
	icp.admin.role.editRow = undefined;
	icp.admin.role.datagrid = $('#datagrid_role').datagrid({
		url:'<%=contextPath%>/authMgr/getRoles.do',
		title:'',
		iconCls:'icon-save',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		/* fit:true, */
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'roleid',
		sortName:'rolename',
		sortOrder:'asc',
		frozenColumns:[[ 
			{field:'ck',checkbox:true} 
		]],
		columns:[[{
			title:'角色编码',
			field:'roleid',
			hidden:true,
		},{
			title:'角色名称',
			field:'rolename',
			width:100,
			sortable:true,
			editor:{
				type:'validatebox',
				options:{
					required:true
				}
			}
		},{
			title:'角色类型',
			field:'roletype',
			width:100,
			formatter:function(value,row,index){
			    for(var i = 0; i < roletype_data.length; i++){
			        if (roletype_data[i].value == value){
			            return roletype_data[i].text;
			        }
			    }
			},
			editor:{
				type:'combobox',
				options:{
					required:true,
					editable:false,
					data:roletype_data,
					valueField:"value",
					textField:"text"
				}
			}
		},{
			title:'操作权限',
			field:'usertype',
			width:100,
			formatter:function(value,row,index){
			    for(var i = 0; i < usertype_data.length; i++){
			        if (usertype_data[i].value == value){
			            return usertype_data[i].text;
			        }
			    }
			},
			editor:{
				type:'combobox',
				options:{
					required:true,
					editable:false,
					data:usertype_data,
					valueField:"value",
					textField:"text"
				}
			}
		},{
			title:'数据权限',
			field:'datalevel',
			width:100,
			formatter:function(value,row,index){
			    for(var i = 0; i < datalevel_data.length; i++){
			        if (datalevel_data[i].value == value){
			            return datalevel_data[i].text;
			        }
			    }
			},
			editor:{
				type:'combobox',
				options:{
					required:true,
					editable:false,
					data: datalevel_data,
					valueField: "value",
					textField: "text"
				}
			}
		},{
			title:'接口权限',
			field:'apitype',
			width:100,
			formatter:function(value,row,index){
				if(value){
					var arrApitype = value.split(',');
					var apitypeText = '';
					for(var i=0; i < arrApitype.length; i++){
						if(arrApitype[i] == '1'){
							apitypeText = apitypeText+'资源查询类,';
						}
						if(arrApitype[i] == '2'){
							apitypeText = apitypeText+'指标查询类,';
						}
						if(arrApitype[i] == '3'){
							apitypeText = apitypeText+'设备操作类';
						}
					}
					if(apitypeText[apitypeText.length-1] == ','){
						return apitypeText.substring(0, apitypeText.length-1);
					}
				    return apitypeText;
				}
			},
			editor:{
				type:'combotree',
				options:{
					method:'get',
					url:'${pageContext.request.contextPath}/web/systemMg/apitype_data.json',
					required:true,
					editable:false,
					multiple:true
					/* valueField:"id",
					textField:"text" */
				}
			}
		},{
			title:'状态',
			field:'isvalid',
			width:100,
			formatter:function(value,row,index){
			    for(var i = 0; i < isvalid_data.length; i++){
			        if (isvalid_data[i].value == value){
			            return isvalid_data[i].text;
			        }
			    }
			},
			editor:{
				type:'combobox',
				options:{
					required:true,
					editable:false,
					data:isvalid_data,
					valueField: "value",
					textField: "text"
				}
			}
		},{
			title:'修改人',
			field:'muser',
			width:100
		},{
			title:'修改时间',
			field:'mtime',
			width:120
		},{
			title:'操作',
			field:'ops',
			width:100,
			formatter: function(value,rowData,rowIndex){
				if(rowData.roleid){				
					var str='';
					str += '<a onclick="icp.admin.role.role_showLogFun('+rowData.roleid+');">日志</a>|';
					str += '<a onclick="icp.admin.role.role_showAllUsersFun('+rowData.roleid+');">用户</a>';
					return str;
				}
			}
		}]],
		toolbar:'#role_tb',
		onAfterEdit:function(rowIndex,rowData,changes){
			var inserted = icp.admin.role.datagrid.datagrid('getChanges','inserted');
			var updated = icp.admin.role.datagrid.datagrid('getChanges','updated');	
			if(inserted < 1 && updated < 1){
				icp.admin.role.editRow = undefined;
				icp.admin.role.datagrid.datagrid('unselectAll');
				return;
			}
			var url = '';
			if(inserted.length > 0){
				url = '<%=contextPath%>/authMgr/addRole.do';
			}
			if(updated.length > 0){
				url = '<%=contextPath%>/authMgr/editRole.do';
			}
			if(inserted.length <= 0 && updated.length <= 0){
				icp.admin.role.editRow = undefined;
				icp.admin.role.datagrid.datagrid('unselectAll');
				return false;
			}
			$.ajax({
				url:url,
				data:rowData,
				dataType:'json',
				success:function(r){
					if(r && r.success){
						icp.admin.role.datagrid.datagrid('acceptChanges');
						$.messager.show({
							msg:r.msg,
							title:'成功'
						});
					}else{
						icp.admin.role.datagrid.datagrid('rejectChanges');
						$.messager.alert('错误',r.msg,'error');
					}
					icp.admin.role.editRow = undefined;
					icp.admin.role.datagrid.datagrid('unselectAll');
					icp.admin.role.datagrid.datagrid('reload');
				}
			});
		},
		onDblClickRow:function(rowIndex,rowData){
			/* icp.admin.role.datagrid.datagrid('removeEditor','roleid'); */
			if(icp.admin.role.editRow != undefined){
				icp.admin.role.datagrid.datagrid('endEdit',icp.admin.role.editRow);
			}
			if(icp.admin.role.editRow == undefined){
				icp.admin.role.datagrid.datagrid('beginEdit',rowIndex);	
				icp.admin.role.editRow=rowIndex;
			}
		},
		onLoadSuccess: function (data) {
		      var pageopt = $('#datagrid_role').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#datagrid_role').datagrid("getRows").length
		      if (_pageSize >= 10) {
		         for(i=10;i>_rows;i--){
		            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
		            $(this).datagrid('appendRow', {operation:''  })
		         }
		         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
		      }else{
		         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
		      }
		 }
	});
	icp.admin.role.searchFun=function(){
		icp.admin.role.editRow = undefined;
		icp.admin.role.datagrid.datagrid('load',icp.serializeObject(icp.admin.role.searchForm));
	};
	icp.admin.role.cleanSearchFun=function(){
		icp.admin.role.editRow = undefined;
		icp.admin.role.searchForm.find('input').val('');
		icp.admin.role.datagrid.datagrid('load',{});
	};
});
icp.admin.role.addRoleFun=function(){
	if(icp.admin.role.editRow != undefined){
		icp.admin.role.datagrid.datagrid('endEdit',icp.admin.role.editRow);
	}
	if(icp.admin.role.editRow == undefined){
		var row = {
			muser:'<%=muser%>'
		};
		icp.admin.role.datagrid.datagrid('insertRow',{
			index:0,
			row:row
		});
		icp.admin.role.datagrid.datagrid('beginEdit',0);	
		icp.admin.role.editRow=0;
	}
};
icp.admin.role.delRoleFun=function(){
	var rows = icp.admin.role.datagrid.datagrid('getSelections');
	if(rows.length > 0){
		$.messager.confirm('请确认','要删除【'+rows.length+'】项，确定要删除吗?',function(b){
			if(b){
				var ids = [];
				var idsName = [];
				for(var i =0;i<rows.length;i++){
					ids.push(rows[i].roleid);
					idsName.push(rows[i].rolename);
				}
				$.ajax({
					url:'<%=contextPath%>/authMgr/deleteRole.do',
					data:{
						delroleids: ids.join(','),
						delrolesName:idsName.join(',')
					},
					cache:false,
					dataType:"json",
					success:function(r){
						if(r && r.success){
							icp.admin.role.datagrid.datagrid('acceptChanges');
							$.messager.show({
								msg:r.msg,
								title:'成功'
							});
						}else{
							icp.admin.role.datagrid.datagrid('rejectChanges');
							$.messager.alert('错误',r.msg,'error');
						}
						icp.admin.role.datagrid.datagrid('unselectAll');
						icp.admin.role.datagrid.datagrid('load');
					}
				});
			}
		});
	}else{
		$.messager.alert('提示','请选择要删除的角色！','error');
	}
};
icp.admin.role.editRoleFun=function(){
	var rows = icp.admin.role.datagrid.datagrid('getSelections');
	if(rows.length == 1){
		if(icp.admin.role.editRow != undefined){
			icp.admin.role.datagrid.datagrid('endEdit',icp.admin.role.editRow);
		}
		if(icp.admin.role.editRow == undefined){
			var index = icp.admin.role.datagrid.datagrid('getRowIndex',rows[0]);	
			icp.admin.role.datagrid.datagrid('beginEdit',index);	
			icp.admin.role.editRow=index;
			icp.admin.role.datagrid.datagrid('unselectAll');
		}
	}else{
		$.messager.alert('提示','请选择一个角色修改！','error');
	}
};
icp.admin.role.saveRoleFun=function(){
	icp.admin.role.datagrid.datagrid('endEdit',icp.admin.role.editRow);
};
icp.admin.role.redoRoleFun=function(){
	icp.admin.role.editRow = undefined;
	icp.admin.role.datagrid.datagrid('rejectChanges');
	icp.admin.role.datagrid.datagrid('unselectAll');
};
icp.admin.role.role_showAllUsersFun=function(role_id){
	var dialog = parent.icp.modalDialog({
		title : '角色对应的所有用户',
		url : '${pageContext.request.contextPath}/web/systemMg/roleMgrAllUsers.jsp?id=' + role_id
	});
};
icp.admin.role.role_showLogFun=function(roleid){
	var dialog = parent.icp.modalDialog({
		title : '角色日志',
		url : '${pageContext.request.contextPath}/web/systemMg/roleAllOperaLog.jsp?id=' + roleid
	});
};
</script>
<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="background:#eee;width:100%;height:30px;overflow:hidden;border:false">
		<form id="rolemgr_searchform">
			<tr class="tableForm datagrid-toolbar">
				<td>角色：<input class="easyui-textbox" id="rolename" name="roleSearch" style="width:110px;height:30px;border:false"></td>
				<td>&nbsp;&nbsp;状态：<select class="easyui-combobox" name="status" id="status" data-options="panelHeight:'auto',required:true,editable:false" style="width:100px;height:30px;">
						<option value="2">全部</option>
						<option value="1">在用</option>
						<option value="0">停用</option>
						</select>
				</td>
				<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="icp.admin.role.searchFun()">查询</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="icp.admin.role.cleanSearchFun();$('#rolename').textbox('clear');$('#status').combobox('select','2');">重置</a>
				</td>
			</tr>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table id="datagrid_role" style="background:#eee;overflow:hidden;width:100%;"></table>
	</div>
</div>
<div id="role_tb" style="background:#f4f4f4;width:100%;float:left">
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="icp.admin.role.saveRoleFun()">保存</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="icp.admin.role.addRoleFun()">增加</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="icp.admin.role.editRoleFun()">修改</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="icp.admin.role.delRoleFun()">删除</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="icp.admin.role.redoRoleFun()">取消编辑</a>
</div>