<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<%@ page language="java" import="com.inspur.icpmg.util.WebLevelUtil"%>
<%@ page language="java" import="com.inspur.icpmg.systemMg.vo.UserEntity"%>
<%
	String muser = null;
	UserEntity ue = WebLevelUtil.getUser(request);
	if(ue != null){
		if(ue.getAlias() != null){
			muser = ue.getAlias();
		}else{
			muser = ue.getEmail();
		}
	}
%>	
	
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
.a_t{
		
		width: 100%;
		height: 25px;
		margin:5px 0 auto;
	}
	.a_t_1{
		float:left;
		width: 14%;
		height: 25px;
	
	}
	.a_t_1 span{
		font-size:14px;
		float:right;
		height: 25px;
		line-height: 25px;
		padding-right: 20px;
	}
	.a_t_2{
		float:left;
		width: 36%;
		height: 25px;
	}
	.a_t_2 input{
		font-size:13px;
		width: 98%;
		margin: 0 auto;
		height: 25px;
		border: 0 silver;
		background: #fff;
	}
	.a_t_3{
		float:left;
		width: 86%;
		height: 25px;
	}
		.a_t_3 input{
		font-size:13px;
		width: 98%;
		margin: 0 auto;
		height: 25px;
		border: 0 silver;
		background: #fff;
	}
	.a_t_4{
		float:left;
		width: 14%;
		height: 25px;
	
	}
	.a_t_4 span{
		font-size:14px;
		float:right;
		height: 25px;
		line-height: 25px;
		padding-right: 20px;
	}
	.a_t_5{
		float:left;
		width: 86%;
		height: 25px;
	}
		.a_t_5 input{
		font-size:13px;
		margin: 2px 2px auto;
		height: 23px;
		line-height: 23px;
		background: #fff;
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
	   var muser = '<%=muser%>';
	   var flagck = 0;
	   var toolbarhistory = [
	       				{
	       				    id:'almexp',
	       				    disabled:false,
	       					text : '导出',
	       					iconCls : 'icon-almexport',
	       					handler : function() {
	       						var rows = $('#dg').datagrid('getChecked');
	    						var pids = "";
	    						 $.each(rows,function(index,object){
	    						 	pids+="'"+object.id+"',";
	    		   				 });
	       						exportHistoryExcel(pids);
	       					} 
	       				}         
	       		 ];
	       		function exportHistoryExcel(pids){
	       			
	       			$('#alarmhistory_searchform').form('submit',{
	       					url:'${pageContext.request.contextPath}/alarm/exportExcel.do',
	       					onSubmit: function(param){
								param.id = pids;
								param.clrStatus =  1 ;
							}
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
								toolbar : toolbarhistory,
								url : '${pageContext.request.contextPath}/alarm/queryEvent.do?almCategory=his',
								onCheck:doCheck,
								onUncheck:unDoCheck,
								onSelect:doCheck,
								onUnselect:unDoCheck,
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
													$('#histevent  input:checkbox').eq(idx+1).css("display","none");
													 
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
		
		
		function doCheck(rowIndex,rowData){
		  var rows  = $('#dg').datagrid('getSelections');
			if(rows.length==1)
			{
			$('#almclr').linkbutton('enable');
			$('#almack').linkbutton('enable');
			$('#almunack').linkbutton('enable');
		    $('#almtt').linkbutton('enable');
		
			}else if(rows.length>1){
			 $('#almclr').linkbutton('enable');
			 $('#almack').linkbutton('enable');
			 $('#almunack').linkbutton('enable');
		     $('#almtt').linkbutton('disable');
			}else{
			  			 $('#almclr').linkbutton('disable');
			 $('#almack').linkbutton('disable');
			 $('#almunack').linkbutton('disable');
		     $('#almtt').linkbutton('disable');
			}
			
		}
		
		function unDoCheck(rowIndex,rowData){
		    doCheck(rowIndex,rowData);
		}
			
		function searchHDataGrid() {
			$('#dg').datagrid('load',
				icp.serializeObject($('#alarmhistory_searchform')));
		};
		function historySeverityformater(value, row, index) {
				switch (value) {
							case 0:
								return "<div style=\"background-color:yellow;\">警告</div>";
							case 1:
								return "<div style=\"background-color:gray; \">一般</div>";
							case 2:
								return "<div style=\"background-color:orange; \">次要</div>";
								case 3:
							return "<div style=\"background-color:purple; \">主要</div>";
									case 4:
							return "<div style=\"background-color:red; \">严重</div>";
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
		function severityformater(value) {
				switch (value) {
							case "0":
								return "警告";
							case "1":
								return "一般";
							case "2":
								return "次要";
								case "3":
							return "主要";
									case "4":
							return "严重";
						}
		}
		
		function severityformater2(value) {
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
						return "严重";
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
				return "<a style=\"color:blue;cursor:pointer\" onclick=\"viewHisDetails('"+ row.id+"');\">详情</a>";
			}
				
		}
		function viewHisDetails(id){
			$('#window').window('close');
			//$('#alarmhiseventform').form('load','${pageContext.request.contextPath}/alarm/getEventDetail.do',queryParams:{});
			$.ajax({
		  		type : 'post',
		  		dataType:'json',
		  		url:'${pageContext.request.contextPath}/alarm/getEventDetail.do',
		  		data:{
		  			almCategory:'his',
		  			id:id},
		  		success:function(data){
		  	
		  			if(data.success)
			    	{
			    	
						for (var item in data.obj) {
						//	debugger;
							if($("#his"+item).length>0)
							{
								if(item=="orgseverity"){
									$("#his"+item).val(severityformater(data.obj[item]));
								}else	if(item=="severity"){
									$("#his"+item).val(severityformater2(data.obj[item]));
								}else if(item=="eventeffect")
								{
								$("#his"+item).val(effectformater(data.obj[item]));
								}else if(item=="eventfeature")
								{
								$("#his"+item).val(featureformater(data.obj[item]));
								}else if(item=="eventcategory")
								{
								$("#his"+item).val(categoryformater(data.obj[item]));
								}else
								{
									$("#his"+item).val(data.obj[item]);
								}
							}
						}
			    		$('#hiswindow').window('open');
			    	} 
		  		}
			  	});
		}
		
		function submitTicket(){
			$('#window4tt').window('close');
			$.messager.alert('消息',"派单成功!");
		}
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="background:#eee;height:30px;overflow:hidden;border:false">
			<form id="alarmhistory_searchform"  method ="post">
				<table >
					<tr>
						<td>设备：<input class="easyui-textbox" name="resourcename"
							id="searchHresourcename" style="width:90px;height:30px;border:false">
							<%-- 厂商：<input id="searchHvendorid"  class="easyui-combobox" name="vendorid" style="width:90px;height:30px;align-text:center"
								data-options="panelHeight:200,
								url:'${pageContext.request.contextPath}/alarm/getVendorids.do',
								valueField:'id',
								textField:'name',
								"/> --%>
								单位：<input id="searchHCompany"  class="easyui-combobox" name="searchCompany" style="width:190px;height:30px;align-text:center"
								data-options="panelHeight:100,
								url:'${pageContext.request.contextPath}/alarm/getCompany.do',
								valueField:'id',
								textField:'name',
								"/>
							标题：<input class="easyui-textbox" name="head"
							id="searchHsuname" style="width:90px;height:30px;border:false">
							级别：<select id="searchHseverity" class="easyui-combobox" name="severity" style="width:90px;height:30px;border:false">   
										<option value="-1">请选择</option> 
									    <option value="4" >重要</option>   
									    <option value="3" >主要</option>
									    <option value="2" >次要</option>   
									    <option value="1" >一般</option>  
									    <option value="0">警告</option>    
								  </select>  
							<!-- 类型：<select id="searchHeventype" class="easyui-combobox" name="eventype" style="width:90px;height:30px;border:false">   
										<option value="-1">请选择</option> 
									    <option value="alarm">故障</option>   
									    <option value="event" >事件</option>   
									    <option value="degradation" >裂化</option>   
									    <option value="notice" >通知</option>   
								  </select>   -->
							发生时间：<input class="easyui-datetimebox" name="occurtime"
							id="searchHoccurtime" style="width:145px;height:30px;border:false">
							到<input class="easyui-datetimebox" name="inserttime"
							id="searchHinserttime" style="width:145px;height:30px;border:false">
							<input name="resourcetypeid"
							id="searchHresourcetypeid" type="hidden" value="<%=request.getParameter("type")%>">
							</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" 
							onclick="searchHDataGrid()">查询</a>&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo',plain:true" 
							onclick="$('#alarmhistory_searchform input').val('');$('#searchpname').textbox('clear');$('#dg').datagrid('load',{});">重置</a><%-- &nbsp;&nbsp;<a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-almexport'"
							onclick="window.location.href='${pageContext.request.contextPath}/alarm/alarmDownload.do?almCategory=his'">导出</a> --%>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="histevent">
			<table title="" style="width:100%;" id="dg">
				<thead >
					<tr>
					    <th id="ckck" data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',width:1,align:'center',hidden:'true'"></th>
						<th data-options="field:'resourceid',width:40,align:'center'">设备</th>
						<th data-options="field:'vendorid',width:20,align:'center',hidden:'true'">厂家</th>
						<th data-options="field:'resourceip',width:40,align:'center'">IP</th>
						<th data-options="field:'occurtime',width:50,align:'center'">发生时间</th>
						<th data-options="field:'head',width:60,align:'center'">事件标题</th>
						<th data-options="field:'eventypename',width:60,align:'center'">事件类型</th>
						<th data-options="field:'severity',width:30,align:'center',formatter:historySeverityformater">事件级别</th>
						<th data-options="field:'clrby',width:30,align:'center'">清除人</th>
						<th data-options="field:'clrtime',width:50,align:'center'">清除时间</th>
						<th data-options="field:'content',width:20,align:'center',formatter:detailformater">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	

		
		
			<div id="hiswindow" class="easyui-window" title="事件详情" data-options="closed:true,cache : false,iconCls:'icon-save',modal: true" style="width:800px;height:410px;padding:5px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center',border:false" style="padding:5px;">
			<form id="alarmhiseventform" method="post" enctype="multipart/form-data" >
				<fieldset>
					<legend>基本信息</legend>
						<div class="a_t">
							<div class="a_t_1">
								<span>设备：</span>
							</div>
							<div class="a_t_2">
								<input id="hisresourceid" name="resourceid"  readonly />
							</div>
							<div class="a_t_1">
								<span>厂商：</span>
							</div>
							<div class="a_t_2">
								<input id="hisvendorid" name="vendorid"  readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>主机名称：</span>
							</div>
							<div class="a_t_2">
								<input  id="hishost" name="host" readonly />
							</div>
							<div class="a_t_1">
								<span>主机IP：</span>
							</div>
							<div class="a_t_2">
								<input id="hisresourceip" name="resourceip" readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>发生时间：</span>
							</div>
							<div class="a_t_2">
								<input id="hisoccurtime" name="occurtime"  readonly />
							</div>
							<div class="a_t_1">
								<span>事件标题：</span>
							</div>
							<div class="a_t_2">
								<input id="hishead" name="head" readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>事件类型：</span>
							</div>
							<div class="a_t_2">
								<input id="hiseventypename" name="eventypename" readonly />
							</div>
							<div class="a_t_1">
								<span>事件级别：</span>
							</div>
							<div class="a_t_2">
								<input id="hisseverity" name="severity" readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>影响用户：</span>
							</div>
							<div class="a_t_2">
								<input id="hissuname" name="suname" readonly />
							</div>
							<div class="a_t_1">
								<span>设备类型：</span>
							</div>
							<div class="a_t_2">
								<input  id="hisresourcetypename" name="resourcetypename"  readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>原始模块：</span>
							</div>
							<div class="a_t_2">
								<input id="hisfacility" name="facility" readonly />
							</div>
							<div class="a_t_1">
								<span>原始级别：</span>
							</div>
							<div class="a_t_2">
								<input  id="hisorgseverity" name="orgseverity" readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>采集协议：</span>
							</div>
							<div class="a_t_2">
								<input id="hisprotocal" name="protocal" readonly />
							</div>
							<div class="a_t_1">
								<span>告警次数：</span>
							</div>
							<div class="a_t_2">
								<input  id="hiseventcount" name="eventcount"  readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>入库时间：</span>
							</div>
							<div class="a_t_2">
								<input id="hisinserttime" name="inserttime" readonly />
							</div>
							<div class="a_t_1">
								<span>确认人：</span>
							</div>
							<div class="a_t_2">
								<input  id="ackby" name="ackby"  readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>确认时间：</span>
							</div>
							<div class="a_t_3">
								<input id="acktime" name="acktime"  readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>事件内容：</span>
							</div>
							<div class="a_t_3">
								<input id="hiscontent" name="content" readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>可能原因：</span>
							</div>
							<div class="a_t_3">
								<input id="hisprocause" name="procause" readonly />
							</div>
						</div>
				</fieldset>
			</form>
		</div>
	</div>
</div>
		
</body>

