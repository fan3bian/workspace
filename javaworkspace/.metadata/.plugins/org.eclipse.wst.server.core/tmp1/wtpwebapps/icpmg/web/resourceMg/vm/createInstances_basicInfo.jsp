<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<style type="text/css">
  
  .basicInfo-left p{
    width:80px;
    text-align:right;
    line-height: 30px;
    margin-left:56px;
    margin-top:25px; 
    font-size: 14px;
  }

</style>
<body>

<div id="createInstances_basicInfo" class="easyui-window" title="创建云服务器-基本信息" data-options="iconCls:'icon-add',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false,resizable:false" style="width:814px;height:550px;">

<div class="createInstances_flow">  
  <img alt="step3" src="${pageContext.request.contextPath}/images/flow_03.png">		
</div>
<div id="basicInfo-wrap" style="width: 100%; height: 405px;overflow: hidden;">

   <div class="basicInfo-left networkConfig-left">
	      
	        <p>虚机名称</p>
	        <p>数量</p>
	        <p style="margin-top: 60px"></p>
	        <p>单位</p>
	        <p>项目</p>
	        <p>应用</p>
	 </div>
 <div class="basicInfo-right networkConfig-right">
    <div class="instancename basicInfo networkConfig">
         <input class="easyui-textbox" data-options="required:'ture',prompt:'虚拟机名称(多台请用分号分隔){例如:vm-01;vm-02;vm-03}',missingMessage:'请填写虚拟机名称'"   id="instancename" style="width: 340px;height: 30px; "  name="instancename">
	 
      </div>
      <div class="instancenumber basicInfo networkConfig">
         <input class="easyui-numberspinner" value="1" data-options="increment:1,min:1,editable:false"   id="instancenumber" style="width: 340px;height: 30px; "  name="instancenumber">
		  
      </div>
      
      <div style="border-bottom: 1px solid #eee;width: 68%;margin-left: 190px;margin-top: 35px"></div>
     
     
      <div class="unitname basicInfo networkConfig" >   
         <input id="unitid" style="width:340px;height: 30px; "  name="unitid" class="easyui-combobox" data-options=" 
				 valueField: 'unitId',    
                 textField: 'unitName',
                 
                 url: '${pageContext.request.contextPath}/project/getUnits.do',    
                 onSelect: function(rec){    
                 var url = '${pageContext.request.contextPath}/project/getProjects.do?unitid='+rec.unitId;    
                 
                 $('#proid').combobox({    
                    url:url,    
                    valueField:'proid',    
                    textField:'proname',  
                    onLoadSuccess: function () { //加载完成后,设置选中第一项
                    var data = $('#proid').combobox('getData');
                  if (data.length > 0) {
                 $('#proid').combobox('select', data[0].proid);
             } 
           }   
   });
              },
               onLoadSuccess: function () { //加载完成后,设置选中第一项
              var data = $('#unitid').combobox('getData');
             if (data.length > 0) {
                 $('#unitid').combobox('select', data[0].unitId);
             } 
            } 
        ">
      </div>
              
      <div class="projectname basicInfo networkConfig" >
      
         <input class="easyui-combobox" data-options="valueField:'proid',textField:'proname',"   id="proid" style="width: 340px;height: 30px;"  name="proid">
      </div>
      
       <div class="appname basicInfo networkConfig">
           <input class="easyui-textbox" data-options="required:'ture',prompt:'应用名称',missingMessage:'请填写应用名称'"   id="appname" style="width: 340px;height: 30px; "  name="appname">
      </div>
      
      </div>
</div>
<div style="background-color: #dce0e4;padding: 6px;text-align:center;">
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" onclick="toLastNetWork()">上一步</a>&nbsp;&nbsp;&nbsp;&nbsp;
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true" onclick="toSuccess()">创建</a>&nbsp;&nbsp;
</div>
 
</div>

</body>
</html>
<script type="text/javascript">
  $(function(){
    
    toLastNetWork = function(){
    
        $('#createInstances_basicInfo').window('close');
        $('#createInstances_networkConfig').window('open');
    }
    
    toSuccess = function(){
         
        var serverNum = $("#instancenumber").spinner('getValue');
        var instancename =  $("#instancename").textbox('getValue');
        if($.trim($("#instancename").textbox('getValue'))==""){
            return;
        }
        if($("#proid").combobox('getValue')==""){
         $.messager.alert('警告',"请选择项目","warning");
            return;
        }
        if($.trim($("#appname").textbox('getValue'))==""){
            return;
        }
        if(serverNum=="1"){
          if(instancename.indexOf(";")>0){
            $.messager.alert('警告',"请严格按照命名规范,单台不能带【;】","warning");
            return;
          }
        }
        if(serverNum!="1"){
           var instancenames = instancename.split(";");
           if(instancenames.length!=serverNum||instancenames[instancenames.length-1]==""){
              $.messager.alert('警告',"虚拟机名与其台数不匹配","warning");
              return;
           }
          
        }
       
       $("#serverName").val($("#instancename").textbox('getValue'));
       $("#serverNum").val($("#instancenumber").spinner('getValue'));
       $("#mproid").val($("#proid").combobox('getValue'));
       $("#mproname").val($("#proid").combobox('getText'));
       $("#munitid").val($("#unitid").combobox('getValue'));
       $("#munitname").val($("#unitid").combobox('getText'));
       $("#mappname").val($("#appname").textbox('getValue'));		
      
       $("#createVmForm").form('submit',{ 
       
       url:'${pageContext.request.contextPath}/vmmanage/createVM.do',   
       async: false, 
       onSubmit: function(){    
       
       },
      success:function(data){    
         
      }    
      });
      $('#createInstances_basicInfo').window('close');
      $('#object_grid').datagrid("reload");   
    }
    

  })
  
</script>
