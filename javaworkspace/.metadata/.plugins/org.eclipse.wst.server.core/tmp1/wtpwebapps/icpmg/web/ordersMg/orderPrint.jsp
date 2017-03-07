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
    	String orderid = request.getParameter("orderid");//订单号
    	String department = URLDecoder.decode(request.getParameter("department"),"UTF-8");//发起单位,中文解码
    	String proname = URLDecoder.decode(request.getParameter("proname"),"UTF-8");//项目名称
    	String uname = URLDecoder.decode(request.getParameter("uname"),"UTF-8");//发起人
    	
    	String otime = request.getParameter("otime");//发起时间
    	String useunitname = URLDecoder.decode(request.getParameter("useunitname"),"UTF-8");//使用单位
    %>
    
    <title>打印清单</title>
    
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
     <!--startprint-->
    <div class="easyui-layout lcy-body" data-options="fit:true,border:false">
        <div data-options="region:'center',border:false">
            <div class="lcy-fqdd" style="margin-top: -74px;">
                <!-- 表格 -->
                <div class="lcy-fqdd-t">
                    <div class="header">资源申请单</div>
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
				url:'${pageContext.request.contextPath}/ordermg/getPrintLists.do',
				data:{
					orderid:$("#orderid").val()
					},
				dataType:'json',
				async:false,
				success:function(result){
					$.each(result,function(index,obj){
						//console.log(obj.pshopid);
					
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
		                    width: 100,
		                    align: 'center'
		                }, {
		                    field: 'pname',
		                    title: '产品名称',
		                    width: 100,
		                    align: 'center'
		                },
		                 {
		                    field: 'configure',
		                    title: '规格',
		                    width: 150,
		                    align: 'center',
		                    
		                },{
		                    field: 'measureunit',
		                    title: '单位',
		                    width: 50,
		                    align: 'center'
		                }, {
		                    field: 'tnumber',
		                    title: '数量',
		                    width: 50,
		                    align: 'center'
		                },
		                {
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
	                    measureunit: obj.measureunit,
	                    tnumber: obj.tnumber,
	                    status:obj.status,
	                    configure: obj.configure
	                }
	            });
		}
    </script>
  </body>
</html>
