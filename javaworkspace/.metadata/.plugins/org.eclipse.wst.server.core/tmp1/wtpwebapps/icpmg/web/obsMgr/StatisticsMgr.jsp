<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java" pageEncoding="UTF-8"%>	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
  <!-- CSS样式  START -->
  <style type="text/css">
  
  	.main {
	  	
	  	padding: 0px 0px 0px 25px;
	}

	.common {
	    height: 24px;
	    position: relative;
	    padding: 10px 0px;
	}

	.time-btn {
	    display: inline-block;
	    font-size: 12px;
	    float: left;
	    padding: 4px 0;
	    margin: 1px 0;
	    min-width: 50px;
	    border-left-width: 0;
	    -webkit-border-radius: 0;
	    border-radius: 0;
	}
	
	.cards {
		height: 250px;
	    text-align: justify;
	    text-justify: inter-ideograph;
	    padding: 0 15px 15px;
	    margin-top: 10px;
	    font-size: 0;
    }
    
    .cards .bigcard {
    	display: inline-block;
	   	-webkit-border-radius: 6px;
	   	border-radius: 6px;
	
		width: 100%;
		height: 95%;
		position: relative;
		margin: 25px 25px 25px 0px;
		overflow: hidden;
		background-color: #fff;
		border: 1px solid #c9ccd0;
		vertical-align: top;
		font-size: 12px;
	}
	
	.bigcard:hover {
		color: #97c9e5;
		border:1px solid rgba(12,148,222,.8);
   		
   	}
    
    .cards .card {
    	display: inline-block;
	   	-webkit-border-radius: 6px;
	   	border-radius: 6px;
		
		width: 32%;
		height: 100%;
		position: relative;
		margin: 25px 1% 25px 0px;
		overflow: hidden;
		background-color: #fff;
		border: 1px solid #c9ccd0;
		vertical-align: top;
		font-size: 12px;
	}
	
	.card:hover {
		color: #97c9e5;
   		border:1px solid rgba(12,148,222,.8);
   	}
   	
   	.cards .longcard {
/*    	display: inline-block; */
	   	-webkit-border-radius: 6px;
	   	border-radius: 6px;
		width: 45%;
		height: 280px;
		float:right;
/* 		position: relative; */
		margin: 0px 25px 25px 25px;
		overflow: hidden;
		background-color: #fff;
		border: 1px solid #c9ccd0;
		vertical-align: top;
		font-size: 12px;
	}
	
	.longcard:hover {
		color: #97c9e5;
   		border:1px solid rgba(12,148,222,.8);
   	}
   	
   	.l-btn.active {
	    background: #eaf2ff none repeat scroll 0 0;
	    border: 1px solid #b7d2ff;
	    color: #000000;
	    filter: none;
	}
	
    .rightcard {
		width: 600px;
		height: 100%;
		position: relative;
		margin: 25px 25px 25px 25px;
		font-size: 12px;
	}

  </style>
  <!-- CSS样式  END -->
  
  <!-- 脚本 START -->
  <script type="text/javascript">
  
  	var spaceRange = '所有空间';
  	var timeRange = 30;
  	var startTime = '';
  	var endTime = '';
  	var seriesName = '近30天';
  	var tabTitle = '使用概况';
  	
  	//页面加载动作
  	$(document).ready(function() {
  		loadStatistics();
	 });
	 
	 //按钮点击，状态变化
	 $(document).on('click', '.timerange .l-btn', function(){
	  					$('.timerange a').removeClass('active');
	  					$(this).addClass('active').siblings();
	  				});

  	//SELECT change option
  	$('#statisticsrange').combobox({
	    onChange:function(newValue,oldValue){
	    	spaceRange = newValue;
	        loadStatistics();
	    }
	});
	
	//点击“近7天”
	function lastWeek(){
		timeRange = 7;
		startTime = '';
		endTime = '';
		seriesName = '近一周';
		loadStatistics();
	}
	
	//点击“近30天”
	function lastMonth(){
		timeRange = 30;
		startTime = '';
		endTime = '';
		seriesName = '近30天';
		loadStatistics();
	}
	
	//点击“当月”
	function thisMonth(){
		
		//获取当前天数
		var myDate = new Date();
		timeRange = myDate.getDate();
		startTime = '';
		endTime = '';
		seriesName = '当月';
		loadStatistics();
	}
	
	//点击“查询”
	function query(){
		startTime = $("#startTime").datebox('getValue');
		endTime = $("#endTime").datebox('getValue');
		
		//验证输入
		if (startTime == null || $.trim(startTime) == "" || endTime == null || $.trim(endTime) == "") {
			$.messager.alert('消息', "起始时间不能为空!");
			return false;
		}
		if(startTime>endTime){
			$.messager.alert('错误', "开始时间大于结束时间",'error');
		}
		timeRange = 0;
		seriesName = startTime + '~' + endTime;
		loadStatistics();
	}
	
	//获取当前点击的TAB名称
	$('#statisticsmgr').tabs({
		border:false,
		onSelect:function(title){
			tabTitle = title;
			loadStatistics();
		}
	}); 
	
	//加载各类统计数据变化图
	function loadStatistics(){
		if(tabTitle == '使用概况'){
			loadStorageStatistics();
			loadFlowStatistics();
			loadPutStatistics();
			loadGetStatistics();
		}else if(tabTitle == '流量统计'){
			loadFlowDetailStatistics();
			loadFlowDataGrid();
			loadFlowPieStatistics();
		}else if(tabTitle == '存储空间'){
			loadStorageDetailStatistics();
			loadStorageDataGrid();
			loadStoragePieStatistics();
		}else if(tabTitle == 'GET请求数'){
			loadGetDetailStatistics();
			loadGetDataGrid();
			loadGetPieStatistics();
		}else if(tabTitle == 'PUT请求数'){
			loadPutDetailStatistics();
			loadPutDataGrid();
			loadPutPieStatistics();
		}
	}
	
  	/****** 使用概况  START ******/
  	//文件存储
  	function loadStorageStatistics() {
  		$('#space-card').highcharts({
	  		chart: {
	            type: 'areaspline'
	        },
	        title: { 
	  			text: '存储 ', x: -10 //center 
	  		},
	  		xAxis: { 
	  			categories: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstDate.do?daycoun=' + timeRange + '&starttime=' + startTime + '&endtime=' + endTime
						, async: false
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}, 
	  		yAxis: { 
	  			title: { 
	  				text: 'MB'
	  			}, 
	            min: 0,
	            minTickInterval:2,
	  			plotLines: [{ 
	  				value: 0, 
	  				width: 1, 
	  				color: '#808080' 
	  			}] 
	  		}, 
	  		tooltip: { 
	  			valueSuffix: 'MB'
	  		},
	  		series: [{ 
	  			name: seriesName, 
	  			data: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstStatisticsByDay.do?' 
						, async: false,
						data:{
							statisticstype:'storage',
							daycoun:timeRange,
							bucketName:spaceRange,
							starttime:startTime,
							endtime:endTime,
						}
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}],
	  		credits: {
			     enabled: false
			}
		});
	}
	
	//流量统计
  	function loadFlowStatistics() {
  		$('#flow-card').highcharts({
	  		chart: {
	            type: 'areaspline'
	        },
	        title: { 
	  			text: '流量统计', x: -10 //center 
	  		},
	  		xAxis: { 
	  			categories: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstDate.do?daycoun=' + timeRange + '&starttime=' + startTime + '&endtime=' + endTime
						, async: false
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}, 
	  		yAxis: { 
	  			title: { 
	  				text: 'MB'
	  			}, 
	            min: 0,
	            minTickInterval:2,
	  			plotLines: [{ 
	  				value: 0, 
	  				width: 1, 
	  				color: '#808080' 
	  			}] 
	  		}, 
	  		tooltip: { 
	  			valueSuffix: 'MB'
	  		},
	  		series: [{ 
	  			name: seriesName, 
	  			data: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstStatisticsByDay.do?' 
						, async: false,
						data:{
							statisticstype:'flow',
							daycoun:timeRange,
							bucketName:spaceRange,
							starttime:startTime,
							endtime:endTime,
						}
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}],
	  		credits: {
			     enabled: false
			}
		});
	}
	
	//PUT请求数
  	function loadPutStatistics() {
  		$('#put-card').highcharts({
	  		chart: {
	            type: 'areaspline'
	        },
	        title: { 
	  			text: 'PUT请求数', x: -10 //center 
	  		},
	  		xAxis: { 
	  			categories: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstDate.do?daycoun=' + timeRange + '&starttime=' + startTime + '&endtime=' + endTime
						, async: false
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}, 
	  		yAxis: { 
	  			title: { 
	  				text: '次'
	  			}, 
	            min: 0,
	            minTickInterval:2,
	  			plotLines: [{ 
	  				value: 0, 
	  				width: 1, 
	  				color: '#808080' 
	  			}] 
	  		}, 
	  		tooltip: { 
	  			valueSuffix: '次'
	  		},
	  		series: [{ 
	  			name: seriesName, 
	  			data: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstStatisticsByDay.do?' 
						, async: false,
						data:{
							statisticstype:'put',
							daycoun:timeRange,
							bucketName:spaceRange,
							starttime:startTime,
							endtime:endTime,
						}
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}],
	  		credits: {
			     enabled: false
			}
		});
	}
	
	//GET请求数
  	function loadGetStatistics() {
  		$('#get-card').highcharts({
	  		chart: {
	            type: 'areaspline'
	        },
	        title: { 
	  			text: 'GET请求数', x: -10 //center 
	  		},
	  		xAxis: { 
	  			categories: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstDate.do?daycoun=' + timeRange + '&starttime=' + startTime + '&endtime=' + endTime
						, async: false
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}, 
	  		yAxis: { 
	  			title: { 
	  				text: '次'
	  			}, 
	            min: 0,
	            minTickInterval:2,
	  			plotLines: [{ 
	  				value: 0, 
	  				width: 1, 
	  				color: '#808080' 
	  			}] 
	  		}, 
	  		tooltip: { 
	  			valueSuffix: '次'
	  		},
	  		series: [{ 
	  			name: seriesName, 
	  			data: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstStatisticsByDay.do?' 
						, async: false,
						data:{
							statisticstype:'get',
							daycoun:timeRange,
							bucketName:spaceRange,
							starttime:startTime,
							endtime:endTime,
						}
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}],
	  		credits: {
			     enabled: false
			}
		});
	}
  	/****** 使用概况  END ******/
  	
  	/****** 流量统计  START ******/
  	//流量统计
  	function loadFlowDetailStatistics() {
  		$('#flow-detail-card').highcharts({
	  		chart: {
	            type: 'areaspline'
	        },
	        title: { 
	  			text: '流量统计', x: -10 //center 
	  		},
	  		xAxis: { 
	  			categories: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstDate.do?daycoun=' + timeRange + '&starttime=' + startTime + '&endtime=' + endTime
						, async: false
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}, 
	  		yAxis: { 
	  			title: { 
	  				text: 'MB'
	  			}, 
	            min: 0,
	            minTickInterval:2,
	  			plotLines: [{ 
	  				value: 0, 
	  				width: 1, 
	  				color: '#808080' 
	  			}] 
	  		}, 
	  		tooltip: { 
	  			valueSuffix: 'MB'
	  		},
	  		series: [{ 
	  			name: seriesName, 
	  			data: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstStatisticsByDay.do',
						data:{
							statisticstype:'flow',
							daycoun:timeRange, 
							bucketName:spaceRange,
							starttime:startTime , 
							endtime:endTime,
							}, 
						async: false, 
						dataType: "json", 
						success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}],
	  		credits: {
			     enabled: false
			}
		});
	}
	
	//按天展示流量
	function loadFlowDataGrid(){
  		$('#flow_table').datagrid({
	  		striped: true,//条纹
	  		scrollbarSize: 0,//滚动条
	  		border: false,
	  		nowarp: false,
	  		fitColumns: true,
	  		singleSelect: true,
	  		checkOnSelect: true,
	  		selectOnCheck: false,
	  		pagination: true,
	  		pageList: [7],
	  		sortName: 'operdate',
	  		sortOrder: 'desc',
	  		url: urlrootpath + '/obsMgr/lstStatisticsByDayPaging.do',
			queryParams:{
	  			statisticstype:'flow',
	  			daycoun:timeRange,
				bucketName:spaceRange,
				starttime:startTime,
				endtime:endTime,
	  		},
	  		method: 'post',
	  		loadMsg: '数据装载中......',
	  		onLoadSuccess:function(data){
	  			var pageopt = $('#flow_table').datagrid('getPager').data("pagination").options;
				var  _pageSize = pageopt.pageSize;//分页条数
				var  _rows = $('#flow_table').datagrid("getRows").length;//每页实际条数
				var total = pageopt.total; //显示的查询的总数
				if (_pageSize >= 7) {
					for( var i=7;i>_rows;i--){
						$(this).datagrid('appendRow', {fileid:''  });
					}
					$('#flow_table').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    	total: total,
				     });
				}else{
					$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				}
	  		}
	  	});
	 }
	 
	 //加载各桶流量比例饼图
	 function loadFlowPieStatistics() {
	 	$('#flow-Piechart').highcharts({ 
 			chart: { 
 				plotBackgroundColor: null
 				, plotBorderWidth: null
 				, plotShadow: false 
 			}
 			, title: { 
 				text: '各空间占比' 
 			}
 			, tooltip: { 
 				pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>' 
 			}
 			, plotOptions: { 
 				pie: { 
 					allowPointSelect: true
 					, cursor: 'pointer'
 					, dataLabels: { enabled: false }
 					, showInLegend: true 
 				} 
 			}
 			, series: [{
                type: 'pie',
                name: '占比',
                data: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstProportion.do',
						data:{
							statisticstype:'flow',
				  			daycoun:timeRange,
							bucketName:spaceRange,
							starttime:startTime,
							endtime:endTime,
						}
						, async: false
						, dataType: "json"
						, success: function(value){
						//	data=value;
							$.each(value,function(index){
								data.push([value[index].displayname, parseInt(value[index].proportion)]);  
							});
				  		}
					});
	  				return data;
	  			}()
	  		}],
	  		credits: {
			     enabled: false
			}
 		}); 
	 }
  	/****** 流量统计  END ******/
  	
  	/****** 存储空间  START ******/
  	//存储空间
  	function loadStorageDetailStatistics() {
  		$('#storage-detail-card').highcharts({
	  		chart: {
	            type: 'areaspline'
	        },
	        title: { 
	  			text: '存储空间', x: -10 //center 
	  		},
	  		xAxis: { 
	  			categories: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstDate.do?daycoun=' + timeRange + '&starttime=' + startTime + '&endtime=' + endTime
						, async: false
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}, 
	  		yAxis: { 
	  			title: { 
	  				text: 'MB'
	  			}, 
	            min: 0,
	            minTickInterval:2,
	  			plotLines: [{ 
	  				value: 0, 
	  				width: 1, 
	  				color: '#808080' 
	  			}] 
	  		}, 
	  		tooltip: { 
	  			valueSuffix: 'MB'
	  		},
	  		series: [{ 
	  			name: seriesName, 
	  			data: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstStatisticsByDay.do',
						data:{
							statisticstype:'storage',
				  			daycoun:timeRange,
							bucketName:spaceRange,
							starttime:startTime,
							endtime:endTime,
						}
						, async: false
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}],
	  		credits: {
			     enabled: false
			}
		});
	}
	
	//按天展示存储空间
	function loadStorageDataGrid(){
  		$('#storage_table').datagrid({
	  		striped: true,//条纹
	  		scrollbarSize: 0,//滚动条
	  		border: false,
	  		nowarp: false,
	  		fitColumns: true,
	  		singleSelect: true,
	  		checkOnSelect: true,
	  		selectOnCheck: false,
	  		pagination: true,
	  		pageList: [7],
	  		sortName: 'operdate',
	  		sortOrder: 'desc',
	  		url: urlrootpath + '/obsMgr/lstStatisticsByDayPaging.do',
	  		queryParams:{
				statisticstype:'storage',
	  			daycoun:timeRange,
				bucketName:spaceRange,
				starttime:startTime,
				endtime:endTime,
	  		},
			method: 'post',
	  		loadMsg: '数据装载中......',
  			onLoadSuccess:function(data){
	  			var pageopt = $('#storage_table').datagrid('getPager').data("pagination").options;
				var  _pageSize = pageopt.pageSize;//分页条数
				var  _rows = $('#storage_table').datagrid("getRows").length;//每页实际条数
				var total = pageopt.total; //显示的查询的总数
				if (_pageSize >= 7) {
					for( var i=7;i>_rows;i--){
						$(this).datagrid('appendRow', {fileid:''  });
					}
					$('#storage_table').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    	total: total,
				     });
				}else{
					$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				}
	  		}
  	});
	 }
	 
	 //加载各桶存储空间比例饼图
	 function loadStoragePieStatistics() {
	 	$('#storage-Piechart').highcharts({ 
 			chart: { 
 				plotBackgroundColor: null
 				, plotBorderWidth: null
 				, plotShadow: false 
 			}
 			, title: { 
 				text: '各空间占比' 
 			}
 			, tooltip: { 
 				pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>' 
 			}
 			, plotOptions: { 
 				pie: { 
 					allowPointSelect: true
 					, cursor: 'pointer'
 					, dataLabels: { enabled: false }
 					, showInLegend: true 
 				} 
 			}
 			, series: [{
                type: 'pie',
                name: '占比',
                data: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstProportion.do?statisticstype=storage&daycoun=' + timeRange + '&bucketName=' + spaceRange + '&starttime=' + startTime + '&endtime=' + endTime
						, async: false
						, dataType: "json"
						, success: function(value){
							$.each(value,function(index){
								data.push([value[index].displayname, parseInt(value[index].proportion)]);  
							});
				  		}
					});
	  				return data;
	  			}()
	  		}],
	  		credits: {
			     enabled: false
			}
 		}); 
	 }
  	/****** 存储空间  END ******/
  	
  	/****** GET请求数  START ******/
  	//GET请求数
  	function loadGetDetailStatistics() {
  		$('#get-detail-card').highcharts({
	  		chart: {
	            type: 'areaspline'
	        },
	        title: { 
	  			text: 'GET请求数', x: -10 //center 
	  		},
	  		xAxis: { 
	  			categories: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstDate.do?daycoun=' + timeRange + '&starttime=' + startTime + '&endtime=' + endTime
						, async: false
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}, 
	  		yAxis: { 
	  			title: { 
	  				text: 'MB'
	  			}, 
	            min: 0,
	            minTickInterval:2,
	  			plotLines: [{ 
	  				value: 0, 
	  				width: 1, 
	  				color: '#808080' 
	  			}] 
	  		}, 
	  		tooltip: { 
	  			valueSuffix: '次'
	  		},
	  		series: [{ 
	  			name: seriesName, 
	  			data: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstStatisticsByDay.do',
						data:{
							statisticstype:'get',
							daycoun:timeRange,
							bucketName:spaceRange,
							starttime:startTime,
							endtime:endTime,
						},
						 async: false
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}],
	  		credits: {
			     enabled: false
			}
		});
	}
	
	//按天展示存储空间
	function loadGetDataGrid(){
  		$('#get_table').datagrid({
	  		striped: true,//条纹
	  		scrollbarSize: 0,//滚动条
	  		border: false,
	  		nowarp: false,
	  		fitColumns: true,
	  		singleSelect: true,
	  		checkOnSelect: true,
	  		selectOnCheck: false,
	  		pagination: true,
	  		pageList: [7],
	  		sortName: 'operdate',
	  		sortOrder: 'desc',
	  		url: urlrootpath + '/obsMgr/lstStatisticsByDayPaging.do',
	  		queryParams:{
	  			statisticstype:'get',
				daycoun:timeRange,
				bucketName:spaceRange,
				starttime:startTime,
				endtime:endTime,
	  		},
			method: 'post',
	  		loadMsg: '数据装载中......',
	  		onLoadSuccess:function(data){
	  			var pageopt = $('#get_table').datagrid('getPager').data("pagination").options;
				var  _pageSize = pageopt.pageSize;//分页条数
				var  _rows = $('#get_table').datagrid("getRows").length;//每页实际条数
				var total = pageopt.total; //显示的查询的总数
				if (_pageSize >= 7) {
					for( var i=7;i>_rows;i--){
						$(this).datagrid('appendRow', {fileid:''  });
					}
					$('#get_table').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    	total: total,
				     });
				}else{
					$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				}
	  		}
	  	});
	 }
	 
	 //加载各桶存储空间比例饼图
	 function loadGetPieStatistics() {
	 	$('#get-Piechart').highcharts({ 
 			chart: { 
 				plotBackgroundColor: null
 				, plotBorderWidth: null
 				, plotShadow: false 
 			}
 			, title: { 
 				text: '各空间占比' 
 			}
 			, tooltip: { 
 				pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>' 
 			}
 			, plotOptions: { 
 				pie: { 
 					allowPointSelect: true
 					, cursor: 'pointer'
 					, dataLabels: { enabled: false }
 					, showInLegend: true 
 				} 
 			}
 			, series: [{
                type: 'pie',
                name: '占比',
                data: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstProportion.do?statisticstype=get&daycoun=' + timeRange + '&bucketName=' + spaceRange + '&starttime=' + startTime + '&endtime=' + endTime
						, async: false
						, dataType: "json"
						, success: function(value){
							$.each(value,function(index){
								data.push([value[index].displayname, parseInt(value[index].proportion)]);  
							});
				  		}
					});
	  				return data;
	  			}()
	  		}],
	  		credits: {
			     enabled: false
			}
 		}); 
	 }
  	/****** GET请求数  END ******/
  	
  	/****** PUT请求数  START ******/
  	//PUT请求数
  	function loadPutDetailStatistics() {
  		$('#put-detail-card').highcharts({
	  		chart: {
	            type: 'areaspline'
	        },
	        title: { 
	  			text: 'PUT请求数', x: -10 //center 
	  		},
	  		xAxis: { 
	  			categories: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstDate.do?daycoun=' + timeRange + '&starttime=' + startTime + '&endtime=' + endTime
						, async: false
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}, 
	  		yAxis: { 
	  			title: { 
	  				text: 'MB'
	  			}, 
	            min: 0,
	            minTickInterval:2,
	  			plotLines: [{ 
	  				value: 0, 
	  				width: 1, 
	  				color: '#808080' 
	  			}] 
	  		}, 
	  		tooltip: { 
	  			valueSuffix: '次'
	  		},
	  		series: [{ 
	  			name: seriesName, 
	  			data: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstStatisticsByDay.do',
						data:{
							statisticstype:'put',
							daycoun:timeRange,
							bucketName:spaceRange,
							starttime:startTime,
							endtime:endTime,
						}
						, async: false
						, dataType: "json"
						, success: function(value){
				  		    data = value;
				  		}
					});
	  				return data;
	  			}()
	  		}],
	  		credits: {
			     enabled: false
			}
		});
	}
	
	//按天展示存储空间
	function loadPutDataGrid(){
  		$('#put_table').datagrid({

	  		//表格格式
	  		striped: true,//条纹
	  		scrollbarSize: 0,//滚动条
	  		border: false,
	
	  		//单元格内格式
	  		nowarp: false,
	  		fitColumns: true,
	  		
	  		//选中
	  		singleSelect: true,
	  		checkOnSelect: true,
	  		selectOnCheck: false,
	
	  		//分页
	  		pagination: true,
	  		pageList: [7],
	  		
	  		//分类
	  		sortName: 'operdate',
	  		sortOrder: 'desc',
	
	  		//数据来源
	  		url: urlrootpath + '/obsMgr/lstStatisticsByDayPaging.do',
	  		queryParams:{
	  			statisticstype:'put',
				daycoun:timeRange,
				bucketName:spaceRange,
				starttime:startTime,
				endtime:endTime,
	  		},
			method: 'post',
	
	  		//等待消息
	  		loadMsg: '数据装载中......',
	  		onLoadSuccess:function(data){
	  			var pageopt = $('#put_table').datagrid('getPager').data("pagination").options;
				var  _pageSize = pageopt.pageSize;//分页条数
				var  _rows = $('#put_table').datagrid("getRows").length;//每页实际条数
				var total = pageopt.total; //显示的查询的总数
				if (_pageSize >= 7) {
					for( var i=7;i>_rows;i--){
						$(this).datagrid('appendRow', {fileid:''  });
					}
					$('#put_table').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    	total: total,
				     });
				}else{
					$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				}
	  		}
	  	});
	 }
	 
	 //加载各桶存储空间比例饼图
	 function loadPutPieStatistics() {
	 	$('#put-Piechart').highcharts({ 
 			chart: { 
 				plotBackgroundColor: null
 				, plotBorderWidth: null
 				, plotShadow: false 
 			}
 			, title: { 
 				text: '各空间占比' 
 			}
 			, tooltip: { 
 				pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>' 
 			}
 			, plotOptions: { 
 				pie: { 
 					allowPointSelect: true
 					, cursor: 'pointer'
 					, dataLabels: { enabled: false }
 					, showInLegend: true 
 				} 
 			}
 			, series: [{
                type: 'pie',
                name: '占比',
                data: function(){
	  				var data = [];
	  				$.ajax({
						type: 'post'
						, url: urlrootpath + '/obsMgr/lstProportion.do',
						data:{
							statisticstype:'put',
							daycoun:timeRange,
							bucketName:spaceRange,
							starttime:startTime,
							endtime:endTime,
						},
						async: false
						, dataType: "json"
						, success: function(value){
							$.each(value,function(index){
								data.push([value[index].displayname, parseInt(value[index].proportion)]);  
							});
				  		}
					});
	  				return data;
	  			}()
	  		}],
	  		credits: {
			     enabled: false
			}
 		}); 
	 }
  	/****** PUT请求数  END ******/
  	function decimalformatter(value){
  		if(!value){
  			return '';
  		}
  		if(value=='0E-8')
  			return '0';
  		else
  			return value;
  	}
  	
  </script>
  <!-- 脚本 END -->
  
  	<div class = "main">
  		<div class="common">
  			<table align="center" style="width:100%">
  				<tr style="margin:10px 10px 10px 0px;padding:0px;" >
  					<!-- 桶列表 -->
  					<td style="margin: 10px 10px 10px 0px;padding: 0px;">
  						统计范围&nbsp;:&nbsp;
						<select id="statisticsrange"  class="easyui-combobox" style="width:160px;"
							data-options="panelHeight:200
								, url:'${pageContext.request.contextPath}/obsMgr/lstBucketName.do?'
								, valueField:'bucketname'
								, textField:'displayname'">
							<option value="所有空间">所有空间</option>
						</select>
  					</td>
  					
  					<!-- 时间设置 -->
  					<td style="float:right">
  						<table>
					  		<tr>
					  			<!-- 快捷按钮 -->
							  	<td colspan="1" class="timerange">
								  	<a href="javascript:void(0);" class="easyui-linkbutton" onclick="lastWeek()">近7天</a>&nbsp;&nbsp;
								  	<a href="javascript:void(0);" class="easyui-linkbutton" onclick="lastMonth()">近30天</a>&nbsp;&nbsp;
								  	<a href="javascript:void(0);" class="easyui-linkbutton" onclick="thisMonth()">当月</a>&nbsp;&nbsp;
								</td>
					
								<!-- 手工设置 -->
								<td style="float:right">
									<table>
										<tr>
											<td style="padding:right"><span>&nbsp;&nbsp;&nbsp;起始时间&nbsp;:&nbsp;&nbsp;</span></td>
											<td><input class="easyui-datebox" name="startTime" id="startTime" style="width:150px"></td>
											<td><span>&nbsp;&nbsp;--&nbsp;&nbsp;</span></td>
											<td><input class="easyui-datebox" name="endTime" id="endTime" validType="compareDate['startTime']" style="width:150px"></td>
											<td align="center" colspan="1">
			                                    <a href="javascript:void(0);" id="search" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="query()">查询</a>&nbsp;&nbsp;
			                                </td>
										</tr>
									</table>
								</td>
					  		</tr>
					  	</table>
					</td>
				</tr>
			</table>
    	</div>
    	
    	<!-- 各类统计结果展示 -->
    	<div id="statisticsmgr" class="easyui-tabs" style="height:700px">
	  		
	  		<!-- 使用概况  START -->
	  		<div title="使用概况" style="padding:20px">
	  			<!-- 流量统计变化图生成 -->
	  			<div class="cards">
	  				<div class="bigcard" id="flow-card">
		            </div>
		        </div>
	  			<div class="cards" style="padding:0;padding-left:15px;">
	  				<!-- 存储空间变化图生成 -->
		            <div class="card" id="space-card">
		            </div>
		            <!-- 上传流量变化图生成 -->
		            <div class="card" id="put-card">
		            </div>
		            <!-- 下载流量变化图生成 -->
		            <div class="card" id="get-card" style="margin-right:0; ">
		            </div>
		         </div>
	  		</div>
	  		<!-- 使用概况  END -->
	  		
	  		<!-- 流量统计  START -->
	  		<div title="流量统计" style="padding:20px">
	  			<!-- 流量统计变化图生成 -->
	  			<div class="cards">
	  				<div class="bigcard" id="flow-detail-card">
		            </div>
		        </div>
		        
		        <div class="cards">
		        		<div style="width:48%;float:left;">
		        			<table align="center" id="flow_table">
		        				<thead><tr>
									<th data-options="field:'operdate',width:140,align:'left',sortable:true">日期</th>
									<th data-options="field:'value',width:100,align:'center',sortable:true,formatter:decimalformatter">流量(MB)</th>
								</tr></thead>
							</table>
						</div>
		        		
	        			<div class="longcard" id="flow-Piechart"></div>
		        </div>
	  		</div>
	  		<!-- 流量统计  END -->
	  		<!-- 存储空间  START -->
	  		<div title="存储空间" style="padding:20px">
	  			<!-- 流量统计变化图生成 -->
	  			<div class="cards">
	  				<div class="bigcard" id="storage-detail-card"></div>
		        </div>
		        <div class="cards">
	        		<div style="width:48%;float:left;">
	        			<table align="center" style="width:100%" id="storage_table">
	        				<thead><tr>
								<th data-options="field:'operdate',width:140,align:'left',sortable:true">日期</th>
								<th data-options="field:'value',width:100,align:'center',sortable:true,formatter:decimalformatter">存储量(MB)</th>
							</tr></thead>
						</table>
	        		</div>
        			<div class="longcard" id="storage-Piechart"></div>
		        </div>
	  		</div>
	  		<!-- 存储空间  END -->
	  		
	  		<!-- GET请求数  START -->
	  		<div title="GET请求数" style="padding:20px">
	  			<!-- 流量统计变化图生成 -->
	  			<div class="cards">
	  				<div class="bigcard" id="get-detail-card"></div>
		        </div>
		        
		        <div class="cards">
		        	<div style="width:48%;float:left;">
		        			<table align="center" style="width:100%" id="get_table">
		        				<thead><tr>
									<th data-options="field:'operdate',width:140,align:'left',sortable:true">日期</th>
									<th data-options="field:'value',width:100,align:'center',sortable:true,formatter:decimalformatter">下载次数(次)</th>
								</tr></thead>
							</table>
		        	</div>		
        			<div class="longcard" id="get-Piechart"></div>
			        
		        </div>
	  		</div>
	  		<!-- GET请求数  END -->
  		
	  		<!-- PUT请求数  START -->
	  		<div title="PUT请求数" style="padding:20px">
	  			<!-- 流量统计变化图生成 -->
	  			<div class="cards">
	  				<div class="bigcard" id="put-detail-card">
		            </div>
		        </div>
		        <div class="cards">
	        		<div style="width:48%;float:left;">
	        			<table align="center" style="width:100%" id="put_table">
	        				<thead>
								<th data-options="field:'operdate',width:140,align:'left',sortable:true">日期</th>
								<th data-options="field:'value',width:100,align:'center',sortable:true">上传次数(次)</th>
							</thead>
						</table>
	        		</div>
        			<div class="longcard" id="put-Piechart"></div>
		        </div>
	  		</div>
	  		<!-- PUT请求数  END -->
		
	</div>
	  </div>

