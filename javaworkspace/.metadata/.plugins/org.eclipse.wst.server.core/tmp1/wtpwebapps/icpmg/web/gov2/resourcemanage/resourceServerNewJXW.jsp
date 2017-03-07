<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ include file="../../../icp/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>资源一览</title>
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
	
	.info-Legend{background: #fff;}
</style>
<%--<link href="${ctx}/web/gov2/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">--%>
<%--<link href="${ctx}/styles/gov2.css" rel="stylesheet" media="screen">--%>
<%--<script src="${ctx}/js/scripts/jquery-1.8.3.min.js"></script>--%>
<%--<script src="${ctx}/web/gov2//bootstrap/js/bootstrap.min.js"></script>--%>
<div class="easyui-layout" data-options="fit:true,border:false"
	 style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;height:500px;">
	<div data-options="region:'north',border:false" style="background:#eee;height:50px;overflow:hidden;">
		<form id="resource_searchform">
			<table  >
				<tr style="margin: 10px 20px 10px 20px;padding: 10px;" >
					<td style="margin: 10px 20px 10px 20px;padding: 10px;">单位：<input name="resourceUnit" id="resourceUnit" style="width:200px;height:30px;"></td>
					<td style="margin: 10px 20px 10px 20px;padding: 10px;">服务类型：<input class="easyui-textbox" name="serverType" id="serverType" data-options="validType:'isBlank'" style="width:100px;height:30px;"></td>
					<td style="margin: 10px 20px 10px 20px;padding: 10px;">服务名称：<input class="easyui-textbox" name="serverName" id="serverName" data-options="validType:'isBlank'" style="width:120px;height:30px;"></td>
					<td style="margin: 10px 20px 10px 20px;padding: 10px;">实例名称：<input class="easyui-textbox" name="resourceName" id="resourceName" style="width:200px;height:30px;"></td>
					<td><input type="hidden" name="severtypeidlevelfirst" id="severtypeidlevelfirst" >
							<input type="hidden"  name="servertypeidlevelsecond" id="servertypeidlevelsecond" ></td>
					<td align="center" colspan="3">
						<a href="javascript:void(0);" id="search" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" id="formReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">重置</a>
					</td>
				</tr>
			</table>

		</form>
	</div>
	<div data-options="region:'center',border:false" id="resourcesid">
		<table title="" style="width:100%;" id="dg">
			<thead>
			<tr>
				<%--projectid, projectname, unittype, unitid, unitname, objectid, severtypeidlevelfirst,--%>
				<%--servertypenamelevelfirst, servertypeidlevelsecond, servertypenamesecond, appname, bussinessstat, extension1, extension2, extension3, snote--%>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'nename',hidden:true"></th>
				<th data-options="field:'typeid',hidden:true"></th>
				<th data-options="field:'vmInfo',hidden:true" ></th>
				<th data-options="field:'configure',hidden:true" ></th>
				<th data-options="field:'networktypename',hidden:true" ></th>
				<th data-options="field:'remark',hidden:true">备注</th>
				<th data-options="field:'projectid',width:60,align:'center',hidden:true,sortable:true"  formatter="serverFormat">项目编号</th>
				<th data-options="field:'projectname',width:100,align:'center',sortable:true">项目名称</th>
				<th data-options="field:'unitname',width:100,align:'center',sortable:true">使用单位</th>
				<th data-options="field:'servertypenamelevelfirst',width:100,align:'center'" >服务类型</th>
				<th data-options="field:'servertypenamesecond',align:'center',sortable:true,">服务名称</th>
				<th data-options="field:'appname',width:100,align:'center'" >应用</th>
				<th data-options="field:'neid',align:'center',sortable:true">实例名称</th>
				<th data-options="field:'testtime',align:'center',sortable:true">开通时间</th>
				<th data-options="field:'usetime',align:'center',sortable:true">计费时间</th>
				<th data-options="field:'feestat',align:'center'"  formatter="statusFormatter">状态</th>
				<th data-options="field:'operation',align:'center',width:80" formatter="operateFormatter" >操作</th>
			</tr>
			</thead>
		</table>
	</div>

</div>

<script type="text/javascript" src="../gov2.js"></script>
<script type="text/javascript">
	var flagck = 0;  //  初始化为0
	$(document).ready(function () {
		loadDataGrid();
		//服务类型 一级分类-二级分类级联
		$('#serverName').combobox({
			//url:'${ctx}/resourceinfo/getSevertypeSecondList.do',
			//valueField: 'servertypeid',
			//textField: 'servertypename',
			width:120,
			panelHeight: '100'
		});
		
		$('#serverType').combobox({
			url:'${pageContext.request.contextPath}/resourceinfo/getSevertypeList.do',
			valueField: 'servertypeid',
			textField: 'servertypename',
			width:100,
			panelHeight: '100',
			loadFilter:function(data){
				data.unshift({servertypeid:"",servertypename:"请选择"});
				return data;
			},
			onSelect:function (record){
				var _servertypeid = record.servertypeid;
				$('#serverName').combobox({
					url:'${pageContext.request.contextPath}/resourceinfo/getSevertypeSecond.do?servertypeid='+_servertypeid,
					valueField: 'servertypeid',
					textField: 'servertypename',
				});
			}
			
		});
	
		//所属单位
		$('#resourceUnit').combobox({
			url:'${pageContext.request.contextPath}/project/getUnitsData.do',
			valueField: 'unitId',
			textField: 'unitName',
			width:200,
			panelHeight: '100',
			loadFilter:function(data){
				data.unshift({unitId:"",unitName:"请选择"});
				return data;
			}
		});

		$("#search").click(function () {
			searchDataGrid();
		});

		$("#formReset").click(function () {
			$("#resource_searchform").form("reset");
			searchDataGrid();
		});

		function loadDataGrid() {
			$('#dg').datagrid({
				rownumbers: false,
				scrollbarSize:0,
				checkOnSelect: true,
				selectOnCheck: false,
				border: false,
				striped: true,
				sortName: 'testtime',
				sortOrder: 'desc',
				nowarp: false,
				singleSelect: true,
				method: 'post',
				loadMsg: '数据装载中......',
				fitColumns: true,
				idField: 'neid',
				pagination: true,
				pageSize:10,
				pageNumber:1,
				pageList: [5,10,20,30],
				url: '${pageContext.request.contextPath}/resourceinfo/resourceinfoListProduct.do',
				onLoadSuccess: function (data) {
					var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
					var  _pageSize = pageopt.pageSize;
					var  _rows = $('#dg').datagrid("getRows").length
					var total = pageopt.total; //显示的查询的总数
					if (_pageSize >= 10) {
						for(i=10;i>_rows;i--){
//							{ itemid: '<div style="text-align:center;color:red">没有相关记录！</div>' }
							//添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
							$(this).datagrid('appendRow', {operation:''  })
						}
						 $('#dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
									    		total: total,
									    	});
						//	$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
					}else{
						//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
						$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					}
					  var rows = data.rows;
				      if (rows.length) {
							 $.each(rows, function (idx, val) {
							
								if(val.operation==''&&val.operation!='0'){  
									$('#resourcesid  input:checkbox').eq(idx+1).css("display","none");
									 
								}
								
							}); 
				      }
					
				},
				//没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.operation==''&&rowData.operation!='0'){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
					$('#resourcesid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck = 1;
							$.each(rows, function (idx, val) {
								if (val.operation==''&&val.operation!='0'){
									$("#grid").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
								}
							});
					},
									
					onUncheckAll: function(rows) {
						flagck = 0;
					}  

			});
		}

		function searchDataGrid() {
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
	 *这个方法暂时不要去掉方法中的注释
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

	function operateFormatter(val,rows,index){
		var _neid = rows['neid'];
		var _objectname = rows['nename'];
//		var atag = '<a href="javascript:void(0)" onclick="showManage(\''+_neid+'\',\''+_objectname+'\')">运行状态<\/a>  |';
		if(_neid){
			var atag = '  <a href="javascript:void(0)" onclick="showDetail(\''+_neid+"','"+index+'\')">详情<\/a>';
		}
		return atag;
	}

	function statusFormatter(val,rows,index){

		switch (rows.feestat) {
			case "1":
				return "试运行";//开始试运行修改为试运行
			case "2":
				return "计费开始";
			case "3":
				return "计费结束";
		}

	}
	function showManage(objectid,objectname){
		$('#centerTab').panel({
			<%--href:"${pageContext.request.contextPath}/vm/vmManageInit.do?neid_=" + neid--%>
			href:"../gov2/resourcemanage/vminfo.jsp?neId="+ objectid+'&objectName='+objectname
		});
	}

	function showDetail(objectid,index) {
		var $win;
//		var rows = $('#dg').datagrid('getChecked');

		var row = $('#dg').datagrid('getData').rows[index];
		if (!("VM" == row.typeid)) {
		 if("HLW"==row.typeid){
		    
		   		$('<div></div>').dialog({
				id: 'hlwwindowApp',
				title: '应用服务信息',
				width: 750,
				height: 500,
				closed: false,
				cache: false,
				href: '${ctx}/web/gov2/resourcemanage/resourceIP.jsp?objectid='+objectid,
				modal: true,
				onClose: function () {
					$(this).dialog('destroy');
				}
			});
		 }
		  else if("InSecurity"==row.typeid){
			 $('<div></div>').dialog({
					id: 'FWResource',
					title: '防火墙信息',
					width: 700,
					height: 500,
					closed: false,
					cache: false,
					href: '${ctx}/web/gov2/resourcemanage/resourceFWInfo.jsp?objectid='+objectid,
					modal: true,
					onLoad: function () {
						 
						$("#fzjhNeid").textbox('setValue',row.neid);
						var fzjhFeeStat = row.feestat;
						var fzjhFeeStatName = "";
						if(fzjhFeeStat == "1"){
							fzjhFeeStatName = "试运行";
						}else if(fzjhFeeStat == "2"){
							fzjhFeeStatName = "计费开始";
						}else if(fzjhFeeStat == "3"){
							fzjhFeeStatName = "计费结束";
						}
						$("#fzjhStatus").textbox('setValue',fzjhFeeStatName);
						$("#fzjhName").textbox('setValue',row.displayname);
						$("#fzjhNetWorkName").textbox('setValue',row.networktypename);
						$("#fzjhservertypenamelevelfirst").textbox('setValue',row.servertypenamelevelfirst);
						$("#fzjhservertypenamesecond").textbox('setValue',row.servertypenamesecond);
						$("#fzjhProjectName").textbox('setValue',row.projectname);
						$("#fzjhUseUnitName").textbox('setValue',row.unitname);
						$("#fzjhUsetime").textbox('setValue',row.usetime);
						$("#fzjhBuyTime").textbox('setValue',row.testtime)
						$("#fzjhAppname").textbox('setValue',row.appname);
					},
					onClose: function () {
						$(this).dialog('destroy');
					}
			 });
		 }
		 else if("InSLB"==row.typeid){//负载均衡
			 $('<div></div>').dialog({
					id: 'fzjhResource',
					title: '负载均衡信息',
					width: 700,
					height: 500,
					closed: false,
					cache: false,
					href: '${ctx}/web/gov2/resourcemanage/resourceFzjhInfo.jsp?objectid='+objectid,
					modal: true,
					onLoad: function () {
						$("#fzjhNeid").textbox('setValue',row.neid);
						var fzjhFeeStat = row.feestat;
						var fzjhFeeStatName = "";
						if(fzjhFeeStat == "1"){
							fzjhFeeStatName = "试运行";
						}else if(fzjhFeeStat == "2"){
							fzjhFeeStatName = "计费开始";
						}else if(fzjhFeeStat == "3"){
							fzjhFeeStatName = "计费结束";
						}
						$("#fzjhStatus").textbox('setValue',fzjhFeeStatName);
						$("#fzjhName").textbox('setValue',row.displayname);
						$("#fzjhNetWorkName").textbox('setValue',row.networktypename);
						$("#fzjhservertypenamelevelfirst").textbox('setValue',row.servertypenamelevelfirst);
						$("#fzjhservertypenamesecond").textbox('setValue',row.servertypenamesecond);
						$("#fzjhProjectName").textbox('setValue',row.projectname);
						$("#fzjhUseUnitName").textbox('setValue',row.unitname);
						$("#fzjhUsetime").textbox('setValue',row.usetime);
						$("#fzjhBuyTime").textbox('setValue',row.testtime)
						$("#fzjhAppname").textbox('setValue',row.appname);
					},
					onClose: function () {
						$(this).dialog('destroy');
					}
			 });
		 }
		 else if("JGTG"==row.typeid){
		    
		   		$('<div></div>').dialog({
				id: 'jgwindowApp',
				title: '应用服务信息',
				width: 800,
				height: 570,
				closed: false,
				cache: false,
				href: '${ctx}/web/gov2/resourcemanage/resourceJGTG.jsp?objectid='+objectid,
				modal: true,
				onLoad: function () {
			      $("#ywyyxt").val(row.appname);
					/* $("#unitname").textbox('setValue', row.unitname);
					$("#projectname").textbox('setValue', row.projectname);
					$("#servertypenamelevelfirst").textbox('setValue', row.servertypenamelevelfirst);
					$("#servertypenamesecond").textbox('setValue', row.servertypenamesecond);
					$("#objectname").textbox('setValue', row.nename);
					$("#appname").textbox('setValue', row.appname);
					$("#extension1").textbox('setValue', row.configure);
//					$('#windowApp').window('open');
					$('#windowApp input').attr("readonly", "readOnly"); */
				},
				onClose: function () {
					$(this).dialog('destroy');
				}
			});
		 }
		 else if("JWTG"==row.typeid){
		  
		 	$('<div></div>').dialog({
				id: 'jwwindowApp',
				title: '应用服务信息',
				width: 800,
				height: 570,
				closed: false,
				cache: false,
				href: '${ctx}/web/gov2/resourcemanage/resourceJWTG.jsp?objectid='+objectid,
				modal: true,
				onLoad: function () {
				$("#u_ywyyxt").val(row.appname);
					/* $("#unitname").textbox('setValue', row.unitname);
					$("#projectname").textbox('setValue', row.projectname);
					$("#servertypenamelevelfirst").textbox('setValue', row.servertypenamelevelfirst);
					$("#servertypenamesecond").textbox('setValue', row.servertypenamesecond);
					$("#objectname").textbox('setValue', row.nename);
					$("#appname").textbox('setValue', row.appname);
					$("#extension1").textbox('setValue', row.configure);
//					$('#windowApp').window('open');
					$('#windowApp input').attr("readonly", "readOnly"); */
				},
				onClose: function () {
					$(this).dialog('destroy');
				}
			});
		 
		 } else if("VIP"==row.typeid){
		 	$('<div></div>').dialog({
				id: 'vipWindowApp',
				title: '专享云服务信息',
				width: 1000,
				height: 530,
				closed: false,
				cache: false,
				href: '${ctx}/web/gov2/resourcemanage/resourceVip.jsp?objectid='+objectid,
				modal: true,
				onLoad: function () {
				
				},
				onClose: function () {
					$(this).dialog('destroy');
				}
			});
		 
		 }else if("InDisk"==row.typeid){
			 	$('<div></div>').dialog({
					id: 'indiskWindowApp',
					title: '云硬盘服务信息',
					width: 720,
					height: 400,
					closed: false,
					cache: false,
					href: '${ctx}/web/gov2/resourcemanage/resourceIndisk.jsp?objectid='+objectid,
					modal: true,
					onLoad: function () {
						$("#unitname").val(row.unitname);
						$("#projectname").val(row.projectname);
						$("#servertypenamelevelfirst").val(row.servertypenamelevelfirst);
						$("#servertypenamesecond").val(row.servertypenamesecond);
						$("#displayname").val(row.displayname);
						$("#networktypename").val(row.networktypename);
						$('#indiskWindowApp input').attr("readonly", "readOnly");
					},
					onClose: function () {
						$(this).dialog('destroy');
					}
				});
			 
			 }else{
		 
			$('<div></div>').dialog({
				id: 'windowApp',
				title: '应用服务信息',
				width: 600,
				height: 570,
				closed: false,
				cache: false,
				href: '${ctx}/web/gov2/resourcemanage/resourceAppForm.jsp',
				modal: true,
				onLoad: function () {
					var disknum = "";
					var temp = "";
					
					$("#objectid").html(row.neid);
					$("#objectid").attr("title",row.neid);
					$("#unitname").html(row.unitname);
					$("#unitname").attr("title",row.unitname);
					$("#projectname").html(row.projectname);
					 
					$("#servertypenamelevelfirst").html('计算');
					$("#servertypenamesecond").html('云服务器服务');
					$("#objectname").html(row.nename);
					$("#displayname").html(row.neid);
					$("#appname").html(row.appname);
					$("#appname").attr("title",row.appname);
					$("#cpunum").text(row.vmInfo.cpunum);
					$("#memnum").text(row.vmInfo.memnum);
					//storage换成disknum
					$("#disknum").text(temp);
	        	 
					$("#osname").text(row.vmInfo.osname);
					$("#osname").attr("title",row.vmInfo.osname);
					$("#hostid").text(row.vmInfo.hostid);
					if (1 == Number(row.networktypeid)) {
						$("#networktype_zw").text("政务外网");
						
						//$("#windowVM").height(400);
						$("#interaip_zw").text(row.vmInfo.interaip);					
						$("#interaport_zw").text(row.vmInfo.interaport);
						
						$("#interipgov").text(row.vmInfo.interipgov);					
						$("#interport_zw").text(row.vmInfo.interport);
						$("#bandwidth_zw").text(row.vmInfo.bandwidth);	
							
						$("#zwww-wrap").show();
						$("#hlw-table").hide(); 
					    $("#wlxx-wrap").hide();
					 
					}
				},
				onClose: function () {
					$(this).dialog('destroy');
				}
			});
		 }
		} else {
			$('<div></div>').dialog({
				id: 'windowVM',
				title: '云服务器信息',
				width: 780,
				 top:"60px",
				closed: false,
				cache: false,
				href: '${ctx}/web/gov2/resourcemanage/resourceForm.jsp',
				modal: true,
				onLoad: function () {
					var disknum = "";
					var temp = "";
					if(row.hasOwnProperty("vmInfo")){
					
						if(row.vmInfo != "undefined" && row.vmInfo.disknum != ""){
						  	disknum = row.vmInfo.disknum;
						  
						   //1,20;2,40
			                if(disknum.length!=0){
			                	var fArr = disknum.split(";");
			               
							 for(var i=0; i<fArr.length; i++){
								 
					           var sArr = fArr[i].split(",");
					               if(fArr[i].indexOf(':')!=-1){
					                 sArr = fArr[i].split(":");
					               }
							if(sArr[1] && sArr[1] != "undefined"){
								 temp += sArr[1] + "-";
								}
								
			                  }
			                  temp = temp.substring(0, temp.length - 1);
			                
			                }
						}
					}
					
	               // var a = disknum.indexOf(",");
	               // var b = disknum.indexOf(";");
	                //var c = disknum.lastIndexOf(",");
	               // var disknum1 = disknum.substring(a+1,b);
	        		//var disknum2 = disknum.substring(c+1);
					//初始化表单数据
					/* $('#windowVM a').removeClass();
					$('#windowVM a').addClass("hidden"); */
					$("#objectid").html(row.neid);
					$("#objectid").attr("title",row.neid);
					$("#unitname").html(row.unitname);
					$("#unitname").attr("title",row.unitname);
					$("#projectname").html(row.projectname);
					 
					$("#servertypenamelevelfirst").html('计算');
					$("#servertypenamesecond").html('云服务器服务');
					$("#objectname").html(row.nename);
					$("#displayname").html(row.neid);
					$("#appname").html(row.appname);
					$("#appname").attr("title",row.appname);
					$("#cpunum").text(row.vmInfo.cpunum);
					$("#memnum").text(row.vmInfo.memnum);
					//storage换成disknum
					$("#disknum").text(temp);
	        	 
					$("#osname").text(row.vmInfo.osname);
					$("#osname").attr("title",row.vmInfo.osname);
					$("#hostid").text(row.vmInfo.hostid);
					if (1 == Number(row.networktypeid)) {
						$("#networktype_zw").text("政务外网");
						
						//$("#windowVM").height(400);
						$("#interaip_zw").text(row.ipaddr);					
						$("#interaport_zw").text(row.vmInfo.interaport);
						
						$("#interipgov").text(row.vmInfo.interipgov);					
						$("#interport_zw").text(row.vmInfo.interport);
						$("#bandwidth_zw").text(row.vmInfo.bandwidth);	
							
						$("#zwww-wrap").show();
						$("#hlw-table").hide(); 
					    $("#wlxx-wrap").hide();
					 
					}
					else
					{
						$("#networktype").text("互联网");
						$("#domainname").text(row.vmInfo.domainname);
						$("#interaip").text(row.ipaddr);
						$("#interipunincom").text(row.vmInfo.interipunincom);
						$("#interaport").text(row.vmInfo.interaport);
						$("#interaport").attr("title",row.vmInfo.interaport);
						$("#interport").text(row.vmInfo.interport);
						$("#interport").attr("title",row.vmInfo.interport);
						$("#bandwidth").text(row.vmInfo.bandwidth);
						
						$("#interiptelecom").text(row.vmInfo.interiptelecom);
						$("#telecombwidth").text(row.vmInfo.telecombwidth);
						$("#telecomaport").text(row.vmInfo.telecomaport);
						$("#telecomaport").attr("title",row.vmInfo.telecomaport);
						$("#telecomport").text(row.vmInfo.telecomport);
						$("#telecomport").attr("title",row.vmInfo.telecomport);
						
						$("#interipmobile").text(row.vmInfo.interipmobile);
						$("#mobileport").text(row.vmInfo.mobileport);
						$("#mobileport").attr("title",row.vmInfo.mobileport);
						$("#mobileaport").text(row.vmInfo.mobileaport);
						$("#mobileaport").attr("title",row.vmInfo.mobileaport);
						$("#mobilebwidth").text(row.vmInfo.mobilebwidth);
						 
						$("#hlw-table").show(); 
					    $("#wlxx-wrap").show();
						$("#zwww-wrap").hide(); 
					} 
					<%-- $("#interaport").textbox('setValue', row.vmInfo.interaport);
					$("#interipunincom").textbox('setValue', row.vmInfo.interipunincom);
					$("#interiptelecom").textbox('setValue', row.vmInfo.interiptelecom);
					$("#interipgov").textbox('setValue', row.vmInfo.interipgov);
//					$("#interport").textbox('setValue', row.vmInfo.interport);
					$("#bandwidth").textbox('setValue',row.vmInfo.bandwidth);
					url='${ctx}/resourceinfo/updateResourceVM.do';
//					$('#win').window('open');
					$('#windowVM input').attr("readonly", "readOnly"); --%>
				},
				onClose: function () {
					$(this).dialog('destroy');
				}

			});
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