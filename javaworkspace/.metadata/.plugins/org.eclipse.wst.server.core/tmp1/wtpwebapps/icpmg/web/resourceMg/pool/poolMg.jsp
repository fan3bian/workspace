<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<style type="text/css">
    .detail-line{
      margin: 10px 25px;
    }
    .tc-table {
       
        margin-bottom: 10px;
    }
    
    .tc-table td {
        padding: 5px 0;
        line-height: 26px;
    }
    
    .input-normol {
        height: 26px;
        line-height: 26px;
        border: 1px solid #ccc;
        border-radius: 3px;
        padding: 0 5px;
    }
    
    .input-normol:focus {
        border-color: #f0a73b
    }
    
    .gxwl li {
        height: 26px;
        line-height: 26px;
        border: 1px solid #ccc;
        border-radius: 3px;
        text-align: center;
        width: 110px;
        display: inline-block;
        cursor: pointer;
    }
    
    .gxwl li.active {
        background: #f8b551;
        color: #fff;
        border-color: #f0a73b;
    }
    
    .c-must {
        color: #f0a73b;
    }
</style>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>资源池管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">


  </head>
  <script type="text/javascript">
  var url = '';
  var flagck = 0;  //  初始化为0
  var toolbar = [
 		{
 			text:'创建',
 			iconCls:'icon-add',
 			handler:function()
 			{
 				$('#pool_edit').dialog({
	                closed: false
	            });
 				$('#pool_edit').html(windowHtml2);
 				$('#platformPool').combobox({
	                url: '${ctx}/vmconfig/queryPlatform.do',
	                valueField: 'platformid',
	                textField: 'platformname',
	                required: true,
 				});
 	            $('.j-required').validatebox({
 	                required: true
 	            });
 	            $('.j-normal').validatebox({
	                required: false
	            });
 	            url='${ctx}/poolmg/createPool.do';
 			}
 		},
 		{
 			text:'修改',
 			iconCls:'icon-modify',
 			handler:function(){
 				var rows = $('#dg_pool').datagrid('getChecked');
				if (rows.length != 1) {
					$.messager.alert('消息', '请选择一条记录！');
					return;
				}
				if (rows) {
	 				$('#pool_edit').dialog({
		                closed: false
		            });
	 				$('#platformPool').combobox({
		                url:'${ctx}/vmconfig/queryPlatform.do',
		                valueField: 'platformid',
		                textField: 'platformname',
		                required: true,
	 				});
	 				
	 				$("#poolid").val(rows[0].poolid);
	 				$("#poolNameCopy").val(rows[0].poolname);
	 				$("#displayname").val(rows[0].displayname);
	 				$("#description").val(rows[0].description);
	 				$("#platformPool").combobox('setValue',rows[0].platformname);
	 				$('#platformPool').combo('readonly', true);
	 				$('.j-required').validatebox({
	 	                required: true
	 	            });
	 				$('.j-normal').validatebox({
	 	                required: false
	 	            });
	 				url='${ctx}/poolmg/updatePool.do';
				}
 			}
 		},
 		{
 			text:'删除',
 			iconCls:'icon-delete',
 			handler:function()
 			{
 				var rows = $('#dg_pool').datagrid('getSelections');
 				if(rows.length!=1){
 					$.messager.alert('消息','请选择一条记录！','info');
 					return;
 				}
 				var id = rows[0].poolid;
 				if(rows[0].poolid){					
 					$.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){
 						if(r){
 							$.ajax({
 								type : 'post',
 								url:'${ctx}/poolmg/dropPool.do',
 								data:{poolid:id},
 								success:function(retr){
 									var data = JSON.parse(retr);
 									$.messager.alert('消息',data.msg);
 									if(data.success)
 									{
 										$('#dg_pool').datagrid('unselectAll');
 										//$('#dg_pool').datagrid('reload');
 										$('#dg_pool').datagrid('load',{});
 									}
 								}
 							});
 						}
 					});
 				}
 			}
 		}
 		];
 		$(function(){
 			$('#dg_pool').datagrid({
 				url:'${ctx}/poolmg/getPoolLists.do',
 				pagination:true,
 				pageSize:10,
 				pageList:[5,10,20,30,40,50],
 				fitColumns:true,
 				nowarp:false,
 				border:false,
 				scrollbarSize:0,
 				idField:'poolid',
 				sortOrder:'desc',
 				singleSelect:true,
 				toolbar:toolbar,
 				onLoadSuccess:function(data){
 					var pageopt = $('#dg_pool').datagrid('getPager').data("pagination").options;
 					var  _pageSize = pageopt.pageSize;
 					var  _rows = $('#dg_pool').datagrid("getRows").length;
 					var total = pageopt.total; //显示的查询的总数
 					if (_pageSize >= 10) {
 						for(i=10;i>_rows;i--){
 							//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
 							$(this).datagrid('appendRow', {poolid:''  })
 						}
 						$('#dg_pool').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
 					    	total: total,
 					     });
 					}else{
 						//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
 						$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
 					}
 					//设置不显示复选框
 			        var rows = data.rows;
 			        if (rows.length) {
 						 $.each(rows, function (idx, val) {
 							if(val.poolid==''){ 
 								//addid为datagrid上一层的div id
 								$('#addid  input:checkbox').eq(idx+1).css("display","none");
 								 
 							}
 						}); 
 			        }
 				},
 				//没数据的行不能被点击选中
 				onClickRow: function (rowIndex, rowData) {
 					if(rowData.poolid==''){
 						 $('#dg_pool').datagrid('unselectRow', rowIndex);
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
 							if(val.poolid==''){
 								//如果是空行，不能被选中
 								$("#dg_pool").datagrid('uncheckRow', idx);
 								//增加全选复选框被选中
 								$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");	
 							}
 						});
 				},
 				 //取消全选
 				onUncheckAll: function(rows) {
 					//取消全选时，标志位变为0
 					flagck = 0;
 				},
 				frozenColumns:[[ 
 	    			{field:'ck',checkbox:true} 
 	    		]],
 	    		columns:[[
 	    			{
 	    				title:'资源池编码',
 	    				field:'poolid',
 	    				width:100,
 	    				align:'center',
 	    			},
 	    			{
 	    				title:'资源池',
 	    				field:'poolname',
 	    				width:100,
 	    				align:'center',
 	    				hidden:'true',
 	    			},
 	    			{
 	    				title:'资源池名称',
 	    				field:'displayname',
 	    				width:100,
 	    				align:'center',
 	    			},
 	    			{
 	    				title:'平台名称',
 	    				field:'platformname',
 	    				width:100,
 	    				align:'center',
 	    			},
 	    			{
 	    				title:'创建时间',
 	    				field:'ctime',
 	    				width:100,
 	    				align:'center',
 	    			},
 	    			{
 	    				title:'创建人',
 	    				field:'cuserid',
 	    				width:100,
 	    				align:'center',
 	    			}
 	    			
 	
 	    			
 	    		]],
 			});
 		});
 		//查询
		function searchFunc(){
		    $('#dg_pool').datagrid('load',icp.serializeObject($('#searchForm')));
		}
		//重置
		function cleanSearchFun(){
			$('#searchForm').form('reset');
			$('#dg_pool').datagrid('load',{});
		}
		
		function confirmBtn(){
			var poolid = $("#poolid").val();
			var poolname = $("#poolNameCopy").val();
			var displayname = $("#displayname").val();
			var platformname = $("#platformPool").combobox('getValue');
			var description = $("#description").val(); 
			$.ajax({
					type : 'post',
					url:url,
					data:{poolid:poolid,poolname:poolname,displayname:displayname,
						platformname:platformname,description:description},
					success:function(retr){
						var data = JSON.parse(retr);
						$.messager.alert('消息',data.msg);
						if(data.success)
						{
							$('#dg_pool').datagrid('unselectAll');
							//$('#dg_pool').datagrid('reload');
							$('#dg_pool').datagrid('load',{});
						}
					}
				});
			
            $('#pool_edit').window('close');
		}

		$(function() {
			$(document).on('click', '#networktypename li', function(event) {
	            $(this).addClass('active').siblings().removeClass('active');
	            
	        });
	        windowHtml2 = $('#pool_edit').html();
	        $('#pool_edit').dialog({
	            title: "资源池编辑",
	            width: 515,
	            height: 330,
	            closed: true,
	            modal: true,
	            collapsible: false,
	            minimizable: false,
	            maximizable: false,
	            resizable: false,
	            buttons: [{
	                text: '确定',
	                iconCls: 'icon-ok',
	                handler: function() {
	                	if($('#poolform').form('validate')){
	                		confirmBtn();
	                	}
	                }
	            }, {
	                text: '取消',
	                iconCls: 'icon-cancel',
	                handler: function() {
	                    $('#pool_edit').dialog('close');
	                }
	            }]
	        });
	    })
  </script>
  <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
			<form method="post" id="searchForm">
				<table>
					<tr>
						<td style="margin-left: 10px">
							资源池名称:<input class="easyui-textbox"  id="poolname" style="width: 200px;height: 30px; "  name="poolname">
						</td>
					 
						<td style="float:right">&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFunc()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="cleanSearchFun()">重置</a>&nbsp;&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>

		<div data-options="region:'center',border:false" style="background:#eee;margin-top: 15px" id="addid">
			<table id="dg_pool" style="background:#eee;width:100%;"></table>
		</div>
	</div>
	<div id="pool_edit" >
 		<form action="" id="poolform">
	        <table width="100%" class="tc-table" >
	            <tbody>
	            	<tr>
	                    <td align="right">平台：</td>
	                    <td align="center">
	                    	<input id="poolid" name="poolid" type="hidden">
	                        <input id="platformPool" name="platformname" style="width: 230px;">
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr>
	                <tr>
	                    <td width="135px" align="right">资源池：</td>
	                    <td width="250" align="center">
	                        <input data-options="required:'ture',validType:['nameInput','maxLength[64]']"  id="poolNameCopy" name="poolname" type="text" style="width: 220px;" class="input-normol j-required">
	                    </td>
	                    <td width="110px"><span class="c-must">*</span></td>
	                </tr>
	                <tr>
	                    <td width="135px" align="right">显示名称：</td>
	                    <td width="250" align="center">
	                        <input data-options="required:'ture',validType:['nameInput','maxLength[64]']" id="displayname" name="displayname" type="text" style="width: 220px;" class="input-normol j-required">
	                    </td>
	                    <td width="110px"><span class="c-must">*</span></td>
	                </tr>
	               <!-- <tr>
	                    <td align="right">区域：</td>
	                    <td align="center">
	                        <ul class="gxwl" id="networktypename" name="networktypename">
	                            <li class="active" value="10001">政务外网</li>
	                            <li value="10002">互联网</li>
	                        </ul>
	                    </td>
	                    <td><span class="c-must">*</span></td>
                	</tr> -->
	                

	            </tbody>
	        </table>
	        <p style="margin-top: 10px;border-top: 1px solid #ccc; margin-bottom: 10px;"></p>
	        <table width="100%" class="tc-table">
	            <tbody>
	                <tr>
	                    <td width="135px" align="right">备注：<br><span style='color:#f00'>(少于200字)</span></td>
	                    <td width="250" align="center">
	                        <textarea data-options="validType:'maxLength[200]',prompt:'不得超过200字'"  id="description" name="description" style="width:220px;height:100px;font-size:14px;" class="input-normol j-normal"></textarea>
	                    </td>
	                    <td width="110px"></td>
	                </tr>
	            </tbody>
	        </table>
 		</form>
    </div>
</html>
