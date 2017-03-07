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
		 	 var content = document.getElementById("companystructure").value;
		if ( content.length==0 || content== null || content=="<p>\n\t<br />\n</p>" || content=='') { 
		
			$pjq.messager.alert('提示', '方案架构内容不能为空！', 'info'); 
			
           return false;
            }else{
		 	$('#tableform').form('submit',{
		    url:'${pageContext.request.contextPath}/content/caseshow.do', 
		    onSubmit: function(){

		    },
		    success:function(retr){
		   			var data =  $.parseJSON(retr); 
				  	if(data.success)
					    	{	
					    	
		     var adr='${pageContext.request.contextPath}/icp/portal/case/temp/' + data.msg;
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
  		
  	var submitForm = function($dialog, $grid, $pjq) {
		
		 	submitSave($dialog, $grid, $pjq);
			
	}
	var submitSave = function($dialog, $grid, $pjq){
	if ($('#tableform').form('validate')) {
		 	//$('#saveBtn').linkbutton('disable');
		 	var content = document.getElementById("companystructure").value;
		if ( content.length==0 || content== null || content=="<p>\n\t<br />\n</p>" || content=='') { 
		
			$pjq.messager.alert('提示', '方案架构内容不能为空！', 'info'); 
			
           return false;
            }else{
		 	$('#tableform').form('submit',{
		    url:'${pageContext.request.contextPath}/content/addCustomerCase.do', 
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
			width:80%;
			height:25px;
		    background-color: #FFFFFF;
			font: normal 12px tahoma, arial, helvetica, sans-serif;
		    text-align: left;
		    word-wrap: break-word;
		    padding-top:0px !important;
		    padding-bottom:0px !important;
		    border:#BCD2EE 1px solid !important;  
		}
		.FieldLabel2 {
			width:25%;
			height:25px;
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
						<input id="caseid" name="caseid" value="<%=id%>" type="hidden" />
						<table align="center"  style="width:100%">
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">客户名称：</td>
								<td class="FieldInput2"><input id="customername"
									style="height:30px;width:300px;" name="customername" class="easyui-validatebox"
									data-options="required:true" /><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">方案标题：</td>
								<td class="FieldInput2"><input id="casetitle"
									style="height:30px;width:300px;" name="casetitle" class="easyui-validatebox"
									data-options="required:true" /><font color="red">*</font>
								</td>
							</tr>
							<!--<tr>
								<td class="FieldLabel2" style="border-top:!important;">使用产品：</td>
								<td class="FieldInput2"><input id="products"
									style="height:30px;width:300px;" name="products" class="easyui-validatebox"
									data-options="required:true" /><font color="red">*</font>
								</td>
							</tr>
							--><tr>
								<td class="FieldLabel2">行业类别：</td>
								<td class="FieldInput2"><select id="tradename" name="tradename" style="height:30px;width:300px;">
							    <option value="gmhy">医药卫生行业</option>
							    <option value="jyhy">教育行业</option>
							    <option value="jrhy">民政行业</option>
							    <option value="wshy">公安行业</option>
							    <option value="zfhy">工商行业</option>
							    <option value="hbhy">水利行业</option>
							    <option value="ny">食药监行业</option>
							    <option value="dzhy">电子商务</option>
							    <option value="rjhy">电子政务</option>
					            </select></td>
							</tr>

							<tr>
								<td class="FieldLabel2">客户logo：</td>
								<td class="FieldInput2"><input type="file" id="customerlogo" style="height:30px;width:300px;" name="logo"  
									 /><font color="red">选择一张图片*</font>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2">客户logo路径：</td>
								<td class="FieldInput2"><input id="customerlogolj" style="height:25px;width: 300px !important" name="customerlogolj" readonly/></td>
							</tr>
							<tr>
								<td class="FieldLabel2">方案概述：</td>
								<td class="FieldInput2" ><textarea id="customerintroduce" name="customerintroduce" style="width:100%;height:120px;" 
									class="easyui-validatebox" data-options="required:true"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel2">方案架构：</td>
								<td class="FieldInput2"><textarea id="companystructure" name="companystructure" style="width:100%;height:120px;"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel2">方案价值：</td>
								<td class="FieldInput2"><textarea id="companyvalue" name="companyvalue" style="width:100%;height:120px;"
									class="easyui-validatebox" data-options="required:true"></textarea></td>
							</tr>
						</table>
					</form>
				</div>
				<!-- <div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" id="saveBtn" href="javascript:void(0)" onclick="submitSave();" style="width:80px">确定</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#caseuiwindow').window('close');" style="width:80px">取消</a>
				</div> -->
			</div> 
</body>
<script type="text/javascript">
//$(function(){
  	var strContent;
  	if ($(':input[name="caseid"]').val().length > 0) {
			
			$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/content/getCaseById.do',
   				  		data:{strId:$(':input[name="caseid"]').val()},
   				  		success:function(retr){
   				  			var _data =  eval('(' + retr + ')'); 
				  			if (_data[0].caseid != "") {
				  				$("#customername").val(_data[0].customername);
					  			$("#casetitle").val(_data[0].casetitle);
					  			$("#products").val(_data[0].products);
					  			//$("#tradename option[value='12']").attr("selected",true);
					  			var ops = document.getElementById("tradename");
					  			for(var i=0;i<ops.options.length;i++){
					  				if(ops.options[i].text == _data[0].tradename){
					  					ops.options[i].selected = true;
					  				}
					  			}
					  			//$("#tradename").combobox('select',_data[0].tradename);
					  			//$("#customerlogo").text(_data[0].customerlogo);
					  			$("#customerlogolj").val(_data[0].customerlogo);
					  			$("#customerintroduce").val(_data[0].customerintroduce);
					  			$("#companyvalue").val(_data[0].companyvalue);
					if (_data[0].companystructure != ""){
						strContent = _data[0].companystructure;
					
					KindEditor.insertHtml('#companystructure', strContent);
					
						}
				
					}
   				  		}
   				  	});
		}
  	
  		KindEditor.ready(function(K) {
                var edit1 = K.create('#companystructure', {
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