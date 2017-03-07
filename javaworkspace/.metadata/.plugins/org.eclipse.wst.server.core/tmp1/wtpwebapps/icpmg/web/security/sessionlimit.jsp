<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
select{
	width:10.5%;
	height:30px;
}
.FieldInput3 {
	width:12%;
	height: 30px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}
.FieldLabel3 {
	width:8%;
	height: 30px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align:left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
</style>	
<script type="text/javascript">
var grid;
var sltoolbar = [
						{
							text:'新增会话限制',
							iconCls:'icon-add',
							handler:function(){ 
								
								// 弹层
							    $('#slw').dialog({
							        title: "新增会话限制",
							        width: 650,
							        height: 420,
							        closed: true,
							        modal: true,
							        collapsible: false,
							        minimizable: false,
							        maximizable: false,
							        resizable: false,
							        buttons: [{
					                    text: '提交',
					                    iconCls: 'icon-ok',
					                    handler: function() {
					                    	addsl();
					                    }
					                }, {
					                    text: '取消',
					                    iconCls: 'icon-cancel',
					                    handler: function() {
					                    	$('#slw').window('close');
					                    }
					                }]
							        
							    });
								
								
								$('#slCreateForm').form('clear');
								//$('#domain').combobox('select','trust');
								$('#domainid').val('');
								$('#domain_session').combobox('setValue','');
								//$('#domainid').val('trust');
								//限制条件必须选，目前只有ip限制所以默认选择ip限制，后期增加其他条件后去掉此处默认选择
								$("#iplimit").attr("checked", "checked");
								//限制条件必须选，目前只有ip限制所以默认选择ip限制，后期增加其他条件后去掉此处默认选择
								
								//ip限制
								$("input[name='iplimit'][value=" + 0 + "]").attr("checked",true);
								
								$("#addr").combo({disabled:false});  
								$("#addr").combobox('setValue',"Any");
								$("#addrtype").combobox({disabled:false});
								$("#addrtype").combobox('setValue',"0");
								$("#ssaddr").combo({disabled:true,value:"" });  
								$("#saddrtype").combo({disabled:true,value:""}); 
								$("#ddaddr").combo({disabled:true,value:""});  
								$("#daddrtype").combo({disabled:true,value:""}); 
								//限制类型
								$("input[name='sessiontype'][value=" + 1 + "]").attr("checked",true);
								$("#sessiontypev1").textbox({disabled:false }); 
								
								$("#sessiontypev2").textbox({disabled:true,value:""});
								$('#slw').window('open');
							}
						}
                       ];
$(document).ready(function() {
	sl_loadDataGrid();
});
//查询结果
function sl_loadDataGrid(){
	grid = $('#sl_grid').datagrid({
		rownumbers: false,
        checkOnSelect: true,
        selectOnCheck: true,
        scrollbarSize: 0,
        border: false,
        striped : true,
        nowarp: false,
        singleSelect: false,
        method: 'post',
        loadMsg: '数据装载中......',
        fitColumns: true,

        pagination: true,
        pageSize: 10,
        pageList: [5, 10, 20, 30, 40, 50],
		toolbar:sltoolbar,    
	    url:'${pageContext.request.contextPath}/security/sLimitList.do?securityid=' + $("#tabs_security_id").val() ,
	    onLoadSuccess : function(data) {
			var pageopt = $('#sl_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var _rows = $('#sl_grid').datagrid("getRows").length;
			var total = pageopt.total;
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {domainid : ''});
				}
				$('#sl_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
					total: total,
			});
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
			
			
			$('.j-delete').linkbutton({
                iconCls: 'icon-delete',
                plain: true
   		    });
			$('.j-modify').linkbutton({
                iconCls: 'icon-modify',
                plain: true
   		    });
		} 
	 }); 
	
	
	
 
}
function sl_reset(){
	$('#sl_grid').datagrid('load',{});
}
//源ip目的ip列格式化
function sl_iplimitformater(value, row, index) {
	if(!value){
		return "";
	}
	var str = ""; 
	if(row.iplimittype == '0'){
		if(row.addrname == 'Any'){
			str = "Any-->Any";
		}else{
			str = row.addrname + "-->Any;Any-->" + row.addrname;
		}
	}else{
		str = row.saddrname + "-->" + row.daddrname;
	}
	
	return str;
}
//类型列格式化
function sl_setypeformater(value, row, index) {
	var str = "";
	if(row.sessiontype == '1'){
		str = "会话数：";
		if(row.sessiontypev == '0'){
			str += "不限制";
		}else{
			str += row.sessiontypev;
		}
	}else if(row.sessiontype == '2'){
		str = "每5秒新建会话数：" + row.sessiontypev;
	}
	return str;
}
//操作列格式化
function sl_slformater(value, row, index) {
	if(!value){
		return "";
	}
	var str = "<a href=\"javascript:void(0);\" onclick=\"getsl(\'" + row.slid + "\',\'" + row.domainid
			+ "\',\'" + row.iplimittype + "\',\'" + row.addrid+ "\',\'" + row.addrtype
			+ "\',\'" + row.saddrid+ "\',\'" + row.saddrtype+ "\',\'" + row.daddrid
			+ "\',\'" + row.daddrtype+ "\',\'" + row.sessiontype+ "\',\'" + row.sessiontypev
			+ "\');\" title=\"修改\" class=\"j-modify\"></a><span class=\"gproducts-partingline\">|</span><a href=\"javascript:void(0);\" onclick=\"sl_delbefore(\'" + row.slid + "\',\'" + row.domainid + "\');\" title=\"删除\" class=\"j-delete\"></a>"; 
	return str;
} 
//修改配置前获取信息展示
function getsl(slid, domainid, iplimittype, addrid, addrtype, saddrid, saddrtype, daddrid, daddrtype, sessiontype, sessiontypev){
	// 弹层
    $('#slw1').dialog({
        title: "修改会话限制",
        width: 650,
        height: 420,
        closed: true,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        buttons: [{
            text: '提交',
            iconCls: 'icon-ok',
            handler: function() {
            	editsl();
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
            	$('#slw1').window('close');
            }
        }]
    });
	
	
	$('#slCreateForm1').form('clear');
	
	$("#slid").val(slid);
	$("#domainid1").val(domainid);
	$('#domain1').combobox('setValue', domainid);
	$("#iplimit1").attr("checked", "checked");//默认选中
	
	$("input[name='iplimit1'][value=" + iplimittype + "]").attr("checked",true);
	if(iplimittype == "0"){
		$("#addr1").combo({disabled:false});  
		$("#addrtype1").combo({disabled:false});
		$("#ssaddr1").combo({disabled:true,value:"" });  
		$("#saddrtype1").combo({disabled:true,value:""});  
		$("#ddaddr1").combo({disabled:true,value:""});  
		$("#daddrtype1").combo({disabled:true,value:""});  
			
		$('#addr1').combobox('setValue', addrid);
		$('#addrtype1').combobox('setValue', addrtype);
		
	}else{
		$("#addr1").combo({disabled:true,value:"" });  
		$("#addrtype1").combo({disabled:true,value:""});
		
		$('#ssaddr1').combobox('setValue', saddrid);
		$('#saddrtype1').combobox('setValue', saddrtype);
		$('#ddaddr1').combobox('setValue', daddrid);
		$('#daddrtype1').combobox('setValue', daddrtype);
		
	}
	if(sessiontype==1){
			$("#sessiontypev11").textbox({disabled:false,value:"" });  
			$("#sessiontypev21").textbox({disabled:true,value:""});
	}else{
			$("#sessiontypev11").textbox({disabled:true,value:"" });  
			$("#sessiontypev21").textbox({disabled:false,value:""});
	}
	
	$("input[name='sessiontype1'][value=" + sessiontype + "]").attr("checked",true);
	$('#sessiontypev' + sessiontype + '1').textbox('setValue', sessiontypev).textbox('setText', sessiontypev);
	
	$('#slw1').window('open');
}
function editsl(){
	var slid = $("#slid").val();
	var domainid = $("#domainid1").val();
	
	var iplimit = 0;
	//var iplimit_flag = $("#iplimit1").attr("checked");
	/* if($("#iplimit1").prop("checked")){
		iplimit = 1;
	} */
	if($("a[id='iplimit1']")){
		iplimit = 1;
	}
	
	var iplimittype = $("input[name='iplimit1']:checked").val(); //0：ip限制，1：源ip目的ip
	var addrid = "";
	var addrname = "";
	var addrtype = "";
	var saddrid = "";
	var saddrname = "";
	var saddrtype = "";
	var daddrid = "";
	var daddrname = "";
	var daddrtype = "";
	if(iplimittype == "0"){
		addrid = $('#addr1').combobox('getValue');
		addrname = $('#addr1').combobox('getText');
		addrtype = $('#addrtype1').combobox('getValue');
		
		if(null == addrid || "" == addrid || null == addrtype || "" == addrtype){
			$.messager.alert('提示信息','IP限制不能为空！', 'info');
			return;
		}
	}else{
		saddrid = $('#ssaddr1').combobox('getValue');
		saddrname = $('#ssaddr1').combobox('getText');
		saddrtype = $('#saddrtype1').combobox('getValue');
		daddrid = $('#ddaddr1').combobox('getValue');
		daddrname = $('#ddaddr1').combobox('getText');
		daddrtype = $('#daddrtype1').combobox('getValue');
		
		if(null == saddrid || "" == saddrid || null == saddrtype || "" == saddrtype ||null == daddrid || "" == daddrid || null == daddrtype || "" == daddrtype ){
			$.messager.alert('提示信息','源IP和目的IP均不能为空！', 'info');
			return;
		}
	}
	var sessiontype = $("input[name='sessiontype1']:checked").val();//0：会话数，1：每5秒新建会话数
	var sessiontypev = $('#sessiontypev' + sessiontype + '1').textbox('getValue');
	
	if(sessiontype ==1 && (null == sessiontypev || "" == sessiontypev || sessiontypev>1000 || sessiontypev<0)){
			$.messager.alert('提示信息','会话数(0~1000;0表示不限制)', 'info');
			return;
	}
	if(sessiontype ==2 && (null == sessiontypev || "" == sessiontypev || sessiontypev>1000 || sessiontypev<1)){
			$.messager.alert('提示信息','每5秒新建会话数(1~1000)', 'info');
			return;
	}
	
    $('#slCreateForm1').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/editSLimit.do",    
	    onSubmit: function(param){ 
	     	param.securityid = $("#tabs_security_id").val(); 
	    	param.objectid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val();
	    	param.slid = slid;
	        param.domainid = domainid;    
	        param.iplimit = iplimit; 
	        param.iplimittype = iplimittype;    
	        param.addrid = addrid;
	        param.addrname = addrname;
	        param.addrtype = addrtype;
	        param.saddrid = saddrid;
	        param.saddrname = saddrname;
	        param.saddrtype = saddrtype;
	        param.daddrid = daddrid;
	        param.daddrname = daddrname;
	        param.daddrtype = daddrtype;
	        param.sessiontype = sessiontype;
	        param.sessiontypev = sessiontypev;
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){    
	        	sl_loadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
	        $('#slw1').window('close');
	    }    

	});  
}
function sl_delbefore(slid, domainid){
	$.messager.confirm('系统提示信息', '当前配置删除后不可恢复，请谨慎操作，确定删除吗？', function(r){
		if (r){
			$('#slManForm').form('submit',{
			    url:'${pageContext.request.contextPath}/security/delSLimit.do', 
			    onSubmit : function(param) {
			    	param.securityid = $("#tabs_security_id").val(); 
			    	param.objectid = $("#tabs_service_id").val();
			    	param.displayname = $("#tabs_displayname").val();
			    	param.manip = $("#tabs_manip").val(); 
					param.slid = slid;
					param.domainid = domainid;
				},
			    success:function(retr){
			    	var _data = $.parseJSON(retr);
			    	if (_data.success) {
						sl_loadDataGrid();
					} else {
						$.messager.alert('提示', "删除操作失败，请重试！", 'error');
					}
			    }
			});
		}
	});
}

$('#domain_session').combobox({    
	onSelect: function(rec){
		$('#domainid').val(rec.value);
    }
});
//新增配置信息保存
function addsl(){
	var domainid = $("#domainid").val();
	if(null == domainid || "" == domainid || null == domainid || "" == domainid){
			$.messager.alert('提示信息','安全域不能为空！', 'info');
			return;
	}
	var iplimit = 0;
	//var iplimit_flag = $("#iplimit").prop("checked");
	if($("a[id='iplimit']")){
		iplimit = 1;
	}
	/* if($("#iplimit").prop("checked")){
		iplimit = 1;
	} */
	
	var iplimittype = $("input[name='iplimit']:checked").val(); //0：ip限制，1：源ip目的ip
	var addrid = "";
	var addrname = "";
	var addrtype = "";
	var saddrid = "";
	var saddrname = "";
	var saddrtype = "";
	var daddrid = "";
	var daddrname = "";
	var daddrtype = "";
	if(iplimittype == "0"){
		addrid = $('#addr').combobox('getValue');
		addrname = $('#addr').combobox('getText');
		addrtype = $('#addrtype').combobox('getValue');
		
		if(null == addrid || "" == addrid || null == addrtype || "" == addrtype){
			$.messager.alert('提示信息','IP限制不能为空！', 'info');
			return;
		}
	}else{
		saddrid = $('#ssaddr').combobox('getValue');
		saddrname = $('#ssaddr').combobox('getText');
		saddrtype = $('#saddrtype').combobox('getValue');
		daddrid = $('#ddaddr').combobox('getValue');
		daddrname = $('#ddaddr').combobox('getText');
		daddrtype = $('#daddrtype').combobox('getValue');
		
		if(null == saddrid || "" == saddrid || null == saddrtype || "" == saddrtype ||null == daddrid || "" == daddrid || null == daddrtype || "" == daddrtype ){
			$.messager.alert('提示信息','源IP和目的IP均不能为空！', 'info');
			return;
		}
	}
	var sessiontype = $("input[name='sessiontype']:checked").val();//0：会话数，1：每5秒新建会话数
	var sessiontypev = $('#sessiontypev' + sessiontype).textbox('getValue');
	
	if(sessiontype ==1 && (null == sessiontypev || "" == sessiontypev || sessiontypev>1000 || sessiontypev<0)){
			$.messager.alert('提示信息','会话数(0~1000;0表示不限制)', 'info');
			return;
	}
	if(sessiontype ==2 && (null == sessiontypev || "" == sessiontypev || sessiontypev>1000 || sessiontypev<1)){
			$.messager.alert('提示信息','每5秒新建会话数(1~1000)', 'info');
			return;
	}
    $('#slCreateForm').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/saveSLimit.do",    
	    onSubmit: function(param){ 
	     	param.securityid = $("#tabs_security_id").val(); 
	    	param.objectid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val();
	        param.domainid = domainid;    
	        param.iplimitv = iplimit; 
	        param.iplimittype = iplimittype;    
	        param.addrid = addrid;
	        param.addrname = addrname;
	        param.addrtype = addrtype;
	        param.saddrid = saddrid;
	        param.saddrname = saddrname;
	        param.saddrtype = saddrtype;
	        param.daddrid = daddrid;
	        param.daddrname = daddrname;
	        param.daddrtype = daddrtype;
	        param.sessiontype = sessiontype;
	        param.sessiontypev = sessiontypev;
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){    
	        	sl_loadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
	        $('#slw').window('close');
	    }    

	});  
}


$(function(){
	$("input[name='iplimit']").click(function(){
		var data = $("input[name='iplimit']:checked").val(); //0：ip限制，1：源ip目的ip
		if(data==1){
			$("#addr").combo({disabled:true,value:"" });  
			$("#addrtype").combo({disabled:true,value:""});
			$("#ssaddr").combo({disabled:false});  
			$("#ssaddr").combobox("setValue","Any");
			$("#saddrtype").combo({disabled:false});
			$("#saddrtype").combobox("setValue","0");
			$("#ddaddr").combo({disabled:false});  
			$("#ddaddr").combobox("setValue","Any");
			$("#daddrtype").combo({disabled:false});
			$("#daddrtype").combobox("setValue","0");
		}else{
			$("#addr").combo({disabled:false ,value:"Any"}); 
			$("#addr").combobox("setValue","Any");
			$("#addrtype").combo({disabled:false});
			$("#addrtype").combobox("setValue","0");
			$("#ssaddr").combo({disabled:true,value:"" });  
			$("#saddrtype").combo({disabled:true,value:""});  
			$("#ddaddr").combo({disabled:true,value:""});  
			$("#daddrtype").combo({disabled:true,value:""});  
		}
	});
	
	$("input[name='sessiontype']").click(function(){
		var data = $("input[name='sessiontype']:checked").val(); //1：会话数，2：每5秒新建会话数
		      	
		if(data==1){
			$("#sessiontypev1").textbox({disabled:false,value:"" });  
			$("#sessiontypev2").textbox({disabled:true,value:""});
		}else{
			$("#sessiontypev1").textbox({disabled:true,value:"" });  
			$("#sessiontypev2").textbox({disabled:false,value:""});
		}
	});
	
	
	$("input[name='iplimit1']").click(function(){
		var data = $("input[name='iplimit1']:checked").val(); //0：ip限制，1：源ip目的ip
		      	
		if(data==1){
			$("#addr1").combo({disabled:true,value:"" });  
			$("#addrtype1").combo({disabled:true,value:""});
			$("#ssaddr1").combo({disabled:false,value:"" });  
			$("#saddrtype1").combo({disabled:false,value:""});  
			$("#ddaddr1").combo({disabled:false,value:"" });  
			$("#daddrtype1").combo({disabled:false,value:""});  
		}else{
			$("#addr1").combo({disabled:false ,value:""});  
			$("#addrtype1").combo({disabled:false,value:""});  
			$("#ssaddr1").combo({disabled:true,value:"" });  
			$("#saddrtype1").combo({disabled:true,value:""});  
			$("#ddaddr1").combo({disabled:true,value:""});  
			$("#daddrtype1").combo({disabled:true,value:""});  
		}
	});
	
	$("input[name='sessiontype1']").click(function(){
		var data = $("input[name='sessiontype1']:checked").val(); //1：会话数，2：每5秒新建会话数
		      	
		if(data==1){
			$("#sessiontypev11").textbox({disabled:false,value:"" });  
			$("#sessiontypev21").textbox({disabled:true,value:""});
		}else{
			$("#sessiontypev11").textbox({disabled:true,value:"" });  
			$("#sessiontypev21").textbox({disabled:false,value:""});
		}
	});	
});

$('#saddrtype').combobox({    
	onSelect: function(rec){
		var daddrtype = $('#daddrtype').combobox('getValue');
	 	if(rec.value==1 && daddrtype ==1){
	 		$('#daddrtype').combobox('setValue', "0");
	 	}
    }
});

$('#daddrtype').combobox({    
	onSelect: function(rec){
		var saddrtype = $('#saddrtype').combobox('getValue');
	 	if(rec.value==1 && saddrtype ==1){
	 		$('#saddrtype').combobox('setValue', "0");
	 	}
		
    }
});
$('#saddrtype1').combobox({    
	onSelect: function(rec){
		var daddrtype1 = $('#daddrtype1').combobox('getValue');
	 	if(rec.value==1 && daddrtype1 ==1){
	 		$('#daddrtype1').combobox('setValue', "0");
	 	}
    }
});

$('#daddrtype1').combobox({    
	onSelect: function(rec){
		var saddrtype1 = $('#saddrtype1').combobox('getValue');
	 	if(rec.value==1 && saddrtype1 ==1){
	 		$('#saddrtype1').combobox('setValue', "0");
	 	}
		
    }
});
</script>
<form id="slManForm"></form>
<div data-options="region:'center',border:false">
	<table title="" style="width:100%;"  id="sl_grid">
		<thead>
			<tr>
				<th data-options="field:'slid',width:10,align:'center'">ID</th>
				<th data-options="field:'domainname',width:10,align:'center'">安全域</th>
				<th data-options="field:'iplimittype',width:30,align:'center',formatter:sl_iplimitformater">源IP->目的IP</th>
				<th data-options="field:'sessiontype',width:20,align:'center',formatter:sl_setypeformater">类型</th>
				<!-- <th data-options="field:'dsnum',width:10,align:'center'">丢弃会话数</th> -->
				<th data-options="field:'domainid',width:10,align:'center',formatter:sl_slformater">操作</th>
			</tr>
		</thead>
	</table>
</div>



<div id="slw" class="easyui-window pop" data-options="closed:true">
		<div style="padding:10px;">
			<form id="slCreateForm" method="post" data-options="novalidate:true">
			    <table style="width:100%;border:0;"  class="table-layout">
	                <tr>
	                    <td align="right" width="19%">安全域：</td>
	                    <td align="left">
	                        <input type="hidden" id="domainid"/>
	                        <select id="domain_session" class="easyui-combobox" name="" style="width: 150px;" data-options="panelHeight:'auto',editable:false">
	                            <option value="">请选择</option>
                                <option value="trust">trust</option>
                                <option value="untrust">untrust</option>
	                        </select>
	                    </td>
	                </tr>
               </table>
		    <p class="spanceline"></p>
            <div class="item2">
                <div class="item-title">限制条件</div>
                <table style="width:100%;border:0;" class="table-layout">
                    <tr>
                        <td width="18%" rowspan="3" align="right">
                            <div style="border-right: 1px solid #ddd;    padding: 30px 10px 30px 0;    margin: 0 0px 0 6px;"> <a href="javascript:void(0)" id="iplimit"  style="width: 90px;"  class="default-btn-demo1 active j-ipxz">IP限制</a></div>
                        </td>
                        <td width="16%" align="left">
                            <label>
                                <input type="radio" name="iplimit" value="0" > IP限制：
                            </label>
                        </td>
                        <td width="33%">
                            <select id="addr" class="easyui-combobox" name="" style="width: 150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="Any">Any</option>
                            </select>
                        </td>
                        <td width="33%">
                            <select id="addrtype" class="easyui-combobox" name="" style="width: 150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="0">所有IP</option>
							    <option value="1">每个IP</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="16%" align="left">
                            <label for="">
                                <input type="radio" name="iplimit" value="1"> 源IP：
                            </label>
                        </td>
                        <td width="33%">
                            <select id="ssaddr" class="easyui-combobox" name="" style="width: 150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="Any">Any</option>
                            </select>
                        </td>
                        <td width="33%">
                            <select id="saddrtype" class="easyui-combobox" name="" style="width: 150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="0">所有源IP</option>
							    <option value="1">每个源IP</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="16%" align="left">
                            &nbsp;&nbsp;&nbsp;&nbsp;目的IP：
                        </td>
                        <td width="33%">
                            <select id="ddaddr" class="easyui-combobox" name="" style="width: 150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="Any">Any</option>
                            </select>
                        </td>
                        <td width="33%">
                            <select id="daddrtype" class="easyui-combobox" name="" style="width: 150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="0">所有目的IP</option>
							    <option value="1">每个目的IP</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
			<div class="item2">
                <div class="item-title">限制类型</div>
                <table style="width:100%;border:0;"  class="table-layout">
                    <tr>
                        <td width="18%" rowspan="2" align="right">
                            <div style="border-right: 1px solid #ddd;    padding: 30px 10px 30px 0;    margin: 0 0px 0 6px;"> <a href="javascript:void(0)" style="width: 90px;">会话类型：</a></div>
                        </td>
                        <td width="16%" align="left">
                            <label for="">
                                <input type="radio" name="sessiontype" value="1"> 会话数：
                            </label>
                        </td>
                        <td>
                            <input type="text" id="sessiontypev1" class="easyui-numberbox" style="width:150px;"  data-options="prompt:'0-1000；0表示不限制'">
                        </td>
                    </tr>
                    <tr>
                        <td width="22%" align="left">
                            <label for="">
                                <input type="radio" name="sessiontype" value="2"> 每5s新建会话数
                            </label>
                        </td>
                        <td>
                            <input type="text" id="sessiontypev2" class="easyui-numberbox" style="width: 150px;" data-options="prompt:'1-1000'">
                        </td>
                    </tr>
                </table>
            </div>
            </form>
            </div>
        </div>
<div id="slw1" class="easyui-window pop" data-options="closed:true">
       <div style="padding:10px;">
			<form id="slCreateForm1" method="post" data-options="novalidate:true">
			   <table style="width:100%;border:0;"  class="table-layout">
	                <tr>
	                    <td align="right" width="19%">安全域：</td>
	                    <td align="left">
	                        <input type="hidden" id="domainid1"/>
						    <input type="hidden" id="slid"/>
	                        <span style="display:inline-block;margin-left: 25px;">
							<select id="domain1" class="easyui-combobox" style="width:150px;" data-options="panelHeight:'auto',editable:false,disabled:true">
								<option value="">请选择</option>
                                <option value="trust">trust</option>
                                <option value="untrust">untrust</option>
							</select>
							</span>
	                    </td>
	                </tr>
               </table>
				<p class="spanceline"></p>
            <div class="item2">
                <div class="item-title">限制条件</div>
                <table style="width:100%;border:0;" class="table-layout">
                    <tr>
                        <td width="18%" rowspan="3" align="right">
                            <div style="border-right: 1px solid #ddd;    padding: 30px 10px 30px 0;    margin: 0 0px 0 6px;"> <a href="javascript:void(0)" id="iplimit1"  style="width: 90px;" class="default-btn-demo1 active j-ipxz">IP限制</a></div>
                        </td>
                        <td width="16%" align="left">
                            <label>
                                <input type="radio" name="iplimit1" value="0" > IP限制：
                            </label>
                        </td>
                        <td width="33%">
                            <select id="addr1" class="easyui-combobox"  style="width: 150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="Any">Any</option>
                            </select>
                        </td>
                        <td width="33%">
                            <select id="addrtype1" class="easyui-combobox" name="" style="width: 150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="0">所有IP</option>
							    <option value="1">每个IP</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="16%" align="left">
                            <label for="">
                                <input type="radio" name="iplimit1" value="1"> 源IP：
                            </label>
                        </td>
                        <td width="33%">
                            <select id="ssaddr1" class="easyui-combobox" name="" style="width: 150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="Any">Any</option>
                            </select>
                        </td>
                        <td width="33%">
                            <select id="saddrtype1" class="easyui-combobox" name="" style="width: 150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="0">所有源IP</option>
							    <option value="1">每个源IP</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="16%" align="left">
                            &nbsp;&nbsp;&nbsp;&nbsp;目的IP：
                        </td>
                        <td width="33%">
                            <select id="ddaddr1" class="easyui-combobox" name="" style="width: 150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="Any">Any</option>
                            </select>
                        </td>
                        <td width="33%">
                            <select id="daddrtype1" class="easyui-combobox" name="" style="width: 150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="0">所有目的IP</option>
							    <option value="1">每个目的IP</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
				<div class="item2">
                <div class="item-title">限制类型</div>
                <table style="width:100%;border:0;"  class="table-layout">
                    <tr>
                        <td width="18%" rowspan="2" align="right">
                            <div style="border-right: 1px solid #ddd;    padding: 30px 10px 30px 0;    margin: 0 0px 0 6px;"> <a href="javascript:void(0)" style="width: 90px;">会话类型：</a></div>
                        </td>
                        <td width="16%" align="left">
                            <label for="">
                                <input type="radio" name="sessiontype1" value="1"> 会话数：
                            </label>
                        </td>
                        <td>
                            <input type="text" id="sessiontypev11" class="easyui-numberbox" style="width:150px;" data-options="prompt:'0-1000；0表示不限制'">
                        </td>
                    </tr>
                    <tr>
                        <td width="22%" align="left">
                            <label for="">
                                <input type="radio" name="sessiontype1" value="2"> 每5s新建会话数
                            </label>
                        </td>
                        <td>
                            <input type="text" id="sessiontypev21" class="easyui-numberbox" style="width: 150px;" data-options="prompt:'1-1000'">
                        </td>
                    </tr>
                </table>
            </div>
			</form>
		</div>
	  </div>	
</body>

