    <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>应用负载运行概况</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
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
                    <span id="oname">实例名称：</span>
                </div>
                <div class="status_cpumem_info">
                    <span>设备ip：</span>
                </div>
                <div class="status_warning_info">
                    <span>告警数：</span>
                </div>
                <div class="status_uptime_info">
                    <span>设备状态: </span>
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
        <div class="ceph-floor">
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
                    <ul>
                        <li class="li_checkbox_input"><input id="listener_select" value="监听器选择"></li>
                        <li class="li_checkbox_input"><input id="bg_server_select" value="后端服务选择"></li>
                    </ul>
                    <ul style="overflow-y:scroll;height:320px">
                        <li class="li_checkbox"><input type="checkbox" name="rtime" onclick="kpiSelect(0,$(this))">&nbsp;&nbsp;&nbsp;HTTP响应延迟时间</li>
                        <li class="li_checkbox"><input type="checkbox" name="scur" onclick="kpiSelect(1,$(this))">&nbsp;&nbsp;&nbsp;HTTP请求数</li>
                        <li class="li_checkbox"><input type="checkbox" name="hrsp_1xx" onclick="kpiSelect(2,$(this))">&nbsp;&nbsp;&nbsp;正确响应数1</li>
                        <li class="li_checkbox"><input type="checkbox" name="hrsp_2xx" onclick="kpiSelect(3,$(this))">&nbsp;&nbsp;&nbsp;正确响应数2</li>
                        <li class="li_checkbox"><input type="checkbox" name="hrsp_3xx" onclick="kpiSelect(4,$(this))">&nbsp;&nbsp;&nbsp;正确响应数3</li>
                        <li class="li_checkbox"><input type="checkbox" name="hrsp_4xx" onclick="kpiSelect(5,$(this))">&nbsp;&nbsp;&nbsp;正确响应数4</li>
                        <li class="li_checkbox"><input type="checkbox" name="hrsp_5xx" onclick="kpiSelect(6,$(this))">&nbsp;&nbsp;&nbsp;正确响应数5</li>
                        <li class="li_checkbox"><input type="checkbox" name="currentconns" onclick="kpiSelect(7,$(this))">&nbsp;&nbsp;&nbsp;并发连接数</li>
                        <li class="li_checkbox"><input type="checkbox" name="bin" onclick="kpiSelect(8,$(this))">&nbsp;&nbsp;&nbsp;流入带宽</li>
                        <li class="li_checkbox"><input type="checkbox" name="bout" onclick="kpiSelect(9,$(this))">&nbsp;&nbsp;&nbsp;流出带宽</li>
                    </ul>
                </div>
                <div id="kpi_trend_chart" style="height:400px;width:79%"></div>
            </div>
        </div>
        <!--datagrid监控-->
        <div class="ceph-floor">
            <div class="floor-title">
                <div class="floor-title-left">应用负载指标监控</div>
            </div>
            <div id="port_monitor_dg"></div>
        </div>
    </div>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/web/omsMonitor/network/js/lbsRunOverview.js"></script>
</body>
</html>