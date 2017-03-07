<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	if (id == null) {
		id = "";
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
		 	 var content = document.getElementById("newscontent").value;
		if ( content.length==0 || content== null || content=="<p>\n\t<br />\n</p>" || content=='') { 
		
			$pjq.messager.alert('提示', '新闻内容不能为空！', 'info'); 
			
           return false;
            }else{
		 	$('#tableform').form('submit',{
		    url:'${pageContext.request.contextPath}/content/newshow.do', 
		    onSubmit: function(){

		    },
		    success:function(retr){
		   			var data =  $.parseJSON(retr);
				  	if(data.success)
					    	{	
					    	var adr='${pageContext.request.contextPath}/icp/portal/news/temp/' + data.msg;
					    //location.replace ('${pageContext.request.contextPath}/icp/portal/news/temp/newshow.html') ;	
		     window.open(adr,'_blank');
		     //newswindow.location.replace ('${pageContext.request.contextPath}/icp/portal/news/temp/newshow.html') ;
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
  		
  	var submitForm = function($dialog, $grid, $pjq) {
		
		 	submitSave($dialog, $grid, $pjq);
			
	}
	var submitSave = function($dialog, $grid, $pjq){
	if ($('#tableform').form('validate')) {
	var content = document.getElementById("newscontent").value;
		if ( content.length==0 || content== null || content=="<p>\n\t<br />\n</p>" || content=='') { 
		
			$pjq.messager.alert('提示', '新闻内容不能为空！', 'info'); 
			
           return false;
            }else{
		 	//$('#saveBtn').linkbutton('disable');
		 	$('#tableform').form('submit',{
		    url:'${pageContext.request.contextPath}/content/newsSaveOrUpdate.do', 
		    onSubmit: function(){
		    	
		    },
		    success:function(retr){
		    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
		    	
		    	var _data =  $.parseJSON(retr); 
		    	if (_data.success) {
				$pjq.messager.alert('提示', _data.msg, 'info');
				$grid.datagrid('unselectAll');
				$grid.datagrid('load');
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
						<input id="newsid" name="newsid" value="<%=id%>" type="hidden"/>
							 
						<table align="center"  style="width:100%">
							<tr>
								<td class="FieldLabel2">新闻类型：</td>
								<td class="FieldInput2">
								<select id="newtypeno" name="newtypeno"  style="height:30px;width:300px;">
							   	 	<option value="1000000019">动态新闻</option>
					            </select>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									新闻标题：</td>
								<td class="FieldInput2"><input id="newstitle"
									style="height:30px;width:300px;" name="newstitle" class="easyui-validatebox"
									data-options="required:true,validType:'length[1,50]'" /><font color="red">*</font></td>

							</tr>
							<!--  
							<tr>
								<td class="FieldLabel2">新闻LOGO：</td>
								<td class="FieldInput2"><input id="newsphotoaddrs" style="height:30px;width:300px;" buttonText="浏  览" class="easyui-filebox" name="newsphotoaddrs"  
								   data-options="text:'file'" /><font color="red">选择一张图片*</font></td>
							</tr>
							-->
						  <tr>
					         <td class="FieldLabel2">新闻概述：</td>
					         <td class="FieldInput2"><textarea id="newsintroduce" name="newsintroduce" style="width:80%;height:80px;" class="easyui-validatebox" data-options="required:true,validType:'length[1,254]'"></textarea></td>
						  </tr>
						 <tr>
						<td class="FieldLabel2">新闻内容：</td>
						<td class="FieldInput2"><textarea id="newscontent" name="content" style="width:100%;height:360px;"></textarea></td>
						</tr>
							
						</table>
					</form>
			</div>
				
			</div>	
</body>
<script type="text/javascript">
  	$(function(){
  	var strContent;
  	if ($(':input[name="newsid"]').val().length > 0) {
			
			$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/content/getNewsById.do',
   				  		data:{strId:$(':input[name="newsid"]').val()},
   				  		success:function(retr){
   				  			var _data =  eval('(' + retr + ')'); 
   				  			
				  			if (_data[0].newsid != "") {
				  			
					  			$("#newstitle").val(_data[0].newstitle);
					  			$("#newsintroduce").val(_data[0].newsintroduce);
					  			//document.getElementById("newsphotoaddrs").setAttribute("setText",_data[0].newsphotoaddr)
								//$("#newsphotoaddrs").val(_data[0].newsphotoaddr);  
								//$("#newsphotoaddrs").textbox('setText',_data[0].newsphotoaddr);
								$("#newtypeno").val(_data[0].newtypeno);
					  			//$("#newtypeno").combobox('select',_data[0].newtypeno);
					  			
					if (_data[0].newscontent != ""){
						strContent = _data[0].newscontent;
					
					KindEditor.insertHtml('#newscontent', strContent);
					
						}
					}
   				  		}
   				  	});
   				  	
			
			
		}
  		KindEditor.ready(function(K) {
                var editor1 = K.create('#newscontent', {
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
       
  	})
  </script>