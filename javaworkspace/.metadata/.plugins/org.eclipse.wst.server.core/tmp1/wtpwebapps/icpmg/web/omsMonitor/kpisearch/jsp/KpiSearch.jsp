<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript"> 
			var context_path = '${pageContext.request.contextPath}';
		</script>
<script src="${pageContext.request.contextPath}/web/omsMonitor/kpisearch/js/kpiSearch.js" type="text/javascript" charset="UTF-8"></script>
<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:5px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height:52px;overflow:hidden;">
			<form id="kpisearch_searchform">
				<table class="tableForm datagrid-toolbar">
					<tr>
						<td>设备类型：<input id="kpisearch_netype" style="height:25px;width:21%"
							name="kpiSearchNetype" class="easyui-combobox"
							data-options="valueField:'typeid',textField:'typename',panelHeight:'200',height:200,required:true" />
						&nbsp;
						设备名称：<input id="kpisearch_ne" style="height:25px;width:45%" name="kpiSearchNe"
							class="easyui-combobox"
							data-options="multiple:'true',valueField:'neid',textField:'nename',panelHeight:'300',height:200" />
						&nbsp;
						指标名称：<input class="easyui-combobox" name="kpiSearchInd"
							id="kpisearch_ind" style="height:25px;width:45%" data-options="valueField:'kpiname',textField:'text',panelHeight:'300',height:200,required:true"/>
						</td>
						</tr>
					   <tr>
						<td>
						时间粒度：<input id="kpisearch_timeperiod" style="height:25px;width:80px" name="kpiSearchTimePeriod"
							class="easyui-combobox"
							data-options="valueField:'periodId',textField:'periodName',data:[{periodId:'M5',periodName:'5分钟',selected:true},{periodId:'H',periodName:'小时'},{periodId:'D',periodName:'天'},{periodId:'M',periodName:'月'}],panelHeight:'auto',height:200" />
						
						&nbsp;						
						时间范围：<input class="easyui-datetimebox" name="kpiSearchStarttimeFrom"
							id="kpisearch_starttime_from" style="height:25px;border:false" data-options="required:true">
							&nbsp;
							到&nbsp;<input class="easyui-datetimebox" name="kpiSearchStarttimeTo"
							id="kpisearch_starttime_to" style="height:25px;border:false" data-options="required:true">
						</td>
						<td><a href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="resetCondition()">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table title="" style="width:100%;" id="kpisearch_dg">
				<thead>
					<tr>
					
						<th
							data-options="field:'netype',width:120,align:'center',sortable:true,formatter:neTypeformater">设备类型</th>
						<th data-options="field:'nename',width:80,align:'center'">设备名称</th>
						<th data-options="field:'indname',width:80,align:'center',formatter:indformater">指标名称</th>
						<th data-options="field:'starttime',width:80,align:'center'">开始时间</th>
						<th data-options="field:'indvalue',width:80,align:'center'">指标值</th>

					</tr>
				</thead>
			</table>
		</div>
</div>
</body>
</html>