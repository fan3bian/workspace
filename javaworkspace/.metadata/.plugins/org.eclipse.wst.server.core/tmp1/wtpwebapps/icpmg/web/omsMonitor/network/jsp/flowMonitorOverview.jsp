<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>流量监控页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="流量监控页面">

  </head>
  
 <body>
 <script type="text/javascript" charset="UTF-8">
  		var context_path = '${pageContext.request.contextPath}';
 </script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/web/omsMonitor/network/css/flowMonitorOverview.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/web/omsMonitor/network/js/flowMonitorOverview.js"></script>

<div style="width: 100%; height:100%;min-width: 1000px;">
	<div class="easyui-layout lcy-body" data-options="fit:true,border:false" >
		 <div data-options="region:'north',border:false" style="height: 43px;padding-top: 4px;">
		 		<form id="flowmonitor_searchform">
		 				<div style="margin: -1px 20px;">
		 						<div class="lcy-search">
		 								<div class="netflow_one">类型：
			 									<input class="easyui-combobox" name="flowmonitortypeid" id="flowmonitortypeid" style="width:150px"
			 											data-options="panelHeight:100,
																valueField: 'label', 
																textField: 'value', 
																data: [{
																	label: 'SWITCH',
																	value: '交换机'
																},{
																	label: 'inSLB',
																	value: '负载均衡'
																}],
																onSelect: function(rec){ 
																	$('#flowmonitorapi').combobox('clear');
																	if(rec.label=='inSLB'){
																		$('#flowmonitorspan').html('监听器');
																		$('#flowmonitorservices').show();
																	}else{
																		 $('#flowmonitorspan').html('端口');
																		 $('#flowmonitorservices').hide();
																	}
																	//查询主机
		            												var url2 = '${pageContext.request.contextPath}/networkfolw/getNeids.do?flowmonitortypeid='+rec.label;    
														            //$('#kpi').combobox('reload', url2); 
														            $('#flowmonitorhost').combobox({ 
																	    url:url2,
																	    valueField:'id',    
																	    textField:'text' ,
																	    onSelect: function(ret){ 
																	    //按照类型和id 查询，如果类型为SWITCH直接显示，否则再查询
																	    var url3 = '${pageContext.request.contextPath}/networkfolw/getKpis.do?flowmonitortypeid='+rec.label+'&flowmonitorhost='+ret.id;  
		            														if(rec.label=='inSLB'){
																				$('#flowmonitorapi').combobox({    
																					    url:url3,
																					    valueField:'id',    
																					    textField:'id' ,
																					    onSelect: function(rets){ 
																					    	var url4 = '${pageContext.request.contextPath}/networkfolw/getSLBservice.do?levelid='+ret.id+'&neid='+rets.id; 
																					    	$('#flowmonitorservice').combobox('reload', url4); 
																					    }
																				});
																			}else{
																				 $('#flowmonitorapi').combobox('reload', url3); 
																			}
																	    }
																	});
																}
												"/>
		 								</div>
		 								<div class="netflow_one">名称：
		 										<input class="easyui-combobox" name="flowmonitorhost" id="flowmonitorhost" style="width:150px"
		 												data-options="panelHeight:100,
																valueField:'id',
																textField:'name',
												"/>
										</div>
		 								<div class="netflow_one"><span id="flowmonitorspan">端口</span>：
		 										<input class="easyui-combobox" name="flowmonitorapi" id="flowmonitorapi" style="width:150px"
		 												data-options="panelHeight:100,
																valueField:'id',
																textField:'id',
												"/>
										</div>
										<div class="netflow_one" id="flowmonitorservices">后端服务：
		 										<input class="easyui-combobox" name="flowmonitorservice" id="flowmonitorservice" style="width:150px"
		 												data-options="panelHeight:100,
																valueField:'id',
																textField:'id',
												"/>
										</div>
			  		 	 				<div class="netflow_one">
			  		 	 						<a href="javascript:void(0);" class="easyui-linkbutton"  data-options="iconCls:'icon-search',plain:true" onclick="queryData()">查询</a>&nbsp;&nbsp;
												<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="resetForm()">重置</a>
										</div>
		 						</div>
		 				</div>
		 		</form>
		 </div>
		 	<div class="folw_nonitor_center" >
		 		<div id="folw_monitor_chart"  style="width:100%;height: 400px;"></div>
		 	</div>
	</div>
</div>
 </body>
</html>
