/**
 * Created by liuenqi on 2016/9/7.
 */
var flowin_speed = new Array();
var flowout_speed = new Array();
var net_device_flowin = new Array();
var net_device_flowout = new Array();
var net_device_flowin_name = new Array();
var net_device_flowout_name = new Array();
/*顶部状态块点击事件*/
$(".single_block:eq(0)").click(function () {
    $(".single_block").each(function () {
        $(this).removeClass("single_block_selected");
    })
    $(".single_block:eq(0)").addClass("single_block_selected");
    $("#dg_monitor_net_list").datagrid({
        url: context_path + "/networkmonitor/getNetDeviceInfo.do?type=all"
    });
    $("#dg_monitor_net_list").datagrid('getPager').pagination({
        pageSize: 10,
        layout: ['first', 'prev', 'sep', 'manual', 'sep', 'next', 'last']
    });
});
$(".single_block:eq(1)").click(function () {
    $(".single_block").each(function () {
        $(this).removeClass("single_block_selected");
    })
    $(".single_block:eq(1)").addClass("single_block_selected");
    $("#dg_monitor_net_list").datagrid({
        url: context_path + "/networkmonitor/getNetDeviceInfo.do?type=stop"
    });
    $("#dg_monitor_net_list").datagrid('getPager').pagination({
        pageSize: 10,
        layout: ['first', 'prev', 'sep', 'manual', 'sep', 'next', 'last']
    });
});
$(".single_block:eq(2)").click(function () {
    $(".single_block").each(function () {
        $(this).removeClass("single_block_selected");
    })
    $(".single_block:eq(2)").addClass("single_block_selected");
    $("#dg_monitor_net_list").datagrid({
        url: context_path + "/networkmonitor/getNetDeviceInfo.do?type=new"
    });
    $("#dg_monitor_net_list").datagrid('getPager').pagination({
        pageSize: 10,
        layout: ['first', 'prev', 'sep', 'manual', 'sep', 'next', 'last']
    });
});
$(".single_block:eq(3)").click(function () {
    $(".single_block").each(function () {
        $(this).removeClass("single_block_selected");
    })
    $(".single_block:eq(3)").addClass("single_block_selected");
    $("#dg_monitor_net_list").datagrid({
        url: context_path + "/networkmonitor/getNetDeviceInfo.do?type=offline"
    });
    $("#dg_monitor_net_list").datagrid('getPager').pagination({
        pageSize: 10,
        layout: ['first', 'prev', 'sep', 'manual', 'sep', 'next', 'last']
    });
});
/*获取顶部状态*/
$.ajax({
    type: 'POST',
    async: false,
    dataType: 'json',
    url: context_path + "/networkmonitor/getNetStatusCount.do?type=network",
    success: function (value) {
        $("#count_all").next().append(value.allcount);
        $("#count_offline").next().append(value.stopcount);
        $("#count_new").next().append(value.newcount);
        $("#count_clear").next().append(value.offlinecount);
    }
});
/*获取网络设备Top信息*/
$.ajax({
    type: 'POST',
    async: false,
    dataType: 'json',
    url: context_path + "/networkmonitor/getNetDeviceFlow.do?type=network",
    success: function (value) {
        var flow_in = value.flowInTop;
        var flow_out = value.flowOutTop;
        for (var i = 0; i < flow_in.length; i++) {
            net_device_flowin_name.push(flow_in[i].oname);
            net_device_flowin.push(flow_in[i].networkname);
            flowin_speed.push(flow_in[i].flow);
        }
        for (var i = 0; i < flow_out.length; i++) {
            net_device_flowout_name.push(flow_out[i].oname);
            net_device_flowout.push(flow_out[i].networkname);
            flowout_speed.push(flow_out[i].flow);
        }
    }
});
/*获取告警统计单元格宽度*/
var warn_info_cell_width = $(".warn_info").width() / 7;
/*设备监控单元格宽度*/
var device_monitor_cell_width = $("#dg_monitor_net_list").width() / 12;
/*网络设备监控*/
$("#dg_monitor_net_list").datagrid({
    height: 300,
    method: 'POST',
    singleSelect: true,
    pagination: true,
    columns: [[
        {
            field: 'oname', title: '设备名称', align: 'center', width: device_monitor_cell_width - 5,
            formatter: function (value, row, index) {
                var objid = row.objectid;
                return "<span style='color: blue; cursor: pointer;' onclick=\"JumpPage('" + objid + "')\"> " + value + "  </span>"
            }
        },
        {field: 'version', title: '设备型号', align: 'center', width: device_monitor_cell_width - 20},
        {field: 'typeid', title: '设备类型', align: 'center', width: device_monitor_cell_width - 29},
        {
            field: 'curstat', title: '健康状态', align: 'center', width: device_monitor_cell_width - 25,
            formatter: function (value, row, index) {
                if (value != "运行中") {
                    return "<span style='color: red'>" + value + "</span>";
                } else {
                    return value;
                }
            }
        },
        {field: 'ip', title: '管理IP', align: 'center', width: device_monitor_cell_width - 7},
        {field: 'runningtime', title: '运行时长', align: 'center', width: device_monitor_cell_width + 77},
        {field: 'cpuusage', title: 'CPU利用率(%)', align: 'center', width: device_monitor_cell_width + 3},
        {field: 'memusage', title: '内存利用率(%)', align: 'center', width: device_monitor_cell_width + 7},
        {
            field: 'pingdiscardpent',
            title: '丢包率(%)',
            align: 'center',
            width: device_monitor_cell_width - 22
        },
        {field: 'inspeed', title: '端口流入速率(KB/s)', align: 'center', width: device_monitor_cell_width + 27},
        {field: 'outspeed', title: '端口流出速率(KB/s)', align: 'center', width: device_monitor_cell_width + 27},
        {
            field: 'detail', title: '运行概况', align: 'center',
            styler: function () {
                return 'border-right : none';
            },
            formatter: function (value, row, index) {
                var objid = row.neid;
                return "<span style='color: blue; cursor: pointer;' onclick=\"JumpNetWorkRunPage('NETWORK','" + objid + "')\">运行概况</span>"
            }
        }
    ]],
    url: context_path + "/networkmonitor/getNetDeviceInfo.do?type=all"
});
$("#dg_monitor_net_list").datagrid('getPager').pagination({
    pageSize: 10,
    layout: ['first', 'prev', 'sep', 'manual', 'sep', 'next', 'last']
});
$("#dg_warn_info").datagrid({
    singleSelect: true,
    columns: [[
        {field: 'type', title: '类型', align: 'center', width: warn_info_cell_width},
        {field: 'serious', title: '严重', align: 'center', width: warn_info_cell_width},
        {field: 'main', title: '主要', align: 'center', width: warn_info_cell_width},
        {field: 'second', title: '次要', align: 'center', width: warn_info_cell_width},
        {field: 'general', title: '一般', align: 'center', width: warn_info_cell_width},
        {field: 'warn', title: '警告', align: 'center', width: warn_info_cell_width + 1},
        {
            field: 'count', title: '总数', align: 'center', width: warn_info_cell_width + 1,
            styler: function () {
                return 'border-right : none';
            }
        }
    ]],
    url: context_path + "/networkmonitor/getAlarmInfo.do?type=network"
});
var flowInChart = echarts.init(document.getElementById('flow_in_chart'));
var flowOutChart = echarts.init(document.getElementById('flow_out_chart'));
flowInChart.setOption({
    title: {
        text: '端口流入速率Top10',
        textStyle: {
            fontWeight: 'normal',
            fontSize: 14
        },
        top: 10,
        left: 10
    },
    tooltip: {
        show: true,
        formatter: function (parm) {
            return "<div class='tooltip_cicrle'></div>名称：" + net_device_flowin_name[parm.dataIndex] + " - " + net_device_flowin[parm.dataIndex] + "<br><div class='tooltip_cicrle'></div>流速：" + parm.data + "KB/s";
        }
    },
    color: ['#3398DB'],
    backgroundColor: '#FFFFFF',
    yAxis: [{
        type: 'value'
    }],
    xAxis: [{
        type: 'category',
        axisLabel: {
            interval: 0
        },
        data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        axisTick: {
            show: false
        }
    }],
    series: [{
        type: 'bar',
        data: flowin_speed
    }]
});
flowOutChart.setOption({
    title: {
        text: '端口流出速率Top10',
        textStyle: {
            fontWeight: 'normal',
            fontSize: 14
        },
        top: 10,
        left: 10
    },
    tooltip: {
        show: true,
        formatter: function (parm) {
            return "<div class='tooltip_cicrle'></div>名称：" + net_device_flowout_name[parm.dataIndex] + " - " + net_device_flowout[parm.dataIndex] + "<br><div class='tooltip_cicrle'></div>流速：" + parm.data + "KB/s";
        }
    },
    color: ['#3398DB'],
    backgroundColor: '#FFFFFF',
    yAxis: [{
        type: 'value'
    }],
    xAxis: [{
        type: 'category',
        axisLabel: {
            interval: 0
        },
        data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        axisTick: {
            show: false
        }
    }],
    series: [{
        type: 'bar',
        data: flowout_speed
    }]
});