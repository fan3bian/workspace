<%@ page contentType="text/html; charset=utf-8" 
import="java.util.*"
	language="java" %>
	<%@ page import="com.inspur.icpmg.systemMg.vo.CorpInfoVo " %>
	<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.ServerWorkOrderVo " %>
	<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.ServerWorkOrderVo" %>
	<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.DbWorkOrderVo" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>申请资源查看</title>

</head>

<%
	List list = new ArrayList();
	list = (ArrayList)request.getAttribute("list");
	CorpInfoVo vo = (CorpInfoVo)request.getAttribute("vo");
	String flowid = (String)request.getAttribute("flowid");
	System.out.println("list.size="+list.size());
	System.out.println("flowid="+flowid);
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
}
.bg table tr td {
	background-color: #FFF;
	font-size: 16px;
}
</style>
<script>
	function redo(){
	    
		$("#details").parent().dialog('close');
	}
</script >
<div id="details" class="bg">

				<div style="height:10px"></div>

  <table width="95%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999" align="center">
    <tr align="center" class="header">
      <th height="60" colspan="6" bgcolor="#0B52D7" class="header" scope="col">客户需求表（云数据库）</th>
    </tr>
    <tr>
      <th colspan="6" align="left" scope="col">用户及应用信息</th>
    </tr>
    <tr>
      <td width="15%" align="center">用户单位</td>
      <td width="30%" align="center"><%=vo.getCmpyname() %></td>
      <td colspan="2" align="center">业务应用</td>
      <td colspan="2" align="center"><%=vo.getBizlic() %></td>
    </tr>
    <tr>
      <td align="center">联系人</td>
      <td align="center"><%=vo.getUname() %></td>
      <td width="14%" align="center">联系电话</td>
      <td width="10%" align="center"><%=vo.getMobile() %></td>
      <td width="6%" align="center">邮箱</td>
      <td width="15%" align="center"><%=vo.getEmail() %></td>
    </tr>
  </table>
  <table width="95%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999" align="center">
    <tr align="left">
      <th colspan="7" scope="col">云数据库配置</th>
    </tr>
    <tr>
      <td align="center"><strong>云数据库序号</strong></td>
      <td align="center"><strong>数据库类型</strong></td>
      <td align="center"><strong>数据库名称</strong></td>
      <td align="center"><strong>硬盘(G)</strong></td>
      <td align="center"><strong>操作系统</strong></td>
      <td align="center"><strong>备注</strong></td>
    </tr>
    <%
        for(int i=0;i<list.size();i++){
        DbWorkOrderVo vo1 =new  DbWorkOrderVo();
        vo1 = (DbWorkOrderVo)list.get(i);
        String str1 = vo1.getAuser();
        String str2 = 	String.valueOf(vo1.getRegionName());
        String str3 = 	String.valueOf(vo1.getDbname());
        String str4 = 	String.valueOf(vo1.getDisknum());
      //  String str5 = 	vo1.get();
        System.out.println("str1="+str1);
        %>
      <tr>
        <td align="center"><%=str1%></td>
      <td align="center">Oracle</td>
      <td align="center"><%=str3%></td>
      <td align="center"><%=str4%></td>
      <td align="center"><%%></td>
      <td align="center">&nbsp;</td>
      </tr>
      <%  
        }
     %><!--
    <tr>
      <td align="center">1</td>
      <td align="center">应用服务器1</td>
      <td align="center">2</td>
      <td align="center">2</td>
      <td align="center">50</td>
      <td align="center">Windows server 2008 64位</td>
      <td align="center">&nbsp;</td>
    </tr>
    <tr>
      <td align="center">2</td>
      <td align="center">应用服务器2</td>
      <td align="center">2</td>
      <td align="center">2</td>
      <td align="center">50</td>
      <td align="center">Windows server 2008 64位</td>
      <td align="center">&nbsp;</td>
    </tr>-->
  </table>
  <table width="95%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999" align="center">
  <!--   <tr align="left">
      <th colspan="7" scope="col">互联网资源需求</th>
    </tr>
    <tr>
      <td align="center"><strong>虚机序号*</strong></td>
      <td align="center"><strong>接入模式*</strong></td>
      <td align="center"><strong>公网IP（个）</strong></td>
      <td align="center"><strong>公网端口*</strong></td>
      <td align="center"><strong>杀毒软件*</strong></td>
      <td align="center"><strong>接入带宽（M）*</strong></td>
      <td align="center"><strong>备注</strong></td>
    </tr> -->
    
  
      <!--<td align="center">1</td>
      <td align="center">电信/联通</td>
      <td rowspan="2" align="center">2个</td>
      <td align="center">8000</td>
      <td align="center">9000</td>
      <td align="center">双线接入，负载均衡</td>
      <td align="center">4M</td>
    </tr>
    <tr>
      <td rowspan="2" align="center">2</td>
      <td rowspan="2" align="center">电信/联通</td>
      <td rowspan="2" align="center">8001</td>
      <td rowspan="2" align="center">9001</td>
      <td rowspan="2" align="center">双线接入，负载均衡</td>
      <td rowspan="2" align="center">4M</td>
    </tr>
    <tr>
      <td align="center">2个</td>
    </tr>
  --></table>
  
  <div style="height:10px"></div>
   <table width="90%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999">
    <tr align="right" >
    <input type="hidden" name="flowid"  id="flowid" value="<%=flowid %>" />
				<!--<a href="#" onClick="javascript:save();" class="easyui-linkbutton"
					data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;&nbsp; --><a
					href="#" onClick="javascript:redo();" class="easyui-linkbutton"
					data-options="iconCls:'icon-redo'">关闭</a>
					</tr>
					 </table>
</div>
</body>
</html>
