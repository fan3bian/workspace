<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    
    <title>资源变更</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  
</head>
  
<body>
 <style>.lcy-body .panel-body{ background: #eee; }</style>
    <link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" />
    <div id="orderWrap" style="width: 100%; height: 100%">
        <div class="easyui-layout lcy-body" data-options="fit:true,border:false" >
            <div data-options="region:'north',border:false" style="height: 43px;padding-top: 4px;">
                <!-- 搜索开始 -->
                <form id="resourcechange_searchform">
                    <div style="margin: -1px 20px;">
                        <table class="lcy-search">
                            <tr>
                                <td>变更单号：
                                    <input class="easyui-textbox" name="updateOrderId" id="updateOrderId">
                                </td>
                                <td>项目名称：
                                    <input class="easyui-textbox" name="proName" id="proName" style="width:150px">
                                </td>
                                <td>发起时间范围：
                                    <input class="easyui-datetimebox" name="startTime" id="startTime" style="width:150px"> --
                                    <input class="easyui-datetimebox" name="endTime" id="endTime" style="width:150px">
                                </td>
                                <td align="center" colspan="1">
                                    <a href="javascript:void(0);" id="search" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a>&nbsp;&nbsp;
                                    <a href="javascript:void(0);" id="formReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">重置</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </form>
            </div>
            
            <div data-options="region:'center',border:false" id="addid">
                <div style="margin: 0 20px 40px 20px;">
                   <!-- 列表数据 -->
                    <table id="updateOrder_dg" width="100%" data-options="fitColumns:true">
                        <thead>
                            <tr>
                                <th data-options="field:'ck',checkbox:true"></th>
                                <th data-options="field:'updateorderid',width:8,align:'center',sortable:true">变更单号</th>
                                <th data-options="field:'proname',width:8,align:'center'">项目名称</th>
                                <th data-options="field:'uname',width:4,align:'center'">发起人</th>
                                <th data-options="field:'unitname',width:8,align:'center'">发起单位</th>
                                <th data-options="field:'useunitname',width:10,align:'center'">使用单位</th>
                                <th data-options="field:'otime',width:10,align:'center'">发起时间</th>
                                <th data-options="field:'ostatusname',width:5,align:'center'">状态</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
            
        </div>
    </div>
    <script type="text/javascript">
    	var flagck = 0;  //  初始化为0
	    $(document).ready(function() { 
	        var severType = [{
	            id: 'COMPUTE',
	            text: '计算'
	        }, {
	            id: 'STORAGE',
	            text: '存储'
	        }, {
	            id: 'DB',
	            text: '数据库'
	        }, {
	            id: 'DR',
	            text: '容灾'
	        }];
	
	        $('#projectName').combobox({
	            data: severType,
	            valueField: 'id',
	            textField: 'text',
	            panelHeight: '100'
	        });
			
	        //查询
	        $("#search").click(function() {
	        	searchCondition();
	        });
	        
			//重置
	        $("#formReset").click(function() {
	            $("#resourcechange_searchform").form("reset");
	            searchCondition();
	        });
			
			//条件查询
	        function searchCondition() {
	    		$('#updateOrder_dg').datagrid('load', icp.serializeObject($('#resourcechange_searchform')));
	    	}
    
			//列表数据
            $('#updateOrder_dg').datagrid({
                rownumbers: false,
                checkOnSelect: true,
                selectOnCheck: true,
                scrollbarSize: 0,
                border: false,
                striped: true,
                sortName: 'orderid',
                sortOrder: 'asc',
                nowarp: false,
                singleSelect: false,
                method: 'post',
                loadMsg: '数据装载中......',
                fitColumns: true,
                idField: 'updateorderid',
                pagination: true,
                pageSize: 10,
                pageList: [10, 20, 30, 40, 50],
                url: '<%=basePath%>/resourcechange/findUpdateOrderList.do',
                toolbar: [{
                    id: 'btnadd',
                    text: '发起变更',
                    iconCls: 'icon-add',
                    handler: function() {
                        $('#btnsave').linkbutton('enable');
                        $('#orderWrap').attr("class", "");
                        
                         $('#orderWrap').panel({
                           href: "<%=basePath%>/web/resourceChange/resourceChangeApplyList.jsp?i="+Math.random(),
                        }); 
                        
                    }
                },
                
                {
                    id: 'bgdxq',
                    text: '变更单详情',
                    iconCls: 'icon-showdetail',
                    handler: function() {
                        var rows = $('#updateOrder_dg').datagrid('getChecked');
        				if (rows.length != 1) {
        					$.messager.alert('消息', '请选择一条记录！','info');
        					return;
        				}
        				
                        $('#btnprint').linkbutton('enable');
                        $('#orderWrap').attr("class", "");
                        $('#orderWrap').panel({
                            href: "<%=basePath%>/web/resourceChange/resourceChangeDetail.jsp?flowid="+rows[0].flowid+"&updateorderid="+rows[0].updateorderid+
                            		"&department="+encodeURI(encodeURI(rows[0].unitname))+
                        		"&proname="+encodeURI(encodeURI(rows[0].proname))+"&uname="+ encodeURI(encodeURI(rows[0].uname))+
                        		"&otime="+rows[0].otime+"&useunitname="+encodeURI(encodeURI(rows[0].useunitname))
                        });
                    }
                }, {
                    id: 'btnprint',
                    text: '打印',
                    iconCls: 'icon-print',
                    handler: function() {
                    	var rows = $('#updateOrder_dg').datagrid('getChecked');
        				if (rows.length != 1) {
        					$.messager.alert('消息', '请选择一条记录打印！','info');
        					return;
        				}
        				
                        $('#btnprint').linkbutton('enable');
                        $('#orderWrap').attr("class", "");
                        window.open("<%=basePath%>web/resourceChange/resourceChangePrint.jsp?flowid="+rows[0].flowid+
                        		"&updateorderid="+rows[0].updateorderid
                        		+"&uname="+encodeURI(encodeURI(rows[0].uname))+"&useunitname="+encodeURI(encodeURI(rows[0].useunitname))+
                        		"&snote="+encodeURI(encodeURI(rows[0].snote))
                        		+"&userid="+rows[0].userid+"&usertel="+rows[0].usertel );                       
                    }
                },{
                    id: 'btnchangeback',
                    text: '撤销',
                    iconCls: 'icon-redo',
                    handler: function() {
                    	var rows = $('#updateOrder_dg').datagrid('getChecked');
        				if (rows.length != 1) {
        					$.messager.alert('消息', '请选择一条记录进行撤销！','info');
        					return;
        				}else{
        					//判断是否可进行撤销操作
        					$.ajax({
        						url:"${pageContext.request.contextPath}/resourcechange/isShenpi.do?updateorderid="+rows[0].updateorderid,
        						data:{},
        						method:"post",
        						cache: false,
        						type:"json",
        						success:function(data){
        							if(data == 1){
        								$.messager.alert('消息', '该申请不能进行撤销操作！','info');
        	        					return;
        							}else{
        								$.messager.confirm('请确认','撤销后不可恢复，您确定要进行撤销吗?',function(b){
        									if(b){//确定撤销
        										$.ajax({
        											url:"${pageContext.request.contextPath}/resourcechange/cancleChangeOrder.do?updateorderid="+rows[0].updateorderid,
        											data:{},
        											method:"post",
        											cache:false,
        											type:"json",
        											success:function(data){
        												if(data == 1){
        													$.messager.alert('消息', '撤销成功！','info');
        													searchCondition();
        												}else if(data == 0){
        													$.messager.alert('消息', '撤销失败，请重新操作！','info');
        												}else {
        													$.messager.alert('消息', '操作失败，请重新操作！','info');
        												}
        											}
        										});
        									}
        								});
        							}
        						}
        					});
        				}
                    }
                }],
              onLoadSuccess: function (data) {
            	    var pageopt = $('#updateOrder_dg').datagrid('getPager').data("pagination").options;
					var  _pageSize = pageopt.pageSize;
					var  _rows = $('#updateOrder_dg').datagrid("getRows").length;
					var total = pageopt.total; //显示的查询的总数
					if (_pageSize >= 10) {
						for(i=10;i>_rows;i--){
							//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
							$(this).datagrid('appendRow', {orderid:''  })
						}
						$('#updateOrder_dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
							if(val.orderid==''){ 
								//addid为datagrid上一层的div id
								$('#addid  input:checkbox').eq(idx+1).css("display","none");
								 
							}
						}); 
			        }
            	  //2016-06-02 add
            	  $('.j-variation').linkbutton({
	                    iconCls: 'icon-variation',
	                    plain: true
	                });
	                $('.j-cancellation').linkbutton({
	                    iconCls: 'icon-cancellation',
	                    plain: true
	                });
		 	  },
		 	//没数据的行不能被点击选中
				onClickRow: function (rowIndex, rowData) {
					if(rowData.orderid==''){
						 $('#updateOrder_dg').datagrid('unselectRow', rowIndex);
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
							if(val.orderid==''){
								//如果是空行，不能被选中
								$("#updateOrder_dg").datagrid('uncheckRow', idx);
								//增加全选复选框被选中
								$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");	
							}
						});
				},
				 //取消全选
				onUncheckAll: function(rows) {
					//取消全选时，标志位变为0
					flagck = 0;
				}
           })
    })
    
    </script>
  </body>
</html>
