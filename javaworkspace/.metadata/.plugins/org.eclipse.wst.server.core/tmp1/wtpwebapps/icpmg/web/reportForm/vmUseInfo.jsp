<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>云服务使用统计</title>
    
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
                <form id="vm_searchform">
                    <div style="margin: 5px 20px;">
                        <table class="lcy-search">
                            <tr>
                            	<td>单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：
                                    <input class="easyui-textbox" name="unitname" id="unitnameVm" style="width:200px;height: 25px;">
                               		<td style="margin: 10px 20px 10px 20px;padding: 10px;">服务类型：<input class="easyui-textbox" name="serverType" id="serverTypeVm" data-options="validType:'isBlank'" style="width:100px;height:25px;"></td>
									<td style="margin: 10px 20px 10px 20px;padding: 10px;">服务名称：<input class="easyui-textbox" name="serverName" id="serverNameVm" data-options="validType:'isBlank'" style="width:120px;height:25px;"></td>
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
            <div data-options="region:'center',border:false" id="vmaddid">
                <div style="margin: 0 20px 10px 20px;">
                    <!-- 搜索结果表格 -->
                    <table id="dg_vmUse" width="100%">
                        <thead>
                            <tr>
                            	<th data-options="field:'ck',checkbox:true"></th>   
                            	
								<th data-options="field:'unitname',width:80,align:'center'">单位名称</th>
								<th data-options="field:'servertypenamelevelfirst',width:80,align:'center'">服务类型</th>
								<th data-options="field:'servertypenamesecond',width:80,align:'center'">服务名称</th>
								<th data-options="field:'usednum',width:50,align:'center'">数量</th>                                                 
                                
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    	var flagck = 0;
	  //服务类型 一级分类-二级分类级联
		$('#serverNameVm').combobox({
			width:120,
			panelHeight: '100'
		});
		
		$('#serverTypeVm').combobox({
			url:'${pageContext.request.contextPath}/resourceinfo/getSevertypeList.do',
			valueField: 'servertypeid',
			textField: 'servertypename',
			width:120,
			panelHeight: '100',
			loadFilter:function(data){
				data.unshift({servertypeid:"",servertypename:"请选择"});
				return data;
			},
			onSelect:function (record){
				var _servertypeid = record.servertypeid;
				$('#serverNameVm').combobox({
					url:'${pageContext.request.contextPath}/resourceinfo/getSevertypeSecond.do?servertypeid='+_servertypeid,
					valueField: 'servertypeid',
					textField: 'servertypename',
				});
			}
			
		});
    	//所属单位
		$('#unitnameVm').combobox({
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
	    $(document).ready(function() { 	        
			
	        //查询
	        $("#search").click(function() {
	        	
	        	searchCondition();
	        });
			//重置
	        $("#formReset").click(function() {
	            $("#vm_searchform").form("reset");
	            searchCondition();
	        });
	        function exportExcel(pids){
				$('#vm_searchform').form('submit',{
						url:'${pageContext.request.contextPath}/report/exportExcel2.do',
						onSubmit: function(param){
							param.neid = pids;
						
							}
					});
			}
		
			//条件查询
	        function searchCondition() {
	    		$('#dg_vmUse').datagrid('load', icp.serializeObject($('#vm_searchform')));
	    		
	    	}
    		
            $('#dg_vmUse').datagrid({
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
                idField: 'neid',
                pagination: true,
                pageSize: 10,
                pageList: [10, 20, 30, 40, 50],
                url: '${pageContext.request.contextPath}/report/queryVmUseLists.do',
               toolbar: [            
                {
                    id: 'almexp',
                     disabled:false,
                    text: '导出',
                    iconCls: 'icon-almexport',
                    handler: function() {
                        var rows = $('#dg_vmUse').datagrid('getChecked');
						var pids = "";
						 $.each(rows,function(index,object){
						 	pids+="'"+object.neid+"',";
		   				 });
						exportExcel(pids);
                        
                    }
                }  
              	], 
                onLoadSuccess: function (data) {

              	document.getElementById("sum").innerHTML=data.vmNum;
	
	              var pageopt = $('#dg_vmUse').datagrid('getPager').data("pagination").options;
			      var  _pageSize = pageopt.pageSize;
			      var  _rows = $('#dg_vmUse').datagrid("getRows").length;
			      var total = pageopt.total; //显示的查询的总数 
			      
			      if (_pageSize >= 10) {
			         for(i=10;i>_rows;i--){
			            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
			            $(this).datagrid('appendRow', {unitname:''  })
			         }
			          $('#dg_vmUse').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
											if   (val.unitname==''){  
												$('#vmaddid  input:checkbox').eq(idx+1).css("display","none");
												 
											}
										}); 
							      }
		 	  },
		 	  
		 	  //没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.unitname==''){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
					$('#vmaddid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck = 1;
							$.each(rows, function (idx, val) {
								if (val.unitname==''){
									$("#datagrid_promg").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('#vmaddid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
								}
							});
					},
									
					onUncheckAll: function(rows) {
						flagck = 0;
					}  
		 	  
		 	  
		 	  
           });
            var vmUseTotal = "<div id='addtoolbar'>当前云服务使用总数：<span style='color:#f00' id='sum'></span>个</div>";
    		$(".datagrid-toolbar table").css("float","left");
    		$(".datagrid-toolbar").append(vmUseTotal); 
    });
        
    </script>
  </body>
</html>
