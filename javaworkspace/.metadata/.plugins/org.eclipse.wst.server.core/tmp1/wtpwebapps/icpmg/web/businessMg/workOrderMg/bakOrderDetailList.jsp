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
        String str1 = vo1.getAuser();
        String str2 = 	String.valueOf(vo1.getCpunum());
        String str3 = 	String.valueOf(vo1.getMemnum());
        String str4 = 	String.valueOf(vo1.getDisknum());
        String str5 = 	vo1.getOsname();
        System.out.println("str1="+str1);
        %>
      <tr>
        <td align="center"><%=str1%></td>
      <td align="center" id="detail<%=str1%>">应用服务器<%=str1%></td>
      <td align="center" id="cpunum<%=str1%>"><%=str2%></td>
      <td align="center" id="memnum<%=str1%>"><%=str3%></td>
      <td align="center"><%=str4%></td>
      <td align="center"><%=str5%></td>
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
        String imode = vo1.getAtime();
        String str1 = vo1.getAuser();
        String str2 = 	String.valueOf(vo1.getIpnum());
        String str3 = 	vo1.getCuserid();
        String str4 = 	vo1.getCtime();
        String str5 = 	vo1.getAtime();
        String str6 = 	vo1.getInterbw();
        System.out.println("str2="+str1);
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
        <td align="center"><%=str1%></td>
      <td align="center"><%=imode%></td>
      <td align="center"><%=str2%></td>
      <td align="center"><%=str3%></td>
      <td align="center"><%=str4%></td>
      <td align="center"><%=str6%></td>
      <td align="center"></td>
      </tr>
      <%  
        }
     %>
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
  <table width="95%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999" align="center">
    <tr align="left">
      <th colspan="7" scope="col">数量时长信息 </th>
    </tr>
    <tr>
 	<td width="15%" rowspan="1" align="center" bgcolor="#66CC99"><strong>虚拟机序号</strong></td>
      <td colspan="1" align="center"><strong>配置说明</strong></td>
      <td width="7%" rowspan="1" align="center"><strong>时长(月)</strong></td>
      <td width="9%" rowspan="1" align="center"><strong>单价<br />(元/月)</strong></td>
      <td width="10%" rowspan="1" align="center"><strong>数量</strong></td>
      <td width="14%" rowspan="1" colspan="2" align="center"><strong>年服务费小计<br />(元)</strong></td>
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
      <td align="center"><%=vo1.getAtime()%></td>
      <td align="center"><%=vo1.getTlong()%></td>
      <td align="center"><%=vo1.getTprice()%></td>
      <td align="center"><%=vo1.getServernum()%></td>
      <td align="center" colspan="2"><%=vo1.getSnote()%></td>
    </tr>
    <%} %>
   </table>
  <div style="height:10px"></div>
   <table width="90%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999">
    <tr align="right" >
    <input type="hidden" name="flowid"  id="flowid" value="<%=flowid %>" />
				<a href="#" id="listsave" class="easyui-linkbutton"
					data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;&nbsp;<a
					href="#" onClick="javascript:redo();" class="easyui-linkbutton"
					data-options="iconCls:'icon-redo'">关闭</a>
					</tr>
					 </table>
</div>
<script type="text/javascript">
	
	$().ready(function (){
		
		var mems ={
				"1":["2","4"],
				"2":["2","4","8","16"],
				"4":["4","8","12","16","24","32"],
				"8":["8","16","24","32","64"],
				"16":["32","64"],
				"32":["64"],
				
		}
		var cpumem = [1,2,4,8,16,32]
		/**
		验证cpu离开时 内存和cpu的数量是否相匹配
		*/
	 	function blurcpu(cpunum){
		
		}
		var cputds = $("#baseinfo >tbody >tr >td[id^='cpunum']");
		cputds.each(function(i){
			var that = $(this);
		   $(this).bind("dblclick",function (){
			   
			   var selectStr = "<select id='cpuedit' name='cpuedit' >"+
			   " <option value='1'>1</option><option value='2'>2</option><option value='4'>4</option>"+
			   " <option value='8'>8</option><option value='16'>16</option><option value='32'>32</option>"+
			   " </select>";
		        $(this).html(selectStr); 
		        $("#cpuedit").die().live('blur',function (){
				 	var cpunum = $(this).val();
				 	var _obj =$(this).parent().next().text();
				 	 $(this).parent().text(cpunum);
					 var exist = $.inArray(parseInt(_obj) + '', mems[cpunum]);
					 if (exist != -1) {
						 that.css("background-color","");
						  that.next().css("background-color","");
					 } else {
					     alert("您改变了cpu的数量，和内存的设置不匹配，请修改内存参数或者cpu参数！");
					    that.css("background-color","red");
					    that.next().css("background-color","red");
					     return false;
					 }
			   }); 
		   });
	 	});
		
		
		var memtds = $("#baseinfo >tbody >tr >td[id^='memnum']");
		memtds.each(function(i) {
		    $(this).bind("dblclick",
		    function() {
		        var cpunum = $(this).prev().html();
		        var arrmem = mems[cpunum];

		        var selectStr = "<select id='memedit' >";
		        for (i = 0; i < arrmem.length; i++) {
		            selectStr += "<option value='" + arrmem[i] + "'>" + arrmem[i] + "G</option>";
		        }
		        selectStr += "</select>";

		        $(this).html(selectStr);

		        $("#memedit").die().live('blur',
		        function() {
		            var memnum = $(this).val();
		            $(this).parent().text(memnum);
		        });
		    });
		});
		
		
		$("#listsave").click(function (){
			
			alert("列表数据保存");
		});
	});
	
	</script>
</body>
</html>
