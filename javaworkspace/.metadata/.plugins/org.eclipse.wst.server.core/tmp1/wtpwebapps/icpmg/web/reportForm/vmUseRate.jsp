<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>云服务器配置</title>
    
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
                                    <input class="easyui-textbox" name="unitname" id="unitnameConfig" style="width:200px;height: 25px;">
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
            <style>
           		#vmaddid .datagrid-header,
           		#vmaddid .datagrid-td-rownumber {
   				background: #bbb;}
   				#vmaddid .datagrid-header .datagrid-cell {
				    background-color: #bbb;
				} 
				#vmaddid .datagrid-header td.datagrid-header-over {
				  background: #bbb;
				}
    		</style>
            <div data-options="region:'center',border:false" id="vmaddid">
                <div style="margin: 0 20px 10px 20px;">
                    <!-- 搜索结果表格 -->
                    <table id="dg_vmRate" >
                        <thead>
                            <tr>
                            	<th data-options="field:'ck',checkbox:true" rowspan="2"></th>   
                            	
								<th data-options="field:'unitname',width:150,height:30,align:'center'" rowspan="2">使用部门</th>
								<th data-options="field:'groupname',width:150,align:'center'" rowspan="2">上级部门</th>
								<th data-options="field:'appname',width:100,align:'center'" rowspan="2">应用</th>
								<th data-options="field:'neid',width:170,align:'center'" rowspan="2">云服务器名称</th>
								<th data-options="field:'networktypename',width:80,align:'center'" rowspan="2">区域</th>
								<th data-options="field:'interaip',width:80,align:'center'," rowspan="2">内网IP</th>
								<th colspan="3">互联网IP</th>
								<th data-options="field:'buytime',width:130,align:'center'" rowspan="2">开通时间</th>
								<th colspan="7">CPU利用率峰值（%）</th>
								<th colspan="7">内存利用率峰值（%）</th>
								<th colspan="7">磁盘使用率（%）</th>
                            </tr>
                            <tr>
                            	<th data-options="field:'interipunincom',width:80,align:'center'">联通IP</th>
								<th data-options="field:'interiptelecom',width:80,align:'center'">电信IP</th>
								<th data-options="field:'interipmobile',width:80,align:'center'">移动IP</th>
                            	<th data-options="field:'maxcpu1',width:80,align:'center'" ><span id="cpudate1"></span></th>
								<th data-options="field:'maxcpu2',width:80,align:'center'" ><span id="cpudate2"></span></th>
								<th data-options="field:'maxcpu3',width:80,align:'center'" ><span id="cpudate3"></span></th>
								<th data-options="field:'maxcpu4',width:80,align:'center'" ><span id="cpudate4"></span></th>
								<th data-options="field:'maxcpu5',width:80,align:'center'" ><span id="cpudate5"></span></th>
								<th data-options="field:'maxcpu6',width:80,align:'center'" ><span id="cpudate6"></span></th>
								<th data-options="field:'maxcpu7',width:80,align:'center'" ><span id="cpudate7"></span></th>
								
								<th data-options="field:'maxmem1',width:80,align:'center'" ><span id="memdate1"></th>
								<th data-options="field:'maxmem2',width:80,align:'center'" ><span id="memdate2"></span></th>
								<th data-options="field:'maxmem3',width:80,align:'center'" ><span id="memdate3"></span></th>
								<th data-options="field:'maxmem4',width:80,align:'center'" ><span id="memdate4"></span></th>
								<th data-options="field:'maxmem5',width:80,align:'center'" ><span id="memdate5"></span></th>
								<th data-options="field:'maxmem6',width:80,align:'center'" ><span id="memdate6"></span></th>
								<th data-options="field:'maxmem7',width:80,align:'center'" ><span id="memdate7"></span></th>
								
								<th data-options="field:'maxdisk1',width:80,align:'center'," ><span id="diskdate1"></th>
								<th data-options="field:'maxdisk2',width:80,align:'center'," ><span id="diskdate2"></span></th>
								<th data-options="field:'maxdisk3',width:80,align:'center'," ><span id="diskdate3"></span></th>
								<th data-options="field:'maxdisk4',width:80,align:'center'," ><span id="diskdate4"></span></th>
								<th data-options="field:'maxdisk5',width:80,align:'center'," ><span id="diskdate5"></span></th>
								<th data-options="field:'maxdisk6',width:80,align:'center'," ><span id="diskdate6"></span></th>
								<th data-options="field:'maxdisk7',width:80,align:'center'," ><span id="diskdate7"></span></th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    	var flagck = 0;
    	//所属单位
		$('#unitnameConfig').combobox({
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
						url:'${pageContext.request.contextPath}/report/exportExcelRate.do',
						onSubmit: function(param){
							param.neid = pids;
						
							}
					});
			}
		
			//条件查询
	        function searchCondition() {
	    		$('#dg_vmRate').datagrid('load', icp.serializeObject($('#vm_searchform')));
	    		
	    	}
    		
            $('#dg_vmRate').datagrid({
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
                idField: 'neid',
                pagination: true,
                pageSize: 10,
                pageList: [10, 20, 30, 40, 50],
                url: '${pageContext.request.contextPath}/report/queryVmRateLists.do',
               toolbar: [            
                {
                    id: 'almexp',
                    disabled:false,
                    text: '导出',
                    iconCls: 'icon-almexport',
                    handler: function() {
                        var rows = $('#dg_vmRate').datagrid('getChecked');
						var pids = "";
						 $.each(rows,function(index,object){
						 	pids+="'"+object.neid+"',";
		   				 });
						exportExcel(pids);
                        
                    }
                }  
              	], 
                onLoadSuccess: function (data) {
	              var pageopt = $('#dg_vmRate').datagrid('getPager').data("pagination").options;
			      var  _pageSize = pageopt.pageSize;
			      var  _rows = $('#dg_vmRate').datagrid("getRows").length;
			      var total = pageopt.total; //显示的查询的总数 
			      
			      if (_pageSize >= 10) {
			         for(i=10;i>_rows;i--){
			            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
			            $(this).datagrid('appendRow', {unitname:''  })
			         }
			          $('#dg_vmRate').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
    });
	    function GetDateStr(AddDayCount) {
	    	var dd = new Date();
	    	dd.setDate(dd.getDate()+AddDayCount);//获取AddDayCount天后的日期
	    	var y = dd.getFullYear();
	    	var m = dd.getMonth()+1;//获取当前月份的日期
	    	var d = dd.getDate();
	    	return y+"-"+m+"-"+d;
	    }
    	$('#cpudate1').html(GetDateStr(-6));
    	$('#memdate1').html(GetDateStr(-6));
    	$('#diskdate1').html(GetDateStr(-6));
    	
    	$('#cpudate2').html(GetDateStr(-5));
    	$('#memdate2').html(GetDateStr(-5));
    	$('#diskdate2').html(GetDateStr(-5));
    	
    	$('#cpudate3').html(GetDateStr(-4));
    	$('#memdate3').html(GetDateStr(-4));
    	$('#diskdate3').html(GetDateStr(-4));
    	
    	$('#cpudate4').html(GetDateStr(-3));
    	$('#memdate4').html(GetDateStr(-3));
    	$('#diskdate4').html(GetDateStr(-3));
    	
    	$('#cpudate5').html(GetDateStr(-2));
    	$('#memdate5').html(GetDateStr(-2));
    	$('#diskdate5').html(GetDateStr(-2));
    	
    	$('#cpudate6').html(GetDateStr(-1));
    	$('#memdate6').html(GetDateStr(-1));
    	$('#diskdate6').html(GetDateStr(-1));
    	
    	$('#cpudate7').html(GetDateStr(0));
    	$('#memdate7').html(GetDateStr(0));
    	$('#diskdate7').html(GetDateStr(0));
    </script>
  </body>
</html>
