<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<body>
<style type="text/css">
	.FieldInput2 {
		width: 35%;
		height: 25px;
		background-color: #FFFFFF;
		font: normal 12px tahoma, arial, helvetica, sans-serif;
		text-align: left;
		word-wrap: break-word;
		padding-top: 0px !important;
		padding-bottom: 0px !important;
		border: #BCD2EE 1px solid !important;
	}

	.FieldLabel2 {
		width: 20%;
		height: 25px;
		background-color: #F0F8FF;
		font: normal 12px tahoma, arial, helvetica, sans-serif;
		text-align: left;
		word-wrap: break-word;
		padding-top: 0px !important;
		padding-bottom: 0px !important;
		padding-right: 10px !important;
		border: #BCD2EE 1px solid !important;
	}
</style>
<div class="easyui-layout" data-options="fit:true,border:false"
	 style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="height:50px;overflow:hidden;">
		<form id="vm_searchform">
			<table  >
				<tr style="margin: 10px 20px 10px 20px;padding: 10px;" >
					<td style="margin: 10px 20px 10px 20px;padding: 10px;">单位：<input name="resourceUnit" id="resourceUnit" style="width:200px"></td>

					<td style="margin: 10px 20px 10px 20px;padding: 10px;">项目：<input name="projectName" id="projectName" style="width:200px"></td>

					<td align="center" colspan="3">
						<a href="javascript:void(0);" id="search" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" id="formReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo'">重置</a>
					</td>
				</tr>
			</table>

		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table title="" style="width:100%;" id="dg">
			<thead>
			<tr>
				<%--projectid, projectname, unittype, unitid, unitname, objectid, severtypeidlevelfirst,--%>
				<%--servertypenamelevelfirst, servertypeidlevelsecond, servertypenamesecond, appname, bussinessstat, extension1, extension2, extension3, snote--%>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'objectid',hidden:true"></th>
				<th data-options="field:'projectid',width:20,align:'center',sortable:true">项目编号</th>
				<th data-options="field:'projectname',width:50,align:'center',sortable:true">项目名称</th>
				<th data-options="field:'unitname',width:20,align:'center',sortable:true">所属单位</th>
				<th data-options="field:'objectname',width:20,align:'center',sortable:true">实例名称</th>
				<th data-options="field:'servertypenamesecond',width:20,align:'center',sortable:true,">服务名称</th>
				<th data-options="field:'servertypenamelevelfirst',width:100,align:'center',hidden:true">类型</th>
				<th data-options="field:'appname',width:40,align:'center'" >应用</th>
				<th data-options="field:'servicebegintime',width:30,align:'center',sortable:true">开通时间</th>
				<th data-options="field:'chargingbegintime',width:30,align:'center',sortable:true">开始计费时间</th>
				<th data-options="field:'bussinessstat',width:20,align:'center'" formatter="statusFormatter">状态</th>
			</tr>
			</thead>
		</table>
	</div>

</div>
<script type="text/javascript" src="../gov2.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		loadDataGrid();
 		//项目下拉框
		$('#projectName').combobox({
			width:140,
			panelHeight: '100'
		}); 
		
		//单位下拉框
		$('#resourceUnit').combobox({
			url:'${pageContext.request.contextPath}/infopublish/getDepartsAll.do',
			valueField: 'unitId',
			textField: 'unitName',
			width:100,
			panelHeight: '100',
			onSelect:function (record){
				var _unitId = record.unitId;
				$('#projectName').combobox({
					url:'${pageContext.request.contextPath}/project/getprojectsAll.do?unitId='+_unitId,
					valueField: 'proid',
					textField: 'proname',
				});
				
			}
		});

		$("#search").click(function () {
			searchDataGrid();
		});

		$("#formReset").click(function () {
			$("#vm_searchform").form("reset");
		});

		function loadDataGrid() {
			$('#dg').datagrid({
				rownumbers: false,
				scrollbarSize:0,
				checkOnSelect: true,
				selectOnCheck: true,
				border: false,
				striped: true,
				sortName: 'projectid',
				sortOrder: 'asc',
				nowarp: false,
				singleSelect: false,
				method: 'post',
				loadMsg: '数据装载中......',
				fitColumns: true,
				idField: 'neid',
				pagination: true,
				pageSize:10,
				pageNumber:1,
				pageList: [5,10,20,30],
				url: '${pageContext.request.contextPath}/resourceinfo/resourceinfoListApp.do'
			});
		}

		function searchDataGrid() {
			console.log( $('#vm_searchform').form('serialize'));
			$('#dg').datagrid('load', $('#vm_searchform').form('serialize'));
		}

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
	});
	function cfgFormatter(val,row,index){
			if(row['detailProduct']){
				var  osname = row['detailProduct']['osname'];
				var diskNum = row['detailProduct']['disknum'];
				var hardNum = 0;
//				1:0;2:0;3:0;4:0
				if(diskNum){
					var diskNumArr = diskNum.split(";");
					var disNumLength = diskNumArr.length;
					for (var ct = 0; ct < disNumLength; ct++) {
						var diskObj = diskNumArr[ct];
						var diskArray = diskObj.split(":");
						if(diskArray[1]){
							hardNum = parseInt(hardNum)+parseInt(diskArray[1]);
						}
					}
				}
				var rootPath = getRootPath();

				if(osname.toLowerCase().indexOf('centos')>=0){
					return  '<img src="'+rootPath+'images/CentOS.png">'+" "+ row['detailProduct']['cpunum']+"  "+row['detailProduct']['memnum']+" "+hardNum
				}
				if(osname.toLowerCase().indexOf('win')>=0){
					return '<img src="'+rootPath+'images/winServer.png">'+" "+ row['detailProduct']['cpunum']+"  "+row['detailProduct']['memnum']+" "+hardNum
				}
				if(osname.toLowerCase().indexOf('ubuntu')>=0){
					return  '<img src="'+rootPath+'images/Ubuntu.png">'+" "+ row['detailProduct']['cpunum']+"  "+row['detailProduct']['memnum']+" "+hardNum
				}
			}else{
				return ""
			}
	}
	//状态
	function statusFormatter(val,rows,index){
		switch (rows.bussinessstat) {
			case "1":
				return "开始试运行";
			case "2":
				return "计费开始";
			case "3":
				return "计费结束"; 
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