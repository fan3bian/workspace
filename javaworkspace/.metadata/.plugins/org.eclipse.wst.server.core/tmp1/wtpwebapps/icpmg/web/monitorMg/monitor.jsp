<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
<script type="text/javascript">
		var toolbar = [];
		$(document).ready(function() {
			loadGrid();

		});
		function loadGrid()
		{
			
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
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height:30px;overflow:hidden;">
			<form id="alarmevent_searchform">
				<table>
					<tr>
						<td>资源标识：<select id="resource" class="easyui-combogrid" style="width:200px;height:30px" 
					     data-options="editable:false,idField:'neid',textField:'nename',url:'${pageContext.request.contextPath}/monitor/getObject.do?type=<%=request.getParameter("type")%>',
								pagination:true,
								pageSize:5,
								pageList:[5,10,20],
								sortName:'ipaddr',
								sortOrder:'asc',
								columns:[[
									{field:'neid',title:'',width:150,hidden:'true'},
									{field:'nename',title:'资源标识',width:120,hidden:'true'},
		                			{field:'ipaddr',title:'IP',width:120,sortable:true}
		                		]]
                			">
            				</select>
							指标：<input class="easyui-combobox" name="counter"
							id="counter" style="width:100px;height:30px;border:false">
							发生时间：<input class="easyui-datetimebox" name="creattime"
							id="creattime" style="width:140px;height:30px;border:false">
							到<input class="easyui-datetimebox" name="endtime"
							id="endtime" style="width:140px;height:30px;border:false">
							</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchAndLoad()">查询</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<div id="lb_chart" style="float:left;display:inline;width:100%;"></div>
		</div>
	</div>	
</body>