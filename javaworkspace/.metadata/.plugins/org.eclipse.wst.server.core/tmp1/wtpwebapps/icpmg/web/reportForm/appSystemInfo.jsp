<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>应用统计</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  
  </head>
  
  <body>
 <style>.lcy-body .panel-body{ background: #eee; }
 #addtoolbar{
	margin-left: 85%;
	width: 15%;
	vertical-align: middle;
	}

  
 
 </style>
    <div style="width: 100%; height: 100%">
        <div class="easyui-layout lcy-body" data-options="fit:true,border:false" >
            <div data-options="region:'north',border:false" style="height: 55px;">
                <!-- 搜索开始 -->
                <form id="app_searchform">
                    <div style="margin: 5px 20px;">
                        <table class="lcy-search">
                            <tr>
                            	<td>单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：
                                    <input class="easyui-textbox" name="unitname" id="unitnameApp" style="width:200px;height: 25px;">
                                </td>
                                                                                              
                                <td align="center" colspan="1">
                                    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFunc()">查询</a>&nbsp;&nbsp;
                                    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="cleanSearchFun()">重置</a>
                                </td>
                            </tr>
                            
                        </table>
                       
                    </div>
                </form>
            </div>
            <div data-options="region:'center',border:false" id="addid">
                <div style="margin: 0 20px 10px 20px;">
                    <!-- 搜索结果表格 -->
                    <table id="appInfo_dg" width="100%"></table>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    	var flagck = 0;  //  初始化为0
    	//所属单位
		/* $('#unitnameApp').combobox({
			url:'${pageContext.request.contextPath}/project/getUnitsData.do',
			valueField: 'id',
			textField: 'name',
			width:200,
			panelHeight: '100',
			loadFilter:function(data){
				data.unshift({id:"",name:"请选择"});
				return data;
			}
		}); */
		//所属单位
		$('#unitnameApp').combobox({
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
		//查询
		function searchFunc(){
		    $('#appInfo_dg').datagrid('load',icp.serializeObject($('#app_searchform')));
		}
		//重置
		function cleanSearchFun(){
			$('#app_searchform input').val('');
			$('#unitnameApp').textbox('clear');
			$('#appInfo_dg').datagrid('load',{});
		}
	    $(document).ready(function() { 	        
			function exportExcel(pids){
				$('#app_searchform').form('submit',{
						url:'${pageContext.request.contextPath}/report/exportExcel1.do',
						onSubmit: function(param){
							param.appid = pids;
							}
					});
			}
			
            $('#appInfo_dg').datagrid({
                rownumbers: false,
                checkOnSelect: true,
                selectOnCheck: true,
                scrollbarSize: 0,
                border: false,
                striped: true,
                sortName: 'ctime',
                sortOrder: 'desc',
                nowarp: false,
                singleSelect: false,
                method: 'post',
                loadMsg: '数据装载中......',
                fitColumns: true,
                idField: 'appid',
                pagination: true,
                pageSize: 10,
                pageList: [10, 20, 30, 40, 50],                
                url: '${pageContext.request.contextPath}/report/queryAppLists.do',
               	toolbar: [            
                {
                    id: 'almexp',
                     disabled:false,
                    text: '导出',
                    iconCls: 'icon-almexport',
                    handler: function() {
                        var rows = $('#appInfo_dg').datagrid('getChecked');
						var pids = "";
						 $.each(rows,function(index,object){
						 	pids+="'"+object.appid+"',";
		   				 });
						exportExcel(pids);
                        
                    }
                }  
              	], 
                onLoadSuccess: function (data) {

              	document.getElementById("sum").innerHTML=data.app;
              	var pageopt = $('#appInfo_dg').datagrid('getPager').data("pagination").options;
				var  _pageSize = pageopt.pageSize;
				var  _rows = $('#appInfo_dg').datagrid("getRows").length;
				var total = pageopt.total; //显示的查询的总数
				if (_pageSize >= 10) {
					for(i=10;i>_rows;i--){
						//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
						$(this).datagrid('appendRow', {appid:''  });
					}
					$('#appInfo_dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
					 $('#appInfo_dg').datagrid('unselectRow', rowIndex);
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
							$("#appInfo_dg").datagrid('uncheckRow', idx);
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
    				title:'',
    				field:'appid',
    				width:100,
    				align:'center',
    				hidden:true,
    			},
    			{
    				title:'部门',
    				field:'unitname',
    				width:100,
    				align:'center',
    			},
    			{
    				title:'业务系统（个）',
    				field:'appnum',
    				width:100,
    				align:'center',
    			}
			    		]],
		 	  
           });
            var totalApp = "<div id='addtoolbar'>当前在用系统总和：<span style='color:#f00' id='sum'></span>个</div>";
			$(".datagrid-toolbar table").css("float","left");
			$(".datagrid-toolbar").append(totalApp); 
    });
        
    </script>
  </body>
</html>
