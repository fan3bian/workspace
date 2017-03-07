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
<div id="securityServiceOpen_typeConfig" class="easyui-window" title="云防火墙开通-防护类型"
		data-options="iconCls:'icon-add',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false"
		style="width:400px;height:200px;">
		<!-- 中部位置开始 -->
		<form id="securityTypeConfigForm" method="post">
			<div class="container-cell" style="height:30px;">
				<div class="product-details">
					<div class="product-from-con">
					    <div class="product-from-row" style="margin:0 auto; width:210px">
							<div class="product-form-cell">
								<ul class="item-01" id="fwtype" >
								    <li id="fw1" class="on"><a href="javascript:void(0)" >东西向防护</a></li>
									<li id="fw2"><a href="javascript:void(0)">南北向防护</a></li>
								</ul>
							</div>
						</div>
						</div>
						</div></div>
		</form>
		<!-- 底部 -->
		<div  style="background-color: #dce0e4;padding-top: 6px;padding-bottom:6px;padding-left: 0px;padding-right: 0px;text-align:center;clear: both;margin-left: -6px;margin-right: -6px;padding-bottom: 7px;">
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="javascript: $('#securityServiceOpen_typeConfig').window('close');">取消</a>&nbsp;&nbsp;&nbsp;&nbsp;
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-nextStep',iconAlign:'right',plain:true" onclick="toCreate()">下一步</a>&nbsp;&nbsp;
		</div>
		
	</div>
</body>
</html>
<script type="text/javascript">
$(function(){
	   var objs_standardchoose=$("#fwtype").children('li');
	   objs_standardchoose.click(function(){
  			$(this).addClass('on').siblings('li').removeClass('on');
		});
});

 toCreate = function(){
 	 var fw_flag = $("#fw1").hasClass("on");
	 if(fw_flag==true){//东西向防火墙
	    $('#securityServiceOpen_typeConfig').window('close');
	    $('#securityServiceOpen_basicConfigEW').window('open');
	 }else{//南北向防火墙
	  	$('#securityServiceOpen_typeConfig').window('close');
	    $('#securityServiceOpen_basicConfig').window('open');
	 }
  };

</script>