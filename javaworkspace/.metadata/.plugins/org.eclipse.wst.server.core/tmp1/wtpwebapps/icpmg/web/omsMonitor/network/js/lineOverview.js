/**
 * Created by zhangxiaoyu on 2016/10/26.
 */
var flowin_speed = new Array();
var flowout_speed = new Array();
var net_device_flowin = new Array();
var net_device_flowout = new Array();
function JumpPage(value) {
    $('#centerTab').panel({
        href: '/icpmg/web/omsMonitor/network/jsp/networkDetailOverview.jsp',
        queryParams: {
            typeid: 'ZLINE',
            neid: value
        }
    });
};
function JumpNetWorkRunPage(typeid, neid) {
    var url = '/icpmg/web/omsMonitor/network/jsp/networkRunOverview.jsp';
    if (typeid == 'LBS') {
        url = '/icpmg/web/omsMonitor/network/jsp/lbsRunOverview.jsp';
    }
    if (typeid == 'ZLINE') {
        url = '/icpmg/web/omsMonitor/network/jsp/lineRunOverview.jsp';
    }
    $('#centerTab').panel({
        href: url,
        queryParams: {
            typeid: typeid,
            neid: neid
        }
    });
};
/*顶部状态块点击事件*/
$(".single_block:eq(0)").click(function () {
    $(".single_block").each(function () {
        $(this).removeClass("single_block_selected");
    })
    $(".single_block:eq(0)").addClass("single_block_selected");
    $("#dg_monitor_net_list").datagrid({
        url: context_path + "/networkmonitor/getZLineInfo.do?type=all"
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
        url: context_path + "/networkmonitor/getZLineInfo.do?type=stop"
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
        url: context_path + "/networkmonitor/getZLineInfo.do?type=new"
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
        url: context_path + "/networkmonitor/getZLineInfo.do?type=offline"
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
    url: context_path + "/networkmonitor/getNetStatusCount.do?type=ZLINE",
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
    url: context_path + "/networkmonitor/getNetDeviceFlow.do?type=ZLINE",
    success: function (value) {
        var flow_in = value.flowInTop;
        var flow_out = value.flowOutTop;
        for (var i = 0; i < flow_in.length; i++) {
            net_device_flowin.push(flow_in[i].networkname);
            flowin_speed.push(flow_in[i].flow);
        }
        for (var i = 0; i < flow_out.length; i++) {
            net_device_flowout.push(flow_out[i].networkname);
            flowout_speed.push(flow_out[i].flow);
        }
    }
});
/*获取告警统计单元格宽度*/
var warn_info_cell_width = $(".warn_info").width() / 7;
/*设备监控单元格宽度*/
var device_monitor_cell_width = $("#dg_monitor_net_list").width() / 11;
/*网络设备监控*/
$("#dg_monitor_net_list").datagrid({
    height: 300,
    method: 'POST',
    singleSelect: true,
    pagination: true,
    columns: [[
        {
            field: 'oname', title: '专线名称', align: 'center', width: device_monitor_cell_width + 3,
            formatter: function (value, row, index) {
                var objid = row.objectid;
                return "<span style='color: blue; cursor: pointer;' onclick=\"JumpPage('" + objid + "')\"> " + value + "  </span>"
            }
        },
        {field: 'portnamein', title: '近端端口', align: 'center', width: device_monitor_cell_width},
        {
            field: 'curstat', title: '专线状态', align: 'center', width: device_monitor_cell_width,
            formatter: function (value, row, index) {
                if (value != "运行中") {
                    return "<span style='color: red'>" + value + "</span>";
                } else {
                    return value;
                }
            }
        },
        {field: 'ipin', title: '进入端Ip地址', align: 'center', width: device_monitor_cell_width},
        {field: 'ipout', title: '出口端Ip地址', align: 'center', width: device_monitor_cell_width},
        {field: 'totbrandwith', title: '总带宽(Mbps)', align: 'center', width: device_monitor_cell_width},
        {field: 'inusage', title: '接收使用率(%)', align: 'center', width: device_monitor_cell_width},
        {field: 'outusage', title: '发送使用率(%)', align: 'center', width: device_monitor_cell_width},
        {field: 'inlossusage', title: '接收丢包率(%)', align: 'center', width: device_monitor_cell_width},
        {field: 'outlossuasage', title: '发送丢包率(%)', align: 'center', width: device_monitor_cell_width},
        {
            field: 'detail', title: '运行概况', align: 'center', width: device_monitor_cell_width,
            styler: function () {
                return 'border-right : none';
            },
            formatter: function (value, row, index) {
                var objid = row.objectid;
                return "<span style='color: blue; cursor: pointer;' onclick=\"JumpNetWorkRunPage('ZLINE','" + objid + "')\">运行概况</span>"
            }
        }
    ]],
    url: context_path + "/networkmonitor/getZLineInfo.do?type=all"
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
        text: '网络专线接收速率TOP10',
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
            return "<div class='tooltip_cicrle'></div>名称：" + net_device_flowin[parm.dataIndex] + "<br><div class='tooltip_cicrle'></div>流速：" + parm.data + "KB/s";
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
        text: '网络专线发送速率TOP10',
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
            return "<div class='tooltip_cicrle'></div>名称：" + net_device_flowout[parm.dataIndex] + "<br><div class='tooltip_cicrle'></div>流速：" + parm.data + "KB/s";
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