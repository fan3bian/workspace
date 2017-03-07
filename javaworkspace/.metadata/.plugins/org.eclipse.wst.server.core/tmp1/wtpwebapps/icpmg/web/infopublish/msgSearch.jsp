<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	width: 75%;
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
	width: 25%;
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
		var flagck = 0;  //  初始化为0
		$(document).ready(function() {
			loadDataGrid();
			loadDataGrid1();
		});
		//公告
		function loadDataGrid() {
			$('#dg').datagrid(
					{
						rownumbers : false,
						border : false,
						striped : true,
						scrollbarSize : 0,
						sortName : 'titleid',
						sortOrder : 'asc',
						singleSelect : true,
						method : 'post',
						loadMsg : '数据装载中......',
						fitColumns : true,
						pagination : true,
						pageSize : 10,
						pageList : [ 5, 10, 20, 30, 40, 50 ],
						url : '${pageContext.request.contextPath}/infopublish/messageList.do',
						onLoadSuccess: function (data) {
						      var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
						      var  _pageSize = pageopt.pageSize;
						      var  _rows = $('#dg').datagrid("getRows").length;
						      var total = pageopt.total; //显示的查询的总数
						      if (_pageSize >= 10) {
						         for(i=10;i>_rows;i--){
						            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
						            $('#dg').datagrid('appendRow', {titleid:''  })
						         }
						         $('#dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
							    	total: total,
							     });
						         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
						      }else{
						         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
						         $('#dg').closest('div.datagrid-wrap').find('div.datagrid-pager').show();
						      }
						    //设置不显示复选框
						      var rows = data.rows;
						      if (rows.length) {
									 $.each(rows, function (idx, val) {
										if(val.titleid==''){ 
											//addid为datagrid上一层的div id
											$('#addid  input:checkbox').eq(idx+1).css("display","none");
											 
										}
									}); 
						      }
						 } ,
						 //没数据的行不能被点击选中
						 onClickRow: function (rowIndex, rowData) {
								if(rowData.titleid==''){
									 $('#dg').datagrid('unselectRow', rowIndex);
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
									if(val.titleid==''){
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
				var beginTime1 = $('#stime1').datebox('getValue');
				var endTime1 = $('#etime1').datebox('getValue');
				var msg = compareTime(beginTime1, endTime1);
				if(msg != ""){
					$.messager.alert('提示', msg, 'info');
				}else{					
					$('#dg').datagrid('load',icp.serializeObject($('#message_searchform')));
				}
			}
			function operformater(value, row, index) {
			
				if(row.titleid){		
					return icp.formatString('<a style=\"color:blue;cursor:pointer\" onclick=\"viewDetail(\'{0}\',\'{1}\',\'{2}\',\'{3}\');\">查看</a>', row.title,row.content.replace(/[\r\n]/g,""),row.filepath,row.filename);
				}
			
				
			}
			var viewDetail = function(title,content,fileurl,filename) {//生成单页公告跳转
				
				document.getElementById("checkTitle").innerHTML='';
				document.getElementById("checkContent").innerHTML='';
				document.getElementById("filepath").innerHTML='';
				/* document.getElementById("checkCuser").innerHTML=cuser; */
				document.getElementById("checkTitle").innerHTML=title;
				document.getElementById("checkContent").innerHTML=content;
				if (fileurl && typeof(fileurl)!="undefined" && fileurl!=0){
					document.getElementById("filepath").innerHTML="附件信息  : "+"<a target='_blank' href=\""+'${pageContext.request.contextPath}' + fileurl + "\" >"+filename+"</a>";
				}
				
					$('#dlg').dialog("open",false); 
		
			};
			
			
		//站内消息
		 function loadDataGrid1() {
			$('#dgs').datagrid(
					{
						rownumbers : false,
						border : false,
						striped : true,
						scrollbarSize : 0,
						sortName : 'titleid',
						sortOrder : 'asc',
						singleSelect : true,
						method : 'post',
						loadMsg : '数据装载中......',
						fitColumns : true,
						pagination : true,
						pageSize : 10,
						pageList : [ 5, 10, 20, 30, 40, 50 ],
						url : '${pageContext.request.contextPath}/infopublish/messageLists.do',
						onLoadSuccess: function (data) {
						      var pageopt = $('#dgs').datagrid('getPager').data("pagination").options;
						      var  _pageSize = pageopt.pageSize;
						      var  _rows = $('#dgs').datagrid("getRows").length;
						      var total = pageopt.total; //显示的查询的总数
						      if (_pageSize >= 10) {
						         for(j=10;j>_rows;j--){
						            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
						            $('#dgs').datagrid('appendRow', {status:''  })
						         }
						         $('#dgs').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
							    	total: total,
							     });
						         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
						      }else{
						         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
						         $('#dgs').closest('div.datagrid-wrap').find('div.datagrid-pager').show();
						      }
						    //设置不显示复选框
						      var rows = data.rows;
						      if (rows.length) {
									 $.each(rows, function (idx, val) {
										if(val.status==''){ 
											//addid为datagrid上一层的div id
											$('#addids  input:checkbox').eq(idx+1).css("display","none");
											 
										}
									}); 
						      }
						 } ,
						 //没数据的行不能被点击选中
						 onClickRow: function (rowIndex, rowData) {
								if(rowData.status==''){
									 $('#dgs').datagrid('unselectRow', rowIndex);
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
									if(val.status==''){
										//如果是空行，不能被选中
										$("#dgs").datagrid('uncheckRow', idx);
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
			function searchDataGrid1() {
				var beginTime2 = $('#stime2').datebox('getValue');
				var endTime2 = $('#etime2').datebox('getValue');
				var msg = compareTime(beginTime2, endTime2);
				if(msg != ""){
					$.messager.alert('提示', msg, 'info');
				}else{
					$('#dgs').datagrid('load',icp.serializeObject($('#msg_searchform')));
				}
			}
			//弹框查看
			function operformaters(value, row, index) {
				if(row.titleid){					
					//return "<a style=\"color:blue;cursor:pointer\" onclick=\"viewDetails('"+ value+"','"+row.status+"');\">查看</a>";
					return icp.formatString('<a style=\"color:blue;cursor:pointer\" onclick=\"viewDetails(\'{0}\',\'{1}\',\'{2}\',\'{3}\');\">查看</a>', row.title,row.content,row.filepath,row.filename);
				}
			}
			
			function viewDetails(title,content,fileurl,filename){
				document.getElementById("checkTitle").innerHTML='';
				document.getElementById("checkContent").innerHTML='';
				document.getElementById("filepath").innerHTML='';
				
				document.getElementById("checkTitle").innerHTML=title;
				document.getElementById("checkContent").innerHTML=content;
				if (fileurl && typeof(fileurl)!="undefined" && fileurl!=0){
					document.getElementById("filepath").innerHTML="附件信息:"+"<a target='_blank' href=\""+'${pageContext.request.contextPath}' + fileurl + "\" >"+filename+"</a>";
				}
 				$('#dlg').dialog("open",false); 
			}
			//判断时间选择条件
			function compareTime(startDate, endDate) {
			    var startDateTemp = startDate.split("-");   
			    var endDateTemp = endDate.split("-");     
				  
				var allStartDate = new Date(startDateTemp[0], startDateTemp[1], startDateTemp[2]);   
				var allEndDate = new Date(endDateTemp[0], endDateTemp[1], endDateTemp[2]);   
				                   
				if (allStartDate.getTime() >= allEndDate.getTime()) {   
			        return "开始时间不能大于结束时间！";   
				}else{
					return "";
				}   
			}
	</script>
    	<div id="tt" class="easyui-tabs" style="height:auto;">
	        <div title="公告信息" style="padding:10px">
				<div data-options="region:'north',border:0"
					style="height:30px;overflow:hidden;">
					<form id="message_searchform">
						<table>
							<tr>
								<td>标题：
									<input class="easyui-textbox" name="title"
									id="searchtitle" style="width:100px;height:30px;border:0">
									创建时间：<input class="easyui-datebox" name="starttime"
									data-options = "panelWidth:160" id="stime1" style="width:160px;height:30px;border:0">
									到&nbsp;<input class="easyui-datebox" name="endtime"
									data-options = "panelWidth:160" id="etime1" style="width:160px;height:30px;border:0">
								</td>
								<td>&nbsp;&nbsp;<a href="javascript:void(0);"
									class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"
									onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
									href="javascript:void(0);" class="easyui-linkbutton"
									data-options="iconCls:'icon-redo',plain:true"
									onclick="$('#message_searchform input').val('');$('#searchtitle').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
								</td>
							</tr>
						</table>
					</form>	
				</div>
				<div data-options="region:'center',border:0" style="margin-top: 10px">
					<div data-options="region:'center',border:false" id="addid">
					<table title="" style="width:100%;" id="dg">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'titleid',width:30,align:'center',hidden:true"></th>
								<th data-options="field:'title',width:80,align:'left'">标题</th>
								<th data-options="field:'content',width:50,align:'center',hidden:true">内容</th>
								<th data-options="field:'filepath',width:50,align:'center',hidden:true">url</th>
								<th data-options="field:'sendrole',width:30,align:'center'">发布单位</th>
								<th data-options="field:'ctime',width:40,align:'center'">发布时间</th>
								<th data-options="field:'status',width:30,height:40,align:'center',formatter:operformater">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				</div>
	   	</div>
	    <div title="站内消息" style="padding:10px">
			<div data-options="region:'north',border:0"
				style="height:30px;overflow:hidden;">
				<form id="msg_searchform">
					<table>
						<tr>
							<td>标题：
								<input class="easyui-textbox" name="title"
								id="searchtitles" style="width:100px;height:30px;border:0">
								创建时间：<input class="easyui-datebox" name="starttime"
								data-options = "panelWidth:160" id="stime2" style="width:160px;height:30px;border:0">
								到&nbsp;<input class="easyui-datebox" name="endtime"
								data-options = "panelWidth:160" id="etime2" style="width:160px;height:30px;border:0">
							</td>
							<td>&nbsp;&nbsp;<a href="javascript:void(0);"
								class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"
								onclick="searchDataGrid1()">查询</a>&nbsp;&nbsp; <a
								href="javascript:void(0);" class="easyui-linkbutton"
								data-options="iconCls:'icon-redo',plain:true"
								onclick="$('#msg_searchform input').val('');$('#searchtitles').textbox('clear');$('#dgs').datagrid('load',{});">重置</a>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div data-options="region:'center',border:0" style="margin-top: 10px">
				<div  id="addids">
				<table title="" style="width:100%;" id="dgs">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'titleid',width:30,align:'center',hidden:true"></th>
							<th data-options="field:'title',width:80,align:'left'">标题</th>
							<th data-options="field:'content',width:50,align:'center',hidden:true">内容</th>
							<th data-options="field:'filepath',width:50,align:'center',hidden:true">url</th>
							<th data-options="field:'sendrole',width:30,align:'center'">发布单位</th>
							<th data-options="field:'ctime',width:40,align:'center'">发布时间</th>
							<th data-options="field:'status',width:30,align:'center',formatter:operformaters">操作</th>
						</tr>
					</thead>
				</table>
				</div>
			</div>
	    </div>
	</div>
	<!-- 弹窗 -->
	<div id="dlg" class="easyui-window" title="消息详情" data-options="modal:true,closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:380px;padding:5px;">
		
		<p class="divcss" id="checkTitle" style="color:#4074e1; font-weight:bold;  font-size:16px;margin-top: 16px;margin-bottom: 14px" align="center"></p>
		
		<div style="margin-top:35px;margin:0 auto;font-size:40px;  background:#f5f5f5;width:560px;height:230px;">
			<div id="checkContent" style="margin-top:10px;font-size:14px;text-indent:30px"></div>
			<div id="filepath" style="font-weight: bold;font-size:14px;margin-top: 30px"></div>
		</div>
		
		<div data-options="region:'',border:0" 
			style="text-align:center;margin-top:10px; padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
			 onclick="$('#dlg').window('close');" style="width:80px">关闭</a>
		</div>
		
	</div>	
</body>
