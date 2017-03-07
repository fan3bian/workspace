<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
	<div id="slw1" class="pop" >
       <div style="padding: 20px 150px 100px 150px;background-color: #ffffff">
       	  <table style="width:100%;border:0;" class="table-layout">
       	  	 <tr>
       	  	 	<td width="20%" align="left">
       				<div class="item-box">
                     	<!-- 开关按钮 -->
                     	<div class="yswitch yswitch-primary" id="alllogSwitchDiv">
                     		请选择需要启用的项目 &nbsp;&nbsp; <input type="checkbox" id="logSwitchAll"><label for="logSwitchAll" onclick="switchBtns('all')"></label>
                     	</div>
                 	</div>
                 </td>
                 <td width="50%" align="left">
                 	<label id='alllogSwitch'>全部禁用</label>
                 </td>
               </tr>
            </table>

            <div class="item2">
                <table style="width:100%;border:0;" cellpadding="0" cellspacing="0" class="table-layout">
                    <tr>
                    	<td  width="15%" align="center"><strong>事件日志</strong><td>
						<td width="15%" align="right">
						
							<div class="item-box">
								<div class="yswitch yswitch-primary" id="eventDiv">
									<input type="checkbox" id="eventlogSwitch"><label	for="eventlogSwitch" onclick="switchBtns('event')"></label>
								</div>
							</div>
						</td>
						<td width="10%" align="left">
							<div style="border-right: 1px solid #ddd;">
								<label	id="eventlogSwitchLabel">禁用</label>
							</div>
						</td>
						<td width="60%" align="center">
                           <label> 最小日志级别：</label>
                           <select id="eventloglev" class="easyui-combobox"
								data-options="panelHeight:'auto',width:140,editable:false"
								style="width: 174px;">
								<option value="0">紧急</option>
								<option value="1">警报</option>
								<option value="2">严重</option>
								<option value="3">错误</option>
								<option value="4">警告</option>
								<option value="5">通告</option>
								<option value="6">信息</option>
								<option value="7">调试</option>
							</select>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="item2">
                <table style="width:100%;border:0;" class="table-layout">
                    <tr>
                    	<td  width="15%" align="center"><strong>威胁日志</strong><td>
						<td width="15%" align="right">
							<div class="item-box">
								<div class="yswitch yswitch-primary" id="threatlogSwitchDiv">
									<input type="checkbox" id="threatlogSwitch"><label
										for="threatlogSwitch" onclick="switchBtns('threat')"></label>
								</div>
							</div>
						</td>
						<td width="10%" align="left">
							<div style="border-right: 1px solid #ddd;">
								<label	id="threatlogSwitchLabel">禁用</label>
							</div>
						</td>
						<td width="60%" align="center">
                           <label> 最小日志级别：</label>
                           <select id="threatloglev" class="easyui-combobox"
								data-options="panelHeight:'auto',width:140,editable:false"
								style="width: 174px;">
								<option value="2">严重</option>
								<option value="4">警告</option>
								<option value="6">信息</option>
							</select>
                        </td>
                    </tr>
                </table>
            </div>
            
             <div class="item2">
                <table style="width:100%;border:0;border-collapse:separate; border-spacing:0px 25px;" class="table-layout">
                    <tr>
                        <td width="15%"  align="center">
                        	<strong>会话日志</strong>
                        </td>
                        <td width="15%" align="right">
                        	<div class="item-box">
								<div class="yswitch yswitch-primary" id="sessionlogSwitchDiv">
									<input type="checkbox" id="sessionlogSwitch"><label
										for="sessionlogSwitch" onclick="switchBtns('session')"></label>
								</div>
							</div>
						 </td>
						 <td width="20%" align="left">
						 	<label	id="sessionlogSwitchLabel">禁用</label>
						 </td>
						 
                        <td width="15%"  align="right">
                        	<strong>NAT日志</strong>
                        </td>
                        <td width="15%" align="right">
                        	<div class="item-box">
								<div class="yswitch yswitch-primary" id="natlogSwitchDiv">
									<input type="checkbox" id="natlogSwitch"><label
										for="natlogSwitch" onclick="switchBtns('nat')"></label>
								</div>
							</div>
                        </td>
                        <td width="20%" align="left">
						 	<label	id="natlogSwitchLabel">禁用</label>
						 </td>
                        
                    </tr>
                    
                    <tr>
                        <td width="15%"  align="center">
                        	<strong>URL日志</strong>
                        </td>
                        <td width="15%" align="right">
                        	<div class="item-box">
								<div class="yswitch yswitch-primary" id="urllogSwitchDiv">
									<input type="checkbox" id="urllogSwitch"><label
										for="urllogSwitch" onclick="switchBtns('url')"></label>
								</div>
							</div>
						 </td>
						 <td width="20%" align="left">
						 	<label	id="urllogSwitchLabel">禁用</label>
						 </td>
                        <td width="15%"  align="right">
                        	<strong>NBC日志</strong>
                        </td>
                        <td width="15%" align="right">
                        	<div class="item-box">
								<div class="yswitch yswitch-primary" id="nbclogSwitchDiv">
									<input type="checkbox" id="nbclogSwitch"><label
										for="nbclogSwitch" onclick="switchBtns('nbc')"></label>
								</div>
							</div>
                        </td>
                        <td width="20%" align="left">
						 	<label	id="nbclogSwitchLabel">禁用</label>
						 </td>
                    </tr>
                    
                     <tr>
                        <td width="15%"  align="center">
                        	<strong>网络日志</strong>
                        </td>
                        <td width="15%" align="right">
                        	<div class="item-box">
								<div class="yswitch yswitch-primary" id="networklogSwitchDiv">
									<input type="checkbox" id="networklogSwitch"><label
										for="networklogSwitch" onclick="switchBtns('network')"></label>
								</div>
							</div>
						 </td>
						 <td width="20%" align="left">
						 	<label	id="networklogSwitchLabel">禁用</label>
						 </td>
                        <td width="15%"  align="right">
                        	<strong>配置日志</strong>
                        </td>
                        <td width="15%" align="right">
                        	<div class="item-box">
								<div class="yswitch yswitch-primary" id="configlogSwitchDiv">
									<input type="checkbox" id="configlogSwitch"><label
										for="configlogSwitch" onclick="switchBtns('config')"></label>
								</div>
							</div>
                        </td>
                        <td width="20%" align="left">
						 	<label	id="configlogSwitchLabel">禁用</label>
						 </td>
                    </tr>
                    
                </table>
            </div>
             
            <br/>
            <table style="width:100%;border:0;" class="table-layout">
            	<tr>
            		<td width="100%" align="center">
            			 <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-ok" onclick="submitMonitorTypeConf()" style="width: 80px;">提交</a> &nbsp;&nbsp;&nbsp;
            			 <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="initLogType()" style="width: 80px;" >取消</a> 
            		</td>
            	</tr>
            </table>
			</form>
		</div>
	  </div>
	  
	  
	  <script type="text/javascript">
	  
       $(document).ready(function() {
			initLogTypeDate();
		});
	var data;
	 function initLogTypeDate(){
	 
	 	 $.ajax({
               type: "POST",
               url: "${pageContext.request.contextPath}/security/initMonitorLogConf.do",
               data: {securityid:$("#tabs_security_id").val()},
               dataType: "json", 
               success: function(vdata){
               		data = vdata;
               		initLogType();
               		
               }
            });
	 
		}
     
     
	 function switchBtns(id){
	 	if(id=='all'){
	 		if($("#logSwitchAll").attr("checked")){
	 			$("[id$='logSwitch']").each(function(){
	 				$(this).attr("checked", false);
	 			});
	 			$("[id$='logSwitchLabel']").each(function(){
	 				$(this).html("禁用");
	 			});
	 			$("#alllogSwitch").html("全部禁用");
	 			
	 		}else{
	 			$("[id$='logSwitch']").each(function(){
	 				$(this).attr("checked", true);
	 			});
	 			$("[id$='logSwitchLabel']").each(function(){
	 				$(this).html("启用");
	 			});
	 			$("#alllogSwitch").html("全部启用");
	 		}
	 	}
	 	
	 	if($("#"+id+"logSwitch").attr("checked")){
	 		$("#"+id+"logSwitchLabel").html("禁用");
	 	}
	 	else{
	 		$("#"+id+"logSwitchLabel").html("启用");	 	
	 	}
	 }
	 
	 
	 function submitMonitorTypeConf(){
	 
	 	var eventlog =  $("#eventlogSwitch").attr("checked")?'1':'0';
	 	var networklog=  $("#networklogSwitch").attr("checked")?'1':'0';
	 	var configlog=  $("#configlogSwitch").attr("checked")?'1':'0';
	 	var sessionlog=  $("#sessionlogSwitch").attr("checked")?'1':'0';
	 	var natlog=  $("#natlogSwitch").attr("checked")?'1':'0';
	 	var urllog=  $("#urllogSwitch").attr("checked")?'1':'0';
	 	var nbclog=  $("#nbclogSwitch").attr("checked")?'1':'0';
	 	var threatlog=  $("#threatlogSwitch").attr("checked")?'1':'0';
	 	var eventloglev = $('#eventloglev').combobox('getValue');
	 	var threatloglev = $('#threatloglev').combobox('getValue');
	 	
	 	$.ajax({
               type: "POST",
               url: "${pageContext.request.contextPath}/security/updateLogTypeInfo.do",
               data: {
               			securityid:$("#tabs_security_id").val(),
               			objectid:$("#tabs_object_id").val(),
               			displayname:$("#tabs_displayname").val(),
               			manageip:$("#tabs_manip").val(),
               			eventlog: eventlog,
	 					networklog : networklog,
	 					configlog : configlog,
	 					sessionlog : sessionlog,
	 					natlog : natlog,
	 					urllog : urllog,
	 					nbclog : nbclog ,
	 					threatlog : threatlog,
	 					eventloglev:eventloglev,
	 					threatloglev:threatloglev
               },
               dataType: "json", 
               success: function(data){
					if (data.result) {
						$.messager.alert('提示信息', '修改成功','info');
					} else {
						if(data.msg!=null){
							$.messager.alert('提示信息', '修改发生错误'+data.msg,'error');
						}else{
							$.messager.alert('提示信息', '修改发生错误！！','error');
						}
					}
               },
              error: function(data){
				   $.messager.alert('提示信息', '修改发生错误','error');
               }
            });
	 }
	 
	 function initLogType(){
	 	if(data.logConf==null)
        	return;
               			
        $('#eventloglev').combobox('setValue',data.logConf.eventloglev); 
        $('#threatloglev').combobox('setValue',data.logConf.threatloglev); 
               		
        if(data.logConf.eventlog=='1'){
        	$('#eventlogSwitch').attr("checked", true);
        	$('#eventlogSwitchLabel').html("启用");
        }else{
        	$('#eventlogSwitch').attr("checked", false);
        	$('#eventlogSwitchLabel').html("禁用");
        }
        if(data.logConf.networklog=='1'){
        	$('#eventlogSwitch').attr("checked", true);
        	$('#eventlogSwitchLabel').html("启用");
        }else{
        	$('#eventlogSwitch').attr("checked", false);
        	$('#eventlogSwitchLabel').html("禁用");
        }
        if(data.logConf.configlog=='1'){
        	$('#configlogSwitch').attr("checked", true);
        	$('#configlogSwitchLabel').html("启用");
        }else{
        	$('#configlogSwitch').attr("checked", false);
        	$('#configlogSwitchLabel').html("禁用");
        }
        if(data.logConf.sessionlog=='1'){
        	$('#sessionlogSwitch').attr("checked", true);
        	$('#sessionlogSwitchLabel').html("启用");
        }else{
        	$('#sessionlogSwitch').attr("checked", false);
        	$('#sessionlogSwitchLabel').html("禁用");
        }
        if(data.logConf.natlog=='1'){
        	$('#natlogSwitch').attr("checked", true);
        	$('#natlogSwitchLabel').html("启用");
        }else{
        	$('#natlogSwitch').attr("checked", false);
        	$('#natlogSwitchLabel').html("禁用");
        }
        if(data.logConf.urllog=='1'){
        	$('#urllogSwitch').attr("checked", true);
        	$('#urllogSwitchLabel').html("启用");
        }else{
        	$('#urllogSwitch').attr("checked", false);
        	$('#urllogSwitchLabel').html("禁用");
        }
        if(data.logConf.nbclog=='1'){
        	$('#nbclogSwitch').attr("checked", true);
        	$('#nbclogSwitchLabel').html("启用");
        }else{
        	$('#nbclogSwitch').attr("checked", false);
        	$('#nbclogSwitchLabel').html("禁用");
        }
        if(data.logConf.threatlog=='1'){
        	$('#threatlogSwitch').attr("checked", true);
         	$('#threatlogSwitchLabel').html("启用");
        }else{
        	$('#threatlogSwitch').attr("checked", false);
        	$('#threatlogSwitchLabel').html("禁用");
        }
	 }
	  
	  
	  
	  </script>	
		
</body>

