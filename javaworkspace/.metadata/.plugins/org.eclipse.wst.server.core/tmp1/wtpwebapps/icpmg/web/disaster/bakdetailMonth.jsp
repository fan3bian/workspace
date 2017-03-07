<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ include file="../../icp/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>资源一览</title>
</head>
<body>
<style type="text/css">

</style>
<script src="../omsMonitor/inhost/js/runOverview/echarts-all.js"></script>
<div class="easyui-layout" data-options="fit:true,border:false"
	 style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;height:500px;">
	<div data-options="region:'north',border:false" style="background:#eee;height:40px;overflow:hidden;">
			<form id="resource_searchform">
				时间范围：<select id="fyear" class="easyui-combobox" name="fyear" style="width:200px;">
				<option value="2016">2016</option>
				<option value="2017">2017</option>
				<option value="2018">2018</option>
				<option value="2019">2019</option>
				<option value="2020">2020</option>
			</select> &nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;
				<select id="fmonth" class="easyui-combobox" name="fmonth" style="width:200px;">
				<option value="01">一月</option>
				<option value="02">二月</option>
				<option value="03">三月</option>
				<option value="04">四月</option>
				<option value="05">五月</option>
				<option value="06">六月</option>
				<option value="07">七月</option>
				<option value="08">八月</option>
				<option value="09">九月</option>
				<option value="10">十月</option>
				<option value="11">十一月</option>
				<option value="12">十二月</option>
			</select>
		<a id="btnSearch" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
		<a id="btnReset" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">重置</a>
			</form>
	</div>
	<div data-options="region:'center',border:false" id="resourcesid">
		<span id="userName" style="font-size:14px">用户：</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span id="boughtNum"  style="font-size:14px">购买容量(M)：</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span id="usedNum"  style="font-size:14px">已使用量(M)：</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

		<%--<div id="overview" style="width: 100%;height:300px;"></div>--%>

		<table title="" style="width:100%;" id="DisasterOverviewDataGrid">
			<thead>
			<tr>
				<%--projectid, projectname, unittype, unitid, unitname, objectid, severtypeidlevelfirst,--%>
				<%--servertypenamelevelfirst, servertypeidlevelsecond, servertypenamesecond, appname, bussinessstat, extension1, extension2, extension3, snote--%>
				<th data-options="field:'clientname',hidden:true" >备份机器名称</th>
				<th data-options="field:'interfacename',width:60,align:'center'">备份机器IP</th>
				<th data-options="field:'osname',width:100,align:'center',sortable:true">操作系统</th>
				<th data-options="field:'idataagent',width:100,align:'center',sortable:true">备份类型</th>
				<th data-options="field:'jobid',width:100,align:'center'" >任务id</th>
				<th data-options="field:'startdate',align:'center',sortable:true,">开始时间</th>
				<th data-options="field:'enddate',width:100,align:'center'" >结束时间</th>
				<th data-options="field:'jobstatus',align:'center',sortable:true"  formatter="successFormater" >是否成功</th>
				<th data-options="field:'incrlevel',align:'center',sortable:true" formatter="increaseFormatter">备份类型</th>
				<th data-options="field:'numbytesuncomMB',align:'center',sortable:true">备份容量(MB)</th>
			</tr>
			</thead>
		</table>
	</div>

</div>

<script type="text/javascript">
	var flagck = 0;  //  初始化为0
	$(document).ready(function () {

		init();

		$.extend($.fn.form.methods, {
			serialize: function (jq) {
				var arrayValue = $(jq[0]).serializeArray();
				var json = {};
				$.each(arrayValue, function () {
					var item = this;
					if (json[item["name"]]) {
						json[item["name"]] = json[item["name"]] + "," + item["value"];
					} else {
						json[item["name"]] = item["value"];
					}
				});
				return json;
			},
			getValue: function (jq, name) {
				var jsonValue = $(jq[0]).form("serialize");
				return jsonValue[name];
			},
			setValue: function (jq, name, value) {
				return jq.each(function () {
					_b(this, _29);
					var data = {};
					data[name] = value;
					$(this).form("load", data);
				});
			}
		});

		var option = {
			title: {
				text: '云容灾购买使用量占比图',
				subtext: '',
				x: 'center'
			},
			tooltip: {
				trigger: 'item',
				formatter: "{a} <br/>{b} : {c} ({d}%)"
			},
			legend: {
				orient: 'vertical',
				x: 'right',
				align: 'right',
				data: ['使用量', '未使用量']
			},
			series: [
				{
					name: '云容灾购买使用量',
					type: 'pie',
					radius: '80%',
					center: ['55%', '50%'],
					itemStyle: {
						emphasis: {
							shadowBlur: 10,
							shadowOffsetX: 0,
							shadowColor: 'rgba(0, 0, 0, 0.5)'
						}
					}
				}
			]
		};



		function init() {
			loadDataGrid();

			getBasicInfo();

			$('#btnSearch').linkbutton({
				onClick:function(){
					$('#DisasterOverviewDataGrid').datagrid('load', $('#resource_searchform').form('serialize'));
				}
			});
			$('#btnReset').linkbutton({
				onClick:function(){
					$("#resource_searchform").form("reset");
				}
			});

		}
		function drawPie(option){
		//	var rowIndex0 = $('#DisasterOverviewDataGrid').datagrid("getRows")[0];
		//	console.log(rowIndex0);
			var boughtnum = {
				value: 1024,
				name: '购买容量'
			};


//			_data[2] = boughtnum;

			var myChart = echarts.init(document.getElementById('overview'));

			myChart.setOption(option);


		}

		function loadDataGrid() {
			var _datagrid = $('#DisasterOverviewDataGrid').datagrid({
				rownumbers: false,
				scrollbarSize:0,
				checkOnSelect: true,
				selectOnCheck: false,
				border: false,
				striped: true,
				// sortName: 'testtime',
				// sortOrder: 'desc',
				nowarp: false,
				singleSelect: true,
				method: 'post',
				loadMsg: '数据装载中......',
				fitColumns: true,
				//idField: 'neid',
				pagination: true,
				pageSize:10,
				pageNumber:1,
				pageList: [5,10,20,30],
				url: '${pageContext.request.contextPath}/report/getBakDetailMonth.do',
				onLoadSuccess: function (data) {
					console.log(data);
					var pageopt = _datagrid.datagrid('getPager').data("pagination").options;
					var  _pageSize = pageopt.pageSize;
					var  _rows = _datagrid.datagrid("getRows").length;
					var total = pageopt.total; //显示的查询的总数
					if (_pageSize >= 10) {
						for(i=10;i>_rows;i--){
//							{ itemid: '<div style="text-align:center;color:red">没有相关记录！</div>' }
							//添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
							$(this).datagrid('appendRow', {operation:''  })
						}
						_datagrid.datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
							total: total
						});
						//	$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
					}else{
						//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
						$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					}

					_datagrid.datagrid("autoMergeCells");
				}

			});
		}

		function getBasicInfo(){
			$.ajax({
				url: '${pageContext.request.contextPath}/report/BasiceInfo.do',
				dataType:'JSON',
				success:function(data){
					$('#userName').append(data.userName);
					$('#boughtNum').append(data.boughtMB);
					$("#usedNum").append(data.usedNum);
					var _data = [];
					var usedNum = {
						value: data.usedNum,
						name: '使用量'
					};
					var unusedNum = {
						value: data.boughtMB - data.usedNum,
						name: '未使用容量'
					};
					_data[0] = usedNum;
					_data[1] = unusedNum;
					option.series[0].data = _data.sort(function (a, b) { return a.value - b.value});
					// drawPie(option);
				}
			});
		}

	});

	$.extend($.fn.datagrid.methods, {
		autoMergeCells : function (jq, fields) {
			return jq.each(function () {
								
				var target = $(this);
				
				if (!fields) {
					fields = target.datagrid("getColumnFields");
				}
				
				var rows = target.datagrid("getRows");
				
				var i = 0,
						j = 0,
						temp = {};
				
				for (i; i < rows.length; i++) {
					var row = rows[i];
					j = 0;
					for (j; j < fields.length; j++) {
						var field = fields[j];
						var tf = temp[field];
						if (!tf) {
							tf = temp[field] = {};
							tf[row[field]] = [i];
						} else {
							var tfv = tf[row[field]];
							if (tfv) {
								tfv.push(i);
							} else {
								tfv = tf[row[field]] = [i];
							}
						}
					}
				}
				
				$.each(temp, function (field, colunm) {	
				///	if(field!="jobstatus")
					$.each(colunm, function () {
						
						var group = this;

						if (group.length > 1) {
							var before,
									after,
									megerIndex = group[0];
							for (var i = 0; i < group.length; i++) {
								
								before = group[i];
								after = group[i + 1];
								if (after && (after - before) == 1) {
									continue;
								}
								var rowspan = before - megerIndex + 1;
								
								if (rowspan > 1&&field!="jobstatus") {
									target.datagrid('mergeCells', {
										index : megerIndex,
										field : field,
										rowspan : rowspan
									});
								}
								
								if (after && (after - before) != 1) {
									megerIndex = after;
								}
																			
							}
						}
					});
				});   
				
			});
		}
	});
	function increaseFormatter(value,row,index){
		console.log(value == 0);
		if (value == 1){
			return "增量备份";
		} else if(value == 0) {
			return "全量备份";
		}else{
			return ""
		}
	}
	///////////////////////////////////
	function dateFormater(value,row,index){		
		var date=valueOf(value);
		return date;

	}
	
	////////////////////
	function successFormater(value,row,index){		
		if("Success" == value || "PartialSuccess" == value) {
			return " 成功"
		}else if("-1" == value){
			return ""
		}else{
			return "失败"
		}
		

	}

	function getRootPath() {
		//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
		var curWwwPath = window.document.location.href;
		//获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
		var pathName = window.document.location.pathname;
		var pos = curWwwPath.indexOf(pathName);
		//获取主机地址，如： http://localhost:8083
		var localhostPaht = curWwwPath.substring(0, pos);
		//获取带"/"的项目名，如：/uimcardprj
		var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
		return (localhostPaht + projectName+"/");
	}

</script>


</body>
</html>