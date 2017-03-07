<%--
  Created by IntelliJ IDEA.
  User: sunjiyun
  Date: 2016/8/12
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>运行概况</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">

    <link href="../cfwMonitor/cssbase/default.css" rel="stylesheet" type="text/css">
    <link href="../cfwMonitor/cssbase/regcore.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="easyui-1.4/jquery-1.8.3.min.js" charset="utf-8"></script>
    <link rel="stylesheet" href="easyui-1.4/themes/default/easyui.css" type="text/css">
    <link rel="stylesheet" href="easyui-1.4/themes/icon.css" type="text/css">
    <script type="text/javascript" src="easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
</head>
<body>
<style type="text/css">
    .inserver-error {
        background-position: -55px 0;
    }

    #inserver-main {
        min-width: 1200px;
        min-height: 1200px;
    / / background-color : red;
    }

    #inserver-head-status {
        width: 100%;
        overflow: hidden;
        height: 100px;
        background-color: #fff;
    }

    #inserver-status {
        margin-left: 20px;
        width: 100px;
        height: 80px;
        float: left;
    }

    #inserver-details {
        height: 70px;
        width: 380px;
        float: left;
        margin-top: 10px;
        overflow: hidden;
        background-color: #EEEEEE;
    }

    #inserver-nename {
        margin-left: 20px;
        margin-top: 8px;
        width: 100%;
        font-size: 13px;
    }

    #inserver-ipaddr {
        margin-left: 20px;
        margin-top: 5px;
        font-size: 13px;
    }

    #inserver-alarm {
        height: 70px;
        width: 120px;
        float: left;
        margin-left: 10px;
        margin-top: 10px;
        background-color: #EEEEEE;
        line-height: 70px;
        font-size: 14px;
    }

    #inserver-running-time {
        height: 70px;
        width: 250px;
        float: left;
        margin-left: 10px;
        margin-top: 10px;
        background-color: #EEEEEE;
        line-height: 70px;
        font-size: 14px;
    }

    #inserver-compute-zone {
        width: 97%;
        height: 400px;
        overflow: hidden;
        margin: 10px;
        padding: 10px;
    }

    #inserver-cpu-zone {
        width: 45%;
        height: 400px;
        float: left;
        margin-right: 3.5%;
    / / background-color : blue;
    }

    #inserver-mem-zone {
        width: 45%;
        height: 400px;
        float: left;
    / / background-color : blue;
    }

    #inserver-index-monitor-zone {
        width: 97%;
        height: 550px;
        margin: 10px;
    / / background-color : green;

    }

    /********************************************************/

    #inserver-index-list-zone {
        width: 15%;
        margin-left: 10px;
        margin-right: 20px;
        background: white;
        overflow: hidden;
        float: left;
    }

    #inserver-index-list-zone .index-menu .index-list:hover .index-dropdown {
    / / display : block !important;
        background: #00B8EE;
    }

    #inserver-index-list-zone .index-menu .index-list .index-title {
        width: 100%;
        height: 50px;
        line-height: 50px;
        background: white;
        color: #4074E1;
        font-size: 18px;
    }

    #inserver-index-list-zone .index-menu .index-list .index-dropdown {
        width: 100%;
        background: #00B8EE;
        display: none;
    }

    #inserver-index-list-zone .index-menu .index-list .index-dropdown .drop-down-title {
        height: 50px;
        line-height: 50px;
        font-size: 16px;
        color: white;
    }

    #inserver-index-list-zone .index-menu .index-list .index-dropdown .drop-down-title:hover {
        background: #7ecef4;
    }

    #inserver-time-cobbox-out {
    / / float : left;
        margin: 10px -1px;
        padding: 1px 0;
        width: 90%;
        margin: 0 auto;
        background-color: #eee;
    }

    /********************************************************/

    #inserver-index-zone {
        width: 77%;
        height: 530px;
        float: left;
        background-color: white;
    }

    #inserver-single-device-zone2 {
        width: 97%;
        height: 450px;
        margin: 10px;
    / / background-color : green;

    }

    #inserver-disk-mount-zone {
        float: left;
        width: 94%;
        height: 430px;
        margin: 5px;
        background-color: white;
    }

    #inserver-single-device-zone {
        width: 97%;
        height: 450px;
        margin: 10px;
    / / background-color : green;

    }

    #inserver-single-disk-zone {
        float: left;
        width: 94%;
        height: 430px;
        margin: 5px;
        background-color: white;
    }

    #inserver-bottom {
        width: 100%;
        height: 50px;
        margin-top: 20px;
    }
</style>
<script type="text/javascript" charset="UTF-8">
    var context_path = '${pageContext.request.contextPath}';
    var ceph_neid = '${pageContext.request.getParameter("neid")}';

    if (!ceph_neid || typeof exp == "undefined" || ceph_neid == 0 || ceph_neid == "") {
        ceph_neid = 'jxwrjc-SECURITY-St-000200';
    }

</script>
<script src="${pageContext.request.contextPath}/web/omsMonitor/inhost/js/runOverview/echarts-all.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../cfwMonitor/css/ceph.css"/>
<div class="wrap" id="">
    <div class="ceph-floor1">
        <img src="../cephMonitor/images/ceph-zt-ok.png" id="imgCephHealth" alt="" width="48px" height="48px"
             class="ceph-floor1-icon">

        <div class="ceph-floor1-box">
            <ul>
                <li>名称：<span id="objectname"></span><input id="objectid" type="hidden" />
                </li>
                <li>策略数：<span style="color:green;" id="numRmdSecurityPolicy">5</span>&nbsp;个&nbsp;&nbsp;&nbsp;&nbsp;
                    防护资源数：<span style="color:green;" id="numProtected">5</span>&nbsp;个&nbsp;&nbsp;&nbsp;&nbsp;
                    告警数：<span style="color:red;" id="numAlarm">15</span>&nbsp;个&nbsp;&nbsp;&nbsp;&nbsp;
                    威胁数：<span style="color:red;" id="numThreat">150</span>&nbsp;个
                </li>
                <li>
                    正常运行时间：
                    <span id="inhost-day" style="color:green;"></span>&nbsp;天
                    <span id="inhost-hour" style="color:green;"></span>&nbsp;时
                    <span id="inhost-min" style="color:green;"></span>&nbsp;分
                </li>
            </ul>
            <a href="#" class="ceph-floor1-more"></a>
        </div>
    </div>


    <!-- 2楼 -->
    <div class="ceph-floor">
        <div class="floor-title">
            <div class="floor-title-left ">
                威胁统计
            </div>
        </div>
        <div class="floor-con" style="padding-bottom: 0">

            <div class="chart-wrap" style="padding:2px;">
                <div id="index5Con"    style="width:100%;height:300px;margin-top:12px;padding-bottom:20px; border-right:0px solid #ddd;text-align: center;">
                    <div style="width:520px;height: 320px; float:left; ;" id="barAttackHost">

                    </div>

                    <div style="width:520px;height: 320px; margin-left:530px" id="barVictimehost">

                    </div>

                </div>
            </div>
        </div>

    </div>
    <!-- 3楼 -->
    <div class="ceph-floor">
        <div class="floor-title">
            <div class="floor-title-left ">
                指标监控
            </div>
        </div>
        <div class="floor-con" style="padding-bottom: 0">
            <div id="inserver-index-list-zone" style="margin-top:12px;padding-bottom:20px; border-right:1px solid #ddd">
                <div class="index-menu">
                    <div class="index-list">
                        <p class="index-title">&nbsp;&nbsp;时间范围选择</p>

                        <p id="inserver-time-cobbox-out">
                            <input id="inserver-time-cobbox" style="width:130px;"/>
                        </p>
                    </div>

                    <div class="index-list">
                        <p class="index-title">&nbsp;&nbsp;计算指标选择</p>

                        <div class="index-dropdown" style="display: block;">


                            <p class="drop-down-title">
                                &nbsp;&nbsp;&nbsp;<input type="radio" name="kpis" id="mem-box" value="cursessioncount" alt="pmd_security"
                                                         title="G">
                                <span>会话数</span>
                            </p>

                            <p class="drop-down-title">
                                &nbsp;&nbsp;
                                <input type="radio" name="kpis" id="usedRadio-box" value="usedRadio" title="利用率(%)">
                                <span>目标IP流量TOP</span>
                            </p>

                        </div>
                    </div>


                </div>
            </div>
            <div class="chart-wrap" style="padding:2px;">
                <div id="index1Con" style="width:850px;height:300px;"></div>

            </div>
        </div>

    </div>

    <!-- 四楼 -->
    <div class="ceph-floor">
        <div class="floor-title">
            <div class="floor-title-left ">
                设备状态
            </div>
        </div>
        <div class="floor-con" style="padding-bottom: 0">

            <div class="chart-wrap" style="padding:2px;">
                <div id="devicestatus"  style="width:1000px;height:300px;margin-top:12px;padding-bottom:20px; border-right:1px solid #ddd;text-align: center;">

                    <div style="width:520px;height: 320px; float:left; ;" id="devicestatusCpu">

                    </div>

                    <div style="width:520px;height: 320px; margin-left:530px" id="devicestatusMem">

                    </div>
                </div>

            </div>
        </div>

    </div>


</div>
</div>
</div>
<script type="application/javascript">
    $(function () {


        var optionLine = {

            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: ['objnum', 'dataused']
            },
            toolbox: {
                feature: {
                    saveAsImage: {}
                }
            },
//                color: [
//                    'orange',
//                    'pink',
//                    'red'
//                ],
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            dataZoom: {
                show: true
            },
            xAxis: [
                {
                    type: 'category',
                    name: "时间",
                    boundaryGap: false,
                    data: []
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '对象总数',
                    type: 'line',
                    itemStyle: {normal: {areaStyle: {type: 'default'}}},
                    data: []
                }

            ]
        };

        var serverRowCellNum = 6;

        getBasicInfo();

        function getBasicInfo() {
            $.ajax({
                url: '../../cfwMonitor/getInStanceInfo.do',
                method: 'POST',
                data: {
                    securityId: ceph_neid

                },
                success: function (data) {
                    console.log(data);
                    $("#numRmdSecurityPolicy").html(data['numRmdSecurityPolicy']);
                    $("#numProtected").html(data["numProtected"]);
                    $("#numAlarm").html(data["numAlarm"]);
                    $("#numThreat").html(data["numThreat"]);

                    $("#objectname").text(data['info']['displayname']);
                    $("#objectid").val(data['info']['securityid']);

                    var runTime = data['inhostStatusVO'];

                    setStatusTime(runTime['day'],runTime['hour'],runTime['minute']);
                    threatInfo();
                    searchKpis();
                    loadDeviceInfo();
                }

            });
        }



        // floor 2
        function threatInfo(){
            $.ajax({
                url:'../../cfwMonitor/threatInfoStatistic.do',
                method:'POST',
                data: {
                    securityId: ceph_neid

                },
                success:function(data){
                    console.log(data);
                    drawBar(data['barAttackHost'],"barAttackHost");
                    drawBar(data['barVictimehost'],"barVictimehost");
                }
            })

        }



        // 楼层3tab切换 楼层4趋势图切换
        function liSelected() {
            $(this).addClass('active').siblings().removeClass('active');
            $("#" + $(this).attr('id') + "Con").show();
            $("#" + $(this).attr('id') + "Con").siblings("div:not(#server1Con)").hide();
        }


        // 楼层4
        $('.j-index-tab li').click(function () {
            $(this).addClass('active').siblings().removeClass('active');
        });

        var isSelected =  $(".drop-down-title").find("input[type='radio']").eq(0).attr("checked");
        isSelected ? "" :  $(".drop-down-title").find("input[type='radio']").eq(0).attr("checked", "checked");

        $('#inserver-time-cobbox').combobox({
            valueField: 'type',
            textField: 'text',
            data: [
                {
                    type: '1',
                    text: '        最近一天',
                    selected: true
                },
                {
                    type: '7',
                    text: '        最近一周'
                },
                {
                    type: '14',
                    text: '        最近两周'
                },
                {
                    type: '30',
                    text: '        最近一个月'
                }
            ],
            width: '100%',
            height: '40px',
            onSelect: function (row) {
                searchKpis();
            }
        });

        $(".drop-down-title").find("input[type='radio']").on("change", function () {
            var isChecked = $(this).is(':checked');
            setTimeout(searchKpis, 1000);

        });
        function _searchKpis(options) {
            return function () {
                searchKpis(options);
            }
        }

        function GetPercent(num, total) {
            num = parseFloat(num);
            total = parseFloat(total);
            if (isNaN(num) || isNaN(total)) {
                return "-";
            }
            return total <= 0 ? "0%" : (Math.round(num / total * 10000) / 100.00 + "%");
        }

        function setStatusTime(day, hour, minute) {
            $("#inhost-day").empty();
            $("#inhost-day").append(day);
            $("#inhost-hour").empty();
            $("#inhost-hour").append(hour);
            $("#inhost-min").empty();
            $("#inhost-min").append(minute);
        }


//        $.ajax({
//            url: '../../cephMonitor/getCephName.do',
//            dataType: 'JSON',
//            async: false,
//            success: function (data) {
//                var cephName = data.cephname;
//                $("#objectid").text(cephName);
//            }
//        });







        function searchKpis() {

            var times = $('#inserver-time-cobbox').combobox("getValue");

            var kpi = "";
            var _legend = {};
            var _dataLegend = [];
            var abc = $(".drop-down-title").find("input[type='radio']").length;
            var lengthKpiChecked = $(".index-dropdown").find("input[type='radio']:checked").length;
            if (lengthKpiChecked <= 0) {
                alert("必须选中一个查看的指标！");
                return;
            }
            var nameY = "";
            $(".index-dropdown").find("input[type='radio']:checked").each(function (i) {
                if (i > 0) {
                    kpi += "," + $(this).val();
                } else {

                    kpi += $(this).val();

                }
                nameY = $(this).attr("title");

                _dataLegend.push({'name': $(this).next().eq(0).text()});
            });
//            nameY =  $(".index-dropdown").find("input[type='radio']:checked")[0].attr("name");
            _legend.data = _dataLegend;


            $.ajax({
                url: '../../cephMonitor/getKpisInfo.do',
                dataType: 'JSON',
                method: 'POST',
                data: {
                    kpis: kpi,
                    times: times,
                    tableName:'pmd_security',
                    objectId: $("#objectid").val()
                },
                success: function (data) {

                    data.nameY = nameY;
                    drawLine(data, _legend);
                }
            });
        }

        function loadDeviceInfo(){

            var _times = $('#inserver-time-cobbox').combobox("getValue");
            $.ajax({
                url: '../../cephMonitor/getKpisInfo.do',
                dataType: 'JSON',
                method: 'POST',
                data: {
                    kpis: "cpuusage",
                    times: _times,
                    tableName: 'pmd_security',
                    objectId: $("#objectid").val()
                },
                success: function (data) {

                    var _legend = {};
                    var _dataLegend = [];
                    _dataLegend.push({'name': "CPU利用率"});
                    _legend.data = _dataLegend;
                    data.nameY = "CPU利用率(%)";
                    data.divId = "devicestatusCpu";
                    var title = {};
                    title.text="CPU利用率";

                    data.title = title;
                    drawLine(data, _legend);
                }
            });

            $.ajax({
                url: '../../cephMonitor/getKpisInfo.do',
                dataType: 'JSON',
                method: 'POST',
                data: {
                    kpis: "memusage",
                    times: _times,
                    tableName: 'pmd_security',
                    objectId: $("#objectid").val()
                },
                success: function (data) {

                    var _legend = {};
                    var _dataLegend = [];
                    _dataLegend.push({'name': "内存利用率"});
                    _legend.data = _dataLegend;
                    data.nameY = "内存利用率(%)";
                    data.divId = "devicestatusMem";
                    var title = {};
                    title.text="内存利用率";

                    data.title = title;
                    drawLine(data, _legend);
                }
            });


        }

        function drawLine(cfg, legend) {
            var divId = "index1Con";
            if(cfg.divId){
                divId = cfg.divId;
            }
            var chartContainer = document.getElementById(divId);
            optionLine.legend = legend;
            optionLine.xAxis[0].data = cfg['cateX'];
            optionLine.series = cfg['dataSeri'];
            optionLine.yAxis[0].name = cfg['nameY'];
            optionLine.title = cfg['title'];
            $(optionLine.series).each(function (i) {
                var element = optionLine.series[i];
                var _name = element['name'];
                element["name"] = $(".index-dropdown").find("input[value='" + _name + "']").next().eq(0).text();
                element["itemStyle"] = {normal: {areaStyle: {type: 'default'}}};
            });
            //加载图表
            var myChart = echarts.init(chartContainer);
            myChart.setOption(optionLine);

        }


        function drawBar(cfg,divId){
            var option = {
                title : {
                    text: cfg['title']

                },
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    data:['攻击数']
                },
                toolbox: {
//                    show : true,
//                    feature : {
//                        mark : {show: true},
//                        dataView : {show: true, readOnly: false},
//                        magicType : {show: true, type: ['line', 'bar']},
//                        restore : {show: true},
//                        saveAsImage : {show: true}
//                    }
                },
                calculable : true,
                xAxis : cfg['xAxis'],
                yAxis: cfg['yAxis'],
                series: cfg['seris']
            };

            var chartContainer = document.getElementById(divId);
            //加载图表
            var myChart = echarts.init(chartContainer);
            myChart.setOption(option);

        }


    });

    function JumpGjPage(ele) {
        var neid = $(ele).next().val();
        var orgUrl = '/icpmg/web/alarmMg/eventActive.jsp';

        //alert(neid);
        $('#centerTab').panel({
            href: encodeURI(orgUrl),
            queryParams: {
                typeid: 'HOST',
                neid: neid
            }
        });
    }
</script>
</body>
</html>

