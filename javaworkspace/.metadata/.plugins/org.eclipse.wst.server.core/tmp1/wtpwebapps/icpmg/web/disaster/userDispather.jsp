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
	 style="padding:10px 20px 10px 10px;margin:10px 20px 10px 10px;height:500px;">
	<%--<div data-options="region:'north',border:false" style="background:#eee;height:40px;overflow:hidden;">
		<span id="userName" style="font-size:14px">用户：</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span id="boughtNum"  style="font-size:14px">购买容量(M)：</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span id="usedNum"  style="font-size:14px">已使用量(M)：</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>--%>
	<div data-options="region:'center',border:false" id="resourcesid">

		<table title="" style="width:99%;" id="DisasterOverviewDataGrid">
			<thead>
			<tr>
				<%--projectid, projectname, unittype, unitid, unitname, objectid, severtypeidlevelfirst,--%>
				<%--servertypenamelevelfirst, servertypeidlevelsecond, servertypenamesecond, appname, bussinessstat, extension1, extension2, extension3, snote--%>
				<th data-options="field:'username',width:10," >用户名</th>
				<th data-options="field:'boughtMB',width:60,align:'center'">购买量（MB）</th>
				<th data-options="field:'tel',width:70,align:'center',sortable:true">联系电话</th>
				<th data-options="field:'address',width:40,align:'center',sortable:true">地址</th>
				<%--<th data-options="field:'jobid',width:100,align11:'center'" >任务id</th>--%>
				<%--<th data-options="field:'startdate',align:'center',sortable:true,">开始时间</th>--%>
				<%--<th data-options="field:'enddate',width:100,align:'center'" >结束时间</th>--%>

				<th data-options="field:'usernamelogin',width:30,align:'center',sortable:true">用户系统登录名</th>
			</tr>
			</thead>
		</table>
	</div>
	<div id="dialogWin"></div>

</div>

<script type="text/javascript">
	var flagck = 0;  //  初始化为0
	$(document).ready(function () {

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
		var  _toolbar = [{
			text:'增加',iconCls:'icon-add',handler:function() {
				$('<div></div>').dialog({
					id: 'winUserConfig',
					title: '用户信息配置',
					width: 600,
					height: 360,
					closed: false,
					cache: false,
					href: '${ctx}/web/disaster/userConfig.html',
					modal: true,
					onLoad: function () {
						$("userInfo").form({});
					},
					onClose: function () {
						$(this).dialog('destroy');
					},
					buttons: [{
						text: '确定',
						iconCls: 'icon-ok',
						handler: function () {
							var objJson = $("#userInfo").serialize();
							console.log(objJson);
							$.ajax({
								url:'${ctx}/report/addUserInfo.do',
								data:objJson,
								dataType:'json',
								success:function(data){
									debugger;

									if(data.successInfo == "1"){
										alert("用户信息配置成功")
									}else{
										alert("用户信息配置失败")
									}
									$("#winUserConfig").dialog('destroy');
								}

							});
						}
					}, {
						text: '取消',
						iconCls: 'icon-cancel',
						handler: function () {
							$("#winUserConfig").dialog('destroy');
						}
					}]

				});
			}
		}];
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
				toolbar:_toolbar,
				url: '${pageContext.request.contextPath}/report/getDisasterUserList.do',
				onLoadSuccess: function (data) {
					var pageopt = _datagrid.datagrid('getPager').data("pagination").options;
					var  _pageSize = pageopt.pageSize;
					var  _rows = _datagrid.datagrid("getRows").length;
					var total = pageopt.total; //显示的查询的总数
					if (_pageSize >= 10) {
						for(i=10;i>_rows;i--){
//							{ itemid: '<div style="text-align:center;color:red">没有相关记录！</div>' }
							//添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
							$(this).datagrid('appendRow', {operation:'', incrlevel:'-1',jobstatus:'-1' })
						}
						_datagrid.datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
							total: total
						});
						//	$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
					}else{
						//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
						$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					}
				}

			});


	});

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