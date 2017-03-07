<%@ page contentType="text/html; charset=utf-8" 
import="java.util.*"
	language="java" %>
	<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.* " %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单退订资源表</title>

</head>
<%
	List list = new ArrayList();
	List list2 = new ArrayList();
	list = (ArrayList)request.getAttribute("list");
	list2 = (ArrayList)request.getAttribute("list2");
	String flowid = (String)request.getAttribute("flowid");
	String stepno = (String)request.getAttribute("stepno");
	String path = request.getContextPath();	
	System.out.println("list.size="+list.size());
	System.out.println("stepno="+stepno);
	String vpnuser="";
	String vpnpass= "";
	String ftpuser="";
	String ftppass= "";
	for(int i=0;i<list2.size();i++){
	   RemoteConfigVo vo = new RemoteConfigVo();
	   vo = (RemoteConfigVo)list2.get(i);
	   if(i==0){
	   vpnuser = vo.getUsername();
	   vpnpass = vo.getPass();
	   }else if(i==1){
	   ftpuser = vo.getUsername();
	   ftppass = vo.getPass();
	   }
	   
	}
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
	font-size: 16px;
	background-color: #FFF;
}
</style>
	<script >
	function save(){
			if ($('#tableform').form('validate')) {
				$('#submitBtn').linkbutton('disable');
			$('#tableform').form('submit',{
		    url:'<%=path%>/workorder/saveOrderCancel.do',
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
      <th height="60" colspan="15" bgcolor="#0B52D7" class="header" scope="col">生产服务订单</th>
    </tr>
    <tr >
      <th colspan="15" align="center" bgcolor="#66CCCC" class="bg" scope="col">云服务器配置</th>
    </tr>
    <tr>
      <td width="15%" align="center"><strong>虚机序号</strong></td>
      <td colspan="7" align="center"><strong>应用说明</strong></td>
      <td width="7%" align="center"><strong>CPU（核）</strong></td>
      <td width="9%" align="center"><strong>内存<br />
      (G)</strong></td>
      <td width="10%" align="center"><strong>硬盘<br />
(G)</strong></td>
      <td width="14%" align="center"><strong>操作系统<br />
      （甲方/乙方提供）</strong></td>
      <td width="12%" align="center"><strong>内网IP</strong></td>
      <td width="14%" align="center"><strong>管理账号</strong></td>
      <td width="12%" align="center"><strong>密码</strong></td>
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
        String str6 = 	vo1.getFlowtype();
         String str7 = 	vo1.getFlowtypename();
         String str8 = 	vo1.getFlowname();
        System.out.println("str1="+str1);
        %>
         <tr>
      <td align="center"><%=str1 %></td>
      <td colspan="7" align="center">应用说明<%=str1 %></td>
      <td align="center"><%=str2 %></td>
      <td align="center"><%=str3 %></td>
      <td align="center"><%=str4 %></td>
      <td align="center"><%=str5 %></td>
      <td align="center"><%=str6 %></td>
       <td align="center"><%=str7 %></td>
      <td align="center"><%=str8 %></td>
    </tr>
           <%
    }
     %>
    <tr>
      <td align="center">&nbsp;</td>
      <td colspan="7" align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
    </tr>
    <tr>
       <th colspan="15" align="center" bgcolor="#66CCCC" class="bg" scope="col">互联网资源及端口映射配置</th>
    </tr>
     <tr>
      <td width="15%" align="center"><strong>虚机序号</strong></td>
      <td colspan="7" align="center"><strong>接入模式</strong></td>
      <td width="7%" align="center"><strong>接入带宽（M）</strong></td>
      <td width="9%" align="center"><strong>公网IP</strong></td>
      <td width="10%" align="center"><strong>公网端口</strong></td>
      <td width="14%" align="center"><strong>内网端口</strong></td>
      <td width="12%" align="center"><strong>电信IP</strong></td>
      <td width="14%" align="center"><strong>联通IP</strong></td>
      <td width="12%" align="center"><strong>移动IP</strong></td>
    </tr>
     <%
    for(int i=0;i<list.size();i++){
     ServerWorkOrderVo vo1 =new  ServerWorkOrderVo();
        vo1 = (ServerWorkOrderVo)list.get(i);
        String str1 = vo1.getAuser();
        //接入模式
        String str2 = 	String.valueOf(vo1.getAtime());
        //接入带宽
        String str3 = 	String.valueOf(vo1.getInterbw());
        //公网ip数
        String str4 = 	String.valueOf(vo1.getIpnum());
        //公网端口
        String str5 = 	vo1.getCuserid();
        //内网端口
        String str6 = 	vo1.getCtime();
        //电信IP
         String str7 = 	vo1.getFtable();
        //联通ip
        String str8 = 	vo1.getFstatusid();
        //移动ip
        String str9 = 	vo1.getFtype();
       
       
        %>
    <tr>
      <td align="center"><%=str1 %></td>
      <td colspan="7" align="center"><%=str2 %></td>
     
      <td align="center"><%=str3 %></td>
      <td align="center"><%=str4 %></td>
      <td align="center"><%=str5 %></td>
      <td align="center"><%=str6 %></td>
       <td align="center"><%=str7 %></td>
       <td align="center"><%=str8 %></td>
       <td align="center"><%=str9 %></td>
   
    </tr>
            <%
    }
     %>
    <tr>
      <td align="center">&nbsp;</td>
      <td colspan="7" align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
    </tr>
    </table>
    <table width="100%" border="1" cellspacing="0" cellpadding="0">
    <tr>
       <th colspan="6" align="center" bgcolor="#66CCCC" class="bg" scope="col">远程vpn访问信息</th>
       <th colspan="2" align="center" bgcolor="#66CCCC" class="bg" scope="col">FTP配置信息</th>
      </tr>
     <tr>
      <td width="23%" align="center"><strong>登陆地址</strong><strong></strong></td>
      <td width="5%" colspan="-6" align="center"><strong>用户名</strong></td>
      <td width="7%" colspan="-6" align="center"><strong>密码</strong></td>
      <td width="25%" colspan="-5" align="center"><strong>登陆地址</strong></td>
      <td width="10%" colspan="-6" align="center"><strong>用户名</strong></td>
      <td width="10%" colspan="-6" align="center"><strong>密码</strong></td>
      <td width="20%" colspan="-6" align="center"><strong>其他</strong></td>
    </tr>
    <tr>
      <td rowspan="2" align="center"><a>3085024126@yimihome.com</a></td>
      <td colspan="-6" align="center"><%=vpnuser %></td>
      <td colspan="-6" align="center"><%=vpnpass %></td>
      <td colspan="-5" rowspan="2" align="center"><a>3085024126@yimihome.com</a></td>
      <td colspan="-6" align="center"><%=ftpuser %></td>
      <td colspan="-6" align="center"><%=ftppass %></td>
      <td colspan="-6" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="-6" align="center">&nbsp;</td>
      <td colspan="-6" align="center">&nbsp;</td>
      <td colspan="-6" align="center">&nbsp;</td>
      <td colspan="-6" align="center">&nbsp;</td>
      <td colspan="-6" align="center">&nbsp;</td>
    </tr>
  </table>
   <div style="height:10px"></div>
   <table width="90%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999">
    <tr align="right" >
    <input type="hidden" name="flowid"  id="flowid" value="<%=flowid %>" />
    <input type="hidden" name="stepno"  id="stepno" value="<%=stepno %>" />
				<a href="#" onClick="javascript:save();" class="easyui-linkbutton"
					data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;&nbsp; <a
					href="#" onClick="javascript:redo();" class="easyui-linkbutton"
					data-options="iconCls:'icon-redo'">关闭</a>
					</tr>
					 </table>
					 <div style="height:10px"></div>
					 <div style="height:10px"></div>
					 </form>
</div>
</body>
</html>