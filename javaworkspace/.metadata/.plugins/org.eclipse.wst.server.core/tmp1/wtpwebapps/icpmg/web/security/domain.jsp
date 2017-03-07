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
var grid;
$('.j-btn-toggle').unbind('click');
$('.j-btn-toggle').click(function(event) {
    $(this).toggleClass('active');
});
$(document).ready(function() {
	domain_loadDataGrid();
});
//列表展示查询结果
function domain_loadDataGrid(){
	grid = $('#domain_grid').datagrid({
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
		//toolbar:,    
	    url:'${pageContext.request.contextPath}/security/queryDomainList.do?securityid=' + $("#tabs_security_id").val(),
	    onLoadSuccess : function(data) {
			var pageopt = $('#domain_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var _rows = $('#domain_grid').datagrid("getRows").length;
			var total = pageopt.total; //显示的查询的总数
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {domainid : ''});
				}
				$('#domain_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
						total: total,
				});
				
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
			
			
			$('.j-modify').linkbutton({
                iconCls: 'icon-modify',
                plain: true
   		    });
		}
	 }); 
}
//其他列格式化
function domain_otherformater(value, row, index) {
	var str = "";
	if(row.appidentify == '1'){
		str += "&nbsp;应用识别";
	}
	if(row.wandomain == '1'){
		str += "&nbsp;WAN安全域";
	}
	return str;
} 
//防护状态列格式化
function domain_stformater(value, row, index) {
	if(!value){
		return "";
	}
	var str = "";
	if(row.ips == '1'){
		str += "<img alt=\"入侵防御：已启用\" title=\"入侵防御：已启用\" src=\"${pageContext.request.contextPath}/images/selected/security/rqfy.png\"/>";
	}else{
		str += "<img alt=\"入侵防御：未启用\" title=\"入侵防御：未启用\" src=\"${pageContext.request.contextPath}/images/unselect/security/rqfyGray.png\"/>";
	}
	
	if(row.arp == '1'){
		str += "<img alt=\"攻击防护：已启用\" title=\"攻击防护：已启用\" src=\"${pageContext.request.contextPath}/images/selected/security/gjfh.png\"/>";
	}else{
		str += "<img alt=\"攻击防护：未启用\" title=\"攻击防护：未启用\" src=\"${pageContext.request.contextPath}/images/unselect/security/gjfhGray.png\"/>";
	}
	
	if(row.bfp == '1'){
		str += "<img alt=\"边界流量过滤：已启用\" title=\"边界流量过滤：已启用\" src=\"${pageContext.request.contextPath}/images/selected/security/bjllgl.png\"/>";
	}else{
		str += "<img alt=\"边界流量过滤：未启用\" title=\"边界流量过滤：未启用\" src=\"${pageContext.request.contextPath}/images/unselect/security/bjllglGray.png\"/>";
	}
	
	return str;
} 
//操作列格式化
function domain_fwoptionformater(value, row, index) {
	if(!value){
		return "";
	}
	var str = "<a href=\"javascript:void(0);\" onclick=\"editdomain(\'" 
			+ row.domainid + "\', \'" + row.domainname + "\', \'" + row.description + "\', \'" + row.domaintype 
			+ "\', \'" + row.iid + "\', \'" + row.iname + "\', \'" + row.appidentify + "\', \'" + row.wandomain 
			+ "\');\" title=\"修改\" class=\"j-modify\"></a>"; 
	
	return str;
}
//修改操作获取当前信息并展示
function editdomain(domainid, domainname, description, domaintype, iid, iname, appidentify, wandomain){
	// 弹层
    $('#domainw').dialog({
        title: "编辑",
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
            	savedomain();
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
            	$('#domainw').window('close');
            }
        }]
    });
	
	$('#domainCreateForm').form('clear');
	
	/*这一版 绑定接口来源于domain表，不做查询选择
    $('#i').combobox({    
		url:'${pageContext.request.contextPath}/security/queryDomianInterface.do?securityid=' + '4207bf21-eda6-0e96-ac17-e0c4006f5b19', //$("#tabs_security_id").val()  
		valueField:'iid',    
		textField:'iname',
		onSelect: function(rec){
	    }
	});*/

	
	$('#domainid').val(domainid);
	$('#domainname').textbox('setValue', domainname).textbox('setText', domainname);
	$('#descri').textbox('setValue', description).textbox('setText', description);
	$('#domaintype').find("li[value="+domaintype+"]").addClass('active').siblings().removeClass('active');
	$('#domaintype').find("li[value="+domaintype+"]").css({"color":"#333","background-color":"#eee","border-color":"#eee"});
	$('#vr').combobox('setValue', "trust-vr");//默认值
	$('#i').combobox('setValue', iid).textbox('setText', iname);
	
	if(appidentify == '1'){
    	$("#appidentify").addClass('active');
	}else{
		$("#appidentify").removeClass('active');
	}
	
	if(wandomain == '1'){
    	$("#wandomain").addClass('active');
	}else{
		$("#wandomain").removeClass('active');
	} 
	
	$('#domainw').window('open');
}
//保存修改后信息
function savedomain(){
	var domainid = $('#domainid').val();
	var description = $('#descri').textbox('getValue');
	if(null != description && "" != description ){
		if( description.length>63 || description.length<0){
			$.messager.alert('提示信息','描述信息长度范围0-63字符！', 'info');
			return;
		}
	}
	var appidentify = 0;
	var appidentify_flag = $("#appidentify").hasClass("active");
	if(appidentify_flag){
		appidentify = 1;
	}
	
	var wandomain = 0;
	var wandomain_flag = $("#wandomain").hasClass("active");
	if(wandomain_flag){
		wandomain = 1;
	}
	
	var iid = $('#i').combobox('getValue');
	var iname = $('#i').combobox('getText');
	
	
	$('#domainCreateForm').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/updateDomain.do",    
	    onSubmit: function(param){ 
	    	param.securityid = $("#tabs_security_id").val(); 
	    	param.serviceid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val();
	        param.domainid = domainid;    
	        param.description = description; 
	        param.appidentify = appidentify;    
	        param.wandomain = wandomain;
	        param.iid = iid;    
	        param.iname = iname;
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){    
	        	domain_loadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
	        $('#domainw').window('close');
	    }    

	});  
}
</script>
<div data-options="region:'center',border:false">
	<div data-options="region:'center',border:false" id="addid">
	<table title="" style="width:100%;"  id="domain_grid">
		<thead>
			<tr>
				<th data-options="field:'domainname',width:10,align:'center'">安全域名称</th>
				<th data-options="field:'strategynum',width:10,align:'center'">策略数</th>
				<th data-options="field:'appidentify',width:20,align:'center',formatter:domain_otherformater">其他</th>
				<th data-options="field:'description',width:20,align:'center'">描述</th>
				<th data-options="field:'ips',width:20,align:'center',formatter:domain_stformater">防护状态</th>
				<th data-options="field:'domainid',width:10,align:'center',formatter:domain_fwoptionformater">操作</th>
			</tr>
		</thead>
	</table>
	</div>
</div>  
<div id="domainw" class="easyui-window pop" data-options="closed:true,minimizable:false,maximizable:false,closable:false">
	<div style="padding:0 10px ">
			<form id="domainCreateForm" method="post" data-options="novalidate:true">
				<input type="hidden" id="domainid"/>
				<div class="item2">
                <div class="item-title">基本配置</div>
                <table style="width:100%;border:0;"  class="table-layout">
                    <tr>
                        <td width="20%" align="right">
                                                                                安全域名称：
                        </td>
                        <td width="80%">
                            <input id="domainname" class="easyui-textbox" style="width: 188px;" data-options="editable:false,disabled:true">（1-31）字符
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                                                                               描述：
                        </td>
                        <td>
                            <input id="descri" class="easyui-textbox" style="width: 188px;">（0-61）字符
                        </td>
                    </tr>
                    <tr>
                        <td align="right">类型：</td>
                        <td align="left">
                            <ul class="item-ul " id="domaintype" >
                                <li style="padding:0 21px"  value="1">二层安全域</li>
                                <li style="padding:0 22px" value="0" >三层安全域</li>
                                <li style="padding:0 22px" value="2">TAP</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                                                                             虚拟路由器：
                        </td>
                        <td>
                            <select id="vr" class="easyui-combobox" name="" style="width: 200px;" data-options="panelHeight:'auto',editable:false,disabled:true">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                                                                             绑定接口：
                        </td>
                        <td>
                            <select id="i" class="easyui-combobox" name="" style="width: 200px;" data-options="panelHeight:'auto',editable:false">
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
				<div class="item2">
                <div class="item-title">高级配置</div>
                <table style="width:100%;border:0;"  class="table-layout">
                    <tr>
                        <td width="20%" align="right">
                        </td>
                        <td width="80%">
                            <a href="javascript:void(0)" style="width: 150px;" id="appidentify" class="default-btn-demo2 j-btn-toggle   active">应用识别</a>
                            <a href="javascript:void(0)" style="width: 150px;" id="wandomain" class="default-btn-demo2 j-btn-toggle   active">WAN安全域</a>
                        </td>
                    </tr>
                </table>
            </div>
			</form>
		</div>
	</div>
</body>

