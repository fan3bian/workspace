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
var flagck = 0;  //  初始化为0
var gridips;
var pipstoolbar = [
						{
							text:'防护管理',
							iconCls:'icon-man',
							handler:function(){ 
								var rows = $('#ipshttp_grid').datagrid('getChecked');
								if(rows.length<1 || rows.length>1){
									$.messager.alert('消息','请选择一条记录！'); 
									return; 
								}
								var protecttype=rows[0].protecttype;
								if(protecttype.indexOf("http")!=-1){
									
								}else{
									$.messager.alert('提示','请先开启防护配置！','info'); 
									return; 
								}
								$('#centerTab').panel({
									href:"${pageContext.request.contextPath}/security/queryhttpIps.do",
									queryParams:{ipsid:rows[0].ipsid}
								});
							}
						},{
							text:'新增协议配置',
							iconCls:'icon-add',
							handler:function(){ 
								$('#ips_http_form').form('clear');
								$('#ipshttpdomain').combobox('setValue','');
								$("[name='ipshttpdirection'][value=2]").attr("checked",true);
								$('#ips_http').window('open');
							}
						}
                       ];
$(document).ready(function() {
	loadDataGrid();
});
$('#ipshttpdomain').combobox({    
	onSelect: function(rec){
		debugger;
		$('#ipshttpdomainid').val(rec.value);
		if(null != rec.value && "" != rec.value){
			$.ajax({  
			    url:'${pageContext.request.contextPath}/security/chkIpsByDomain.do',
			    type:'post',  
			    async: false,
			    data: {domainid: rec.value, securityid: $("#tabs_security_id").val()},    
			    dataType:'json',  
			    success:function(data){ 
			    	if(data.success){
			    		//如果成功返回，变新增为修改配置
			    		$.messager.alert('提示信息','当前安全域下已经配置了协议,不允许重复配置！', 'info'); 
			    		$('#addips').linkbutton("disable", true);
			    	}else{
			    		$('#addips').linkbutton("enable");
			    	}
			    }
			})
		}
    }
});
//查询结果
function loadDataGrid(){
	gridips = $('#ipshttp_grid').datagrid({
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
		toolbar:pipstoolbar,    
	    url:'${pageContext.request.contextPath}/security/queryIpsList.do?securityid=' + $("#tabs_security_id").val(),
	    onLoadSuccess : function(data) {
			var pageopt = $('#ipshttp_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var _rows = $('#ipshttp_grid').datagrid("getRows").length;
			var total = pageopt.total; //显示的查询的总数
			
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {ipsid : ''});
				}
			 	$('#ipshttp_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
						total: total,
				});
				
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
			//设置不显示复选框
								      var rows = data.rows;
								      if (rows.length) {
											 $.each(rows, function (idx, val) {
												if   (val.ipsid ==''){ 
													//addid为datagrid上一层的div id
													$('#addid  input:checkbox').eq(idx+1).css("display","none");
													 
												}
											}); 
								      }
		}
	   /*  ,onLoadSuccess : function(data) {
			var pageopt = $('#ipshttp_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var _rows = $('#ipshttp_grid').datagrid("getRows").length
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {operation : ''})
				}
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			} 
		}*/
	 }); 
}
//防护方向列格式化
function dformater(value, row, index) {
	var str = "";
	if(value == "2"){
		str = "双向";
	}else if(value == "1"){
		str = "流出";
	}else if(value == "0"){
		str = "流入";
	}
	return str;
}
//操作列格式化
function ipsoptionformater(value, row, index) {
	if(!value){
		return "";
	}
	var str = "";
	if(row.isoper == '0'){
		return str; 
	}
	var protecttype=row.protecttype;
	if(protecttype.indexOf("http")!=-1){
		str = "<a href=\"javascript:void(0);\" onclick=\"getips(\'"
			+ row.ipsname + "\', \'" + row.direction + "\', \'" + row.protecttype  + "\', \'" + row.domainid
			+ "\');\">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"delbefore(\'"
			+ row.ipsid + "\', \'" + row.domainid + "\');\">删除</a>"; 
	}else{
		str = "<a href=\"javascript:void(0);\" onclick=\"ipsHttpOn(\'"
			+ row.ipsname + "\');\">开启</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"getips(\'"
			+ row.ipsname + "\', \'" + row.direction + "\', \'" + row.protecttype  + "\', \'" + row.domainid
			+ "\');\">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"delbefore(\'"
			+ row.ipsid + "\', \'" + row.domainid + "\');\">删除</a>"; 	 
	}
	
  
	return str;
} 
function httpformatter(value, row, index) {
	if(!value){
		return "";
	}
	if(value.indexOf("http")!=-1){
		return "开启";
	}else{
		return "未开启";
	}
}
function ipsHttpOn(ipsname){
	$.ajax({   
		url:'${pageContext.request.contextPath}/security/ipsHttpOn.do',
	    type:'post',  
	    async: false,
	    data: {ipsid: ipsname,securityid: $("#tabs_security_id").val(),manip:$("#tabs_manip").val()},    
	    dataType:'json',  
	    success:function(data){ 
	   		if (data.success){    
	        	$.messager.alert('提示信息',data.msg, 'info');
	        } else{
	        	$.messager.alert('提示信息',data.msg, 'error'); 
	        }
	   		loadDataGrid();
		}
	}); 
}
//修改配置前获取信息展示
function getips(ipsname, direction, protecttype,domainid){
	$('#ips_http_form1').form('clear');
	debugger;
	$('#ipshttpname1').textbox('setValue', ipsname).textbox('setText', ipsname);
	$("#ipshttpdomainid1").val(domainid);
	$('#ipshttpdomain1').combobox('setValue', domainid);
	$("input[name='ipshttpdirection1'][value=" + direction + "]").attr("checked",true);
	$("#protecttype1").val(protecttype);
	$("#cprotecttype1").val(protecttype);
	/* var r=document.getElementsByName("protecttype1");  
    for(var i=0;i<r.length;i++){
	 	if(-1 != protecttype.indexOf(r[i].alt)){
	 		r[i].checked = true;
	 	}
    }  */
	
	$('#ips_http1').window('open');
}
//修改配置保存信息
 function editips(){
	debugger;
	var ipsname = $('#ipshttpname1').textbox('getValue');
	var direction = $("input[name='ipshttpdirection1']:checked").val();
	var domainid = $("#ipshttpdomainid1").val();
	var domainname = $("#ipshttpdomain1").combobox('getValue');
	if(null == domainid || "" == domainid){
		domainid = domainname;
	}
	/* var protecttype = "";
	var r=document.getElementsByName("protecttype1");  
    for(var i=0;i<r.length;i++){
       if(r[i].checked){
			protecttype += r[i].alt+",";
       }
    } 
    protecttype = protecttype.substring(0, protecttype.length-1); */
	var protecttype=$("#protecttype1").val();
    var preprotecttype = $("#cprotecttype1").val();//原来
    $('#ips_http_form1').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/editIps.do",    
	    onSubmit: function(param){ 
	     	param.securityid = $("#tabs_security_id").val(); 
	    	param.serviceid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val();
	        param.ipsid = ipsname;  
	    	param.domainid = domainid;
	    	param.domainname = domainname;
	        param.direction = direction;    
	        param.protecttype = protecttype;
	        param.preprotecttype = preprotecttype;
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){    
	        	loadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
	        $('#ips_http1').window('close');
	    }    

	});  
} 
//删除操作
function delbefore(ipsid, domainid){
	$.messager.confirm('系统提示信息', '当前配置删除后不可恢复，请谨慎操作，确定删除吗？', function(r){
		if (r){
			$('#pipsManForm').form('submit',{
			    url:'${pageContext.request.contextPath}/security/deleteIps.do', 
			    onSubmit : function(param) {
			    	param.securityid = $("#tabs_security_id").val(); 
			    	param.serviceid = $("#tabs_service_id").val();
			    	param.displayname = $("#tabs_displayname").val();
			    	param.manip = $("#tabs_manip").val(); 
					param.ipsid=ipsid;
					param.domainid = domainid;
				},
			    success:function(retr){
			    	var _data = $.parseJSON(retr);
					if (_data.success) {
						loadDataGrid();
					} else {
						$.messager.alert('提示', "删除操作失败，请重试！", 'error');
					}
			    }
			});
		}
	});

}

	//新增配置信息保存
	function addIpsHttp() {
		var ipsname = $('#ipshttpname').textbox('getValue');
		var direction = $("input[name='ipshttpdirection']:checked").val();
		var domainid = $("#ipshttpdomainid").val();
		if(null == ipsname || "" == ipsname || ipsname.length>31 || ipsname.length<1){
			$.messager.alert('提示信息','协议配置名称(1~31)字符！', 'info');
			return;
		}
		/* var protecttype = "";
		var r=document.getElementsByName("protecttype");  
		for(var i=0;i<r.length;i++){
			if(r[i].checked){
				protecttype += r[i].alt + ",";
			}
		} 
		protecttype = protecttype.substring(0, protecttype.length-1); */

		$('#ips_http_form').form('submit', {
			url : "${pageContext.request.contextPath}/security/ipsSave.do",
			onSubmit : function(param) {
				param.securityid = $("#tabs_security_id").val();
				param.serviceid = $("#tabs_service_id").val();
				param.displayname = $("#tabs_displayname").val();
				param.manip = $("#tabs_manip").val();
				param.ipsid = ipsname;
				param.domainid = domainid;
				param.direction = direction;
				param.protype = "http";
			},
			success : function(retr) {
				var data = $.parseJSON(retr);
				if (data.success) {
					loadDataGrid();
				} else {
					$.messager.alert('提示信息', '保存发生错误，请重试！', 'error');
				}
				$('#ips_http').window('close');
			}

		});
	}
</script>
<form id="pipsManForm"></form>
<div data-options="region:'center',border:false">
	<div data-options="region:'center',border:false" id="addid">
	<table title="" style="width:100%;"  id="ipshttp_grid">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'ipsname',width:10,align:'center'">名称</th>
				<th data-options="field:'domainname',width:6,align:'center'">安全域</th>
				<th data-options="field:'direction',width:10,align:'center',formatter:dformater">方向</th>
				<th data-options="field:'protecttype',width:10,align:'center',formatter:httpformatter">防护功能</th>
				<th data-options="field:'ipsid',width:10,align:'center',formatter:ipsoptionformater">操作</th>
			</tr>
		</thead>
	</table>
	</div>
</div>  <!--  -->
<div id="ips_http" class="easyui-window" title="新增协议配置" data-options="closed:true,minimizable:false,maximizable:false,closable:true,collapsible:false,iconCls:'icon-save'" style="width:700px;height:350px;padding:5px;top:127px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="ips_http_form" method="post" data-options="novalidate:true">
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 76px;">安全域：</span>
						<input type="hidden" id="ipshttpdomainid"/>
						<select id="ipshttpdomain" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto',editable:false">
							<option value="">请选择</option>
							<option value="trust">trust</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 76px;">名称：</span>
						<input id="ipshttpname" class="easyui-textbox" style="width:100px;height:22px;"/>&nbsp;(1-31)字符
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 73px;">防护方向：</span>
						&nbsp;<input type="radio" name="ipshttpdirection" value="2" style="width:20px;line-height:20px;" />双向
						&nbsp;<input type="radio" name="ipshttpdirection" value="1" style="width:20px;line-height:20px;" />流出
						&nbsp;<input type="radio" name="ipshttpdirection" value="0" style="width:20px;line-height:20px;" />流入
					</p>
				</div>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="addIpsHttp();" id="addips" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#ips_http').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
<div id="ips_http1" class="easyui-window" title="修改协议配置" data-options="closed:true,minimizable:false,maximizable:false,closable:true,collapsible:true,iconCls:'icon-save'" style="width:700px;height:350px;padding:5px;top:127px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="ips_http_form1" method="post" data-options="novalidate:true">
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 76px;">安全域：</span>
						<input type="hidden" id="ipshttpdomainid1"/>
						<select id="ipshttpdomain1" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto',editable:false">
							<option value="">请选择</option>
							<option value="trust">trust</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 76px;">名称：</span>
						<input id="ipshttpname1" class="easyui-textbox" style="width:100px;height:22px;" data-options="editable:false,disabled:true"/>&nbsp;(1-31)字符
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 73px;">防护方向：</span>
						&nbsp;<input type="radio" name="ipshttpdirection1" value="2" style="width:20px;line-height:20px;" />双向
						&nbsp;<input type="radio" name="ipshttpdirection1" value="1" style="width:20px;line-height:20px;" />流出
						&nbsp;<input type="radio" name="ipshttpdirection1" value="0" style="width:20px;line-height:20px;" />流入
					</p>
				</div>
				
				<input type="hidden" id="protecttype1"/> 
				<input type="hidden" id="cprotecttype1"/>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="editips();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#ips_http1').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
</body>

