<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java" %>

<body class="easyui-layout" data-options="fit:true,border:false" >

<script type="text/javascript" charset="utf-8">
var showResourceApply = function(whouser) {
	switch(whouser){
		case 'fwqInit':
			$('#centerTab').panel({
				href:"${pageContext.request.contextPath}/createServerItem.do"
			});
			break;
		case 'zyInit':
			$('#centerTab').panel({
				href:"${pageContext.request.contextPath}/resourceApply.do?pid=0000000013"
			});
			break;
	}
	//var dialog = parent.icp.modalDialog({
	//	title : '云服务器申请工单',
		//url : "${pageContext.request.contextPath}/createServerItem.do"
	//});
};
var showUserInitWorkOrder = function(whouser){
	switch(whouser){
		case 'zhf':
			$('#centerTab').panel({
				href:"${pageContext.request.contextPath}/zhfInitWorkOrder.do"
			});
			break;
		case 'qy':
			$('#centerTab').panel({
				href:"${pageContext.request.contextPath}/qyInitWorkOrder.do"
			});
			break;
	};
};
</script>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
       
        <tr>
          <td width="5%" height="5">&nbsp;</td>
          <td width="95%" class="ys_07">请选择工单类型</td>
        </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="5%" rowspan="2" align="center">&nbsp;</td>
          <td width="11%" rowspan="2" align="left" class="ys_00"><span class="ys_08">资源申请</span></td>
          <td width="14%" height="80" align="center"><img onclick="showResourceApply('zyInit')" src="${pageContext.request.contextPath}/images/workorder/ordermenu/cunchu_01.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center"><img onclick="showResourceApply('fwqInit');" src="${pageContext.request.contextPath}/images/workorder/ordermenu/fuwuqi_01.png" width="76" height="76" /></td>
          <!--<td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/fuwuqi_03.png" width="76" height="76" /></td> -->
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/shujuku_03.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/tuoguan_03.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/rongzai_03.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/yuqing_03.png" width="76" height="76" /></td>
        </tr>
        <tr>
          <td align="center" class="zyzx">政务云</td>
          <td align="center" class="zyzx">服务器</td>
          <!-- <td align="center" class="zyzx">存储</td> -->
          <td align="center" class="zyzx">数据库</td>
          <td align="center" class="zyzx">托管</td>
          <td align="center" class="zyzx">容灾</td>
          <td align="center" class="zyzx">舆情</td>
        </tr>
    </table>
     
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="40" align="center" valign="middle"><img src="${pageContext.request.contextPath}/images/workorder/henggang_02.png" width="794" height="22" /></td>
        </tr>
    </table>
     
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="5%" rowspan="2" align="center">&nbsp;</td>
          <td width="11%" rowspan="2" align="left" class="ys_00"><span class="ys_08">用户注册</span></td>
          <td width="14%" height="80" align="center"><img onclick="showUserInitWorkOrder('zhf');" src="${pageContext.request.contextPath}/images/workorder/ordermenu/zhengfuuser_01.png" width="76" height="76" /></td>
         <td width="14%" height="80" align="center"><img onclick="showUserInitWorkOrder('qy');" src="${pageContext.request.contextPath}/images/workorder/ordermenu/qiyeuser_01.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center">&nbsp;</td>
          <td width="14%" height="80" align="center">&nbsp;</td>
          <td width="14%" height="80" align="center">&nbsp;</td>
          <td width="14%" height="80" align="center">&nbsp;</td>
          <td width="14%" height="80" align="center">&nbsp;</td>
        </tr>
     
      
        <tr>
          <td align="center" class="zyzx">政府用户</td>
         <td align="center" class="zyzx">企业用户</td>
          <td align="center" class="zyzx">&nbsp;</td>
          <td align="center" class="zyzx">&nbsp;</td>
          <td align="center" class="zyzx">&nbsp;</td>
          <td align="center" class="zyzx">&nbsp;</td>
          <td align="center" class="zyzx">&nbsp;</td>  
        </tr>
    </table>
   
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="40" align="center" valign="middle"><img src="${pageContext.request.contextPath}/images/workorder/henggang_02.png" width="794" height="22" /></td>
        </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="5%" rowspan="2" align="center">&nbsp;</td>
          <td width="11%" rowspan="2" align="left" class="ys_00"><span class="ys_08">外宣申请</span></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/chanpjieshao_03.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/anli_03.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/fuwushequ_03.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/dongtainews_03.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center">&nbsp;</td>
          <td width="14%" height="80" align="center">&nbsp;</td>
        </tr>
        <tr>
          <td align="center" class="zyzx">产品介绍</td>
          <td align="center" class="zyzx">客户案例</td>
          <td align="center" class="zyzx">服务社区</td>
          <td align="center" class="zyzx">动态新闻</td>
          <td align="center" class="zyzx">&nbsp;</td>
          <td align="center" class="zyzx">&nbsp;</td>
        </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="40" align="center" valign="middle"><img src="${pageContext.request.contextPath}/images/workorder/henggang_02.png" width="794" height="22" /></td>
        </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="5%" rowspan="2" align="center">&nbsp;</td>
          <td width="11%" rowspan="2" align="left" class="ys_00"><span class="ys_08">资源注销</span></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/fuwuqi_03.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/cunchu_03.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/shujuku_03.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/tuoguan_03.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/rongzai_03.png" width="76" height="76" /></td>
          <td width="14%" height="80" align="center"><img style="cursor:default" src="${pageContext.request.contextPath}/images/workorder/ordermenu/yuqing_03.png" width="76" height="76" /></td>
        </tr>
        <tr>
          <td align="center" class="zyzx">服务器</td>
          <td align="center" class="zyzx">存储</td>
          <td align="center" class="zyzx">数据库</td>
          <td align="center" class="zyzx">托管</td>
          <td align="center" class="zyzx">容灾</td>
          <td align="center" class="zyzx">舆情</td>
        </tr>
    </table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
  	<tr>
    <td height="26">&nbsp;</td>
  	</tr>
	</table>
</body>

