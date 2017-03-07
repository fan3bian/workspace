/**
 * Created by liuenqi on 2016/9/22.
 */
var cell_width = $("#port_monitor_dg").width() / 7;
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
        top: '7%',
        left: '3%',
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

function JumpPage(value) {
    if (value == -1) {
        $("#centerTab").panel({
            href: "/icpmg/web/omsMonitor/network/jsp/networkOverview.jsp"
        });
    } else {
        $('#centerTab').panel({
            href: '/icpmg/web/omsMonitor/network/jsp/networkDetailOverview.jsp',
            queryParams: {
                typeid: 'NETWORK',
                neid: value
            }
        });
    }
};
function kpiSelect(i, e, portid) {
    //如果未选择端口则提示选择端口
    if (portid == "端口选择") {
        alert("请选择端口");
        $(".li_checkbox input").prop("checked", false);
    } else if (e.is(":checked")) {
        //选中一个之后取消选中其余选项
        $(".li_checkbox input").each(function (index) {
            if (index == i) {
                return true;
            } else {
                $(this).prop("checked", false);
            }
        });
        //如果选择的是非端口指标设置指标id为-1
        if (!portid) {
            portid = -1;
        }
        getKpiValue(objid, e.prop("name"), portid);
    }
};
function getKpiValue(objid, kpiid, portid) {
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/networkrunoverview/getNetworkKpi.do?objid=" + objid + "&kpiid=" + kpiid
        + "&portid=" + portid + "&timerange=all",
        success: function (data) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            for (var i = 0; i < data.length; i++) {
                kpi_time.push(data[i].time);
                kpi_value.push(data[i].value);
            }
            switch (kpiid) {
                case "pingtime":
                    y_title = "ms";
                    break;
                case "inspeed":
                    y_title = "B/s";
                    break;
                case "outspeed":
                    y_title = "B/s";
                    break;
                default:
                    y_title = "百分比(%)";
                    break;
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
            });
        }
    });
};
/*时间范围切换*/
$(".date-tab li:eq(0)").click(function () {
    $(".date-tab li").removeClass("active")
    $(this).addClass("active");
    var portid = $("*[type='checkbox']:checked").attr("name");
    switch (portid) {
        case "cpuusage":
        case "memusage":
        case "pingtime":
            portid = -1;
            break;
        default:
            portid = $('#port_select').combobox('getText');
            break;
    }
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/networkrunoverview/getNetworkKpi.do?objid=" + objid + "&kpiid="
        + $("*[type='checkbox']:checked").attr("name") + "&portid=" + portid + "&timerange=all",
        success: function (data) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            for (var i = 0; i < data.length; i++) {
                kpi_time.push(data[i].time);
                kpi_value.push(data[i].value);
            }
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "pingtime":
                    y_title = "ms";
                    break;
                case "inspeed":
                    y_title = "B/s";
                    break;
                case "outspeed":
                    y_title = "B/s";
                    break;
                default:
                    y_title = "百分比(%)";
                    break;
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
            });
        }
    });
});
$(".date-tab li:eq(1)").click(function () {
    $(".date-tab li").removeClass("active")
    $(this).addClass("active");
    var portid = $("*[type='checkbox']:checked").attr("name");
    switch (portid) {
        case "cpuusage":
        case "memusage":
        case "pingtime":
            portid = -1;
            break;
        default:
            portid = $('#port_select').combobox('getText');
            break;
    }
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/networkrunoverview/getNetworkKpi.do?objid=" + objid + "&kpiid="
        + $("*[type='checkbox']:checked").attr("name") + "&portid=" + portid + "&timerange=1",
        success: function (data) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            if (data.length != 0) {
                for (var i = 0; i < data.length; i++) {
                    kpi_time.push(data[i].time);
                    kpi_value.push(data[i].value);
                }
            } else {
                kpi_time = [0];
                kpi_value = [0];
            }
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "pingtime":
                    y_title = "ms";
                    break;
                case "inspeed":
                    y_title = "B/s";
                    break;
                case "outspeed":
                    y_title = "B/s";
                    break;
                default:
                    y_title = "百分比(%)";
                    break;
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
            });
        }
    });
});
$(".date-tab li:eq(2)").click(function () {
    $(".date-tab li").removeClass("active")
    $(this).addClass("active");
    var portid = $("*[type='checkbox']:checked").attr("name");
    switch (portid) {
        case "cpuusage":
        case "memusage":
        case "pingtime":
            portid = -1;
            break;
        default:
            portid = $('#port_select').combobox('getText');
            break;
    }
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/networkrunoverview/getNetworkKpi.do?objid=" + objid + "&kpiid="
        + $("*[type='checkbox']:checked").attr("name") + "&portid=" + portid + "&timerange=7",
        success: function (data) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            if (data.length != 0) {
                for (var i = 0; i < data.length; i++) {
                    kpi_time.push(data[i].time);
                    kpi_value.push(data[i].value);
                }
            } else {
                kpi_time = [0];
                kpi_value = [0];
            }
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "pingtime":
                    y_title = "ms";
                    break;
                case "inspeed":
                    y_title = "B/s";
                    break;
                case "outspeed":
                    y_title = "B/s";
                    break;
                default:
                    y_title = "百分比(%)";
                    break;
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
            });
        }
    });
});
$(".date-tab li:eq(3)").click(function () {
    $(".date-tab li").removeClass("active")
    $(this).addClass("active");
    var portid = $("*[type='checkbox']:checked").attr("name");
    switch (portid) {
        case "cpuusage":
        case "memusage":
        case "pingtime":
            portid = -1;
            break;
        default:
            portid = $('#port_select').combobox('getText');
            break;
    }
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/networkrunoverview/getNetworkKpi.do?objid=" + objid + "&kpiid="
        + $("*[type='checkbox']:checked").attr("name") + "&portid=" + portid + "&timerange=15",
        success: function (data) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            if (data.length != 0) {
                for (var i = 0; i < data.length; i++) {
                    kpi_time.push(data[i].time);
                    kpi_value.push(data[i].value);
                }
            } else {
                kpi_time = [0];
                kpi_value = [0];
            }
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "pingtime":
                    y_title = "ms";
                    break;
                case "inspeed":
                    y_title = "B/s";
                    break;
                case "outspeed":
                    y_title = "B/s";
                    break;
                default:
                    y_title = "百分比(%)";
                    break;
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
            });
        }
    });
});
$(".date-tab li:eq(4)").click(function () {
    $(".date-tab li").removeClass("active")
    $(this).addClass("active");
    var portid = $("*[type='checkbox']:checked").attr("name");
    switch (portid) {
        case "cpuusage":
        case "memusage":
        case "pingtime":
            portid = -1;
            break;
        default:
            portid = $('#port_select').combobox('getText');
            break;
    }
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/networkrunoverview/getNetworkKpi.do?objid=" + objid + "&kpiid="
        + $("*[type='checkbox']:checked").attr("name") + "&portid=" + portid + "&timerange=30",
        success: function (data) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            if (data.length != 0) {
                for (var i = 0; i < data.length; i++) {
                    kpi_time.push(data[i].time);
                    kpi_value.push(data[i].value);
                }
            } else {
                kpi_time = [0];
                kpi_value = [0];
            }
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "pingtime":
                    y_title = "ms";
                    break;
                case "inspeed":
                    y_title = "B/s";
                    break;
                case "outspeed":
                    y_title = "B/s";
                    break;
                default:
                    y_title = "百分比(%)";
                    break;
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
            });
        }
    });
});
/*顶部工具栏功能*/
$(".refresh").click(function () {
    $(".date-tab li:eq(0)").trigger('click');
});
/*获取顶部信息*/
$("#oname").append(objid);
$.ajax({
    type: 'POST',
    async: false,
    dataType: 'json',
    url: context_path + "/networkrunoverview/getNetworkBasicInfo.do?objid=" + objid + "&typeid=network",
    success: function (value) {
        $(".status_ip_info span:eq(1)").append(value[0].ip);
        $("#cpuusage").append(value[0].cpuusage);
        $("#memusage").append(value[0].memusage);
        $(".status_warning_info span").append(value[0].alarmcount);
        $(".status_uptime_info span").append(value[0].runningtime);
        if (value[0].curstat == "Running" || value[0].curstat == "running") {
            $("#status_img").attr("id", "status_img");
        } else {
            $("#status_img").attr("id", "status_error_img");
        }
    }
});
$("#port_monitor_dg").datagrid({
    height: 400,
    striped: true,
    singleSelect: true,
    fitColumns: true,
    columns: [[
        {field: 'portdescription', title: '网卡名称', align: 'center', halign: 'center', width: cell_width * 1.5},
        {
            field: 'totusage', title: '带宽/Mbps', align: 'center', halign: 'center', width: cell_width - 20,
            formatter: function (value, row, index) {
                var objid = row.totusage;
                return objid / 1000000;
            }
        },
        {field: 'bandwidthusage', title: '带宽利用率/%', align: 'center', halign: 'center', width: cell_width - 10},
        {field: 'flow', title: '总流速(B/s)', align: 'center', halign: 'center', width: cell_width - 10,},
        {field: 'inspeed', title: '流入速率(B/s)', align: 'center', halign: 'center', width: cell_width - 10},
        {field: 'outspeed', title: '流出速率(B/s)', align: 'center', halign: 'center', width: cell_width},
        {field: 'portstat', title: '运行状态', align: 'center', halign: 'center', width: cell_width - 29}
    ]],
    url: context_path + "/networkrunoverview/getNetworkPortInfo.do?objid=" + objid
});
$("#port_select").combobox({
    width: 226,
    height: 30,
    valueField: 'id',
    textField: 'text',
    editable: false,
    url: context_path + "/networkrunoverview/getNetworkPortList.do?objid=" + objid
});
kpiTrendChart.setOption(kpiTrendOption);