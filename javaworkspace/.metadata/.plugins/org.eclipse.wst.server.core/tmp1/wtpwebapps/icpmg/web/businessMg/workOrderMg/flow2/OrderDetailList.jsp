<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!-- tcyi -->
<%@ page contentType="text/html; charset=utf-8" 
import="java.util.*"
	language="java" %>
	<%@ page import="com.inspur.icpmg.systemMg.vo.CorpInfoVo " %>
	<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.ServerWorkOrderVo " %>	
	<!--tcyi-->	
	<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.* " %>
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>申请资源查看</title>

</head>

<%
	List list = new ArrayList();
	list = (ArrayList)request.getAttribute("list");
	CorpInfoVo vo = (CorpInfoVo)request.getAttribute("vo");
	String flowid = (String)request.getAttribute("flowid");
	//tcyi
	FlowStepDetailVo vo2 = new FlowStepDetailVo();	
	vo2 = (FlowStepDetailVo)request.getAttribute("vo2");
 %>

<body>
  <script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery-1.8.3.min.js"></script>
  
  <script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery.easyui.min.js" ></script>
  <link href="${pageContext.request.contextPath}/easyui-1.4/themes/default/easyui.css" rel="stylesheet" type="text/css" />
  <link href="${pageContext.request.contextPath}/easyui-1.4/themes/icon.css" rel="stylesheet" type="text/css" /> 
  
<style type="text/css">
body {
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
}
.content {
	font-family: "微软雅黑", "华文细黑", "时尚中黑简体",;
	font-size: 12px;
	color: #333;
	margin-top: 5px;
	margin-right: auto;
	margin-bottom: 20px;
	margin-left: auto;
	width: 100%;
}
.content .title {
	font-family: "微软雅黑", "宋体", "时尚中黑简体";
	font-size: 16px;
	color: #FFF;
	height: 45px;
	background-color: #25b7de;
	line-height: 45px;
	padding-left: 20px;
	overflow: hidden;
}
.content .subtitle {
	border-left-width: 5px;
	border-left-style: solid;
	border-left-color: #25b7de;
	margin-top: 5px;
	margin-bottom: 5px;
	line-height: 25px;
	padding-left: 20px;
	color: #25b7de;
	font-size: 14px;
	
}
.content .table {
}
.content .table table {
	text-align: left;
}
.content .table table tbody tr {
height: 10px;
}
.content .table table tr td {
	padding-left: 20px;
	border: 1px solid #e8e8e8;
	height: 5px;
	line-height: 20px;
}
.content .table2 {
}
.content .table2 table tbody tr {
height: 10px;
}
.content .table2 table tr td {
	border: 1px solid #e8e8e8;
	height: 5px;
	text-align: center;
	line-height: 20px;
}
.content .table2 table tr th {
	height: 5px;
	line-height: 20px;
	background-color: #f0f0f0;
	border: 1px solid #e8e8e8;
}
.content .table2 table tr td a {
	color: #25b7de;
	list-style-type: none;
}
a:link {
	text-decoration: none;
}
a:visited {
	text-decoration: none;
}
a:hover {
	text-decoration: none;
}
a:active {
	text-decoration: none;
}
</style>
<script>
	function redo(){
	    
		$("#details").parent().dialog('close');
	}
</script >
<div id="details" class="content"  >
 <div class="title">客户需求表（云服务器）</div>
  <div class="subtitle">用户及应用信息</div>
    <div class="table">
  <table   width="98%"  align="center" >

    <tr>
      <td width="15%" align="center" bgcolor="#f0f0f0" scope="row">用户单位</td>
      <td width="30%" align="center"><%=vo.getCmpyname() %></td>
      <td colspan="2" align="center" bgcolor="#f0f0f0">业务应用</td>
      <td colspan="2" align="center"><%=vo.getBizlic() %></td>
    </tr>
    <tr>
      <td align="center" bgcolor="#f0f0f0">联系人</td>
      <td align="center"><%=vo.getUname() %></td>
      <td width="14%" align="center" bgcolor="#f0f0f0">联系电话</td>
      <td width="10%" align="center"><%=vo.getMobile() %></td>
      <td width="6%" align="center" bgcolor="#f0f0f0">邮箱</td>
      <td width="15%" align="center"><%=vo.getEmail() %></td>
    </tr>
  </table>
  </div>
  <div class="subtitle">云服务器配置</div>
  <form action="${pageContext.request.contextPath}/workorder/flowHandler.do" id="listhandlerform" method="post">
   <div class="table2">
  <table id="baseinfo" width="98%" align="center" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <th align="center" scope="col"><strong>虚机序号</strong></th>
      <th scope="col" align="center"><strong>应用类型</strong></th>
      <th align="center" scope="col"><strong>CPU（核）</strong></th>
      <th align="center" scope="col"><strong>内存（G)</strong></th>
      <th align="center" scope="col"><strong>硬盘(G)</strong></th>
      <th align="center" scope="col"><strong>操作系统</strong></th>
      <th align="center" scope="col"><strong>操作</strong></th>
    </tr>
    <%
        for(int i=0;i<list.size();i++){
        ServerWorkOrderVo vo1 =new  ServerWorkOrderVo();
        vo1 = (ServerWorkOrderVo)list.get(i);
        String detailid = vo1.getDetailid();
        String cpunum = 	String.valueOf(vo1.getCpunum());
        String memnum = 	String.valueOf(vo1.getMemnum());
        String disknum = 	String.valueOf(vo1.getDisknum());
        String diskNumDisplay = vo1.getDiskDisplayStr();
        String osname = 	vo1.getOsname();
        %>
      <tr>
        <td align="center"><%=detailid%></td>
      <td align="center" id="detail<%=detailid%>">应用服务器<%=detailid%>
      <input  value="<%=detailid%>" type="hidden" name="serverWorkOrderVoList[<%=Integer.valueOf(detailid)-1 %>].detailid" />
      </td>
      <td align="center" id="cpunum<%=detailid%>">
      	<%=cpunum%>
       <input  value="<%=cpunum%>" type="hidden" name="serverWorkOrderVoList[<%=Integer.valueOf(detailid)-1 %>].cpunum" />
       </td>
      <td align="center" id="memnum<%=detailid%>">
      <%=memnum%> <input value="<%=memnum%>"  type="hidden" name="serverWorkOrderVoList[<%=Integer.valueOf(detailid)-1 %>].memnum"  />
      </td>
      <td align="center">
      <%=diskNumDisplay%><input value="<%=disknum%>"  type="hidden" name="serverWorkOrderVoList[<%=Integer.valueOf(detailid)-1 %>].Disknum"  />
      </td>
      <td align="center"><%=osname%>
       <input value="<%=osname%>"  type="hidden" name="serverWorkOrderVoList[<%=Integer.valueOf(detailid)-1 %>].osname"  />
      </td>
      <td align="center">
      <!--tcyi-->
      	  <c:if test="${ 1 eq vo2.iseditconfig}">
	      	 <a  onclick="editdetil('<%=vo1.getOrderid() %>', '<%=vo1.getDetailid() %>', '', '', '')">修改</a>
	      </c:if>
      </td>
      </tr>
      <%  
        }
     %>
  </table>
  </div>
   <div class="subtitle">互联网资源需求</div>
   <div class="table2">
  <table width="98%" border="0" cellpadding="0" cellspacing="0"  align="center">
    <tr>
      <th align="center"><strong>虚机序号</strong></th>
      <th align="center"><strong>接入模式</strong></th>
      <th align="center"><strong>公网IP（个）</strong></th>
      <th align="center"><strong>公网端口</strong></th>
      <th align="center"><strong>杀毒软件</strong></th>
      <th align="center"><strong>接入带宽（M）</strong></th>
      <th align="center"><strong>操作</strong></th>
    </tr>
    
     <%
        for(int i=0;i<list.size();i++){
        ServerWorkOrderVo vo1 =new  ServerWorkOrderVo();
        vo1 = (ServerWorkOrderVo)list.get(i);
        String imode = vo1.getImode();
        String detailid = vo1.getDetailid();
        String ipnum = 	String.valueOf(vo1.getIpnum());
        String interport = 	vo1.getInterport();
       // String str5 = 	vo1.getInterport();
        String virusName = 	vo1.getVirusName();
        String interbw = 	vo1.getInterbw();
        String str = "";		
        if(imode.endsWith("电信单线")){
          str = "电信";
        }else if(imode.endsWith("联通单线")){
         str = "联通";
        }else if(imode.endsWith("移动单线")){
        str = "移动";
        }else if(imode.endsWith("双线接入")){
        str = "电信/联通";
        }else if(imode.endsWith("三线接入")){
        str = "电信/联通/移动";
        }
        %>
      <tr>
        <td align="center"><%=detailid%></td>
      <td align="center"><%=imode%></td>
      <td align="center"><%=ipnum%></td>
      <td align="center"><%=interport%></td>
      <td align="center"><%=virusName%></td>
      <td align="center"><%=interbw%></td>
      <td align="center">
          <c:if test="${ 1 eq vo2.iseditconfig}">
              <a  onclick="editdetil('<%=vo1.getOrderid() %>', '<%=vo1.getDetailid() %>', '', '', '')">修改</a>
          </c:if>
      </td>
      </tr>
      <%  
        }
     %>
     </table>
  </div>

   <c:if test="${1 eq vo2.iseditprice}">
   <div class="subtitle">数量时长信息</div>
    <div class="table2">
  <table width="98%" border="0" cellpadding="0" cellspacing="0"  align="center">
    <tr>
 	<th width="15%" rowspan="1" align="center" bgcolor="#66CC99"><strong>虚拟机序号</strong></th>
      <!-- <th colspan="1" align="center"><strong>配置说明</strong></th> -->
      <th width="7%" rowspan="1" align="center"><strong>时长(月)</strong></th>
      <th width="9%" rowspan="1" colspan="2" align="center"><strong>单价(元/月)</strong></th>
      <th width="10%" rowspan="1" align="center"><strong>数量</strong></th>
      <th width="10%" rowspan="1" align="center"><strong>订单价</strong></th>
      <th width="14%" rowspan="1" colspan="2" align="center"><strong>审批后总价(元)</strong></th>
    </tr>
     <%
     	float orderTotalPrice = 0.0F;
        for(int i=0;i<list.size();i++){
        ServerWorkOrderVo vo1 =new  ServerWorkOrderVo();
        vo1 = (ServerWorkOrderVo)list.get(i);
        String detailid = vo1.getDetailid();
        orderTotalPrice +=Float.valueOf(vo1.getSnote());
        %>
    <tr>
      <td align="center">应用服务器<%=detailid%></td>
      <td align="center"><%=vo1.getTlong()%></td>
      <td align="center" colspan="2"><%=vo1.getTprice()%></td>
      <td align="center"><%=vo1.getServernum()%></td>
      <td align="center"><%=vo1.getTprice()*Integer.parseInt(vo1.getTlong())%></td>
      <td align="center" colspan="2"><%=vo1.getApirce()%></td>
    </tr>
   
    <%} %>
   </table>
    </div>
      </c:if>
</div>
<script type="text/javascript">

	
	function editdetil(orderid, detailid, vtable, pname, shopid) {
	    var url = "${pageContext.request.contextPath}/workorder/getOrderChangeMxPz.do?orderid="+orderid+"&detailid="+detailid;
	  //  data : {'orderid' : orderid, 'detailid' : detailid, 'vtable' : vtable, 'pname' : pname},
	    var title = "申请资源修改";
	    
	    var mainTab =  window.parent.$("#centerTab").find("#tabs");
	    var currentTab = mainTab.tabs("getSelected");
	    var index = mainTab.tabs('getTabIndex',currentTab);
	    
	    addTab(title,url,index); 
	}
	function addTab(title, url,index) {
		 var maintab = window.parent.$("#centerTab").find("#tabs");
		//var tabs =$("#centerTab").find("#tabs");
	    if ( maintab.tabs('exists', title)) {
	    	maintab.tabs('select', title);
	    } else {
	    	//console.log($("#tabs-1"));
	        var content = '<iframe id="details" scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:99%;"></iframe>';
	        maintab.tabs('add', {
	        	id:'orderdetails',
	            title: title,
	            content: content,
	            closable: true,
	            onClose:function (title ,newindex){
	            	maintab.tabs('select',index);
	            }
	          
	        });
	        
	        maintab.tabs('select', title);
	    }
	}
	
	</script>
</body>
</html>
