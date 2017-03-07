<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>云服务费用统计</title>
    
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
  .mytable
{
    padding: 0;
    margin: 10px auto;
    border-collapse: collapse;
    font-family: @宋体;
    empty-cells: show;
}

.mytable caption
{
    font-size: 12px;
    color: #0E2D5F;
    height: 16px;
    line-height: 16px;
    border: 1px dashed red;
    empty-cells: show;
}

.mytable tr th
{
    border: 1px dashed #C1DAD7;
    letter-spacing: 2px;
    text-align: left;
    padding: 6px 6px 6px 12px;
    font-size: 13px;
    height: 16px;
    line-height: 16px;
    empty-cells: show;
}

.mytable tr td
{
    font-size: 12px;
    border: 1px dashed #C1DAD7;
    padding: 6px 6px 6px 12px;
    empty-cells: show;
    border-collapse: collapse;
}
.cursor
{
    cursor: pointer;
}
.tdbackground
{
    background-color: #FFE48D;
}
 </style>
    <div id="orderWrap" style="width: 100%; height: 100%">
        <div class="easyui-layout lcy-body" data-options="fit:true,border:false" >
            <div data-options="region:'north',border:false" style="height: 45px;">
                <!-- 搜索开始 -->
                <form id="resource_searchform">
                    <div style="margin: 5px 20px;">
                        <table class="lcy-search">
                            <tr>
                                <td>单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：
                                    <input class="easyui-textbox" name="unitname" id="unitname" style="width:200px;height: 25px;">
                                </td>
                                
                                <td>&nbsp;&nbsp; 年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份： 
                                
                                <input id="tdate" name="tdate" style="height: 25px; "data-options="panelHeight:60">  
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
            
            <div data-options="region:'center',border:false" id="scoreid">
                <div style="margin: 0 20px 10px 20px;">
                    <!-- 搜索结果表格 -->
                    <table id="vmFee_dg" width="100%">
                        <thead>
                            <tr>
                                <th data-options="field:'ck',checkbox:true"></th>                                
                                
                                <th data-options="field:'unitname',width:60,align:'center'">单位名称</th>                                                             
                                <th data-options="field:'tdate',width:60,align:'center'">年份</th>
                                <th data-options="field:'tfee',width:60,align:'center'">费用(元)</th>
                                
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    var flagck = 0;
    $.extend($.fn.combobox.methods, {
    yearandmonth: function (jq) {
        return jq.each(function () {
            var obj = $(this).combobox();
            var date = new Date();
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var table = $('<table>');
            var tr1 = $('<tr>');
            var tr1td1 = $('<td>', {
                text: '-',
                click: function () {
                    var y = $(this).next().html();
                    y = parseInt(y) - 1;
                    $(this).next().html(y);
                }
            });
            tr1td1.appendTo(tr1);
            var tr1td2 = $('<td>', {
                text: year,
                click: function () {
                	 var yyyy = $(table).find("tr:first>td:eq(1)").html();
                	 obj.combobox('setValue', yyyy).combobox('hidePanel');
                }
            }).appendTo(tr1);

            var tr1td3 = $('<td>', {
                text: '+',
                click: function () {
                    var y = $(this).prev().html();
                    y = parseInt(y) + 1;
                    $(this).prev().html(y);
                }
            }).appendTo(tr1);
            tr1.appendTo(table);

            table.addClass('mytable cursor');
            table.find('td').hover(function () {
                $(this).addClass('tdbackground');
            }, function () {
                $(this).removeClass('tdbackground');
            });
            table.appendTo(obj.combobox("panel"));

        });
    }
});
    
    $('#tdate').combobox('yearandmonth');
    
    	//所属单位
		/* $('#unitname').combobox({
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
		$('#unitname').combobox({
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
	            $("#resource_searchform").form("reset");
	            searchCondition();
	        });
			//条件查询
	        function searchCondition() {
	    		$('#vmFee_dg').datagrid('load', icp.serializeObject($('#resource_searchform')));
	    		
	    	}
	    	function exportExcel(pids){
				$('#resource_searchform').form('submit',{
					url:'${pageContext.request.contextPath}/report/exportExcel.do',
					onSubmit: function(param){
						param.unitid = pids;
						
					}
				});
			}
            $('#vmFee_dg').datagrid({
                rownumbers: false,
                checkOnSelect: true,
                selectOnCheck: true,
                scrollbarSize: 0,
                border: false,
                striped: true,
                sortName: 'unitid',
                sortOrder: 'asc',
                nowarp: false,
                singleSelect: false,
                method: 'post',
                loadMsg: '数据装载中......',
                fitColumns: true,
                //idField: 'orderid',
                pagination: true,
                pageSize: 10,
                pageList: [10, 20, 30, 40, 50],
                url: '${pageContext.request.contextPath}/report/queryVmFeeLists.do', 
                toolbar: [            
                {
                    id: 'almexp',
                    disabled:false,
                    text: '导出',
                    iconCls: 'icon-almexport',
                    handler: function() {
                        var rows = $('#vmFee_dg').datagrid('getChecked');
						var pids = "";
						 $.each(rows,function(index,object){
						 	pids+="'"+object.unitid+"',";
		   				 });
		   				
						exportExcel(pids);
                        
                    }
                }  
              	],               
              	onLoadSuccess: function (data) {
     
              	  document.getElementById("sum").innerHTML=data.vmPrice;

			      var pageopt = $('#vmFee_dg').datagrid('getPager').data("pagination").options;
				      var  _pageSize = pageopt.pageSize;
				      var  _rows = $('#vmFee_dg').datagrid("getRows").length;
				      var total = pageopt.total; //显示的查询的总数 
				      if (_pageSize >= 10) {
				         for(i=10;i>_rows;i--){
				            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
				            $(this).datagrid('appendRow', {operation:''  })
				         }
				          $('#vmFee_dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
									$("#datagrid_promg").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('#scoreid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
								}
							});
					},
									
					onUncheckAll: function(rows) {
						flagck = 0;
					}  
		 	  
		 	  
		 	  
           });
            var vmFeeTotal = "<div id='addtoolbar'>当前费用总和：<span style='color:#f00' id='sum'></span>元</div>";
			$(".datagrid-toolbar table").css("float","left");
			$(".datagrid-toolbar").append(vmFeeTotal);
    });
        
    </script>
  </body>
</html>
