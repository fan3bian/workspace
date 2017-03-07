<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
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
<script type="text/javascript">
function selectChange(){
	debugger;
	$("#agioPrice").text("");
	var aigonum=$("#agio").val();
	var aigoPrice=Number(${sumPrice})*(1-Number(aigonum));
	$("#agioPrice").text(aigoPrice);
} 
function save(){
		if ($('#tableform').form('validate')) {
			$('#submitBtn').linkbutton('disable');
		$('#tableform').form('submit',{
	    url:'${ctx}/lb/saveLbOrderDetail.do',
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
      <th height="60" colspan="12" bgcolor="#0B52D7" class="header" scope="col">负载均衡报价单</th>
    </tr>
    <tr >
      <th colspan="12" align="left" class="bg" scope="col">用户及应用信息</th>
    </tr>
    <tr>
      <td width="15%" rowspan="2" align="center" bgcolor="#66CC99"><strong>实例名称</strong></td>
      <td colspan="7" align="center"><strong>配置说明</strong></td>
      <td width="7%" rowspan="2" align="center"><strong>时长(个月)</strong></td>
      <td width="9%" rowspan="2" align="center"><strong>单价<br/>(元/月)</strong></td>
      <td width="10%" rowspan="2" align="center"><strong>数量</strong></td>
      <td width="14%" rowspan="2" align="center"><strong>年服务费小计<br />(元)</strong></td><!-- 按年计算 -->
    </tr>
    <tr>
      <td width="5%" align="center"><strong>CPU<br/>(核)</strong></td>
      <td width="4%" align="center"><strong>内存<br/>(G)</strong></td>
      <td width="4%" align="center"><strong>硬盘<br/>(G)</strong></td>
      <td width="10%" align="center"><strong>操作系统</strong></td>
      <td width="8%" align="center"><p><strong>实例类型</strong></p></td>
      <td width="8%" align="center"><p><strong>最大连接数<br/>(个)</strong></p></td>
      <td width="7%" align="center"><strong>地域</strong></td>
    </tr>
   	<c:if test="${fn:length(lbWorkFlowVos) > 0}">
		<c:forEach items="${lbWorkFlowVos}" var="vo">
		    <tr>
		      <td align="center">${vo.displayname}</td>
		      <td align="center">${vo.cpunum}</td>
		      <td align="center">${vo.memnum}</td>
		      <td align="center">${vo.disknum}</td>
		      <td align="center">${vo.osname}</td>
		      <td align="center">
		      	<c:if test="${vo.instatype eq '1'}">私有网络</c:if>
   		      	<c:if test="${vo.instatype eq '2'}">公网</c:if>
		      </td>
		      <td align="center">${vo.connnum}</td>
		      <td align="center">${vo.regionname}</td>
		      <td align="center">${vo.tlong}</td>
		      <td align="center">${vo.tprice}</td>
		      <td align="center">${vo.number}</td>
		      <td align="center">${vo.snote}</td>
		    </tr>
	   </c:forEach>
   </c:if>
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
      <td colspan="4" align="center"><strong>${sumPrice}</strong></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><strong>折扣</strong></td>
      <td align="center"> 
        <select name="agio" id="agio"style="width:100%" onchange="selectChange()">
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
      <td align="center"><strong id="agioPrice">${sumPrice}</strong></td>
    </tr>
  </table>
   <div style="height:10px"></div>
   <table width="90%" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999">
    <tr align="right" >
    <input type="hidden" name="flowid"  id="flowid" value="${flowid}" />
    <input type="hidden" name="stepno"  id="stepno" value="${stepno}" />
				<a href="#" onClick="javascript:save();" class="easyui-linkbutton"
					data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;&nbsp; <a
					href="#" onClick="javascript:redo();" class="easyui-linkbutton"
					data-options="iconCls:'icon-redo'">关闭</a>
					</tr>
					 </table>
					 </form>
</div>