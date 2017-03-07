<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
<style type="text/css">
.product-product-close {
  position: absolute;
  top: 50%;
  margin-top: -8px;
  height: 16px;
  overflow: hidden;
  background: url('${pageContext.request.contextPath}/easyui-1.4/themes/default/images/panel_tools.png') no-repeat -16px 0px;
}

.FieldLabel1 {
	width: 172px;
	height: 30px;
	background-color: #ccc;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #CCC 1px dotted !important;
	
	color:#fff;
}

.FieldLabel2 {
	width: 402px;
	height: 30px;
	background-color: #ccc;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #CCC 1px dotted !important;
	color:#fff;
}

.FieldInput {
	width: 172px;
	height: 30px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #CCC 1px dotted !important;
}

.FieldLabel3 {
	width: 172px;
	height: 30px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #CCC 1px dotted !important;
}

.FieldLabel4 {
	width: 402px;
	height: 30px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #CCC 1px dotted !important;
}

</style>

<script type="text/javascript">

$('#scorevalue1').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>10)
			  {
			    	$.messager.alert('提示',"请评小于10分！");
			  }
			    
			 if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }   
	    }    
}); 

$('#scorevalue2').numberbox({          
	    
	    onChange:function(value){
	    
		    if(value>5)
		     {
		    	$.messager.alert('提示',"请评小于5分！");
		     }
			    
		    if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }      
	    }    
});

$('#scorevalue3').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>5)
			    {
			    	$.messager.alert('提示',"请评小于5分！");
			    }
			if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }         
	    }    
}); 

$('#scorevalue4').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>5)
			    {
			    	$.messager.alert('提示',"请评小于5分！");
			    }
			    
			if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }         
	    }    
}); 

$('#scorevalue5').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>5)
			    {
			    	$.messager.alert('提示',"请评小于5分！");
			    }
			if(value<0)
				 {
				 		$.messager.alert('提示',"请评大于0分！");
				 }         
			       
	    }    
});

$('#scorevalue6').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>5)
			    {
			    	$.messager.alert('提示',"请评小于5分！");
			    }
			  if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }         
			       
	    }    
});

$('#scorevalue7').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>5)
			    {
			    	$.messager.alert('提示',"请评小于5分！");
			    }
			     if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }         
	    }    
}); 
   
$('#scorevalue8').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>5)
			    {
			    	$.messager.alert('提示',"请评小于5分！");
			    }
			     if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }         
	    }    
});  

$('#scorevalue9').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>5)
			    {
			    	$.messager.alert('提示',"请评小于5分！");
			    }
			     if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }         
	    }    
}); 

$('#scorevalue10').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>10)
			    {
			    	$.messager.alert('提示',"请评小于10分！");
			    } 
			     if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }        
	    }    
}); 

$('#scorevalue11').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>10)
			    {
			    	$.messager.alert('提示',"请评小于10分！");
			    } 
			     if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }        
	    }    
}); 

$('#scorevalue12').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>10)
			    {
			    	$.messager.alert('提示',"请评小于10分！");
			    } 
			     if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }        
	    }    
}); 

$('#scorevalue13').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>5)
			    {
			    	$.messager.alert('提示',"请评小于5分！");
			    } 
			     if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }        
	    }    
}); 

$('#scorevalue14').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>5)
			    {
			    	$.messager.alert('提示',"请评小于5分！");
			    }  
			     if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }       
	    }    
}); 

$('#scorevalue15').numberbox({          
	    
	    onChange:function(value){
	    	    
		    if(value>10)
			    {
			    	$.messager.alert('提示',"请评小于10分！");
			    }   
			     if(value<0)
			 {
			 		$.messager.alert('提示',"请评大于0分！");
			 }      
	    }    
}); 
function submitSave()
			{		 				 	
	 			document.getElementById('score').value = parseInt(document.getElementById('scorevalue1').value)
	 			+parseInt(document.getElementById('scorevalue2').value)
	 			+parseInt(document.getElementById('scorevalue3').value)
	 			+parseInt(document.getElementById('scorevalue4').value)
	 			+parseInt(document.getElementById('scorevalue5').value)
	 			+parseInt(document.getElementById('scorevalue6').value)
	 			+parseInt(document.getElementById('scorevalue7').value)
	 			+parseInt(document.getElementById('scorevalue8').value)
	 			+parseInt(document.getElementById('scorevalue9').value)
	 			+parseInt(document.getElementById('scorevalue10').value)
	 			+parseInt(document.getElementById('scorevalue11').value)
	 			+parseInt(document.getElementById('scorevalue12').value)
	 			+parseInt(document.getElementById('scorevalue13').value)
	 			+parseInt(document.getElementById('scorevalue14').value)
	 			+parseInt(document.getElementById('scorevalue15').value)
	 			;
					 			
				
	
				$('#scoreinfoform').form('submit',{
			    url:'${pageContext.request.contextPath}/scoreinfoMg/scoresubmit.do',
			    onSubmit: function(){
			    
			    var scorevalue1 = $("#scorevalue1").textbox('getValue');		    	
		    	var scorevalue2 = $("#scorevalue2").textbox('getValue');
		    	var scorevalue3 = $("#scorevalue3").textbox('getValue');
		    	var scorevalue4 = $("#scorevalue4").textbox('getValue');
		    	var scorevalue5 = $("#scorevalue5").textbox('getValue');		    	
		    	var scorevalue6 = $("#scorevalue6").textbox('getValue');
		    	var scorevalue7 = $("#scorevalue7").textbox('getValue');
		    	var scorevalue8 = $("#scorevalue8").textbox('getValue');
		    	var scorevalue9 = $("#scorevalue9").textbox('getValue');		    	
		    	var scorevalue10 = $("#scorevalue10").textbox('getValue');
		    	var scorevalue11 = $("#scorevalue11").textbox('getValue');
		    	var scorevalue12 = $("#scorevalue12").textbox('getValue');
		    	var scorevalue13 = $("#scorevalue13").textbox('getValue');		    	
		    	var scorevalue14 = $("#scorevalue14").textbox('getValue');
		    	var scorevalue15 = $("#scorevalue15").textbox('getValue');
		    	
		    	if(""==scorevalue1 || null==scorevalue1){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue2 || null==scorevalue2){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue3 || null==scorevalue3){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue4 || null==scorevalue4){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue5 || null==scorevalue5){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue6 || null==scorevalue6){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue7 || null==scorevalue7){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue8 || null==scorevalue8){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue9 || null==scorevalue9){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue10 || null==scorevalue10){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue11 || null==scorevalue11){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue12 || null==scorevalue12){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	             if(""==scorevalue13 || null==scorevalue13){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue14 || null==scorevalue14){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	            
	            if(""==scorevalue15 || null==scorevalue15){ 
	                $.messager.alert('提示',"有没评分的项！"); 
	                return false;
	            }
	    
			    	
			    },
			    success:function(retr){
			    	$('#saveBtn').linkbutton('disable');
			    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
			     	var _data =  JSON.parse(retr); 
			    	//alert("success: "+_data.success);
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('reload',icp.serializeObject($('#funcmgr_searchform')));
						$('#dg').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
			    	} 
			    	
					$('#w').window('close');
			    }
			});		 		
			
			}

</script>
	
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">		
		<div data-options="region:'center',border:false" style="background:#eee;width:100%;">
			<form id="scoreinfoform" method="post" enctype="multipart/form-data">
			<div class="detail-line" style="margin: 0px 0px 10px">
						
						<span style="margin-left: 0px">
							<select class="easyui-combobox" style="width:200px;height:30px" name="userunitnametype" id="userunitnametype">
								<option value="1">电子政务云服务用户满意度评价</option>
					           
		      				</select>
						</span>
						<span style="margin-left: 5px">
							评价年度：
						</span>
						<span style="margin-left: 5px">
							<select class="easyui-combobox" style="width:200px;height:30px" name="scoreyeartype" id="scoreyeartype">
								<option value="1">2016</option>
								<option value="2">2017</option>
								<option value="3">2018</option>
								<option value="4">2019</option>
								<option value="5">2020</option>					           
		      				</select>
						</span>
						
			</div>
					<%--
			
				总分：<input id="score" name="score" value=""/>
				
				--%>
				<table align="center" style="width:100%">
					<tr>
						<td class="FieldLabel1" >类别</td>
						<td class="FieldLabel2" >指标及描述</td>
						<td class="FieldLabel2" >评分细则</td>
						<td class="FieldLabel1">得分</td>
					</tr>
						
					<tr>
						<td class="FieldLabel3" >总体满意度(10)</td>
						<td class="FieldLabel4" >对电子政务云服务使用的总体满意度。</td>
						<td class="FieldLabel4" >很满意：10分；较满意：8分；一般：6分；不满意：4分；</td>
						<td class="FieldInput"><input id="scorevalue1" name="scorevalue1" style="width:100%;height:30px;"/></td>		
					</tr>
					
					<tr>
						<td class="FieldLabel3" rowspan="8">服务质量感知(40)</td>
						<td class="FieldLabel4"  >电子政务云服务是否满足了日常政务工作的需求。</td>
						<td class="FieldLabel4" >完全满足：5分；基本满足：4分；部分满足：3；不满足：2分；</td>
						<td class="FieldInput"><input id="scorevalue2" name="scorevalue2" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >电子政务云服务是否节约了工作时间（和非云服务时期比较）</td>
						<td class="FieldLabel4"  >节约很多时间：5分；节约较多时间：4分；节约较少时间：3分；没有节约：2分；</td>
						<td class="FieldInput"><input id="scorevalue3" name="scorevalue3" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >电子政务云服务系统的稳定性。</td>
						<td class="FieldLabel4"  >很好：5分；较好：4分；一般：3分；较差：2分；很差：1分；</td>
						<td class="FieldInput"><input id="scorevalue4" name="scorevalue4" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >电子政务云服务系统网络连接以及系统相应的速度。</td>
						<td class="FieldLabel4"  >很快：5分；较快：4分；一般：3分；慢：2分；</td>
						<td class="FieldInput"><input id="scorevalue5" name="scorevalue5" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >网络是否频繁终端，中断后是否及时恢复。</td>
						<td class="FieldLabel4"  >无中断：5分；偶尔中断但恢复很快：4分；偶尔中断但恢复较慢：3分；经常中断：2分；</td>
						<td class="FieldInput"><input id="scorevalue6" name="scorevalue6" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >电子政务云服务系统是否易用，操作是否便捷。</td>
						<td class="FieldLabel4"  >很好：5分；较好：4分；一般：3分；差：2分；</td>
						<td class="FieldInput"><input id="scorevalue7" name="scorevalue7" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >服务人员的服务态度是否用友好</td>
						<td class="FieldLabel4"  >很好：5分；较好：4分；一般：3分；差：2分；</td>
						<td class="FieldInput"><input id="scorevalue8" name="scorevalue8" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >服务的专业性、规范性和解决问题的能力</td>
						<td class="FieldLabel4"  >很专业：5分；较专业：4分；一般：3分；差：2分；</td>
						<td class="FieldInput"><input id="scorevalue9" name="scorevalue9" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel3" rowspan="3">安全感知(30)</td>
						<td class="FieldLabel4"  >对云服务系统安全性的感知。</td>
						<td class="FieldLabel4" >很安全：10分；较安全：8分；一般：6分；较差：4分；</td>
						<td class="FieldInput"><input id="scorevalue10" name="scorevalue10" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >对云服务系统中数据安全的感知。</td>
						<td class="FieldLabel4"  >很安全：10分；较安全：8分；一般：6分；较差：4分；</td>
						<td class="FieldInput"><input id="scorevalue11" name="scorevalue11" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >对云服务系统中系统权限保护的感知。</td>
						<td class="FieldLabel4"  >很合理：10分；较合理：8分；一般：6分；较差：4分；</td>
						<td class="FieldInput"><input id="scorevalue12" name="scorevalue12" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel3" rowspan="3">抱怨和投诉(20)</td>
						<td class="FieldLabel4"  >对电子政务云服务系统的抱怨。</td>
						<td class="FieldLabel4" >没有：5分；较少：4分；一般：3分；较多：2分；</td>
						<td class="FieldInput"><input id="scorevalue13" name="scorevalue13" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >对电子政务云服务的投诉是否频繁</td>
						<td class="FieldLabel4"  >没有：5分；较低：4分；一般：3分；较高：2分；</td>
						<td class="FieldInput"><input id="scorevalue14" name="scorevalue14" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >是否愿意继续使用该电子政务云服务</td>
						<td class="FieldLabel4"  >很愿意：10分；愿意：8分；一般：6分；不愿意：4分；</td>
						<td class="FieldInput"><input id="scorevalue15" name="scorevalue15" style="width:100%;height:30px;"/></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel3" >总分(100)</td>
						<td class="FieldLabel4" ></td>
						<td class="FieldLabel4" ></td>
						<td class="FieldInput"><input id="score" name="score" value="" type="hidden" style="width:100%;height:20px;"/></td>		
					</tr>	
										
				</table>				
			</form>				
			<div data-options="region:'center',border:false"
					style="text-align:center;padding:10px 0 50px;">
					<a class="easyui-linkbutton" 
						id="saveBtn" href="javascript:void(0)" onclick="submitSave();"
						style="width:80px">提交</a> 
			</div>
		</div>
		
	</div>	
	</body>

