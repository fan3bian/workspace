<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
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
var arptoolbar = [
						{
							text:'新增防护配置',
							iconCls:'icon-add',
							handler:function(){ 
								$('#arpCreateForm').form('clear');
								//默认值
								$('#allaction').combobox('setValue', '');
								$("#icmp").attr("checked",'true');
								$('#icmpalert').textbox('setValue', 1500).textbox('setText', 1500);
								$('#r0').combobox('setValue', 0);
								$("#udp").attr("checked",'true');
								$('#udpsalert').textbox('setValue', 1500).textbox('setText', 1500);
								$('#udpdalert').textbox('setValue', 1500).textbox('setText', 1500);
								$('#r1').combobox('setValue', 0);
								$('#r2').combobox('setValue', 0);
								$('#arpipnumofmac').textbox('setValue', '0').textbox('setText', '0');
								$('#arppsendrate').textbox('setValue', '0').textbox('setText', '0');
								$("#syn").attr("checked",'true');
								$('#syndalerttype').combobox('setValue', 1);
								$('#synsalert').textbox('setValue', 1500).textbox('setText', 1500);
								$('#syndalert').textbox('setValue', 1500).textbox('setText', 1500);
								$('#r3').combobox('setValue', 0);
								$('#syndalerttype').combobox('setValue', 1);
								$("#winnuke").attr("checked",'true');
								$("#ipcheat").attr("checked",'true');
								$("#ipscanning").attr("checked",'true');
								$('#ipscanningalert').textbox('setValue', 1).textbox('setText', 1);
								$('#r4').combobox('setValue', 0);
								$("#portscanning").attr("checked",'true');
								$('#portscanningalert').textbox('setValue', 1).textbox('setText', 1);
								$('#r5').combobox('setValue', 0);
								$("#pingofdeath").attr("checked",'true');
								$("#treadrop").attr("checked",'true');
								$("#ipshard").attr("checked",'true');
								$('#r6').combobox('setValue', 0);
								$("#ipoption").attr("checked",'true');
								$('#r7').combobox('setValue', 0);
								$("#sf").attr("checked",'true');
								$('#r8').combobox('setValue', 0);
								$("#land").attr("checked",'true');
								$('#r9').combobox('setValue', 0);
								$('#icmpbpalert').textbox('setValue', 1024).textbox('setText', 1024);
								$('#r10').combobox('setValue', 0);
								$('#synagentminrate').textbox('setValue', 1000).textbox('setText', 1000);
								$('#synagentmaxrate').textbox('setValue', 3000).textbox('setText', 3000);
								$('#syntimeout').textbox('setValue', 30).textbox('setText', 30);
								$('#r11').combobox('setValue', 0);
								$('#dnssalert').textbox('setValue', 1500).textbox('setText', 1500);
								$('#dnsdalert').textbox('setValue', 1500).textbox('setText', 1500);
								$('#r12').combobox('setValue', 0);
								$('#dnsrsalert').textbox('setValue', 1000).textbox('setText', 1000);
								$('#dnsrdalert').textbox('setValue', 1000).textbox('setText', 1000);
								$('#r13').combobox('setValue', 0);
								
								$('#arpw').window('open');
							}
						}
                       ];
$(document).ready(function() {
	loadDataGrid();
});
//安全域选择校验
$('#domain').combobox({    
	onSelect: function(rec){
		$('#domainid').val(rec.value);
		if(null != rec.value && "" != rec.value){
			$.ajax({  
			    url:'${pageContext.request.contextPath}/security/chkArpByDomain.do',
			    type:'post',  
			    async: false,
			    data: {domainid: rec.value, securityid: $("#tabs_security_id").val()},    
			    dataType:'json',  
			    success:function(data){ 
			    	if(data.success){
			    		$.messager.alert('提示信息','当前安全域下已经配置了攻击防护信息,不允许重复配置！', 'info'); 
			    		$('#addarp').linkbutton("disable", true);
			    	}else{
			    		$('#addarp').linkbutton("enable");
			    	}
			    }
			})
		}else{
			$('#addarp').linkbutton("enable");
		}
    }
});
//查询结果
function loadDataGrid(){
	grid = $('#arp_grid').datagrid({
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
		toolbar:arptoolbar,    
	    url:'${pageContext.request.contextPath}/security/arpDomainList.do?securityid=' + $("#tabs_security_id").val(),
	    onLoadSuccess : function(data) {
			var pageopt = $('#arp_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var _rows = $('#arp_grid').datagrid("getRows").length
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {operation : ''})
				}
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
		}
	 }); 
}
//操作列格式化
function fwoptionformater(value, row, index) {
	if(!value){
		return "";
	}
	var str = "";
	if(row.usestat == "0"){
		str = "<a href=\"javascript:void(0);\" onclick=\"editstatus(\'1\',\'" + row.domainid + "\');\">启用</a>";
	}else{
		str = "<a href=\"javascript:void(0);\" onclick=\"editstatus(\'0\',\'" + row.domainid + "\');\">停用</a>";
	}
	str += "&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"getdomainarp(\'" + row.domainid + "\', \'"
			+ row.alluser + "\', \'" + row.allaction + "\', \'" + row.icmp  + "\', \'" + row.icmpalert + "\', \'"
			+ row.icmpaction + "\', \'" + row.udp + "\', \'" + row.udpsalert  + "\', \'" + row.udpdalert + "\', \'" 
			+ row.udpaction + "\', \'" + row.arp + "\', \'" + row.arpaction + "\', \'" + row.arpipnumofmac  + "\', \'"
			+ row.arppsendrate + "\', \'" + row.arpreverseq + "\', \'" + row.syn + "\', \'" + row.synsalert + "\', \'"
			+ row.syndalert  + "\', \'" + row.synaction + "\', \'" + row.syndalerttype + "\', \'" + row.winnuke + "\', \'"
			+ row.ipcheat  + "\', \'" + row.ipscanning + "\', \'" + row.ipscanningalert + "\', \'" + row.ipscanningaction + "\', \'" 
			+ row.portscanning  + "\', \'" + row.portscanningalert + "\', \'" + row.portscanningaction + "\', \'"
			+ row.pingofdeath + "\', \'" + row.treadrop + "\', \'" + row.ipshard  + "\', \'" + row.ipshardaction + "\', \'"
			+ row.ipoption + "\', \'" + row.ipoptionaction + "\', \'" + row.sf  + "\', \'" + row.sfaction + "\', \'"
			+ row.land + "\', \'" + row.landaction + "\', \'" + row.icmpbp + "\', \'" + row.icmpbpalert  + "\', \'"
			+ row.icmpbpaction + "\', \'" + row.synagent + "\', \'" + row.synagentminrate + "\', \'" + row.synagentmaxrate + "\', \'" 
			+ row.syncookie+ "\', \'" + row.syntimeout + "\', \'" + row.tcp + "\', \'" + row.tcpaction + "\', \'"
			+ row.dns + "\', \'" + row.dnssalert + "\', \'" + row.dnsdalert + "\', \'" + row.dnsaction  + "\', \'" 
			+ row.dnsr + "\', \'" + row.dnsrsalert  + "\', \'" + row.dnsrdalert + "\', \'" + row.dnsraction + "\');\">修改</a>"; 
	return str;
} 
//单记录获取信息
function getdomainarp(domainid, alluser, allaction, icmp, icmpalert, icmpaction, udp, udpsalert, udpdalert, udpaction,
		arp, arpaction, arpipnumofmac, arppsendrate, arpreverseq, syn, synsalert, syndalert, synaction, syndalerttype,
		winnuke, ipcheat, ipscanning, ipscanningalert, ipscanningaction, portscanning, portscanningalert, portscanningaction,
		pingofdeath, treadrop, ipshard, ipshardaction, ipoption, ipoptionaction, sf, sfaction, land, landaction, icmpbp,
		icmpbpalert, icmpbpaction, synagent, synagentminrate, synagentmaxrate, syncookie, syntimeout, tcp, tcpaction, 
		dns, dnssalert, dnsdalert ,dnsaction, dnsr, dnsrsalert, dnsrdalert, dnsraction){
	$('#arpCreateForm1').form('clear');
	
	$('#domainid1').val(domainid);
	$('#domain1').combobox('setValue', domainid);
	if(alluser == 1){
		$("#alluser1").attr("checked",'true');
	}
	if(null === allaction || "null" === allaction){
		$('#allaction1').combobox('setValue', '');
	}else{
		$('#allaction1').combobox('setValue', allaction);
	}
	if(icmp == 1){
		$("#icmp1").attr("checked",'true');
	}
	$('#icmpalert1').textbox('setValue', icmpalert).textbox('setText', icmpalert);
	$('#_r0').combobox('setValue', icmpaction);
	if(udp == 1){
		$("#udp1").attr("checked",'true');
	}
	$('#udpsalert1').textbox('setValue', udpsalert).textbox('setText', udpsalert);
	$('#udpdalert1').textbox('setValue', udpdalert).textbox('setText', udpdalert);
	$('#_r1').combobox('setValue', udpaction);
	if(arp == 1){
		$("#arp1").attr("checked",'true');
	}
	$('#_r2').combobox('setValue', arpaction);
	$('#arpipnumofmac1').textbox('setValue', arpipnumofmac).textbox('setText', arpipnumofmac);
	$('#arppsendrate1').textbox('setValue', arppsendrate).textbox('setText', arppsendrate);
	if(syn == 1){
		$("#syn1").attr("checked",'true');
	}
	$('#synsalert1').textbox('setValue', synsalert).textbox('setText', synsalert);
	$('#syndalert1').textbox('setValue', syndalert).textbox('setText', syndalert);
	$('#_r3').combobox('setValue', synaction);
	$('#syndalerttype1').combobox('setValue', syndalerttype);
	if(winnuke == 1){
		$("#winnuke1").attr("checked",'true');
	}
	if(ipcheat == 1){
		$("#ipcheat1").attr("checked",'true');
	}
	if(ipscanning == 1){
		$("#ipscanning1").attr("checked",'true');
	}
	$('#ipscanningalert1').textbox('setValue', ipscanningalert).textbox('setText', ipscanningalert);
	$('#_r4').combobox('setValue', ipscanningaction);
	if(portscanning == 1){
		$("#portscanning1").attr("checked",'true');
	}
	$('#portscanningalert1').textbox('setValue', portscanningalert).textbox('setText', portscanningalert);
	$('#_r5').combobox('setValue', portscanningaction);
	if(pingofdeath == 1){
		$("#pingofdeath1").attr("checked",'true');
	}
	if(treadrop == 1){
		$("#treadrop1").attr("checked",'true');
	}
	if(ipshard == 1){
		$("#ipshard1").attr("checked",'true');
	}
	$('#_r6').combobox('setValue', ipshardaction);
	if(ipoption == 1){
		$("#ipoption1").attr("checked",'true');
	}
	$('#_r7').combobox('setValue', ipoptionaction);
	if(sf == 1){
		$("#sf1").attr("checked",'true');
	}
	$('#_r8').combobox('setValue', sfaction);
	if(land == 1){
		$("#land1").attr("checked",'true');
	}
	$('#_r9').combobox('setValue', landaction);
	if(icmpbp == 1){
		$("#icmpbp1").attr("checked",'true');
	}
	$('#icmpbpalert1').textbox('setValue', icmpbpalert).textbox('setText', icmpbpalert);
	$('#_r10').combobox('setValue', icmpbpaction);
	if(synagent == 1){
		$("#synagent1").attr("checked",'true');
	}
	$('#synagentminrate1').textbox('setValue', synagentminrate).textbox('setText', synagentminrate);
	$('#synagentmaxrate1').textbox('setValue', synagentmaxrate).textbox('setText', synagentmaxrate);
	if(syncookie == 1){
		$("#syncookie1").attr("checked",'true');
	}
	$('#syntimeout1').textbox('setValue', syntimeout).textbox('setText', syntimeout);
	if(tcp == 1){
		$("#tcp1").attr("checked",'true');
	}
	$('#_r11').combobox('setValue', tcpaction);
	if(dns == 1){
		$("#dns1").attr("checked",'true');
	}
	$('#dnssalert1').textbox('setValue', dnssalert).textbox('setText', dnssalert);
	$('#dnsdalert1').textbox('setValue', dnsdalert).textbox('setText', dnsdalert);
	$('#_r12').combobox('setValue', dnsaction);
	if(dnsr == 1){
		$("#dnsr1").attr("checked",'true');
	}
	$('#dnsrsalert1').textbox('setValue', dnsrsalert).textbox('setText', dnsrsalert);
	$('#dnsrdalert1').textbox('setValue', dnsrdalert).textbox('setText', dnsrdalert);
	$('#_r13').combobox('setValue', dnsraction);
	
	$('#arpw1').window('open');
}
//单记录修改状态
function editstatus(status, domainid){
	$("#manForm").form('submit', {
		url:"${pageContext.request.contextPath}/security/updateArpDomainStat.do", 
	    onSubmit : function(param) {
	    	param.securityid = $("#tabs_security_id").val(); 
	    	param.serviceid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val(); 
			param.domainid=domainid;
			param.usestat=status;
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.success) {
				loadDataGrid();
			} else {
				$.messager.alert('提示', "状态修改失败，请重试！", 'error');
			}
	    }
	}); 
}
//新增，全部选中
$("#alluser").change(function(){
	if($("#alluser").prop("checked")){
		var r=document.getElementsByName("chk");  
	    for(var i=0;i<r.length;i++){
	    	r[i].checked = true;
	    }
	}
});
//新增，全部行为
$('#allaction').combobox({    
	onSelect: function(rec){
		if(null != rec.value && "" != rec.value){
		    for(var i=0;i<14;i++){
		    	$('#r' + i).combobox('setValue', rec.value);
		    }
		}
    }
});
//修改，全部选中
$("#alluser1").change(function(){
	if($("#alluser1").prop("checked")){
		var r=document.getElementsByName("chk1");  
	    for(var i=0;i<r.length;i++){
	    	r[i].checked = true;
	    }
	}
});
//修改，全部行为
$('#allaction1').combobox({    
	onSelect: function(rec){
		if(null != rec.value && "" != rec.value){
		    for(var i=0;i<14;i++){
		    	$('#_r' + i).combobox('setValue', rec.value);
		    }
		}
    }
});
//单记录添加保存信息
function adddomainarp(){
	var domainid = $('#domainid').val();//安全域
	if(null == domainid || "" == domainid){
		$.messager.alert('提示信息','请选择安全域！', 'info'); 
		return;
	} 
	
	var alluser = 0;//全部启用
	var icmp = 0;//ICMP洪水攻击防护
	var udp = 0;//UDP洪水攻击防护
	var arp = 0;//ARP欺骗攻击防护
	var syn = 0;//SYN洪水攻击防护
	var ipscanning = 0;//IP地址扫描攻击防护
	var portscanning = 0;//端口扫描防护
	var ipshard = 0;//IP分片防护
	var ipoption = 0;//IP选项
	var sf = 0;//Smurf或者Fraggle攻击防护
	var land = 0;//Land攻击防护
	var icmpbp = 0;//ICMP大包攻击防护
	var tcp = 0;//TCP异常
	var dns = 0;//DNS查询洪水防护
	var dnsr = 0;//DNS递归查询洪水攻击防护
	var winnuke = 0;//winnuke攻击防护
	var ipcheat = 0;//ip地址欺骗攻击防护
	var pingofdeath = 0;//pingofdeath攻击防护
	var treadrop = 0;//Treadrop攻击防护
	var synagent = 0;//syn代理
	if($("#alluser").prop("checked")){
		alluser = 1;
		icmp = 1;
		udp = 1;
		arp = 1;
		syn = 1;
		ipscanning = 1;
		portscanning = 1;
		ipshard = 1;
		ipoption = 1;
		sf = 1;
		land = 1;
		icmpbp = 1;
		tcp = 1;
		dns = 1;
		dnsr = 1;
		winnuke = 1;
		ipcheat = 1;
		pingofdeath = 1;
		treadrop = 1;
		synagent = 1;
	}else{
		if($("#icmp").prop("checked")){
			icmp = 1;
		}
		if($("#udp").prop("checked")){
			udp = 1;
		}
		if($("#arp").prop("checked")){
			arp = 1;
		}
		if($("#syn").prop("checked")){
			syn = 1;
		}
		if($("#ipscanning").prop("checked")){
			ipscanning = 1;
		}
		if($("#portscanning").prop("checked")){
			portscanning = 1;
		}
		if($("#ipshard").prop("checked")){
			ipshard = 1;
		}
		if($("#ipoption").prop("checked")){
			ipoption = 1;
		}
		if($("#sf").prop("checked")){
			sf = 1;
		}
		if($("#land").prop("checked")){
			land = 1;
		}
		if($("#icmpbp").prop("checked")){
			icmpbp = 1;
		}
		if($("#tcp").prop("checked")){
			tcp = 1;
		}
		if($("#dns").prop("checked")){
			dns = 1;
		}
		if($("#dnsr").prop("checked")){
			dnsr = 1;
		}
		if($("#winnuke").prop("checked")){
			winnuke = 1;
		}
		if($("#ipcheat").prop("checked")){
			ipcheat = 1;
		}
		if($("#pingofdeath").prop("checked")){
			pingofdeath = 1;
		}
		if($("#treadrop").prop("checked")){
			treadrop = 1;
		}
		if($("#synagent").prop("checked")){
			synagent = 1;
		}
	}
	
	var allaction = $('#allaction').combobox('getValue');//全部行为
	if(null != allaction && "" != allaction){
		var icmpaction = allaction, udpaction = allaction, arpaction = allaction;
		var synaction = allaction, ipscanningaction = allaction;
		var portscanningaction = allaction, ipshardaction = allaction, ipoptionaction = allaction;
		var sfaction = allaction, landaction = allaction, icmpbpaction = allaction;
		var tcpaction = allaction, dnsaction = allaction, dnsraction = allaction;
	}else{
		var icmpaction = $('#r0').combobox('getValue');//ICMP洪水攻击防护行为
		var udpaction = $('#r1').combobox('getValue');//UDP洪水攻击防护行为
		var arpaction = $('#r2').combobox('getValue');//ARP欺骗攻击防护行为
		var synaction = $('#r3').combobox('getValue');//SYN洪水攻击防护行为
		var ipscanningaction = $('#r4').combobox('getValue');//IP地址扫描攻击防护行为
		var portscanningaction = $('#r5').combobox('getValue');//端口扫描防护行为
		var ipshardaction = $('#r6').combobox('getValue');//IP分片防护行为
		var ipoptionaction = $('#r7').combobox('getValue');//IP选项行为
		var sfaction = $('#r8').combobox('getValue');//Smurf或者Fraggle攻击防护行为
		var landaction = $('#r9').combobox('getValue');//Land攻击防护行为
		var icmpbpaction = $('#r10').combobox('getValue');//ICMP大包攻击防护行为
		var tcpaction = $('#r11').combobox('getValue');//TCP异常行为
		var dnsaction = $('#r12').combobox('getValue');//DNS查询洪水防护行为
		var dnsraction = $('#r13').combobox('getValue');//DNS递归查询洪水攻击防护行为
	}
	
	var icmpalert = $('#icmpalert').textbox('getValue');
	var udpsalert = $('#udpsalert').textbox('getValue');
	var udpdalert = $('#udpdalert').textbox('getValue');
	var arpipnumofmac = $('#arpipnumofmac').textbox('getValue');
	var arppsendrate = $('#arppsendrate').textbox('getValue');
	var arpreverseq = 0;
	if($("#arpreverseq").prop("checked")){
		arpreverseq = 1;
	}
	var ipscanningalert = $('#ipscanningalert').textbox('getValue');
	var portscanningalert = $('#portscanningalert').textbox('getValue');
	var synsalert = $('#synsalert').textbox('getValue');
	var syndalert = $('#syndalert').textbox('getValue');
	var syndalerttype = $('#syndalerttype').combobox('getValue');
	var syndalertdatype = "";
	var syndalertdavalue = "";
	var icmpbpalert = $('#icmpbpalert').textbox('getValue');
	var synagentminrate = $('#synagentminrate').textbox('getValue');
	var synagentmaxrate = $('#synagentmaxrate').textbox('getValue');
	var syntimeout = $('#syntimeout').textbox('getValue');
	var syncookie = 0;
	if($("#syncookie").prop("checked")){
		syncookie = 1;
	}
	var dnssalert = $('#dnssalert').textbox('getValue');
	var dnsdalert = $('#dnsdalert').textbox('getValue');
	var dnsrsalert = $('#dnsrsalert').textbox('getValue');
	var dnsrdalert = $('#dnsrdalert').textbox('getValue');
	
	$('#arpCreateForm').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/saveArpDomain.do",    
	    onSubmit: function(param){ 
	     	param.securityid = $("#tabs_security_id").val(); 
	    	param.serviceid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val();
	        param.domainid = domainid;  
	        param.alluser = alluser;
	        param.allaction = allaction;
	        param.icmp = icmp; 
	        param.icmpalert = icmpalert;    
	        param.icmpaction = icmpaction;
	        param.udp = udp;    
	        param.udpsalert = udpsalert; 
	        param.udpdalert = udpdalert;    
	        param.udpaction = udpaction;
	        param.arp = arp;    
	        param.arpaction = arpaction; 
	        param.arpipnumofmac = arpipnumofmac;    
	        param.arppsendrate = arppsendrate;
	        param.arpreverseq = arpreverseq;    
	        param.syn = syn; 
	        param.synsalert = synsalert;    
	        param.synaction = synaction;
	        param.syndalert = syndalert;    
	        param.syndalerttype = syndalerttype; 
	        param.syndalertdatype = syndalertdatype;    
	        param.syndalertdavalue = syndalertdavalue;
	        param.winnuke = winnuke; 
	        param.ipcheat = ipcheat;    
	        param.ipscanning = ipscanning;
	        param.ipscanningalert = ipscanningalert;    
	        param.ipscanningaction = ipscanningaction; 
	        param.portscanning = portscanning;    
	        param.portscanningalert = portscanningalert;
	        param.portscanningaction = portscanningaction;    
	        param.pingofdeath = pingofdeath; 
	        param.treadrop = treadrop;    
	        param.ipshard = ipshard;
	        param.ipshardaction = ipshardaction; 
	        param.ipoption = ipoption;    
	        param.ipoptionaction = ipoptionaction;
	        param.sf = sf;    
	        param.sfaction = sfaction; 
	        param.land = land;    
	        param.landaction = landaction;
	        param.icmpbp = icmpbp;    
	        param.icmpbpalert = icmpbpalert; 
	        param.icmpbpaction = icmpbpaction;    
	        param.synagent = synagent;
	        param.synagentminrate = synagentminrate;    
	        param.synagentmaxrate = synagentmaxrate; 
	        param.syncookie = syncookie;    
	        param.syntimeout = syntimeout;
	        param.tcp = tcp;    
	        param.tcpaction = tcpaction; 
	        param.dns = dns;    
	        param.dnssalert = dnssalert;
	        param.dnsdalert = dnsdalert;    
	        param.dnsaction = dnsaction;
	        param.dnsr = dnsr;    
	        param.dnsrsalert = dnsrsalert; 
	        param.dnsrdalert = dnsrdalert;    
	        param.dnsraction = dnsraction;
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){    
	        	loadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
			$('#arpw').window('close');
	    }    

	});  
}
//单记录编辑保存信息
function editdomainarp(){
	var domainid = $('#domainid1').val();//安全域
	
	var alluser = 0;//全部启用
	var icmp = 0;//ICMP洪水攻击防护
	var udp = 0;//UDP洪水攻击防护
	var arp = 0;//ARP欺骗攻击防护
	var syn = 0;//SYN洪水攻击防护
	var ipscanning = 0;//IP地址扫描攻击防护
	var portscanning = 0;//端口扫描防护
	var ipshard = 0;//IP分片防护
	var ipoption = 0;//IP选项
	var sf = 0;//Smurf或者Fraggle攻击防护
	var land = 0;//Land攻击防护
	var icmpbp = 0;//ICMP大包攻击防护
	var tcp = 0;//TCP异常
	var dns = 0;//DNS查询洪水防护
	var dnsr = 0;//DNS递归查询洪水攻击防护
	var winnuke = 0;//winnuke攻击防护
	var ipcheat = 0;//ip地址欺骗攻击防护
	var pingofdeath = 0;//pingofdeath攻击防护
	var treadrop = 0;//Treadrop攻击防护
	var synagent = 0;//syn代理
	if($("#alluser1").prop("checked")){
		alluser = 1;
		icmp = 1;
		udp = 1;
		arp = 1;
		syn = 1;
		ipscanning = 1;
		portscanning = 1;
		ipshard = 1;
		ipoption = 1;
		sf = 1;
		land = 1;
		icmpbp = 1;
		tcp = 1;
		dns = 1;
		dnsr = 1;
		winnuke = 1;
		ipcheat = 1;
		pingofdeath = 1;
		treadrop = 1;
		synagent = 1;
	}else{
		if($("#icmp1").prop("checked")){
			icmp = 1;
		}
		if($("#udp1").prop("checked")){
			udp = 1;
		}
		if($("#arp1").prop("checked")){
			arp = 1;
		}
		if($("#syn1").prop("checked")){
			syn = 1;
		}
		if($("#ipscanning1").prop("checked")){
			ipscanning = 1;
		}
		if($("#portscanning1").prop("checked")){
			portscanning = 1;
		}
		if($("#ipshard1").prop("checked")){
			ipshard = 1;
		}
		if($("#ipoption1").prop("checked")){
			ipoption = 1;
		}
		if($("#sf1").prop("checked")){
			sf = 1;
		}
		if($("#land1").prop("checked")){
			land = 1;
		}
		if($("#icmpbp1").prop("checked")){
			icmpbp = 1;
		}
		if($("#tcp1").prop("checked")){
			tcp = 1;
		}
		if($("#dns1").prop("checked")){
			dns = 1;
		}
		if($("#dnsr1").prop("checked")){
			dnsr = 1;
		}
		if($("#winnuke1").prop("checked")){
			winnuke = 1;
		}
		if($("#ipcheat1").prop("checked")){
			ipcheat = 1;
		}
		if($("#pingofdeath1").prop("checked")){
			pingofdeath = 1;
		}
		if($("#treadrop1").prop("checked")){
			treadrop = 1;
		}
		if($("#synagent1").prop("checked")){
			synagent = 1;
		}
	}
	
	var allaction = $('#allaction1').combobox('getValue');//全部行为
	if(null != allaction && "" != allaction){
		var icmpaction = allaction, udpaction = allaction, arpaction = allaction;
		var synaction = allaction, ipscanningaction = allaction;
		var portscanningaction = allaction, ipshardaction = allaction, ipoptionaction = allaction;
		var sfaction = allaction, landaction = allaction, icmpbpaction = allaction;
		var tcpaction = allaction, dnsaction = allaction, dnsraction = allaction;
	}else{
		var icmpaction = $('#_r0').combobox('getValue');//ICMP洪水攻击防护行为
		var udpaction = $('#_r1').combobox('getValue');//UDP洪水攻击防护行为
		var arpaction = $('#_r2').combobox('getValue');//ARP欺骗攻击防护行为
		var synaction = $('#_r3').combobox('getValue');//SYN洪水攻击防护行为
		var ipscanningaction = $('#_r4').combobox('getValue');//IP地址扫描攻击防护行为
		var portscanningaction = $('#_r5').combobox('getValue');//端口扫描防护行为
		var ipshardaction = $('#_r6').combobox('getValue');//IP分片防护行为
		var ipoptionaction = $('#_r7').combobox('getValue');//IP选项行为
		var sfaction = $('#_r8').combobox('getValue');//Smurf或者Fraggle攻击防护行为
		var landaction = $('#_r9').combobox('getValue');//Land攻击防护行为
		var icmpbpaction = $('#_r10').combobox('getValue');//ICMP大包攻击防护行为
		var tcpaction = $('#_r11').combobox('getValue');//TCP异常行为
		var dnsaction = $('#_r12').combobox('getValue');//DNS查询洪水防护行为
		var dnsraction = $('#_r13').combobox('getValue');//DNS递归查询洪水攻击防护行为
	}
	
	var icmpalert = $('#icmpalert1').textbox('getValue');
	var udpsalert = $('#udpsalert1').textbox('getValue');
	var udpdalert = $('#udpdalert1').textbox('getValue');
	var arpipnumofmac = $('#arpipnumofmac1').textbox('getValue');
	var arppsendrate = $('#arppsendrate1').textbox('getValue');
	var arpreverseq = 0;
	if($("#arpreverseq1").prop("checked")){
		arpreverseq = 1;
	}
	var ipscanningalert = $('#ipscanningalert1').textbox('getValue');
	var portscanningalert = $('#portscanningalert1').textbox('getValue');
	var synsalert = $('#synsalert1').textbox('getValue');
	var syndalert = $('#syndalert1').textbox('getValue');
	var syndalerttype = $('#syndalerttype1').combobox('getValue');
	var syndalertdatype = "";
	var syndalertdavalue = "";
	var icmpbpalert = $('#icmpbpalert1').textbox('getValue');
	var synagentminrate = $('#synagentminrate1').textbox('getValue');
	var synagentmaxrate = $('#synagentmaxrate1').textbox('getValue');
	var syntimeout = $('#syntimeout1').textbox('getValue');
	var syncookie = 0;
	if($("#syncookie1").prop("checked")){
		syncookie = 1;
	}
	var dnssalert = $('#dnssalert1').textbox('getValue');
	var dnsdalert = $('#dnsdalert1').textbox('getValue');
	var dnsrsalert = $('#dnsrsalert1').textbox('getValue');
	var dnsrdalert = $('#dnsrdalert1').textbox('getValue');
	
	$('#arpCreateForm1').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/arpUpdate.do",    
	    onSubmit: function(param){ 
	     	param.securityid = $("#tabs_security_id").val(); 
	    	param.serviceid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val();
	        param.domainid = domainid;  
	        param.alluser = alluser;
	        param.allaction = allaction;
	        param.icmp = icmp; 
	        param.icmpalert = icmpalert;    
	        param.icmpaction = icmpaction;
	        param.udp = udp;    
	        param.udpsalert = udpsalert; 
	        param.udpdalert = udpdalert;    
	        param.udpaction = udpaction;
	        param.arp = arp;    
	        param.arpaction = arpaction; 
	        param.arpipnumofmac = arpipnumofmac;    
	        param.arppsendrate = arppsendrate;
	        param.arpreverseq = arpreverseq;    
	        param.syn = syn; 
	        param.synsalert = synsalert;    
	        param.synaction = synaction;
	        param.syndalert = syndalert;    
	        param.syndalerttype = syndalerttype; 
	        param.syndalertdatype = syndalertdatype;    
	        param.syndalertdavalue = syndalertdavalue;
	        param.winnuke = winnuke; 
	        param.ipcheat = ipcheat;    
	        param.ipscanning = ipscanning;
	        param.ipscanningalert = ipscanningalert;    
	        param.ipscanningaction = ipscanningaction; 
	        param.portscanning = portscanning;    
	        param.portscanningalert = portscanningalert;
	        param.portscanningaction = portscanningaction;    
	        param.pingofdeath = pingofdeath; 
	        param.treadrop = treadrop;    
	        param.ipshard = ipshard;
	        param.ipshardaction = ipshardaction; 
	        param.ipoption = ipoption;    
	        param.ipoptionaction = ipoptionaction;
	        param.sf = sf;    
	        param.sfaction = sfaction; 
	        param.land = land;    
	        param.landaction = landaction;
	        param.icmpbp = icmpbp;    
	        param.icmpbpalert = icmpbpalert; 
	        param.icmpbpaction = icmpbpaction;    
	        param.synagent = synagent;
	        param.synagentminrate = synagentminrate;    
	        param.synagentmaxrate = synagentmaxrate; 
	        param.syncookie = syncookie;    
	        param.syntimeout = syntimeout;
	        param.tcp = tcp;    
	        param.tcpaction = tcpaction; 
	        param.dns = dns;    
	        param.dnssalert = dnssalert;
	        param.dnsdalert = dnsdalert;    
	        param.dnsaction = dnsaction;
	        param.dnsr = dnsr;    
	        param.dnsrsalert = dnsrsalert; 
	        param.dnsrdalert = dnsrdalert;    
	        param.dnsraction = dnsraction;
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){    
	        	loadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
			$('#arpw1').window('close');
	    }    

	});  
}
</script>
<form id="manForm"></form>
<div data-options="region:'center',border:false">
	<table title="" style="width:100%;"  id="arp_grid">
		<thead>
			<tr>
				<th data-options="field:'domainname',width:10,align:'center'">防护安全域</th>
				<th data-options="field:'usestat',width:10,align:'center'">攻击防护状态</th>
				<th data-options="field:'etime',width:10,align:'center'">修改时间</th>
				<th data-options="field:'ctime',width:10,align:'center'">创建时间</th>
				<th data-options="field:'domainid',width:10,align:'center',formatter:fwoptionformater">操作</th>
			</tr>
		</thead>
	</table>
</div>  
<div id="arpw" class="easyui-window" title="新增防护配置" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save'" style="width:1000px;height:350px;padding:5px;top:127px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="arpCreateForm" method="post" data-options="novalidate:true">
				<h2>选择安全域</h2>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">安全域：
						<input type="hidden" id="domainid"/>
						<select id="domain" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto',editable:false">
							<option value="">请选择</option>
							<option value="trust">trust</option>
						</select>
					</p>
				</div>
				<h2>白名单</h2>
				<div style="margin-bottom:5px;">
					<a class="easyui-linkbutton" style="margin-left:30px;" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="">配置</a>
				</div>
				<h2>全选</h2>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">全部启用&nbsp;<input type="checkbox" id="alluser"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="allaction" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="">--</option>
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<h2>Flood防护</h2>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">ICMP洪水攻击防护&nbsp;<input type="checkbox" id="icmp" name="chk"/></p>
					<p style="float:left;margin-left:30px;">警戒值：<input id="icmpalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-50,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r0" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">UDP洪水攻击防护&nbsp;<input type="checkbox" id="udp" name="chk"/></p>
					<p style="float:left;margin-left:30px;">源警戒值：<input id="udpsalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>
					<p style="float:left;margin-left:30px;">目的警戒值：<input id="udpdalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r1" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">ARP欺骗攻击防护&nbsp;<input type="checkbox" id="arp" name="chk"/></p>
					<p style="float:left;margin-left:30px;">每个MAC最大IP数：<input id="arpipnumofmac" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-1,024)</p>
					<p style="float:left;margin-left:30px;">免费ARP包发送速率：<input id="arppsendrate" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-10)</p>
					<p style="float:left;margin-left:30px;">反向查询&nbsp;<input type="checkbox" id="arpreverseq"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r2" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">SYN洪水攻击防护&nbsp;<input type="checkbox" id="syn" name="chk"/></p>
					<p style="float:left;margin-left:30px;">源警戒值：<input id="synsalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-50,000)</p>
					<p style="float:left;margin-left:30px;">目的警戒值：
						<select id="syndalerttype" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="1">基于IP</option>
							<option value="2">基于端口</option>
						</select>
						<input id="syndalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-50,000)
					</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r3" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<h2>MS-Windows防护</h2>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">WinNuke攻击防护&nbsp;<input type="checkbox" id="winnuke" name="chk"/></p>
				</div>
				<h2>扫描/欺骗防护</h2>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">IP地址欺骗攻击防护&nbsp;<input type="checkbox" id="ipcheat" name="chk"/></p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">IP地址扫描攻击防护&nbsp;<input type="checkbox" id="ipscanning" name="chk"/></p>
					<p style="float:left;margin-left:30px;">警戒值：<input id="ipscanningalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-5,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r4" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">端口扫描防护&nbsp;<input type="checkbox" id="portscanning" name="chk"/></p>
					<p style="float:left;margin-left:30px;">警戒值：<input id="portscanningalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-5,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r5" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<h2>拒绝服务防护</h2>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">Ping of Death攻击防护&nbsp;<input type="checkbox" id="pingofdeath" name="chk"/></p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">Teardrop攻击防护&nbsp;<input type="checkbox" id="treadrop" name="chk"/></p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">IP分片防护&nbsp;<input type="checkbox" id="ipshard" name="chk"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r6" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">IP选项&nbsp;<input type="checkbox" id="ipoption" name="chk"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r7" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">Smurf或者Fraggle攻击防护&nbsp;<input type="checkbox" id="sf" name="chk"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r8" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">Land攻击防护&nbsp;<input type="checkbox" id="land" name="chk"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r9" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">ICMP大包攻击防护&nbsp;<input type="checkbox" id="icmpbp" name="chk"/></p>
					<p style="float:left;margin-left:30px;">源警戒值：<input id="icmpbpalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-50,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r10" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<h2>代理</h2>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">SYN代理&nbsp;<input type="checkbox" id="synagent" name="chk"/></p>
					<p style="float:left;margin-left:30px;">最小代理速率：<input id="synagentminrate" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-50,000)</p>
					<p style="float:left;margin-left:30px;">最大代理速率：<input id="synagentmaxrate" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-1,500,000)</p>
					<p style="float:left;margin-left:30px;">代理超时：<input id="syntimeout" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-180)秒</p>
					<p>&nbsp;&nbsp;&nbsp;cookie&nbsp;<input type="checkbox" id="syncookie"/></p>
				</div>
				<h2>协议异常报告</h2>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">TCP异常&nbsp;<input type="checkbox" id="tcp" name="chk"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r11" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<h2>DNS查询洪水防护</h2>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">DNS查询洪水防护&nbsp;<input type="checkbox" id="dns" name="chk"/></p>
					<p style="float:left;margin-left:30px;">源警戒值：<input id="dnssalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>
					<p style="float:left;margin-left:30px;">目的警戒值：<input id="dnsdalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r12" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">DNS递归查询洪水攻击防护&nbsp;<input type="checkbox" id="dnsr" name="chk"/></p>
					<p style="float:left;margin-left:30px;">源警戒值：<input id="dnsrsalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>
					<p style="float:left;margin-left:30px;">目的警戒值：<input id="dnsrdalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="r13" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="adddomainarp();" id="addarp" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#arpw').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
<div id="arpw1" class="easyui-window" title="修改防护配置" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save'" style="width:1000px;height:350px;padding:5px;top:127px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="arpCreateForm1" method="post" data-options="novalidate:true">
				<h2>选择安全域</h2>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">安全域：
						<input type="hidden" id="domainid1"/>
						<select id="domain1" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto',editable:false,disabled:true">
						</select>
					</p>
				</div>
				<h2>白名单</h2>
				<div style="margin-bottom:5px;">
					<a class="easyui-linkbutton" style="margin-left:30px;" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="">配置</a>
				</div>
				<h2>全选</h2>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">全部启用&nbsp;<input type="checkbox" id="alluser1"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="allaction1" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="">--</option>
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<h2>Flood防护</h2>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">ICMP洪水攻击防护&nbsp;<input type="checkbox" id="icmp1" name="chk1"/></p>
					<p style="float:left;margin-left:30px;">警戒值：<input id="icmpalert1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-50,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r0" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">UDP洪水攻击防护&nbsp;<input type="checkbox" id="udp1" name="chk1"/></p>
					<p style="float:left;margin-left:30px;">源警戒值：<input id="udpsalert1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>
					<p style="float:left;margin-left:30px;">目的警戒值：<input id="udpdalert1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r1" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">ARP欺骗攻击防护&nbsp;<input type="checkbox" id="arp1" name="chk1"/></p>
					<p style="float:left;margin-left:30px;">每个MAC最大IP数：<input id="arpipnumofmac1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-1,024)</p>
					<p style="float:left;margin-left:30px;">免费ARP包发送速率：<input id="arppsendrate1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-10)</p>
					<p style="float:left;margin-left:30px;">反向查询&nbsp;<input type="checkbox" id="arpreverseq1"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r2" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">SYN洪水攻击防护&nbsp;<input type="checkbox" id="syn1" name="chk1"/></p>
					<p style="float:left;margin-left:30px;">源警戒值：<input id="synsalert1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-50,000)</p>
					<p style="float:left;margin-left:30px;">目的警戒值：
						<select id="syndalerttype1" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="1">基于IP</option>
							<option value="2">基于端口</option>
						</select>
						<input id="syndalert1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-50,000)
					</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r3" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<h2>MS-Windows防护</h2>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">WinNuke攻击防护&nbsp;<input type="checkbox" id="winnuke1" name="chk1"/></p>
				</div>
				<h2>扫描/欺骗防护</h2>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">IP地址欺骗攻击防护&nbsp;<input type="checkbox" id="ipcheat1" name="chk1"/></p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">IP地址扫描攻击防护&nbsp;<input type="checkbox" id="ipscanning1" name="chk1"/></p>
					<p style="float:left;margin-left:30px;">警戒值：<input id="ipscanningalert1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-5,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r4" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">端口扫描防护&nbsp;<input type="checkbox" id="portscanning1" name="chk1"/></p>
					<p style="float:left;margin-left:30px;">警戒值：<input id="portscanningalert1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-5,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r5" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<h2>拒绝服务防护</h2>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">Ping of Death攻击防护&nbsp;<input type="checkbox" id="pingofdeath1" name="chk1"/></p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="margin-left:30px;">Teardrop攻击防护&nbsp;<input type="checkbox" id="treadrop1" name="chk1"/></p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">IP分片防护&nbsp;<input type="checkbox" id="ipshard1" name="chk1"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r6" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">IP选项&nbsp;<input type="checkbox" id="ipoption1" name="chk1"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r7" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">Smurf或者Fraggle攻击防护&nbsp;<input type="checkbox" id="sf1" name="chk1"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r8" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">Land攻击防护&nbsp;<input type="checkbox" id="land1" name="chk1"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r9" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">ICMP大包攻击防护&nbsp;<input type="checkbox" id="icmpbp1" name="chk1"/></p>
					<p style="float:left;margin-left:30px;">源警戒值：<input id="icmpbpalert1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-50,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r10" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<h2>代理</h2>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">SYN代理&nbsp;<input type="checkbox" id="synagent1" name="chk1"/></p>
					<p style="float:left;margin-left:30px;">最小代理速率：<input id="synagentminrate1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-50,000)</p>
					<p style="float:left;margin-left:30px;">最大代理速率：<input id="synagentmaxrate1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-1,500,000)</p>
					<p style="float:left;margin-left:30px;">代理超时：<input id="syntimeout1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-180)秒</p>
					<p>&nbsp;&nbsp;&nbsp;cookie&nbsp;<input type="checkbox" id="syncookie1"/></p>
				</div>
				<h2>协议异常报告</h2>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">TCP异常&nbsp;<input type="checkbox" id="tcp1" name="chk1"/></p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r11" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<h2>DNS查询洪水防护</h2>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">DNS查询洪水防护&nbsp;<input type="checkbox" id="dns1" name="chk1"/></p>
					<p style="float:left;margin-left:30px;">源警戒值：<input id="dnssalert1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>
					<p style="float:left;margin-left:30px;">目的警戒值：<input id="dnsdalert1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r12" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
				<div style="margin-bottom:5px;">
					<p style="float:left;margin-left:30px;">DNS递归查询洪水攻击防护&nbsp;<input type="checkbox" id="dnsr1" name="chk1"/></p>
					<p style="float:left;margin-left:30px;">源警戒值：<input id="dnsrsalert1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>
					<p style="float:left;margin-left:30px;">目的警戒值：<input id="dnsrdalert1" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：
						<select id="_r13" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
							<option value="0">丢弃</option>
							<option value="1">告警</option>
						</select>
					</p>
				</div>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="editdomainarp();" id="addarp" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#arpw1').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
</body>

