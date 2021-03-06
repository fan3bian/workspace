﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>订单管理</title>
    
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
                                
                                <td>&nbsp;&nbsp; 月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份：     
                                	<input id="tdate" name="tdate" style="height: 25px; "data-options="panelHeight:200">                          
                                   <!-- <input class="easyui-datebox" data-options="showSeconds:false,panelWidth:200"  id="tdate" style="width: 200px ;"  name="tdate"> -->
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
             	<!-- <div style="">
             	
             	<p style="position: absolute; right: 50px; z-index: 1; top: 12px;">当前费用总和：<span style="color:#f00" id="sum"></span>元</p>
                             
	            </div> -->
                <div style="margin: 0 20px 40px 20px;">
                    <!-- 搜索结果表格 -->
                    <table id="order_dg" width="100%">
                        <thead>
                            <tr>
                                <th data-options="field:'ck',checkbox:true"></th>                                
                                
                                <th data-options="field:'unitname',width:60,align:'center'">单位名称</th>                                                             
                                <th data-options="field:'objectid',width:60,align:'center'">实例名称</th>                                                   
                                <th data-options="field:'servertypenamesecond',width:60,align:'center'">服务名称</th>  
                                <th data-options="field:'tdate',width:60,align:'center',sortable:true">月份</th>                                                                              
                                <th data-options="field:'tfee',width:60,align:'center'">费用(元)</th>
                                
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    
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
                text: year
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

            var n = 1;
            for (var i = 1; i <= 4; i++) {
                var tr = $('<tr>');
                for (var m = 1; m <= 3; m++) {
                    var td = $('<td>', {
                        text: n,
                        click: function () {
                            var yyyy = $(table).find("tr:first>td:eq(1)").html();
                            var cell = $(this).html();
                            var v = yyyy + '-' + (cell.length < 2 ? '0' + cell : cell);
                            obj.combobox('setValue', v).combobox('hidePanel');

                        }
                    });
                    if (n == month) {
                        td.addClass('tdbackground');
                    }
                    td.appendTo(tr);
                    n++;
                }
                tr.appendTo(table);
            }
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
		$('#unitname').combobox({
			url:'${pageContext.request.contextPath}/alarm/getCompany.do',
			valueField: 'id',
			textField: 'name',
			width:200,
			panelHeight: '100',
			loadFilter:function(data){
				data.unshift({id:"",name:"请选择"});
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
	    		$('#order_dg').datagrid('load', icp.serializeObject($('#resource_searchform')));
	    		
	    	}
    
            $('#order_dg').datagrid({
                rownumbers: false,
                checkOnSelect: true,
                selectOnCheck: true,
                scrollbarSize: 0,
                border: false,
                striped: true,
                sortName: 'objectname',
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
                url: '${pageContext.request.contextPath}/scoreinfoMg/feeList.do',
                toolbar: [ 
                           
                {
                    id: 'ddxq',
                    text: '计费详情',
                    iconCls: 'icon-showdetail',
                    handler: function() {
                        var rows = $('#order_dg').datagrid('getChecked');
        				if (rows.length != 1) {
        					$.messager.alert('消息', '请选择一条记录！','info');
        					return;
        				}
        				var orderidTemp = rows[0].objectname;//订单号
        				var timeTemp = rows[0].tdate;//日期      
        								       				
        				var useunitnameTemp = rows[0].unitname;//使用单位 
                        $('#btnprint').linkbutton('enable');
                        $('#orderWrap').attr("class", "");
                       
                        $('#orderWrap').panel({
                            href: "<%=basePath%>/web/feeMg/feePrint.jsp?objectname="+orderidTemp+"&unitname="+encodeURI(encodeURI(useunitnameTemp))+"&tdate="+timeTemp
                        });
                    }
                },
               /*  {
                    id: 'almexp',
                    text: '导出',
                    iconCls: 'icon-almexport',
                    menuAlign: 'right',
                    handler: function() {
                        
                        
                    }
                } */
              	],
              onLoadSuccess: function (data) {

              	document.getElementById("sum").innerHTML=data.monthPrice;
	
	            var pageopt = $('#order_dg').datagrid('getPager').data("pagination").options;
					      var  _pageSize = pageopt.pageSize;
					      var  _rows = $('#order_dg').datagrid("getRows").length;
					      var total = pageopt.total; //显示的查询的总数 
					      if (_pageSize >= 10) {
					         for(i=10;i>_rows;i--){
					            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
					            $(this).datagrid('appendRow', {operation:''  })
					         }
					          $('#order_dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
            var feeTotal = "<div id='addtoolbar'>当前费用总和：<span style='color:#f00' id='sum'></span>元</div>";
			$(".datagrid-toolbar table").css("float","left");
			$(".datagrid-toolbar").append(feeTotal); 
    });
        
    </script>
  </body>
</html>
