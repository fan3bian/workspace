<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<div>
	&nbsp;&nbsp;<select id="one_" class="easyui-combobox" style="height:30px;width:180px;" data-options="editable:false,panelHeight:'auto'"></select>
	&nbsp;&nbsp;<select id="two_" class="easyui-combobox" style="height:30px;width:180px;" data-options="editable:false,panelHeight:'auto'"></select>
	&nbsp;&nbsp;<select id="three_" class="easyui-combobox" style="height:30px;width:180px;" data-options="editable:false,panelHeight:'auto'"></select>
	&nbsp;&nbsp;开始时间：<input class="easyui-datetimebox" editable="fasle" name="starttime" id="starttime" style="width:150px;height:30px;border:false"/>
	&nbsp;&nbsp;结束时间：<input class="easyui-datetimebox"  editable="fasle" name="endtime" id="endtime" style="width:150px;height:30px;border:false"/>
	&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchAndLoad()">查询</a>
</div>
<div id="lb_chart" style="float:left;display:inline;width:100%;"></div>
<script type="text/javascript">	
$(document).ready(function() {	
	initCombobox();
}); 
function initCombobox(){
	$('#one_').combobox({    
	    url:'${pageContext.request.contextPath}/lb/getonelist.do?lbid=' + $("#tabs_lbid").val(),    
	    valueField:'id',    
	    textField:'name',
    	onSelect: function(rec){  
    		twoCombobox(rec.id);
        }
	});
}
function twoCombobox(listport){
	$('#two_').combobox({    
	    url:'${pageContext.request.contextPath}/lb/gettwolist.do?lbid=' + $("#tabs_lbid").val() + '&listport=' + listport,    
	    valueField:'id',    
	    textField:'name',
    	onSelect: function(rec){  
    		threeCombobox(rec.id,listport);
        }
	});
}
function threeCombobox(serverid,listport){
	$('#three_').combobox({    
	    url:'${pageContext.request.contextPath}/lb/getthreelist.do?lbid=' + $("#tabs_lbid").val() + '&listport=' + listport + '&serverid=' + serverid,    
	    valueField:'id',    
	    textField:'name',
    	onSelect: function(rec){  
    		
        }
	});
}
function lb_query(data){
	lb_chart = new Highcharts.Chart({
					chart: {
					    renderTo: 'lb_chart',
					    type: 'line',//设置图表样式，可以为line,spline, scatter, splinearea bar,pie,area,column  
					},
					legend: {
			            layout: 'vertical',
			            align: 'right',
			            verticalAlign: 'middle',
			            borderWidth: 0
			        },
					title: {
					    text: data.title
					},
					credits:{//右下角的文本  
			            enabled: false
			        }, 
			       xAxis: {
			            categories: data.categories,
			            tickInterval: data.tickInterval,//步长
			            labels: {//设置横轴坐标的显示样式  
			            }
			        },
			        yAxis: {
			            minPadding: 0.2,
			            maxPadding: 0.2,
			            title:''
			        },
			        series: data.series
			    }); 
}
//查询指标后画出折线
function lbAjax(one, two, three, beginTime, endTime){
	$.ajax({
		url : "${pageContext.request.contextPath}/lb/getChartData.do",
		data : {'lbid':$("#tabs_lbid").val(), 'one':one, 'two':two, 'three':three, 'beginTime':beginTime, 'endTime':endTime},
		type : "post",
		dataType: "json",
		cache : false,
		success: function(result) {
			lb_query(result.obj);
		}
	});
	
}
function searchAndLoad(){
	var beginTime = $('#starttime').datebox('getValue');
	var endTime = $('#endtime').datebox('getValue');
	var msg = compareTime(beginTime, endTime);
	if(msg != ""){
		$.messager.alert('提示', msg, 'info');
		return;
	}
	
	var one = $('#one_').combobox('getValue');
	var two = $('#two_').combobox('getValue');
	var three = $('#three_').combobox('getValue');
	if(null == one || '' ==  one || null == two || '' == two || null == three || '' == three){
		$.messager.alert('提示', "查询条件均为必选", 'info');
		return;
	}
	
	lbAjax(one, two, three, beginTime, endTime);
}
//判断时间选择条件
function compareTime(startDate, endDate) { 
	if(null == startDate || '' == startDate || null == endDate || '' == endDate){
		return "查询条件均为必选";  
	}
    var startDateTemp = startDate.split(" ");   
    var endDateTemp = endDate.split(" ");   
                   
    var arrStartDate = startDateTemp[0].split("-");   
    var arrEndDate = endDateTemp[0].split("-");   
  
    var arrStartTime = startDateTemp[1].split(":");   
    var arrEndTime = endDateTemp[1].split(":");   
	  
	var allStartDate = new Date(arrStartDate[0], arrStartDate[1], arrStartDate[2], arrStartTime[0], arrStartTime[1], arrStartTime[2]);   
	var allEndDate = new Date(arrEndDate[0], arrEndDate[1], arrEndDate[2], arrEndTime[0], arrEndTime[1], arrEndTime[2]);   
	                   
	if (allStartDate.getTime() >= allEndDate.getTime()) {   
        return "开始时间不能大于结束时间";   
	} else if(allStartDate.getTime() - allEndDate.getTime() > 7*24*60*60){
		return "时间范围不能超过一周";
	}else{
		return "";
	}   
}
</script>
</body>
