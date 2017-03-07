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

    <link href="../cephMonitor/cssbase/default.css" rel="stylesheet" type="text/css">
    <link href="../cephMonitor/cssbase/regcore.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="easyui-1.4/jquery-1.8.3.min.js" charset="utf-8"></script>
    <link rel="stylesheet" href="easyui-1.4/themes/default/easyui.css" type="text/css">
    <link rel="stylesheet" href="easyui-1.4/themes/icon.css" type="text/css">
    <script type="text/javascript" src="easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
</head>
<body>
<style type="text/css">
    .inserver-error
    {
        background-position: -55px 0;
    }

    #inserver-main
    {
        min-width:1200px;
        min-height:1200px;
    //background-color: red;
    }

    #inserver-head-status
    {
        width: 100%;
        overflow:hidden;
        height: 100px;
        background-color: #fff;
    }
    #inserver-status
    {
        margin-left: 20px;
        width:100px;
        height: 80px;
        float:left;
    }

    #inserver-details
    {
        height:70px;
        width:380px;
        float:left;
        margin-top:10px;
        overflow:hidden;
        background-color: #EEEEEE;
    }
    #inserver-nename
    {
        margin-left: 20px;
        margin-top: 8px;
        width:100%;
        font-size:13px;
    }
    #inserver-ipaddr
    {
        margin-left: 20px;
        margin-top:5px;
        font-size:13px;
    }

    #inserver-alarm
    {
        height:70px;
        width:120px;
        float:left;
        margin-left: 10px;
        margin-top:10px;
        background-color: #EEEEEE;
        line-height: 70px;
        font-size: 14px;
    }
    #inserver-running-time
    {
        height:70px;
        width:250px;
        float:left;
        margin-left: 10px;
        margin-top:10px;
        background-color: #EEEEEE;
        line-height: 70px;
        font-size: 14px;
    }

    #inserver-compute-zone
    {
        width: 97%;
        height:400px;
        overflow:hidden;
        margin:10px;
        padding:10px;
    }

    #inserver-cpu-zone
    {
        width:45%;
        height:400px;
        float:left;
        margin-right: 3.5%;
    //background-color: blue;
    }
    #inserver-mem-zone
    {
        width:45%;
        height:400px;
        float:left;
    //background-color: blue;
    }

    #inserver-index-monitor-zone
    {
        width:97%;
        height:550px;
        margin: 10px;
    //background-color: green;

    }




    /********************************************************/

    #inserver-index-list-zone {
        width: 15%;
        margin-left:10px;
        margin-right:20px;
        background: white;
        overflow: hidden;
        float:left;
    }
    #inserver-index-list-zone .index-menu .index-list:hover .index-dropdown {
    //display: block !important;
        background: #00B8EE;
    }
    #inserver-index-list-zone .index-menu .index-list .index-title {
        width: 100%;
        height: 50px;
        line-height: 50px;
        background: white;
        color:#4074E1;
        font-size: 18px;
    }
    #inserver-index-list-zone .index-menu .index-list .index-dropdown {
        width: 100%;
        background: #00B8EE;
        display:none;
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

    #inserver-time-cobbox-out
    {
    //float:left;
        margin:10px -1px;
        padding:1px 0;
        width:90%; margin:0 auto;
        background-color: #eee;
    }

    /********************************************************/

    #inserver-index-zone
    {
        width:77%;
        height:530px;
        float:left;
        background-color: white;
    }


    #inserver-single-device-zone2
    {
        width:97%;
        height:450px;
        margin: 10px;
    //background-color: green;

    }


    #inserver-disk-mount-zone
    {
        float:left;
        width:94%;
        height:430px;
        margin: 5px;
        background-color: white;
    }


    #inserver-single-device-zone
    {
        width:97%;
        height:450px;
        margin: 10px;
    //background-color: green;

    }

    #inserver-single-disk-zone
    {
        float:left;
        width:94%;
        height:430px;
        margin: 5px;
        background-color: white;
    }


    #inserver-bottom
    {
        width:100%;
        height:50px;
        margin-top:20px;
    }
</style>
<script type="text/javascript" charset="UTF-8">
    var context_path = '${pageContext.request.contextPath}';
    var ceph_neid = '${pageContext.request.getParameter("neid")}';
</script>
<script src="${pageContext.request.contextPath}/web/omsMonitor/inhost/js/runOverview/echarts-all.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../cephMonitor/css/ceph.css"/>
<div class="wrap" id="">
    <%--{"cephid":"3bd13786-d2ff-4c60-8482-8726b466fe47","collperiod":10,"dataused":35304.00,"diskavail":100070.00,"disktotal":100359.00,"diskused":289.00,
    "monlist":"{ceph1=200.0.20.9:6789/0_ceph2=200.0.20.10:6789/0_ceph3=200.0.20.11:6789/0}","monnum":3,"monver":"e1",
    "objectid":"JNCS-CEPH01","objnum":17000000.00,"osdin":36,"osdnum":36,"osdup":36,"osdver":"e1095","pgbad":8,"pgnum":8584.00,"pgok":8576,
    "pgver":"v91288","poolnum":17,"starttime":"2016-08-15 14:20:00"}--%>
    <!-- 1楼 -->
    <div class="ceph-floor1">
        <img src="../cephMonitor/images/ceph-zt-ok.png" id="imgCephHealth" alt="" width="48px" height="48px" class="ceph-floor1-icon">

        <div class="ceph-floor1-box">
            <ul>
                <li>名称：<span id="objectid"></span></li>
                <li><div class="ceph-floor1-middle">资源位置：<em id="location"></em></div></li>
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
    <div class="ceph-floor" id="overview">
        <div class="floor-title">
            <div class="floor-title-left">Ceph概况</div>
            <div class="floor-title-right">
                <a href="javascript:vois(0)" class="refresh"></a>
            </div>
        </div>
        <div class="floor-con" style="padding-bottom: 0">
            <div class="floor-con-left">
                <dl class="floor-con-item">
                    <dt>MON</dt>
                    <dd>
                        <p class="c-blue" id="countAll"></p>

                        <p>总数</p>
                    </dd>
                    <dd>
                        <p class="c-blue" id="countUp">0</p>

                        <p>在用数</p>
                    </dd>
                    <dd>
                        <p class="c-red" id="countDown">0</p>

                        <p>异常数</p>
                    </dd>
                </dl>
                <dl class="floor-con-item">
                    <dt>统计</dt>
                    <dd>
                        <p class="c-blue" id="poolnum"></p>

                        <p>pool</p>
                    </dd>
                    <dd>
                        <p class="c-blue" id="objnum"></p>

                        <p>对象总数</p>
                    </dd>
                    <dd>
                        <p class="c-blue" id="disktotal"></p>

                        <p>数据容量（G）</p>
                    </dd>
                </dl>
            </div>
            <div class="floor-con-center">
                <dl class="floor-con-item">
                    <dt>OSD</dt>
                    <dd>
                        <p class="c-blue" id="osdnum"></p>

                        <p>总数</p>
                    </dd>
                    <dd>
                        <p class="c-blue" id="osdin"></p>

                        <p>在用数</p>
                    </dd>
                    <dd>
                        <p class="c-green" id="osdup"></p>

                        <p>启动数</p>
                    </dd>
                </dl>
                <dl class="floor-con-item">
                    <dt>PG</dt>
                    <dd>
                        <p class="c-blue" id="pgnum"></p>

                        <p>总数</p>
                    </dd>
                    <dd>
                        <p class="c-blue" id="pgok"></p>

                        <p>正常数</p>
                    </dd>
                    <dd>
                        <p class="c-red" id="pgbad"></p>

                        <p>异常数</p>
                    </dd>
                </dl>
            </div>
            <div class="floor-con-right">
                <div class="floor-con-right-r">
                    <div id="ceph_rate_pie" style=" width: 200px ; height: 150px; background: #eee; margin: 0 auto;"></div>
                    <p><span class="count" name="disktotal">总<i class="c-blue" ></i></span> <span class="count" id="diskPercent">利用率</span></p>

                    <p><span class="count-two" id="diskavail">可用</span> <span class="count-already" id="diskused">已用</span></p>
                </div>
                <div class="floor-con-right-l">
                    <p>节点数：<span class="c-blue" id="nenum"> 36</span></p>

                    <p>异常数：<span class="c-blue">0</span></p>

                    <p>存储盘数：<span class="c-blue" id="diskused"></span></p>
                </div>
            </div>
        </div>
    </div>
    <!-- 3楼 -->
    <div class="ceph-floor" id="cephservers">
        <div class="floor-title">
            <div class="floor-title-left j-tab">
                <ul>
                    <%--<li class="active" id="server1">服务器1</li>--%>
                    <%--<li id="server2">服务器2</li>--%>
                    <%--<li id="server3">服务器3</li>--%>
                    <%--<li id="server4">服务器4</li>--%>
                </ul>
            </div>
        </div>
        <div class="floor-con">
            <div id="server1Con" name="123" class="j-tab-con">
                <p class="floor-con-survey"><span>CPU负荷：80%</span> <span>内存利用率：45%</span> <span>带宽利用率：68%</span></p>
            </div>
        </div>
        <%--<div id="server2Con" class="j-tab-con" style="display: none">服务器2</div>--%>
        <%--<div id="server3Con" class="j-tab-con" style="display: none">服务器3</div>--%>
        <%--<div id="server4Con" class="j-tab-con" style="display: none">服务器4</div>--%>
    </div>
</div>
<!-- 四楼 -->

<div class="ceph-floor">
    <div class="floor-title">
        <div class="floor-title-left ">
            指标监控
        </div>
    </div>
    <div class="floor-con" style="padding-bottom: 0" >
        <div  id="inserver-index-list-zone"  style="margin-top:12px;padding-bottom:20px; border-right:1px solid #ddd">
        <div class="index-menu">
            <div class="index-list">
                <p class="index-title">&nbsp;&nbsp;时间范围选择</p>
                <p id="inserver-time-cobbox-out" >
                    <input id="inserver-time-cobbox"  style="width:130px;" />
                </p>
            </div>

            <div class="index-list">
                <p class="index-title">&nbsp;&nbsp;计算指标选择</p>
                <div class="index-dropdown" style="display: block;">
                    <p class="drop-down-title">
                        &nbsp;&nbsp;&nbsp;<input type="radio" name="kpis" id="objectnum-box" value="objnum" title="个">
                       <span> 对象总数</span>
                    </p>
                    <p class="drop-down-title">
                        &nbsp;&nbsp;&nbsp;<input type="radio" name="kpis" id="mem-box" value="dataused" title="G">
                       <span>数据容量</span>
                    </p>
                    <p class="drop-down-title">
                        &nbsp;&nbsp;
                        <input type="radio" name="kpis" id="usedRadio-box" value="usedRadio" title="利用率(%)">
                       <span>空间利用率</span>
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
<!-- 5楼 -->
<div class="ceph-floor" id="cephpool">
    <div class="floor-title">
        <div class="floor-title-left ">
            Pool概览 <span class="floor-title-tot" name="total"> </span>
            <span class="floor-title-tot" name="used"></span></div>
    </div>
    <div class="floor-con">
        <div class="pool-wrap">

        </div>
    </div>
</div>
</div>
</div>
</div>
<script type="application/javascript">
    $(function () {
        var  optionLine = {

            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['objnum','dataused']
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
	      	dataZoom : 
	      	{
		        show : true
	    	},
            xAxis : [
                {
                    type : 'category',
                    name:"时间",
                    boundaryGap : false,
                    data:[]
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series : [
                {
                    name:'对象总数',
                    type:'line',
                    itemStyle: {normal: {areaStyle: {type: 'default'}}},
                    data:[]
                }

            ]
        };

        var serverRowCellNum = 6;
        // 楼层3tab切换 楼层4趋势图切换
        function liSelected() {
            $(this).addClass('active').siblings().removeClass('active');
            $("#" + $(this).attr('id') + "Con").show();
            $("#" + $(this).attr('id') + "Con").siblings("div:not(#server1Con)").hide();
        }

        $(".j-tab li").click(liSelected);
        // 槽位切换
        $(".j-disk ").click(function () {
            var obj = $(this).parents('.j-tab-con'); //当面面板
            $(obj).find(".j-disk ").removeClass('active');
            $(this).addClass('active');
            var ky = $(this).find('.j-tot em').html() - $(this).find('.j-already em').html();

            $('.j-disk-info .info-title').html($(this).find('.disk-middle-l').text()); //磁盘名
            $('.j-disk-info .info-tem').html($(this).find('.disk-middle-r').text()); //温度
            $('.j-disk-info .info-per-r').html($(this).find('.j-tot').text()); //总共
            $('.j-disk-info .info-per-l').html(ky + "G可用"); //可用
            //百分占比
            infoPer = ky / $(this).find('.j-tot em').html() * 100 + '%';
            $('#infoPer').css({
                width: infoPer
            });
            //读写趋势图
        });
        // 楼层4
        $('.j-index-tab li').click(function () {
            $(this).addClass('active').siblings().removeClass('active');
        });

        var isSelected = jQuery("#objectnum-box").attr("checked");
        isSelected?"":jQuery("#objectnum-box").attr("checked","checked");

        $('#inserver-time-cobbox').combobox({
            valueField:'type',
            textField:'text',
            data:
                    [
                        {
                            type: '1',
                            text: '        最近一天',
                            selected:true
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
            width:'100%',
            height:'40px',
            onSelect:function(row)
            {
               searchKpis();
            }
        });

        $(".drop-down-title").find("input[type='radio']").on("change", function () {
            var isChecked = $(this).is(':checked');
            setTimeout(searchKpis, 1000);

        });
        function _searchKpis(options){
            return function(){
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

        function setStatusTime(day,hour,minute)
        {
            $("#inhost-day").empty();
            $("#inhost-day").append(day);
            $("#inhost-hour").empty();
            $("#inhost-hour").append(hour);
            $("#inhost-min").empty();
            $("#inhost-min").append(minute);
        }

        
        $.ajax({
        	   url: '../../cephMonitor/getCephName.do',
        	   dataType: 'JSON',
        	   async:false,
        	   success: function (data) {
        		   var cephName = data.cephname;
        		   $("#objectid").text(cephName);
        	   }
        });
        

        searchKpis();

       
           
        
        /**
         * 1 F 和 2F 概况
         * */
        $.ajax({
            url: '../../cephMonitor/getCephOverView.do',
            dataType: 'JSON',
            data: {
                objectId:  $("#objectid").text()
            },
            success: function (data) {
                console.log(data['cephhealth']);
                var _health =  data['cephhealth'];
                if(_health.indexOf("HEALTH_OK") >=0 ){
                    $("#imgCephHealth").attr("src","../cephMonitor/images/ceph-zt-ok.png");
                }
                if(_health.indexOf("HEALTH_WARN") >=0 ){
                    $("#imgCephHealth").attr("src","../cephMonitor/images/status-alarm.png");
                }

                if(_health.indexOf("HEALTH_ERR") >=0 ){
                    $("#imgCephHealth").attr("src","../cephMonitor/images/status-error.png");
                }
                
                $("#imgCephHealth").attr("title",_health);
                		
                var runTime = data['inhostStatusVO'];

                setStatusTime(runTime['day'],runTime['hour'],runTime['minute']);

                var _location = data['nelist'];
                _location = _location.substr(1,_location.length-1);
                var arrLocation = _location.split("/");
                for(var i =0;i<arrLocation.length;i++){
                    if(arrLocation[i].length>2){
                        $("#location").append($("<span>",{
                            html:arrLocation[i].replace("=",":").replace("0_","")+"&nbsp;&nbsp;"
                        }));
                    }
                }
                for (key in data) {
                    $("#overview").children().children().children("dl").children("dd").children("p[id='" + key + "']").text(data[key]);
                    $("#overview .floor-con-right-l").children("p").find("span[id='" + key + "']").text(data[key]);
                    $(".floor-con-right-r").children("p").find("span[id='" + key + "']").append(data[key]+" G");
                    if($(".floor-con-right-r").children("p").find("span[name='" + key + "']").children("i")){
                        $(".floor-con-right-r").children("p").find("span[name='" + key + "']").children("i").append(data[key]+" G");
                    }
                }

                var _used =  data['diskused'];
                var _total = data['disktotal'];
                var _percent = GetPercent(_used,_total);
                $(".floor-con-right-r").children("p").find("span[id='diskPercent']").append(_percent);
                var _data = [];
                var _objUsed = {
                    value:_used,
                    name:"已用"
                };
                var _objAvail = {
                    value:data['diskavail'],
                    name:"已用"
                };
                _data.push(_objUsed);
                _data.push(_objAvail);

                var cfgPie ={};
                cfgPie.data = _data;

                drawPie(cfgPie);

            }


        });
        /**
         * 1 F 和 2F 概况
         * */
        $.ajax({
            url: '../../cephMonitor/getMonInfo.do',
            dataType: 'JSON',
            data: {
                objectId:  $("#objectid").text()
            },
            success: function (data) {
//                debugger;
                for (key in data) {
                    $("#overview").children().children().children("dl").children("dd").children("p[id='" + key + "']").text(data[key]);
//                    $("#overview .floor-con-right-l").children("p").find("span[id='" + key + "']").text(data[key]);
                }
            }


        });


        // 3F servers
        $.ajax({
            url: '../../cephMonitor/getServersInfo.do',
            dataType: 'JSON',
            data: {
                objectId: $("#objectid").text()
            },
            success: function (data) {
                var count = 0;
                for (key in data) {
                    cephServerHandler(key, data);
                    count++;
                }
            }
        });

        function searchKpis(){
            var  kpi = "";
            var _legend = {};
            var _dataLegend = [];
            var abc = $(".drop-down-title").find("input[type='radio']").length;
            var lengthKpiChecked =  $(".index-dropdown").find("input[type='radio']:checked").length;
            if(lengthKpiChecked<=0){
                alert("必须选中一个查看的指标！");
                return ;
            }
            var nameY ="";
            $(".index-dropdown").find("input[type='radio']:checked").each(function(i){
                    if(i>0){
                            kpi += ","+$(this).val();
                    }else{

                            kpi+=$(this).val();

                    }
                nameY = $(this).attr("title");

                _dataLegend.push({'name':$(this).next().eq(0).text()});
            });
//            nameY =  $(".index-dropdown").find("input[type='radio']:checked")[0].attr("name");
            _legend.data = _dataLegend;
            var times =    $('#inserver-time-cobbox').combobox("getValue");

            $.ajax({
                url: '../../cephMonitor/getKpisInfo.do',
                dataType: 'JSON',
                method:'POST',
                data: {
                    kpis: kpi,
                    times: times,
                    objectId: $("#objectid").text()
                },
                success: function (data) {

                    data.nameY = nameY;
                    drawLine(data,_legend);
                }
            });
        }


        /**
        * 第五层 ceph pool处理
         */
        $.ajax({
            url: '../../cephMonitor/getPoolInfo.do',
            dataType: 'JSON',
            data: {
                objectId: $("#objectid").text()
            },
            success: function (data) {
                var count = 0;
//              alert($("#cephpool").children("div").eq(1).children("div").eq(0).children("div").children("ul").html());
//              returnpool
//            cephPoolHandler(data);
                poolHandler(data);
            }
        });


        // pool 这一层 上边的title ul li 的处理
        function poolHandler(data) {
          //  alert(data.length);

//            共个Pool
            $("#cephpool").find("span[class='floor-title-tot'][name='total']").text("共: "+data.lisPmdCephPool.length+"个pool");
            $("#cephpool").find("span[class='floor-title-tot'][name='used']").text("总占用率: "+data.mapUsedRadio.totalusage +"%");



            var ulElement = $("<ul>", {
                class: 'j-tab floor-pool'
            });
            $(data.lisPmdCephPool).each(function (i, element) {
                var liElement = null;
                var divElement = null;
                if (i == 0) {
                    liElement = $("<li>", {
                        id: element['objectid'],
                        class: 'active',
                        text: element['oname']
                    });
                    divElement = $("<div>",{
                        id:element['objectid']
                    });

                } else {
                    liElement = $("<li>", {
                        id: element['objectid'],
                        text: element['oname']
                    });
                    divElement = $("<div>",{
                        id:element['objectid'],
                        style:'display: none'
                    });
                }
                liElement.on("click",'',{poolid:element['oname'],onum:+data.lisPmdCephPool[i].onum,usagerate:data.lisPmdCephPool[i].usageRate},handActiveLi);
                ulElement.append(liElement);

                $("#cephpool").children("div[class='floor-con']").children("div[class='pool-wrap']").append(divElement);
            });

            $("#cephpool").children("div[class='floor-con']").children("div[class='pool-wrap']").before(ulElement);

//            alert(  $("#cephpool").children("div[class='floor-con']").children("ul").html());

            $("#cephpool").children("div[class='floor-con']").children("ul").children("li").eq(0).trigger("click");

        }

        /**
         * 5F ceph处理选中的pool ，选中为active的时候的回调函数
         * @param pid
         */
        function handActiveLi(event){

           var divId = event.target.id;

            var onum = event.data.onum;
            var usageRate = event.data.usagerate;

            $(this).addClass('active').siblings().removeClass('active');
//            console.log(event.data.poolid);
            // var poolId = event.data.poolid;
            $.ajax({

                url: '../../cephMonitor/getImageInfo.do',
                dataType: 'JSON',
                method:'POST',
                data: {
                    poolid:event.target.innerHTML
                },
                success: function (data) {
                    cephPoolHandler(data,divId,onum,usageRate )
                }
            })
        }

        // 每个pool 下面的 image的处理
        function cephPoolHandler(data,divId,onum,usageRate) {
            $("#cephpool").children("div[class='floor-con']").children("div[class='pool-wrap']").children("#"+divId).css({display:''}).append($("<ul><li><p>没有符合条件的数据</p></li></ul>")).siblings().css({
                display:'none'
            });

            $("#cephpool").children("div[class='floor-con']").children("div[class='pool-wrap']").children("#"+divId).empty();
            $(data).each(function (i, n) {
//                var pUsed = $("<p />", {
//                    text: "已用:" + n['poolUsed'] ?  n['poolUsed'] : 0
//                });
                var pCapacity = $("<p />", {
                    text: "容量 "+n['imagesize']+" G"
                });
                var pOname = $("<p />", {
//                    text: "用户：" + n['oname']
                    text: ""
                });
                var h6 = $("<h6>", {
                    text: n['objectid']
                });
                var h5 = $("<h5>", {
                    text: i
                });
                var divPolliteml = $("<div>", {
                    class: 'pool-item-l'
                });
                var divPollitemr = $("<div>", {
                    class: 'pool-item-r'
                });
                divPollitemr.append(h5);
                divPollitemr.append(h6);
                divPollitemr.append(pOname);
                divPollitemr.append(pCapacity);
//                divPollitemr.append(pUsed);

                var li = $("<li>");

                li.append(divPolliteml);
                li.append(divPollitemr);
                var ulElement = $("<ul>");
                ulElement.append(li);
//                pool-wrap

                $("#cephpool").children("div[class='floor-con']").children("div[class='pool-wrap']").children("#"+divId).append(ulElement);
            });
//        <p><span class="pool-tot">共7个Pool </span>
//                    <span class="pool-tot">总占用率80%</span></p>


            var pHtml = $("<p>");
            var spanHtmlNum = $("<span>",{text:'共 '+onum+' 个存储对象  '});
            var spanHtmlUsed = $("<span>",{text:'总占用率 '+usageRate+" %"});

            pHtml.append(spanHtmlNum).append(spanHtmlUsed).prependTo($("#cephpool").children("div[class='floor-con']").children("div[class='pool-wrap']").children("#"+divId))


        }

        //  3F 服务器部分的 title ul li 的处理
        function cephServerHandler(key, data, divId) {
            var divId = "#" + key + "Con";
            if ("ceph1" == key.trim()) {
                var objLi = "<li class='active' id='" + key + "'>" + key + "</li>";
                $(".j-tab").children("ul").append("<li class='active' id='" + key + "'>" + key + "</li>");
                $("#cephservers").find("div[class='floor-con']").append($('<div id="' + key + 'Con" class="j-tab-con"></div>'));
                var arrData = data[key];
                var rows =0;
                arrData.length % serverRowCellNum == 0 ?  rows = arrData.length/serverRowCellNum :rows =  Math.floor(arrData.length/serverRowCellNum)+1;
              //  var totalPageNum = (arrData.length  +  pageSize  - 1) / pageSize;
            //    var rows = Math.ceil(arrData.length / serverRowCellNum);
                for (i = 0; i < rows; i++) {
                    if (i == 0) {
                        dataHandler(arrData.slice(0, serverRowCellNum), divId);
                    } else {
                        var begin = (i * serverRowCellNum);
                        var end = (i+1) * serverRowCellNum  > arrData.length ?  arrData.length:(i+1) * serverRowCellNum;
                        dataHandler(arrData.slice(begin, end), divId);
                    }
                }
                $("li[id='" + key + "']").live("click", liSelected);
            } else {
                $("#cephservers").find("div[class='floor-con']").append($('<div id="' + key + 'Con" class="j-tab-con" style="display: none"></div>'));
                $(".j-tab").children("ul").append("<li  id='" + key + "'>" + key + "</li>");
                var arrData = data[key];
                var rows = Math.ceil(arrData.length / serverRowCellNum);
                for (i = 0; i < rows; i++) {
                    if (i == 0) {
                        dataHandler(arrData.slice(0, serverRowCellNum), divId);
                    } else {
                        var begin = (i * serverRowCellNum);
                        var end = (i+1) * serverRowCellNum  > arrData.length ?  arrData.length:(i+1) * serverRowCellNum ;
                        dataHandler(arrData.slice(begin, end), divId);
                    }
                }
                $("li[id='" + key + "']").live("click", liSelected);
            }
        }
        // 3F 服务器的每一小块的处理
        function dataHandler(data, divId) {
            var dl = $('<dl class="floor-con-row">');
            $(data).each(function (i) {
                var tempItem = data[i];

                tempItem['diskid'] ? "" : tempItem['diskid'] = 'sda  ';
                !tempItem['writerate'] ? tempItem['writerate'] = 0 : "";
                tempItem['readrate'] ? "" : tempItem['readrate'] = 0;
                tempItem['usedcap'] ? "" : tempItem['usedcap'] = 0;

                var divDiskItem = $("<div/>", {class: 'disk-item', id: tempItem['diskid']});
                var divTop = $("<div/>", {class: 'disk-top', text: "槽位:"+tempItem['slot']});
                divTop.appendTo(divDiskItem);

                var divdJDisk = $("<div/>", {class: 'disk-main j-disk '});
                var divMiddle = $("<div/>", {class: 'disk-middle'});
                var pDiskmiddleL = $("<div />", {class: 'disk-middle-l', text: '磁盘' + tempItem['diskid'] + "  "});
                var spanIconDisk = $("<span/>", {class: 'icon-disk'});
                spanIconDisk.appendTo(pDiskmiddleL);
                pDiskmiddleL.appendTo(divMiddle);
                var pDiskMiddleR = $("<p/>", {class: 'disk-middle-r', text: tempItem['drivetemperature'].substr(0, 2)+'℃'});
                pDiskMiddleR.appendTo(divMiddle);
                divMiddle.appendTo(divdJDisk);
                divdJDisk.appendTo(divDiskItem);

                tempItem['writerate'] ? "" : tempItem['writerate'] = 0;
                tempItem['readrate'] ? "" : tempItem['readrate'] = 0;

                var divBottom = $("<div/>", {class: 'disk-bottom'});
                var pLine1 = '<p><span class="floor-fl j-tot">共有:<em>' + tempItem['size'] + '</em></span><span class="floor-fr">&nbsp;&nbsp;&nbsp;已用:' + tempItem['usedcap']  + 'GB</span></p>';
                var pLine2 = '<p><span class="floor-fl j-already">写速率(m/s):<em>' + tempItem['writerate'] + '</em></span></p><p><span class="floor-fl">读速率(m/s):' + tempItem['readrate'] + '</span></p>';

              // var pLine1 = '<p><span class="floor-fl j-tot">共有:<em>' + tempItem['size'] + '</em></span><span class="floor-fr">写速率(m/s):' + tempItem['writerate'] + '</span></p>';
              //  var pLine2 = '<p><span class="floor-fl j-already">已用:<em>' + tempItem['usedcap'] + '</em>GB</span><span class="floor-fr">读速率(m/s):' + tempItem['readrate'] + '</span></p>';

                divBottom.append($(pLine1));
                divBottom.append($(pLine2));
                divBottom.appendTo(divDiskItem);

                if (i == 0) {
                    var dt = $("<dt>");
                    divDiskItem.appendTo(dt);
                    dt.appendTo(dl);
                } else {
                    var __dd = $("<dd>",{
                        width:'185px'
                    });
                    divDiskItem.appendTo(__dd);
                    __dd.appendTo(dl);
                }

            });

//            $(divId).empty();
            $(divId).append(dl);

        }
        
       function drawPie(cfgPie){
    	  var option = {
    			    tooltip : {
    			        trigger: 'item',
    			        formatter: "{a} <br/>{b} : {c} ({d}%)"
    			    },
    			    series : [
    			        {
    			            name: '容量',
    			            type: 'pie',
    			            radius : '55%',
    			            center: ['50%', '60%'],
                            data:cfgPie.data,
    			            itemStyle: {
    			                emphasis: {
    			                    shadowBlur: 10,
    			                    shadowOffsetX: 0,
    			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
    			                }
    			            }
    			        }
    			    ]
    			};
    	  
    	  
    	    var chartContainer = document.getElementById("ceph_rate_pie");
            //加载图表
            var myChart = echarts.init(chartContainer);
            myChart.setOption(option);
       } 
        
       
       function drawLine(cfg,legend){
    	    var chartContainer = document.getElementById("index1Con");
           optionLine.legend = legend;
           optionLine.xAxis[0].data = cfg['cateX'];
           optionLine.series = cfg['dataSeri'];
           optionLine.yAxis[0].name=cfg['nameY'];
           $(optionLine.series).each(function (i){
                    var element = optionLine.series[i];

                      var  _name = element['name'];
              var text = $(".index-dropdown").find("input[value='"+_name+"']").next().eq(0).text();
//               alert(_name);
               element["name"] = text;
               element["itemStyle"] = {normal: {areaStyle: {type: 'default'}}};
           });
//           console.log(optionLine.series[0].data);
           //加载图表
           var myChart = echarts.init(chartContainer);
            myChart.setOption(optionLine);
    	  
       }



    });
</script>
</body>
</html>

