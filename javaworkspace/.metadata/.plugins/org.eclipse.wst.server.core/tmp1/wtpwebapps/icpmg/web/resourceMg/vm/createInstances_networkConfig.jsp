<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<style type="text/css">
  
  .networkConfig{
    margin-top: 25px;
    padding-left: 190px;
  }
  .networkConfig-left{
    float: left;
    width: 20%;
    height: 100%;
     
    background-color: #eee;
  }
  .networkConfig-left p{
    width:50px;
    text-align:right;
    line-height: 29px;
    margin-left:92px;
    margin-top:26px; 
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
<body>

<div id="createInstances_networkConfig" class="easyui-window" title="创建云服务器-网络配置"
		data-options="iconCls:'icon-add',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false,resizable:false"
		style="width:814px;height:550px;">
   <div class="createInstances_flow">   
	 <img alt="step2" src="${pageContext.request.contextPath}/images/flow_02.png" >
   </div>
	 	
	 <div id="networkConfig-wrap" style="width: 100%; height: 405px;overflow: hidden;">
	 
	   <div class="networkConfig-left">
	      
	        <p>资源池</p>
	        <p>网络</p>
	       <!--  <p>IP</p> -->
	      
	   </div>
	   <div class="networkConfig-right">
	   
	       <div class="resourcepool networkConfig">
	   
	            <input class="easyui-combobox" data-options="valueField:'poolid',textField:'poolname',editable:false"   id="resourcepool" style="width: 340px;height: 30px; "  name="resourcepool">
				
	       </div>
	       <div class="instancesnetwork networkConfig">
	            <input class="easyui-combobox" data-options="valueField:'networkid',textField:'networkname',editable:false"   id="instancesnetwork" style="width: 340px;height: 30px; "  name="instancesnetwork">
		   
	       </div>
	     <!--   <div class="instancesip networkConfig">
                <p>IP可以在虚机创建完成后配置</p>
           </div> -->
	   </div>
	</div>	
<div style="background-color: #dce0e4;padding: 6px;text-align:center;">
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" onclick="toLastConfig()">上一步</a>&nbsp;&nbsp;&nbsp;&nbsp;
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-nextStep',plain:true,iconAlign:'right'" onclick="toBaseInfo()">下一步</a>&nbsp;&nbsp;
</div>
</div>

</body>
</html>
<script type="text/javascript">
  var resourcepoolurl="${pageContext.request.contextPath}/vmconfig/queryResourcePool.do";
  var instancesnetworkurl="${pageContext.request.contextPath}/vmconfig/queryVlan.do";
  $(function(){
   
   //获取资源池
  $("#resourcepool").combobox({    
    url:resourcepoolurl,    
    valueField:'poolid',    
    textField:'poolname',
    loadFilter:function(data){
	        data.unshift({poolid:'',poolname:"---请选择---"});
	        return data;
	  },
    onLoadSuccess: function () { //加载完成后,设置选中第一项
       var data = $('#resourcepool').combobox('getData');
           if (data.length > 0) {
                 $('#resourcepool').combobox('select', data[0].poolid);
             } 
    },   
    onSelect:function(rec){
       var temp  = rec.poolid;
       var temp1 = temp.split(",");
       $("#resourceId").val(temp1[0]);
       $("#platformid").val(temp1[1]);
       $("#mnetworkypeid").val(temp1[2]);
       $("#mnetworkypename").val(temp1[3]);
       $("#instancesnetwork").combobox('reload','${pageContext.request.contextPath}/vmconfig/queryVlan.do?platformid='+temp1[1]);
    }
  });
    
   $("#instancesnetwork").combobox({    
    url:instancesnetworkurl,    
    valueField:'networkid',    
    textField:'networkname',
    loadFilter:function(data){
	        data.unshift({networkid:'',networkname:"---请选择---"});
	        return data;
	  },
    onLoadSuccess: function () { //加载完成后,设置选中第一项
       var data = $('#instancesnetwork').combobox('getData');
           if (data.length > 0) {
                 $('#instancesnetwork').combobox('select', data[0].networkid);
             } 
            }
    
  });  
  
    toLastConfig = function(){
    
        $('#createInstances_networkConfig').window('close');
        $('#createInstances_basicConfig').window('open');
    }
    toBaseInfo = function(){
    
       /*  var reg = /^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/; 
        var ip  = $("#instancesip").textbox('getValue'); */
        
         if($("#resourcepool").combobox('getValue').split(",")[0]==""){
             $.messager.alert('警告',"请选择资源池","warning");
             return;
         }
         if($("#instancesnetwork").combobox('getValue')==""){
             $.messager.alert('警告',"请选择vlan","warning");
             return;
         }
        
      /*    if(!reg.test(ip)){
           
           $.messager.alert('警告',"请输入正确格式IP","warning");
            return;
        } */
       
        $("#networkId").val($("#instancesnetwork").combobox('getValue'));
       /*  $("#ipDiy").val($("#instancesip").textbox('getValue')); */
        $('#createInstances_networkConfig').window('close');
        $('#createInstances_basicInfo').window('open');
    }
  })
</script>
