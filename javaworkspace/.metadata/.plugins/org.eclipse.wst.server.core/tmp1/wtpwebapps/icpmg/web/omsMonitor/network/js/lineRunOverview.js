/**
 * Created by liuenqi on 2016/10/18.
 */
var kpiTrendChart = echarts.init(document.getElementById('kpi_trend_chart'));
var kpiTrendOption = {
    tooltip: {
        trigger: 'axis',
        axisPointer: {
            type: 'line'
        }
    },
    dataZoom: {
        show: true
    },
    grid: {
        left: '3%',
        top: '7%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis: [{
        type: 'category',
        boundaryGap: false,
        nameTextStyle: {
            fontWeight: 'bold'
        },
        axisLabel: {
            textStyle: {
                color: '#666',
                fontWeight: 'bold'
            }
        },
        data: []
    }],
    yAxis: {
        show: true,
        position: 'left',
        nameLocation: 'end',
        splitNumber: 10,
        nameTextStyle: {
            fontWeight: 'bold'
        },
        axisLabel: {
            textStyle: {
                color: '#666',
                fontWeight: 'bold'
            }
        },
        type: 'value'
    },
    backgroundColor: '#FFFFFF',
    series: [{
        name: "值",
        type: 'line',
        smooth: true,
        itemStyle: {normal: {areaStyle: {type: 'default'}}},
        data: []
    }]
};
kpiTrendChart.setOption(kpiTrendOption);

function JumpPage(value) {
    if (value == -1) {
        $("#centerTab").panel({
            href: "/icpmg/web/omsMonitor/network/jsp/lineOverview.jsp"
        });
    } else {
        $('#centerTab').panel({
            href: '/icpmg/web/omsMonitor/network/jsp/networkDetailOverview.jsp',
            queryParams: {
                typeid: 'LINE',
                neid: value
            }
        });
    }
};
function kpiSelect(i, e) {
    if (e.is(":checked")) {
        $(".li_checkbox input").each(function (index) {
            if (index == i) {
                return true;
            } else {
                $(this).prop("checked", false);
            }
        });
        /*获取图表信息*/
        $.ajax({
            type: 'POST',
            async: false,
            dataType: 'json',
            url: context_path + "/networkrunoverview/getLineChartData.do?objid=" + objid +
            "&kpiid=" + $("*[type='checkbox']:checked").attr("name") + "&timerange=all",
            success: function (value) {
                var y_title;
                var kpi_time = new Array();
                var kpi_value = new Array();
                switch (e.prop("name")) {
                    case "inusage":
                    case "outusage":
                        y_title = '%';
                        break;
                    case "inspeed":
                    case "outspeed":
                        y_title = 'MB/s';
                        break;
                }
                for (var i = 0; i < value.length; i++) {
                    kpi_time.push(value[i].time);
                    kpi_value.push(value[i].value);
                }
                kpiTrendChart.setOption({
                    yAxis: [{
                        name: y_title
                    }],
                    xAxis: [{
                        data: kpi_time
                    }],
                    series: [{
                        data: kpi_value
                    }]
                })
            }
        });
    } else {
        $(".li_checkbox input").each(function () {
            $(this).removeAttr("disabled");
        });
    }
};
/*获取顶部信息*/
$(".status_ip_info span:eq(0)").append(objid);
$.ajax({
    type: 'POST',
    async: false,
    dataType: 'json',
    url: context_path + "/networkrunoverview/getLineBasicInfo.do?objid=" + objid,
    success: function (value) {
        $(".status_ip_info span:eq(1)").append(value[0].displayname);
        $(".status_cpumem_info span:eq(0)").append(value[0].ipin);
        $(".status_cpumem_info span:eq(1)").append(value[0].ipout);
        $(".status_warning_info span").append(value[0].alarmcount);
        switch (value[0].curstat) {
            case "1":
                $(".status_uptime_info span").append("运行中");
                $("#status_img").attr("id", "status_img");
                break;
            case "2":
                $(".status_uptime_info span").append("停止");
                $("#status_img").attr("id", "status_error_img");
                break;
            case "3":
                $(".status_uptime_info span").append("正在停止");
                $("#status_img").attr("id", "status_error_img");
                break;
            case "4":
                $(".status_uptime_info span").append("启动中");
                $("#status_img").attr("id", "status_error_img");
                break;
            default:
                $(".status_uptime_info span").append(value[0].curstat);
                $("#status_img").attr("id", "status_error_img");
                break;
        }
    }
});
/*时间范围切换*/
$(".date-tab li:eq(0)").click(function () {
    $(".date-tab li").removeClass("active")
    $(this).addClass("active");
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/networkrunoverview/getLineChartData.do?objid=" + objid +
        "&kpiid=" + $("*[type='checkbox']:checked").attr("name") + "&timerange=all",
        success: function (value) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "inusage":
                case "outusage":
                    y_title = '%';
                    break;
                case "inspeed":
                case "outspeed":
                    y_title = 'MB/s';
                    break;
            }
            for (var i = 0; i < value.length; i++) {
                kpi_time.push(value[i].time);
                kpi_value.push(value[i].value);
            }
            kpiTrendChart.setOption({
                yAxis: [{
                    name: y_title
                }],
                xAxis: [{
                    data: kpi_time
                }],
                series: [{
                    data: kpi_value
                }]
            })
        }
    });
});
$(".date-tab li:eq(1)").click(function () {
    $(".date-tab li").removeClass("active")
    $(this).addClass("active");
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/networkrunoverview/getLineChartData.do?objid=" + objid +
        "&kpiid=" + $("*[type='checkbox']:checked").attr("name") + "&timerange=1",
        success: function (value) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "inusage":
                case "outusage":
                    y_title = '%';
                    break;
                case "inspeed":
                case "outspeed":
                    y_title = 'MB/s';
                    break;
            }
            if (value.length != 0) {
                for (var i = 0; i < value.length; i++) {
                    kpi_time.push(value[i].time);
                    kpi_value.push(value[i].value);
                }
            } else {
                kpi_time = [0];
                kpi_value = [0];
            }
            kpiTrendChart.setOption({
                yAxis: [{
                    name: y_title
                }],
                xAxis: [{
                    data: kpi_time
                }],
                series: [{
                    data: kpi_value
                }]
            })
        }
    });
});
$(".date-tab li:eq(2)").click(function () {
    $(".date-tab li").removeClass("active")
    $(this).addClass("active");
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/networkrunoverview/getLineChartData.do?objid=" + objid +
        "&kpiid=" + $("*[type='checkbox']:checked").attr("name") + "&timerange=7",
        success: function (value) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "inusage":
                case "outusage":
                    y_title = '%';
                    break;
                case "inspeed":
                case "outspeed":
                    y_title = 'MB/s';
                    break;
            }
            if (value.length != 0) {
                for (var i = 0; i < value.length; i++) {
                    kpi_time.push(value[i].time);
                    kpi_value.push(value[i].value);
                }
            } else {
                kpi_time = [0];
                kpi_value = [0];
            }
            kpiTrendChart.setOption({
                yAxis: [{
                    name: y_title
                }],
                xAxis: [{
                    data: kpi_time
                }],
                series: [{
                    data: kpi_value
                }]
            })
        }
    });
});
$(".date-tab li:eq(3)").click(function () {
    $(".date-tab li").removeClass("active")
    $(this).addClass("active");
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/networkrunoverview/getLineChartData.do?objid=" + objid +
        "&kpiid=" + $("*[type='checkbox']:checked").attr("name") + "&timerange=15",
        success: function (value) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "inusage":
                case "outusage":
                    y_title = '%';
                    break;
                case "inspeed":
                case "outspeed":
                    y_title = 'MB/s';
                    break;
            }
            if (value.length != 0) {
                for (var i = 0; i < value.length; i++) {
                    kpi_time.push(value[i].time);
                    kpi_value.push(value[i].value);
                }
            } else {
                kpi_time = [0];
                kpi_value = [0];
            }
            kpiTrendChart.setOption({
                yAxis: [{
                    name: y_title
                }],
                xAxis: [{
                    data: kpi_time
                }],
                series: [{
                    data: kpi_value
                }]
            })
        }
    });
});
$(".date-tab li:eq(4)").click(function () {
    $(".date-tab li").removeClass("active")
    $(this).addClass("active");
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/networkrunoverview/getLineChartData.do?objid=" + objid +
        "&kpiid=" + $("*[type='checkbox']:checked").attr("name") + "&timerange=30",
        success: function (value) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "inusage":
                case "outusage":
                    y_title = '%';
                    break;
                case "inspeed":
                case "outspeed":
                    y_title = 'MB/s';
                    break;
            }
            if (value.length != 0) {
                for (var i = 0; i < value.length; i++) {
                    kpi_time.push(value[i].time);
                    kpi_value.push(value[i].value);
                }
            } else {
                kpi_time = [0];
                kpi_value = [0];
            }
            kpiTrendChart.setOption({
                yAxis: [{
                    name: y_title
                }],
                xAxis: [{
                    data: kpi_time
                }],
                series: [{
                    data: kpi_value
                }]
            })
        }
    });
});
$(".refresh").click(function () {
    $(".date-tab li:eq(0)").trigger('click');
});