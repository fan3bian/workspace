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
<link rel="stylesheet" type="text/css" media="screen"
	href="${pageContext.request.contextPath}/web/resourceMg/vm/css/gather.css" />
<link rel="stylesheet" type="text/css" media="screen"
	href="${pageContext.request.contextPath}/web/resourceMg/vm/css/util.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/web/resourceMg/vm/js/slide.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/web/resourceMg/vm/js/TweenMax.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/web/resourceMg/vm/js/myScroll.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/web/resourceMg/vm/js/util.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/web/resourceMg/vm/js/gather.js"></script>
<script type="text/javascript" 
    src="${pageContext.request.contextPath}/js/validate.js"></script>
<body>

<div id="securityServiceOpen_basicConfig" class="easyui-window" title="安全服务开通-基础配置"
		data-options="iconCls:'icon-add',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false"
		style="width:801px;height:477px;">
   <div class="createInstances_flow">  
       <img alt="step1" src="${pageContext.request.contextPath}/images/safe_flow_01.png">
	</div>	
	<!-- 中部位置开始 -->
		<form id="securityBasicConfigForm" method="post">
	<div class="securityServiceOpen_basicConfig_wrap" style="width: 100%; height: 330px;">
	    <!--左边位置开始  -->
	  <div class="basicConfig_left" style="height: 70%;width: 20%;">
	        
	        <p>规格</p>
	        <p>服务</p>
	        <p>租户</p>
	        <p>名称</p>
	     
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
									<ul class="item-01" id="security_shopid">
									    <li   value="10001" class="on"><a href="javascript:void(0)" >基础</a></li>
										<li   value="10002"><a href="javascript:void(0)">高级</a></li>
									</ul>
								</div>
								<div class="clear"></div>
							</div>
							
							<div class="product-from-row">
							 
								<div class="product-form-cell">
									<ul class="item-01" id="security_funtypes">
										<li class="on"  value="1"><a href="javascript:void(0)" >防火墙</a></li>
										<li  value="3"><a href="javascript:void(0)" >入侵防御</a></li>
										<li class="on"  value="4"><a href="javascript:void(0)" >Web应用防护</a></li>
									</ul>
								</div>
								<div class="clear"></div>
							</div>
							
						   <div class="product-from-row">
							 
								<div class="product-form-cell">
								   <input class="easyui-combobox" data-options="editable:false,required:true"   id="security_suserid" style="width: 340px;height: 30px; "  name="security_userunit">
								</div>
								<div class="clear"></div>
						   </div>
							
							
							  <div class="product-from-row">
							 
								<div class="product-form-cell">
								     <input class="easyui-textbox" data-options="prompt:'名称(必填)',required:true,validType:'length[1,100]',missingMessage:'该输入项不允许为空，最多输入100个字符'"   id="security_displayname" style="width: 340px;height: 30px; "  name="security_displayname">
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
	 
	   
     </div><!-- 右边位置结束 -->
	</div>	<!-- 中部位置结束 -->
		</form>
	<!-- 底部 -->
		<div style="background-color: #dce0e4;padding: 6px;text-align:center; clear: both;">
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="javascript: $('#securityServiceOpen_basicConfig').window('close');">取消</a>&nbsp;&nbsp;&nbsp;&nbsp;
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-nextStep',iconAlign:'right',plain:true" onclick="toNetwork()">下一步</a>&nbsp;&nbsp;
		</div>
		
	</div>
</body>
</html>
<script type="text/javascript">
$(function(){

	   var objs_standardchoose=$("#security_shopid").children('li');
	   objs_standardchoose.click(function(){
  			$(this).addClass('on').siblings('li').removeClass('on');
			});
	   
	   
	   var objs_servicechoose=$("#security_funtypes").children('li');
	   objs_servicechoose.click(function(){
		   if($(this).val() == 4){
			   return;
		   }
		   
  			if($(this).hasClass("on")){
  				$(this).removeClass('on');
  				//至少要保证一个选中
  				if($(this).val() == 1){
  					$(this).next().addClass('on');
  				}else if($(this).val() == 3){
  					$(this).prev().addClass('on');
  				}
  			}else{
  				$(this).addClass('on');
  			}
  			
			});
	
		$("#security_suserid").combobox({
			url:'${pageContext.request.contextPath}/authMgr/queryUserBscinfo.do',    
		    valueField:'email',    
		    textField:'uname',
		    editable:false,
		    required:true,
		    panelHeight:'auto',
		    onSelect:function(record){
		    	debugger;
		    	queryNetwork(record.email);
		    }
// 					url:'${pageContext.request.contextPath}/authMgr/getAllGovUserInfo.do',    
// 				    valueField:'emailUnitId',    
// 				    textField:'alias',
// 				    editable:false,
// 				    required:true,
// 				  //  panelHeight:'auto',
// 				    onSelect:function(record){
// 				       var emailUnitIdArray = record.emailUnitId.split(";");
// 				       var unitid = null;
// 				       if(emailUnitIdArray.length = 2){
// 				    	   unitid = emailUnitIdArray[1];
// 				    	   $("#unitid").val(unitid);
// 				    	   if(unitid){
// 				    		   queryNetwork(unitid); 
// 				    	   }
// 				       }
				    	
// 				    }
			});
		
		function queryNetwork(email){
			$("#security_manVlanName").combobox({
				url:'${pageContext.request.contextPath}/lb/queryNetwork.do?servicetype=0&email='+email,
			    valueField:'vlanid',    
			    textField:'vlanname',
			    required:true,
			    panelHeight:'auto',
		    	onSelect :function(record){
		    		$('#unitid').val(record.userunitid);
		  	    	/*if('openstack'==record.plattype){
		  	    		$('#madr').hide();
		  	    		$('#fadr').hide();
		  	    		$('#cadr').hide();
		  	    		$('#security_manIp').parent().hide();
		  	    		$('#security_funIp').parent().hide();
		  	    		$('#security_connIp').parent().hide();
		  	    	}else{
		  		    	$('#madr').show();
		  	    		$('#fadr').show();
		  	    		$('#cadr').show();
		  	    		$('#security_manIp').parent().show();
		  	    		$('#security_funIp').parent().show();
		  	    	}*/
		  	    }
			});
			$("#security_funVlanName").combobox({
				url:'${pageContext.request.contextPath}/lb/queryNetwork.do?servicetype=1&email='+email,
			    valueField:'vlanid',    
			    textField:'vlanname',
			    required:true,
			    panelHeight:'auto'
			});
			$("#security_connVlanName").combobox({
				url:'${pageContext.request.contextPath}/lb/queryNetwork.do?servicetype=2&email='+email,
			    valueField:'vlanid',    
			    textField:'vlanname',
			    required:true,
			    panelHeight:'auto'
			});
		}
		
	
});

 toNetwork = function(){
	 if($('#securityBasicConfigForm').form('validate')){
      $('#securityServiceOpen_basicConfig').window('close');
      $('#securityServiceOpen_networkConfig').window('open');
	 }
  };

  
  function resetSecurityBasicConfig(){
	  var objs_standardchoose=$("#security_shopid").children('li');
	  var objs_servicechoose=$("#security_funtypes").children('li');
	  objs_standardchoose.each(function(index,element){
		  if(index == 0){
			  $(this).addClass('on');
		  }else{
			  $(this).removeClass('on');
		  }	  
	  });
	  
	  objs_servicechoose.each(function(index,element){
		    if(index == 0){
		    	 $(this).addClass('on');
		    }else if (index == 1){
		    	 $(this).removeClass('on');
		    }else if(index == 2){
		    	 $(this).addClass('on');
		    }
		  
	  });
	  
	  $("#security_suserid").combobox('clear');
	  $("#security_displayname").textbox('clear');
  }
  
  
</script>