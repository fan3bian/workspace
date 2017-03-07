    <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>网络设备运行概况</title>
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
                    <span>设备ip：</span>
                </div>
                <div class="status_cpumem_info">
                    <span id="cpuusage">CPU使用率：</span>
                    <span id="memusage">内存利用率：</span>
                </div>
                <div class="status_warning_info">
                    <span>告警数：</span>
                </div>
                <div class="status_uptime_info">
                    <span>正常运行时间:<br></span>
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
                    <span class="action-icon refresh"></span>
                    <span class="action-icon export"></span>
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
                <div class="kpi_select_list" style="width:20%">
                    <ul>
                        <li class="li_checkbox"><input type="checkbox" name="cpuusage" onclick="kpiSelect(0,$(this))">&nbsp;&nbsp;&nbsp;CPU利用率</li>
                        <li class="li_checkbox"><input type="checkbox" name="memusage" onclick="kpiSelect(1,$(this))">&nbsp;&nbsp;&nbsp;内存利用率</li>
                        <li class="li_checkbox"><input type="checkbox" name="pingtime" onclick="kpiSelect(2,$(this))">&nbsp;&nbsp;&nbsp;ping响应时间</li>
                        <li class="li_title">端口选择</li>
                        <li class="li_checkbox_input"><input id="port_select" value="端口选择"></li>
                        <li class="li_checkbox"><input type="checkbox" name="inspeed" onclick="kpiSelect(3,$(this),$('#port_select').combobox('getText'))">&nbsp;&nbsp;&nbsp;接收速率</li>
                        <li class="li_checkbox"><input type="checkbox" name="outspeed" onclick="kpiSelect(4,$(this),$('#port_select').combobox('getText'))">&nbsp;&nbsp;&nbsp;发送速率</li>
                        <li class="li_checkbox"><input type="checkbox" name="flow" onclick="kpiSelect(5,$(this),$('#port_select').combobox('getText'))">&nbsp;&nbsp;&nbsp;带宽占用率</li>
                        <li class="li_checkbox"><input type="checkbox" name="inlossusage" onclick="kpiSelect(6,$(this),$('#port_select').combobox('getText'))">&nbsp;&nbsp;&nbsp;接收丢包率</li>
                    </ul>
                </div>
                <div id="kpi_trend_chart" style="height:360px;width:79%"></div>
            </div>
        </div>
        <!--datagrid监控-->
        <div class="ceph-floor">
            <div class="floor-title">
                <div class="floor-title-left">端口指标监控</div>
            </div>
            <div id="port_monitor_dg"></div>
        </div>
    </div>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/web/omsMonitor/network/js/networkRunOverview.js"></script>
</body>
</html>