<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../../icp/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <title>浪潮云服务</title>
</head>
<body>

<link href="${ctx}/web/gov2/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="${ctx}/styles/gov2.css" rel="stylesheet" media="screen">

<%--<script src="${ctx}/js/scripts/jquery-1.8.3.min.js"></script>--%>
<script src="${ctx}/web/gov2//bootstrap/js/bootstrap.min.js"></script>
<%--<script type="text/javascript" src="${ctx}/highchart/jquery-latest.js"></script>--%>
<%--<script type="text/javascript" src="${ctx}/highchart/4.2.1/highcharts.js"></script>--%>
<script type="text/javascript" src="${ctx}/highchart/4.2.1/highcharts-more.js"></script>

<div class="easyui-layout" data-options="height:800px,border:false"
     style="padding:0px 0px 0px 20px;margin:0px -12px 10px 20px;">

    <%--<div data-options="region:'center',border:false">--%>

    <div style="width: 100%;" class="container">
        <div id="basicInfo" class="basicinfo" style="height: 65px;width: 100%">
            <div class="zhuangtai"><img src="${ctx}/images/status-ok.png"/></div>
            <div class="basicinfo_text">
               <div class="span4"> 服务器名称：<span name="nename"></span> <br/>IP地址：<span name="ip"></span>
                </div>
                <div class="span2">
                    应用：<span name="app"></span> <br/>
                    安全服务：<span name="security"></span>
                </div>
                <div class="span3">
                告警总数：<span name="alarmCount"></span>
            </div>
                <div class="span2">
                    正常运行时常：<br/><span name="runningTime"></span>
                </div>
                <img src="${ctx}/images/arrow.png"/>
            </div>
        </div>

        <c:if test="${sessionScope.sessionUser.roleid ne '1000000047'}">
            <div class="row " style="">
                <div class="span6 module" style="margin: 0px 20px 0px 0px">
                    <div class="module_title">
                        CPU负荷
                        <a href="#"><img src="${ctx}/images/refresh.png"/></a>
                    </div>

                    <div class="row module_text">
                        <div class="span3">
                            <div id="speedg"
                                 style="min-width: 150px; max-width: 260px; height: 300px; margin: 0px 10px 0px -10px"></div>
                        </div>
                        <div class="span3">
                            <div id="speedghost"
                                 style="min-width: 130px; max-width: 230px; height: 300px; margin: 0px 10px 0px 15px"></div>
                        </div>
                    </div>
                </div>
                <div class="span6 module" style="margin: 0px 0px 0px 12px;">

                    <div class="module_title">
                        内存利用率
                        <a href="#"><img src="${ctx}/images/refresh.png"/></a>
                    </div>
                    <div class="row">
                        <div class="span3">
                            <div id="memusagevn"
                                 style="min-width: 180px; max-width: 260px;height: 300px;  margin: 0px 0px 0px 0px"></div>
                        </div>
                        <div class="span3" style="margin-left: 0px">
                            <div id="memusagehost"
                                 style="min-width: 150px; max-width: 230px; height: 280px; margin: 0px 10px 0px 55px"></div>
                        </div>
                    </div>

                </div>
            </div>
        </c:if>

        <div class="row " style="height: 300px; margin-top:10px ">

            <div class="span12 module2" style="margin-left: 0px;width: 1112px">
                <div class="module2_title">
                    指标监控
                    <a href="#"><img src="${ctx}/images/refresh.png"/></a>
                    <a href="#"><img src="${ctx}/images/shezhi.png"/></a>
                    <a href="#"><img src="${ctx}/images/daochu.png"/></a>
                </div>
                <div class="span1">

                    <div class="film_focus">
                        <div class="film_focus_desc">
                            <ul class="film_focus_nav">
                                <li class="cur" id="cpuload" name="CPU利用率"><b> CPU利用率</b><span>CPU利用率</span></li>
                                <li  id="memusage" name="内存利用率" ><b>内存利用率</b><span>内存利用率</span></li>
                                <li  id="cpuload" name="一分钟负荷" ><b>一分钟负荷</b><span>一分钟负荷</span></li>
                                <%--<li  id="io"><b>网络流量</b><span>网络流量</span></li>--%>
                                <%--<li><b>长标题4</b><span>短标题4</span></li>--%>
                                <%--<li><b>长标题5</b><span>短标题5</span></li>--%>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="span11">
                    <div class="row">
                        <div class="span12" style="align:right">
                            <span style="align-content: flex-end" id="1M">
                                1Mon
                            </span>
                            <span id="1W">1week</span><span id="1D">1d</span><span id="12H">12h</span><span id="1H">1h</span>
                        </div>
                    </div>
                    <div class="module2_text">
                        <div id="areaMissing"
                             style="min-width: 250px;max-width: 900px; height: 400px; margin: 0 auto"></div>
                    </div>
                </div>

            </div>

        </div>
        <div class="row">

        </div>
        <%--<div class="row" style="height: 200px;">--%>
        <%--<div class="span6">--%>
        <%--cpu--%>
        <%--</div>--%>
        <%--<div class="span6">--%>
        <%--磁盘分区--%>
        <%--</div>--%>
        <%--</div>--%>

        <%--</div>--%>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        //基本信息
        getBasicInfo();
        if(('${sessionScope.sessionUser.roleid }') != '1000000047'){
            //cpu绘图
            drawgauge("speedg", {pointVal: 60, changeValue: [30, 60], title: 'VM CPU'});
            drawgauge("speedghost", {pointVal: 40, changeValue: [10, 40], title: 'HOST CPU', paneCenter: ['50%', '60%'], size:'75%'});
            //内存利用率绘图
            drawgauge("memusagevn", {pointVal: 45, changeValue: [20, 50], title: 'VM MEM'});
            drawgauge("memusagehost", {
                pointVal: 30,
                changeValue: [10, 30],
                title: 'HOST MEM',
                paneCenter: ['50%', '60%'],
                size:'75%'
            });
        }
        //面积图绘图
        getCpuLoad();

        $(".film_focus_nav li").click(function (){
            $(this).nextAll().removeClass("cur");
            $(this).prevAll().removeClass("cur");
            $(this).addClass("cur");
            var  _kpiid = $(this).attr("id");
            var _displayName = $(this).attr("name");
            drawKpi('areaMissing',_kpiid,_displayName);

        });

        function getCpuLoad(){
            $.getJSON(
                '${ctx}/highchart/loadCpu.do',
                {neId:'${param.neId}',
                 displayname:'CPU利用率'
                },
                function(data){
                    if(data['series'].length == 0){
                        data['series']=null;
                    }
                    data.title='${param.objectName}';
                    drawarea('areaMissing',data);

                }
            );
        }

        function drawKpi(chartDivId,kpiId,displayName){
            $.getJSON(
                    '${ctx}/highchart/loadKpi.do',
                    {neId:'${param.neId}',
                     kpiId:kpiId,
                     displayname:displayName
                    },
                    function(data){
                        if(data['series'].length == 0){
                            data['series']=null;
                        }
                        data.title='${param.objectName}';
                        drawarea(chartDivId,data);

                    }
            );
        }
    });

     function getBasicInfo(){
         $.ajax({
             url:'${ctx}/resourceinfo/resourceBasicInfoProduct.do',
             data:{
                 objectId:'${param.neId}',
                 serverStartTime:'${param.serverStarttime}'
             },
             dataType:'JSON',
             success:function(data){
//                 console.log(data);
                 $("#basicInfo span[name='nename']").html(data['basicInfo']['nename']);
                 $("#basicInfo span[name='ip']").html(data['basicInfo']['ipaddr']);
                 $("#basicInfo").find("span[name='app']").html(data['appAndSecurity'].app);
                 $('#basicInfo').find('span[name=\'security\']').html(data['appAndSecurity'].security);
                 $("#basicInfo").find("span[name='alarmCount']").html(data['basicInfo'].alarmCount);
                 $("#basicInfo").find("span[name='runningTime']").html(data['basicInfo']['runningTime']);
             }
         });

     }

    //仪表盘图
    function drawgauge(divid, options) {
//        var _id = "#" + divid;
        var _options = {
            credits: {
                enabled: false
            },
            chart: {
                renderTo: divid,
                type: 'gauge',
                plotBorderWidth: 0,
                plotShadow: false,
                margin: [20, 0, 0, 0]
            },
            title: {
                text: options.title
            },
            pane: {
                size: options.size || '90%',
                startAngle: -150,
                endAngle: 150,
                background: [{
                    backgroundColor: {
                        linearGradient: {x1: 0, y1: 0, x2: 0, y2: 1},
                        stops: [
                            [0, '#FFF'],
                            [1, '#333']
                        ]
                    },
                    borderWidth: 0,
                    outerRadius: '109%'
                }, {
                    backgroundColor: {
                        linearGradient: {x1: 0, y1: 0, x2: 0, y2: 1},
                        stops: [
                            [0, '#333'],
                            [1, '#FFF']
                        ]
                    },
                    borderWidth: 1,
                    outerRadius: '107%'
                }, {
                    // default background
                }, {
                    backgroundColor: '#DDD',
                    borderWidth: 0,
                    outerRadius: '105%',
                    innerRadius: '103%'
                }],
                center: options.paneCenter || ['50%', '50%']
            },

            // the value axis
            yAxis: {
                min: 0,
                max: 100,

                minorTickInterval: 'auto',
                minorTickWidth: 1,
                minorTickLength: 10,
                minorTickPosition: 'inside',
                minorTickColor: '#666',

                tickPixelInterval: 30,
                tickWidth: 2,
                tickPosition: 'inside',
                tickLength: 10,
                tickColor: '#666',
                labels: {
                    step: 2,
                    rotation: 'auto'
                },
                title: {
                    text: '%'
                },
                plotBands: [{
                    from: 0,
                    to: 60,
                    color: '#55BF3B' // green
                }, {
                    from: 60,
                    to: 80,
                    color: '#DDDF0D' // yellow
                }, {
                    from: 80,
                    to: 100,
                    color: '#DF5353' // red
                }]
            },

            series: [{
                name: 'CPU',
                data: [options['pointVal']],
                tooltip: {
                    valueSuffix: ' %'
                }
            }]
        };
        var chart = new Highcharts.Chart(_options);
    }

    //面积图
    function drawarea(_divid,options){
//        console.log(options);
        var _id = "#"+_divid;
        $(_id).highcharts({
            chart: {
                type: 'area',
                spacingBottom: 30
            },
            title: {
                text: options.title || '指标监控'
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
//                x: 150,
//                y: 100,
                floating: true,
                borderWidth: 1
            },

            xAxis: {
                labels: {
                    formatter: function() {
                        return options['categories'][this.value];
                    },
                    rotation: -45
                },
                tickInterval:1
            },
            yAxis: {
                title: {
                    text: '%'
                },
                labels: {
                    formatter: function () {
                        return this.value;
                    }
                },
                minPadding:0,
                startOnTick:false
            },
            tooltip: {
                formatter: function () {
//                    console.log((this.point));
                    return this.series.name +':'+
                            options['categories'][this.x] + '  ' + this.y+'%';
                },
                    backgroundColor: '#FCFFC5',   // 背景颜色
                    borderColor: 'black',         // 边框颜色
                    borderRadius: 10,             // 边框圆角
                    borderWidth: 3,               // 边框宽度
                    shadow: true,                 // 是否显示阴影
                    animation: true,              // 是否启用动画效果
                    style: {                      // 文字内容相关样式
                        color: "#ff0000",
                        fontSize: "12px",
                        fontWeight: "blod",
                        fontFamily: "Courir new"
                    }
            },
            plotOptions: {
                area: {
                    fillOpacity: 0.5
                }
            },
            credits: {
                enabled: false
            },
            series: options['series']
        });
    }

</script>
</body>
</html>