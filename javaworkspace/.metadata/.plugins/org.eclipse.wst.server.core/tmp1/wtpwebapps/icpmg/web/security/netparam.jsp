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
$(document).ready(function() {
	netparam_loadDataGrid();
	
	$('.make-gray').find("input,select").attr({
        disabled: 'disabled'
    });
});




//数据加载
function netparam_loadDataGrid(){
	$('#netparamCreateForm').form('submit', {    
	    url: "${pageContext.request.contextPath}/security/queryNetparam.do",    
	    onSubmit: function(param){    
	        param.securityid = $("#tabs_security_id").val();  
	    },  
		success: function(retr){ 
			var data = $.parseJSON(retr); 
	        if (data.success){   
	        	$('#netparamCreateForm').form('clear');//清空页面
	        	setdata(data.obj);//各标签赋值
	        } 
	    }    
	});  
}
//页面填充数据
function setdata(obj){
	$('#ipmaxshard').textbox('setValue', obj.ipmaxshard).textbox('setText', obj.ipmaxshard);
	$('#iptimeout').textbox('setValue', obj.iptimeout).textbox('setText', obj.iptimeout);
	
	if(obj.ipltsession == '1'){
		 $("#ipltsession").parents('tr').removeClass('make-gray');
	     $("#ipltsession").parents('tr').find("input,select").removeAttr('disabled');
	     
    	 $('#lspercetage').textbox('setValue', obj.lspercetage).textbox('setText', obj.lspercetage);
	}else{
		$("#ipltsession").parents('tr').addClass('make-gray');
        $("#ipltsession").parents('tr').find("input,select").attr({
            disabled: 'disabled'
        });
        $("#ipltsession").removeClass('active');
        
    	$('#lspercetage').textbox('setValue', '').textbox('setText', '');
	}
	
	if(obj.tcpmss == '1'){
		$("#tcpmss").parents('tr').removeClass('make-gray');
		$("#tcpmss").addClass('active');
	    $("#tcpmss").parents('tr').find("input,select").removeAttr('disabled');
	    
    	$('#tcpmaxmss').textbox('setValue', obj.tcpmaxmss).textbox('setText', obj.tcpmaxmss);
	}else{
		$("#tcpmss").parents('tr').addClass('make-gray');
        $("#tcpmss").parents('tr').find("input,select").attr({
            disabled: 'disabled'
        });
        $("#tcpmss").removeClass('active');
        
    	//$('#tcpmaxmss').textbox('setValue', '').textbox('setText', '');
	}
	
	if(obj.tcpmssvpn == '1'){
		$("#tcpmssvpn").parents('tr').removeClass('make-gray');
		$("#tcpmssvpn").addClass('active');
	    $("#tcpmssvpn").parents('tr').find("input,select").removeAttr('disabled');
    	
    	$('#tcpmssvpnmax').textbox('setValue', obj.tcpmssvpnmax).textbox('setText', obj.tcpmssvpnmax);
	}else{
		$("#tcpmssvpn").parents('tr').addClass('make-gray');
        $("#tcpmssvpn").parents('tr').find("input,select").attr({
            disabled: 'disabled'
        });
        $("#tcpmssvpn").removeClass('active');
		
    	//$('#tcpmssvpnmax').textbox('setValue', '').textbox('setText', '');
	}
	
	if(obj.tcppnumcheck == '1'){
		$("#tcppnumcheck").parents('tr').removeClass('make-gray');
		$("#tcppnumcheck").addClass('active');
	    $("#tcppnumcheck").parents('tr').find("input,select").removeAttr('disabled');
	}else{
		$("#tcppnumcheck").parents('tr').addClass('make-gray');
        $("#tcppnumcheck").parents('tr').find("input,select").attr({
            disabled: 'disabled'
        });
        $("#tcppnumcheck").removeClass('active');
	}
	
	if(obj.tcphandshake == '1'){
		$("#tcphandshake").parents('tr').removeClass('make-gray');
		$("#tcphandshake").addClass('active');
	    $("#tcphandshake").parents('tr').find("input,select").removeAttr('disabled');
	    
    	$('#tshtimeout').textbox('setValue', obj.tshtimeout).textbox('setText', obj.tshtimeout);
	}else{
		$("#tcphandshake").parents('tr').addClass('make-gray');
        $("#tcphandshake").parents('tr').find("input,select").attr({
            disabled: 'disabled'
        });
        $("#tcphandshake").removeClass('active');
        
    	//$('#tshtimeout').textbox('setValue', '').textbox('setText', '');
	}
	
	if(obj.tcpsyncheck == '1'){
		$("#tcpsyncheck").parents('tr').removeClass('make-gray');
		$("#tcpsyncheck").addClass('active');
	    $("#tcpsyncheck").parents('tr').find("input,select").removeAttr('disabled');
	}else{
		$("#tcpsyncheck").parents('tr').addClass('make-gray');
        $("#tcpsyncheck").parents('tr').find("input,select").attr({
            disabled: 'disabled'
        });
        $("#tcpsyncheck").removeClass('active');
	}
	
	$('.j-toggle li').click(function(event) {
	    $(this).addClass('active').siblings().removeClass('active');
	});
	
	
	$('#other').find("li[value="+obj.other+"]").addClass('active').siblings().removeClass('active');
	$('#protectmode').find("li[value="+obj.protectmode+"]").addClass('active').siblings().removeClass('active');
	
}
//信息保存
function savenetparam(){
	
	var ipmaxshard = $('#ipmaxshard').textbox('getValue');
	if(null == ipmaxshard || "" == ipmaxshard || ipmaxshard>1024 || ipmaxshard<1){
		$.messager.alert('提示信息','最大分片数填写范围1-1024！', 'info');
		return;
	}
	
	var iptimeout = $('#iptimeout').textbox('getValue');
	if(null == iptimeout || "" == iptimeout || iptimeout>60 || iptimeout<1){
		$.messager.alert('提示信息','超时填写范围1-60秒！', 'info');
		return;
	}
	
	var ipltsession = 0;
	var lspercetage = null;
	var ipltsession_flag = $("#ipltsession").hasClass("active");
	if(ipltsession_flag){ 
		ipltsession = 1;
		lspercetage = $('#lspercetage').textbox('getValue');
		if(null == lspercetage || "" == lspercetage || lspercetage>100 || lspercetage<1){
			$.messager.alert('提示信息','长效会话百分比填写范围1-100！', 'info');
			return;
		}
	}
	
	var tcpmss = 0;
	var tcpmaxmss = null;
	var tcpmss_flag = $("#tcpmss").hasClass("active");
	if(tcpmss_flag){
		tcpmss = 1;
		tcpmaxmss = $('#tcpmaxmss').textbox('getValue');
		if(null == tcpmaxmss || "" == tcpmaxmss || tcpmaxmss>65535 || tcpmaxmss<64){
			$.messager.alert('提示信息','MSS 最大值填写范围64-65535！', 'info');
			return;
		}
	}
	
	var tcpmssvpn = 0;
	var tcpmssvpnmax = null;
	var tcpmssvpn_flag = $("#tcpmssvpn").hasClass("active");
	if(tcpmssvpn_flag){
		tcpmssvpn = 1;
		tcpmssvpnmax = $('#tcpmssvpnmax').textbox('getValue');
		if(null == tcpmssvpnmax || "" == tcpmssvpnmax || tcpmssvpnmax>65535 || tcpmssvpnmax<64){
			$.messager.alert('提示信息','MSS 最大值填写范围64-65535！', 'info');
			return;
		}
	}
	
	var tcppnumcheck = 0;
	var tcppnumcheck_flag = $("#tcppnumcheck").hasClass("active");
	if(tcppnumcheck_flag){
		tcppnumcheck = 1;
	}
	
	var tcphandshake = 0;
	var tshtimeout = null;
	var tcphandshake_flag = $("#tcphandshake").hasClass("active");
	if(tcphandshake_flag){
		tcphandshake = 1;
		tshtimeout = $('#tshtimeout').textbox('getValue');
		if(null == tshtimeout || "" == tshtimeout || tshtimeout>1800 || tshtimeout<1){
			$.messager.alert('提示信息','超时填写范围1-1800！', 'info');
			return;
		}
	}
	
	var tcpsyncheck = 0;
	var tcpsyncheck_flag = $("#tcpsyncheck").hasClass("active");
	if(tcpsyncheck_flag){
		tcpsyncheck = 1;
	}
	
	var other =$('#other').find("li[class='active']").val();
	var protectmode =$('#protectmode').find("li[class='active']").val();
	
	$('#netparamCreateForm').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/updateNetparam.do",    
	    onSubmit: function(param){  
	    	param.securityid = $("#tabs_security_id").val(); 
	    	param.serviceid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val(); 
	        param.ipmaxshard = ipmaxshard;    
	        param.iptimeout = iptimeout; 
	        param.ipltse = ipltsession;    
	        param.lspercetage = lspercetage;
	        param.tcpmss = tcpmss;    
	        param.tcpmaxmss = tcpmaxmss;
	        param.tcpmssvpn = tcpmssvpn;    
	        param.tcpmssvpnmax = tcpmssvpnmax;
	        param.tcppnumcheck = tcppnumcheck;
	        param.tcphandshake = tcphandshake;    
	        param.tshtimeout = tshtimeout;
	        param.tcpsyncheck = tcpsyncheck;    
	        param.other = other;
	        param.protectmode = protectmode;
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){    
	        	$.messager.alert('提示信息','保存成功！', 'info');   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }   
	    }    

	});  
}

$(function(){
//页面效果：隐现
	$('.j-wlcs').bind('click', function(event) {
	
	    $(this).toggleClass('active');
	    if ($(this).hasClass('active')) {
	        $(this).parents('tr').removeClass('make-gray');
	        $(this).parents('tr').find("input,select").removeAttr('disabled');
	
	    } else {
	        $(this).parents('tr').addClass('make-gray');
	        $(this).parents('tr').find("input,select").attr({
	            disabled: 'disabled'
	        });
	
	    }
	});
	$('.j-toggle li').click(function(event) {
	    $(this).addClass('active').siblings().removeClass('active');
	});
});
</script>
<div class="pop " style="padding: 0 70px; width: auto;">
	<form id="netparamCreateForm" method="post" data-options="novalidate:true">
	
        <div class="item2">
            <div class="item-title">IP分片</div>
            <table style="width:100%;border:0;" class="table-layout">
                <tr>
                    <td width="16%" align="right">
                                                                最大分片数：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td width="33%">
                        <input id="ipmaxshard" class="easyui-numberbox" style="width:120px;"  data-options="prompt:'1-1024'">
                    </td>
                </tr>
                <tr>
                    <td align="right">
                                                                   超时：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>
                        <input id="iptimeout" class="easyui-numberbox" style="width:120px;"  data-options="prompt:'1-60秒'">
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <a href="javascript:void(0)" id="ipltsession" style="width: 120px;" class="default-btn-demo2 j-wlcs active ">长效会话</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>
                                                                      长效会话百分比：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="lspercetage" class="easyui-numberbox" style="width:120px;" value="20">
                    </td>
                </tr>
            </table>
        </div>	
	
	
		<div class="item2">
            <div class="item-title">TCP</div>
            <table style="width:100%;border:0;" class="table-layout">
                <tr class="">
                    <td align="right" width="16%">
                        <a href="javascript:void(0)" id="tcpmss" style="width: 120px;" class="default-btn-demo2 j-wlcs  ">TCP MSS</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td width="33%">
                        MSS 最大值：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="tcpmaxmss" class="easyui-numberbox" style="width:120px;" data-options="prompt:'64-65535'">
                    </td>
                </tr>
                <tr class="">
                    <td align="right">
                        <a href="javascript:void(0)" id="tcpmssvpn" style="width: 120px;" class="default-btn-demo2 j-wlcs  ">TCP MSS VPN</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>
                        MSS 最大值：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="tcpmssvpnmax" class="easyui-numberbox" style="width:120px;"  data-options="prompt:'64-65535'">
                    </td>
                </tr>
                <tr class="make-gray">
                    <td align="right">
                        <a href="javascript:void(0)" id="tcppnumcheck" style="width: 120px;" class="default-btn-demo2 j-wlcs  ">TCP包序列号检查</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>
                    </td>
                </tr>
                <tr class="">
                    <td align="right">
                        <a href="javascript:void(0)" id="tcphandshake" style="width: 120px;" class="default-btn-demo2 j-wlcs  ">TCP三次握手</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;超时：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="tshtimeout" class="easyui-numberbox" style="width:120px;" data-options="prompt:'1-1800秒'">
                    </td>
                </tr>
                <tr class="make-gray">
                    <td align="right">
                        <a href="javascript:void(0)" id="tcpsyncheck" style="width: 120px;" class="default-btn-demo2 j-wlcs  ">TCP SYN包检查</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </div>
		
        <div class="item2">
            <div class="item-title">其他</div>
            <table style="width:100%;border:0;" class="table-layout">
                <tr>
                    <td width="16%" align="right">
                                                            非IP包且非ARP包：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td width="33%">
                        <ul class="item-ul j-toggle" id="other">
                            <li class="active"  value="1" style="padding:0 21px; width: 90px;">丢弃</li>
                            <li style="padding:0 21px;width: 90px;" value="2" class="">转发</li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                                                              防护模式：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>
                        <ul class="item-ul j-toggle" id="protectmode">
                            <li class="active"  value="0" style="padding:0 21px; width: 90px;">记录日志且重置</li>
                            <li style="padding:0 21px;  width: 90px;"  value="1" class=""> 只记录日志</li>
                        </ul>
                    </td>
                </tr>
            </table>
        </div>

		<p style=" text-align: center; margin:10px 0 30px;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="savenetparam();" style="width:80px">提交</a>
		    <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="netparam_loadDataGrid();" style="width:80px">取消</a>
	    </p>
	</form>
</div>

</body>

