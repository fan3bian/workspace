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
var pipstoolbar = [
						{
							text:'新增协议配置',
							iconCls:'icon-add',
							handler:function(){ 
								$('#pipsCreateForm').form('clear');
								$("input[name='direction'][value=2]").attr("checked",true);
								$('#domain_ips').combobox('setValue','');
								$("input[name='ipschose']").eq(0).attr("checked",true);
								checkall('');
								$('#pipsw').window('open');
							}
						}
                       ];
$(document).ready(function() {
	loadDataGrid();
});
$('#domain_ips').combobox({    
	onSelect: function(rec){
		$('#domainid').val(rec.value);
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
			});
		}else{
			$('#addips').linkbutton("enable");
		}
    }
});
//查询结果
function loadDataGrid(){
	grid = $('#pips_grid').datagrid({
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
			var pageopt = $('#pips_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var _rows = $('#pips_grid').datagrid("getRows").length;
			var total = pageopt.total; //显示的查询的总数
			
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {curstat : ''});
				}
				$('#pips_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
						total: total,
				});
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
		}
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
	str = "<a href=\"javascript:void(0);\" onclick=\"getips(\'"
			+ row.ipsname + "\', \'" + row.direction + "\', \'" + row.protecttype  + "\', \'" + row.domainid
			+ "\');\">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"delbefore(\'"
			+ row.ipsid + "\', \'" + row.domainid + "\');\">删除</a>"; 
	return str;
} 
//修改配置前获取信息展示
function getips(ipsname, direction, protecttype,domainid){
	$('#pipsCreateForm1').form('clear');
	
	$('#ipsname1').textbox('setValue', ipsname).textbox('setText', ipsname);
	$("#domainid1").val(domainid);
	$('#domain1').combobox('setValue', domainid);
	$("input[name='direction1'][value=" + direction + "]").attr("checked",true);
	
	$("#cprotecttype1").val(protecttype);
	var r=document.getElementsByName("protecttype1");  
    for(var i=0;i<r.length;i++){
	 	if(-1 != protecttype.indexOf(r[i].alt)){
	 		r[i].checked = true;
	 	}
    } 
	
	$('#pipsw1').window('open');
}
//修改配置保存信息
function editips(){
	var ipsname = $('#ipsname1').textbox('getValue');
	var direction = $("input[name='direction1']:checked").val();
	var domainid = $("#domainid1").val();
	var domainname = $("#domain1").combobox('getValue');
	if(null == domainid || "" == domainid){
		domainid = domainname;
	}
    var preprotecttype = $("#cprotecttype1").val();//原来
	var protecttype = "";
	var r=document.getElementsByName("protecttype1");  
    for(var i=0;i<r.length;i++){
       if(r[i].checked){
			protecttype += r[i].alt+",";
       }
    } 
    if(null != protecttype && "" != protecttype){
	    protecttype = protecttype.substring(0, protecttype.length-1);
    }
	
    $('#pipsCreateForm1').form('submit', {    
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
	        $('#pipsw1').window('close');
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
function addips(){
	var ipsname = $('#ipsname').textbox('getValue');
	if(null == ipsname || "" == ipsname || ipsname.length>31 || ipsname.length<1){
		$.messager.alert('提示信息','协议配置名称(1~31)字符！', 'info');
		return;
	}
	var direction = $("input[name='direction']:checked").val();  
	var domainid = $("#domainid").val();
	var protecttype = "";
	var r=document.getElementsByName("protecttype");  
    for(var i=0;i<r.length;i++){
		if(r[i].checked){
			protecttype += r[i].alt + ",";
		}
    } 
    protecttype = protecttype.substring(0, protecttype.length-1);
	
    $('#pipsCreateForm').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/ipsSave.do",    
	    onSubmit: function(param){ 
	     	param.securityid = $("#tabs_security_id").val(); 
	    	param.serviceid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val();
	        param.ipsid = ipsname;    
	        param.domainid = domainid; 
	        param.direction = direction;    
	        param.protype = protecttype;
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){    
	        	loadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
	        $('#pipsw').window('close');
	    }    

	});  
}
//全选
function checkall(data){
	var r=document.getElementsByName("protecttype" + data);  
    for(var i=0;i<r.length;i++){
    	r[i].checked = true;
    }
}
//全不选
function uncheckall(data){
	var r=document.getElementsByName("protecttype" + data);  
    for(var i=0;i<r.length;i++){
    	r[i].checked = false;
    }
}
</script>
<form id="pipsManForm"></form>
<div data-options="region:'center',border:false">
	<table title="" style="width:100%;"  id="pips_grid">
		<thead>
			<tr>
				<th data-options="field:'ipsname',width:10,align:'center'">名称</th>
				<th data-options="field:'domainname',width:6,align:'center'">安全域</th>
				<th data-options="field:'direction',width:6,align:'center',formatter:dformater">方向</th>
				<th data-options="field:'protecttype',width:70,align:'center'">协议类型</th>
				<th data-options="field:'ipsid',width:8,align:'center',formatter:ipsoptionformater">操作</th>
			</tr>
		</thead>
	</table>
</div>  
<div id="pipsw" class="easyui-window" title="新增协议配置" data-options="closed:true,minimizable:false,maximizable:false,closable:true,collapsible:false,iconCls:'icon-save'" style="width:700px;height:350px;padding:5px;top:127px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="pipsCreateForm" method="post" data-options="novalidate:true">
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 76px;">安全域：</span>
						<input type="hidden" id="domainid"/>
						<select id="domain_ips" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto',editable:false">
							<option value="">请选择</option>
							<option value="trust">trust</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 76px;">名称：</span>
						<input id="ipsname" class="easyui-textbox" style="width:100px;height:22px;"/>&nbsp;(1-31)字符
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 73px;">防护方向：</span>
						&nbsp;<label><input type="radio" name="direction" value="2"/>双向</label>
						&nbsp;<label><input type="radio" name="direction" value="1"/>流出</label>
						&nbsp;<label><input type="radio" name="direction" value="0"/>流入</label>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 76px;">防护类型：</span>
						<label style="display:inline-block;width: 60px;">全选<input type="radio" name="ipschose" style="width:20px;line-height:20px;" onclick="checkall('')"/></label>
						<label style="display:inline-block;width: 60px;">全不选<input type="radio" name="ipschose" style="width:20px;line-height:20px;" onclick="uncheckall('')"/></label>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:106px;">
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="dns"/>&nbsp;DNS</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="dhcp"/>&nbsp;DHCP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="finger"/>&nbsp;Finger</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="ftp"/>&nbsp;FTP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="http"/>&nbsp;HTTP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="imap"/>&nbsp;IMAP</span><br/>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="ldap"/>&nbsp;LDAP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="msrpc"/>&nbsp;MSRPC</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="mssql"/>&nbsp;MSSQL</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="mysql"/>&nbsp;MYSQL</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="netbios"/>&nbsp;NETBIOS</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="nntp"/>&nbsp;NNTP</span><br/>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="oracle"/>&nbsp;ORACLE</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="smtp"/>&nbsp;SMTP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="pop3"/>&nbsp;POP3</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="snmp"/>&nbsp;SNMP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="sunrpc"/>&nbsp;SUNRPC</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="telnet"/>&nbsp;Telnet</span><br/>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="tftp"/>&nbsp;TFTP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="voip"/>&nbsp;VoIP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="other-tcp"/>&nbsp;Other-TCP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype" alt="other-udp"/>&nbsp;Other-UDP</span>
					</p>
				</div>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="addips();" id="addips" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#pipsw').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
<div id="pipsw1" class="easyui-window" title="修改协议配置" data-options="closed:true,minimizable:false,maximizable:false,closable:true,iconCls:'icon-save',collapsible:false" style="width:700px;height:350px;padding:5px;top:127px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="pipsCreateForm1" method="post" data-options="novalidate:true">
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 76px;">安全域：</span> 
						<input type="hidden" id="domainid1"/>
						<select id="domain1" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto',editable:false">
							<option value="">请选择</option>
							<option value="trust">trust</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 76px;">名称：</span>
						<input id="ipsname1" class="easyui-textbox" style="width:100px;height:22px;" data-options="editable:false,disabled:true"/>&nbsp;(1-31)字符
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 73px;">防护方向：</span>
						&nbsp;<label><input type="radio" name="direction1" value="2"/>双向</label>
						&nbsp;<label><input type="radio" name="direction1" value="1"/>流出</label>
						&nbsp;<label><input type="radio" name="direction1" value="0"/>流入</label>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">
						<span style="display:inline-block;width: 76px;">防护类型：</span>
						<label style="display:inline-block;width: 60px;">全选<input type="radio" name="ipschose1" style="width:20px;line-height:20px;" onclick="checkall('1')"/></label>
						<label style="display:inline-block;width: 60px;">全不选<input type="radio" name="ipschose1" style="width:20px;line-height:20px;" onclick="uncheckall('1')"/></label>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:106px;">
						<input type="hidden" id="cprotecttype1"/>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="dns"/>&nbsp;DNS</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="dhcp"/>&nbsp;DHCP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="finger"/>&nbsp;Finger</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="ftp"/>&nbsp;FTP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="http"/>&nbsp;HTTP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="imap"/>&nbsp;IMAP</span><br/>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="ldap"/>&nbsp;LDAP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="msrpc"/>&nbsp;MSRPC</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="mssql"/>&nbsp;MSSQL</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="mysql"/>&nbsp;MYSQL</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="netbios"/>&nbsp;NETBIOS</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="nntp"/>&nbsp;NNTP</span><br/>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="oracle"/>&nbsp;ORACLE</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="smtp"/>&nbsp;SMTP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="pop3"/>&nbsp;POP3</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="snmp"/>&nbsp;SNMP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="sunrpc"/>&nbsp;SUNRPC</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="telnet"/>&nbsp;Telnet</span><br/>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="tftp"/>&nbsp;TFTP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="voip"/>&nbsp;VoIP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="other-tcp"/>&nbsp;Other-TCP</span>
						<span style="display:inline-block;width: 85px;"><input type="checkbox" style="width:20px;line-height:20px;" name="protecttype1" alt="other-udp"/>&nbsp;Other-UDP</span>
					</p>
				</div>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="editips();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#pipsw1').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
</body>

