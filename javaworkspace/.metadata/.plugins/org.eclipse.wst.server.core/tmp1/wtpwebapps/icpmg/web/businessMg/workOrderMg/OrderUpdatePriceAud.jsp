<%@ page contentType="text/html; charset=utf-8" 
import="java.util.*"
	language="java" %>
	<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>变更资源表</title>

</head>
<%
	List list = new ArrayList();
	List list2 = new ArrayList();
	Map<String, Object> paramMap = new HashMap<String, Object>(); 
	list = (ArrayList)request.getAttribute("list");
	list2 = (ArrayList)request.getAttribute("list2");
	paramMap = (Map)request.getAttribute("paramMap");
	String flowid = (String)request.getAttribute("flowid");
	String stepno = (String)request.getAttribute("stepno");
	String path = request.getContextPath();	
	System.out.println("list.size="+list.size());
	System.out.println("list2.size="+list2.size());
	System.out.println("stepno="+stepno);
	String vpnuser="";
	String vpnpass= "";
	String ftpuser="";
	String ftppass= "";
	String ftpaddress="";
	String vpnaddress= "";
	for(int i=0;i<list2.size();i++){
	   RemoteConfigVo vo = new RemoteConfigVo();
	   vo = (RemoteConfigVo)list2.get(i);
	   if(i==0){
	   vpnuser = vo.getUsername();
	   vpnpass = vo.getPass();
	   vpnaddress = vo.getAddress();
	   }else if(i==1){
	   ftpuser = vo.getUsername();
	   ftppass = vo.getPass();
	   ftpaddress = vo.getAddress();
	   }
	   
	}
	System.out.println("vpnaddress="+vpnaddress);
	System.out.println("ftpaddress="+ftpaddress);
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
}
</style>
<script>	
	function redo(){
	    
		$("#details").parent().dialog('close');
	}
</script >
<div id="details" class="bg">
  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
    <tr align="center"class="header">
      <th height="60" colspan="13" bgcolor="#0B52D7" class="header" scope="col">生产服务订单</th>
    </tr>
    <tr >
      <th colspan="13" align="left" class="bg" scope="col">第一部分：配置信息</th>
    </tr>
    <tr >
      <th colspan="13" align="center" bgcolor="#66CCCC" class="bg" scope="col">云服务器配置</th>
    </tr>
    <tr>
      <td width="8%" align="center" bgcolor="#FFFFFF"><strong>虚机序号</strong></td>
      <td width="15%" align="center" bgcolor="#FFFFFF"><strong>信息类型</strong></td>
      <td width="15%" align="center" bgcolor="#FFFFFF"><strong>应用说明</strong></td>
      <td width="8%" align="center" bgcolor="#FFFFFF"><strong>CPU（核）</strong></td>
      <td width="8%" align="center" bgcolor="#FFFFFF"><strong>内存<br />
      (G)</strong></td>
      <td width="10%" align="center" bgcolor="#FFFFFF"><strong>硬盘<br />
(G)</strong></td>
      <td colspan="2" align="center" bgcolor="#FFFFFF"><strong>操作系统<br />
      （甲方/乙方提供）</strong></td>
    </tr>
      <%
      String labelName = "更新";
    for(int i=0;i<list.size();i++){
     ServerWorkOrderVo vo1 =new  ServerWorkOrderVo();
        vo1 = (ServerWorkOrderVo)list.get(i);
        String str1 = vo1.getAuser();
        String str2 = 	String.valueOf(vo1.getCpunum());
        String str3 = 	String.valueOf(vo1.getMemnum());
        String str4 = 	String.valueOf(vo1.getDisknum());
        String str5 = 	vo1.getOsname();
        String status = String.valueOf(vo1.getIsvalid());
        System.out.println("str1="+str1);
         if(status.endsWith("3")){
         str1 = vo1.getAuser();
         str2 = "";
         str3 = "";
         str4 = "";
         str5 = "";
         labelName = "注销";
         }
         String str11 = "";
        String str21 = 	"";
        String str31 = "";
        String str41 = 	"";
        String str51 = 	"";
         ServerWorkOrderVo vo2 =new  ServerWorkOrderVo();
         vo2 = (ServerWorkOrderVo)paramMap.get(str1);
        
         str11 = vo2.getAuser();
         str21 = 	String.valueOf(vo2.getCpunum());
         str31 = 	String.valueOf(vo2.getMemnum());
         str41 = 	String.valueOf(vo2.getDisknum());
         str51 = 	vo2.getOsname();
       
        
        if(i%2==0){
        %>
    <tr>
      <td align="center" bgcolor="#EAEAEA"><%=i+1 %></td>
      <td align="center" bgcolor="#EAEAEA">原始</td>
      <td  align="center" bgcolor="#EAEAEA">应用服务器<%=str11 %></td>
      <td align="center" bgcolor="#EAEAEA"><%=str21 %></td>
      <td align="center" bgcolor="#EAEAEA"><%=str31 %></td>
      <td align="center" bgcolor="#EAEAEA"><%=str41 %></td>
      <td colspan="2" align="center" bgcolor="#EAEAEA"><%=str51 %></td>
    </tr>
   
    
     <tr>
      <td align="center" bgcolor="#EAEAEA"><%=i+1 %></td>
      <td align="center" bgcolor="#EAEAEA"><%=labelName %></td>
      <td  align="center" bgcolor="#EAEAEA">应用服务器<%=str1 %></td>
      <td align="center" bgcolor="#EAEAEA"><%=str2 %></td>
      <td align="center" bgcolor="#EAEAEA"><%=str3 %></td>
      <td align="center" bgcolor="#EAEAEA"><%=str4 %></td>
      <td colspan="2" align="center" bgcolor="#EAEAEA"><%=str5 %></td>
    </tr>
    
           <%
    }else{
    
      %>
       <tr>
      <td align="center" bgcolor="#FFFFFF"><%=i+1 %></td>
      <td align="center" bgcolor="#FFFFFF">原始</td>
      <td  align="center" bgcolor="#FFFFFF">应用服务器<%=str11 %></td>
      <td align="center" bgcolor="#FFFFFF"><%=str21 %></td>
      <td align="center" bgcolor="#FFFFFF"><%=str31 %></td>
      <td align="center" bgcolor="#FFFFFF"><%=str41 %></td>
      <td colspan="2" align="center" bgcolor="#FFFFFF"><%=str51 %></td>
    </tr>
     <tr>
      <td align="center" bgcolor="#FFFFFF"><%=i+1 %></td>
      <td align="center" bgcolor="#FFFFFF"><%=labelName %></td>
      <td  align="center" bgcolor="#FFFFFF">应用服务器<%=str1 %></td>
      <td align="center" bgcolor="#FFFFFF"><%=str2 %></td>
      <td align="center" bgcolor="#FFFFFF"><%=str3 %></td>
      <td align="center" bgcolor="#FFFFFF"><%=str4 %></td>
      <td colspan="2" align="center" bgcolor="#FFFFFF"><%=str5 %></td>
    </tr>
    <%  
    }
    }
     %>
   
    <tr>
      <td align="center" bgcolor="#EAEAEA">&nbsp;</td>
      <td  align="center" bgcolor="#EAEAEA">&nbsp;</td>
      <td  align="center" bgcolor="#EAEAEA">&nbsp;</td>
      <td align="center" bgcolor="#EAEAEA">&nbsp;</td>
      <td align="center" bgcolor="#EAEAEA">&nbsp;</td>
      <td align="center" bgcolor="#EAEAEA">&nbsp;</td>
      <td colspan="2" align="center" bgcolor="#EAEAEA">&nbsp;</td>
    </tr>
    <tr>
       <th colspan="13" align="center" bgcolor="#66CCCC" class="bg" scope="col">互联网资源及端口映射配置</th>
    </tr>
     <tr>
      <td width="15%" align="center" bgcolor="#FFFFFF"><strong>虚机序号</strong></td>
       <td width="15%" align="center" bgcolor="#FFFFFF"><strong>信息类型</strong></td>
      <td colspan="2" align="center" bgcolor="#FFFFFF"><strong>接入模式</strong></td>
      <td width="8%" align="center" bgcolor="#FFFFFF"><strong>公网IP（个）</strong></td>
      <td width="8%" align="center" bgcolor="#FFFFFF"><strong>公网端口*</strong></td>
      <td width="10%" align="center" bgcolor="#FFFFFF"><strong>内网端口*</strong></td>
      <td width="13%" align="center" bgcolor="#FFFFFF"><strong>接入带宽（M）</strong></td>
      
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
        //String str6 = 	vo1.getCtime();
            
         String status = String.valueOf(vo1.getIsvalid());
        System.out.println("str1="+str1);
        
        if(status.endsWith("3")){
         str1 = vo1.getAuser();
         str2 = "";
         str3 = "";
         str4 = "";
         str5 = "";
         labelName = "注销";
         }
          String str11 = "";
        //接入模式
        String str21 = 	"";
        //接入带宽
        String str31 = 	"";
        //公网ip数
        String str41 = 	"";
        //公网端口
        String str51 = 	"";
        //内网端口
       // String str61 = "";
         ServerWorkOrderVo vo2 =new  ServerWorkOrderVo();
         vo2 = (ServerWorkOrderVo)paramMap.get(str1);
           
           str11 = vo2.getAuser();
        //接入模式
         str21 = 	String.valueOf(vo2.getAtime());
        //接入带宽
         str31 = 	String.valueOf(vo2.getInterbw());
        //公网ip数
         str41 = 	String.valueOf(vo2.getIpnum());
        //公网端口
         str51 = 	vo2.getCuserid();
        //内网端口
        // str61 = 	vo2.getCtime();
        
        if(i%2==0){
        %>
    <tr>
       <td align="center" bgcolor="#EAEAEA"><%=i+1 %></td>
       <td align="center" bgcolor="#EAEAEA">原始</td>
       <td colspan="2" align="center" bgcolor="#EAEAEA"><%=str21 %></td>
       <td align="center" bgcolor="#EAEAEA"><%=str41 %></td>
       <td align="center" bgcolor="#EAEAEA"><%=str51 %></td>
       <td align="center" bgcolor="#EAEAEA"><%=str51 %></td>
       <td align="center" bgcolor="#EAEAEA"><%=str31 %></td>

    </tr>
     <tr>
       <td align="center" bgcolor="#EAEAEA"><%=i+1 %></td>
        <td align="center" bgcolor="#EAEAEA"><%=labelName %></td>
       <td colspan="2" align="center" bgcolor="#EAEAEA"><%=str2 %></td>
       <td align="center" bgcolor="#EAEAEA"><%=str4 %></td>
       <td align="center" bgcolor="#EAEAEA"><%=str5 %></td>
       <td align="center" bgcolor="#EAEAEA"><%=str5 %></td>
       <td align="center" bgcolor="#EAEAEA"><%=str3 %></td>
       
    </tr>
            <%
    }else{
    
      %>
       <tr>
       <td align="center" bgcolor="#FFFFFF"><%=i+1 %></td>
       <td align="center" bgcolor="#FFFFFF">原始</td>
       <td colspan="2" align="center" bgcolor="#FFFFFF"><%=str21 %></td>
       <td align="center" bgcolor="#FFFFFF"><%=str41 %></td>
       <td align="center" bgcolor="#FFFFFF"><%=str51 %></td>
       <td align="center" bgcolor="#FFFFFF"><%=str51 %></td>
       <td align="center" bgcolor="#FFFFFF"><%=str31 %></td>
       
    </tr>
     <tr>
       <td align="center" bgcolor="#FFFFFF"><%=i+1 %></td>
         <td align="center" bgcolor="#FFFFFF"><%=labelName %></td>
       <td colspan="2" align="center" bgcolor="#FFFFFF"><%=str2 %></td>
       <td align="center" bgcolor="#FFFFFF"><%=str4 %></td>
       <td align="center" bgcolor="#FFFFFF"><%=str5 %></td>
       <td align="center" bgcolor="#FFFFFF"><%=str5 %></td>
       <td align="center" bgcolor="#FFFFFF"><%=str3 %></td>
      
    </tr>
      <%  
    }
    }
     %>
    <tr>
       <td align="center" bgcolor="#EAEAEA">&nbsp;</td>
       <td  align="center" bgcolor="#EAEAEA">&nbsp;</td>
       <td colspan="2" align="center" bgcolor="#EAEAEA">&nbsp;</td>
       <td align="center" bgcolor="#EAEAEA">&nbsp;</td>
       <td align="center" bgcolor="#EAEAEA">&nbsp;</td>
       <td align="center" bgcolor="#EAEAEA">&nbsp;</td>
       <td align="center" bgcolor="#EAEAEA">&nbsp;</td>
    </tr>
  </table><!--
    <div align="center">
      <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
        <tr>
          <th colspan="3" align="center" bgcolor="#66CCCC" class="bg" scope="col">远程vpn访问信息</th>
          <th colspan="5" align="center" bgcolor="#66CCCC" class="bg" scope="col">FTP配置信息</th>
        </tr>
        <tr>
          <td width="23%" align="center" bgcolor="#FFFFFF"><strong>登陆地址</strong><strong></strong></td>
          <td width="5%" colspan="-6" align="center" bgcolor="#FFFFFF"><strong>用户名</strong></td>
          <td width="7%" colspan="-6" align="center" bgcolor="#FFFFFF"><strong>密码</strong></td>
          <td width="25%" colspan="-5" align="center" bgcolor="#FFFFFF"><strong>登陆地址</strong></td>
          <td width="10%" colspan="-6" align="center" bgcolor="#FFFFFF"><strong>用户名</strong></td>
          <td width="10%" colspan="-6" align="center" bgcolor="#FFFFFF"><strong>密码</strong></td>
          <td width="20%" colspan="-6" align="center" bgcolor="#FFFFFF"><strong>其他</strong></td>
        </tr>
        <tr>
          <td  align="center" bgcolor="#FFFFFF"><%=vpnaddress %></td>
           <td colspan="-6" align="center"><%=vpnuser %></td>
           <td colspan="-6" align="center"><%=vpnpass %></td>
          <td colspan="-5" rowspan="2" align="center" bgcolor="#FFFFFF"><%=ftpaddress %></td>
          <td colspan="-6" align="center"><%=ftpuser %></td>
          <td colspan="-6" align="center"><%=ftppass %></td>
          <td colspan="-6" align="center" bgcolor="#FFFFFF">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="-6" align="center" bgcolor="#FFFFFF">&nbsp;</td>
          <td colspan="-6" align="center" bgcolor="#FFFFFF">&nbsp;</td>
          <td colspan="-6" align="center" bgcolor="#FFFFFF">&nbsp;</td>
          <td colspan="-6" align="center" bgcolor="#FFFFFF">&nbsp;</td>
          <td colspan="-6" align="center" bgcolor="#FFFFFF">&nbsp;</td>
          <td colspan="-6" align="center" bordercolor="#999999" bgcolor="#FFFFFF">&nbsp;</td>
        </tr>
      </table>
  </div>
   --><div style="height:10px"></div>
   <table width="90%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999">
    <tr align="right" >
    <input type="hidden" name="flowid"  id="flowid" value="<%=flowid %>" />
    <input type="hidden" name="stepno"  id="stepno" value="<%=stepno %>" />
				<a href="#" onClick="javascript:redo();" class="easyui-linkbutton"
					data-options="iconCls:'icon-redo'">关闭</a>
					</tr>
					 </table>
					 <div style="height:10px"></div>
					 <div style="height:10px"></div>
</div>
</body>
</html>
