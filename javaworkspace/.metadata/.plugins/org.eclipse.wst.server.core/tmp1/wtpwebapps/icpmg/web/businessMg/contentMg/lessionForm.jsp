<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String lessionid = request.getParameter("lessionid");
	if (lessionid == null) {
		lessionid = "";
	}	
%>

<body>
	<jsp:include page="../../inc.jsp"></jsp:include>
  	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/kindeditor/themes/default/default.css">
   	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/kindeditor/kindeditor.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/kindeditor/lang/zh_CN.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/js/validate.js"></script>
  	<script type="text/javascript">
  	var onShows = function($pjq) {
		
		 	showHtml($pjq);
			
	}
	var showHtml = function($pjq){
  		    $.messager.confirm('确认','您确认要预览吗？',function(r){  
   			if (r){ 	  
   			if ($('#tableform').form('validate')) {
		 	 var content = document.getElementById("lessioncontent").value;
		if ( content.length==0 || content== null || content=="<p>\n\t<br />\n</p>" || content=='') { 
		
			$pjq.messager.alert('提示', '课堂内容不能为空！', 'info'); 
			
           return false;
            }else{
		 	$('#tableform').form('submit',{
		    url:'${pageContext.request.contextPath}/content/lessionshow.do', 
		    onSubmit: function(){

		    },
		    success:function(retr){
		   			var data =  $.parseJSON(retr);
				  	if(data.success)
					    	{	
					    	var adr='${pageContext.request.contextPath}/icp/portal/service/content/lession/temp/' + data.msg;
					    //location.replace ('${pageContext.request.contextPath}/icp/portal/news/temp/newshow.html') ;	
		               window.open(adr,'_blank');
		     }
		    }
		  });
		  }
        }  
			 
	      }
	   	 		  
	  });
	   	 
	 }  
  	var closeWindows = function($dialog) {
  		$dialog.dialog('destroy');
  		}
  		
  	var submitForm = function($dialog, $gridLession, $pjq) {
		
		 	submitSave($dialog, $gridLession, $pjq);
			
	}
	var submitSave = function($dialog, $gridLession, $pjq){
	if ($('#tableform').form('validate')) {
	var content = document.getElementById("lessioncontent").value;
		if ( content.length==0 || content== null || content=="<p>\n\t<br />\n</p>" || content=='') { 
		
			$pjq.messager.alert('提示', '课堂内容不能为空！', 'info'); 
			
           return false;
            }else{
		 	//$('#saveBtn').linkbutton('disable');
		 	$('#tableform').form('submit',{
		    url:'${pageContext.request.contextPath}/content/lessionSaveOrUpdate.do', 
		    onSubmit: function(){
		    	
		    },
		    success:function(retr){
		    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
		    	
		    	var _data =  $.parseJSON(retr);
		    	if (_data.success) {
				$pjq.messager.alert('提示', _data.msg, 'info');
				$gridLession.datagrid('unselectAll');
				$gridLession.datagrid('load');
				$dialog.dialog('destroy');
				} else {
				$pjq.messager.alert('提示', _data.msg, 'error');
				}
		    	
		    }
		});
		 	//$("#details").parent().dialog('destroy');
		 	}
		 }
		 }
</script>
		 
<style type="text/css">
		.FieldInput2 {
			width:77%;
			height:30px;
		    background-color: #FFFFFF;
			font: normal 12px tahoma, arial, helvetica, sans-serif;
		    text-align: left;
		    word-wrap: break-word;
		    padding-top:0px !important;
		    padding-bottom:0px !important;
		    border:#BCD2EE 1px solid !important;  
		}
		.FieldLabel2 {
			width:23%;
			height:30px;
		    background-color: #F0F8FF;
			font: normal 12px tahoma, arial, helvetica, sans-serif;
		    text-align: left;
		    word-wrap: break-word;
		    padding-top:0px !important;
		    padding-bottom:0px !important;
		    padding-right:10px !important;
		    border:#BCD2EE 1px solid !important;  
		}
	</style>
	<div id="details" class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'center',border:false" style="padding:10px;">
	<form id="tableform" method="post" enctype="multipart/form-data">
						<input id="lessionid" name="lessionid" value="<%=lessionid%>" type="hidden"/>
							 
						<table align="center"  style="width:100%">
					 
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									标题：</td>
								<td class="FieldInput2"><input id="lessiontitle"
									style="height:30px;width:300px;" name="lessiontitle" class="easyui-validatebox"
									data-options="required:true,validType:'length[1,50]'" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2">标题LOGO：</td>
								<td class="FieldInput2"><input type="file" id="lessionImage" style="height:30px;width:300px;"  name="lessionImage"  
								    /><font color="red">选择一张图片*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">标题LOGO路径：</td>
								<td class="FieldInput2"><input id="lessionimage" style="height:25px;width: 300px !important" name="lessionimage" readonly/></td>
							</tr>
							<tr>
								<td class="FieldLabel2">文件上传：</td>
								<td class="FieldInput2"><input type="file" id="lessionFile" style="height:30px;width:300px;"  name="lessionFile"  
								   /><font color="red">请选择相关附件</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">文件上传路径：</td>
								<td class="FieldInput2"><input id="lessionfileurl2" style="height:25px;width: 300px !important" name="lessionfileurl2" readonly/></td>
							</tr>
					     <tr>
					      <td class="FieldLabel2">内容简介：</td>
					      <td class="FieldInput2"><textarea id="lessionintroduce" name="lessionintroduce" style="width:80%;height:80px;" class="easyui-validatebox" data-options="required:true,validType:'length[1,254]'"></textarea></td>
						</tr>
						<tr>
						<td class="FieldLabel2">课堂内容：</td>
					      <td class="FieldInput2"><textarea id="lessioncontent" name="lessioncontent" style="width:100%;height:360px;"></textarea></td>
						</tr>
						</table>
					</form>
			</div>
				
			</div>	
</body>
<script type="text/javascript">
  	//$(function(){
  	var strContent;
  	if ($(':input[name="lessionid"]').val().length > 0) {
			
			$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/content/getLessionById.do',
   				  		data:{leId:$(':input[name="lessionid"]').val()},
   				  		success:function(retr){
   				  			var _data =  eval('(' + retr + ')'); 
   				  			
				  			if (_data[0].lessionid != "") {
				  			
					  			$("#lessiontitle").val(_data[0].lessiontitle);
					  			$("#lessionintroduce").val(_data[0].lessionintroduce);	  			
								$("#lessionImage").text(_data[0].lessionimage);
					  			//$("#lessionFile").text(_data[0].lessionfileurl);
					  			$("#lessionimage").val(_data[0].lessionimage);
					  			$("#lessionfileurl2").val(_data[0].lessionfileurl);
					
					if (_data[0].lessioncontent != ""){
						strContent = _data[0].lessioncontent;
					
					KindEditor.insertHtml('#lessioncontent', strContent);
					
						}
					}
   				  		}
   				  	});
   				  	
			
			
		}
  		KindEditor.ready(function(K) {
                var editor1 = K.create('#lessioncontent', {
                    //自定义工具栏
                	items:[
					        'code', '|', 'justifyleft', 'justifycenter', 'justifyright',
					        'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent',
					        'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen',
					        'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
					        'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 
					        'table', 'hr', 'emoticons', 'baidumap', 'pagebreak',
					        'anchor', 'link', 'unlink'
					],
					uploadJson : '${pageContext.request.contextPath}/content/ImgUpload.do', //图片上传Action
					fileManagerJson : '${pageContext.request.contextPath}/kindeditor/jsp/file_manager_json.jsp',
					allowFileManager : true,
					allowImageUpload : true,
					allowImageRemote : false, //取消网络图片上传
					afterChange:function(){
					this.sync();//这个是必须的,如果你要覆盖afterChange事件的话,请记得最好把这句加上.
					}
				});
				
				 
        });
       
  	//})
  </script>