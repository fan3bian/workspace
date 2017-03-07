/**
 * Created by liuenqi on 2016/10/14.
 */
var listener_list = new Array();
var background_server_list = new Array();
var cell_width = $("#port_monitor_dg").width() / 9;
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
            href: "/icpmg/web/omsMonitor/network/jsp/lbsOverview.jsp"
        });
    } else {
        $('#centerTab').panel({
            href: '/icpmg/web/omsMonitor/network/jsp/networkDetailOverview.jsp',
            queryParams: {
                typeid: 'LSB',
                neid: value
            }
        });
    }
};
function kpiSelect(i, e) {
    if ($("#listener_select").combobox('getText') != '监听器选择') {
        if ($("#bg_server_select").combobox('getText') != '后端服务选择') {
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
                    url: context_path + "/networkrunoverview/getLBSChartData.do?objid=" + objid + "&listenid="
                    + $("#listener_select").combobox('getText') + "&serverid=" + $("#bg_server_select").combobox('getText')
                    + "&kpiid=" + e.prop("name") + "&timerange=all",
                    success: function (value) {
                        var y_title;
                        var kpi_time = new Array();
                        var kpi_value = new Array();
                        switch (e.prop("name")) {
                            case "bin":
                            case "bout":
                                y_title = 'Bps';
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
        } else {
            alert("请选择后端服务器");
            e.prop("checked", false);
        }
    } else {
        alert("请选择监听器");
        e.prop("checked", false);
    }
};
/*获取顶部信息*/
$("#oname").append(objid);
$.ajax({
    type: 'POST',
    async: false,
    dataType: 'json',
    url: context_path + "/networkrunoverview/getNetworkBasicInfo.do?objid=" + objid + "&typeid=LBS",
    success: function (value) {
        $(".status_cpumem_info span").append(value[0].ip);
        $(".status_warning_info span").append(value[0].alarmcount);
        $(".status_uptime_info span").append(value[0].curstat);
        if (value[0].curstat == "Running" || value[0].curstat == "running" || value[0].curstat == "UP" || value[0].curstat == "OPEN") {
            $("#status_img").attr("id", "status_img");
        } else {
            $("#status_img").attr("id", "status_error_img");
        }
    }
});
/*获取后端服务器*/
$("#bg_server_select").combobox({
    width: 226,
    height: 30,
    valueField: 'id',
    textField: 'name',
    editable: false,
    onShowPanel: function () {
        if ($("#listener_select").combobox('getText') == "监听器选择") {
            alert("请先选择监听器");
            $("#bg_server_select").combobox('hidePanel');
        }
    }
});
function twoCombobox(listport) {
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + '/lb/gettwolist.do?lbid=' + objid + '&listport=' + listport,
        success: function (value) {
            background_server_list = [];
            if (value.length > 1) {
                for (var i = 1; i < value.length; i++) {
                    background_server_list.push(value[i]);
                }
            }
            $("#bg_server_select").combobox({
                data: background_server_list
            });
        }
    });
};
/*时间范围切换*/
$(".date-tab li:eq(0)").click(function () {
    $(".date-tab li").removeClass("active")
    $(this).addClass("active");
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/networkrunoverview/getLBSChartData.do?objid=" + objid + "&listenid="
        + $("#listener_select").combobox('getText') + "&serverid=" + $("#bg_server_select").combobox('getText')
        + "&kpiid=" + $("*[type='checkbox']:checked").attr("name") + "&timerange=all",
        success: function (value) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "bin":
                case "bout":
                    y_title = 'Bps';
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
        url: context_path + "/networkrunoverview/getLBSChartData.do?objid=" + objid + "&listenid="
        + $("#listener_select").combobox('getText') + "&serverid=" + $("#bg_server_select").combobox('getText')
        + "&kpiid=" + $("*[type='checkbox']:checked").attr("name") + "&timerange=1",
        success: function (value) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "bin":
                case "bout":
                    y_title = 'Bps';
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
        url: context_path + "/networkrunoverview/getLBSChartData.do?objid=" + objid + "&listenid="
        + $("#listener_select").combobox('getText') + "&serverid=" + $("#bg_server_select").combobox('getText')
        + "&kpiid=" + $("*[type='checkbox']:checked").attr("name") + "&timerange=7",
        success: function (value) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "bin":
                case "bout":
                    y_title = 'Bps';
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
        url: context_path + "/networkrunoverview/getLBSChartData.do?objid=" + objid + "&listenid="
        + $("#listener_select").combobox('getText') + "&serverid=" + $("#bg_server_select").combobox('getText')
        + "&kpiid=" + $("*[type='checkbox']:checked").attr("name") + "&timerange=15",
        success: function (value) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "bin":
                case "bout":
                    y_title = 'Bps';
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
        url: context_path + "/networkrunoverview/getLBSChartData.do?objid=" + objid + "&listenid="
        + $("#listener_select").combobox('getText') + "&serverid=" + $("#bg_server_select").combobox('getText')
        + "&kpiid=" + $("*[type='checkbox']:checked").attr("name") + "&timerange=30",
        success: function (value) {
            var y_title;
            var kpi_time = new Array();
            var kpi_value = new Array();
            switch ($("*[type='checkbox']:checked").attr("name")) {
                case "bin":
                case "bout":
                    y_title = 'Bps';
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
/*获取监听器*/
$.ajax({
    type: 'POST',
    async: false,
    dataType: 'json',
    url: context_path + '/lb/getonelist.do?lbid=' + objid,
    success: function (value) {
        for (var i = 1; i < value.length; i++) {
            listener_list.push(value[i]);
        }
    }
});
$("#listener_select").combobox({
    width: 226,
    height: 30,
    valueField: 'id',
    textField: 'name',
    editable: false,
    data: listener_list,
    onSelect: function (rec) {
        twoCombobox(rec.id);
    }
});
$("#port_monitor_dg").treegrid({
    height: 300,
    idField: 'id',
    treeField: 'id',
    fitColumns: true,
    singleSelect: true,
    columns: [[
        {field: 'id', title: '监控名称', align: 'left', halign: 'center', width: cell_width + 40},
        {field: 'rtime', title: '响应延迟时间', align: 'center', halign: 'center', width: cell_width},
        {field: 'scur', title: '请求数(并发连接数)', align: 'center', halign: 'center', width: cell_width + 12},
        {field: 'hrsp1xx', title: '正确响应数1', align: 'center', halign: 'center', width: cell_width - 10},
        {field: 'hrsp2xx', title: '正确响应数2', align: 'center', halign: 'center', width: cell_width - 10},
        {field: 'hrsp3xx', title: '正确响应数3', align: 'center', halign: 'center', width: cell_width - 10},
        {field: 'hrsp4xx', title: '正确响应数4', align: 'center', halign: 'center', width: cell_width - 10},
        {field: 'hrsp5xx', title: '正确响应数5', align: 'center', halign: 'center', width: cell_width - 10},
        {field: 'stot', title: 'TCP累计连接数', align: 'center', halign: 'center', width: cell_width},
    ]],
    url: context_path + "/networkrunoverview/getLBSTreeData.do?objid=" + objid
});