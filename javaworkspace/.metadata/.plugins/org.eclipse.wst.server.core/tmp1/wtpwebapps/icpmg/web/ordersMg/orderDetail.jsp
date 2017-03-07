<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String orderId = request.getParameter("orderId")==null?"":request.getParameter("orderId").toString();//订单号
%>
<body class="easyui-layout" data-options="fit:true,border:false" >
	<style type="text/css">
		.iconImg ext-icon-note {background: url('${pageContext.request.contextPath}/images/normal.png') }
	</style>
	
	<div data-options="region:'center',fit:true,border:false" style="padding:10px;width:100%;height:100%;background:#eee">
		<table id="dg_orderDetail" style="width:100%"
				   data-options="rownumbers:false,border:false,striped : true,nowarp:false,singleSelect: true,
				   sortName:'detailid',sortOrder:'asc',
				   url:'${pageContext.request.contextPath}/ordermg/getOrderDetailByOrderId.do?orderId=<%=orderId %>',
				   method:'post',loadMsg:'数据装载中......',fitColumns:true,idField:'detailid'">
				<thead>
				<tr>
					<th data-options="field:'detailid',width:20,align:'center' ">序号</th>
					<th data-options="field:'orderid',width:20,align:'center',hidden:true">订单编码</th>
					<th data-options="field:'shopid',width:40,align:'center' ">服务编码</th>
					<th data-options="field:'pname',width:80,align:'center' ">资源名称</th>
					<th data-options="field:'appname',width:50,align:'center'">应用</th>
					<th data-options="field:'configure',width:170,align:'center'">规格</th>
					<th data-options="field:'network',width:30,align:'center'">网络类型</th>
					<th data-options="field:'tnumber',width:20,align:'center'">数量</th>
					<th data-options="field:'measureunit',width:30,align:'center'">单位</th>
					<th data-options="field:'status',width:30,align:'center',formatter:statusFormatter">状态</th>
					<th data-options="field:'ops',width:30,align:'center',formatter:detailsformater">操作</th>
				</tr>
				</thead>
			</table>
	</div>
	<script type="text/javascript" charset="utf-8">
		$().ready(function () {
			//订单详情，显示悬浮框
			$('#dg_orderDetail').datagrid({ 
				onLoadSuccess: function (data) {
					$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
				}
	      	});
	 	 });
		
		//专享、托管等查看详情
	  	function detailsformater(value,row,index){
		  if('200060'==row.shopid){
		 	 return icp.formatString('<a style=\"color:blue;cursor:pointer\" onclick=\"viewDetails(\'{0}\',\'{1}\');\">详情</a>', row.detailid,row.orderid);
		  }
		  if('200008'==row.shopid){
		     return icp.formatString('<a style=\"color:blue;cursor:pointer\" onclick=\"viewJGDetails(\'{0}\',\'{1}\',\'{2}\',\'{3}\');\">详情</a>',row.flowid, row.detailid,row.orderid,row.appname);
		  }
		   if('200009'==row.shopid){
		     return icp.formatString('<a style=\"color:blue;cursor:pointer\" onclick=\"viewIPDetails(\'{0}\',\'{1}\',\'{2}\');\">详情</a>',row.flowid, row.detailid,row.orderid);
		  }
		  if('200012'==row.shopid){
		     return icp.formatString('<a style=\"color:blue;cursor:pointer\" onclick=\"viewJWDetails(\'{0}\',\'{1}\',\'{2}\',\'{3}\');\">详情</a>',row.flowid, row.detailid,row.orderid,row.appname);
		   }
		 
		}
	 
	    function viewDetails(detailid,orderid){
	      var url="${pageContext.request.contextPath}/web/ordersMg/vipAllDetails.jsp?orderid="+orderid+"&detailid="+detailid;
	   	  var dialog = parent.icp.modalDialog({
				title : '专享详情一览',
				url : url,
				draggable:true
			});
		}
		
		function viewJGDetails(flowid,detailid,orderid,appname){
		    var url='${pageContext.request.contextPath}/web/ordersMg/orderJGTG.jsp?flowid='+orderid+'&detailid='+detailid+'&appname='+encodeURI(encodeURI(appname));
	     	var dialog = parent.icp.modalDialog({
			  title : '机柜托管详情',
			  width:'800px',
			  url : url,
			  draggable:true
			});
		}
		
		function viewIPDetails(flowid,detailid,orderid){
		    var url='${pageContext.request.contextPath}/web/ordersMg/orderIp.jsp?flowid='+orderid+'&detailid='+detailid;
	     	var dialog = parent.icp.modalDialog({
			  title : '互联网线路',
			  width:'750px',
			  height:'450px',
			  url : url,
			  draggable:true
			});
		}
		
		function viewJWDetails(flowid,detailid,orderid,appname){
		    var url='${pageContext.request.contextPath}/web/ordersMg/orderJWTG.jsp?flowid='+orderid+'&detailid='+detailid+'&appname='+encodeURI(encodeURI(appname));
	     	var dialog = parent.icp.modalDialog({
			  title : '机位托管详情',
			  width:'800px',
			  url : url,
			  draggable:true
			});
		}
		
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
	    
	    //实施状态
		function statusFormatter(value, row, index){ 
			switch(value){
				case "0":
					return "未完成";
				case "1":
					return "实施完成";
				case "2":
					return "实施中";
				case "3":
					return "实施失败";
				case "4":
					return "待实施";
				case "5":
					return "驳回";
				case "6":
					return "废弃";
			}
		}
 	</script>
</body>

