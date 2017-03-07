<%@ page contentType="text/html; charset=utf-8" 
import="java.util.*"
	language="java" %>
	<%@ page import="com.inspur.icpmg.systemMg.vo.CorpInfoVo " %>
	<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.ServerWorkOrderVo " %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>申请资源查看</title>

</head>

<%
	List list = new ArrayList();
	list = (ArrayList)request.getAttribute("list");
	CorpInfoVo vo = (CorpInfoVo)request.getAttribute("vo");
	String flowid = (String)request.getAttribute("flowid");
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
      <th height="60" colspan="6" bgcolor="#0B52D7" class="header" scope="col">客户需求表（云服务器）</th>
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
 
  <table id="baseinfo" width="95%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999" align="center">
    <tr align="left">
      <th colspan="7" scope="col">云服务器配置</th>
    </tr>
    <tr>
      <td align="center"><strong>虚机序号</strong></td>
      <td align="center"><strong>应用类型</strong></td>
      <td align="center"><strong>CPU（核）</strong></td>
      <td align="center"><strong>内存（G)</strong></td>
      <td align="center"><strong>硬盘(G)</strong></td>
      <td align="center"><strong>操作系统</strong></td>
      <td align="center"><strong>备注</strong></td>
    </tr>
    <%
        for(int i=0;i<list.size();i++){
        ServerWorkOrderVo vo1 =new  ServerWorkOrderVo();
        vo1 = (ServerWorkOrderVo)list.get(i);
        String detailid = vo1.getDetailid();
        String cpunum = 	String.valueOf(vo1.getCpunum());
        String memnum = 	String.valueOf(vo1.getMemnum());
        String disknum = 	String.valueOf(vo1.getDisknum());
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
      <%=disknum%><input value="<%=disknum%>"  type="hidden" name="serverWorkOrderVoList[<%=Integer.valueOf(detailid)-1 %>].Disknum"  />
      </td>
      <td align="center"><%=osname%>
       <input value="<%=osname%>"  type="hidden" name="serverWorkOrderVoList[<%=Integer.valueOf(detailid)-1 %>].osname"  />
      </td>
      <td align="center"><%-- <a  onclick="editdetil(<%=vo1.getOrderid() %>, <%=vo1.getDetailid() %>, '', '', '')">修改</a> --%></td>
      </tr>
      <%  
        }
     %>
  </table>
  <table width="95%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999" align="center">
    <tr align="left">
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
      <td align="center"></td>
      </tr>
      <%  
        }
     %>
     </table>
  
  <div style="height:10px"></div>
   <table width="90%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999">
    <tr align="right" >
    <input type="hidden" name="flowid"  id="flowid" value="<%=flowid %>" />
				<!--<a href="#" id="listsave" class="easyui-linkbutton"
					data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;&nbsp;--><a
					href="#" onClick="javascript:redo();" class="easyui-linkbutton"
					data-options="iconCls:'icon-redo'">关闭</a>
					</tr>
	</table>
</div>
</body>
</html>
