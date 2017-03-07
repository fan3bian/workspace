<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
	<div id="logServerManage" class="pop" >
       <div style="padding: 20px 150px 100px 150px;background-color: #ffffff">
            <div class="item2">
                <div class="item-title">基本信息</div>
                <table style="width:100%;border:0;" class="table-layout">
                    <tr>
                        <td width="25%" align="right">
                            <label align="left">主机名称：</label>
                        </td>
                        
                        <td width="75%" align="left">
                         	<input type="text" id="loghost" class="easyui-textbox" style="width: 250px;">&nbsp;&nbsp;
                         	<label>(A.B.C.D)/(1-255字符)</label>
                        </td>
                    </tr>
                    <tr>
                       <td width="25%" align="right">
                          <label align="left">协议：</label>
                        </td>
                        <td width="75%" align="left">
                         	<select id="logprotocol" class="easyui-combobox"
								data-options="panelHeight:'auto',editable:false,onSelect: function(rec){protocolChange(rec.value)}" 
								style="width: 250px;">
								<option value="0">UDP</option>
								<option value="1">TCP</option>
								<option value="2">Secure-TCP</option>
							</select>
                        </td>
                    </tr>
                    
                     <tr>
                        <td width="25%" align="right">
                            <label align="left">端口：</label>
                        </td>
                        
                        <td width="75%" align="left">
                         	<input type="text" id="logport" class="easyui-textbox" style="width: 250px;">&nbsp;&nbsp;
                         	<label>(1-25535)</label>
                        </td>
                    </tr>
                    
                   
                     	<tr id="servercertcheckTr">
                       	 	<td width="25%" align="right">
                            		<label align="left">不验证服务器证书：</label>
                        	</td>
                        
                        	<td width="75%" align="left">
                         			<input type="checkbox" id="servercertcheck" >
                        	</td>
                    	</tr>
                    
                    
                </table>
            </div>
             <div class="item2">
                <div class="item-title">日志类型</div>
                <table style="width:100%;border:0;" class="table-layout">
                    <tr>
                        <td width="25%" rowspan="3" align="center">
                            <div style="border-right: 1px solid #ddd;    padding: 30px 10px 30px 0;    margin: 0 0px 0 6px;"> <a href="javascript:void(0)" id="allopen"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle" onclick="selectAllLog()">全选</a></div>
                        </td>
                        
                        <td width="75%" align="center">
                         	<a href="javascript:void(0)" id="eventlog"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">事件日志</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="javascript:void(0)" id="configlog"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">配置日志</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="javascript:void(0)" id="networklog"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">网络日志</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="javascript:void(0)" id="sessionlog"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">会话日志</a>
                        </td>
                    </tr>
                    <tr>
                        <td width="75%" align="center">
                          <a href="javascript:void(0)" id="natlog"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">NAT日志</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          <a href="javascript:void(0)" id="urllog"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">URL日志</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          <a href="javascript:void(0)" id="nbclog"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">NBC日志</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          <a href="javascript:void(0)" id="threatlog"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">威胁日志</a>
                        </td>
                    </tr>
                </table>
            </div>
            <br/>
            <table style="width:100%;border:0;" class="table-layout">
            	<tr>
            		<td width="100%" align="center">
            			 <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-ok" onclick="updateLogServerInfo()" style="width: 80px;">提交</a> &nbsp;&nbsp;&nbsp;
            			 <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="initLogServer()" style="width: 80px;" >取消</a> 
            		</td>
            	</tr>
            </table>
		</div>
	  </div>
	  
	  <script type="text/javascript">
	  
	  $(document).ready(function() {
			initLogServerDate();
		});
		
	var data;
		
	 function initLogServerDate(){
	 
	 	$("#servercertcheckTr").hide();  
	 	 $.ajax({
               type: "POST",
               url: "${pageContext.request.contextPath}/security/initMonitorLogConf.do",
               data: {securityid:$("#tabs_security_id").val()},
               dataType: "json", 
               success: function(vdata){
               		data = vdata;
               		initLogServer();
               }
            });
	 
		}
		
	function updateLogServerInfo(){
		var logprotocol = $('#logprotocol').combobox('getValue');
		var logport = $("#logport").val();
		var loghost = $("#loghost").val();
		var servercertcheck = $("#servercertcheck").attr("checked")?'1':'0';
		var logtypes = 	getLogTypes();
		
		if(!isIP(loghost)){
			$.messager.alert('提示信息', '主机名称格式错误，请重新填写','info');
			return;
		}
		if(logport<1||logport>25535){
			$.messager.alert('提示信息', '端口超出范围，请重新填写','info');
			return;
		}
		
		$.ajax({
               type: "POST",
               url: "${pageContext.request.contextPath}/security/updateLogServerInfo.do",
               data: {
               			securityid:$("#tabs_security_id").val(),
               			objectid:$("#tabs_object_id").val(),
               			displayname:$("#tabs_displayname").val(),
               			manageip:$("#tabs_manip").val(),
               			bindway:'2',
               			bindvalue:'ethernet0/1',
               			logprotocol:logprotocol,
               			logport:logport,
               			loghost:loghost,
               			logtypes:logtypes,
               			servercertcheck:servercertcheck
               },
               dataType: "json", 
               success: function(data){
					if (data.success) {
						$.messager.alert('提示信息', '修改成功','info');
					} else {
						$.messager.alert('提示信息', '修改发生错误','error');
					}
               },
              error: function(data){
				   $.messager.alert('提示信息', '修改发生错误','error');
               }
            });
	}
	
	function initLogServer(){
	
		if(data.logConf==null)
         	return;
        $('#logprotocol').combobox('setValue',data.logConf.logprotocol); 
        $("#logport").textbox('setValue',data.logConf.logport);
        $("#loghost").textbox('setValue',data.logConf.loghost);
        if(data.logConf.logprotocol=='2'){
            $("#servercertcheckTr").show();
        	if(data.logConf.servercertcheck){
            	$("#servercertcheck").attr("checked", true);
            }
        }
        //开启日志
        var logTypes = data.logConf.logtypes;
               		
        if(logTypes.indexOf("0") >= 0){
         	setConfOfLog($("#eventlog"),"1");
        }else{
        	setConfOfLog($("#eventlog"),"0");
        }
        if(logTypes.indexOf("1") > 0){
        	setConfOfLog($("#configlog"),"1");
        }else{
        	setConfOfLog($("#configlog"),"0");
        }
        if(logTypes.indexOf("2") > 0){
        	setConfOfLog($("#networklog"),"1");
        }else{
        	setConfOfLog($("#networklog"),"0");
        }
        if(logTypes.indexOf("3") > 0){
        	setConfOfLog($("#sessionlog"),"1");
        }else{
        	setConfOfLog($("#sessionlog"),"0");
        }
        if(logTypes.indexOf("4") > 0){
        	setConfOfLog($("#natlog"),"1");
        }else{
        	setConfOfLog($("#natlog"),"0");
        }
        if(logTypes.indexOf("5") > 0){
         	setConfOfLog($("#urllog"),"1");
        }else{
        	setConfOfLog($("#urllog"),"0");
        }
        if(logTypes.indexOf("7") > 0){
        	setConfOfLog($("#nbclog"),"1");
        }else{
        	setConfOfLog($("#nbclog"),"0");
        }
        if(logTypes.indexOf("8") > 0){
        	setConfOfLog($("#threatlog"),"1");
        }else{
        	setConfOfLog($("#threatlog"),"0");
        }
	
	}
	
	function protocolChange(val)
	{
		if(val=='2'){
			$("#servercertcheckTr").show(); 
		}else{
			$("#servercertcheckTr").hide(); 
		}
	}
    	
	
	 //根据id 和 值设置是否开启配置
	 function setConfOfLog(id,conf)
	 {
		 if(conf=='1')
			 {
			 	id.addClass('active');
			 }
		 else{
		 	id.removeClass('active');
		 }
	 }
	 
	 
	  function getValOfLog(monitor){
	  	if(monitor.hasClass('active'))
	  		return 1;
	  	return 0;
	  }
	  
	  //全选按钮点击响应时间
	  function selectAllLog(){
	  	var allOpen = false;
	  	if (!$("#allopen").hasClass('active')){
	  		allOpen = true;
	 	 }
	 	 
	  	 $("[id$='log']").each(function(){
	  	 		 if(allOpen)
	  	 		 	$(this).addClass('active');
	  	 		 else
	  	 		 	$(this).removeClass('active');
	  		});
	  }
	  
	  //获取打开的log日志类型，中间用逗号分隔
	  function getLogTypes(){
	  	var logTypes='';
	  	$("[id$='log']").each(function(){
	  		if($(this).hasClass('active')){
	  			if($(this).attr("id")=='eventlog'){
	  				logTypes+='0,';
	  			}
	  			if($(this).attr("id")=='configlog'){
	  				logTypes+='1,';
	  			}
	  			if($(this).attr("id")=='networklog'){
	  				logTypes+='2,';
	  			}
	  			if($(this).attr("id")=='sessionlog'){
	  				logTypes+='3,';
	  			}
	  			if($(this).attr("id")=='natlog'){
	  				logTypes+='4,';
	  			}
	  			if($(this).attr("id")=='urllog'){
	  				logTypes+='5,';
	  			}
	  			if($(this).attr("id")=='nbclog'){
	  				logTypes+='7,';
	  			}
	  			if($(this).attr("id")=='threatlog'){
	  				logTypes+='8';
	  			}
	  		}
	  	 });
	  	return logTypes;
	  }
	  
	 //点击按钮相应时间，开关css切换
	 $("[id$='log'],[id$='open']").click(function() {
	 	
	  	if($(this).hasClass('active'))
	  		$(this).removeClass('active');
	  	else
	  		$(this).addClass('active');
	  });

	//ip地址校验
	function isIP(ip) {
		var re = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/
		return re.test(ip);
	}
	  
 </script>	
		
</body>

