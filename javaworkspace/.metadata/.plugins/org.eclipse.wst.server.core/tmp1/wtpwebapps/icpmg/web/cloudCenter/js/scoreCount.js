/**
 * Created by liuenqi on 2016/8/15.
 */
/*打开详情页面*/
//@ sourceURL=scoreCount.js
var openDialog = function (name, id, date) {
    $("#cloud_center_detail").window({
        title: name,
        maximizable: false,
        collapsible: false,
        minimizable: false,
        resizable: false,
        width: 700,
        height: 400,
        modal: true,
        onBeforeOpen: function () {
            $('#cloud_center_detail').tabs({});
            $('#score_detail').datagrid({
                url: context_path + "/cloudcenter/getScoreDetail.do?ccid=" + id + "&starttime=" + date + "&indtype=0,1",
                resizeHandle: false,
                striped: true,
                singleSelect: true,
                columns: [[{
                    field: 'indname',
                    title: '指标名称',
                    align: 'center',
                    resizable: false,
                    width: 340
                }, {
                    field: 'indvalue',
                    title: '分数',
                    align: 'center',
                    resizable: false,
                    width: 339
                }]]
            });
        },
        onOpen: function () {
            $('#cloud_center_detail').tabs('select', 0);
            $('#cloud_center_detail').tabs({
                onSelect: function (title, index) {
                    if (index == 0) {
                        $('#score_detail').datagrid({
                            resizeHandle: false,
                            striped: true,
                            singleSelect: true,
                            columns: [[{
                                field: 'indname',
                                title: '指标名称',
                                align: 'center',
                                resizable: false,
                                width: 340
                            }, {
                                field: 'indvalue',
                                title: '分数',
                                align: 'center',
                                resizable: false,
                                width: 339
                            }]],
                            url: context_path + "/cloudcenter/getScoreDetail.do?ccid=" + id + "&starttime=" + date + "&indtype=0,1"
                        });
                    } else if (index == 1) {
                        $('#original_kpi').datagrid({
                            resizeHandle: false,
                            striped: true,
                            singleSelect: true,
                            columns: [[{
                                field: 'indid',
                                hidden: true
                            }, {
                                field: 'indname',
                                title: '指标名称',
                                align: 'center',
                                resizable: false,
                                width: 340
                            }, {
                                field: 'indvalue',
                                title: '指标值',
                                align: 'center',
                                resizable: false,
                                width: 339,
                                formatter: function (value, row, index) {
                                    var ind_id = row.indid;

                                    if (ind_id == 11) {
                                        return "<span style='color: blue; cursor: pointer;' onclick=\"getAlarmDetail('" + id + "','" + ind_id + "','" + date + "')\">" + value + "</span>"
                                    }
                                    else if (ind_id != 12 && ind_id != 13) {
                                        var hour = Math.floor(value / 60);
                                        var minutes = value % 60;
                                        var valueText = "";
                                        if (hour > 0)
                                            valueText = hour + "小时";
                                        if (minutes > 0)
                                            valueText = valueText + minutes + "分钟";
                                        return "<span style='color: blue; cursor: pointer;' onclick=\"getAlarmDetail('" + id + "','" + ind_id + "','" + date + "')\">" + valueText + "</span>"
                                    }
                                    else {
                                        return value;
                                    }
                                }
                            }]],
                            url: context_path + "/cloudcenter/getOrKpi.do?ccid=" + id + "&starttime=" + date + "&indtype=2"
                        });
                    } else if (index == 2) {
                        $('#alarm_detail').datagrid({
                            resizeHandle: false,
                            striped: true,
                            singleSelect: true,
                            pagination: true,
                            pageSize: 10,
                            url: context_path + "/cloudcenter/getAlarmDetail.do?ccid=" + id + "&indid=" + 11 + "&time=" + date,
                            pageList: [10, 20, 30],
                            columns: [[{
                                field: 'orgid',
                                title: '告警编号',
                                align: 'center',
                                resizable: false,
                                width: 136
                            }, {
                                field: 'eventypename',
                                title: '告警名称',
                                align: 'center',
                                width: 136
                            }, {
                                field: 'occurtime',
                                title: '告警发生时间',
                                align: 'center',
                                resizable: false,
                                width: 136
                            }, {
                                field: 'clrtime',
                                title: '告警清除时间',
                                align: 'center',
                                resizable: false,
                                width: 135
                            }, {
                                field: 'hour',
                                title: '告警历时(分钟)',
                                align: 'center',
                                resizable: false,
                                width: 135
                            }]]
                        });
                    }
                }
            })
        }
    });
};
var getAlarmDetail = function (ccid, indid, time) {
    $('#cloud_center_detail').tabs('select', 2);
    $('#alarm_detail').datagrid({
        url: context_path + "/cloudcenter/getAlarmDetail.do?ccid=" + ccid + "&indid=" + indid + "&time=" + time,
        /*设置分页*/
        onLoadSuccess: function (data) {
            $('#alarm_detail').datagrid('getPager').pagination({
                layout: ['list', 'sep', 'first', 'prev', 'sep', 'manual', 'sep', 'next', 'last'],
                total: data.count
            })
        }
    });
};
$(function () {
    var chartData;
    /* 获取当前月份 */
    function getLastMonth() {
        var date = new Date();
        var year = date.getFullYear();          //获取当前日期的年
        var month = date.getMonth() + 1;        //获取当前日期的月
        var year2 = year;
        var month2 = parseInt(month) - 1;
        if (month2 == 0) {
            year2 = parseInt(year2) - 1;
            month2 = 12;
        }
        if (month2 < 10) {
            month2 = '0' + month2;
        }
        var m = year2.toString();
        var n = month2.toString();
        var t2 = m + "-" + n;
        return t2;
    }

    /* 获取图表数据 */
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: context_path + "/cloudcenter/getChartData.do?ChartData=" + getLastMonth(),
        success: function (value) {
            chartData = value;
        }
    });
    $.extend($.fn.combobox.methods, {
        yym: function (jq) {
            return jq.each(function () {
                var obj = $(this).combobox();
                var date = new Date();
                var year = date.getFullYear();
                var month = date.getMonth();
                var table = $('<table width="180px;">');
                var tr1 = $('<tr>');
                var tr1td1 = $('<td>', {
                    text: '-',
                    click: function () {
                        var y = $(this).next().html();
                        y = parseInt(y) - 1;
                        $(this).next().html(y);
                        $('.ty-gray').removeClass('ty-gray');
                    }
                });
                tr1td1.appendTo(tr1);
                var tr1td2 = $('<td>', {text: year}).appendTo(tr1);
                var tr1td3 = $(
                    '<td>',
                    {
                        text: '+',
                        click: function () {
                            var y = $(this).prev().html();
                            if (y < year) {
                                y = parseInt(y) + 1;
                            }
                            $(this).prev().html(y);
                            if (y == year) {
                                $(this).addClass('ty-gray');
                                for (var i = month; i < 12; i++) {
                                    $(this).parents('table').find('td').eq(i + 3).addClass('ty-gray');
                                }
                            }
                        }
                    }).appendTo(tr1).addClass('ty-gray');
                tr1.appendTo(table);
                var n = 1;
                for (var i = 1; i <= 4; i++) {
                    var tr = $('<tr>');
                    for (var m = 1; m <= 3; m++) {
                        var td = $('<td>', {
                            text: n,
                            click: function () {
                                if ($(this).hasClass('ty-gray')) {
                                    return;
                                } else {
                                    var yyyy = $(table).find("tr:first>td:eq(1)").html();
                                    var cell = $(this).html();
                                    var v = yyyy + '-' + (cell.length < 2 ? '0' + cell : cell);
                                    obj.combobox('setValue', v).combobox('hidePanel');
                                }
                            }
                        });
                        if (n == month) {
                            td.addClass('tdbackground');
                        }
                        if (n > month) {
                            td.addClass('ty-gray');
                        }
                        td.appendTo(tr);
                        n++;
                    }
                    tr.appendTo(table);
                }
                table.addClass('mytable cursor');
                table.find('td').hover(function () {
                    $(this).addClass('tdbackground');
                }, function () {
                    $(this).removeClass('tdbackground');
                });
                table.appendTo(obj.combobox("panel"));
            });
        }
    });
    $('#tdate').combobox('yym');
    /* 默认选中当前月 */
    $('#tdate').combobox('setValue', getLastMonth());
    $("#exportHref").attr("href", context_path + "/cloudcenter/exportListData.do?ListData=" + getLastMonth());
    var yAxisData = function (data) {
        var city = new Array();
        for (var i = 0; i < data.length; i++) {
            city.push(data[i].ccname);
        }
        return city;
    };
    var setColor = function (value) {
        if (value > 80) {
            return '#66AC4E'
        } else if (value > 60) {
            return '#3086D6'
        } else {
            return '#EC7426'
        }
    };
    var setIndexColor = function (value) {
        if (value > 80) {
            return '#EC7426'
        } else if (value > 60) {
            return '#3086D6'
        } else {
            return '#66AC4E'
        }
    };
    var setSeriesData = function (data) {
        var retData = new Array();
        if (data.length > 0 && typeof(data[0].score) == "undefined") {
            for (var i = 0; i < data.length; i++) {
                retData.push(data[i].indvalue);
            }
        }
        else {
            for (var i = 0; i < data.length; i++) {
                retData.push(data[i].score);
            }
        }
        return retData;
    };
    $('.count_title').append("全部<span style='color: #2EA1F9'>" + chartData.length + "</span>个");
    $('.list_subtitle').append($('#tdate').combobox("getText").substring(0, 4) + "年" + $('#tdate').combobox("getText").substring(5, 7) + "月排名情况");
    /*图表配置信息*/
    var chart = echarts.init(document.getElementById('CC_chart_area'));
    chart.setOption({
        title: {
            text: '云中心排名',
            subtext: $('#tdate').combobox("getText").substring(0, 4) + "年" + $('#tdate').combobox("getText").substring(5, 7) + "月排名情况"
        },
        legend: {
            show: false
        },
        tooltip: {
            show: true
        },
        xAxis: {
            type: 'value',
            min: '0',
            max: '100',
            axisTick: {
                show: false
            }
        },
        yAxis: {
            type: 'category',
            data: yAxisData(chartData),
            axisTick: {
                show: false
            }
        },
        series: [{
            type: 'bar',
            data: setSeriesData(chartData),
            label: {
                normal: {
                    show: true,
                    position: 'insideRight'
                }
            },
            itemStyle: {
                normal: {
                    color: function (i) {
                        return setColor(i.data);
                    }
                }
            }
        }],
        grid: {
            show: true,
            left: '2%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        toolbox: {
            itemSize: 25,
            feature: {
                saveAsImage: {}
            },
            right: 20,
            top: 10
        },
        backgroundColor: '#FFFFFF'
    });
    /*页面切换按钮*/
    $('.list_view').click(function () {
        if ($(".top_menu img:eq(0)").attr("src").indexOf("list_unselect") >= 0) {
            $(".top_menu img:eq(0)").attr({
                "src": context_path + "/web/cloudCenter/img/list_select.png"
            });
            $(".top_menu img:eq(1)").attr({
                "src": context_path + "/web/cloudCenter/img/chart_unselect.png"
            });
            $("#CC_chart_area").css("display", "none");
            $(".top_tool_bar").css("display", "none");
            $("#list_main_body").removeAttr("style");
            /* 绘制datagrid */
            $("#data_table").datagrid({
                resizeHandle: true,
                striped: true,
                singleSelect: true,
                columns: [[
                    {
                        field: 'ccname',
                        title: '云中心名称',
                        align: 'center',
                        width: '30%',
                        resizable: true
                    },
                    {
                        field: 'score',
                        title: '本月分数',
                        align: 'center',
                        resizable: false,
                        width: '10%',
                    },
                    {
                        field: 'lastScore',
                        title: '上月分数',
                        align: 'center',
                        resizable: false,
                        width: '10%',
                    },
                    {
                        field: 'cctrend',
                        title: '环比变化',
                        align: 'center',
                        resizable: true,
                        width: '30%',
                        styler: function (value, row, index) {
                            if (value > 0) {
                                return 'color:green';
                            } else if (value < 0) {
                                return 'color:red';
                            }
                        },
                        formatter: function (value, row, index) {
                            if (value > 0) {
                                return "上升" + value + "名";
                            } else if (value < 0) {
                                return "下降" + -value + "名";
                            } else {
                                return "名次未变化";
                            }
                        }
                    },
                    {
                        field: 'operation',
                        title: '操作',
                        align: 'center',
                        width: '20%',
                        resizable: true,
                        formatter: function (value, row, index) {
                            var CC_name = row.ccname;
                            var CC_id = row.ccid;
                            return "<img src='" + context_path + "/web/cloudCenter/img/icon_details.png' onclick=\"openDialog('" + CC_name + "','" + CC_id + "','" + $('#tdate').combobox("getText") + "')\" ";
                        }
                    }, {
                        field: 'ccid',
                        hidden: true
                    }]],
                url: context_path + "/cloudcenter/getListData.do?ListData=" + $('#tdate').combobox("getText")
            });
        } else {
            return;
        }
    });
    $('.chart_view').click(function () {
        $('#topn_select').combobox("clear");
        var data = $('#topn_select').combobox("getData");
        $('#topn_select').combobox("select", data[2].text);
        $('#kpi_select').combobox("clear");
        var index = $('#kpi_select').combobox("getData");
        $('#kpi_select').combobox("select", index[6].text);
        if ($(".top_menu img:eq(1)").attr("src").indexOf("chart_select") >= 0) {
            return;
        } else {
            $(".top_menu img:eq(1)").attr({
                "src": context_path + "/web/cloudCenter/img/chart_select.png"
            });
            $(".top_menu img:eq(0)").attr({
                "src": context_path + "/web/cloudCenter/img/list_unselect.png"
            });
            $("#CC_chart_area").removeAttr("style");
            $(".top_tool_bar").removeAttr("style");
            $("#list_main_body").css("display", "none");
        }
    });
    /*按条件查询数据*/
    $('.easyui-linkbutton').click(function () {
        $('#topn_select').combobox("clear");
        var data = $('#topn_select').combobox("getData");
        $('#topn_select').combobox("select", data[2].text);
        $('#kpi_select').combobox("clear");
        var index = $('#kpi_select').combobox("getData");
        $('#kpi_select').combobox("select", index[6].text);
        $('.list_subtitle').empty();
        $('.list_subtitle').append($('#tdate').combobox("getText").substring(0, 4) + "年" + $('#tdate').combobox("getText").substring(5, 7) + "月排名情况");
        $("#data_table").datagrid({
            url: context_path + "/cloudcenter/getListData.do?ListData=" + $('#tdate').combobox("getText")
        });
        $.ajax({
            type: 'POST',
            async: false,
            dataType: 'json',
            url: context_path + "/cloudcenter/getChartData.do?ChartData=" + $('#tdate').combobox("getText"),
            success: function (value) {
                chartData = value;
                $('.count_title').empty();
                $('.count_title').append("全部<span style='color: #2EA1F9'>" + chartData.length + "</span>个");
                chart.setOption({
                    title: {
                        subtext: $('#tdate').combobox("getText").substring(0, 4) + "年" + $('#tdate').combobox("getText").substring(5, 7) + "月排名情况"
                    },
                    yAxis: {
                        data: yAxisData(chartData)
                    },
                    series: [{
                        data: setSeriesData(chartData)

                    }]
                });
            }
        });
    });
    $('#kpi_select').combobox({
        height: 30,
        valueField: 'id',
        textField: 'text',
        editable: false,
        data: [{
            'id': 8,
            'text': '互联网中断时长（小时）'
        }, {
            'id': 9,
            'text': 'Zabbix和VCenter的联通中断时长（小时）'
        }, {
            'id': 10,
            'text': '互联网出口防火中断时长（小时）'
        }, {
            'id': 11,
            'text': '告警个数'
        }, {
            'id': 12,
            'text': '虚拟机个数'
        }, {
            'id': 13,
            'text': '告警系数'
        }, {
            'id': 1,
            'text': '总分'
        }],
        onSelect: function () {
            $.ajax({
                type: 'POST',
                async: false,
                dataType: 'json',
                url: context_path + "/cloudcenter/getChartData.do?ChartData=" + $('#tdate').combobox("getText") + "&index=" + $('#kpi_select').combobox("getValue") + "&number=" + $('#topn_select').combobox("getText"),
                success: function (value) {
                    chartData = value;
                    var setMax = function () {
                        if ($('#kpi_select').combobox("getValue") == 8 || $('#kpi_select').combobox("getValue") == 9
                            || $('#kpi_select').combobox("getValue") == 10 || $('#kpi_select').combobox("getValue") == 11
                            || $('#kpi_select').combobox("getValue") == 12 || $('#kpi_select').combobox("getValue") == 13) {
                            return 'auto';
                        }
                        else {
                            return '100';
                        }
                    }
                    chart.setOption({
                        title: {
                            subtext: $('#tdate').combobox("getText").substring(0, 4) + "年" + $('#tdate').combobox("getText").substring(5, 7) + "月排名情况"
                        },
                        yAxis: {
                            data: yAxisData(chartData)
                        },
                        xAxis: {
                            max: setMax()
                        },
                        series: [{
                            data: setSeriesData(chartData),
                            itemStyle: {
                                normal: {
                                    color: function (i) {
                                        if ($('#kpi_select').combobox("getValue") == 8 || $('#kpi_select').combobox("getValue") == 9
                                            || $('#kpi_select').combobox("getValue") == 10 || $('#kpi_select').combobox("getValue") == 11
                                            || $('#kpi_select').combobox("getValue") == 13) {
                                            return setIndexColor(i.data);
                                        }
                                        else if ($('#kpi_select').combobox("getValue") == 12) {
                                            return '#3086D6';
                                        }
                                        else {
                                            return setColor(i.data);
                                        }
                                    }
                                }
                            }
                        }]
                    });
                }
            });
        }
    });
    $('#topn_select').combobox({
        height: 30,
        valueField: 'id',
        textField: 'text',
        editable: false,
        data: [{
            'id': 1,
            'text': 'Top5'
        }, {
            'id': 2,
            'text': 'Top10'
        }, {
            'id': 3,
            'text': 'Top全部'
        }],
        onSelect: function () {
            $.ajax({
                type: 'POST',
                async: false,
                dataType: 'json',
                url: context_path + "/cloudcenter/getChartData.do?ChartData=" + $('#tdate').combobox("getText") + "&index=" + $('#kpi_select').combobox("getValue") + "&number=" + $('#topn_select').combobox("getText"),
                success: function (value) {
                    chartData = value;
                    chart.setOption({
                        title: {
                            subtext: $('#tdate').combobox("getText").substring(0, 4) + "年" + $('#tdate').combobox("getText").substring(5, 7) + "月排名情况"
                        },
                        yAxis: {
                            data: yAxisData(chartData)
                        },
                        series: [{
                            data: setSeriesData(chartData)
                        }]
                    });
                }
            });
        }
    });
});