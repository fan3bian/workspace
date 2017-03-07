<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
	String flowid = request.getParameter("flowid");//
   	String updateorderid = request.getParameter("updateorderid");//
   	String department = URLDecoder.decode(request.getParameter("department"),"UTF-8");//发起单位,中文解码
   	String proname = URLDecoder.decode(request.getParameter("proname"),"UTF-8");//项目名称
   	String uname = URLDecoder.decode(request.getParameter("uname"),"UTF-8");//发起人
   	
   	String otime = request.getParameter("otime");//发起时间
   	String useunitname = URLDecoder.decode(request.getParameter("useunitname"),"UTF-8");//使用单位
%>

<body class="easyui-layout" data-options="fit:true,border:false" >
	<style type="text/css">
		.iconImg ext-icon-note {background: url('${pageContext.request.contextPath}/images/normal.png') }
	</style>
  	<input id = "flowid" value=<%=flowid %> type="hidden">
  	
     <!--startprint-->
     <%--
    <div class="easyui-layout lcy-body" data-options="fit:true,border:false">
        <div data-options="region:'center',border:false">
            <div class="lcy-fqdd" style="margin-top: -74px;">
                <!-- 表格 -->
                <div class="lcy-fqdd-t">
                    <div class="header">资源变更申请单</div>
                    <div class="info">
                        <p class="fqr">使用单位: <span><%=useunitname %></span></p>
                        <p class="fqdw"></p>
                        <p class="fqdate">项目名称：<span><%=proname %></span></p>
                    </div>
               
                    
                    <div class="info">
                        <p class="fqr">发起人: <span><%= uname%></span></p>
                        <p class="fqdw">发起单位：<span><%= department%></span></p>
                        <p class="fqdate">发起时间：<span><%= otime%></span></p>
                    </div>
                </div>
            </div>
        </div>
    </div> --%>
    <!--endprint-->
    
    <div data-options="region:'center',fit:true,border:false" style="padding:10px;width:100%;height:100%;background:#eee">
		<table id="dg_changeOrderDetail" style="width:100%"
				   data-options="rownumbers:false,border:false,striped : true,nowarp:false,singleSelect: true,
				   sortName:'detailid',sortOrder:'asc',
				   url:'${pageContext.request.contextPath}/resourcechange/findResourceChangeToDo.do?transferid=<%=flowid %>',
				   method:'post',loadMsg:'数据装载中......',fitColumns:true,idField:'detailid'">
				<thead>
				<tr>
					<th data-options="field:'detailid',width:50,align:'center',sortable:true">序号</th>
					<th data-options="field:'useunitname',width:140,align:'center'">使用单位</th>
					<th data-options="field:'pname',width:100,align:'center'">服务名称</th>
					<th data-options="field:'neid',width:160,align:'center'">实例名称</th>
					<th data-options="field:'appname',width:100,align:'center'">应用</th>
					<th data-options="field:'networktype',width:100,align:'center'">网络类型</th>
					<th data-options="field:'tnumber',width:50,align:'center'">数量</th>
					<th data-options="field:'oldconfigure',width:170,align:'center'">原有规格</th>
					<th data-options="field:'newconfigure',width:170,align:'center'">变更规格</th>
					<th data-options="field:'operatetype',width:70,align:'center',formatter:operTypeFormater">操作类型</th>
					<th data-options="field:'status',width:70,align:'center',formatter:zybgoperformater">状态</th>
				</tr>
				</thead>
			</table>
	</div>
    <script type="text/javascript">
    	<%-- 
	    $(document).ready(function() {
			$.ajax({
				type:'post',
				url:'${pageContext.request.contextPath}/resourcechange/findResourceChangeToDo.do?transferid='+$("#flowid").val(),
				data:{},
				dataType:'json',
				async:false,
				success:function(result){
					$.each(result,function(index,obj){
						if($('#'+obj.pshopid).length==0){
						  $(".info").append('<div class="t-wrap-iaas"><table id="'+obj.pshopid+'"width="100%"></table></div>');
					     loadDataGrid(obj);
						}else{
						  insertData(obj);
						}
					})
				}
			});
		});
	  
	    // 表格数据加载
	    function loadDataGrid(obj) {
	        var str;
	        $('#'+obj.pshopid).datagrid({
	            title: obj.pshopname,
	            rownumbers: false,
	            scrollbarSize: 0,
	            border: false,
	            method: 'post',
	            loadMsg: '数据装载中......',
	            fitColumns: true,
	            nowrap: false,
	            columns: [
	                [{
	                    field: 'shopid',
	                    title: '服务编码 ',
	                    width:60,
	                    align: 'center'
	                }, {
	                    field: 'pname',
	                    title: '产品名称',
	                    width: 100,
	                    align: 'center'
	                },{
	                    field: 'neid',
	                    title: '实例名称',
	                    width: 130,
	                    align: 'center'
	                },{
	                    field: 'oldconfigure',
	                    title: '原有规格',
	                    width: 150,
	                    align: 'center'
	                    
	                },{
	                    field: 'newconfigure',
	                    title: '现有规格',
	                    width: 150,
	                    align: 'center'
	                    
	                },{
	                    field: 'measureunit',
	                    title: '单位',
	                    width: 40,
	                    align: 'center'
	                }, {
	                    field: 'newtnumber',
	                    title: '数量',
	                    width: 40,
	                    align: 'center'
	                },{
	                	field:'operatetype',
	                	title:'类型',
	                	width:40,
	                	align:'center',
	                	formatter:function(value,data){
	                		if("1"==data){
	                			return "变更";
	                		}else{
	                			return "注销";
	                		}
	                	}
	                },	                {
	                    field: 'status',
	                    title: '状态',
	                    width: 50,
	                    align: 'center',
	                    formatter:function(value,data){
	                        if('1'== value){
	                         return "完成";
	                        }else{
	                         return "未完成";
	                       }
	                    }
	                }]
	            ]
	        });
	        $(window).resize(function() {	
		        $('#'+obj.pshopid).datagrid('resize', {
		            width: $(".t-wrap-iaas").width //收缩引起window resize,重新计算值，并调用resize方法。
		        });
	    	}); 
	        //读入数据
	        insertData(obj);
	    }
		
		function insertData(obj){
			$('#'+obj.pshopid).datagrid('insertRow', {
                index: 0, // index start with 0
                row: {
                    shopid: obj.shopid,
                    pname: obj.pname,
                    neid:obj.neid,
                    oldconfigure: obj.oldconfigure,
                    newconfigure: obj.newconfigure,
                    measureunit: obj.measureunit,
                    newtnumber: obj.newtnumber,
                    operatetype:obj.operatetype,
                    status:obj.status
                }
            });
		}--%>
		
		$().ready(function () {
			//订单详情，显示悬浮框
			$('#dg_changeOrderDetail').datagrid({ 
				onLoadSuccess: function (data) {
					$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
				}
	      	});
	 	 });
		
		 //操作类型
		 function operTypeFormater(value,row,index){
			 switch(value){
				 case "1":
					 return "变更";
				 case "2":
					 return "注销";
			 }
		 }
		
		 //资源变更状态
	     function zybgoperformater(value, row, index){ 
			switch (value) {
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
  </body>
