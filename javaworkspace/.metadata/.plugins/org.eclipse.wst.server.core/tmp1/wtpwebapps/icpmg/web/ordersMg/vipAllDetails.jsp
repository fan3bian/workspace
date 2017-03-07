<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<%
 	String orderid = request .getParameter("orderid" );
 	if (orderid == null) {
		orderid = "";
	}
    String detailid = request .getParameter("detailid" );
	
	if (detailid == null) {
		detailid = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<%-- <jsp:include page="../inc.jsp"></jsp:include> --%>
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/easyui-1.4/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/easyui-1.4/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/easyui-1.4/themes/color.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/easyui-1.4/demo/demo.css">
<script type="text/javascript" src="<%=contextPath %>/easyui-1.4/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=contextPath %>/easyui-1.4/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/javascript">
$(function(){

   // var orderid =<%=orderid %>;
  //  var detailid =<%=detailid %>;
  //  ${pageContext.request.contextPath}/workorder/getVipDetails.do?orderid="+orderid+"&detailid="+detailid;
	//var urls="${pageContext.request.contextPath}/workorder/getVipDetails.do?orderid="+orderid+"&detailid="+detailid;
	$('#vip_allDetails_datagrid').datagrid({
		url:'${pageContext.request.contextPath}/workorder/getVipDetails.do?orderid=<%=orderid%>&detailid=<%=detailid%>',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		fit:true,
		fitColumns:true,
		nowarp:false,
		rownumbers:true,
		border:false,
		scrollbarSize:0,
		idField:'equipmentname',
		sortOrder:'asc',
		onLoadSuccess: function (data) {
						$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
					}
	});
});

	function productFormatter(value) {
        for (var i = 0; i < optionTypes.length; i++) {
        	
            if (optionTypes[i].productid == value) return optionTypes[i].name;
        }
        return value;
    }
  //专享
     var optionTypes = [{
        productid: '10001',
        name: '服务器'
    }, {
        productid: '10002',
        name: '存储'
    }, {
        productid: '10003',
        name: '网络设备'
    }, {
        productid: '10004',
        name: '安全设备'
    }, {
        productid: '10005',
        name: 'SAN交换机'
    },{
        productid: '10006',
        name: '其它'
    }
    
    ];
  //datagrid悬浮框处理
		$.extend($.fn.datagrid.methods, {
	        /**
	         * 开打提示功能
	         * @param {} jq
	         * @param {} params 提示消息框的样式
	         * @return {}
	         */
	        doCellTip: function(jq, params){
	            function showTip(data, td, e){
	                if ($(td).text() == "") 
	                    return;
	                data.tooltip.text($(td).text()).css({
	                    top: (e.pageY + 10) + 'px',
	                    left: (e.pageX + 20) + 'px',
	                    'z-index': $.fn.window.defaults.zIndex,
	                    display: 'block'
	                });
	            };
	            return jq.each(function(){
	                var grid = $(this);
	                var options = $(this).data('datagrid');
	                if (!options.tooltip) {
	                    var panel = grid.datagrid('getPanel').panel('panel');
	                    //var fields=$(this).datagrid('getColumnFields',false);////获取列
	                    var defaultCls = {
	                        'border': '1px solid #333',
	                        'padding': '2px',
	                        'color': '#333',
	                        'background': '#f7f5d1',
	                        'position': 'absolute',
	                        'max-width': '200px',
							'border-radius' : '4px',
							'-moz-border-radius' : '4px',
							'-webkit-border-radius' : '4px',
	                        'display': 'none'
	                    }
	                    var tooltip = $("<div id='celltip'></div>").appendTo('body');
	                    tooltip.css($.extend({}, defaultCls, params.cls));
	                    options.tooltip = tooltip;
	                    panel.find('.datagrid-body').each(function(){
	                        var delegateEle = $(this).find('> div.datagrid-body-inner').length ? $(this).find('> div.datagrid-body-inner')[0] : this;
	                        $(delegateEle).undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove').delegate('td', {
	                            'mouseover': function(e){
	                                if (params.delay) {
	                                    if (options.tipDelayTime) 
	                                        clearTimeout(options.tipDelayTime);
	                                    var that = this;
	                                    options.tipDelayTime = setTimeout(function(){
	                                        showTip(options, that, e);
	                                    }, params.delay);
	                                }
	                                else {
	                                    showTip(options, this, e);
	                                }
	                                
	                            },
	                            'mouseout': function(e){
	                                if (options.tipDelayTime) 
	                                    clearTimeout(options.tipDelayTime);
	                                options.tooltip.css({
	                                    'display': 'none'
	                                });
	                            },
	                            'mousemove': function(e){
									var that = this;
	                                if (options.tipDelayTime) 
	                                    clearTimeout(options.tipDelayTime);
	                                //showTip(options, this, e);
									options.tipDelayTime = setTimeout(function(){
	                                        showTip(options, that, e);
	                                    }, params.delay);
	                            }
	                        });
	                    });
	                    
	                }
	                
	            });
	        },
	        /**
	         * 关闭消息提示功能
	         *
	         * @param {}
	         *            jq
	         * @return {}
	         */
	        cancelCellTip: function(jq){
	            return jq.each(function(){
	                var data = $(this).data('datagrid');
	                if (data.tooltip) {
	                    data.tooltip.remove();
	                    data.tooltip = null;
	                    var panel = $(this).datagrid('getPanel').panel('panel');
	                    panel.find('.datagrid-body').undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove')
	                }
	                if (data.tipDelayTime) {
	                    clearTimeout(data.tipDelayTime);
	                    data.tipDelayTime = null;
	                }
	            });
	        }
	    });
</script>
</head>
<body>
	<table style="width:100%;" id="vip_allDetails_datagrid">
		<thead>
			<tr>
				<th data-options="field:'equipmentname',width:100,align:'center'">设备名称</th>
				<th data-options="field:'equipmentbrand',width:80,align:'center'">品牌型号</th>
				<th data-options="field:'equipmentstyle',width:100,align:'center',formatter:productFormatter,
				editor:{
                            type:'combobox',
                            options:{
                            	editable:false,
                                valueField:'productid',
                                textField:'name',
                                data:optionTypes,
                                required:true
                            }
                        }">类型</th>
				<th data-options="field:'equiparameters',width:300,align:'center'">规格参数</th>
				<th data-options="field:'measureunit',width:60,align:'center'">单位</th>
				<th data-options="field:'equipnums',width:60,align:'center'">数量</th>
			</tr>
		</thead>
	</table>
</body>
</html>