<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/icp/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>方案提交</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<!--多文件上传引用-->

</head>
<style type="text/css">
 
</style>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 30px 10px 20px;heigt:900px">
		<div data-options="region:'north',border:false" style="background:#eee;height:500px;overflow:hidden;border:false"> 
		<img alt="top" src="${ctx}/images/upload-pic.png" style="margin-top:30px">
		<form action="" method="post" enctype="multipart/form-data" id="filesform">
		<input type="hidden" name="proname" id="proname">
		<input type="hidden" name="unitname" id="unitname">
		 <div id="loadwrapper" style="margin: 60px 360px;">
		      <div class="load-line" >
				<span>单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：<input id="unitid" style="width: 340px;height: 30px; "  name="unitid" class="easyui-combobox" data-options=" 
				 valueField: 'unitId',    
                 textField: 'unitName',
                 url: '${ctx}/project/getUnits.do',    
                 onSelect: function(rec){    
                 var url = '${ctx}/project/getProjects.do?unitid='+rec.unitId;    
                 
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
				</span> 	  
		       </div>
		       <div class="load-line" style="margin-top: 20px" >
				<span>项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;目：<input class="easyui-combobox" data-options="valueField:'proid',textField:'proname'"   id="proid" style="width: 340px;height: 30px; "  name="proid">
				</span> 	  
		       </div>
		       <div class="load-line" style="margin-top: 20px">
				<span>文档类别：<select class="easyui-combobox" data-options="validType:'isBlank',"  id="filetype" style="width: 340px;height: 30px; "  name="filetype">
				   <option value="1">项目调研</option>   
                   <option value="2">项目需求</option>   
                   <option value="3">项目招标</option>   
                   <option value="4">项目方案</option>   
                   <option value="5">项目合同</option> 
                   <option value="5">专家评审</option>
                   <option value="6">其他类别</option>
		      	</select>
				</span> 	  
		       </div>
		       <div style="margin-top: 20px">
				<span>文档上传：<input type="file" data-options="validType:'isBlank'"  id="fileload" style="width: 340px;height: 30px; "  name="fileload">
				</span> 
		       </div>
			  </form>	  
		       <div style="text-align:center;padding:45px;margin-left: -40px">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="fileup()" style="width:80px">确定</a>&nbsp;&nbsp;&nbsp;
                <a class="easyui-linkbutton" data-options="iconCls:'icon-redo'" href="javascript:void(0)" onclick="javascript:$('#filesform').form('reset')" style="width:80px">重置</a>
            </div>
		 </div>
		 </div>
	</div>
	
    
      
	 
<script type="text/javascript">
 
  function fileup(){
   
     $("#filesform").form('submit',{
        url:'${ctx}/project/proFileLoad.do',
        onSubmit:function(){
            //var fileTypeName =  $("#fileload").val('getValue');
            
            var value = $("#proid").textbox("getValue");
            var unitid = $("#unitid").textbox("getValue");   
            if(value==""){
              $.messager.alert('警告',"请选择项目！","warning");
              return false;
            }
             if(unitid==""){
              $.messager.alert('警告',"请选择单位！","warning");
              return false;
            }
           /* if(fileTypeName=="" || fileTypeName==null){
             
             $.messager.alert('警告',"文档不能为空！","warning"); 
              return false;
           }  */
            var filetype = $("#filesform input[name='fileload']")[0].value;
			var fileTemp = filetype.substring(filetype.lastIndexOf(".")+1);
			var arr = new Array("doc","docx","txt","pdf","xls","xlsx");
			var flag = 0;
           
           if(!filetype)
			{
        	   $.messager.alert('警告',"文档不能为空！","warning");
				return false;
			}else{
				for(var i=0;i<arr.length;i++){
					if(arr[i]==fileTemp){
						flag = "1";
					}
				}
				if(flag=="0"){
					$.messager.alert('消息', '暂不支持该类型文档上传！<br><span style="color: #babbbc">支持的文件格式有：【.doc】【.docx】【.txt】【.pdf】【.xls】【.xlsx】。</span>',"info");
					return false;
				}
			}
          $('#proname').val($('#proid').combobox('getText'));
          $('#unitname').val($('#unitid').combobox('getText'));
          
        },
        success:function(data){
          var data = JSON.parse(data);
            if(data.success){
            $.messager.alert('提示',data.msg,"info");
    
           }else{
            
             $.messager.alert('提示',data.msg,"info"); 
           } 
       }
     })
     }
</script>
</body>
</html>
