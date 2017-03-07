<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
	<div id="monitorConfManage" class="pop" >
       <div style="padding: 20px 150px 100px 150px;background-color: #ffffff">
       		<div>
       		请选择需要开启的项目 &nbsp;&nbsp; 
       		<a href="javascript:void(0)" id="allMonitor"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle" onclick="selectAllMonitor()">全选</a><br/>
       		</div>
            <div class="item2">
                <div class="item-title">设备监控</div>
                <table style="width:100%;border:0;" class="table-layout">
                    <tr>
                        <td width="30%" rowspan="3" align="center">
                            <div style="border-right: 1px solid #ddd;    padding: 30px 10px 30px 0;    margin: 0 0px 0 6px;"> <a href="javascript:void(0)" id="deviceMonitorStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle" onclick="selectDeviceMonitor()">全选</a></div>
                        </td>
                        
                        <td width="20%" align="right">
                           <label> 接口统计：</label>
                        </td>
                        <td width="50%" align="center">
                         	<a href="javascript:void(0)" id="interfaceBandwithStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">带宽</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="javascript:void(0)" id="interfaceSessionStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">会话</a>
                        </td>
                    </tr>
                    <tr>
                       <td width="20%" align="right">
                          <label>安全域统计：</label>
                        </td>
                        <td width="50%" align="center">
                          <a href="javascript:void(0)" id="zoneBandwithStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">带宽</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          <a href="javascript:void(0)" id="zoneSessionStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">会话</a>
                        </td>
                    </tr>
                </table>
            </div>
             <div class="item2">
                <div class="item-title">用户监控</div>
                <table style="width:100%;border:0;" class="table-layout">
                    <tr>
                        <td width="30%" rowspan="3" align="center">
                            <div style="border-right: 1px solid #ddd;    padding: 5px 10px 30px 0;    margin: 0 0px 0 6px;"> <a href="javascript:void(0)" id="usrMonitorStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle" onclick="selectUserMonitor()">全选</a></div>
                        </td>
                        <td width="20%" align="right">
                            <label> 用户/IP统计：</label>
                        </td>
                        <td width="50%" align="center">
                            <a href="javascript:void(0)" id="userBandwithStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">带宽</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="javascript:void(0)" id="userSessionOnlineStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">会话/在线用户数</a>
                        </td>
                    </tr>
                </table>
            </div>
             <div class="item2">
                <div class="item-title">应用监控</div>
                <table style="width:100%;border:0;" class="table-layout">
                    <tr>
                        <td width="30%" rowspan="3" align="center">
                            <div style="border-right: 1px solid #ddd;    padding: 5px 10px 30px 0;    margin: 0 0px 0 6px;"> <a href="javascript:void(0)" id="apMonitorStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle" onclick="selectAppMonitor()">全选</a></div>
                        </td>
                        <td width="20%" align="right">
                            <label> 应用统计统计：</label>
                        </td>
                        <td width="50%" align="center">
                            <a href="javascript:void(0)" id="appBandwithStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">带宽</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="javascript:void(0)" id="appSessionStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">会话</a>
                        </td>
                    </tr>
                </table>
            </div>
             <div class="item2">
                <div class="item-title">其他</div>
                <table style="width:100%;border:0;" class="table-layout">
                    <tr>
                        <td width="30%" rowspan="3" align="center">
                            <div style="border-right: 1px solid #ddd;    padding: 30px 10px 30px 0;    margin: 0 0px 0 6px;"> <a href="javascript:void(0)" id="othrMonitorStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle" onclick="selectOtherMonitor()">全选</a></div>
                        </td>
                       <td width="20%" align="right">
                       </td>
                        <td width="50%" align="center">
                            <a href="javascript:void(0)" id="otherThreatStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">威胁监控</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="javascript:void(0)" id="otherUrlHitStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">URL访问</a>
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="20%" align="right">
                       </td>
                        <td width="50%" align="center">
                           <a href="javascript:void(0)" id="otherKeywordBlockStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">关键字阻断</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <a href="javascript:void(0)" id="otherApplicationBlockStat"  style="width: 100px;" class="default-btn-demo2 j-btn-toggle">应用阻断</a>
                        </td>
                    </tr>
                </table>
            </div>
            <br/>
            <table style="width:100%;border:0;" class="table-layout">
            	<tr>
            		<td width="100%" align="center">
            			 <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-ok" onclick="submitMonitorConf()" style="width: 80px;">提交</a> &nbsp;&nbsp;&nbsp;
            			 <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="initMonitorConfData()" style="width: 80px;" >取消</a> 
            		</td>
            	</tr>
            </table>
			</form>
		</div>
	  </div>
	  
	  <script type="text/javascript">
	  
	  var data;
    	
	 $(document).ready(function() {
	 	   $.ajax({
               type: "POST",
               url: "${pageContext.request.contextPath}/security/initMonitorConf.do",
               data: {securityid:$("#tabs_security_id").val()},
               dataType: "json", 
               success: function(vdata){
               		data = vdata;
               		initMonitorConfData();
                  }
            });
	 	}); 

	  function submitMonitorConf(){
	  
    	var interface_Bandwith_Stat = getVal($("#interfaceBandwithStat")); //设备监控-接口统计-带宽
    	var interface_Session_Stat = getVal($("#interfaceSessionStat"));//设备监控-接口统计-会话
    	var zone_Bandwith_Stat = getVal($("#zoneBandwithStat"));//设备监控-安全域统计-带宽
    	var zone_Session_Stat = getVal($("#zoneSessionStat"));//设备监控-安全域统计-会话
    	
    	var user_Bandwith_Stat = getVal($("#userBandwithStat"));		//用户监控-用户/IP统计-带宽
    	var user_Session_Online = getVal($("#userSessionOnlineStat"));//用户监控-用户/IP统计-会话/在线用户数
	  	var app_Bandwith_Stat = getVal($("#appBandwithStat"));	//应用监控-应用统计-带宽	
    	var app_Session_Stat = getVal($("#appSessionStat"));//应用监控-应用统计-会话
    	
    	var threat_Stat = getVal($("#otherThreatStat"));	//威胁监控
    	var url_Hit_Stat = getVal($("#otherUrlHitStat"));	//URL访问
    	var keyword_Block_Stat = getVal($("#otherKeywordBlockStat"));	//关键字阻断
    	var application_Block_Stat = getVal($("#otherApplicationBlockStat"));//应用阻断
    	
    	
    		
		$('#snmpUpdateForm').form('submit',{
				url : "${pageContext.request.contextPath}/security/updateMonitorConf.do",
				onSubmit : function(param) {
							param.securityid = $("#tabs_security_id").val();
							param.objectid = $("#tabs_object_id").val();
							param.displayname = $("#tabs_displayname").val();
							param.manip = $("#tabs_manip").val();
									
							param.app_Bandwith_Stat = app_Bandwith_Stat;
							param.app_Session_Stat = app_Session_Stat;
							param.interface_Bandwith_Stat = interface_Bandwith_Stat;
							param.interface_Session_Stat = interface_Session_Stat;
							param.zone_Session_Stat = zone_Session_Stat;
							param.zone_Bandwith_Stat = zone_Bandwith_Stat;
							param.user_Session_Online = user_Session_Online;
							param.user_Bandwith_Stat = user_Bandwith_Stat;
							param.application_Block_Stat = application_Block_Stat;
							param.keyword_Block_Stat = keyword_Block_Stat;
							param.url_Hit_Stat = url_Hit_Stat;
							param.threat_Stat = threat_Stat;
						},
				success : function(retr) {
							var data = $.parseJSON(retr);
							if (data.success) {
								$.messager.alert('提示信息', '保存成功！','ok');
							} else {
								$.messager.alert('提示信息', '保存发生错误，请重试！','error');
							}
				}
								
			});
	  }
	 
	 //全选按钮点击响应 
	 function selectAllMonitor(){
	  	var allOpen = false;
	  	if (!$("#allMonitor").hasClass('active')){
	  		allOpen = true;
	 	 }
	 	 
	  	 $("[id$='Stat']").each(function(){
	  	 		 if(allOpen)
	  	 		 	$(this).addClass('active');
	  	 		 else
	  	 		 	$(this).removeClass('active');
	  		});
	  }
	 //设备监控全选按钮点击
	 function selectDeviceMonitor(){
	  	var allOpen = false;
	  	if (!$("#deviceMonitorStat").hasClass('active')){
	  		allOpen = true;
	 	 }
	 	 
	  	 $("[id^='interface'][id$='Stat'],[id^='zone'][id$='Stat']").each(function(){
	  	 		 if(allOpen)
	  	 		 	$(this).addClass('active');
	  	 		 else
	  	 		 	$(this).removeClass('active');
	  		});
	  }
	 //用户监控全选按钮点击
	 function selectUserMonitor(){
	  	var allOpen = false;
	  	if (!$("#usrMonitorStat").hasClass('active')){
	  		allOpen = true;
	 	 }
	 	 
	  	 $("[id^='user'][id$='Stat']").each(function(){
	  	 		 if(allOpen)
	  	 		 	$(this).addClass('active');
	  	 		 else
	  	 		 	$(this).removeClass('active');
	  		});
	  }
	 //应用监控全选按钮点击
	function selectAppMonitor(){
	  	var allOpen = false;
	  	if (!$("#apMonitorStat").hasClass('active')){
	  		allOpen = true;
	 	 }
	 	 
	  	 $("[id^='app'][id$='Stat']").each(function(){
	  	 		 if(allOpen)
	  	 		 	$(this).addClass('active');
	  	 		 else
	  	 		 	$(this).removeClass('active');
	  		});
	  }
	 //其他监控全选按钮点击
	function selectOtherMonitor(){
	  	var allOpen = false;
	  	if (!$("#othrMonitorStat").hasClass('active')){
	  		allOpen = true;
	 	 }
	 	 
	  	 $("[id^='other'][id$='Stat']").each(function(){
	  	 		 if(allOpen)
	  	 		 	$(this).addClass('active');
	  	 		 else
	  	 		 	$(this).removeClass('active');
	  		});
	  }
	  
	  
	 //根据id 和 值设置是否开启配置
	 function setConf(id,conf)
	 {
		 if(conf=='1')
			 {
			 	id.addClass('active');
			 }
		 else{
		 	id.removeClass('active');
		 }
	 }

	 function initMonitorConfData(){
	 	 setConf($("#interfaceBandwithStat"),data.monitorConf.interbandwidth);
         setConf($("#interfaceSessionStat"),data.monitorConf.intersession);
         setConf($("#zoneBandwithStat"),data.monitorConf.domainbandwidth);
         setConf($("#zoneSessionStat"),data.monitorConf.domainsession);
         setConf($("#userBandwithStat"),data.monitorConf.userbandwidth);
         setConf($("#userSessionOnlineStat"),data.monitorConf.usersession);
         setConf($("#appBandwithStat"),data.monitorConf.appbandwidth);
         setConf($("#appSessionStat"),data.monitorConf.appsession);
         setConf($("#otherThreatStat"),data.monitorConf.threat); 
         setConf($("#otherUrlHitStat"),data.monitorConf.url);
         setConf($("#otherKeywordBlockStat"),data.monitorConf.keywords);
         setConf($("#otherApplicationBlockStat"),data.monitorConf.appblock); 
                    
         if(data.monitorConf.interbandwidth=='1'&&data.monitorConf.intersession=='1'&&data.monitorConf.domainbandwidth=='1'&&data.monitorConf.domainsession=='1'){
            setConf($("#deviceMonitorStat"),'1');
         }else{
         	setConf($("#deviceMonitorStat"),'0');
         }
         if(data.monitorConf.userbandwidth=='1'&&data.monitorConf.usersession=='1'){
             setConf($("#usrMonitorStat"),'1');
         }else{
         	setConf($("#usrMonitorStat"),'0');
         }
         if(data.monitorConf.appbandwidth=='1'&&data.monitorConf.appsession=='1'){
             setConf($("#apMonitorStat"),'1');
          }else{
          	setConf($("#apMonitorStat"),'0');
          }
          if(data.monitorConf.appblock=='1'&&data.monitorConf.threat=='1'&&data.monitorConf.url=='1'&&data.monitorConf.keywords=='1'){
             setConf($("#othrMonitorStat"),'1');
         }else{
         	 setConf($("#othrMonitorStat"),'0');
         }
	 
	 }

	  function getVal(monitor){
	  	if(monitor.hasClass('active'))
	  		return 1;
	  	return 0;
	  }
	  
	  
	  $('.j-btn-toggle').click(function() {
	  	if($(this).hasClass('active'))
	  		$(this).removeClass('active');
	  	else
	  		$(this).addClass('active');
	  });
	  
	  
	  </script>	
		
</body>

