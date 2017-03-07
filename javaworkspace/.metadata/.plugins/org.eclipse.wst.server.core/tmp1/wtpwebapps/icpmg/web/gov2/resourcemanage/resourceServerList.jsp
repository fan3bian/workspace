<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ include file="../../../icp/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>开通一览</title>
</head>
<body>
<style type="text/css">
	.FieldInput2 {
		width: 35%;
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
		width: 20%;
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
<%--<link href="${ctx}/web/gov2/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">--%>
<%--<link href="${ctx}/styles/gov2.css" rel="stylesheet" media="screen">--%>
<%--<script src="${ctx}/js/scripts/jquery-1.8.3.min.js"></script>--%>
<%--<script src="${ctx}/web/gov2//bootstrap/js/bootstrap.min.js"></script>--%>
<div class="easyui-layout" data-options="fit:true,border:false"
	 style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;height:500px;">
	<div data-options="region:'north',border:false" style="background:#eee;height:50px;overflow:hidden;">
		<form id="resource_searchform">
			<table  >
				<tr style="margin: 10px 20px 10px 20px;padding: 10px;" >
					<!-- <td style="margin: 10px 20px 10px 20px;padding: 10px;">单位：<input name="resourceUnit" id="resourceUnit" style="width:200px;height:30px;"></td> -->
					<!-- <td style="margin: 10px 20px 10px 20px;padding: 10px;">服务类型：<input class="easyui-textbox" name="serverType" id="serverType" data-options="validType:'isBlank'" style="width:100px;height:30px;"></td>
					<td style="margin: 10px 20px 10px 20px;padding: 10px;">服务名称：<input class="easyui-textbox" name="serverName" id="serverName" data-options="validType:'isBlank'" style="width:120px;height:30px;"></td> -->
					<td style="margin: 10px 20px 10px 20px;padding: 10px;">云服务器名称：<input class="easyui-textbox" name="serverid" id="serverid" style="width:200px;height:30px;"></td>
					<!-- <td><input type="hidden" name="severtypeidlevelfirst" id="severtypeidlevelfirst" >
							<input type="hidden"  name="servertypeidlevelsecond" id="servertypeidlevelsecond" ></td> -->
					<td align="center" colspan="3">
						<a href="javascript:void(0);" id="search" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" id="formReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">重置</a>
					</td>
				</tr>
			</table>

		</form>
	</div>
	<div data-options="region:'center',border:false" id="resourcesid">
		<table title="" style="width:100%;" id="dg">
			<thead>
			<tr>
				<%--projectid, projectname, unittype, unitid, unitname, objectid, severtypeidlevelfirst,--%>
				<%--servertypenamelevelfirst, servertypeidlevelsecond, servertypenamesecond, appname, bussinessstat, extension1, extension2, extension3, snote--%>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'nename',hidden:true"></th>
				<th data-options="field:'vmInfo',hidden:true" ></th>
				<th data-options="field:'configure',hidden:true" ></th>
				<th data-options="field:'unitname',width:80,align:'center',sortable:true">单位名称</th>
				<th data-options="field:'projectid',width:60,align:'center',hidden:true,sortable:true">项目编号</th>
				<th data-options="field:'projectname',width:80,align:'center',sortable:true">项目名称</th>
				<!-- <th data-options="field:'unitname',align:'center',sortable:true">所属单位</th> -->
				<!-- <th data-options="field:'servertypenamelevelfirst',width:50,align:'center'" >服务类型</th> -->
				<!-- <th data-options="field:'servertypenamesecond',width:50,align:'center',sortable:true,">服务名称</th> -->
				<th data-options="field:'appname',width:40,align:'center'" >应用</th>
				<th data-options="field:'neid',width:100,align:'center',sortable:true">云服务器名称</th>
				<th data-options="field:'testtime',width:80,align:'center',sortable:true">开通时间</th>
				<th data-options="field:'ipaddr',width:50,align:'center',sortable:true">IP地址</th>
				<th data-options="field:'typeid',width:100,align:'center'"  formatter="typeFormatter">登录方式</th>
				<!-- <th data-options="field:'usetime',align:'center',sortable:true">计费时间</th> -->
				<!-- <th data-options="field:'feestat',align:'center'" formatter="statusFormatter">状态</th> -->
			</tr>
			</thead>
		</table>
	</div>

</div>

<script type="text/javascript" src="../gov2.js"></script>
<script type="text/javascript">
	var flagck = 0;  //  初始化为0
	$(document).ready(function () {
		loadDataGrid();
		//服务类型 一级分类-二级分类级联
		$('#serverName').combobox({
			//url:'${ctx}/resourceinfo/getSevertypeSecondList.do',
			//valueField: 'servertypeid',
			//textField: 'servertypename',
			width:120,
			panelHeight: '100'
		});
		
		$('#serverType').combobox({
			url:'${pageContext.request.contextPath}/resourceinfo/getSevertypeList.do',
			valueField: 'servertypeid',
			textField: 'servertypename',
			width:100,
			panelHeight: '100',
			loadFilter:function(data){
				data.unshift({servertypeid:"",servertypename:"请选择"});
				return data;
			},
			onSelect:function (record){
				var _servertypeid = record.servertypeid;
				$('#serverName').combobox({
					url:'${pageContext.request.contextPath}/resourceinfo/getSevertypeSecond.do?servertypeid='+_servertypeid,
					valueField: 'servertypeid',
					textField: 'servertypename',
				});
			}
			
		});
	
		//所属单位
		$('#resourceUnit').combobox({
			url:'${pageContext.request.contextPath}/project/getUnitsData.do',
			valueField: 'unitId',
			textField: 'unitName',
			width:200,
			panelHeight: '100',
			loadFilter:function(data){
				data.unshift({unitId:"",unitName:"请选择"});
				return data;
			}
		});

		$("#search").click(function () {
			searchDataGrid();
		});

		$("#formReset").click(function () {
			$("#resource_searchform").form("reset");
			searchDataGrid();
		});

		function loadDataGrid() {
			$('#dg').datagrid({
				rownumbers: false,
				scrollbarSize:0,
				checkOnSelect: true,
				selectOnCheck: false,
				border: false,
				striped: true,
				sortName: 'testtime',
				sortOrder: 'desc',
				nowarp: false,
				singleSelect: true,
				method: 'post',
				loadMsg: '数据装载中......',
				fitColumns: true,
				idField: 'neid',
				pagination: true,
				pageSize:10,
				pageNumber:1,
				pageList: [5,10,20,30],
				url: '${pageContext.request.contextPath}/vmmanage/getCreatedVms.do',
				onLoadSuccess: function (data) {
					var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
					var  _pageSize = pageopt.pageSize;
					var  _rows = $('#dg').datagrid("getRows").length
					var total = pageopt.total; //显示的查询的总数
					if (_pageSize >= 10) {
						for(i=10;i>_rows;i--){
//							{ itemid: '<div style="text-align:center;color:red">没有相关记录！</div>' }
							//添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
							$(this).datagrid('appendRow', {operation:''  })
						}
						 $('#dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
									    		total: total,
									    	});
						//	$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
					}else{
						//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
						$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					}
					  var rows = data.rows;
				      if (rows.length) {
							 $.each(rows, function (idx, val) {
							
								if(val.operation==''&&val.operation!='0'){  
									$('#resourcesid  input:checkbox').eq(idx+1).css("display","none");
									 
								}
								
							}); 
				      }
					
				},
				//没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.operation==''&&rowData.operation!='0'){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
					$('#resourcesid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck = 1;
							$.each(rows, function (idx, val) {
								if (val.operation==''&&val.operation!='0'){
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

		function searchDataGrid() {
			$('#dg').datagrid('load', $('#resource_searchform').form('serialize'));
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

	function typeFormatter(val,rows,index){

		if ('VM'==rows.typeid) {
			return "用户名：root, 密码：1qaz@wsx?S";
		}

	}



</script>


</body>
</html>