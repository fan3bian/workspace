<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/icp/style/homepage.css" type="text/css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/icp/style/index.css" type="text/css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/icp/style/style2.css" type="text/css"/>
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/icp/style/miniui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui-1.4/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui-1.4/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/icp/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/icp/js/easyui-1.4/jquery.easyui.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/icp/js/easyui-1.4/locale/easyui-lang-zh_CN.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/icp/js/util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/icp/js/gather.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/icp/js/slide.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/icp/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/icp/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/highchart/highcharts.js"  ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/icp/js/homepage/jquery-ui.js"></script> 
 <script>
        $(function (){
            $("#tabs").tabs({
            });
        });
  </script>
</head>
<body style="height:350px;width:423px;overflow:hidden;">
             <div style="height:350px;width:423px;overflow:hidden;">
					 <div id="tabs">
				        <ul>
				            <li><a href="${pageContext.request.contextPath}/icp/include/tab1.jsp">待办工单</a></li>
				            <li><a href="${pageContext.request.contextPath}/icp/include/tab2.jsp">已办工单</a></li>
				            <li><a href="${pageContext.request.contextPath}/icp/include/tab3.jsp">办结工单</a></li>
				        </ul>
  					  </div>
  		    </div>

</body>
</html>