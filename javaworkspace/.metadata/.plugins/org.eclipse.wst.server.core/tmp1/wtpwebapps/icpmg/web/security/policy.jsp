<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
select{
	width:8%;
	height:30px;
}
.FieldInput3 {
	width:12%;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}
.FieldLabel3 {
	width:8%;
	height: 25px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align:center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
</style>
<script type="text/javascript">
var grid;
var policytoolbar = [
						{
							text:'新增安全策略',
							iconCls:'icon-add',
							handler:function(){ 
								$('#policyCreateForm').form('clear');
								
								//初始化
								$('#sdomain').combobox('setValue', 'Any');
								$('#ddomain').combobox('setValue', 'Any');
								$('#saddrname').textbox('setValue', 'Any').textbox('setText', 'Any');
								$('#daddrname').textbox('setValue', 'Any').textbox('setText', 'Any');
								$("#_sdomain").val('Any');
								$("#saddr").val('0,Any;');
								$("#ddomainid").val('Any');
								$("#daddr").val('0,Any;');
								$('#p1').combobox('setValue', "");
								//初始化
								$('#behavior1_1').removeClass('active');
        						$('#behavior1').addClass('active');
								
								$('#log_deny').addClass('active');
								$('#log_start').removeClass('active');
								$('#log_end').removeClass('active');
								
								$('#description').textbox('setValue', '');
								$('#policyw').attr('style','visibility:visible');
								$("#porder1").val("");
								$('#policyw').window('open');
							}
						}
                       ];
$(document).ready(function() {
	policyloadDataGrid();
	$('.j-link-add').linkbutton({
            plain: true,
            iconCls: 'icon-add'
    });
    
    $('.j-toggle li').bind('click', function(event) {
     $(this).addClass('active').siblings().removeClass('active');
    });
    $(".j-multiple li").unbind("click");
    $(".j-multiple li").click(function(){
        $(this).toggleClass('active');
    });
    
});
//查询结果
function policyloadDataGrid(){
	grid = $('#policy_grid').datagrid({
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
		toolbar:policytoolbar,    
		queryParams:{securityid:$("#tabs_security_id").val()},
	    url:'${pageContext.request.contextPath}/security/queryPolicyList.do',
	    onLoadSuccess : function(data) {
			var pageopt = $('#policy_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var _rows = $('#policy_grid').datagrid("getRows").length;
			var total = pageopt.total; //显示的查询的总数
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {operation : ''});
				}
				$('#policy_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
					total: total,
			});
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
			
			$('#policyw').dialog({
	            title: "新增安全策略",
	            width: 600,
	            height: 500,
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
	                    addpolicy();
	                }
	            }, {
	                text: '取消',
	                iconCls: 'icon-cancel',
	                handler: function() {
	                    $('#policyw').dialog('close');
	                }
	            }]
	        });
	        $('#policyw1').dialog({
	            title: "修改安全策略",
	            width: 600,
	            height: 500,
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
	                    editpolicy();
	                }
	            }, {
	                text: '取消',
	                iconCls: 'icon-cancel',
	                handler: function() {
	                    $('#policyw1').dialog('close');
	                }
	            }]
	        });
	        // 弹层选择地址
	        $('#addrw').dialog({
	            title: "选择地址",
	            width: 500,
	            height: 300,
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
	                	policyAddrFill();//内容回填
	                    $('#addrw').dialog('close');
	                }
	            }, {
	                text: '取消',
	                iconCls: 'icon-cancel',
	                handler: function() {
	                    $('#addrw').dialog('close');
	
	                }
	            }]
	        });
	        
	        $('.j-open').linkbutton({
                iconCls: 'icon-open',
                plain: true
   		    });
			$('.j-close').linkbutton({
                iconCls: 'icon-close',
                plain: true
   		    });
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
//行为属性格式化
function policybeformatter(value, row, index) {
	var str = "";
	if(value == '1'){
		str = "拒绝";
	}else if(value == '2'){
		str = "允许";
	}else if(value == '5'){
		str = "安全链接";
	}
	return str;
} 
//状态属性格式化
function policypsformatter(value, row, index) {
	var str = "";
	if(value == '1'){
		str = "在用";
	}else if(value == '0'){
		str = "停用";
	}
	return str;
} 
//操作列格式化
function fwoptionformatter(value, row, index) {
	if(!value){
		return "";
	}
	var str = "";
	if(row.pstatus == "0"){
		str = "<a href=\"javascript:void(0);\" class=\"j-open\" onclick=\"policyeditstatus(\'1\',\'" + row.policyid + "\');\"  title=\"启用\"></a>";
	}else if(row.pstatus == "1"){
		str = "<a href=\"javascript:void(0);\" class=\"j-close\" onclick=\"policyeditstatus(\'0\',\'" + row.policyid + "\');\" title=\"停用\"></a>";
	}
	
	str += "&nbsp;|&nbsp;<a href=\"javascript:void(0);\"  class=\"j-modify\" onclick=\"getpolicy(\'" + row.policyid + "\',\'" + row.policyname
			+ "\',\'" + row.behavior + "\',\'" + row.sdomainid + "\',\'" + row.ddomainid + "\',\'" + row.saddrstr
			+ "\',\'" + row.saddrstrv + "\',\'" + row.daddrstr + "\',\'" + row.daddrstrv + "\',\'" + row.description
			+ "\',\'" + row.logdeny + "\',\'" + row.logstart + "\',\'" + row.logend + "\',\'" + row.seqno
			+ "\');\" title=\"修改\"></a>&nbsp;|&nbsp;" 
			+ "<a href=\"javascript:void(0);\"  class=\"j-delete\" onclick=\"policydelbefore(\'" + row.policyid + "\' );\" title=\"删除\"></a>"; 
	return str;
} 
//获取单记录信息展示
function getpolicy(policyid, policyname, behavior, sdomainid, ddomainid, saddrstr, saddrstrv, daddrstr, daddrstrv, description, logdeny, logstart, logend, seqno){
	$('#policyCreateForm1').form('clear');
	
	$('#policyid1').val(policyid);
	$('#policyname1').textbox('setValue', policyname).textbox('setText', policyname);
	if(behavior==1){  //2:允许  1：拒绝
		$('#behavior1').removeClass('active');
        $('#behavior1_1').addClass('active');
	}else{
		$('#behavior1_1').removeClass('active');
        $('#behavior1').addClass('active');
	}
	
	$("#_sdomain1").val(sdomainid);
	$('#sdomain1').combobox('setValue', sdomainid);
	$("#ddomainid1").val(ddomainid);
	$('#ddomain1').combobox('setValue', ddomainid);
	$("#saddr1").val(saddrstrv);
	$('#saddrname1').textbox('setValue', saddrstr).textbox('setText', saddrstr);
	$("#daddr1").val(daddrstrv);
	$('#daddrname1').textbox('setValue', daddrstr).textbox('setText', daddrstr);
	$('#description1').textbox('setValue', description).textbox('setText', description);
	$('#_p1').combobox('setValue', "");
	$('#seqno').val(seqno);


	if(logdeny==1){
        $('#log_deny1').addClass('active');
	}else{
		$('#log_deny1').removeClass('active');
	}
	if(logstart==1){
        $('#log_start1').addClass('active');
	}else{
		$('#log_start1').removeClass('active');
	}
	if(logend==1){
        $('#log_end1').addClass('active');
	}else{
		$('#log_end1').removeClass('active');
	}
	
	$('#_porder1').val("");
	$('#_porder2').val("");
	
	$('#policyw1').attr('style','visibility:visible');
	$('#policyw1').window('open');
}
//修改配置信息保存
function editpolicy(){
	var policyid = $("#policyid1").val();
	var policyname = $('#policyname1').textbox('getValue');
	var behavior_flag = $("#behavior1").hasClass("active");
	var behavior ="";
	if(behavior_flag){
		behavior = 2; //行为:允许
	}else{
		behavior = 1; //行为：拒绝
	}
	var sdomainid = $("#_sdomain1").val();
	var saddr = $("#saddr1").val();
	var ddomainid = $("#ddomainid1").val();
	var daddr = $("#daddr1").val();
	var description = $('#description1').textbox('getValue');
	
	var logdeny = "0";
	var logstart = "0";
	var logend = "0";
	var seqno =  $("#seqno").val();
	
    var logdeny = "0";
	var logstart = "0";
	var logend = "0";
	
	var log_deny = $("#log_deny1").hasClass("active");
	var log_start = $("#log_start1").hasClass("active");
	var log_end = $("#log_end1").hasClass("active");
	if(log_deny){
		logdeny = "1";
	}
	if(log_start){
		logstart = "1";
	}
	if(log_end){
		logend = "1";
	}
    
    var porder = "";
    var porder1 = $('#_porder1').val();
    if(null != porder1 && "" != porder1){
	    var porder2 = $('#_porder2').textbox('getValue');
    	porder = changeseqno(porder1, porder2);
    }

	if(porder1 =='befor' || porder1 =='after'){
		var pid = $('#_porder2').val();
    	if(pid==null||pid==""){
    		$.messager.alert('提示信息','请输入ID！', 'info');
    		return;
    	}
    	var flag = checkPolicyid('modify');
    	if(flag=='false'){
    		$.messager.alert('提示信息','请输入正确的ID！', 'info');
    		return;
    	}
    }
    $('#policyCreateForm1').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/updatePolicy.do",    
	    onSubmit: function(param){ 
	     	param.securityid = $("#tabs_security_id").val(); 
	    	param.objectid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val();
	    	param.policyid = policyid;
	        param.policyname = policyname;    
	        param.behavior = behavior; 
	        param.sdomainid = sdomainid;    
	        param.saddr = saddr;    
	        param.ddomainid = ddomainid;
	        param.daddr = daddr;
	        param.logdeny = logdeny;    
	        param.logstart = logstart;
	        param.logend = logend;    
	        param.porder = porder;
	        param.seqno = seqno;
	        param.porder1 = $("#_porder1").val();
	        param.porder2 = $("#_porder2").val();
	        param.description = description;
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){    
	        	policyloadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
	        $('#policyw1').window('close');
	    }    

	});  
}
//单记录修改状态
function policyeditstatus(pstatus, policyid){
	$('#policyManForm').form('submit',{
		url:'${pageContext.request.contextPath}/security/updatePolicyStatus.do', 
	    onSubmit : function(param) {
	    	param.securityid = $("#tabs_security_id").val(); 
	    	param.objectid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val(); 
			param.policyid=policyid;
			param.pstatus=pstatus;
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.success) {
				debugger;
				policyloadDataGrid();
			} else {
				$.messager.alert('提示', "状态修改操作失败，请重试！", 'error');
			}
	    }
	});
}
//单记录删除
function policydelbefore(policyid){
	$.messager.confirm('系统提示信息', '当前策略删除后不可恢复，请谨慎操作，确定删除吗？', function(r){
		if (r){
			$('#policyManForm').form('submit',{
				url:'${pageContext.request.contextPath}/security/delPolicy.do', 
			    onSubmit : function(param) {
			    	param.securityid = $("#tabs_security_id").val(); 
			    	param.objectid = $("#tabs_service_id").val();
			    	param.displayname = $("#tabs_displayname").val();
			    	param.manip = $("#tabs_manip").val(); 
					param.policyid=policyid;
				},
			    success:function(retr){
			    	var _data = $.parseJSON(retr);
					if (_data.success) {
						policyloadDataGrid();
					} else {
						$.messager.alert('提示', "删除操作失败，请重试！", 'error');
					}
			    }
			});
		}
	});

}
//转换seqno
function changeseqno(porder1, porder2){
	var policyId = 0;
	var seqno = parseInt(0x00000);
	switch (porder1) {
		case 'front':
			seqno = parseInt(0x10000);
			policyId = 0;
			break;
		case 'last':
			seqno = parseInt(0x00000);
			policyId = 0;
			break;
		case 'befor':
			seqno = parseInt(0x20000);
			policyId = porder2;
			break;
		case 'after':
			seqno = parseInt(0x30000);
			policyId = porder2;
			break;
	}
	return seqno += parseInt(policyId);
}
//新增配置信息保存
function addpolicy(){
	var policyname = $('#policyname').textbox('getValue');
		if(policyname == null || policyname == ""){
		$.messager.alert('提示信息','安全策略名称不可为空！', 'info');
		return;
	}
	var behavior_flag = $("#behavior").hasClass("active");
	/*if(behavior == null || behavior == ""){
		$.messager.alert('提示信息','安全策略行为不可为空！', 'info');
		return;
	}*/
	var behavior ="";
	if(behavior_flag){
		behavior = 2; //行为:允许
	}else{
		behavior = 1; //行为：拒绝
	}
	var sdomainid = $("#_sdomain").val();
	if(sdomainid == null || sdomainid == ""){
		$.messager.alert('提示信息','源安全域不可为空！', 'info');
		return;
	}
	var saddr = $("#saddr").val();
	if(saddr == null || saddr == ""){
		$.messager.alert('提示信息','源地址不可为空！', 'info');
		return;
	}
	var ddomainid = $("#ddomainid").val();
	if(ddomainid == null || ddomainid == ""){
		$.messager.alert('提示信息','目的安全域不可为空！', 'info');
		return;
	}
	var daddr = $("#daddr").val();
	if(daddr == null || daddr == ""){
		$.messager.alert('提示信息','目的地址不可为空！', 'info');
		return;
	}
	var description = $('#description').textbox('getValue');
	
	var logdeny = "0";
	var logstart = "0";
	var logend = "0";
	
	var log_deny = $("#log_deny").hasClass("active");
	var log_start = $("#log_start").hasClass("active");
	var log_end = $("#log_end").hasClass("active");
	if(log_deny){
		logdeny = "1";
	}
	if(log_start){
		logstart = "1";
	}
	if(log_end){
		logend = "1";
	}
	/*
	var r=document.getElementsByName("log");  
    for(var i=0;i<r.length;i++){
		if(r[i].checked){
			if(r[i].alt == "deny"){
				logdeny = "1";
			}else if(r[i].alt == "start"){
				logstart = "1";
			}else if(r[i].alt == "end"){
				logend = "1";
			}
		}
    } */
    var porder = "";
    var porder1 = $('#porder1').val();
    if(null != porder1 && "" != porder1){
	    var porder2 = $('#porder2').textbox('getValue');
    	porder = changeseqno(porder1, porder2);
    }
    if(porder1 =='befor' || porder1 =='after'){
    	var pid = $('#porder2').val();
    	if(pid==null||pid==""){
    		$.messager.alert('提示信息','请输入ID！', 'info');
    		return;
    	}
    	var flag = checkPolicyid('add');
    	if(flag=='false'){
    		$.messager.alert('提示信息','请输入正确的ID！', 'info');
    		return;
    	}
    }
    $('#policyCreateForm').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/savePolicy.do",    
	    onSubmit: function(param){ 
	     	param.securityid = $("#tabs_security_id").val(); 
	    	param.objectid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val();
	        param.policyname = policyname;    
	        param.behavior = behavior; 
	        param.sdomainid = sdomainid;    
	        param.saddr = saddr;    
	        param.ddomainid = ddomainid;
	        param.daddr = daddr;
	        param.logdeny = logdeny;    
	        param.logstart = logstart;
	        param.logend = logend;    
	        param.porder = porder;
	        param.porder1 = $("#porder1").val();
	        param.porder2 = $("#porder2").val();
	        param.description = description;
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){    
	        	policyloadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
	        $('#policyw').window('close');
	    }  
	     
	});  
}
//源、目的地址后选择按钮
function policychooseaddr(oper, type){
	//先清空
	$('#addrCreateForm').form('clear');
	$("#data_  tr:not(:first)").remove();
	
	//再赋值
	var temp = "";
	if(oper == 'edit'){
		temp = "1";
 	}
	var str = $("#" + type + "addr" + temp).val();
	var strname = $("#" + type + "addrname" + temp).val();//页面展示转换后信息
	var strArr = str.split(";");
	var strname_arr = strname.split(",");
	for(var i=0;i<strArr.length-1;i++){
		var sArr = strArr[i].split(",");
		var contypeid = sArr[0];
		var contypename = "";
		if("0" == sArr[0]){
			contypename = "地址簿";
			var val = sArr[1];
		}else if("1" == sArr[0]){
			contypename = "IP/掩码";
			var val = strname_arr[i];
		}else if("2" == sArr[0]){
			contypename = "IP范围";
			var val = sArr[1];
		}
		
		var trHtml = "<tr class='tr'><td  style='display:none;'>" + contypeid + "</td><td  style='text-align:center;width:5%;'>" + contypename + "</td><td  style='text-align:center;width:15%;'>" + val + "</td><td  style='text-align:center;width:5%;'><a class='j-delete'  style='cursor: pointer;' onclick='policydeladdr(this.parentElement.parentElement.rowIndex)'></a></td></tr>";
		var $tr=$("#data_ tr:last"); //$("#"+tab+" tr").eq(row);   tab 表id    row 行数，如：0->第一行 1->第二行 -2->倒数第二行 -1->最后一行
		$tr.after(trHtml);
	}
	
	$('#oper').val(oper);//操作，add/edit
	$('#type').val(type);//地址类型，s/d
	$('.j-delete').linkbutton({
		 iconCls: 'icon-delete',
	     plain: true
	});
	//$('#addrw').attr('style','visibility:visible');
	$('#addrw').window('open');
}
//所有地址回填
function policyAddrFill(){
	var addrstr = '';
	var addrstrv = '';
 	$("#data_ .tr").each(function(){
		addrstr += $(this).children().eq(2).text() + ",";
		addrstrv += $(this).children().eq(0).text() + "," + $(this).children().eq(2).text() + ";";
	});
 	addrstr = addrstr.substring(0, addrstr.length-1);
	
 	var temp = "";
	if($('#oper').val() == 'edit'){
		temp = "1";
 	}
 	
	if($('#type').val() == "s"){
		$("#saddr" + temp).val(addrstrv);
		$("#saddrname" + temp).textbox('setValue', addrstr).textbox('setText', addrstr);
	}else if($('#type').val() == "d"){
		$("#daddr" + temp).val(addrstrv);
		$("#daddrname" + temp).textbox('setValue', addrstr).textbox('setText', addrstr);
	}
	
	$('#addrw').window('close');
}
//地址添加
function policyaddaddr(contypeid, contypename){
	var val = "";
	if('0' == contypeid){
		val = $('#1contype0').val(); 
	}else if('1' == contypeid){
		val = $('#0contype1').textbox('getValue') + '/' + $('#1contype1').textbox('getValue');
	}else if('2' == contypeid){
		val = $('#0contype2').textbox('getValue') + '-' + $('#1contype2').textbox('getValue');
	}
	
	if(val.length <=1){
		return;
	}
	
	var trHtml = "<tr class='tr'><td  style='display:none;'>" + contypeid + "</td><td  style='text-align:center;width:5%;'>" + contypename + "</td><td style='text-align:center;width:15%;'>" + val + "</td><td  style='text-align:center;width:5%;'><a class='j-delete'  style='cursor: pointer;' onclick='policydeladdr(this.parentElement.parentElement.rowIndex)'></a></td></tr>";
	var $tr=$("#data_ tr:last"); //$("#"+tab+" tr").eq(row);   tab 表id    row 行数，如：0->第一行 1->第二行 -2->倒数第二行 -1->最后一行
	$tr.after(trHtml);
	$('.j-delete').linkbutton({
		 iconCls: 'icon-delete',
	     plain: true
	});
}
//地址删除
function policydeladdr(rowIndex){
	document.getElementById("data_").deleteRow(rowIndex); 
}
//校验指定id是否存在
function checkPolicyid(type){
	if(type=='add'){
		var pid = $('#porder2').val();
	}else{
		var pid = $('#_porder2').val();
	}
	var security_id = $('#tabs_security_id').val();
	var flag = true;
	 $.ajax({  
			url:'${pageContext.request.contextPath}/security/checkPolicyid.do',
				    type:'post',  
				    async: false,
				    data: {policyid:pid,security_id:security_id},    
				    success:function(data){ 
						flag=data;
				    }	    
				});
	return flag;
}
</script>
<form id="policyManForm"></form>
<div data-options="region:'center',border:false">
	<table title="" style="width:100%;"  id="policy_grid">
		<thead>
			<tr>
				<th data-options="field:'policyid',width:8,align:'center'">ID</th>
				<th data-options="field:'policyname',width:10,align:'center'">名称</th>
				<th data-options="field:'sdomainname',width:10,align:'center'">源安全域</th>
				<th data-options="field:'saddrstr',width:50,align:'center'">源地址</th>
				<th data-options="field:'ddomainname',width:12,align:'center'">目的安全域</th>
				<th data-options="field:'daddrstr',width:50,align:'center'">目的地址</th>
				<th data-options="field:'behavior',width:10,align:'center',formatter:policybeformatter">行为</th>
				<th data-options="field:'pstatus',width:8,align:'center',formatter:policypsformatter">状态</th>
				<th data-options="field:'securityid',width:17,align:'center',formatter:fwoptionformatter">操作</th>
			</tr>
		</thead>
	</table>
</div>  

<div id="policyw" class="pop" style="visibility: hidden;">
        <div class="item-wrap">
            <div class="item2">
                <div class="item-title">基础配置</div>
                <div class="item-wrap">
                 	<form id="policyCreateForm" method="post" data-options="novalidate:true">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout">
                        <tr>
                            <td align="right" width="30%">名称：</td>
                            <td align="left" width="70%">
                                <input id="policyname" type="text" class="easyui-textbox" style="width:174px;">
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">行为：</td>
                            <td id="beha" align="left" width="70%">
                                <ul class="item-ul j-toggle">
                                    <li id="behavior" class="active" style="padding:0 5px">允许</li>
                                    <li id="behavior_1"style="padding:0 5px">拒绝</li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">源安全域：</td>
                            <td align="left" width="70%">
                            	<input type="hidden" id="_sdomain"/>
                                <select  id="sdomain" class="easyui-combobox"  data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#_sdomain').val(rec.value);}" style="width: 174px;">
                                    <option value="Any">Any</option>
									<option value="trust">trust</option>
									<option value="untrust">untrust</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">源地址：</td>
                            <td align="left" width="70%">
                            	<input type="hidden" id="saddr"/>  
                                <input id="saddrname" type="text" class="easyui-textbox" style="width:174px;"  data-options="editable:false">
                                <span style="position: relative; top: 4px;left: 8px; cursor: pointer;"  ><img onclick="policychooseaddr('add', 's');" src="/icpmg/easyui-1.4/themes/icons/edit_add.png"></span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">目的安全域：</td>
                            <td align="left" width="70%">
                            	<input type="hidden" id="ddomainid"/>
                                <select id="ddomain" class="easyui-combobox " data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#ddomainid').val(rec.value);}" style="width: 174px;">
                                    <option value="Any">Any</option>
									<option value="trust">trust</option>
									<option value="untrust">untrust</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">目的地址：</td>
                            <td align="left" width="70%">
                            	<input type="hidden" id="daddr"/>
                                <input id="daddrname" type="text" class="easyui-textbox" data-options="editable:false" style="width:174px;">
                                <span style="position: relative; top: 4px;left: 8px; cursor: pointer;" ><img onclick="policychooseaddr('add', 'd');" src="/icpmg/easyui-1.4/themes/icons/edit_add.png"></span>
                            </td>
                        </tr>
                    </table>
                    </form>
                </div>
            </div>
            <div class="item2 " style="margin-bottom: 10px">
                <div class="item-title">高级配置</div>
                <div class="item-wrap">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout">
                        <tr>
                            <td align="right" width="30%">描述：</td>
                            <td align="left" width="70%">
                                <input id="description" type="text" class="easyui-textbox" style="width: 291px;">
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">记录日志：</td>
                            <td id="log" align="left" width="70%">
                                <ul  class="j-multiple">
                                    <li id="log_deny" class="default-btn-demo2 active" style="padding:0 22px">拒绝策略</li>
                                    <li id="log_end" class="default-btn-demo2" style="padding:0 22px">会话结束</li>
                                    <li id="log_start" class="default-btn-demo2" style="padding:0 23px">会话开始</li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">列表位置：</td>
                            <td align="left" width="70%">
                            	<input type="hidden" id="porder1"/>
                                <select  id="p1" class="easyui-combobox " style="width: 170px;" data-options="panelHeight:'auto',width:140,editable:false,
									onSelect: function(rec){
										$('#porder1').val(rec.value);
									}">
                                   	<option value="">------</option>
									<option value="front">列表最前</option>
									<option value="last">列表最后</option>
									<option value="befor">该ID之前</option>
									<option value="after">该ID之后</option>
                                </select>
                                <input id="porder2" type="text" class="easyui-textbox" style="width: 120px;" prompt="位置越前优先级越高" onblur="if(!this.value){this.value =this.defaultValue;this.style.color = '#666';}" onfocus="if(this.value==this.defaultValue)this.value ='';this.style.color = '#333';" style="color: #666;">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
<div id="addrw" class="pop">
        <div class="item3">
        	<form id="addrCreateForm" method="post" data-options="novalidate:true">
			<input type="hidden" id="oper"/>
			<input type="hidden" id="type"/>
            <table class="table-layout">
                <tr>
                    <td>配置类型：</td>
                    <td>
                       <select id="addrcontype" class="easyui-combobox"  data-options="panelHeight:'auto',width:80,editable:false,onSelect: 
							function(rec){
							for(var i=0; i<3; i++){
								document.getElementById('contype' + i).style.display='none';
							}
							document.getElementById('contype' + rec.value).style.display=''; 
					    	}">
						<option value="0">地址簿</option>
						<option value="1">IP/掩码</option>
						<option value="2">IP范围</option>
						</select>
                    </td>
                    <td>
                        <div id="contype0" style="display:none;">
							<input type="hidden" id="1contype0"/>
							&nbsp;<select id="_cha" class="easyui-combobox"  data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#1contype0').val(rec.value);}">
								<option value="Any">Any</option>
							</select>
							&nbsp;<a class="j-link-add" href="javascript:void(0)" onclick="policyaddaddr('0', '地址簿');" style="width:50px" title="添加"></a>
						</div>
						<div id="contype1" style="display:none;">
							&nbsp;<input id="0contype1" class="easyui-textbox" style="width:100px;height:22px;"/>
							&nbsp;/&nbsp;<input id="1contype1" class="easyui-textbox" style="width:100px;height:22px;"/>
							&nbsp;<a class="j-link-add" href="javascript:void(0)" onclick="policyaddaddr('1', 'IP/掩码');" style="width:50px" title="添加"></a>
						</div>
						<div id="contype2" style="display:none;">
							&nbsp;<input id="0contype2" class="easyui-textbox" style="width:100px;height:22px;"/>
							&nbsp;-&nbsp;<input id="1contype2" class="easyui-textbox" style="width:100px;height:22px;"/>
							&nbsp;<a class="j-link-add" href="javascript:void(0)" onclick="policyaddaddr('2', 'IP范围');" style="width:50px" title="添加"></a>
						</div> 
                    </td>
                </tr>
            </table>
            </form>
        </div>
        <div class="panle" data-options="fit:true">
            <table id="data_" class="table-data">
            	<tbody id="tb">
					<tr>
						<th scope="col" style="text-align:center;display:none;">类型编码</th>
						<th scope="col" style="text-align:center;width:5%;">类型</th>
						<th scope="col" style="text-align:center;width:15%;">成员</th>
						<th scope="col" style="text-align:center;width:5%;">操作</th>
						
					</tr>
				</tbody>
            </table>
        </div>
    </div>    

<div id="policyw1" class="pop" style="visibility: hidden;">
        <div class="item-wrap">
            <div class="item2">
                <div class="item-title">基础配置</div>
                <div class="item-wrap">
                 	<form id="policyCreateForm1" method="post" data-options="novalidate:true">
                 	<input type="hidden" id="policyid1"/>
					<input type="hidden" id="seqno"/>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout">
                        <tr>
                            <td align="right" width="30%">名称：</td>
                            <td align="left" width="70%">
                                <input id="policyname1" type="text" class="easyui-textbox" style="width:174px;">
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">行为：</td>
                            <td id="beha1" align="left" width="70%">
                                <ul class="item-ul j-toggle">
                                    <li id="behavior1" class="active" style="padding:0 5px">允许</li>
                                    <li id="behavior1_1" style="padding:0 5px">拒绝</li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">源安全域：</td>
                            <td align="left" width="70%">
                            	<input type="hidden" id="_sdomain1"/>
                                <select  id="sdomain1" class="easyui-combobox"  data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#_sdomain1').val(rec.value);}" style="width: 174px;">
                                    <option value="Any">Any</option>
									<option value="trust">trust</option>
									<option value="untrust">untrust</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">源地址：</td>
                            <td align="left" width="70%">
                            	<input type="hidden" id="saddr1"/>  
                                <input id="saddrname1" type="text" class="easyui-textbox" style="width:174px;"  data-options="editable:false">
                                <span style="position: relative; top: 4px;left: 8px; cursor: pointer;"  ><img onclick="policychooseaddr('edit', 's');" src="/icpmg/easyui-1.4/themes/icons/edit_add.png"></span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">目的安全域：</td>
                            <td align="left" width="70%">
                            	<input type="hidden" id="ddomainid1"/>
                                <select id="ddomain1" class="easyui-combobox " data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#ddomainid1').val(rec.value);}" style="width: 174px;">
                                    <option value="Any">Any</option>
									<option value="trust">trust</option>
									<option value="untrust">untrust</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">目的地址：</td>
                            <td align="left" width="70%">
                            	<input type="hidden" id="daddr1"/>
                                <input id="daddrname1" type="text" class="easyui-textbox" data-options="editable:false" style="width:174px;">
                                <span style="position: relative; top: 4px;left: 8px; cursor: pointer;" ><img onclick="policychooseaddr('edit', 'd');" src="/icpmg/easyui-1.4/themes/icons/edit_add.png"></span>
                            </td>
                        </tr>
                    </table>
                    </form>
                </div>
            </div>
            <div class="item2 " style="margin-bottom: 10px">
                <div class="item-title">高级配置</div>
                <div class="item-wrap">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout">
                        <tr>
                            <td align="right" width="30%">描述：</td>
                            <td align="left" width="70%">
                                <input id="description1" type="text" class="easyui-textbox" style="width: 291px;">
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">记录日志：</td>
                            <td id="log1" align="left" width="70%">
                                <ul class="j-multiple">
                                    <li id="log_deny1" class="default-btn-demo2 active" style="padding:0 22px">拒绝策略</li>
                                    <li id="log_end1" class="default-btn-demo2" style="padding:0 22px">会话结束</li>
                                    <li id="log_start1" class="default-btn-demo2" style="padding:0 23px">会话开始</li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">列表位置：</td>
                            <td align="left" width="70%">
                            	<input type="hidden" id="_porder1"/>
                                <select  id="_p1" class="easyui-combobox " style="width: 170px;" data-options="panelHeight:'auto',width:140,editable:false,
									onSelect: function(rec){
										$('#_porder1').val(rec.value);
									}">
                                   	<option value="">------</option>
									<option value="front">列表最前</option>
									<option value="last">列表最后</option>
									<option value="befor">该ID之前</option>
									<option value="after">该ID之后</option>
                                </select>
                                <input id="_porder2" type="text" class="easyui-textbox" style="width: 120px;" prompt="位置越前优先级越高" onblur="if(!this.value){this.value =this.defaultValue;this.style.color = '#666';}" onfocus="if(this.value==this.defaultValue)this.value ='';this.style.color = '#333';" style="color: #666;">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>

