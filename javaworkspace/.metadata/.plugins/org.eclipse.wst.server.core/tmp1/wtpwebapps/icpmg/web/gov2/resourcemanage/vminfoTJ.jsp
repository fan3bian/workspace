<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../../icp/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">

    <title>浪潮云服务</title>
</head>
<body>
<link href="${ctx}/web/gov2/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="${ctx}/styles/gov2.css" rel="stylesheet" media="screen">

<script src="${ctx}/web/gov2//bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/highchart/4.2.1/highcharts-more.js"></script>

<div class="easyui-layout" data-options="height:800px,border:false"
     style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">

    <%--<div data-options="region:'center',border:false">--%>

    <div style="width: 100%;" class="container">


        <div id="basicInfo" class="basicinfo" style="height: 60px;width: 100%">

            <div class="zhuangtai"><img src="${ctx}/images/status-ok.png"/></div>
            <div class="basicinfo_text">
               <div class="span3"> 服务器名称：<span>${param.objectName}</span> <br/>IP地址：<span name="ip"></span>
                </div>
                <div class="span3">
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


        <div class="row " style="height: 300px; margin-top:10px ">

            <div class="span12 module2" style="margin-left: 0px;width: 1080px">
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
                                <%--<li  id="io"><b>网络流量</b><span>网络流量</span></li>--%>
                                <%--<li><b>长标题4</b><span>短标题4</span></li>--%>
                                <%--<li><b>长标题5</b><span>短标题5</span></li>--%>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="span11">
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
                $("#basicInfo span[name='ip']").html(data['basicInfo']['ipaddr']);
                $("#basicInfo").find("span[name='app']").html(data['appAndSecurity'].app);
                $('#basicInfo').find('span[name=\'security\']').html(data['appAndSecurity'].security);
                $("#basicInfo").find("span[name='alarmCount']").html(data['basicInfo'].alarmCount);
                $("#basicInfo").find("span[name='runningTime']").html(data['basicInfo']['runningTime']);
            }
        });

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
                    return this.series.name +'<br>'+
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