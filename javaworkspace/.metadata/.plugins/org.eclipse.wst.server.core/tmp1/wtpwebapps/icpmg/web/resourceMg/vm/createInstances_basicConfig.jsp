<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
  }
  .basicConfig_left p{
     position: relative;
     padding-top:3px;
     top: 5px;
  }
  
</style>
<link rel="stylesheet" type="text/css" media="screen"
	href="${pageContext.request.contextPath}/web/resourceMg/vm/css/gather.css" />
 
<body>

<div id="createInstances_basicConfig" class="easyui-window" title="创建云服务器-基础配置"
		data-options="iconCls:'icon-add',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false,resizable:false"
		style="width:814px;height:550px;">
   <div class="createInstances_flow">  
       <img alt="step1" src="${pageContext.request.contextPath}/images/flow_01.png">
	</div>	
	<!-- 中部位置开始 -->
	<div class="createInstances_basicConfig_wrap" style="width: 100%; height: 405px;">
	    <!--左边位置开始  -->
	  <div class="basicConfig_left networkConfig-left" style="height: 74%;width: 20%;">
	        
	        <p>CPU</p>
	        <p>内存</p>
	        <p>镜像</p>
	        <p>系统盘</p>
	        <p>数据盘</p>
	  </div>
	 <!--右边位置开始  -->
	  <div class="basicConfig_right networkConfig-right">
 	    <div class="container-wrap" >
		  <div class="container">			
			<div style="float:left;width:885px;height: 399px/*padding-bottom:9999px;margin-bottom:-9999px;*/">
				<div class="container-cell">
					<div class="product-details">
						<div class="product-from-con">
						<div style=" ">
						    <div class="product-from-row">
								 
								<div class="product-form-cell">
									<ul class="item-01" id="cpuchoose">
									   
									</ul>
								</div>
								<div class="clear"></div>
							</div>
							
							<div class="product-from-row">
							 
								<div class="product-form-cell">
									<ul class="item-01" id="memchoose">
										 
									</ul>
								</div>
								<div class="clear"></div>
							</div>
							
						   <div class="product-from-row">
							 
								<div class="product-form-cell">
								   <input class="easyui-combobox" data-options="valueField:'templateid',textField:'templatename',editable:false,panelHeight:'auto'"   id="instancestemplate" style="width: 340px;height: 30px; "  name="instancestemplate">
								</div>
								<div class="clear"></div>
						   </div>
							
							
							  <div class="product-from-row">
							 
								<div class="product-form-cell">
								   <p style="height: 30px;line-height: 29px; font-size: 13px">赠送系统盘Windows(60G)、Linux(40G)</p>
								</div>
								<div class="clear"></div>
						     </div>
						   
						    <div class="product-from-row">
							 
								<div class="product-form-cell" style="margin-left: 8px">
								   <input class="easyui-slider" id="disknum1" style="width:400px" data-options="showTip:true,max:2000,min:0,step:10,rule: [0,'|','|',600,'|','|','|','|','|','|',2000],tipFormatter: function(value){
				                        return value+'G';}">
								</div>
								<span><img id="diskadd" alt="diskpluse" src="${pageContext.request.contextPath}/web/resourceMg/vm/images/add.png" style="margin: 2px 0 0 23px "></span>
								 
								<div class="clear"></div>
						     </div>
						     
						       <div class="product-from-row">
							 
						       <div class="product-form-cell disk-select2" style="margin-top: 10px;margin-left: 8px">
								   <input class="easyui-slider" id="disknum2" style="width:400px" data-options="showTip:true,max:2000,min:0,step:10,rule: [0,'|','|',600,'|','|','|','|','|','|',2000],tipFormatter: function(value){
				                        return value+'G';}">
								</div>
								<span><img id="diskremove" alt="diskpluse" src="${pageContext.request.contextPath}/web/resourceMg/vm/images/cancel.png" style="margin: 14px 0 0 23px "></span>
								 
								<div class="clear"></div>
						     </div>
						</div>
                     </div>
					</div>	
				</div>
			</div>		 
		</div>
	   </div>
	   <!-- 引用原icpserver结束 -->
	 
	   
     </div><!-- 右边位置结束 -->
	</div>	<!-- 中部位置结束 -->
	<!-- 底部 -->
		<div style="background-color: #dce0e4;padding: 6px;text-align:center; clear: both;">
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="javascript: $('#createInstances_basicConfig').window('close');">取消</a>&nbsp;&nbsp;&nbsp;&nbsp;
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-nextStep',iconAlign:'right',plain:true" onclick="toNetwork()">下一步</a>&nbsp;&nbsp;
		</div>
		
	</div>
</body>
</html>

<script type="text/javascript">

$(document).ready(function (){
  //硬盘增减
    $(".disk-select2").hide();
    $("#diskremove").hide();
    $("#diskadd").click(function(){
       $(".disk-select2").show();
       $("#diskremove").show();
       $(this).hide();
    });
    $("#diskremove").click(function(){
        $("#diskremove").hide();
         $("#diskadd").show();
        $(".disk-select2").hide();
        $("#disknum2").slider('setValue','0');
    });
    $("#diskadd").tooltip({
        position: 'right',  
        content: '<span style="color:#fff">最多有两块数据盘</span>',
        onShow: function(){ 
          
             $(this).tooltip('tip').css({backgroundColor: '#999',borderColor: '#999'});
       
        }
    
    })
 
    //初始化cpu
    initCpu();
    $("#cpuchoose").children().remove();
    //初始化內存
    initMem();
   $("#memchoose").children().remove();
   //获取镜像
  $("#instancestemplate").combobox({    
    url:'${pageContext.request.contextPath}/vmconfig/queryTemplates.do',    
    valueField:'templateid',    
    textField:'templatename',
    onSelect: function(data){ 
    
      $(this).combobox('setText', data.templatename.substring(data.templatename.indexOf(">")+1));
    },
     loadFilter:function(data){
	        data.unshift({templateid:'',templatename:"---请选择---"});
	        return data;
	  },
    onLoadSuccess: function () { //加载完成后,设置选中第一项
       var data = $('#instancestemplate').combobox('getData');
     
           if (data.length > 0) {
                 $('#instancestemplate').combobox('select', data[0].templatename.substring(data[0].templatename.indexOf(">")+1));
                 $('#instancestemplate').combobox('select', data[0].templateid);

             } 
             
     }   
    
  });

}); 

     function choosecpu(value){
       
        $("#memchoose").children().remove();
         	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/vmconfig/queryMem.do',
   				  		data:{cpunum:value},
   				  		asyn:false,
   				  		dataType:'json',
   				  		success:function(data){
   				  	       $.each(data,function(index,value){
   				  	         if(index=='0'){   				  	         
   				  	          $("#memchoose").append("<li class=\"on\" onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
   				  	          $('#stroeSize').val(value);
   				  	         }else{
   				  	           $("#memchoose").append("<li onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
   				  	         }
   				  	         
   				  	         var obj_2=$("#memchoose").children('li');
		 	                 obj_2.click(function(){
	   		             	 $(this).addClass('on').siblings('li').removeClass('on');
  			                 })
  			                
   				  	       })
   				  		}
   				 })
   			
     }
      
       function choosemem(value){
           $('#stroeSize').val(value);
        }
         
       function initCpu() {
        
         	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/vmconfig/queryCpu.do',
   				  		asyn:false,
   				  		dataType:'json',
   				  		cache: false,
   				  		success:function(data){
   				  		  if($("#cpuchoose").children().length==0){
   				  	       $.each(data,function(index,value){
   				  	         if(index=='1'){   				  	         
   				  	             $("#cpuchoose").append("<li class=\"on\" onclick=\"choosecpu("+value+")\" value="+value+"><a href=\"javascript:void(0)\" >"+value+"核 </a></li>");
   				  	         }else{
   				  	            $("#cpuchoose").append("<li onclick=\"choosecpu("+value+")\"  value="+value+"><a href=\"javascript:void(0)\">"+value+"核</a></li>");
   				  	         }
  			              
   				  	       })
   				  	      }
		  	        	   var obj_2=$("#cpuchoose").children('li');
		 	               obj_2.click(function(){
	   			           $(this).addClass('on').siblings('li').removeClass('on');
	   			            var _value = $(this).attr("value");
	                        $("#cpuNum").val(_value);
	                      })
   				  		}
   				 })
       }
       
       function initMem() {
        
         	$.ajax({
			  		type : 'post',
			  		url:'${pageContext.request.contextPath}/vmconfig/queryMem.do',
			  		asyn:false,
			  		dataType:'json',
			  		cache: false,
			  		success:function(data){
			  	      if($("#memchoose").children().length==0){
			  	       $.each(data,function(index,value){
			  	         if(index=='0'){   				  	         
			  	             $("#memchoose").append("<li class=\"on\" onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
			  	         }else{
			  	            $("#memchoose").append("<li onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
			  	         }
			          
			            
			  	       })
			      	   } 
			             var obj_2=$("#memchoose").children('li');
			             obj_2.click(function(){
			             $(this).addClass('on').siblings('li').removeClass('on');
			           
			            })
			  		}
			 })
       }
        toNetwork = function(){
          $('#createInstances_basicConfig').window('close');
          $('#createInstances_networkConfig').window('open');
   
          $("#imagesId").val($("#instancestemplate").combobox('getValue'));
          $("#dataDisk1").val($("#disknum1").slider('getValue'));
          $("#dataDisk2").val($("#disknum2").slider('getValue')); 
          
        } 
                
</script>