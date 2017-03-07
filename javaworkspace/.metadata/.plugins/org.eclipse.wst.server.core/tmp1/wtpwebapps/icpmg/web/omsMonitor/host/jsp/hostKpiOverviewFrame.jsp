<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ page import="com.inspur.icpmg.widgetmg.service.StyleConfigService" %>
<%@ page import="com.inspur.icpmg.widgetmg.pojo.PmcMonitorStyle" %>
<%@ page import="com.google.gson.Gson" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html id="iframehtml">
<head>
    <base href="<%=basePath%>">
    <title>物理机指标监控</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
</head>
<body>
<%
    StyleConfigService styleConfigService = new StyleConfigService();
    List<String> listStyle = styleConfigService.getWidgetStyle();
    List<PmcMonitorStyle> listWidgetStyle = styleConfigService.getWidgetStyleList();
    Gson gson = new Gson();
    String stringGson = gson.toJson(listWidgetStyle);
    pageContext.setAttribute("listStyle", listStyle);
    pageContext.setAttribute("stringGson", stringGson);
    pageContext.setAttribute("listWidgetStyle", listWidgetStyle);
%>
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/web/omsMonitor/host/lib/jquery-ui.min.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/web/omsMonitor/host/lib/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/web/omsMonitor/host/lib/jquery-ui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/web/omsMonitor/host/js/map.js"></script>
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/web/omsMonitor/host/css/hostKpiOverview.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/web/omsMonitor/host/js/echarts.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui-1.4/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui-1.4/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery.easyui.min.js"></script>
    <script type="text/javascript" charset="UTF-8">
        var context_path = '${pageContext.request.contextPath}';
        var group_id=$('#groupid', parent.document).val();
        
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/web/omsMonitor/host/js/hostkpiOverview.js"></script>
    <style>
        #dragWrap { list-style-type: none; margin: 0; padding: 0; width: 1162px; }
        #dragWrap .indexs-item { margin: 0px -15px -15px 0; padding: 1px; float: left; width: 578px; height: 350px; font-size: 4em; text-align: center; position: relative}
    </style>

	<a href="javascript:;" style="margin-left: 10px" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="openConfig(0)">增加</a>
	<a href="javascript:;" style="margin-left: 10px" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="savePosition()">保存</a>
	<!--菜单组件-->
    <div id="mm" class="easyui-menu" style="width:120px;">
        <div onclick="openConfig(1)">设置数据源</div>
        <div>
            <span>改变宽度</span>
            <div style="width:120px;">
                <div onclick="changeEleWidth(1)"><b>原始宽度</b></div>
                <div onclick="changeEleWidth(2)">2倍宽度</div>
                
            </div>
        </div>
    </div>
    <div id="setWinWidgetType">
        <!-- 弹层1 -->
        <div class="model-step1">
            <div class="model-step1-content">
                <div class="model-title">选择图表类型</div>
                <div id="radios">
                    <c:forEach items="${listStyle}" var="style" varStatus="myindex">
                    <!--items迭代对象集合-->
                    <c:choose>
                        <c:when test="${myindex.index eq 0}">
                            <input type="radio" name="imageStyles" id="${style}" value="${style}" checked="checked"
                            onclick="checkType(this)"> ${style}
                        </c:when>
                        <c:otherwise>
                            <input type="radio" name="imageStyles" id="${style}" value="${style}"
                            onclick="checkType(this)">  ${style}
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                </div>
                <div id="images"></div>
            </div>
        </div>
        <!-- 弹层2 -->
        <div id="setWindow2">
            <div id="setWindow2-step2" class="easyui-tabs" >
                <div title="设备选择" id="device_select" class="model-indexs-step2">
                    <div id="type_select" style="margin:20px 0 0 50px">设备类型&nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="select_combo">
    					<div class="model-row">
                            <div class="model-left">
                                <div class="model-title">选择设备
                                    <div class="model-search">
                                        <input style="width:150px" id="set" />
                                    </div>
                                </div>
                                <div class="model-con j-step2-select" id="host_list">
                                    <ul></ul>
                                </div>
                                
                            </div>
                            <div class="model-center">
                                <a href="javascript:;" class=" icon toright-only j-toright-only"></a>
                                <a href="javascript:;" class=" icon toright-more j-toright-more"></a>
                                <a href="javascript:;" class=" icon toleft-only j-toleft-only"></a>
                                <a href="javascript:;" class=" icon toleft-more j-toleft-more"></a>
                            </div>
                            <div class="model-right">
                                <div class="model-title">已选设备</div>
                                <div class="model-con j-step2-right">
                                    <ul></ul>
                                </div>
                            </div>
                        </div>
                       <div id="is-monitor-com" style="margin-right:100px; display:none">
                                <input type="checkbox" id="is-monitor-comp"> 是否监控下级组件
                       	</div> 
                    </div>
                </div>
                <div title="组件选择" id="component_select" class="model-indexs-step2">
                	 <div style="margin:20px 0 0 50px">选择下级组件类型&nbsp;&nbsp;
                        <input id="select_comp">
                     </div>
                     <div id="flag_div"></div>
                </div>
                <div title="指标选择" id="kpi_select" class="model-indexs-step2">
					<div class="model-row" style="margin:40px 0 0 50px">
					    <div class="model-left">
					        <div class="model-title">选择指标类型
					            <div class="model-search">
					                <input style="width:150px" id="type" />
					            </div>
					        </div>
					        <div class="model-con j-step2-select" id="kpi_list">
					            <ul></ul>
					        </div>
					    </div>
					    <div class="model-center">
					        <a href="javascript:;" class=" icon toright-only j-toright-only"></a>
					        <a href="javascript:;" class=" icon toright-more j-toright-more"></a>
					        <a href="javascript:;" class=" icon toleft-only j-toleft-only"></a>
					        <a href="javascript:;" class=" icon toleft-more j-toleft-more"></a>
					    </div>
					    <div class="model-right">
					        <div class="model-title">已选指标类型</div>
					        <div class="model-con j-step2-right">
					            <ul></ul>
					        </div>
					    </div>
					</div>
                </div>
                <div title="时间范围" id="time_select" class="model-indexs-step2">
					<div class="model-row" style="height: 90px;">
					    <div style="width: 95%; margin-left: 40px">
					            <p>
					                <span id="time_interval">
					                    时间粒度：<input type="text" id="interval" style="width: 100px;">
					                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                </span>
					                <select id="time_function" onchange="sele_Change();">
					                <option value="time_range">距今时间</option>
                                     <option value="time_span">绝对时间</option>
					                </select>
					                <span id="time_range">
					                                            最近<input value="100" id="timeRange" style="width: 100px;" />天&nbsp;&nbsp;&nbsp;
					                </span>
					                <span id="time_span">
					                                                  从<input class="easyui-datetimebox" id="fromtime" style="width:100px;">
									        到<input class="easyui-datetimebox" id="totime" style="width:100px;">&nbsp;&nbsp;&nbsp;
					                </span>
					                <span id="topn_select">
					                    TopN选择：<input type="text" id="topN" style="width: 100px;">
					                </span>
					            </p>
					            <p style="margin-top: 10px;">控件标题：
					                <input type="text" id="widgettitle" name="widgetTitle" style="width: 530px;">
					            </p>
					    </div>
					</div>
                </div>
            </div>
        </div>
    </div>
    <div id="dragWrap">
            <!-- 拖动容器 -->
    </div>

<script type="text/javascript">

    function checkType(obj) {
        var eleName = obj.value;
        $("#images").empty();
        var imagsObj = ${stringGson}
                $.each(imagsObj, function (index) {
                    if (this.widgetstyletype == eleName) {
                        var imgSrcNotSelect = "${pageContext.request.contextPath}/web/omsMonitor/inhost/img/" + this.widgetstyleId + ".png";
                        var imgSrcSelected = "${pageContext.request.contextPath}/web/omsMonitor/inhost/img/selected/" + this.widgetstyleId + "-select.png";
                        var _div = $("<div style='float:left;margin:10px 5px;'>").append($("<img>").attr("src", "${pageContext.request.contextPath}/web/omsMonitor/inhost/img/" + this.widgetstyleId + ".png")
                                .attr({id: this.widgetstyleId}));
                        _div.appendTo($("#images"));
                        _div.on("click", function () {
                            var _imgage = $(this).children("img");
                            _imgage.attr("src", imgSrcSelected)
                                    .attr("name", "selected");
                            var siblingImgId = _div.siblings().find("img[name='selected']").attr("id");
                            var imgSrcNotSelectTmp = "${pageContext.request.contextPath}/web/omsMonitor/inhost/img/" + siblingImgId + ".png";
                            _div.siblings().find("img[name='selected']").attr("src", imgSrcNotSelectTmp).attr("name", siblingImgId);
                        });
                    }
                });
    }
 
    $(document).ready(function() {
    	  var groupid=$('#groupid', parent.document).val();
			loadWidgetList(groupid);
		});
    function loadWidgetList(groupid)
    {	
    	$.ajax({
					url : '${pageContext.request.contextPath}/widget/getWidgetList.do?groupid='+groupid,
					data : {
						
					},
					type : 'POST',
					dataType : 'json',
					success : function(result) {
						var widgetList = result.rows ;
						//$("#dragWrap").empty() ;
						for(var i = 0 ; i< widgetList.length;i ++)
						{
							var widgetid = widgetList[i].widgetid ;
							var widgetname = widgetList[i].widgetname ;
							var chartItem = '<div class="indexs-item j-drag" id ="'+widgetid+'">' ;
							chartItem = chartItem +  '<div class="btnbox"><i class="icon close j-close"></i> <i class="icon export"></i><i class="icon set j-set"></i></div>' ;
							chartItem = chartItem +  '<div class="item-drag drag-title"> ' ;
							chartItem = chartItem +  '<div class="indexs-title">'+widgetname+'</div> ' ;
                       		chartItem = chartItem +  '<div class="indexs-con"><div id="chart'+widgetid+'" style="width: 100%; height: 100%;"></div></div>' ;
                   			chartItem = chartItem +  ' </div>' ;
                   			chartItem = chartItem +  ' </div>' ;                   			
							$("#dragWrap").append(chartItem) ;
							initChart(widgetid,widgetList[i].widgetwidth);
							};	
						$("#dragWrap .indexs-item").addClass("indexs-item j-drag") ;
						$("#dragWrap .btnbox").addClass("btnbox") ;
						$("#dragWrap .item-drag").addClass("item-drag drag-title") ;
						$("#dragWrap .indexs-title").addClass("indexs-title") ;
						$("#dragWrap .indexs-con").addClass("indexs-con") ;
					}
				});
    }
    function sele_Change () {
    	var sel_value= $("#time_function").val();
    	if (sel_value=="time_range"){
    		$("#time_span").css("display", "none");
    		$("#time_range").removeAttr("style");
    	}
    	else{
    		$("#time_range").css("display", "none");
    		$("#time_span").removeAttr("style");
    	}
    }

    var initChart = function (widgetid,widgetwidth) {
    	$.ajax({
				url : '${pageContext.request.contextPath}/widget/getChartOptionConfig.do',
				data : {
					widgetid: widgetid
				},
				type: 'POST',
				dataType : 'json',
				async:true,
				success : function(result) {
                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document.getElementById('chart' + widgetid));
					// 指定图表的配置项和数据
				    var option = {
				        title: {
				            show: false
				        },
				        tooltip: {
                            show: true
                        },
				        legend: result.legend,
				        xAxis: result.xAxis,
				        yAxis: result.yAxis,
				        series: result.series
				    };
				    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                    initMenuWithChart($("#" + widgetid + " div i.j-set"), myChart);
                    deleteBlock($("#" + widgetid + " div i.j-close"));
                    if(widgetwidth==2){
                    	$("#" + widgetid).width(567 * widgetwidth-12);
                    }
                    else{
                    	$("#" + widgetid).width(567 * widgetwidth);
                    }
                    myChart.resize();
                    return myChart;
				}
			});
	}
</script>
</body>
</html>