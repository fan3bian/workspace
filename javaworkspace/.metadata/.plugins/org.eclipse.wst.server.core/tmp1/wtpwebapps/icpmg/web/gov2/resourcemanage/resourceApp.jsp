<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../../icp/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="background:#eee;height:40px;overflow:hidden;border:false">
			<form id="vm_searchform">
				<table>
					<tr style="margin: 10px 20px 10px 20px;padding: 10px;" >
						<td style="margin: 10px 20px 10px 20px;padding: 10px;">单位：
							<input name="resourceUnit" id="resourceUnit" style="width:200px">
						</td>
						<td style="margin: 10px 20px 10px 20px;padding: 10px;">项目：
							<input name="projectName" id="projectName" style="width:200px">
						</td>
						<td align="center" colspan="3">
							<a href="javascript:void(0);" id="search" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" id="formReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="appid">
			<table title="" style="width:100%;" id="dg">
				<thead>
					<tr>
						<%--projectid, projectname, unittype, unitid, unitname, objectid, severtypeidlevelfirst,--%>
						<%--servertypenamelevelfirst, servertypeidlevelsecond, servertypenamesecond, appname, bussinessstat, extension1, extension2, extension3, snote--%>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'objectid',hidden:true"></th>
						<th data-options="field:'projectid',width:20,align:'center',sortable:true,hidden:true">项目编号</th>
						<th data-options="field:'projectname',width:50,align:'center',sortable:true">项目名称</th>
						<th data-options="field:'unitname',width:20,align:'center',sortable:true">所属单位</th>
						<th data-options="field:'objectname',width:20,align:'center',sortable:true">实例名称</th>
						<th data-options="field:'servertypenamesecond',width:20,align:'center',sortable:true,">服务名称</th>
						<th data-options="field:'servertypenamelevelfirst',width:100,align:'center',hidden:true">类型</th>
						<th data-options="field:'severtypeidlevelfirst',width:100,align:'center',hidden:true">一级分类id</th>
						<th data-options="field:'servertypeidlevelsecond',width:100,align:'center',hidden:true">二级分类id</th>
						
						<th data-options="field:'appname',width:40,align:'center'" >应用</th>
						<th data-options="field:'servicebegintime',width:30,align:'center',sortable:true">开通时间</th>
						<th data-options="field:'chargingbegintime',width:30,align:'center',sortable:true">开始计费时间</th>			
						<th data-options="field:'bussinessstat',width:20,align:'center'" formatter="statusFormatter">状态</th>
						
						
						
						<th data-options="field:'extension1',hidden:true"></th>						
					</tr>
				</thead>
			</table>
		</div>
	</div>

	
<script type="text/javascript" src="../gov2.js"></script>
<script type="text/javascript">

	var flagck = 0;
	
	$(document).ready(function () {
		var toolbar = [{
			text:'增加',
			iconCls:'icon-newadd',
			handler:function()
			{
	                $('<div></div>').dialog({
	                    id : 'windowApp',
	                    title : '应用服务信息',
	                    width : 600,
	                    height : 360,
	                    closed : false,
	                    cache : false,
	                    href : '${ctx}/web/gov2/resourcemanage/resourceAppForm.jsp',
	                    modal : true,
	                    onLoad : function() {
	                    	$("#unitname").textbox('setValue','');
							$("#projectname").textbox('setValue','');
							$("#servertypenamelevelfirst").textbox('setValue','');
							$("#servertypenamesecond").textbox('setValue','');
							$("#objectname").textbox('setValue','');
							$("#appname").textbox('setValue','');
							
							$("#severtypeidlevelfirst").val('');
							$("#servertypeidlevelsecond").val('');
							
							$("#extension1").textbox('setValue','');
							url='${ctx}/resourceinfo/addResourceApp.do';						
	                    },
	                    onClose : function() {
	                        $(this).dialog('destroy');
	                    },
	                    buttons : [ {
	                        text : '确定',
	                        iconCls : 'icon-ok',
	                        handler : function() {
	                            //提交表单
	                            confirmBtn();
	                        }
	                    }, {
	                        text : '取消',
	                        iconCls : 'icon-cancel',
	                        handler : function() {
	                            $("#windowApp").dialog('destroy');
	                        }
	                    } ]

	                });
		        }

		},{
			text:'删除',
			iconCls:'icon-del',
			handler:function()
			{
				var rows = $('#dg').datagrid('getChecked');
				if(rows.length<1)
				{
					$.messager.alert('消息','请至少选择一条记录！');
					return;
				}
				var objectids = "";
				$.each(rows,function(index,object){
					objectids+=object.objectid+",";
				});
				$.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){
					if (r){
						$.ajax({
							type : 'post',
							url:'${ctx}/resourceinfo/deleteResourceApp.do',
							data:{objectids:objectids},
							success:function(retr){
								var data = JSON.parse(retr);
								$.messager.alert('消息',data.msg);
								if(data.success)
								{
									$('#dg').datagrid('unselectAll');
									$('#dg').datagrid('reload');
								}
							}
						});
					}
				});
			}
		},{
			text:'修改',
			iconCls:'icon-update',
			handler:function()
			{	
				var rows = $('#dg').datagrid('getChecked');
				if (rows.length != 1) {
					$.messager.alert('消息', '请选择一条记录！');
					return;
				}
	            if (rows&& rows[0].objectid) {
	                $('<div></div>').dialog({
	                    id : 'windowApp',
	                    title : '应用服务信息',
	                    width : 600,
	                    height : 360,
	                    closed : false,
	                    cache : false,
	                    href : '${ctx}/web/gov2/resourcemanage/resourceAppForm.jsp',
	                    modal : true,
	                    onLoad : function() {
	                        //初始化表单数据
	                        $("#objectid").val(rows[0].objectid);
							$("#unitname").textbox('setValue',rows[0].unitname);
							$("#projectname").textbox('setValue',rows[0].projectname);
							$("#servertypenamelevelfirst").textbox('setValue',rows[0].severtypeidlevelfirst).textbox('setText',rows[0].servertypenamelevelfirst);
							$("#servertypenamesecond").textbox('setValue',rows[0].servertypeidlevelsecond).textbox('setText',rows[0].servertypenamesecond);
							$("#objectname").textbox('setValue',rows[0].objectname);
							$("#appname").textbox('setValue',rows[0].appname);
							
							
							//alert(rows[0].severtypeidlevelfirst);
							$("#severtypeidlevelfirst").val(rows[0].severtypeidlevelfirst);
							$("#servertypeidlevelsecond").val(rows[0].servertypeidlevelsecond);
							
							$("#extension1").textbox('setValue',rows[0].extension1);
										
							url='${ctx}/resourceinfo/updateResourceApp.do';
	                        	        				
	                    },
	                    onClose : function() {
	                        $(this).dialog('destroy');
	                    },
	                    buttons : [ {
	                        text : '确定',
	                        iconCls : 'icon-ok',
	                        handler : function() {
	                            //提交表单
	                            confirmBtn();
	                        }
	                    }, {
	                        text : '取消',
	                        iconCls : 'icon-cancel',
	                        handler : function() {
	                            $("#windowApp").dialog('destroy');
	                        }
	                    } ]

	                });
	              }	
			}
		}];
		
		loadDataGrid();
			//项目下拉框
		$('#projectName').combobox({
			width:140,
			panelHeight: '100'
		}); 
		
		//单位下拉框
		$('#resourceUnit').combobox({
			url:'${ctx}/infopublish/getDepartsTJ.do',
			valueField: 'unitId',
			textField: 'unitName',
			width:100,
			panelHeight: '100',
			onSelect:function (record){
				var _unitId = record.unitId;
				$('#projectName').combobox({
					url:'${ctx}/project/getprojectsAll.do?unitId='+_unitId,
					valueField: 'proid',
					textField: 'proname',
					loadFilter:function(data){
						data.unshift({proid:"",proname:"请选择"});
						return data;
					}
				});
			}
		});
		//查询
		$("#search").click(function () {
			searchDataGrid();
		});
		//重置
		$("#formReset").click(function () {
			$("#vm_searchform").form("reset");
			searchDataGrid();
		});
	
		function loadDataGrid() {
			$('#dg').datagrid({
				rownumbers: false,
				scrollbarSize:0,
				checkOnSelect: true,
				selectOnCheck: true,
				border: false,
				striped: true,
				sortName: 'projectid',
				sortOrder: 'asc',
				nowarp: false,
				singleSelect: false,
				method: 'post',
				loadMsg: '数据装载中......',
				fitColumns: true,
				idField: 'objectid',
				pagination: true,
				toolbar: toolbar,
				pageSize:10,
				pageNumber:1,
				pageList: [5,10,20,30],
				url: '${ctx}/resourceinfo/resourceinfoListApp.do',
				onLoadSuccess: function (data) {
					   	debugger;
					      var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
					      var  _pageSize = pageopt.pageSize;
					      var  _rows = $('#dg').datagrid("getRows").length;
					      var total = pageopt.total; //显示的查询的总数 
					      if (_pageSize >= 10) {
					         for(i=10;i>_rows;i--){
					            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
					            $(this).datagrid('appendRow', {operation:''  })
					         }
					          $('#dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
						    	total: total,
						     });
					         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
					      }else{
					         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
					         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					      }
					     
					      debugger;
					        //设置不显示复选框
									      var rows = data.rows;
									      if (rows.length) {
												 $.each(rows, function (idx, val) {
													if   (val.operation==''){  
														$('#appid  input:checkbox').eq(idx+1).css("display","none");
														 
													}
												}); 
									      }
					      
					      
					},
					 //没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.operation==''){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
					$('#appid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck = 1;
							$.each(rows, function (idx, val) {
								if (val.operation==''){
									$("#dg").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('#appid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
								}
							});
					},
									
					onUncheckAll: function(rows) {
						flagck = 0;
					}  
									
			});
		}
	
		function searchDataGrid() {
	//		console.log($('#vm_searchform').form('serialize'));
			$('#dg').datagrid('load', $('#vm_searchform').form('serialize'));
		}
		$.extend($.fn.form.methods, {
			serialize: function (jq) {
				var arrayValue = $(jq[0]).serializeArray();
				var json = {};
				$.each(arrayValue, function () {
					var item = this;
					if (json[item["name"]]) {
						json[item["name"]] = json[item["name"]] + "," + item["value"];
					} else {
						json[item["name"]] = item["value"];
					}
				});
				return json;
			},
			getValue: function (jq, name) {
				var jsonValue = $(jq[0]).form("serialize");
				return jsonValue[name];
			},
			setValue: function (jq, name, value) {
				return jq.each(function () {
					_b(this, _29);
					var data = {};
					data[name] = value;
					$(this).form("load", data);
				});
			}
		});
	});
	


	
	//增加$修改 确定按钮
	function confirmBtn(){
		
		$('#formApp').form('submit',{
			url:url,
	        onSubmit:function(){
	        	//表单验证
	        	var unitname =  $("#unitname").textbox('getValue');
	        	if(""==unitname || null==unitname){ 
	                $.messager.alert('提示',"请选择单位！"); 
	                return false;
	            }
	        	var projectname =  $("#projectname").textbox('getValue');
	        	if(""==projectname || null==projectname){ 
	                $.messager.alert('提示',"请选择项目！"); 
	                return false;
	            }
	        	var objectname =  $("#objectname").textbox('getValue');
	        	if(objectname=="" || objectname==null){ 
	                $.messager.alert('提示',"名称不能为空！"); 
	                return false;
	            }
	        	var appname =  $("#appname").textbox('getValue');
	        	if(appname=="" || appname==null){ 
	                $.messager.alert('提示',"应用不能为空！"); 
	                return false;
	            }
	        	
	        },
	        success:function(data){
	        	var data = JSON.parse(data);
	        	$('#windowApp').window('close');
	  			$.messager.alert('消息',data.msg);
	        	if(data.success){
	        		$('#dg').datagrid('unselectAll');
		    		$('#dg').datagrid('reload');
	        	}
	        }
		})
	}
	
	//状态
	function statusFormatter(val,rows,index){
		switch (rows.bussinessstat) {
			case "0":
				return "开通"
			case "1":
				return "试运行";
			case "2":
				return "计费开始";
			case "3":
				return "计费结束"; 
		}
	}
</script>
</body>
</html>