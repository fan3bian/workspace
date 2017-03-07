<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/icp/include/taglib.jsp" %>
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
        border-color: #f0a73b;
    }
    
    .c-must {
        color: #f0a73b;
    }
</style>
<html>
	<script type="text/javascript" charset="utf-8">
		var flagck = 0;  //  初始化为0
		var url = '';
		var toolbar = [
		    {
				text:'增加',
				iconCls:'icon-add',
				handler:function(){
					$('#app_edit').dialog({
		                closed: false
		            });
					$('#app_edit').html(windowHtml2);
					 //所属单位
					$('#unitName').combobox({
						url:'${pageContext.request.contextPath}/alarm/getCompany.do',
						valueField: 'id',
						textField: 'name',
						required: true,
						onLoadSuccess: function () { //加载完成后,设置选中第一项
		                    var data = $('#unitName').combobox('getData');
		                    if (data.length > 0) {
		                    	$('#unitName').combobox('select', data[0].id);
		                    } 
		                } 
					});
					$('.j-required').validatebox({
	 	                required: true
	 	            });
					$('.j-normal').validatebox({
	 	                required: false
	 	            });
					url = '${ctx}/project/addApp.do';
				}
			},
			{
				text:'修改',
				iconCls:'icon-modify',
				handler:function(){
					var rows = $('#dg_app').datagrid('getChecked');
					if (rows.length != 1) {
						$.messager.alert('消息', '请选择一条记录！');
						return;
					}
					if (rows) {
						if(!verifyOper(rows[0].appname)){
					         $.messager.alert('警告',"该应用已被使用，不可再修改！","warning");
					         return;
					    }
		 				$('#app_edit').dialog({
			                closed: false
			            });
		 				$('#unitName').combobox({
							url:'${pageContext.request.contextPath}/alarm/getCompany.do',
							valueField: 'id',
							textField: 'name',
							required: true
						});
		 				$('.j-required').validatebox({
		 	                required: true
		 	            });
		 				$('.j-normal').validatebox({
		 	                required: false
		 	            });
		 				$('#appid').val(rows[0].appid);
		 				$('#appName').val(rows[0].appname);
		 				$('#appshort').val(rows[0].appshort);
		 				$('#appnote').val(rows[0].appnote);
		 				$("#unitName").combobox('setValue',rows[0].unitname);
		 				$('#unitName').combo('readonly', true);
		 				url='${ctx}/project/modifyApp.do';
					}
	 			}
				
			},
			{
				text:'删除',
				iconCls:'icon-delete',
				handler:function(){
					var rows = $('#dg_app').datagrid('getSelections');
	 				if(rows.length!=1){
	 					$.messager.alert('消息','请选择一条记录！','info');
	 					return;
	 				}
	 				var id = rows[0].appid;
	 				if(rows[0].appid){
	 					if(!verifyOper(rows[0].appname)){
					         $.messager.alert('警告',"该应用已被使用，不可删除！","warning");
					         return;
					    }
	 					$.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){
	 						if(r){
	 							$.ajax({
	 								type : 'post',
	 								url:'${ctx}/project/deleteApp.do',
	 								data:{appid:id},
	 								success:function(retr){
	 									var data = JSON.parse(retr);
	 									$.messager.alert('消息',data.msg);
	 									if(data.success)
	 									{
	 										$('#dg_app').datagrid('unselectAll');
	 										$('#dg_app').datagrid('load',{});
	 									}
	 								}
	 							});
	 						}
	 					});
	 				}
				}
				
			}
		];
		verifyOper = function(appname){
			var flag;
			$.ajax({
				type:'post',
				url:'${ctx}/project/verifyOper.do',
				data:{
			  		  appname:appname
			  		},
			  		async: false,
			  		success:function(data){
			  		   var data = JSON.parse(data);
			  		   flag = data.success;
			  		}
			});
			return flag;	
		}
		$(function(){
			$('#dg_app').datagrid({
				url:'${ctx}/project/appLists.do',
				pagination: true,
				pageSize: 10,
			    pageList: [10, 20, 30, 40, 50],
			    fitColumns: true,
			    singleSelect: false,
			    idField:'appid',
			    toolbar:toolbar,
			    nowarp:false,
				border:false,
				scrollbarSize:0,
				sortName:'ctime',
				sortOrder:'desc',
			    frozenColumns:[[ 
	       			{field:'ck',checkbox:true} 
	       		]],
	       		onLoadSuccess:function(data){
					var pageopt = $('#dg_app').datagrid('getPager').data("pagination").options;
					var  _pageSize = pageopt.pageSize;
					var  _rows = $('#dg_app').datagrid("getRows").length;
					var total = pageopt.total; //显示的查询的总数
					if (_pageSize >= 10) {
						for(i=10;i>_rows;i--){
							//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
							$(this).datagrid('appendRow', {appid:''  })
						}
						$('#dg_app').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
							if(val.appid==''){ 
								//addid为datagrid上一层的div id
								$('#addid  input:checkbox').eq(idx+1).css("display","none");
								 
							}
						}); 
			        }
				},
				//没数据的行不能被点击选中
				onClickRow: function (rowIndex, rowData) {
					if(rowData.appid==''){
						 $('#dg_app').datagrid('unselectRow', rowIndex);
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
							if(val.appid==''){
								//如果是空行，不能被选中
								$("#dg_app").datagrid('uncheckRow', idx);
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
	       		columns:[[
	       			{
	       				title:'应用编码',
	       				field:'appid',
	       				width:100,
	       				align:'center',
	       				hidden:true
	       			},
	       			{
	       				title:'应用名称',
	       				field:'appname',
	       				width:100,
	       				align:'center'
	       			},
	       			{
	       				title:'使用单位',
	       				field:'unitname',
	       				width:100,
	       				align:'center'
	       			},
	       			{
	       				title:'创建时间',
	       				field:'ctime',
	       				width:100,
	       				align:'center',
	       				sortable:true
	       			},
	       			{
	       				title:'创建人',
	       				field:'cuser',
	       				width:100,
	       				align:'center'
	       			}
	       		]],
			    
			});
		});
		//查询
		function searchFunc(){
		    $('#dg_app').datagrid('load',icp.serializeObject($('#searchForm')));
		}
		//重置
		function cleanSearchFun(){
			$('#searchForm input').val('');
			$('#appname').textbox('clear');
			$('#dg_app').datagrid('load',{});
		}
		function confirmBtn(){
			var appid = $("#appid").val();
			var appname = $("#appName").val();
			var appshort = $("#appshort").val();
			var appnote = $("#appnote").val(); 
			var unitid = $("#unitName").combobox('getValue');
			$.ajax({
					type : 'post',
					url:url,
					data:{unitid:unitid,appid:appid,appname:appname,appshort:appshort,appnote:appnote},
					success:function(retr){
						var data = JSON.parse(retr);
						$.messager.alert('消息',data.msg);
						if(data.success)
						{
							$('#dg_app').datagrid('unselectAll');
							$('#dg_app').datagrid('load',{});
						}
					}
				});
			
            $('#app_edit').window('close');
		}
		$(function() {
	        windowHtml2 = $('#app_edit').html();
	        $('#app_edit').dialog({
	            title: "应用编辑",
	            width: 515,
	            height: 310,
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
	                	var appnote = $("#appnote").val(); 
	                	if(appnote.length>200){
	                		$.messager.alert('消息','应用备注字数超出限制！','info');
	                		return;
	                	}
	                	if($('#appform').form('validate')){
	                		confirmBtn();
	                	}
	                }
	            }, {
	                text: '取消',
	                iconCls: 'icon-cancel',
	                handler: function() {
	                    $('#app_edit').dialog('close');
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
							应用名称:<input class="easyui-textbox"  id="appname" style="width: 200px;height: 30px; "  name="appname">
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
			<table id="dg_app" style="background:#eee;width:100%;"></table>
		</div>
	</div>
	<div id="app_edit" >
 		<form action="" id="appform">
	        <table width="100%" class="tc-table" >
	            <tbody>
	            	<tr>
	                    <td align="right">使用单位：</td>
	                    <td align="center">
	                    	<input id="unitName" name="unitname"  style="width: 230px;" >
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr>
	            	<tr>
	                    <td align="right">应用名称：</td>
	                    <td align="center">
	                    	<input id="appid" name="appid" type="hidden">
	                    	<input data-options="required:'ture',validType:['nameInput','maxLength[128]'],prompt:'应用名称',missingMessage:'应用名称必填'"  id="appName" name="appname" type="text" style="width: 220px;" class="input-normol j-required">
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr>
	                <tr>
	                    <td width="135px" align="right">应用简称：</td>
	                    <td width="250" align="center">
	                        <input data-options="required:'ture',validType:['englishOrNum','maxLength[20]'],prompt:'应用名称',missingMessage:'应用名称必填'"  id="appshort" name="appshort" type="text" style="width: 220px;" class="input-normol j-required">
	                    </td>
	                    <td width="110px"><span class="c-must">*</span></td>
	                </tr>
	                 <tr>
	                    <td width="135px" align="right">应用备注：<br><span style='color:#f00'>(少于200字)</span></td>
	                    <td width="250" align="center">
	                    	<textarea data-options="validType:'maxLength[200]',prompt:'不得超过200字'"  id="appnote" name="appnote" style="width:220px;height:100px;font-size:14px;" class="input-normol j-normal"></textarea>
	                    </td>
	                    <td width="110px"></td>
	                </tr>
	            </tbody>
	        </table>
 		</form>
    </div>
</html>