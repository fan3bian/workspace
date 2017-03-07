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

.FieldLabel1 {
	width: 172px;
	height: 25px;
	background-color: #ccc;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #CCC 1px dotted !important;
	 
}

.FieldLabel2 {
	width: 402px;
	height: 25px;
	background-color: #ccc;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #CCC 1px dotted !important;
	 
}

.FieldInput {
	width: 172px;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #CCC 1px dotted !important;
}

.FieldLabel3 {
	width: 172px;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #CCC 1px dotted !important;
}

.FieldLabel4 {
	width: 402px;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #CCC 1px dotted !important;
}


</style>
	<script type="text/javascript">
	
		var flagck = 0;
		
		$(document).ready(function() {			
			loadDataGrid();
		});
				
		function loadDataGrid() {
			$('#scoreItem')
					.datagrid(
							{
								rownumbers : false,
								checkOnSelect:true,
								selectOnCheck:true,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'createtime',
								sortOrder : 'desc',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								//idField : 'pid',
								pagination : true,
								pageSize : 10,
								pageNumber:1,
								pageList : [ 5, 10, 20, 30, 40, 50 ],								
								url : '${pageContext.request.contextPath}/scoreinfoMg/scoreList.do',
								onLoadSuccess: function (data) {
					   	debugger;
					      var pageopt = $('#scoreItem').datagrid('getPager').data("pagination").options;
					      var  _pageSize = pageopt.pageSize;
					      var  _rows = $('#scoreItem').datagrid("getRows").length;
					      var total = pageopt.total; //显示的查询的总数 
					      if (_pageSize >= 10) {
					         for(i=10;i>_rows;i--){
					            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
					            $(this).datagrid('appendRow', {operation:''  })
					         }
					          $('#scoreItem').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
						    	total: total,
						     });
					         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
					      }else{
					         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
					         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					      }
					      
					      var rows = data.rows;
									      if (rows.length) {
												 $.each(rows, function (idx, val) {
													if   (val.operation==''){  
														$('#scoreid  input:checkbox').eq(idx+1).css("display","none");
														 
													}
												}); 
									      }
					      					    					      
					},
					 //没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.operation==''){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
					$('#scoreid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck = 1;
							$.each(rows, function (idx, val) {
								if (val.operation==''){
									$("#scoreItem").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('#scoreid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
								}
							});
					},
									
					onUncheckAll: function(rows) {
						flagck = 0;
					}  
					
					
					
					});

			}
			
			function searchDataGrid() {
			$('#scoreItem').datagrid('load',
					icp.serializeObject($('#score_searchform')));
			};
			function isvalidformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:green\">已提交</span>";
							case "0":
								return "<span style=\"color:red\">未提交</span>";
							}
			}
			
			function operformater(value, row, index) {
				var _neid = row['id'];
				if(_neid)
				{
					return "<a style=\"color:blue;cursor:pointer\" onclick=\"viewDetails('"+ _neid+"','"+index+"');\">明细</a>";
				}
			} 
			
			function viewDetails(id,status)
			{				
				var rows = $('#scoreItem').datagrid('getSelected');
				
				var value1 = rows.scorevalue1;
				
				var value2 = rows.scorevalue2;
				var value3 = rows.scorevalue3;
				var value4 = rows.scorevalue4;
				var value5 = rows.scorevalue5;
				var value6 = rows.scorevalue6;
				var value7 = rows.scorevalue7;
				var value8 = rows.scorevalue8;
				var value9 = rows.scorevalue9;
				var value10 = rows.scorevalue10;
				var value11 = rows.scorevalue11;
				var value12 = rows.scorevalue12;
				var value13 = rows.scorevalue13;
				var value14 = rows.scorevalue14;
				var value15 = rows.scorevalue15;
				var scorevalue = rows.score;
				
				
				document.getElementById("scorevalue1").innerHTML=value1;
				document.getElementById("scorevalue2").innerHTML=value2;
				document.getElementById("scorevalue3").innerHTML=value3;
				document.getElementById("scorevalue4").innerHTML=value4;
				document.getElementById("scorevalue5").innerHTML=value5;
				
				document.getElementById("scorevalue6").innerHTML=value6;
				document.getElementById("scorevalue7").innerHTML=value7;
				document.getElementById("scorevalue8").innerHTML=value8;
				document.getElementById("scorevalue9").innerHTML=value9;
				document.getElementById("scorevalue10").innerHTML=value10;
				
				document.getElementById("scorevalue11").innerHTML=value11;
				document.getElementById("scorevalue12").innerHTML=value12;
				document.getElementById("scorevalue13").innerHTML=value13;
				document.getElementById("scorevalue14").innerHTML=value14;
				document.getElementById("scorevalue15").innerHTML=value15;
				
				document.getElementById("score").innerHTML=scorevalue;
														
				$('#window').window('open');
			}
			
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"	style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"	style="background:#eee;height:40px;overflow:hidden;">
			<form id="score_searchform">
				<table>
					<tr>
						<td>评分年度：<input class="easyui-textbox" name="scoreyear"
							id="searchusername" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo',plain:true"
							onclick="$('#score_searchform input').val('');$('#searchusername').textbox('clear');$('#scoreItem').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="scoreid">
			<table title="" style="width:100%;" id="scoreItem">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'userunitname',width:60,align:'center'">评分用户名称</th>
						<th data-options="field:'scoreyear',width:60,align:'center'">评分年度</th>
						<th data-options="field:'score',width:60,align:'center'">总分</th>
						<th data-options="field:'scorevalue1',width:60,align:'center',hidden:'true'">评分项一</th>
						<th data-options="field:'scorevalue2',width:60,align:'center',hidden:'true'">评分项二</th>
						<th data-options="field:'scorevalue3',width:60,align:'center',hidden:'true'">评分项三</th>
						<th data-options="field:'scorevalue4',width:60,align:'center',hidden:'true'">评分项四</th>
						<th data-options="field:'scorevalue5',width:60,align:'center',hidden:'true'">评分项五</th>
						<th data-options="field:'scorevalue6',width:60,align:'center',hidden:'true'">评分项六</th>
						<th data-options="field:'scorevalue7',width:60,align:'center',hidden:'true'">评分项七</th>
						<th data-options="field:'scorevalue8',width:60,align:'center',hidden:'true'">评分项八</th>
						<th data-options="field:'scorevalue9',width:60,align:'center',hidden:'true'">评分项九</th>
						<th data-options="field:'scorevalue10',width:60,align:'center',hidden:'true'">评分项十</th>
						<th data-options="field:'scorevalue11',width:60,align:'center',hidden:'true'">评分项十一</th>
						<th data-options="field:'scorevalue12',width:60,align:'center',hidden:'true'">评分项十二</th>
						<th data-options="field:'scorevalue13',width:60,align:'center',hidden:'true'">评分项十三</th>
						<th data-options="field:'scorevalue14',width:60,align:'center',hidden:'true'">评分项十四</th>
						<th data-options="field:'scorevalue15',width:60,align:'center',hidden:'true'">评分项十五</th>
						<th data-options="field:'createtime',width:60,align:'center'">评分时间</th>						
						<th data-options="field:'status',width:60,align:'center',formatter:isvalidformater">状态</th>	
						<th data-options="field:'operation',width:60,align:'center',formatter:operformater">操作</th>					
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div id="window" class="easyui-window" title="评分明细" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:750px;height:510px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
						
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<table title="" style="width:100%;" id="details">
					
					<tr>
						<td class="FieldLabel1" >类别</td>
						<td class="FieldLabel2" >指标及描述</td>
						
						<td class="FieldLabel1">得分</td>
					</tr>
						
					<tr>
						<td class="FieldLabel3" >总体满意度(10)</td>
						<td class="FieldLabel4" >对电子政务云服务使用的总体满意度。</td>
						
						<td class="FieldLabel3"><div id="scorevalue1"></div></td>		
					</tr>
					
					<tr>
						<td class="FieldLabel3" rowspan="8">服务质量感知(40)</td>
						<td class="FieldLabel4"  >电子政务云服务是否满足了日常政务工作的需求。</td>
						
						<td class="FieldLabel3"><div id="scorevalue2"/></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >电子政务云服务是否节约了工作时间（和非云服务时期比较）</td>
						
						<td class="FieldLabel3"><div id="scorevalue3" /></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >电子政务云服务系统的稳定性。</td>
						
						<td class="FieldLabel3"><div id="scorevalue4" /></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >电子政务云服务系统网络连接以及系统相应的速度。</td>
						
						<td class="FieldLabel3"><div id="scorevalue5"/></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >网络是否频繁终端，中断后是否及时恢复。</td>
						
						<td class="FieldLabel3"><div id="scorevalue6"/></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >电子政务云服务系统是否易用，操作是否便捷。</td>
						
						<td class="FieldLabel3"><div id="scorevalue7"/></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >服务人员的服务态度是否用友好</td>
						
						<td class="FieldLabel3"><div id="scorevalue8"/></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >服务的专业性、规范性和解决问题的能力</td>
						
						<td class="FieldLabel3"><div id="scorevalue9"/></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel3" rowspan="3">安全感知(30)</td>
						<td class="FieldLabel4"  >对云服务系统安全性的感知。</td>
						
						<td class="FieldLabel3"><div id="scorevalue10"/></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >对云服务系统中数据安全的感知。</td>
						
						<td class="FieldLabel3"><div id="scorevalue11"/></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >对云服务系统中系统权限保护的感知。</td>
						
						<td class="FieldLabel3"><div id="scorevalue12"/></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel3" rowspan="3">抱怨和投诉(20)</td>
						<td class="FieldLabel4"  >对电子政务云服务系统的抱怨。</td>
						
						<td class="FieldLabel3"><div id="scorevalue13"/></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >对电子政务云服务的投诉是否频繁</td>
						
						<td class="FieldLabel3"><div id="scorevalue14"/></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel4"  >是否愿意继续使用该电子政务云服务</td>
						
						<td class="FieldLabel3"><div id="scorevalue15"/></div></td>			
					</tr>
					
					<tr>
						<td class="FieldLabel3" >总分(100)</td>
						
						<td class="FieldLabel4" ></td>
						<td class="FieldLabel3"><div id="score"/></div></td>		
					</tr>	
									
					</table>
				</div>				
			</div>
		</div>			
</body>

