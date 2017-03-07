<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
.j-guanli ,.j-guanli .l-btn-text,.j-guanli .l-btn-left {
    line-height: 24px;!important
}
.j-guanli {    margin-top: -3px; }
</style>
<script type="text/javascript">
   var resourceStatus = 0; 
   var row;
   var ws = null;
   var url = null;
   var transports = [];
   updateUrl('/icpmg/sockjs/echo');
   connect();
  
  /* var windowHtml3 = $('#serviceWindow3').html(); */
  function updateUrl(urlPath) {
		if (urlPath.indexOf('sockjs') != -1) {
			url = urlPath;

		} else {
			if (window.location.protocol == 'http:') {
				url = 'ws://' + window.location.host + urlPath;
			} else {
				url = 'wss://' + window.location.host + urlPath;
			}

		}
	} 
  
  function connect() {
	    if(window.eventactive){
			window.eventactive.close();
			window.eventactive=null;
		}
		if (!url) {
			alert('Select whether to use W3C WebSocket or SockJS');
			return;
		}
		ws = (url.indexOf('sockjs') != -1) ? new SockJS(url, undefined, {
			protocols_whitelist : transports
		}) : new WebSocket(url);
        window.eventactive = ws;
		ws.onopen = function() {
          
		};
		ws.onmessage = function(event) {
		var data = event.data;
		var data =  JSON.parse(data);
		var info = data.msg;
		if(data.type=="add"){
			if(data.flag=="success" ){
			    $.messager.alert('提示',data.vmname+"加保护成功!","info");
			    $('#fw_object_grid').datagrid('reload');
			}else{
				$.messager.alert('提示',data.vmname+"加保护失败!","info");
				$('#fw_object_grid').datagrid('reload');
			}
		}else{
			if(data.flag=="success" ){
			    $.messager.alert('提示',data.vmname+"去保护成功!","info");
			    $('#fw_object_grid').datagrid('reload');
			}else{
				$.messager.alert('提示',data.vmname+"去保护失败!","info");
				$('#fw_object_grid').datagrid('reload');
			}
		}
		
		};
		ws.onclose = function(event) {
 
		};
	}
    
     // 弹层
     $('#vmcenterInit').dialog({
         title: "资源绑定",
         width: 550,
         height: 350,
         closed: true,
         modal: true,
         collapsible: false,
         minimizable: false,
         maximizable: false,
         resizable: false,
         closable:false,
         buttons: [
         {
             text: '提交',
             iconCls: 'icon-ok',
             handler: function() {
                 addBindResource();
             }
         }, {
             text: '关闭',
             iconCls: 'icon-cancel',
             handler: function() {
                 $('#vmcenterInit').window('close');
             }
         }]
     });
     
function loadVmDataGrid(cuserid,securityid,manip,objectid){
	$('#VmConfigTable').datagrid({
		singleSelect:true,
		rownumbers : false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		height:236,
		method : 'post',
		loadMsg : '数据装载中......',
		fitColumns : true,
		pagination : false,
		queryParams:{cuserid:cuserid,securityid:securityid,manip:manip,objectid:objectid},
	    url:'${pageContext.request.contextPath}/security/getVmlist.do',
	    onLoadSuccess : function(data) {
			var pageopt = $('#fw_object_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var total = pageopt.total;
			var _rows = $('#fw_object_grid').datagrid("getRows").length;
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {curstat : ''});
				}
				 $('#fw_object_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    		total: total,
			     });
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
			 //设置不显示复选框
			var rows = data.rows;
			if (rows.length) {
				$.each(rows, function (idx, val) {
					if   (val.operation ==''){ 
						//addid为datagrid上一层的div id
						$('#addid  input:checkbox').eq(idx+1).css("display","none");
						}
					}); 
			 }
		},
		 //没数据的行不能被点击选中
		 onClickRow: function (rowIndex, rowData) {
					if   (rowData.operation ==''){
						 $(this).datagrid('unselectRow', rowIndex);
					}else{
						//点击有数据的行  标志位变为0
						flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
		}, 
	    }); 
	    $("#rownum").val(-1);
}

function fwOperate(value, row, index) {
	if(!value){
		return "";
	}
	if(row.curstat=='Running' && row.protype==1){//东西向防火墙
		if(row.neid==null){
			var str = "<div style=\"height:30px;overflow:hidden;\"><a href=\"javascript:void(0);\" onclick=\"vmcenterInit(\'" 
				+ row.cuserid  +  "\', \'" + row.securityid + "\', \'"  + row.manip + "\', \'"  + row.objectid + "\');\" class=\"j-guanli\" iconCls=\"icon-bangding\" plain=\"true\" title=\"防护资源\"></a>";
		}else if(row.neid=='changing'){
			var str = "<div style=\"height:30px;overflow:hidden;\"><a href=\"javascript:void(0);\" onclick=\"bindingTip();\" class=\"j-guanli\" iconCls=\"icon-bangding\" plain=\"true\" title=\"防护资源\"></a>";
		}else{
			var str = "<div style=\"height:30px;overflow:hidden;\"><a href=\"javascript:void(0);\" onclick=\"initFw(\'" 
				+ row.objectid  + "\');\" class=\"j-guanli\" iconCls=\"icon-objmanage\" plain=\"true\" title=\"管理\"></a><span class=\"gproducts-partingline\">|</span><a href=\"javascript:void(0);\"   onclick=\"removeBindResource(\'" 
				+ row.neid  +  "\', \'" + row.securityid + "\', \'"  + row.manip + "\', \'"  + row.objectid + "\');\" class=\"j-guanli\" iconCls=\"icon-jiebang\" plain=\"true\" title=\"解除绑定\"></a>";
		}
	}else if(row.curstat=='Running' && row.protype==0){//南北向防火墙
		var str = "<div style=\"height:30px;overflow:hidden;\"><a href=\"javascript:void(0);\" onclick=\"initFw(\'" 
				+ row.objectid  + "\');\" class=\"j-guanli\" iconCls=\"icon-objmanage\" plain=\"true\" title=\"管理\" ></a>";
	}else if(row.curstat=='Destroyed'){//已销毁资源
		var str = "";
	}
	
	return str;
}
function protypeformater(value, row, index) {
	if(!value){
		return "";
	}
	switch (value) {
		case "0":
			return "南北";
		case "1":
			return "东西";
	}
} 
function vmcenterInit(cuserid,securityid,manip,objectid){
	$('#vmcenterInit').attr('style','visibility:visible');
	$('#manip_ew').val(manip);
	$('#securityid_ew').val(securityid);
	$('#cuserid').val(cuserid);
	$('#serviceid_ew').val(objectid);
	$('#vmcenterInit').dialog({
        closed: false
    });
    loadVmDataGrid(cuserid,securityid,manip,objectid);
   
}

function addBindResource(){
	if($("#rownum").val()=='-1'){
		$.messager.alert('提示信息','请选择一个被防护资源！', 'info');
		return;
	}
	var row = $('#VmConfigTable').datagrid('getData').rows[$("#rownum").val()];
	var neid = row.neid;
	var hostip = row.hostip;
	var ipsync = row.ipsync;
	var filter = row.filter;
	var protection = row.protection;
    $('#vmcenterForm').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/changeBindResource.do",    
	    onSubmit: function(param){
	   		param.neid = neid;
	    	param.hostip = hostip;
	    	param.ipsync = ipsync;
	    	param.filter = filter;
	    	param.protection = protection;
	    	param.securityid = $("#securityid_ew").val(); 
	    	param.manip = $("#manip_ew").val();
	    	param.objectid = $("#serviceid_ew").val();
	    	param.operateType = "add";
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){   
	        	alert("加保护命令已提交！");
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        } 
	        $('#fw_object_grid').datagrid('reload'); 
	        $('#vmcenterInit').window('close');
	    }  
	});  
}

function removeBindResource(neid,securityid,manip,objectid){
 	$.messager.confirm('系统提示信息', '确定解绑该实例上的资源吗？', function(r){
		if (r){
			$.ajax({  
				url:"${pageContext.request.contextPath}/security/changeBindResource.do",   
			  	type:'post',  
			    async: false,
			    data: {neid:neid,securityid:securityid,manip:manip,objectid:objectid,operateType:"remove"},    
			    dataType:'text',
			    success:function(data){ 
			    	var _data = $.parseJSON(data);
					if (_data.success) {
						alert("去保护命令已提交！");
					} else {
						$.messager.alert('提示', "删除操作失败，请重试！", 'error');
					}
					$('#fw_object_grid').datagrid('reload'); 
			    }	    
			});
		}
	});
}

function bindingTip(){
	$.messager.alert('提示信息','正在改变资源保护状态！', 'info'); 
}
function initFw(objectid){
	$('#centerTab').panel({
		href:"${pageContext.request.contextPath}/security/fwManageInit.do" ,
		queryParams:{objectid:objectid}
	});
}
$("#VmConfigTable").datagrid({
		//行点击事件
		onClickRow: function (rowIndex, rowData) {
			$("#rownum").val(rowIndex);
		},
		//行选择事件
		onSelect: function (rowIndex, rowData) {
			$("#rownum").val(rowIndex);
			
		}
	});
</script>

<div id="vmcenterInit" class="pop" style="visibility: hidden;">
    <p style="padding: 0;  color: #08c;     margin: 6px 0 6px 15px;">请选择被防护资源：</p>
    <style>.table-data td{text-align: center;}</style>
    <form id="vmcenterForm" method="post" data-options="novalidate:true" style="padding:0 10px">
    <input type="hidden" id="rownum" name="rownum">
	<input type="hidden" id="securityid_ew" name="securityid">
	<input type="hidden" id="manip_ew" name="manip">
	<input type="hidden" id="serviceid_ew" name="serviceid">
    <table width="100%" border="0" class="easyui-datagrid" id="VmConfigTable"  >   
    <thead>   
        <tr>   
            <th data-options="field:'ck',checkbox:true"></th>
            <th data-options="field:'neid',width:100,align:'center'">编码</th>   
            <th data-options="field:'hostip',width:100,align:'center'">IP</th>   
        </tr>   
    </thead>   
    </table>
    </form>
</div>

</body>
