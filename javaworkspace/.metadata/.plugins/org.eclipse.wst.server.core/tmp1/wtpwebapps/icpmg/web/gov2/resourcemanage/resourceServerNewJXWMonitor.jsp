<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ include file="../../../icp/include/taglib.jsp" %>
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
<link href="${ctx}/web/gov2/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="${ctx}/styles/gov2.css" rel="stylesheet" media="screen">
<%--<script src="${ctx}/js/scripts/jquery-1.8.3.min.js"></script>--%>
<script src="${ctx}/web/gov2//bootstrap/js/bootstrap.min.js"></script>
<div class="easyui-layout" data-options="fit:true,border:false"
	 style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="height:50px;overflow:hidden;">
		<form id="resource_searchform">
			<table  >
				<tr style="margin: 10px 20px 10px 20px;padding: 10px;" >
					<td style="margin: 10px 20px 10px 20px;padding: 10px;">所属厅局：<input name="resourceUnit" id="resourceUnit" style="width:200px"></td>
					<td style="margin: 10px 20px 10px 20px;padding: 10px;">资源名称：<input class="easyui-textbox" name="resourceName" id="resourceName" style="width:200px"></td>


					<td style="margin: 10px 20px 10px 20px;padding: 10px;">服务类型：<input name="serverType" id="serverType" style="width:200px"></td>
					<td style="margin: 10px 20px 10px 20px;padding: 10px;">服务名称：<input class="easyui-textbox" name="serverName" id="serverName" style="width:200px"></td>

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
				<th data-options="field:'projectid',width:40,align:'center',sortable:true"  formatter="serverFormat">项目编号</th>
				<th data-options="field:'projectname',width:80,align:'center',sortable:true">项目名称</th>
				<th data-options="field:'unitname',align:'center',sortable:true">所属单位</th>
				<th data-options="field:'objectname',align:'center',sortable:true">实例名称</th>
				<th data-options="field:'servertypenamesecond',align:'center',sortable:true,">服务名称</th>
				<th data-options="field:'servertypenamelevelfirst',width:100,align:'center'" >类型</th>
				<th data-options="field:'appname',width:100,align:'center'" >应用</th>
				<th data-options="field:'servicebegintime',align:'center',sortable:true">开通时间</th>
				<th data-options="field:'chargingbegintime',align:'center',sortable:true">开始计费时间</th>
				<th data-options="field:'bussinessstat',align:'center'"  formatter="statusFormatter">状态</th>
				<th data-options="field:'operation',align:'center',width:80" formatter="operateFormatter" >操作</th>
			</tr>
			</thead>
		</table>
	</div>

</div>
<div id="win" class="easyui-window" title="详细信息" closed="true" style="width:300px;height:100px;padding:5px;">
	<div style="padding: 0px; text-align: left;height: 400px">
		<form class="form-horizontal" role="form">
		<fieldset style="border: none">
			<legend>基础配置信息</legend>
			<div class="form-group">
				<label class="col-sm-1 control-label" style="text-align: center">CPU</label>
				<div class="col-sm-5">
					<input class="form-control" id="cpu" type="text" placeholder="192.168.1.161" readonly/>
				</div>
				<label class="col-sm-1 control-label" style="text-align: center" >内存</label>
				<div class="col-sm-5">
					<input class="form-control" id="mem" type="text" readonly />
				</div>
				<label class="col-sm-2 control-label" style="text-align: center">硬盘</label>
				<div class="col-sm-4">
					<input class="form-control" id="disk" type="text" readonly />
				</div>
				<label class="col-sm-2 control-label" style="text-align: center">操作系统</label>
				<div class="col-sm-4">
					<input class="form-control" id="os_name" type="text" readonly/>
				</div>
			</div>

		</fieldset>

			<fieldset style="border: none">
				<legend>网络信息</legend>
				<div class="form-group">
					<label for="interaIp" class="col-sm-2 control-label" style="text-align: center">内网IP</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="interaIp" readonly>
					</div>
					<label for="interaPort" class="col-sm-2 control-label" style="text-align: center">内网端口</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="interaPort" readonly >
					</div>
					<label for="interaIpUnicom" class="col-sm-2 control-label" style="text-align: center">联通外网IP</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="interaIpUnicom" readonly>
					</div>
					<label for="interPort" class="col-sm-2 control-label" style="text-align: center">外网端口P</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="interPort" readonly>
					</div>
				</div>
			</fieldset>

			</form>


	</div>
</div>
<script type="text/javascript" src="../gov2.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		var severType = [{id: 'COMPUTE', text: '计算'}, {id: 'STORAGE', text: '存储'}, {id: 'DB', text: '数据库'}, {
			id: 'DR',
			text: '容灾'
		}];
		loadDataGrid();
		//服务类型
		$('#serverType').combobox({
			data: severType,
			valueField: 'id',
			textField: 'text',
			width:100,
			panelHeight: '100'
		});
		//所属单位
		$('#resourceUnit').combobox({
			url:'${pageContext.request.contextPath}/infopublish/getDepartsAll.do',
			valueField: 'unitId',
			textField: 'unitName',
			width:100,
			panelHeight: '100'
		});

		$("#search").click(function () {
			searchDataGrid();
		});

		$("#formReset").click(function () {
			$("#resource_searchform").form("reset");
		});

		function loadDataGrid() {
			$('#dg').datagrid({
				rownumbers: false,
				scrollbarSize:0,
				checkOnSelect: true,
				selectOnCheck: true,
				border: false,
				striped: true,
				sortName: 'fname',
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
				url: '${pageContext.request.contextPath}/resourceinfo/resourceinfoListProduct.do'
			});
		}

		function searchDataGrid() {
			console.log( $('#resource_searchform').form('serialize'));
			$('#dg').datagrid('load', $('#resource_searchform').form('serialize'));
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

	/**
	 *这个方法暂时不要取消掉方法中的注释
	 * @param val
	 * @param row
	 * @param index
	 * @returns {*}
	 */
	function serverFormat(val, row, index) {
//        if (!(row['servername'])) {
//            return (row['typename'])
//        } else {
//            return val;
//        }
		return val;
	}

	function operatorFormat(){
		return ""
	}

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

	function operateFormatter(val,rows,index){
		var _neid = rows['objectid']
		var _objectname = rows['objectname']
		var atag = '<a href="javascript:void(0)" onclick="showManage(\''+_neid+'\',\''+_objectname+'\')">运行状态<\/a>  |';
		atag += '  <a href="javascript:void(0)" onclick="showDetail(\''+_neid+'\')">详情<\/a>';
		return atag;
	}

	function statusFormatter(val,row,index){

		if(val == "1"){
			return "服务已开启（未计费）"
		}
		if(val == "2"){
			return "计费已开启"
		}

	}
	function showManage(objectid,objectname){
		$('#centerTab').panel({
			<%--href:"${pageContext.request.contextPath}/vm/vmManageInit.do?neid_=" + neid--%>
			href:"../gov2/resourcemanage/vminfo.jsp?neId="+ objectid+'&objectName='+objectname
		});
	}

	function showDetail(objectid){
		var $win;
		$win = $('#win').window({
			title: '基本信息',
			width:700,
			height:500,
			top: 100,
			left: 500,
			shadow: true,
			modal: true,
//			iconCls: 'icon-add',
			closed: true,
			minimizable: false,
			maximizable: false,
			collapsible: false
		});

		$win.window('open');
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