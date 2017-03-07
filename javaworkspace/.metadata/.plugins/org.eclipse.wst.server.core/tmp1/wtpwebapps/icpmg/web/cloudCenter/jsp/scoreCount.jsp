<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../../../../icp/include/taglib.jsp"%>
<%@ include file="../../../../icp/include/import3.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>分数统计</title>
</head>
<body>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/web/cloudCenter/css/scoreCount.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/web/cloudCenter/css/manualScore.css">
    <script type="text/javascript">
        var context_path = '${pageContext.request.contextPath}';
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/web/omsMonitor/host/js/echarts.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/web/cloudCenter/js/scoreCount.js"></script>
    <div class="top_menu clearfix">
        <div class="score_cycle">
           	记分周期&nbsp;&nbsp;&nbsp;
            <input id="tdate" name="tdate" style="height: 25px; width: 200px;"data-options="panelHeight:190">
            <a href="javascript:;" style="margin-left: 10px" class="easyui-linkbutton" data-options="plain:'true',iconCls:'icon-search'">查询</a>
        </div>
        <img class="list_view" src="${pageContext.request.contextPath}/web/cloudCenter/img/list_unselect.png"/>
        <img class="chart_view" src="${pageContext.request.contextPath}/web/cloudCenter/img/chart_select.png"/>
    </div>
    <div id="main_body">
        <div class="top_tool_bar">
            <input id="kpi_select" value="指标筛选">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input id="topn_select" value="Top全部">
        </div>
        <div id="CC_chart_area" style="height:800px"></div>
    </div>
    <div id="list_main_body" style="display: none;">
        <div id="list_top_tool_bar">
            <span class="list_title">云中心排名</span>
            <span class="list_subtitle"></span>
            <a id="exportHref"><img class="saveas_img" src="${pageContext.request.contextPath}/web/cloudCenter/img/icon_saveas.png"></a>
            <span class="count_title"></span>
        </div>
        <div id="list_area">
            <table id="data_table"></table>
        </div>
    </div>
    <div id="cloud_center_detail" class="easyui_tabs">
        <div title="分数详情" id="score_detail"></div>
        <div title="原始指标" id="original_kpi"></div>
        <div title="告警详情" id="alarm_detail"></div>
    </div>
</body>
</html>