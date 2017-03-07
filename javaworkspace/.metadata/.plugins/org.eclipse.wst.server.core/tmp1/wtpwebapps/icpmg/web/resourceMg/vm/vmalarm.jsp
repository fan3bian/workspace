<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body class="easyui-layout" data-options="fit:true,border:false" >
<style type="text/css">
.FieldInput2 {
	height: 25px;
	background-color: #eee;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/validate.js"></script>
<script type="text/javascript">	
/* $(document).ready(function() {
	$('#neid').combobox({    
	    url:'${pageContext.request.contextPath}/vm/getvms.do',    
	    valueField:'neid',    
	    textField:'nename',
   		onLoadSuccess: function () {
   		 	//加载完成后,设置选中第一项
            var val = $(this).combobox("getData");
            for (var item in val[0]) {
                if (item == "neid") {
                    $(this).combobox("select", val[0][item]);
                }
            }
    	}  
	}); 
}); */
function alevelformater(value,row,index){
	switch (value) {
		case "1":
			return "警告";
		case "2":
			return "一般";
		case "3":
			return "次要";
		case "4":
			return "主要";
		case "5":
			return "严重";
	}
}
function searchAndLoad(){
	if ($('#order_searchform').form('validate')) {
		$('#dg').datagrid('load',icp.serializeObject($('#order_searchform')));
	} 
}
</script>

	<div data-options="region:'north',border:false" style="padding:10px 20px 10px 10px;margin:10px 5px 0px 25px;height:30px;overflow:hidden;">
		<form id="order_searchform" method="post">
			<table >
				<tr>
					<td>资源名称：<input class="easyui-textbox" name="nename" id="nename" style="width:160px;height:30px;border:false"></td>
					<td>&nbsp;&nbsp;IP：<input class="easyui-textbox" name="ipaddr" id="ipaddr" style="width:160px;height:30px;border:false"></td>
					<td>&nbsp;&nbsp;开始时间：<input class="easyui-datetimebox" editable="fasle" name="starttime" id="starttime" style="width:130px;height:30px;border:false"></td>
					<td>&nbsp;&nbsp;结束时间：<input class="easyui-datetimebox"  editable="fasle" validType="compareDate['starttime']" name="endtime" id="endtime" style="width:130px;height:30px;border:false"></td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchAndLoad()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="$('#order_searchform input').val('');$('#nename').textbox('clear');$('#ipaddr').textbox('clear');$('#starttime').datebox('setValue', '');$('#endtime').datebox('setValue', '');$('#dg').datagrid('load',{});">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',fit:true,border:false"  style="padding:10px 20px 10px 10px;margin: 0px 5px 0 25px;">
		<table id="dg" class="easyui-datagrid" style="width:100%;"
			data-options="rownumbers:false,border:false,striped : true,scrollbarSize:0,nowarp:false,singleSelect: true,url:'${pageContext.request.contextPath}/vm/vmalarm.do',method:'post',loadMsg:'数据装载中......',fitColumns:true,pagination:true,pageSize:10,pageList:[5,10,20,30,40,50]">
			<thead>
				<tr>
					<th data-options="field:'nename',width:160,align:'center'">名称</th>
					<th data-options="field:'ipaddr',width:100,align:'center'">IP</th>
					<th data-options="field:'atitle',width:100,align:'center'">标题</th>
					<th data-options="field:'alevel',width:60,align:'center',formatter:alevelformater">级别</th>
					<th data-options="field:'avalue',width:60,align:'center'">告警值</th>
					<th data-options="field:'atime',width:100,align:'center'">时间</th>
					<th data-options="field:'trend',width:60,align:'center'">趋势</th>
				</tr>
			</thead>
		</table>
	</div>
<script type="text/javascript">	
	
</script>
</body>

