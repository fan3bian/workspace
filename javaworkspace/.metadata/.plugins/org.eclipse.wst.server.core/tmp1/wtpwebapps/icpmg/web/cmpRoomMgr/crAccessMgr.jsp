<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
	<meta http-equiv="charset" content="iso-8859-1">
<body>
<style type="text/css">
.TicketTitle{
	text-align:left;
	background-color:#F0F8FF;
	border:#BCD2EE 1px solid;
}
.Titlefont{
	text-align:center;
	font-size:20px;
	color:#4048B0;
	font-family:"arial";
}
.FieldInput2 {
	width: 33%;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}

.FieldLabel2 {
	width: 17%;
	height: 25px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
</style>
	<script type="text/javascript">
		Date.prototype.Format = function(fmt)   
		{ //author: meizz   
		  var o = {   
		    "M+" : this.getMonth()+1,                 //月份   
		    "d+" : this.getDate(),                    //日   
		    "H+" : this.getHours(),                   //小时   
		    "m+" : this.getMinutes(),                 //分   
		    "s+" : this.getSeconds(),                 //秒   
		    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
		    "S"  : this.getMilliseconds()             //毫秒   
		  };   
		  if(/(y+)/.test(fmt))   
		    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
		  for(var k in o)   
		    if(new RegExp("("+ k +")").test(fmt))   
		  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
		  return fmt;   
		};
		var idtype_data = [{"value":"1","text":"身份证"},{"value":"2","text":"驾驶证"},{"value":"3","text":"军官证"},{"value":"4","text":"其他"}];
		var toolbar = [
				{
					text : '增加',
					iconCls : 'icon-add',
					handler : function() {
						$("#windowreadFlag").val('1');
						$("#windowreadCardmsg").html('');
						$("#windowcraname").val('');
						$("#windowaccperson").val('');
						$("#windowintime").datetimebox('setValue', (new Date()).Format("yyyy-MM-dd HH:mm:ss"));
						$("#windowentourage").val('');
						$("#windowidtype").val('');
						$("#windowidcard").val('');
						$("#windowunit").val('');
						$("#windowmobile").val('');
						$("#windowduty").val('');
						$("#windowemail").val('');
						$("#windowthing").val('');
						$("#windowgoods").val('');
						$("#windowmark").val('');
						$("#windowidtype").combobox('select','1');
						$("#jpgfile").attr("src",'');
						$('#window').window('open');
					}
				},
				{
					text : '离开',
					iconCls : 'icon-modify',
					handler : function() {
						var rows = $('#dg').datagrid('getChecked');
						if(rows.length!=1)
						{
							$.messager.alert('消息','请选择一条记录！'); 
							return; 
						}
						
						$("#windowreadFlag").val('3');
						$("#windowreadCardmsg").html('');
						$("#windowcraid").val(rows[0].craid);
						$("#windowcraname").val(rows[0].craname);
						$("#windowaccperson").val(rows[0].accperson);
						$("#windowintime").datetimebox('setValue', rows[0].intime);
						$("#windowouttime").datetimebox('setValue', (new Date()).Format("yyyy-MM-dd HH:mm:ss"));
						$("#windowentourage").val(rows[0].entourage);
						$("#windowidtype").combobox('select',rows[0].idtype);
						$("#windowidcard").val(rows[0].idcard);
						$("#windowunit").val(rows[0].unit);
						$("#windowmobile").val(rows[0].mobile);
						$("#windowduty").val(rows[0].duty);
						$("#windowemail").val(rows[0].email);
						$("#windowthing").textbox('setValue',rows[0].thing);
						$("#windowgoods").textbox('setValue',rows[0].goods);
						$("#windowmark").textbox('setValue',rows[0].mark);
						$("#jpgfile").attr("src",'');
						$('#window').window('open');
						}
				},
				{
					text : '刷证进入',
					iconCls : 'icon-movein',
					handler : function() {
						var  pp;
						
						pp=rdcard.ReadCard2();
						if(pp==0)
				        {
					   // document.getElementsByName("tResult")[0].value="ReadCard2成功";
				        }
				        else
				        {	
				        	$.messager.alert('消息','身份证读卡失败，请联系管理员！错误代码：'+pp); 
				        	return;
				           // document.getElementsByName("tResult")[0].value="ReadCard2失败: "+pp;
				        }
				        $("#windowreadFlag").val('2');
				        $("#windowreadCardmsg").html('<font color="red">请将身份证放至读卡器感应区...</font>');
						$("#windowcraname").val('');
						$("#windowaccperson").val('');
						$("#windowintime").datetimebox('setValue', (new Date()).Format("yyyy-MM-dd HH:mm:ss"));
						$("#windowentourage").val('0');
						$("#windowidtype").val('');
						$("#windowidcard").val('');
						$("#windowunit").val('');
						$("#windowmobile").val('');
						$("#windowduty").val('');
						$("#windowemail").val('');
						$("#windowthing").val('');
						$("#windowgoods").val('');
						$("#windowmark").val('');
						$("#windowidtype").combobox('select','1');
						$("#jpgfile").attr("src",'');
						$('#window').window('open');
					}
				},
				{
					text : '刷证离开',
					iconCls : 'icon-moveout',
					handler : function() {
							var  pp;
						
						pp=rdcard.ReadCard2();
						if(pp==0)
				        {
					   // document.getElementsByName("tResult")[0].value="ReadCard2成功";
				        }
				        else
				        {	
				        	$.messager.alert('消息','身份证读卡失败，请联系管理员！错误代码：'+pp); 
				        	return;
				           // document.getElementsByName("tResult")[0].value="ReadCard2失败: "+pp;
				        }
				        $("#windowreadCardmsg").html('<font color="red">请将身份证放至读卡器感应区...</font>');
				         $("#windowreadFlag").val('3');
						$("#windowcraname").val('');
						$("#windowaccperson").val('');
						$("#windowouttime").datetimebox('setValue','');
						$("#windowintime").datetimebox('setValue', '');
						$("#windowentourage").val('0');
						$("#windowidtype").val('');
						$("#windowidcard").val('');
						$("#windowunit").val('');
						$("#windowmobile").val('');
						$("#windowduty").val('');
						$("#windowemail").val('');
						$("#windowthing").val('');
						$("#windowgoods").val('');
						$("#windowmark").val('');
						$("#windowidtype").combobox('select','1');
						$("#jpgfile").attr("src",'');
						$('#window').window('open');
						}
				},
				{
					text : '控件下载',
					iconCls : 'icon-download',
					handler : function() {
							window.open ('${pageContext.request.contextPath}/sysfile/WidgetV1.3.6.4.rar', "", "height=100, width=400, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no"); //写成一行 
						}
				},
				{
					text : '使用配置说明',
					iconCls : 'icon-help',
					handler : function() {
							window.open ('${pageContext.request.contextPath}/sysfile/DocumentV1.0.0.docx', "", "height=100, width=400, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no"); //写成一行 
						}
				}];
		$(document).ready(function() {
			loadDataGrid();
			loadComboData();
		});
		function myclose_onclick(){
		var  pp;
		pp=rdcard.closeport();
		if(pp==0) {
	   // $("#tResult").val("closeport成功");
        }else if(pp==200){
			//$("#tResult").val("读卡失效重新放卡");
		}else
        {	
            //$("#tResult").val("closeport失败: "+pp);
        }		
	}
     function Unload(){
		MyClose_onclick();
		//alert("Page is Close");
	}
		function loadDataGrid() {
			$('#dg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'intime',
								sortOrder : 'desc',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								//idField : 'pid',
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbar,
								url : '${pageContext.request.contextPath}/crMgr/getCRAcesPersnl.do'
							});

		}
		function loadComboData()
		{
			$('#windowidtype').combobox({ 
				data: idtype_data,   
			    valueField:'value',    
			    textField:'text'
			}); 
		}	
		function searchDataGrid() {
		$('#dg').datagrid('load',
				icp.serializeObject($('#paccess_searchform')));
		};
		function typeformater(value, row, index) {
		 	for(var i = 0; i < idtype_data.length; i++){
		        if (idtype_data[i].value == value){
		            return "<span style=\"color:blue\">"+idtype_data[i].text+"</span>";;
		        }
		    }
		    return "";
		} 
		function isNum(s) {
				var regu = "^[0-9]*$";
				//var regu = "^([0-9]*[.0-9])$"; // 小数测试
				var re = new RegExp(regu);
				if (s.search(re) != -1)
					return true;
				else
					return false;
			}
		function submitSave()
		{
	 		$('#paccessform').form('submit',{
		    url:'${pageContext.request.contextPath}/crMgr/processCRAccessPersnl.do', 
		    onSubmit: function(){
		    	if($("#windowcraname").attr("value")==null || $.trim($("#windowcraname").attr("value"))=="" )
		    	{
		    		$.messager.alert('消息',"姓名不能为空!");  
		    		return false;
		    	}
		    	
		    	if($("#windowaccperson").attr("value")==null || $.trim($("#windowaccperson").attr("value"))=="" )
		    	{
		    		$.messager.alert('消息',"陪同人员不能为空!");  
		    		return false;
		    	}
		    	if($("#windowentourage").attr("value")==null || $.trim($("#windowentourage").attr("value"))=="" )
		    	{
		    		$.messager.alert('消息',"人员数量不能为空!");  
		    		return false;
		    	}
		    	if(!isNum($('#windowentourage').val()))
				{
						$.messager.alert('消息',"人员数量必须为数字！");  
		    		return false;
				}
				if($("#windowmobile").attr("value")==null || $.trim($("#windowmobile").attr("value"))=="" )
		    	{
		    		$.messager.alert('消息',"手机号码不能为空!");  
		    		return false;
		    	}
		    	if(!isNum($('#windowmobile').val()))
				{
						$.messager.alert('消息',"手机号码必须为数字！");  
		    		return false;
				}
		    },
		    success:function(retr){
		    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
		    	var _data =  JSON.parse(retr); 
		    	//alert("success: "+_data.success);
		    	$.messager.alert('消息',_data.msg);  
				if(_data.success){
					$('#dg').datagrid('load',
						icp.serializeObject($('#paccess_searchform')));
					myclose_onclick();
					$('#window').window('close');
		    	}
		    }
		});
		}
		 function writeToWindow()
		 {
		 	
		 	if($("#windowreadFlag").val()=='2')
		 	{
			 	 if ($("#windowidcard").val().indexOf(rdcard.CardNo) >= 0)
			    {
			    	
			    }else
			    {
			    if($("#windowcraname").val()!='')
			    {
			    	$("#windowcraname").val(rdcard.NameL+","+$("#windowcraname").val());
			 		$("#windowidcard").val(rdcard.CardNo+","+$("#windowidcard").val());
			    }else
			    {
			    	$("#windowcraname").val(rdcard.NameL);
			 		$("#windowidcard").val(rdcard.CardNo);
			    }
			   
			 	$("#windowentourage").val(($("#windowentourage").val()*1+1));
			    }
		 	}else if($("#windowreadFlag").val()=='3')
		 	{
		 		
		 		$.ajax({
		  		type : 'post',
		  		url:'${pageContext.request.contextPath}/crMgr/getAccInfo.do',
		  		data:{idcard:rdcard.CardNo},
		  		success:function(retr){
		  			var data =  JSON.parse(retr); 
		  			if(data.success)
			    	{
			    		var list = data.obj;
			    		if(list.length==0)
			    		{
			    			$.messager.alert('消息',"没有查到系统录入的进入记录！");  
			    		}else
			    		{
			    			$("#windowcraid").val(list[0].craid);
			    			
							$("#windowcraname").val(list[0].craname);
							$("#windowaccperson").val(list[0].accperson);
							$("#windowintime").datetimebox('setValue', list[0].intime);
							$("#windowouttime").datetimebox('setValue', (new Date()).Format("yyyy-MM-dd HH:mm:ss"));
							$("#windowentourage").val(list[0].entourage);
							$("#windowidtype").combobox('select',list[0].idtype);
							$("#windowidcard").val(list[0].idcard);
							$("#windowunit").val(list[0].unit);
							$("#windowmobile").val(list[0].mobile);
							$("#windowduty").val(list[0].duty);
							$("#windowemail").val(list[0].email);
							$("#windowthing").textbox('setValue',list[0].thing);
							$("#windowgoods").textbox('setValue',list[0].goods);
							$("#windowmark").textbox('setValue',list[0].mark);
			    		}
			    		
			    	} 
			  		}
			  	});
		 	}else
		 	{
		 	
		 	}
		 	$("#jpgfile").attr("src",'data:image/jpeg;base64,' + rdcard.JPGBuffer);
		 }
		 function showSelectWin()
		 {
		 	if($("#windowidcard").val()=='')
		 	{
		 		$.messager.alert('消息',"证件号码不能为空");  
		 		return;
		 	}
		 	$.ajax({
	  		type : 'post',
	  		url:'${pageContext.request.contextPath}/crMgr/getAccperson.do',
	  		data:{idcard:$("#windowidcard").val()},
	  		success:function(retr){
	  			var data =  JSON.parse(retr); 
	  			if(data.success)
		    	{
		    		var list = data.obj;
		    		if(list.length==0)
		    		{
		    			$.messager.alert('消息',"没有查到系统录入的陪同人员！");  
		    		}else
		    		{
						$("#windowaccperson").val(list[0].crpname);
						$("#windowunit").val(list[0].unit);
						$("#windowmobile").val(list[0].mobile);
						$("#windowduty").val(list[0].duty);
						$("#windowemail").val(list[0].email);
		    		}
		    		
		    	} 
		  		}
		  	});
		 }
	</script>
	<script for=idcard event="Readed()">
      //alert('Readed');
      writeToWindow();
	</script>
	<OBJECT
	  classid="clsid:F1317711-6BDE-4658-ABAA-39E31D3704D3"                  
	  codebase="SDRdCard.cab#version=1,3,6,4"
	  align="center"
	  hspace="0"
	  vspace="0"
	  style="display:none"
	  id="idcard"
	  name="rdcard">
	</OBJECT>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height:30px;overflow:hidden;">
			<form id="paccess_searchform">
				<table>
					<tr>
							<td>名称：<input class="easyui-textbox" name="craname" data-options="prompt:'姓名/手机号/证件号码'" style="width:180px;height:28px;border:false"></td>
							<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#paccess_searchform input').val('');$('#dg').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table title="" style="width:100%;" id="dg">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'craname',width:60,align:'center'">姓名</th>
						<th data-options="field:'entourage',width:20,align:'center'">人数</th>
						<th data-options="field:'idtype',width:40,align:'center',formatter:typeformater">证件类型</th>
						<th data-options="field:'idcard',width:60,align:'center'">证件号码</th>
						<th data-options="field:'intime',width:60,align:'center'">进入时间</th>
						<th data-options="field:'outtime',width:60,align:'center'">离开时间</th>
						<th data-options="field:'entourage',width:60,align:'center'">陪同人员</th>
						<th data-options="field:'unit',width:60,align:'center'">单位部门</th>
						<th data-options="field:'mobile',width:50,align:'center'">手机号码</th>
						<th data-options="field:'thing',width:60,align:'center'">事由</th>
						<th data-options="field:'goods',width:60,align:'center'">携带物品</th>
						<th data-options="field:'mark',width:60,align:'center'">备注</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	
	<div id="window" class="easyui-window" title="信息登记" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:800px;height:540px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="paccessform" method="post">
						<input id="windowcraid" name="craid" type="hidden" value="0" />
						<input id="windowreadFlag" name="readFlag" type="hidden" value="0" />
						<table  style="width:100%">
							<caption id="windowreadCardmsg" class="TicketTitle"><font color="red"></font></caption>
						</table>
						<table align="center" style="width:100%">
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									姓名：</td>
								<td class="FieldInput2"><input id="windowcraname" name="craname" style="height:30px" /><font color="red">*</font>
								</td>
								
							</tr>
								<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									陪同人员：</td>
								<td class="FieldInput2"><input id="windowaccperson" name="accperson" style="height:30px" /><font color="red">*</font>
									<a href="#" id="searchData" onClick="javascript:showSelectWin();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
								</td>
								<td class="FieldLabel2" style="border-top:!important;">
									人员数量：</td>
								<td class="FieldInput2"><input id="windowentourage" name="entourage" style="height:30px" /><font color="red">*</font>
								</td>
							</tr>
							<tr>
							<td class="FieldLabel2" style="border-top:!important;">
									进入时间：</td>
								<td class="FieldInput2"><input id="windowintime" name="intime" style="height:30px;width:150px"  class="easyui-datetimebox"  readonly/><font color="red">*</font>
								</td>
								<td class="FieldLabel2" style="border-top:!important;">
									离开时间：</td>
								<td class="FieldInput2"><input id="windowouttime" name="outtime" style="height:30px;width:150px"  class="easyui-datetimebox"  readonly/>
								</td>
							</tr>	
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									证件类型：</td>
								<td class="FieldInput2"><input id="windowidtype" name="idtype" style="height:30px" />
								</td>
								<td class="FieldLabel2" style="border-top:!important;">
									证件号码：</td>
								<td class="FieldInput2"><input id="windowidcard" name="idcard" style="height:30px" /><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									单位：</td>
								<td class="FieldInput2"><input id="windowunit" name="unit" style="height:30px" />
								</td>
								<td class="FieldLabel2" style="border-top:!important;">
									职务：</td>
								<td class="FieldInput2"><input id="windowduty" name="duty" style="height:30px" />
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									手机号码：</td>
								<td class="FieldInput2"><input id="windowmobile" name="mobile" style="height:30px" /><font color="red">*</font>
								</td>
								<td class="FieldLabel2" style="border-top:!important;">
									邮箱：</td>
								<td class="FieldInput2"><input id="windowemail" name="email" style="height:30px" />
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									事由：</td>
								<td class="FieldInput2"><input id="windowthing"
									style="height:75px;width: 210px" name="thing" class="easyui-textbox" data-options="multiline:true" /><font color="red">*</font></td>
								<td class="FieldLabel2" style="border-top:!important;">
									头像：</td>
								<td class="FieldInput2"><img height="126px" alt="" width="102px" border=0 name="photo" id="jpgfile" style="left:10px;" /></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									携带物品：</td>
								<td class="FieldInput2"><input id="windowgoods"
									style="height:75px;width: 220px" name="goods" class="easyui-textbox" data-options="multiline:true" /></td>
								<td class="FieldLabel2" style="border-top:!important;">
									备注：</td>
								<td class="FieldInput2"><input id="windowmark"
									style="height:75px;width: 220px" name="mark" class="easyui-textbox" data-options="multiline:true" /></td>
							</tr>
						</table>
					</form>
				</div>
				<div data-options="region:'south',border:false"
					style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
						id="saveBtn" href="javascript:void(0)" onclick="submitSave();"
						style="width:80px">确定</a> <a class="easyui-linkbutton"
						data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
						onclick="myclose_onclick();$('#window').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
</body>