<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
.FieldInput2 {
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
}
</style>
<script type="text/javascript">
var flagck = 0;  //  初始化为0
var ws = null;
var url = null;
var transports = [];
var ipstoolbar = [
				 {
					text:'管理',
					iconCls:'icon-objmanage',
					handler:function(){ 
						var rows = $('#ips_object_grid').datagrid('getChecked');
						if(rows.length<1 || rows.length>1){
							$.messager.alert('消息','请选择一条记录！'); 
							return; 
						}  
						
						$('#centerTab').panel({
							href:"${pageContext.request.contextPath}/security/ipsManageInit.do", 
							queryParams:{serviceid:rows[0].serviceid}
						});
						
					}
				}/* , 
				{
					text:'开通安全服务',
					iconCls:'icon-add',
				    handler:function(){ 
				    	resetSecurityBasicConfig();
				    	resetSecurityNetworkConfig();
				      $("#securityServiceOpen_basicConfig").window('open');
				    }
				} */
               ];
$(document).ready(function() {

	loadComboData();
	loadObjectDataGrid();
/* 	updateUrl('/icpmg/sockjs/echo');
	updateTransport('all');
	connect(); */
	
});

function connect() {
	
	 if(window.ipsobjects){
		 window.ipsobjects.close();
		 window.ipsobjects=null;
	 }

	
    if (!url) {
        alert('Select whether to use W3C WebSocket or SockJS');
        return;
    }

    ws = (url.indexOf('sockjs') != -1) ? 
        new SockJS(url, undefined, {protocols_whitelist: transports}) : new WebSocket(url);

   	window.ipsobjects=ws;    
        
    ws.onopen = function () {
       
       // console.log('Info: connection opened.');
    };
    ws.onmessage = function (event) {
    	 //alert(event);
      //  console.log('Received: ' + event.data);
        $('#ips_object_grid').datagrid('reload');
    };
    ws.onclose = function (event) {
       
      // console.log('Info: connection closed.');
      // console.log(event);
    };
}

function disconnect() {
    if (ws != null) {
        ws.close();
        ws = null;
    }
   
}

function updateUrl(urlPath) {
    if (urlPath.indexOf('sockjs') != -1) {
        url = urlPath;

    }
    else {
      if (window.location.protocol == 'http:') {
          url = 'ws://' + window.location.host + urlPath;
      } else {
          url = 'wss://' + window.location.host + urlPath;
      }

    }
}

function updateTransport(transport) {
  transports = (transport == 'all') ?  [] : [transport];
}

//查询结果
function loadObjectDataGrid(){
	$('#ips_object_grid').datagrid({
		singleSelect:true,
		rownumbers : false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		method : 'post',
		loadMsg : '数据装载中......',
		fitColumns : true,
		pagination : true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		toolbar:ipstoolbar,    
	    url:'${pageContext.request.contextPath}/security/querySecurityList.do?funtype=3',
	    onLoadSuccess : function(data) {
			var pageopt = $('#ips_object_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var _rows = $('#ips_object_grid').datagrid("getRows").length;
			var total = pageopt.total; //显示的查询的总数
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {operation : ''});
				}
				$('#ips_object_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
						total: total,
				});
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
			var rows = data.rows;
			if (rows.length) {
				$.each(rows, function (idx, val) {
					if   (val.operation ==''){ 
						//addid为datagrid上一层的div id
						$('#addid  input:checkbox').eq(idx+1).css("display","none");
						}
				}); 
			}
		}
	    }); 
}
function searchDataGrid(){
	$('#ips_object_grid').datagrid('load',icp.serializeObject($('#conditionForm')));
};
function reset(){
	$('#conditionForm').form('reset');
	$('#ips_object_grid').datagrid('load',{});
}
function statusformater(value, row, index) {
	switch (value) {
		case "Running":
			return "运行中";
		case "Stopped":
			return "停止";
		case "Stopping":
			return "正在停止";
		case "Starting":
			return "启动中";
		case "Destroyed":
			return "已删除";
		case "Expunging":
			return "正在销毁";
		case "Creating":
			 return "创建中";
		case "error":
			return	"<a style=\"color:red;cursor:pointer;\" onclick=\"deletese('" + row.securityid + "');\">创建失败</a>"
	}
} 
function deletese(securityid){
	$.messager.confirm('系统提示信息', '当前记录无效，请删除！', function(r){
		if(r){
			$.ajax({
				 url:'${pageContext.request.contextPath}/security/deletese.do?',
				 type:'post',
				 async:false,
				 data:{securityid:securityid},
			     dataType:'json',  
			     success:function(data){      	
					if (data.success) {
						$.messager.alert('提示', data.msg, 'info');
					} else {
						$.messager.alert('提示', data.msg, 'error');
					}
					$('#ips_object_grid').datagrid("reload");
				}
			});
		}
	});
	
}

//下拉框数据
function loadComboData(){
	$('#separam_').combobox({ 
		data: [
		       {id: '', name: '请选择'},
		       {id: 'displayname', name: '名称'},
		       {id: 'regionname', name: '区域'},
		       {id: 'manip', name: '管理地址'},
		       {id: 'funip', name: '业务地址'},
		       {id: 'connip', name:'外连地址'},
		       {id: 'description', name: '描述'},
		       {id: 'curstat', name: '状态'}
		],   
	    valueField:'id',    
	    textField:'name',
	}); 
	$("#separam_").combobox('select', '');
}
</script>
<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
		<form id="conditionForm">
			<table >
				<tr>
					<td class="FieldInput2"><input name="separam" id="separam_" style="height:30px;width:160px"/></td>
					<td>&nbsp;&nbsp;<input class="easyui-textbox" name="sevalue" id="sevalue_" style="width:160px;height:30px;border:false"/></td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset()">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<div data-options="region:'center',border:false" id="addid">
		<table title="" style="width:100%;"  id="ips_object_grid">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'securityid',width:60,align:'center'">编码</th>
					<!-- <th data-options="field:'serviceid',width:60,align:'center'">编码</th> -->
					<th data-options="field:'displayname',width:50,align:'center'">名称</th>
					<th data-options="field:'manip',width:50,align:'center'">管理地址</th>
					<th data-options="field:'funip',width:50,align:'center'">业务地址</th>
					<th data-options="field:'connip',width:50,align:'center'">外连地址</th>
					<th data-options="field:'regionname',width:30,align:'center'">区域</th>
					<th data-options="field:'description',width:60,align:'center'">描述</th>
					<th data-options="field:'ctime',width:60,align:'center'">开通时间</th>
					<th data-options="field:'curstat',width:40,align:'center',formatter:statusformater">状态</th>
				</tr>
			</thead>
		</table>
		</div>
	</div>  
</div>
</body>

