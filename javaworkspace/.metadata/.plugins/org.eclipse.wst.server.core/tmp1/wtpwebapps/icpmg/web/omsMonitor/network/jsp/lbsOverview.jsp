<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>负载均衡监控概况</title>
<!-- <meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> -->
</head>
<body>
    <script type="text/javascript">
        var context_path = '${pageContext.request.contextPath}';
        function JumpPage(value){
			$('#centerTab').panel({
				href:'/icpmg/web/omsMonitor/network/jsp/networkDetailOverview.jsp',
				queryParams:{
					typeid:'SLB',
					neid:value
				}
			});
		};
		function JumpNetWorkRunPage(typeid,neid){
			var url = '/icpmg/web/omsMonitor/network/jsp/networkRunOverview.jsp';
			if(typeid=='LBS'){
				url = '/icpmg/web/omsMonitor/network/jsp/lbsRunOverview.jsp';
			}
			if(typeid=='LINE'){
				url = '/icpmg/web/omsMonitor/network/jsp/lineRunOverview.jsp';
			}
			$('#centerTab').panel({
				href:url,
				queryParams:{
					typeid:typeid,
					neid:neid
				}
			});	
		};
    </script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/web/omsMonitor/network/css/networkOverview.css" />
    <!-- 页面主体 -->
    <div id="net_main_body">
        <!-- 顶部块 -->
        <div id="top_block" class="clearfix">
            <div class="single_block clearfix">
                <div class="block_img" id="count_all"></div>
                <span></span>
                <span>总台数</span>
            </div>
            <div class="single_block clearfix">
                <div class="block_img" id="count_offline"></div>
                <span></span>
                <span>未启动台数</span>
            </div>
            <div class="single_block clearfix">
                <div class="block_img" id="count_new"></div>
                <span></span>
                <span>本月新增数</span>
            </div>
            <div class="single_block clearfix">
                <div class="block_img" id="count_clear"></div>
                <span></span>
                <span>本月退网数</span>
            </div>
        </div>
        <!-- 设备监控列表 -->
        <div id="monitor_list_block" style="width:97%">
            <div class="monitor_top_block">
                <span>负载均衡监控</span>
            </div>
            <div id="dg_monitor_LBS_list" style="width:100%"></div>
        </div>
        <!-- 设备告警信息统计 -->
        <div class="warn_info" style="width: 97%">
                <span class="block_title">设备告警信息统计</span>
                <div id="dg_warn_info" style="width: 100%"></div>
        </div>
        <!-- 流入流出图表 -->
        <div class="net_flow_chart clearfix" style="width: 97%;">
            <div id="flow_in_chart" style="width: 48% ; height:360px"></div>
            <div id="flow_out_chart" style="width: 48% ; height:360px"></div>
        </div>
    </div>
    <script type="text/javascript" src="${pageContext.request.contextPath}/web/omsMonitor/host/js/echarts.min.js"></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/web/omsMonitor/network/js/lbsOverview.js" charset="UTF-8"></script>
</body>
</html>