<%@ page contentType="text/html; charset=utf-8" 
import="java.util.*"
	language="java" %>
	<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.ServerWorkOrderVo " %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单价格审核</title>

</head>
<%
	List list = new ArrayList();
	list = (ArrayList)request.getAttribute("list");
	String sumPrice = (String)request.getAttribute("sumPrice");
	String flowid = (String)request.getAttribute("flowid");
	String stepno = (String)request.getAttribute("stepno");
	String path = request.getContextPath();	
 %>
<body>
<style type="text/css">
body {
	margin-left: 10px;
	margin-top: 30px;
	margin-right: 10px;
}
.bg .header {
	font-family: "华文细黑", "时尚中黑简体", "微软雅黑";
	font-size: 18px;
	background-color: #36C;
	height: 60px;
	color: #FFF;
	text-align: center;
	font-weight: bolder;
}
.bg table {
}
.bg table tr td strong {
}
.bg table tr {
	background-color: #39C;
	font-size: 18px;
	font-family: "华文细黑", "时尚中黑简体", "微软雅黑";
}
.bg table tr td {
	background-color: #FFF;
	font-size: 16px;
}
</style>
<script>
function save(){
			if ($('#tableform').form('validate')) {
				$('#submitBtn').linkbutton('disable');
			$('#tableform').form('submit',{
		    url:'<%=path%>/workorder/saveOrderDetailServer.do',
		    onSubmit: function(){
		    },
		    success:function(data){
				
				alert("保存成功！！！");
		    }
		});
		}
		//$('#editForm').submit();	
		$("#details").parent().dialog('close');
	}	
	
	function redo(){
	    
		$("#details").parent().dialog('close');
	}
</script >
<div id="details" class="bg">
<form id="tableform" method="post">
  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999">
    <tr align="center"class="header">
      <th height="60" colspan="12" bgcolor="#0B52D7" class="header" scope="col">云服务器报价单</th>
    </tr>
    <tr >
      <th colspan="12" align="left" class="bg" scope="col">用户及应用信息</th>
    </tr>
    <tr>
      <td width="15%" rowspan="2" align="center" bgcolor="#66CC99"><strong>应用说明</strong></td>
      <td colspan="7" align="center"><strong>配置说明</strong></td>
      <td width="7%" rowspan="2" align="center"><strong>时长(月)</strong></td>
      <td width="9%" rowspan="2" align="center"><strong>单价<br />(元/月)</strong></td>
      <td width="10%" rowspan="2" align="center"><strong>数量</strong></td>
      <td width="14%" rowspan="2" align="center"><strong>年服务费小计<br />(元)</strong></td>
    </tr>
    <tr>
      <td width="5%" align="center"><strong>CPU<br />(核)</strong></td>
      <td width="4%" align="center"><strong>内存<br />(G)</strong></td>
      <td width="4%" align="center"><strong>硬盘<br />(G)</strong></td>
      <td width="14%" align="center"><strong>操作系统</strong></td>
      <td width="4%" align="center"><p><strong>带宽(Mb)</strong></p></td>
      <td width="7%" align="center"><p><strong>接入模式</strong></p></td>
      <td width="7%" align="center"><strong>ip数量<br />(个)</strong></td>
    </tr>
     <%
        for(int i=0;i<list.size();i++){
        ServerWorkOrderVo vo1 =new  ServerWorkOrderVo();
        vo1 = (ServerWorkOrderVo)list.get(i);
        String str1 = vo1.getAuser();
        String str2 = 	String.valueOf(vo1.getCpunum());
        String str3 = 	String.valueOf(vo1.getMemnum());
        String str4 = 	String.valueOf(vo1.getDisknum());
        String str5 = 	vo1.getOsname();
        System.out.println("str1="+str1);
        %>
    <tr>
      <td align="center">应用服务器<%=vo1.getAuser()%></td>
      <td align="center"><%=vo1.getCpunum()%></td>
      <td align="center"><%=vo1.getMemnum()%></td>
      <td align="center"><%=vo1.getDisknum()%></td>
      <td align="center"><%=vo1.getOsname()%></td>
      <td align="center"><%=vo1.getInterbw()%></td>
      <td align="center"><%=vo1.getAtime()%></td>
      <td align="center"><%=vo1.getIpnum()%></td>
      <td align="center"><%=vo1.getTlong()%></td>
      <td align="center"><%=vo1.getTprice()%></td>
      <td align="center"><%=vo1.getStepno()%></td>
      <td align="center"><%=vo1.getSnote()%></td>
    </tr>
    <%} %>
   <tr>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="8" rowspan="2" align="center"><strong>资费合计（元）</strong></td>
      <td colspan="4" align="center"><strong><%=sumPrice %></strong></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><strong>折扣</strong></td>
      <td align="center">
        <select name="agio" id="agio"style="width:100%">
         <option value="0">请选择</option>
          <option value="0.1">10%</option>
           <option value="0.15">15%</option>
          <option value="0.2">20%</option>
           <option value="0.25">25%</option>
          <option value="0.3">30%</option>
          <option value="0.35">35%</option>
          <option value="0.4">40%</option>
        </select>
     </td>
      <td align="center"><strong><%=sumPrice %></strong></td>
    </tr>
  </table>
   <div style="height:10px"></div>
   <table width="90%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999">
    <tr align="right" >
    <input type="hidden" name="flowid"  id="flowid" value="<%=flowid %>" />
    <input type="hidden" name="stepno"  id="stepno" value="<%=stepno %>" />
				<a href="#" onClick="javascript:save();" class="easyui-linkbutton"
					data-options="iconCls:'icon-save'">保存1</a>&nbsp;&nbsp;&nbsp; <a
					href="#" onClick="javascript:redo();" class="easyui-linkbutton"
					data-options="iconCls:'icon-redo'">关闭</a>
					</tr>
			 </table>
					 </form>
</div>
</body>
</html>
