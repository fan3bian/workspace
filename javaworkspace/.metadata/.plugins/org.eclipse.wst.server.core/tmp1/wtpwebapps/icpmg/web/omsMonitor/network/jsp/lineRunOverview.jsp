<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>网络专线运行概况</title>
	<meta http-equiv="description" content="网络专线运行概况">
  </head>
  <body>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/web/omsMonitor/network/css/networkRunOverview.css" />
    <script type="text/javascript">
        var context_path = '${pageContext.request.contextPath}';
        var objid = '${pageContext.request.getParameter("neid")}';
    </script>
    <!--主包含容器-->
    <div class="main_container" style="width:97%">
        <!--顶层状态栏-->
        <div class="top_status clearfix">
            <div id = "top_cricle"></div>
            <div class="top_status_block">
                <div id = "status_img"></div>
                <div class="status_ip_info" style = "margin-left: 10%;width: 24%">
                    <span>专线编码：</span>
                    <span>专线名称：</span>
                </div>
                <div class="status_cpumem_info">
                    <span>入口IP：</span>
                    <span>出口IP：</span>
                </div>
                <div class="status_warning_info">
                    <span>告警数：</span>
                </div>
                <div class="status_uptime_info">
                    <span>专线状态: </span>
                </div>
                <div class="status_back" onclick="JumpPage(-1)">
                    <span>< 概况</span>
                </div>
                <div class="status_detail" onclick="JumpPage(objid)" style = "margin-left: 10px">
                    <span>详情 ></span>
                </div>
            </div>
        </div>
        <!--指标趋势监控-->
        <div class="kpi_trend_monitor_container ceph-floor">
        <!--监控标题栏-->
            <div class="floor-title">
                <div class="floor-title-left">指标监控</div>
                <div class="floor-title-right">
                    <a href="javascript:;" class="action-icon refresh"></a>
                    <a href="javascript:;" class="action-icon export"></a>
                    <ul class="date-tab j-index-tab">
                        <li class="active">全部</li>
                        <li>1d</li>
                        <li>7d</li>
                        <li>15d</li>
                        <li>1m</li>
                    </ul>
                </div>
            </div>
            <div class="kpi_trend_monitor clearfix" style="width:100%">
                <div class="kpi_select_list" style="width:20%;height:400px">
                    <ul style="height:320px">
                        <li class="li_checkbox"><input type="checkbox" name="inusage" onclick="kpiSelect(0,$(this))">&nbsp;&nbsp;&nbsp;接收利用率</li>
                        <li class="li_checkbox"><input type="checkbox" name="outusage" onclick="kpiSelect(1,$(this))">&nbsp;&nbsp;&nbsp;发送利用率</li>
                        <li class="li_checkbox"><input type="checkbox" name="inspeed" onclick="kpiSelect(2,$(this))">&nbsp;&nbsp;&nbsp;接收速率</li>
                        <li class="li_checkbox"><input type="checkbox" name="outspeed" onclick="kpiSelect(3,$(this))">&nbsp;&nbsp;&nbsp;发送速率</li>
                    </ul>
                </div>
                <div id="kpi_trend_chart" style="height:400px;width:79%"></div>
            </div>
        </div>
    </div>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/web/omsMonitor/network/js/lineRunOverview.js"></script>
  </body>
</html>