<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<style type="text/css">
  
  .networkConfig{
    margin-top: 13px;
    padding-left: 190px;
  }
  .networkConfig-left{
    float: left;
    width: 20%;
    height: 100%;
     
    background-color: #eee;
  }
  .networkConfig-left p{
    width:60px;
    text-align:right;
    line-height: 20px;
    margin-left:92px;
    margin-top:20px; 
    font-size: 14px;
  }
  
  .networkConfig-right{
    height: 100%;
   
  }
  .createInstances_flow{
   width: 100%;
   height:72px;
   overflow: hidden;
   padding: 0;
   margin: 0;
  }
</style>

<script type="text/javascript" 
    src="${pageContext.request.contextPath}/js/validate.js"></script>
<body>

<div id="securityServiceOpen_networkConfig" class="easyui-window" title="安全服务开通-网络配置"
		data-options="iconCls:'icon-add',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false"
		style="width:814px;height:580px;">
   <div class="createInstances_flow">   
	 <img alt="step2" src="${pageContext.request.contextPath}/images/safe_flow_02.png" >
   </div>
	 		<form id="securityNetworkConfigForm" method="post">
	 <div id="networkConfig-wrap" style="width: 100%; height: 435px;overflow: hidden;">
	 
	   <div class="networkConfig-left">
	      
	       
	        <p>管理网络</p>
	        <!-- <p id="madr">管理IP</p> -->
	         <p style="margin-top: 48px"></p>
	        
	        <p>业务网络</p>
	       <!--  <p id="fadr">业务IP</p> -->
	          <p style="margin-top: 48px"></p>
	       
	        <p>外连网络</p>
	       <!--  <p id="cadr">外连IP</p> -->
	      
	   </div>
	   <div class="networkConfig-right">
	       <!-- 管理网络 -->

	       <div class="instancesnetwork networkConfig">
	            <input class="easyui-combobox" data-options="editable:false, panelHeight:'auto',required:true"   id="security_manVlanName" style="width: 340px;height: 30px; "  name="security_manVlanName">
		   
	       </div>
	       <!-- 
	       <div class="instancesip networkConfig">
               <input class="easyui-textbox" data-options="prompt:'IP',validType:'ip',missingMessage:'请输入正确的ip地址'"   id="security_manIp" style="width: 340px;height: 30px; "  name="security_manIp">
		      
           </div>
            -->
            <div style="border-bottom: 1px solid #eee;width: 68%;margin-left: 190px;margin-top: 18px"></div>
           
           <!-- 业务网络 -->
	       <div class="instancesnetwork networkConfig">
	            <input class="easyui-combobox" data-options="editable:false, panelHeight:'auto',required:true"   id="security_funVlanName" style="width: 340px;height: 30px; "  name="security_funVlanName">
		   
	       </div>
	       <!-- 
	       <div class="instancesip networkConfig">
               <input class="easyui-textbox" data-options="prompt:'IP',validType:'ip',missingMessage:'请输入正确的ip地址'"   id="security_funIp" style="width: 340px;height: 30px; "  name="security_funIp">
		      
           </div>
           -->
            <div style="border-bottom: 1px solid #eee;width: 68%;margin-left: 190px;margin-top: 18px"></div>
            <!-- 外连网络 -->
	       <div class="instancesnetwork networkConfig">
	            <input class="easyui-combobox" data-options="editable:false, panelHeight:'auto',required:true"   id="security_connVlanName" style="width: 340px;height: 30px; "  name="security_connVlanName">
		   
	       </div>
	       <!-- 
	       <div class="instancesip networkConfig">
               <input class="easyui-textbox" data-options="prompt:'IP',validType:'ip',missingMessage:'请输入正确的ip地址'"   id="security_connIp" style="width: 340px;height: 30px; "  name="security_connIp">
		      
           </div> 
            -->
           <input type="hidden" id="unitid"/> 
	   </div>
	</div>	
        </form>
<div style="background-color: #dce0e4;padding: 6px;text-align:center;">
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" onclick="toLastConfig()">上一步</a>&nbsp;&nbsp;&nbsp;&nbsp;
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-nextStep',plain:true,iconAlign:'right'" onclick="toSuccess()">创建</a>&nbsp;&nbsp;
</div>
</div>
</body>
</html>
<script type="text/javascript">
toLastConfig = function(){
    
    $('#securityServiceOpen_networkConfig').window('close');
    $('#securityServiceOpen_basicConfig').window('open');
}
toSuccess = function(){
	    
	     if(!$("#securityNetworkConfigForm").form('validate')){
	    	 return false;
	     }
	     //获取基础信息配置
	     var security_shopid=$("#security_shopid").children('li').filter('.on');
	     var security_funtypes=$("#security_funtypes").children('li').filter('.on');
	     
	     var id_security_shopid = security_shopid.eq(0).val();
	     var ids_security_funtypes = security_funtypes.map(function (index, element){
	    	    return $(this).val();
	    	}).get().join(",");
	     
	     var security_suserid = $("#security_suserid").combobox('getValue');
	     var security_suserid_name = $("#security_suserid").combobox('getText');
	     var security_displayname = $("#security_displayname").val();
	     
	     //获取网络信息配置
	     var security_manVlanId = $('#security_manVlanName').combobox('getValue');
	     var security_manVlanName = $('#security_manVlanName').combobox('getText');	     
	     var security_manVlanIdName = security_manVlanId + ";" + security_manVlanName;
	     
	     var security_funVlanId = $('#security_funVlanName').combobox('getValue');
	     var security_funVlanName = $('#security_funVlanName').combobox('getText'); 
	     var security_funVlanIdName = security_funVlanId + ";" +security_funVlanName;
	     
	     var security_connVlanId  = $('#security_connVlanName').combobox('getValue');
	     var security_connVlanName  = $('#security_connVlanName').combobox('getText');
	     var security_connVlanIdName  = security_connVlanId + ";" + security_connVlanName;
	     
	     //var security_manIp = $('#security_manIp').val();
	     //var security_funIp = $('#security_funIp').val();
	     //var security_connIp = $('#security_connIp').val();
		 var unitid =$('#unitid').val();
	     //先根据网络获取平台和资源池
	  	 var flag = true;
	     
		$.ajax({
   				  		type : 'post',
   				  	    dataType: 'json',
   				 	    url : '${pageContext.request.contextPath}/security/securityCreateNew.do',
   				  		data:{
   				  		id_security_shopid:id_security_shopid,
   				  		     id_security_shopid:id_security_shopid,
   				  		     ids_security_funtypes:ids_security_funtypes,
   				  		     security_suserid:security_suserid,
   				  			 security_displayname:security_displayname,
   				  		      security_manVlanIdName:security_manVlanIdName,
   				  		      security_funVlanIdName:security_funVlanIdName,
   				  		      security_connVlanIdName:security_connVlanIdName,
   				  		      //security_manIp:security_manIp,
   				  		      //security_funIp:security_funIp,
   				  		      //security_connIp:security_connIp,
   				  		      unitid:unitid,
   				  		      typeid:"InSecurity"
   				  			},
   				  		async:false,
   				  		success:function(retr){
   				  			
   				  			alert(retr.msg);
   				  			flag = retr.success;
   				  			
   				  		}	
   				  	});
	if(flag){
		//设置成功页面的详情
		var security_shopname = "基础";
		if(id_security_shopid == 10002){
			security_shopname = "高级";
		}
		
		var array_security_funtypes = ids_security_funtypes.split(",");
		var names_security_funtypes = "";
		for(var security_funtypes_idx = 0 ; security_funtypes_idx < array_security_funtypes.length; security_funtypes_idx ++){
			var current_security_funtype_id = array_security_funtypes[security_funtypes_idx];
			var current_security_funtype_name = "";
			if(current_security_funtype_id == 1){
				current_security_funtype_name = "防火墙";
			}else if(current_security_funtype_id == 2){
				current_security_funtype_name = "病毒过滤";
			}else if(current_security_funtype_id == 3){
				current_security_funtype_name = "入侵防御";
			}else if(current_security_funtype_id == 4){
				current_security_funtype_name = "Web应用防护";
			}
			
			if(security_funtypes_idx == 0){
				names_security_funtypes = current_security_funtype_name;
			}else{
				names_security_funtypes = names_security_funtypes + ";" + current_security_funtype_name;
			}
		}
		
		
		
		$("#security_detail_text_shopname").text(security_shopname);
		$("#security_detail_text_funtype").text(names_security_funtypes);
		$("#security_detail_text_suserid").text(security_suserid_name);
		$("#security_detail_text_displayname").text(security_displayname);
		$("#security_detail_text_manvlan").text(security_manVlanName);
		//$("#security_detail_text_manip").text(security_manIp);
		$("#security_detail_text_funvlan").text(security_funVlanName);
		//$("#security_detail_text_funip").text(security_funIp);
		$("#security_detail_text_connvlan").text(security_connVlanName);
		//$("#security_detail_text_connip").text(security_connIp);
		
		//刷新表格数据
		$('#fw_object_grid').datagrid('reload');
		$('#ips_object_grid').datagrid('reload');
		$('#waf_object_grid').datagrid('reload');
		
	    $('#securityServiceOpen_networkConfig').window('close');
	    $('#securityServiceOpen_success').window('open');
	}else{
		return;
	}
};
   function resetSecurityNetworkConfig(){
	   $("#security_manVlanName").combobox('clear');
	   //$("#security_manIp").textbox('clear');
	   $("#security_funVlanName").combobox('clear');
	   //$("#security_funIp").textbox('clear');
	   $("#security_connVlanName").combobox('clear');
	   //$("#security_connIp").textbox('clear');
   }

</script>