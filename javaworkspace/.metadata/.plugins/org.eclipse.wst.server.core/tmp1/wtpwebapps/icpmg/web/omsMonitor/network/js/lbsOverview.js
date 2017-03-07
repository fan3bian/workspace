/**
 * Created by liuenqi on 2016/9/29.
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
    $("#dg_monitor_LBS_list").treegrid({
        url: context_path + "/networkmonitor/getLBSInfo.do?type=all"
    });
    $("#dg_monitor_LBS_list").datagrid('getPager').pagination({
        pageSize: 10,
        layout: ['first', 'prev', 'sep', 'manual', 'sep', 'next', 'last']
    });
});
$(".single_block:eq(1)").click(function () {
    $(".single_block").each(function () {
        $(this).removeClass("single_block_selected");
    })
    $(".single_block:eq(1)").addClass("single_block_selected");
    $("#dg_monitor_LBS_list").treegrid({
        url: context_path + "/networkmonitor/getLBSInfo.do?type=stop"
    });
    $("#dg_monitor_LBS_list").datagrid('getPager').pagination({
        pageSize: 10,
        layout: ['first', 'prev', 'sep', 'manual', 'sep', 'next', 'last']
    });
});
$(".single_block:eq(2)").click(function () {
    $(".single_block").each(function () {
        $(this).removeClass("single_block_selected");
    })
    $(".single_block:eq(2)").addClass("single_block_selected");
    $("#dg_monitor_LBS_list").treegrid({
        url: context_path + "/networkmonitor/getLBSInfo.do?type=new"
    });
    $("#dg_monitor_LBS_list").datagrid('getPager').pagination({
        pageSize: 10,
        layout: ['first', 'prev', 'sep', 'manual', 'sep', 'next', 'last']
    });
});
$(".single_block:eq(3)").click(function () {
    $(".single_block").each(function () {
        $(this).removeClass("single_block_selected");
    })
    $(".single_block:eq(3)").addClass("single_block_selected");
    $("#dg_monitor_LBS_list").treegrid({
        url: context_path + "/networkmonitor/getLBSInfo.do?type=offline"
    });
    $("#dg_monitor_LBS_list").datagrid('getPager').pagination({
        pageSize: 10,
        layout: ['first', 'prev', 'sep', 'manual', 'sep', 'next', 'last']
    });
});
/*获取顶部状态*/
$.ajax({
    type: 'POST',
    async: false,
    dataType: 'json',
    url: context_path + "/networkmonitor/getNetStatusCount.do?type=LBS",
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
    url: context_path + "/networkmonitor/getNetDeviceFlow.do?type=inSLB",
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
var device_monitor_cell_width = $("#dg_monitor_LBS_list").width() / 12;
/*应用负载监控*/
$("#dg_monitor_LBS_list").treegrid({
    height: 300,
    singleSelect: true,
    pagination: true,
    idField: 'id',
    treeField: 'id',
    columns: [[
        {
            field: 'id',
            title: '设备名称',
            align: 'left',
            halign: 'center',
            width: device_monitor_cell_width + 206,
            formatter: function (value, row, index) {
                if (row.levels == "parent") {
                    return "<span style='color: blue; cursor: pointer;' onclick=\"JumpPage('" + value + "')\"> " + value + "  </span>"
                } else {
                    return value;
                }
            }
        },
        {field: 'ckstatus', title: '健康状态', align: 'center', width: device_monitor_cell_width + 139},
        {
            field: 'bin', title: '流入流量(MB)', align: 'center', width: device_monitor_cell_width + 150,
            formatter: function (value, row, index) {
                return Math.round((value / 1000 / 1000) * 100) / 100;
            }
        },
        {
            field: 'bout', title: '流出流量(MB)', align: 'center', width: device_monitor_cell_width + 150,
            formatter: function (value, row, index) {
                return Math.round((value / 1000 / 1000) * 100) / 100;
            }
        },
        {
            field: 'detail', title: '运行概况', align: 'center', width: device_monitor_cell_width + 20,
            styler: function () {
                return 'border-right : none';
            },
            formatter: function (value, row, index) {
                var objid = row.id;
                if (row.levels == "parent") {
                    return "<span style='color: blue; cursor: pointer;' onclick=\"JumpNetWorkRunPage('LBS','" + objid + "')\">运行概况</span>"
                }
            }
        }
    ]],
    url: context_path + "/networkmonitor/getLBSInfo.do?type=all",
    onBeforeExpand: function (row) {
        if (!row._parentId) {
            $("#dg_monitor_LBS_list").treegrid('options').url = context_path + "/networkmonitor/getLBSChildrenInfo.do?parentid=" + row.id
        } else {
            $("#dg_monitor_LBS_list").treegrid('options').url = context_path + "/networkmonitor/getLBSSonInfo.do?parentid=" + row.objectid + "&childid=" + row.id
        }
    }
});
$("#dg_monitor_LBS_list").datagrid('getPager').pagination({
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
    url: context_path + "/networkmonitor/getAlarmInfo.do?type=inSLB"
});
var flowInChart = echarts.init(document.getElementById('flow_in_chart'));
var flowOutChart = echarts.init(document.getElementById('flow_out_chart'));
flowInChart.setOption({
    title: {
        text: '后端服务器流量流入速率Top10',
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
            return "<div class='tooltip_cicrle'></div>名称：" + net_device_flowout_name[parm.dataIndex] + " -<br>" + net_device_flowout[parm.dataIndex] + "<br><div class='tooltip_cicrle'></div>流速：" + parm.data + "B/s";
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
        text: '后端服务器流量流出速率Top10',
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
            return "<div class='tooltip_cicrle'></div>名称：" + net_device_flowout_name[parm.dataIndex] + " -<br>" + net_device_flowout[parm.dataIndex] + "<br><div class='tooltip_cicrle'></div>流速：" + parm.data + "B/s";
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