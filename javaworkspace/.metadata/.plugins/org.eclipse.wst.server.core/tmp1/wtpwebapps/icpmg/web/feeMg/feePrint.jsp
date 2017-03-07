<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <%
    	String orderid = request.getParameter("objectname");//订单号
    	
    	String tdate = request.getParameter("tdate");
    	 
    	//String proname = URLDecoder.decode(request.getParameter("projectname"),"UTF-8");//项目名称
    	
    	String useunitname = URLDecoder.decode(request.getParameter("unitname"),"UTF-8");//使用单位 
    %>
    
    <title>费用清单</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
   <title>ICP后台管理</title>
    <link href="<%=basePath%>/css/default.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>/css/regcore.css" rel="stylesheet" type="text/css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery-1.8.3.min.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/default/easyui.css" type="text/css">
    <link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/icon.css" type="text/css">
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
  </head>
  
  <body>
  	<input id = "orderid" value=<%=orderid %> type="hidden">
  	<input id = "tdate" value=<%=tdate %> type="hidden">
  	
     <!--startprint-->
    <link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" />
    <div class="easyui-layout lcy-body" data-options="fit:true,border:false">
        <div data-options="region:'center',border:false">
            <div class="lcy-fqdd" style="margin-top: -74px;">
                <!-- 表格 -->
                <div class="lcy-fqdd-t">
                    <div class="header">费用详情单</div>
                    <div class="info">
                       <p class="fqr">使用单位: <span><%=useunitname %></span></p>
                        <%-- <p class="fqdw"></p>
                        <p class="fqdate">项目名称：<span><%=proname %></span></p> --%>
                    </div>
               
                    
                    <%-- <div class="info">
                        <p class="fqr">发起人: <span><%= uname%></span></p>
                        <p class="fqdw">发起单位：<span><%= department%></span></p>
                        <p class="fqdate">发起时间：<span><%= otime%></span></p>
                    </div> --%>
                    <!-- <div class="btn-box noprint  ">
                        <a href="#" class="easyui-linkbutton " data-options="iconCls:'icon-print'" onclick="doPrint()">打印</a>
                    </div> -->
                </div>
            </div>
        </div>
    </div>
    <!--endprint-->
    <script type="text/javascript">
	    $(document).ready(function() {
	    	
			$.ajax({
				type:'post',
				url:'${pageContext.request.contextPath}/scoreinfoMg/feedetailList.do',
				data:
					"orderid="+$("#orderid").val()+"&tdate="+$("#tdate").val()					
					,
				dataType:'json',
				async:false,
				success:function(result){
					console.log(result);
					$.each(result,function(index,obj){
						console.log(index);
						if($('#'+obj.severtypeidlevelfirst).length==0){
						  $(".info").append('<div class="t-wrap-iaas"><table id="'+obj.severtypeidlevelfirst+'"width="100%"></table></div>');
					     loadDataGrid(obj);
						}else{
							console.log('aaa');
						  insertData(obj);
				 
						}
					});
				}
			});
		});
    
   
	  
	    // 表格数据加载
	    function loadDataGrid(obj) {
	        var str;
	  
		        $('#'+obj.severtypeidlevelfirst).datagrid({
		           title: true,
		            rownumbers: false,
		            scrollbarSize: 0,
		            border: false,
		            method: 'post',
		            loadMsg: '数据装载中......',
		            fitColumns: true,
		            columns: [
		                [
		                 {
		                    field: 'objectid',
		                    title: '实例名称',
		                    width: 80,
		                    align: 'center'
		                },{
		                    field: 'objectname',
		                    title: '实例名称',
		                    width: 80,
		                    align: 'center',
		                    hidden: true,
		                },{
		                    field: 'tdate',
		                    title: '日期',
		                    width: 80,
		                    align: 'center'
		                },{
		                    field: 'servertypenamesecond',
		                    title: '服务名称',
		                    width: 80,
		                    align: 'center'
		                },{
		                    field: 'status',
		                    title: '状态',
		                    width: 50,
		                    align: 'center',
		                    formatter:function(value,data){
		                     
		                        if('1'== value){
		                         return "正常";
		                        }else{
		                         return "不正常";
		                       }
		                    }
		                },{
		                    field: 'tfee',
		                    title: '费用(元)',
		                    width: 50,
		                    align: 'center'
		                } ]
		            ]
		        });
		        $(window).resize(function() {	
			        $('#'+obj.severtypeidlevelfirst).datagrid('resize', {
			            width: $(".t-wrap-iaas").width //收缩引起window resize,重新计算值，并调用resize方法。
			        });
		    	}); 
		        //读入数据
		        insertData(obj);
    
	    }
		
		function insertData(obj){
				$('#'+obj.severtypeidlevelfirst).datagrid('insertRow', {
	                index: 0, // index start with 0
	                row: {
	                    
	                    tdate:obj.tdate,
	                    objectid:obj.objectid,
	                    servertypenamesecond:obj.servertypenamesecond,
	                    status:obj.status,
	                    tfee:obj.tfee	                   
	                }
	            });
		}
    </script>
  </body>
</html>
