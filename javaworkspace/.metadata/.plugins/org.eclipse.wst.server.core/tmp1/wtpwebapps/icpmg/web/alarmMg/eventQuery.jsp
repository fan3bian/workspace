<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
<style type="text/css">
.product-product-close {
  position: absolute;
  top: 50%;
  margin-top: -8px;
  height: 16px;
  overflow: hidden;
  background: url('${pageContext.request.contextPath}/easyui-1.4/themes/default/images/panel_tools.png') no-repeat -16px 0px;
}
.FieldInput2 {
	width: 37%;
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
	width: 13%;
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
	<script type="text/javascript">
		var flagck = 0;
		var toolbarquery = [
				{
				    id:'almexp',
				    disabled:false,
					text : '导出',
					iconCls : 'icon-almexport',
					handler : function() {
						exportQueryExcel();
					} 
				}         
		 ];
		function exportQueryExcel(){
			
			$('#alarmqueryevent_searchform').form('submit',{
					url:'${pageContext.request.contextPath}/alarm/exportExcel.do',
				});
	}
		$(document).ready(function() {
			loadDataGrid();

		});
		function loadDataGrid() {
			$('#dg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'occurtime',
								sortOrder : 'desc',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								//idField : 'pid',
								queryParams: {
									resourcetypeid: '<%=request.getParameter("type")%>'
								},
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbarquery,
								url : '${pageContext.request.contextPath}/alarm/queryEvent.do?almCategory=act',
									onLoadSuccess: function (data) {
									      var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
									      var  _pageSize = pageopt.pageSize;
									      var  _rows = $('#dg').datagrid("getRows").length;
									      var total = pageopt.total; //显示的查询的总数
									      if (_pageSize >= 10) {
									         for(var i=10;i>_rows;i--){
									            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
									            $(this).datagrid('appendRow', {content:''  });
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
													if   (val.content==''){  
														$('#querevent  input:checkbox').eq(idx+1).css("display","none");
														 
													}
												}); 
									      }
									 } ,
									 //没数据的行不能被点击
									 onClickRow: function (rowIndex, rowData) {
												if   (rowData.content==''){
													 $(this).datagrid('unselectRow', rowIndex);
												}else{
													flagck=0;
												}
												//判断时候已经有全部选择
												if(flagck ==1){
													$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
												}
									}, 
									 //全选问题
									onCheckAll: function(rows) {
										flagck = 1;
											$.each(rows, function (idx, val) {
												if   (val.content==''){
													$("#dg").datagrid('uncheckRow', idx);
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
			$('#dg').datagrid('load',
				icp.serializeObject($('#alarmqueryevent_searchform')));
		};
		function querySeverityFormater(value, row, index) {
			//console.log("servity--->"+value);
				switch (value) {
							/* case 0:
								return "<span style=\"color:yellow\">警告</span>";
							case 1:
								return "<span style=\"color:gray\">一般</span>";
							case 2:
								return "<span style=\"color:orange\">次要</span>";
							case 3:
								return "<span style=\"color:purple\">主要</span>";
							case 4:
								return "<span style=\"color:red\">重要</span>"; */
							case 0:
								return "<div style=\"background-color:yellow;\">警告</div>";
							case 1:
								return "<div style=\"background-color:gray; \">一般</div>";
							case 2:
								return "<div style=\"background-color:orange; \">次要</div>";
							case 3:
								return "<div style=\"background-color:purple; \">主要</div>";
							case 4:
								return "<div style=\"background-color:red; \">重要</div>";
						}
		}
		
		function effectformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:green\">成功</span>";
							case "0":
								return "<span style=\"color:gray\">尝试</span>";
							case "2":
								return "<span style=\"color:orange\">失败</span>";
						}
		}
		function featureformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:yellow\">可疑</span>";
							case "0":
								return "<span style=\"color:red\">攻击</span>";
							case "2":
								return "<span style=\"color:blue\">扫描</span>";
								case "3":
							return "<span style=\"color:green\">正常</span>";
									case "4":
							return "<span style=\"color:orange\">异常</span>";
						}
		}
		function queryseverityformater(value) {
				switch (value) {
							case 0:
								return "警告";
							case 1:
								return "一般";
							case 2:
								return "次要";
								case 3:
							return "主要";
									case 4:
							return "重要";
						}
		}
		
		function effectformater(value) {
				switch (value) {
							case "1":
								return "成功";
							case "0":
								return "尝试";
							case "2":
								return "失败";
						}
		}
		function featureformater(value) {
				switch (value) {
							case "1":
								return "可疑";
							case "0":
								return "攻击";
							case "2":
								return "扫描";
								case "3":
							return "正常";
									case "4":
							return "异常";
						}
		}
		function categoryformater(value) {
				switch (value) {
							case "1":
								return "故障";
							case "0":
								return "事件";
						}
		}
		function detailformater(value, row, index) {
			if(value.length==0){
				return "<a style=\"color:blue;cursor:pointer\" ></a>";
			}else{
				return "<a style=\"color:blue;cursor:pointer\" onclick=\"viewDetails('"+ row.id+"');\">详情</a>";
			}
		}
		function viewDetails(id)
		{
			$.ajax({
			  		type : 'post',
			  		dataType:'json',
			  		url:'${pageContext.request.contextPath}/alarm/getEventDetail.do',
			  		data:{id:id},
			  		success:function(data){
			  			if(data.success)
				    	{
				    	
							for (var item in data.obj) {
								debugger;
								if($("#"+item).length>0)
								{
									if(item=="severity")
									{
										$("#"+item).val(queryseverityformater(data.obj[item]));
									}else if(item=="eventeffect")
									{
									$("#"+item).val(effectformater(data.obj[item]));
									}else if(item=="eventfeature")
									{
									$("#"+item).val(featureformater(data.obj[item]));
									}else if(item=="eventcategory")
									{
									$("#"+item).val(categoryformater(data.obj[item]));
									}else
									{
										$("#"+item).val(data.obj[item]);
									}
								}
							}
				    		$('#window').window('open');
				    	} 
			  		}
				  	});
		}
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="background:#eee;height:30px;overflow:hidden;border:false">
			<form id="alarmqueryevent_searchform" method="post">
				<table>
					<tr>
						<td>设备：<input class="easyui-textbox" name="resourcename"
							id="searchQresourcename" style="width:90px;height:30px;border:false">
							厂商：<input id="searchQvendorid"  class="easyui-combobox" name="vendorid" style="width:90px;height:30px;align-text:center"
								data-options="panelHeight:200,
								url:'${pageContext.request.contextPath}/alarm/getVendorids.do',
								valueField:'id',
								textField:'name',
								"/>
							标题：<input class="easyui-textbox" name="head"
							id="searchQsuname" style="width:90px;height:30px;border:false">
							级别：<select id="searchQseverity" class="easyui-combobox" name="severity" style="width:90px;height:30px;border:false">   
										<option value="-1">请选择</option> 
										<option value="0">警告</option> 
									    <option value="1">一般</option>   
									    <option value="2" >次要</option>   
									    <option value="3" >主要</option>   
									    <option value="4" >重要</option>   
								  </select>  
							类型：<select id="searchQeventype" class="easyui-combobox" name="eventype" style="width:90px;height:30px;border:false">   
										<option value="-1">请选择</option> 
									    <option value="alarm">故障</option>   
									    <option value="event" >事件</option>   
									    <option value="degradation" >裂化</option>   
									    <option value="notice" >通知</option>   
								  </select>   
							发生时间：<input class="easyui-datetimebox" name="occurtime"
							id="searchQoccurtime" style="width:145px;height:30px;border:false">
							到<input class="easyui-datetimebox" name="inserttime"
							id="searchQinserttime" style="width:145px;height:30px;border:false">
							<input name="resourcetypeid"
							id="searchQresourcetypeid" type="hidden" value="<%=request.getParameter("type")%>">
							</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton"  data-options="iconCls:'icon-search',plain:true" 
							onclick="searchDataGrid()">查询</a>&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo',plain:true" 
							onclick="$('#alarmqueryevent_searchform input').val('');$('#searchpname').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="querevent">
			<table title="" style="width:100%;" id="dg">
				<thead>
					<tr>
						<th data-options="field:'id',width:30,align:'center',hidden:'true'"></th>
						<th data-options="field:'resourcename',width:50,align:'center'">设备</th>
						<th data-options="field:'vendorid',width:20,align:'center'">厂家</th>
						<th data-options="field:'resourceip',width:40,align:'center'">IP</th>
						<th data-options="field:'occurtime',width:50,align:'center'">发生时间</th>
						<th data-options="field:'head',width:60,align:'center'">事件标题</th>
						<th data-options="field:'eventypename',width:60,align:'center'">事件类型</th>
						<th data-options="field:'severity',width:30,align:'center',formatter:querySeverityFormater">事件级别</th>
						<th data-options="field:'procause',width:80,align:'center'">可能原因</th>
						<th data-options="field:'content',width:20,align:'center',formatter:detailformater">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	
	<div id="window" class="easyui-window" title="事件详情" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:800px;height:460px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="alarmeventform" method="post" enctype="multipart/form-data" >
						<table align="center" style="width:100%">
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									设备：</td>
								<td class="FieldInput2"><input id="resourcename" name="resourcename" style="height:30px;" readonly /></td>
								<td class="FieldLabel2" style="border-top:!important;">
									厂家：</td>
								<td class="FieldInput2"><input id="vendorid" name="vendorid" style="height:30px;" readonly /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">
									主机名称：</td>
								<td class="FieldInput2"><input id="host" name="host" style="height:30px;" readonly /></td>
								<td class="FieldLabel2">
									主机IP：</td>
								<td class="FieldInput2"><input id="resourceip" name="hostip" style="height:30px;" readonly /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">
									发生时间：</td>
								<td class="FieldInput2"><input id="occurtime" name="occurtime" style="height:30px;" readonly /></td>
								<td class="FieldLabel2">
									事件标题：</td>
								<td class="FieldInput2"><input id="head" name="head" style="height:30px;" readonly /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">
									事件类型：</td>
								<td class="FieldInput2"><input id="eventypename" name="eventypename" style="height:30px;" readonly /></td>
								<td class="FieldLabel2">
									事件级别：</td>
								<td class="FieldInput2"><input id="severity" name="severity" style="height:30px;" readonly /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">
									影响用户：</td>
								<td class="FieldInput2"><input id="suname" name="suname" style="height:30px;" readonly /></td>
								<td class="FieldLabel2">
									设备类型：</td>
								<td class="FieldInput2"><input id="resourcetypename" name="resourcetypename" style="height:30px;" readonly /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">
									原始模块：</td>
								<td class="FieldInput2"><input id="facility" name="facility" style="height:30px;" readonly /></td>
								<td class="FieldLabel2">
									原始级别：</td>
								<td class="FieldInput2"><input id="orgseverity" name="orgseverity" style="height:30px;" readonly /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">
									采集协议：</td>
								<td class="FieldInput2"><input id="protocal" name="protocal" style="height:30px;" readonly /></td>
								<td class="FieldLabel2">
									告警次数：</td>
								<td class="FieldInput2"><input id="eventcount" name="eventcount" style="height:30px;" readonly />
								</td>
							</tr>
								<tr>
								<td class="FieldLabel2">
									入库时间：</td>
								<td class="FieldInput2"><input id="inserttime" name="inserttime" style="height:30px;" readonly />
								</td>
								<td class="FieldLabel2">
									确认人：</td>
								<td class="FieldInput2"><input id="ackby" name="ackby" style="height:30px;" readonly />
								</td>
							</tr>
							</tr>
							<tr>
								<td class="FieldLabel2">
									确认时间：</td>
								<td class="FieldInput2"><input id="acktime" name="acktime" style="height:30px;" readonly />
								</td>
								<td class="FieldLabel2">
									 </td>
								<td class="FieldInput2"> 
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2">
									事件内容：</td>
								<td class="FieldInput2"><textarea id="content" name="content" style=" height:60px;width:100%" readonly ></textarea>
								</td>
								<td class="FieldLabel2">
									 可能原因：</td>
								<td class="FieldInput2"><textarea id="procause" name="procause" style=" height:60px;width:100%" readonly ></textarea>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
</body>

