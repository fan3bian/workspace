<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<style type="text/css">
  .basicConfig_right{
    margin-left:175px;
    padding-left:20px;
    height: 100%;
  }
  .basicConfig_left{
     position: absolute;
     width: 10%;
     z-index: 1;
     float: left;
     width: 20%;
     height: 100%;
     
     background-color: #eee;
  }
  .basicConfig_left p{
     position: relative;
     padding-top:3px;
    /* top: 15px;*/
     width:60px;
    text-align:right;
    line-height: 26px;
    margin-left:92px;
    margin-top:30px; 
    font-size: 14px;
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
  
  
</style>

<body>

<div id="securityServiceOpen_basicConfigEW" class="easyui-window" title="云防火墙开通-基础配置"
		data-options="iconCls:'icon-add',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false"
		style="width:801px;height:477px;">
   <div class="createInstances_flow">  
   	   <img alt="step1" src="${pageContext.request.contextPath}/web/security/image/security_ew_flow_01.png" />
	</div>	
	<!-- 中部位置开始 -->
		<form id="securityServiceOpen_basicConfigEWForm" method="post">
	<div class="securityServiceOpen_basicConfig_wrap" style="width: 100%; height: 330px;">
	    <!--左边位置开始  -->
	  <div class="basicConfig_left" style="height: 70%;width: 20%;">
	        <p>名称</p>
	        <p>描述</p>
	        <p>数量</p>
	        <p>租户</p>
	  </div>
	 <!--右边位置开始  -->
	  <div class="basicConfig_right networkConfig-right">
 	    <div class="container-wrap" >
		  <div class="container">			
			<div style="float:left;width:885px;height: 340px/*padding-bottom:9999px;margin-bottom:-9999px;*/">
				<div class="container-cell">
					<div class="product-details">
						<div class="product-from-con">
						<div style=" ">
							<div class="product-from-row">
							 
								<div class="product-form-cell">
								     <input class="easyui-textbox" data-options="prompt:'名称(必填)',required:true,validType:'length[1,100]',missingMessage:'该输入项不允许为空，最多输入100个字符'"   id="security_displayname1" style="width: 340px;height: 30px; "  name="security_displayname1">
								</div>
								<div class="clear"></div>
						     </div>
						
							<div class="product-from-row">
							 
								<div class="product-form-cell">
								     <input class="easyui-textbox" data-options="prompt:'描述(必填)',required:true,validType:'length[1,100]',missingMessage:'该输入项不允许为空，最多输入100个字符'"   id="security_description1" style="width: 340px;height: 30px; "  name="security_description1">
								</div>
								<div class="clear"></div>
						     </div>
						     
						     <div class="product-from-row">
							 
								<div class="product-form-cell">
								     <input class="easyui-textbox" data-options="prompt:'数量(必填)',required:true,validType:'length[1,100]',missingMessage:'该输入项不允许为空，最多输入100个字符'"   id="security_num1" style="width: 340px;height: 30px; "  name="security_num1">
								</div>
								<div class="clear"></div>
						     </div>
						     
						   <div class="product-from-row">
							 
								<div class="product-form-cell">
								   <input class="easyui-combobox" data-options="editable:false,required:true"   id="security_suserid1" style="width: 340px;height: 30px; "  name="security_userunit1">
								</div>
								<div class="clear"></div>
						   </div>
						</div>
                     </div>
					</div>	
				</div>
			</div>		 
		</div>
	   </div>
	 <input type="hidden" id="unitid1"/>
	   
     </div><!-- 右边位置结束 -->
	</div>	<!-- 中部位置结束 -->
		</form>
	<!-- 底部 -->
		<div style="background-color: #dce0e4;padding: 6px;text-align:center; clear: both;">
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="javascript: $('#securityServiceOpen_basicConfigEW').window('close');">取消</a>&nbsp;&nbsp;&nbsp;&nbsp;
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-nextStep',iconAlign:'right',plain:true" onclick="toSuccessEW()">下一步</a>&nbsp;&nbsp;
		</div>
		
	</div>
</body>
</html>
<script type="text/javascript">
$(function(){
		$("#security_suserid1").combobox({
			url:'${pageContext.request.contextPath}/authMgr/queryUserBscinfo.do',    
		    valueField:'email',    
		    textField:'uname',
		    editable:false,
		    required:true,
		    panelHeight:'auto',
		    onSelect:function(record){
		    	$("#unitid1").val(record.unitid);
		    }
			});
		
});

toSuccessEW = function(){
  	    var flag = true;
        var security_suserid = $("#security_suserid1").combobox('getValue');
     	var security_suserid_name = $("#security_suserid1").combobox('getText');
     	var security_displayname = $("#security_displayname1").val();
     	var security_num = $("#security_num1").val();
     	var security_description = $("#security_description1").val();
     	var unitid =$("#unitid1").val();
		$.ajax({
	  		type : 'post',
	  	    dataType: 'json',
	 	    url : '${pageContext.request.contextPath}/security/securityEWCreateNew.do',
	  		data:{
	  		     security_suserid:security_suserid,
	  		     security_num:security_num,
	  			 security_displayname:security_displayname,
	  			 security_description:security_description,
  		         typeid:"InSecurity",
  		         unitid:unitid
	  			},
	  		async:false,
	  		success:function(retr){
	  			alert(retr.msg);
   				flag = retr.success;
	  		}	
	  	});
		if(flag){
			$("#security_detail_text_numEW").text(security_num);
			$("#security_detail_text_descriptionEW").text(security_description);
			$("#security_detail_text_suseridEW").text(security_suserid_name);
			$("#security_detail_text_displaynameEW").text(security_displayname);
		
			//刷新表格数据
			$('#fw_object_grid').datagrid('reload');
			$('#ips_object_grid').datagrid('reload');
			$('#waf_object_grid').datagrid('reload');
			//设置成功页面的详情
		    $('#securityServiceOpen_basicConfigEW').window('close');
		    $('#securityServiceOpen_successEW').window('open');
		}else{
			return;
		}
};
  
  function resetSecurityBasicConfigEW(){
      $("#security_description1").textbox('clear');
  	  $("#security_num1").textbox('clear');
	  $("#security_suserid1").combobox('clear');
	  $("#security_displayname1").textbox('clear');
  }
  
  
</script>