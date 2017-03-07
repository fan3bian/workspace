<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java" %>

<body class="easyui-layout" data-options="fit:true,border:false" >
<script type="text/javascript" src="${pageContext.request.contextPath}/js/validate.js"></script>
<script type="text/javascript" charset="utf-8">	
	$(document).ready(function(){
		//使用单位（已过滤数据权限）
		$('#useUnit').combobox({
			url:'${pageContext.request.contextPath}/project/getUnitsData.do?cqcsgdSign=1&unittype=2',
			valueField: 'unitId',
			textField: 'unitName',
			width:170,
			panelHeight: '100',
			loadFilter:function(data){
				data.unshift({unitId:"",unitName:"请选择"});
				return data;
			}
		});
	});

	var showDraft = function(id,adr) {//草稿状态跳转
		$('#centerTab').panel({
			href:"${pageContext.request.contextPath}/"+adr+"?transferid=" + id
		});
	};
	
	var showDetail = function(id) {//待办 已办 办结状态跳转
		$('#centerTab').panel({
			href:"${pageContext.request.contextPath}/approvalCenter.do?transferid=" + id
		});
	};
	
	//状态
	function flowformater(value,row,index){ 
		if(row.tstatusid == '1'){
	 		return "<img src=\"${pageContext.request.contextPath}/images/limit1.png\" />";
		}else if(row.tstatusid == undefined || row.tstatusid == ""){
			return "";
		}
		return "<img src=\"${pageContext.request.contextPath}/images/normal1.png\" />";
	 }
	
	 //操作
	 function rowformater(value,row,index){
		 var str = '';
		 if(row.fstatus == '草稿'){
			 str += icp.formatString('<img src=\"${pageContext.request.contextPath}/images/btnchakan.png\" title="发起" onclick="showDraft(\'{0}\',\'{1}\');"/>', row.flowid,row.jspurl);
			 return str;
		 }else if(row.tstatusid == undefined || row.tstatusid == ""){
	  		return "";
	  	 }
	 	return icp.formatString('<img src=\"${pageContext.request.contextPath}/images/btnchakan.png\" title="查看" onclick="showDetail(\'{0}\');"/>', row.flowid);
	 }
	 
	function searchAndLoad(){
		if ($('#order_searchform').form('validate')) {
			$('#dg').datagrid('load',icp.serializeObject($('#order_searchform')));
		} 
	}
 	
	//抄送工单列表
	$("#dg").datagrid({
		rownumbers: false,
		border: false,
		striped: true,
		scrollbarSize: 0,
		sortName: 'ctime',
		sortOrder: 'desc',
		nowarp: false,
		singleSelect: true,
		pagination: true,
		url:'${pageContext.request.contextPath}/workorder/queryCqzwyCsgd.do?flagSign=cqzwycsgd',
		method: 'post',
		loadMsg: '数据装载中......',
		idField: 'flowid',
		pagination: true,
		pageSize: 10,
		pageList: [10, 20, 30, 40, 50],
		onLoadSuccess: function(data) {
	        var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
			var  _pageSize = pageopt.pageSize;//分页条数
			var  _rows = $('#dg').datagrid("getRows").length;//每页实际条数
			var total = pageopt.total; //显示的查询的总数
			if (_pageSize >= 10) {
				for(i=10;i>_rows;i--){
					//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
					$(this).datagrid('appendRow', {orderid:''  })
				}
				$('#dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    	total: total,
			     });
			}else{
				//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
	        
			//设置不显示复选框
			/*
	        var rows = data.rows;
	        if (rows.length) {
				 $.each(rows, function (idx, val) {
					if(val.neid=='' || val.neid == undefined){ 
						//addid为datagrid上一层的div id 
						//$('#addid  input:checkbox').eq(idx+1).css("display","none");//设置不显示复选框
					}
				}); 
	        }*/
	    }
	});
 </script>
	<div data-options="region:'north',border:false" style="padding:10px 20px 10px 10px;margin:10px 5px 0px 25px;height:30px;overflow:hidden;">
		<form id="order_searchform" method="post">
			<table >
				<tr>
					<td>工单号：<input class="easyui-textbox" name="flowid" id="flowid" style="width:100px;height:30px;border:false"></td>
					<td style="margin: 10px 20px 10px 20px;padding: 10px;">使用单位：<input name="useUnit" id="useUnit" style="width:120px;height:30px;"></td>
					<td>&nbsp;工单状态：<select class="easyui-combobox" name="fstatusid" id="fstatusid" data-options="panelHeight:'auto',editable:false" style="width:70px;height:30px">
							<option value="0">请选择</option>
							<option value="1">草稿</option>
							<option value="2">提交</option>
							<option value="3">受理</option>
							<option value="4">归档</option>
							<option value="5">办结</option>
							<option value="6">驳回</option>
							</select>
					</td>
					<td>&nbsp;&nbsp;开始时间：<input class="easyui-datetimebox" editable="fasle"name="starttime" id="starttime" style="width:130px;height:30px;border:false"></td>
					<td>&nbsp;&nbsp;结束时间：<input class="easyui-datetimebox"  editable="fasle" validType="compareDate['starttime']" name="endtime" id="endtime" style="width:130px;height:30px;border:false"></td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchAndLoad()">查询</a>&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="$('#order_searchform input').val('');$('#flowid').textbox('clear');$('#fstatusid').combobox('select','0');$('#starttime').textbox('clear');$('#endtime').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',fit:true,border:false"  style="padding:10px 20px 10px 10px;margin: 0px 5px 0 25px;">
	<table id="dg" class="easyui-datagrid" style="width:100%;"
		data-options="fitColumns:true">
		<thead>
			<tr>
				<th data-options="field:'tstatusid',width:60,align:'center',sortable:true,formatter:flowformater">状态</th>
				<th data-options="field:'flowid',width:120,align:'center',sortable:true">工单号</th>
				<%--
					<th data-options="field:'orderid',width:100,align:'center',sortable:true">订单号</th>
					<th data-options="field:'cusername',width:80,sortable:true">发起人</th>
				 --%>
				<th data-options="field:'flowname',width:150,align:'center',sortable:true">标题</th>
				<th data-options="field:'unitname',width:110,align:'center',sortable:true">申请单位</th>
				<th data-options="field:'useunitname',width:100,align:'center',sortable:true">使用单位</th>
				<th data-options="field:'ctime',width:100,align:'center',sortable:true">发起时间</th>
				<th data-options="field:'fstatus',width:60,align:'center',sortable:true">工单状态</th>
				<th data-options="field:'Ftypename',width:60,align:'center',sortable:true">工单类型</th>
				<th data-options="field:'jspurl',width:30,align:'center',hidden:true">URL</th>
				<th data-options="field:'id',width:50,align:'center',formatter:rowformater">工单信息</th>
			</tr>
		</thead>
	</table>
	</div>
	
</body>

