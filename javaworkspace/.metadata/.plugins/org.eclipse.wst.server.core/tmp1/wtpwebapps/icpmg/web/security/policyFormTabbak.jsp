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
<link href="../../css/formtabs.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../js/sliding.form.js"></script>
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
								
								$('#policyw').window('open');
							}
						}
                       ];
$(document).ready(function() {
	loadDataGrid();
});
$('#addrcontype').combobox({    
	onSelect: function(rec){
		for(var i=0; i<3; i++){
			document.getElementById('contype' + i).style.display="none";
		}
		
		document.getElementById('contype' + rec.value).style.display=""; 
    }
});
//查询结果
function loadDataGrid(){
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
			var _rows = $('#policy_grid').datagrid("getRows").length
		    var total = pageopt.total;
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {operation : ''})
				}
				 $('#policy_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    		total: total,
			     });
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
		}
	 }); 
}
//行为属性格式化
function beformatter(value, row, index) {
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
function psformatter(value, row, index) {
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
		str = "<a href=\"javascript:void(0);\" onclick=\"editstatus(\'1\',\'" + row.policyid + "\');\">启用</a>";
	}else if(row.pstatus == "1"){
		str = "<a href=\"javascript:void(0);\" onclick=\"editstatus(\'0\',\'" + row.policyid + "\');\">停用</a>";
	}
	
	str += "&nbsp;|&nbsp;<a href=\"javascript:void(0);\" onclick=\"getpolicy(\'" + row.policyid + "\',\'" + row.policyname
			+ "\',\'" + row.behavior + "\',\'" + row.sdomainid + "\',\'" + row.ddomainid + "\',\'" + row.saddrstr
			+ "\',\'" + row.saddrstrv + "\',\'" + row.daddrstr + "\',\'" + row.daddrstrv + "\',\'" + row.description
			+ "\',\'" + row.logdeny + "\',\'" + row.logstart + "\',\'" + row.logend
			+ "\');\">修改</a>&nbsp;|&nbsp;" 
			+ "<a href=\"javascript:void(0);\" onclick=\"delbefore(\'" + row.policyid + "\');\">删除</a>"; 
	return str;
} 
//获取单记录信息展示
function getpolicy(policyid, policyname, behavior, sdomainid, ddomainid, saddrstr, saddrstrv, daddrstr, daddrstrv, description, logdeny, logstart, logend){
	$('#policyCreateForm1').form('clear');
	
	$('#policyid1').val(policyid);
	$('#policyname1').textbox('setValue', policyname).textbox('setText', policyname);
	$("input[name='behavior1'][value=" + behavior + "]").attr("checked",true);
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
	var r = document.getElementsByName("log1");  
    for(var i=0;i<r.length;i++){
	 	if(r[i].alt == "deny" && logdeny == "1"){
	 		r[i].checked = true;
		}else if(r[i].alt == "start" && logstart == "1"){
			r[i].checked = true;
		}else if(r[i].alt == "end" && logend == "1"){
			r[i].checked = true;
		}
    } 
	
	$('#policyw1').window('open');
}
//修改配置信息保存
function editpolicy(){
	var policyid = $("#policyid1").val();
	var policyname = $('#policyname1').textbox('getValue');
	var behavior = $("input[name='behavior1']:checked").val(); 
	var sdomainid = $("#_sdomain1").val();
	var saddr = $("#saddr1").val();
	var ddomainid = $("#ddomainid1").val();
	var daddr = $("#daddr1").val();
	var description = $('#description1').textbox('getValue');
	
	var logdeny = "0";
	var logstart = "0";
	var logend = "0";
	var r=document.getElementsByName("log1");  
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
    } 
    
    var porder = "";
    var porder1 = $('#_porder1').val();
    if(null != porder1 && "" != porder1){
	    var porder2 = $('#_porder2').textbox('getValue');
    	porder = changeseqno(porder1, porder2);
    }

    $('#policyCreateForm1').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/updatePolicy.do",    
	    onSubmit: function(param){ 
	     	param.securityid = $("#tabs_security_id").val(); 
	    	param.serviceid = $("#tabs_service_id").val();
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
	        param.description = description;
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){    
	        	loadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
	        $('#policyw1').window('close');
	    }    

	});  
}
//单记录修改状态
function editstatus(pstatus, policyid){
	$('#policyManForm').form('submit',{
		url:'${pageContext.request.contextPath}/security/updatePolicyStatus.do', 
	    onSubmit : function(param) {
	    	param.securityid = $("#tabs_security_id").val(); 
	    	param.serviceid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val(); 
			param.policyid=policyid;
			param.pstatus=pstatus;
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
//单记录删除
function delbefore(policyid){
	$.messager.confirm('系统提示信息', '当前策略删除后不可恢复，请谨慎操作，确定删除吗？', function(r){
		if (r){
			$('#policyManForm').form('submit',{
				url:'${pageContext.request.contextPath}/security/delPolicy.do', 
			    onSubmit : function(param) {
			    	param.securityid = $("#tabs_security_id").val(); 
			    	param.serviceid = $("#tabs_service_id").val();
			    	param.displayname = $("#tabs_displayname").val();
			    	param.manip = $("#tabs_manip").val(); 
					param.policyid=policyid;
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
	var behavior = $("input[name='behavior']:checked").val(); 
	var sdomainid = $("#_sdomain").val();
	var saddr = $("#saddr").val();
	var ddomainid = $("#ddomainid").val();
	var daddr = $("#daddr").val();
	var description = $('#description').textbox('getValue');
	
	var logdeny = "0";
	var logstart = "0";
	var logend = "0";
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
    } 
    
    var porder = "";
    var porder1 = $('#porder1').val();
    if(null != porder1 && "" != porder1){
	    var porder2 = $('#porder2').textbox('getValue');
    	porder = changeseqno(porder1, porder2);
    }
    
    $('#policyCreateForm').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/savePolicy.do",    
	    onSubmit: function(param){ 
	     	param.securityid = $("#tabs_security_id").val(); 
	    	param.serviceid = $("#tabs_service_id").val();
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
	        param.description = description;
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){    
	        	loadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
	        $('#policyw').window('close');
	    }    

	});  
}
//源、目的地址后选择按钮
function chooseaddr(oper, type){
	//先清空
	$('#addrCreateForm').form('clear');
	$("#data_  tr:not(:first)").remove();
	
	//再赋值
	var temp = "";
	if(oper == 'edit'){
		temp = "1";
 	}
	var str = $("#" + type + "addr" + temp).val();
	var strArr = str.split(";");
	for(var i=0;i<strArr.length-1;i++){
		var sArr = strArr[i].split(",");
		var contypeid = sArr[0];
		var contypename = "";
		if("0" == sArr[0]){
			contypename = "地址簿";
		}else if("1" == sArr[0]){
			contypename = "IP/掩码";
		}else if("2" == sArr[0]){
			contypename = "IP范围";
		}
		var val = sArr[1];
		var trHtml = "<tr class='tr'><td class='FieldInput3' style='display:none;'>" + contypeid + "</td><td class='FieldInput3' style='width:5%;'>" + contypename + "</td><td class='FieldInput3' style='width:15%;'>" + val + "</td><td class='FieldInput3' style='width:5%;'><a style='cursor: pointer;' onclick='deladdr(this.parentElement.parentElement.rowIndex)'>删除</a></td></tr>";
		var $tr=$("#data_ tr:last"); //$("#"+tab+" tr").eq(row);   tab 表id    row 行数，如：0->第一行 1->第二行 -2->倒数第二行 -1->最后一行
		$tr.after(trHtml);
	}
	
	$('#oper').val(oper);//操作，add/edit
	$('#type').val(type);//地址类型，s/d
	$('#addrw').window('open');
}
//所有地址回填
$("#tj").live("click", function(){
	var addrstr = '';
	var addrstrv = '';
 	$(".tr").each(function(){
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
})
//地址添加
function addaddr(contypeid, contypename){
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
	
	var trHtml = "<tr class='tr'><td class='FieldInput3' style='display:none;'>" + contypeid + "</td><td class='FieldInput3' style='width:5%;'>" + contypename + "</td><td class='FieldInput3' style='width:15%;'>" + val + "</td><td class='FieldInput3' style='width:5%;'><a style='cursor: pointer;' onclick='deladdr(this.parentElement.parentElement.rowIndex)'>删除</a></td></tr>";
	var $tr=$("#data_ tr:last"); //$("#"+tab+" tr").eq(row);   tab 表id    row 行数，如：0->第一行 1->第二行 -2->倒数第二行 -1->最后一行
	$tr.after(trHtml);
}
//地址删除
function deladdr(rowIndex){
	document.getElementById("data_").deleteRow(rowIndex); 
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
				<th data-options="field:'behavior',width:10,align:'center',formatter:beformatter">行为</th>
				<th data-options="field:'pstatus',width:8,align:'center',formatter:psformatter">状态</th>
				<th data-options="field:'securityid',width:17,align:'center',formatter:fwoptionformatter">操作</th>
			</tr>
		</thead>
	</table>
</div>  
<div id="policyw" class="easyui-window" title="新增安全策略" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save'" style="width:640px;height:500px;padding:5px;top:127px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<div id="navigation" style="display:none;float:left">
				<ul>
					<li class="selected">
						<a href="#">基本信息</a>
					</li>
					<li>
						<a href="#">高级设置</a>
					</li>
				</ul>
			</div>
			<div id="wrapper">

				<div id="steps">
					<form id="policyCreateForm" method="post" data-options="novalidate:true">
						<fieldset class="step">

							<div style="margin-bottom:5px;">
								<p style="margin-left:30px;">名称：
									<input id="policyname" class="easyui-textbox" style="width:100px;height:22px;"/>&nbsp;
								</p>
							</div>
							<div style="margin-bottom:5px;">
								<p style="margin-left:30px;">行为：
									&nbsp;<input type="radio" name="behavior" value="2"/>允许
									&nbsp;<input type="radio" name="behavior" value="1"/>拒绝
								</p>
							</div>
							<div style="margin-bottom:5px;">
								<p style="margin-left:30px;">源安全域：
									<input type="hidden" id="_sdomain"/>
									<select id="sdomain" class="easyui-combobox"
											data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#_sdomain').val(rec.value);}">
										<option value="Any">Any</option>
										<option value="MGT">MGT</option>
										<option value="trust">trust</option>
										<option value="untrust">untrust</option>
									</select>
								</p>
							</div>
							<div style="margin-bottom:5px;">
								<p style="margin-left:30px;">源地址：
									<input type="hidden" id="saddr"/>
									<input id="saddrname" class="easyui-textbox" style="width:200px;height:22px;"
										   data-options="editable:false"/>
									<a class="easyui-linkbutton" href="javascript:void(0)"
									   onclick="chooseaddr('add', 's');"
									   style="width:50px">选择</a>
								</p>
							</div>
							<div style="margin-bottom:5px;">
								<p style="margin-left:30px;">目的安全域：
									<input type="hidden" id="ddomainid"/>
									<select id="ddomain" class="easyui-combobox"
											data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#ddomainid').val(rec.value);}">
										<option value="Any">Any</option>
										<option value="MGT">MGT</option>
										<option value="trust">trust</option>
										<option value="untrust">untrust</option>
									</select>
								</p>
							</div>
							<div style="margin-bottom:5px;">
								<p style="margin-left:30px;">目的地址：
									<input type="hidden" id="daddr"/>
									<input id="daddrname" class="easyui-textbox" style="width:200px;height:22px;"
										   value="Any" data-options="editable:false"/>
									<a class="easyui-linkbutton" href="javascript:void(0)"
									   onclick="chooseaddr('add', 'd');"
									   style="width:50px">选择</a>
								</p>
							</div>
						</fieldset>
						<fieldset class="step">


							<div style="margin-bottom:5px;">
								<p style="margin-left:30px;">描述：
									<input id="description" class="easyui-textbox" style="width:200px;height:22px;"/>
								</p>
							</div>
							<div style="margin-bottom:5px;">
								<p style="margin-left:30px;">记录日志：
									&nbsp;<input type="checkbox" name="log" alt="deny"/>策略拒绝
									&nbsp;<input type="checkbox" name="log" alt="end"/>会话结束
									&nbsp;<input type="checkbox" name="log" alt="start"/>会话开始
								</p>
							</div>
							<div style="margin-bottom:5px;">
								<p style="margin-left:30px;">列表位置：
									<input type="hidden" id="porder1"/>
									<select id="p1" class="easyui-combobox" data-options="panelHeight:'auto',width:140,editable:false,
					onSelect: function(rec){
						$('#porder1').val(rec.value);
					}">
										<option value="">------</option>
										<option value="front">列表最前</option>
										<option value="last">列表最后</option>
										<option value="befor">该ID之前</option>
										<option value="after">该ID之后</option>
									</select>
									<input id="porder2" class="easyui-textbox" style="width:50px;height:22px;"/>&nbsp;位置越前，优先级越高
								</p>
							</div>
						</fieldset>
					</form>
				</div>

			</div>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="addpolicy();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#policyw').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
<div id="addrw" class="easyui-window" title="选择地址" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save'" style="width:500px;height:300px;padding:5px;top:157px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="addrCreateForm" method="post" data-options="novalidate:true">
			<input type="hidden" id="oper"/>
			<input type="hidden" id="type"/>
			<div style="margin-bottom:5px;">
				<div style="float:left;">配置类型：
					<select id="addrcontype" class="easyui-combobox"  data-options="panelHeight:'auto',width:80,editable:false">
						<option value="0">地址簿</option>
						<option value="1">IP/掩码</option>
						<option value="2">IP范围</option>
						<!-- <option value="3">主机</option> -->
					</select>
				</div>
				<div id="contype0" style="display:none;">
					<input type="hidden" id="1contype0"/>
					&nbsp;<select id="_cha" class="easyui-combobox"  data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#1contype0').val(rec.value);}">
						<option value="Any">Any</option>
					</select>
					&nbsp;<a class="easyui-linkbutton" href="javascript:void(0)" onclick="addaddr('0', '地址簿');" style="width:50px">添加</a>
				</div>
				<div id="contype1" style="display:none;">
					&nbsp;<input id="0contype1" class="easyui-textbox" style="width:100px;height:22px;"/>
					&nbsp;/&nbsp;<input id="1contype1" class="easyui-textbox" style="width:100px;height:22px;"/>
					&nbsp;<a class="easyui-linkbutton" href="javascript:void(0)" onclick="addaddr('1', 'IP/掩码');" style="width:50px">添加</a>
				</div>
				<div id="contype2" style="display:none;">
					&nbsp;<input id="0contype2" class="easyui-textbox" style="width:100px;height:22px;"/>
					&nbsp;-&nbsp;<input id="1contype2" class="easyui-textbox" style="width:100px;height:22px;"/>
					&nbsp;<a class="easyui-linkbutton" href="javascript:void(0)" onclick="addaddr('2', 'IP范围');" style="width:50px">添加</a>
				</div>
			</div>
			<div style="height:160px;overflow-y:scroll;margin-top:5px;clear:both;">
				<table id="data_" style="width:100%">  
					<tbody id="tb">
						<tr>
							<td class="FieldLabel3" style="display:none;">类型编码</td>
							<td class="FieldLabel3" style="width:5%;">类型</td>
							<td class="FieldLabel3" style="width:15%;">成员</td>
							<td class="FieldLabel3" style="width:5%;">操作</td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" id="tj" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#addrw').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
<div id="policyw1" class="easyui-window" title="修改安全策略" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save'" style="width:700px;height:400px;padding:5px;top:127px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="policyCreateForm1" method="post" data-options="novalidate:true">
			<input type="hidden" id="policyid1"/>
			<h2>基本配置</h2>
			<div style="margin-bottom:5px;">
				<p style="margin-left:30px;">名称：
					<input id="policyname1" class="easyui-textbox" style="width:100px;height:22px;"/>&nbsp;
				</p>
			</div>
			<div style="margin-bottom:5px;">
				<p style="margin-left:30px;">行为：
					&nbsp;<input type="radio" name="behavior1" value="2"/>允许
					&nbsp;<input type="radio" name="behavior1" value="1"/>拒绝
				</p>
			</div>
			<div style="margin-bottom:5px;">
				<p style="margin-left:30px;">源安全域：
					<input type="hidden" id="_sdomain1"/>
					<select id="sdomain1" class="easyui-combobox"  data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#_sdomain1').val(rec.value);}">
						<option value="Any">Any</option>
						<option value="MGT">MGT</option>
						<option value="trust">trust</option>
						<option value="untrust">untrust</option>
					</select>
				</p>
			</div>
			<div style="margin-bottom:5px;">
				<p style="margin-left:30px;">源地址：
					<input type="hidden" id="saddr1"/>
					<input id="saddrname1" class="easyui-textbox" style="width:200px;height:22px;" data-options="editable:false"/>
					<a class="easyui-linkbutton" href="javascript:void(0)" onclick="chooseaddr('edit', 's');" style="width:50px">选择</a>
				</p>
			</div>
			<div style="margin-bottom:5px;">
				<p style="margin-left:30px;">目的安全域：
					<input type="hidden" id="ddomainid1"/>
					<select id="ddomain1" class="easyui-combobox" data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#ddomainid1').val(rec.value);}">
						<option value="Any">Any</option>
						<option value="MGT">MGT</option>
						<option value="trust">trust</option>
						<option value="untrust">untrust</option>
					</select>
				</p>
			</div>
			<div style="margin-bottom:5px;">
				<p style="margin-left:30px;">目的地址：
					<input type="hidden" id="daddr1"/>
					<input id="daddrname1" class="easyui-textbox" style="width:200px;height:22px;" value="Any" data-options="editable:false"/>
					<a class="easyui-linkbutton" href="javascript:void(0)" onclick="chooseaddr('edit', 'd');" style="width:50px">选择</a>
				</p>
			</div>
			<h2>高级配置</h2>
			<div style="margin-bottom:5px;">
				<p style="margin-left:30px;">描述：
					<input id="description1" class="easyui-textbox" style="width:200px;height:22px;"/>
				</p>
			</div>
			<div style="margin-bottom:5px;">
				<p style="margin-left:30px;">记录日志：
					&nbsp;<input type="checkbox" name="log1" alt="deny"/>策略拒绝
					&nbsp;<input type="checkbox" name="log1" alt="end"/>会话结束
					&nbsp;<input type="checkbox" name="log1" alt="start"/>会话开始
				</p>
			</div>
			<div style="margin-bottom:5px;">
				<p style="margin-left:30px;">列表位置：
					<input type="hidden" id="_porder1"/>
					<select id="_p1" class="easyui-combobox" data-options="panelHeight:'auto',width:140,editable:false,
					onSelect: function(rec){
						$('#_porder1').val(rec.value);
					}">
						<option value="">------</option>
						<option value="front">列表最前</option>
						<option value="last">列表最后</option>
						<option value="befor">该ID之前</option>
						<option value="after">该ID之后</option>
					</select>
					<input id="_porder2" class="easyui-textbox" style="width:50px;height:22px;"/>&nbsp;位置越前，优先级越高
				</p>
			</div>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="editpolicy();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#policyw1').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
</body>

