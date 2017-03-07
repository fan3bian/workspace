<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<style type="text/css">
  .detail-line{
    margin: 10px 25px;
  }
</style>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="background:#eee;height:40px;overflow:hidden;border:0;margin-bottom: 10px">
					<form id="resource_searchform">
				<table  >
					<tr style="margin: 10px 20px 10px 20px;padding: 10px;" >
						<td style="margin: 10px 20px 10px 20px;padding:5px;">单位：<input name="resourceUnit" id="resourceUnit" style="width:180px;height:30px;"></td>
						<td style="margin: 10px 20px 10px 20px;padding:5px;">服务类型：<input class="easyui-textbox" name="serverType" id="serverType" data-options="validType:'isBlank'" style="width:100px;height:30px;"></td>
						<td style="margin: 10px 20px 10px 20px;padding:5px;">服务名称：<input class="easyui-textbox" name="serverName" id="serverName" data-options="validType:'isBlank'" style="width:120px;height:30px;"></td>
						<td style="margin: 10px 20px 10px 20px;padding:5px;">实例名称：<input class="easyui-textbox" name="resourceName" id="resourceName" style="width:150px;height:30px;"></td>
						<td><input type="hidden" name="severtypeidlevelfirst" id="severtypeidlevelfirst" >
							<input type="hidden"  name="servertypeidlevelsecond" id="servertypeidlevelsecond" ></td>
						<td align="center" colspan="3">
							<a href="javascript:void(0);" id="search" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" id="formReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">重置</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-muban',plain:true" onclick="downloadExcel()">模板下载</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-daoru',plain:true" onclick="infoImport()">信息导入</a>&nbsp;&nbsp;
						</td>
					</tr>
				</table>

			</form>
		</div>
		<div data-options="region:'center',border:false">		
			<div data-options="region:'center',border:false" id="addid">
				<table title="" style="width:100%;" id="dg">
					<thead>
					<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'nename',hidden:true"></th>
							<th data-options="field:'typeid',hidden:true"></th>
							<th data-options="field:'vmInfo',hidden:true" ></th>
							<th data-options="field:'configure',hidden:true" ></th>
							<th data-options="field:'projectid',width:60,align:'center',hidden:true,sortable:true"  >项目编号</th>
							<th data-options="field:'projectname',width:80,align:'center',sortable:true">项目名称</th>
							<th data-options="field:'unitname',align:'center',sortable:true">所属单位</th>
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
	</div>
	<div id="importwindow" class="easyui-window" title="上传文件" data-options="closed:true,modal:true,iconCls:'icon-save',inline:true,modal:true"
		 style="width:600px;height:400px;padding:5px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:10px;">
				<form id="uploadForm" method="post" enctype="multipart/form-data">
					<table align="center" style="width:100%">
						<tr>
							<div class="detail-line"  style="margin: 15px 20px">
								<span>选择文件：</span>
								<input class="easyui-filebox" data-options="prompt:'请选择要上传的excel文件'" buttonText='选择文件' style="width:250px;height: 30px"  id="fileurl" name="filepath" data-options="buttonText:'选择文件'"/>
								<font color="red">选择一个附件*</font></td>
							</div>
						</tr>
					</table>
				</form>
			</div>
			<div data-options="region:'south',border:false"
				 style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" id="confirmBtn" href="javascript:void(0)"
				   onclick="confirmUpload();" style="width:80px">确定</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
				   onclick="$('#importwindow').window('close');" style="width:80px">关闭</a>
			</div>
		</div>
	</div>
<script type="text/javascript" src="../gov2.js"></script>
<script type="text/javascript">
	var flagck = 0;  //  初始化为0
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
				idField: 'projectid',
				pagination: true,
				pageSize:10,
				pageNumber:1,
				pageList: [5,10,20,30],
				url: '${pageContext.request.contextPath}/resourceinfo/resourceinfoListVM.do',
				onLoadSuccess: function (data) {
				      var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
				      var  _pageSize = pageopt.pageSize;
				      var  _rows = $('#dg').datagrid("getRows").length;
				      var total = pageopt.total; //显示的查询的总数
				      if (_pageSize >= 10) {
				         for(i=10;i>_rows;i--){
				            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
				            $(this).datagrid('appendRow', {objectid:'',operation:''  })
				         }
				         $('#dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
					    	total: total,
					     });
				         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
				      }else{
				         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
				         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				      }
				    //设置不显示复选框
		              var rows = data.rows;
		                if (rows.length) {
		                 $.each(rows, function (idx, val) {
		                  if(val.objectid==''){ 
		                    //addid为datagrid上一层的div id
		                    $('#addid  input:checkbox').eq(idx+1).css("display","none");
		                     
		                  }
		                }); 
		              }
		           } ,
		           //没数据的行不能被点击选中
		           onClickRow: function (rowIndex, rowData) {
		              if(rowData.objectid==''){
		                 $(this).datagrid('unselectRow', rowIndex);
		              }else{
		                //点击有数据的行  标志位变为0
		                flagck=0;
		              }
		              //判断时候已经有全部选择
		              if(flagck ==1){
		                $('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
		              }
		          }, 
		           //点击全选
		          onCheckAll: function(rows) {
		              //全选时，标志位变为1
		              flagck = 1;
		              $.each(rows, function (idx, val) {
		                if(val.objectid==''){
		                  //如果是空行，不能被选中
		                  $("#dg").datagrid('uncheckRow', idx);
		                  //增加全选复选框被选中
		                  $('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");  
		                }
		              });
		          }, 
		           //点击全选
		          onUncheckAll: function(rows) {
		            //取消全选时，标志位变为0
		            flagck = 0;
		          }
		        });
		}

		function searchDataGrid() {
			//console.log($('#vm_searchform').form('serialize'));
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
	function operateFormatter(val,rows,index){
		if(!(rows['operation'] == '')){
			var str='';
			str += '<a onclick="operMonitor(\''+rows.neid+'\');">运行监控</a>';
			//str += '<a onclick="alarmStatistics(\''+rowData.serverid+'\');">|告警统计</a>';
			return str;
		}

	}

	//运行监控
	function operMonitor(vmid){
/* 		var orghref = "${pageContext.request.contextPath}/instance/operMonitor.do?neid_=" + vmid;
		$('#centerTab').panel({
			href:encodeURI(orghref)
		}); */
		var neid = vmid;
		var orghref = '/icpmg/web/omsMonitor/inserver/jsp/runOverview.jsp';
		var oskhref = '/icpmg/web/omsMonitor/inserver/jsp/osRunOverview.jsp';
		
		var platformTypeUrl = '${pageContext.request.contextPath}/oms_summary/queryVmPlatformType.do';
		$.ajax({
	  		type : 'post',
	  		url:encodeURI(platformTypeUrl),
	  		data:{
	  			serverId:neid  			
	  		},
	  		dataType:'json',
	  		success:function(retr){
	  		   var currentServerName = retr.servername;
	  		   var currentPlattype =	retr.plattype;
	  			if(currentPlattype == 'vmware'){
	  				$('#centerTab').panel({
	  					href:encodeURI(orghref),
	  					queryParams:{
	  						neid:neid
	  					}
	  					});	
	  				
	  			}else if(currentPlattype == 'openstack'){
	  				$('#centerTab').panel({
	  					href:encodeURI(oskhref),
	  					queryParams:{
	  						nename:currentServerName
	  					}
	  					});	 				
	  			}else{
	  				$('#centerTab').panel({
	  					href:encodeURI(orghref),
	  					queryParams:{
	  						neid:neid
	  					}
	  					});	
	  				
	  			}
	  			
	  			
	  		}
		});
	}

	function showManage(objectid,objectname,serverStarttime){
		 var _href = "../gov2/resourcemanage/vminfo.jsp";
		<%--if( (${sessionScope.sessionUser.roleid}) == '1000000047'){--%>
			<%--_href = "../gov2/resourcemanage/vminfoTJ.jsp";--%>
		<%--}--%>
		$('#centerTab').panel({
			href: encodeURI(_href+"?neId="+ objectid+'&objectName='+objectname+"&serverStarttime="+serverStarttime)
		});
	}

	//下载模板
	function downloadExcel(){
		var url = '${pageContext.request.contextPath}/instance/downloadExcel.do';
		$.ajax({
			type : 'post',
			url : url,
			dataType:'text',
			async: false,
			success:function(result){
				console.log(result);
				url = '${pageContext.request.contextPath}/'+result;
				window.location.href = url;
			}
		});
	}


	//信息导入 按钮
	function infoImport(){
		url='${pageContext.request.contextPath}/instance/infoImportVM.do';
		$('#importwindow').window('open');
	}

	//信息导入 确定按钮
	function confirmUpload(){
		$('#uploadForm').form('submit',{
			url:url,
			onSubmit:function(){
				var filetype = $("#uploadForm input[name='filepath']")[0].value;
				var fileTemp = filetype.substring(filetype.lastIndexOf(".")+1);
				var arr = new Array("xls","xlsx");
				var flag = 0;
				if(!filetype){
					$.messager.alert('消息', "请选择要上传的excel文件！","info");
					return false;
				}else{
					for(var i=0;i<arr.length;i++){
						if(arr[i]==fileTemp){
							flag = "1";
						}
					}
					if(flag=="0"){
						$.messager.alert('消息', '请选择正确格式的excel文件！',"info");
						return false;
					}
				}
			},
			success:function(retr){
				var _data =  JSON.parse(retr);
				$.messager.alert('消息',_data.msg);
				if(_data.success){
					$('#importwindow').window('close');
					$('#object_grid').datagrid('reload');
				}
			}
		});
	}
</script>
</body>
</html>