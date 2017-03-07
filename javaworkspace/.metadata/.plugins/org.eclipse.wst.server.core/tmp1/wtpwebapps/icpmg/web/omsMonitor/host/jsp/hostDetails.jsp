<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>物理机详情界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <%  
		String neid=request.getParameter("neid");  
	%> 
  <body>
  <input type="hidden" id="hostDetailneid" value="<%=neid %>"></input>
  		<link rel="stylesheet" href="${pageContext.request.contextPath}/web/omsMonitor/host/css/hostDetails.css" />
  		<link rel="stylesheet" href="${pageContext.request.contextPath}/web/omsMonitor/host/css/jquery.bigpage.css" />
		
		<script type="text/javascript"  src="${pageContext.request.contextPath}/web/omsMonitor/host/js/jquery.bigpage.js" charset="UTF-8"></script>
	
		<script type="text/javascript">
			$(document).ready(function() {
				queryhostBasic();
				queryhostAlarm();
				queryhostVm();
				
			});
			
			//查询基本信息
			function queryhostBasic(){
				var neid = $("#hostDetailneid").val();
				//var neid = 'jxwshxxhc-cq20199292993000385';
				$('#queryHostBasic').form(
						'load',
						"${pageContext.request.contextPath}/oms_summary/queryBasicInfo.do?neid="+neid
				);
			};
			//查询告警信息
			function queryhostAlarm(){
				var neid = $("#hostDetailneid").val();
				$("#hostDetailTable_alarm").bigPage({
					data:null,
					ajaxData:{
						url :' ${pageContext.request.contextPath}/oms_summary/queryAlarmEvent.do?almCategory=HOST&neid='+neid,
								params:{}
						},
						pageSize:10,
						maxPageNumCount:10
					});
			}
			
			//查询虚机信息
			function queryhostVm(){
				var neid = $("#hostDetailneid").val();
				//var neid = '172.23.8.200';
				$("#hostDetailTable_vm").bigPage({
					data:null,
					ajaxData:{
						url :' ${pageContext.request.contextPath}/oms_summary/queryVmLists.do?almCategory='+neid,
								params:{}
						},
						pageSize:10,
						maxPageNumCount:10
					});
			}
			
			function JumpHostPage(){
				var neid = $("#hostDetailneid").val();
				$('#centerTab').panel({
					href:'/icpmg/web/omsMonitor/inhost/jsp/runOverview.jsp',
					queryParams:{
						typeid:'HOST',
						neid:neid
					}
				});	
			}
		</script>
		
	  	<div class="inhostDetails_Container">
	  		<form id="queryHostBasic" method="post">
	  		<div class="inhostDetails_space top">
	  			<div class = "inhostDetails_space_top top_1" style="width: 10%">
	  				<div class="top_1_span">基本信息</div>
	  				<div class="top_1_backgroud"></div>
	  			</div>
	  			<div class = "inhostDetails_space_top_o" style="width: 25%">
	  				<div class="top_3_span">
	  					<div class="top_3_span_top">
	  						<span style="height: 58px;line-height: 58px;">服务器名称：</span><input readonly id="hostdetailneid" name='nename' style="float: right ;"></input>
	  					</div>
	  				</div>
	  			</div>
	  			<div class = "inhostDetails_space_top_o" style="width: 24%">
	  				<div class="top_3_span">
	  					
	  					<div class="top_3_span_top">
	  						<span style="height: 58px;line-height: 58px;">IP地址：</span><input readonly id="hostdetailipaddr" name='ipaddr' style="float: right ;"></input>
	  					</div>
	  				</div>
	  			</div>
	  			<div class = "inhostDetails_space_top_o" style="width: 24%">
	  				<div class="top_3_span">
	  					<div class="top_3_span_top">
	  						<span style="height: 58px;line-height: 58px;">运维应用：</span><input readonly id="hostdetailappstat" name='appstat' style="float: right ;color: #ffa300;"></input>
	  					</div>
	  				</div>
	  			</div>
	  			<div class = "inhostDetails_space_top" style="width: 15%;">
	  				<div  class="inhostDetails_space_top_btn" onclick='JumpHostPage()'>
	  					返回
	  				</div>
	  			</div>
	  		</div>
	  		<div class="work-text">
				<section class="ac-container">
					<div>
						<input id="ac-1" name="accordion-1" type="checkbox" />
						<label for="ac-1" class="grid1"><i></i>基本信息</label>
						<article class="ac-smallone">
							<table border="1" align="center" style="width:98%" id="inhostDetailTable">
								<tr>
									<td class='inhostDetail_FieldLabel2'> 设备编码：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly   name='neid'></input></td>
									<td class='inhostDetail_FieldLabel2'> 设备名称：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='nename'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> 设备类型：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='typename'></input></td>
									<td class='inhostDetail_FieldLabel2'> 设备型号：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='omodel'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> 域名：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='ipname'></input></td>
									<td class='inhostDetail_FieldLabel2'> mac：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='macaddr'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> IP地址：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='ipaddr'></input></td>
									<td class='inhostDetail_FieldLabel2'> 业务IP：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='sip'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>展示名称：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='displayname'></input></td>
									<td class='inhostDetail_FieldLabel2'> 厂商名称：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='vendorname'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>资源位置：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='slocation'></input></td>
									<td class='inhostDetail_FieldLabel2'> 资源用途：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='useinfo'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>管理状态：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='adstat'></input></td>
									<td class='inhostDetail_FieldLabel2'> 操作状态：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='opstat'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>费用状态：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='feestat'></input></td>
									<td class='inhostDetail_FieldLabel2'> 设备等级：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly  name='nelevel'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>删除标志：</td>
									<td class='inhostDetail_FieldLabel2' ><input readonly  name='deleteflag'></input></td>
									<td class='inhostDetail_FieldLabel2' > </td>
									<td class='inhostDetail_FieldLabel2' > </td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>备注：</td>
									<td class='inhostDetail_FieldLabel2' ><input readonly  name='remark'></input></td>
									<td class='inhostDetail_FieldLabel2' > </td>
									<td class='inhostDetail_FieldLabel2' > </td>
								</tr>
							</table>
						</article>
					</div>
					<div>
						<input id="ac-2" name="accordion-1" type="checkbox" />
						<label for="ac-2" class="grid2"><i></i>维护信息</label>
						<article class="ac-smalltwo">
							<table border="1" align="center" style="width:98%" id="inhostDetailTable">
								<tr>
									<td class='inhostDetail_FieldLabel2'> 录入人：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='insertman'></input></td>
									<td class='inhostDetail_FieldLabel2'> 维护人：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='opuser'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>创建时间：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='buytime'></input></td>
									<td class='inhostDetail_FieldLabel2'> 试运行时间：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='testtime'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>入网时间：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='usetime'></input></td>
									<td class='inhostDetail_FieldLabel2'> 退网时间：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='useendtime'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>配置更新时间：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='ctime'></input></td>
									<td class='inhostDetail_FieldLabel2'>性能更新时间：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='ptime'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>告警更新时间：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='ftime'></input></td>
									<td class='inhostDetail_FieldLabel2'>最后更新时间：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='infotime'/></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>软件版本：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='softver'/></td>
									<td class='inhostDetail_FieldLabel2'></td>
									<td class='inhostDetail_FieldLabel2'></td>
								</tr>
							</table>
						</article>
					</div>
					<div>
						<input id="ac-3" name="accordion-1" type="checkbox" />
						<label for="ac-3" class="grid3"><i></i>归属层级</label>
						<article class="ac-smallthree">
							<table border="1" align="center" style="width:98%" id="inhostDetailTable">
								<tr>
									<td class='inhostDetail_FieldLabel2'> 区域：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='Nodename'></input></td>
									<td class='inhostDetail_FieldLabel2'> 省：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='provname'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> 地市：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='cityname'></input></td>
									<td class='inhostDetail_FieldLabel2'> </td>
									<td class='inhostDetail_FieldLabel2'></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> 机房：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='bidname'></input></td>
									<td class='inhostDetail_FieldLabel2'> 所属资源池：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='poolname'></input></td>
								</tr>
							</table>
						</article>
					</div>
					<div>
						<input id="ac-4" name="accordion-1" type="checkbox" />
						<label for="ac-4" class="grid4"><i></i>租户信息</label>
						<article class="ac-smallfour">
							<table border="1" align="center" style="width:98%" id="inhostDetailTable">
								<tr>
									<td class='inhostDetail_FieldLabel2'> 申请人：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='Suserid'></input></td>
									<td class='inhostDetail_FieldLabel2'> 部署的应用程序：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='appmodel'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> 一级归属：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='groupid'></input></td>
									<td class='inhostDetail_FieldLabel2'> 二级归属：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='Puserid'></span></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> 归属单位：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='unitname'></input></td>
									<td class='inhostDetail_FieldLabel2'>网络类型：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='networktypename'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>项目名称：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='projectname'></input></td>
									<td class='inhostDetail_FieldLabel2'>应用名称：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='appname'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>一级服务类型：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='servertypenamelevelfirst'></input></td>
									<td class='inhostDetail_FieldLabel2'>二级服务类型：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='servertypenamesecond'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>服务开始时间：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='sbegin'></input></td>
									<td class='inhostDetail_FieldLabel2'>服务结束时间：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='send'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>订单编码：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='orderid'></input></td>
									<td class='inhostDetail_FieldLabel2'>流程编码：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='flowid'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>详细编码：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='detailid'></input></td>
									<td class='inhostDetail_FieldLabel2'>运行状态：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='curstat'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'>价格：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='perprice'></input></td>
									<td class='inhostDetail_FieldLabel2'>VLAN编码：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='vlanid'></input></td>
								</tr>
							</table>
						</article>
					</div>
					<div>
						<input id="ac-5" name="accordion-1" type="checkbox" />
						<label for="ac-5" class="grid5"><i></i>告警信息</label>
						<article class="ac-smallfive">
							<div class="ac-smallfive_space">
								<table border="1" align="center" style="width:98%" id="hostDetailTable_alarm">
									<thead>
										<tr>
											<th>设备</th>
											<!--<th>厂商</th>-->
											<th>IP</th>
											<th>发生时间</th>
											<th>事件标题</th>
											<th>事件类型</th>
											<th>事件级别</th>
											<th>确认人</th>
											<th>确认时间</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</article>
					</div>
					<div>
						<input id="ac-6" name="accordion-1" type="checkbox" />
						<label for="ac-6" class="grid6"><i></i>配置信息</label>
						<article class="ac-smallsix">
							<table border="1" align="center" style="width:98%" name="inhostDetailTable">
								<tr>
									<td class='inhostDetail_FieldLabel2'> 所属平台：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='platformid'></input></td>
									<td class='inhostDetail_FieldLabel2'></td>
									<td class='inhostDetail_FieldLabel2'></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> 数据中心：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='datacenter'></input></td>
									<td class='inhostDetail_FieldLabel2'> 集群：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='cluster'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> 物理机：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='hostname'></input></td>
									<td class='inhostDetail_FieldLabel2'> 物理存储：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='STORAGE'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> 模板：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='templateid'></input></td>
									<td class='inhostDetail_FieldLabel2'></td>
									<td class='inhostDetail_FieldLabel2'></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> cpu颗数(个)：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='cpunum'></input></td>
									<td class='inhostDetail_FieldLabel2'> 内存大小(G)：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='memnum'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> 操作系统：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='osname'></input></td>
									<td class='inhostDetail_FieldLabel2'> 杀毒软件：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='antivirus'></input></td>
								</tr>
								<tr>
									<td class='inhostDetail_FieldLabel2'> 是否可用：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='haenable'></input></td>
									<td class='inhostDetail_FieldLabel2'> 数据盘：</td>
									<td class='inhostDetail_FieldLabel2'><input readonly name='disknum'></input></td>
								</tr>
							</table>
						</article>
					</div>
					<div>
						<input id="ac-7" name="accordion-1" type="checkbox" />
						<label for="ac-7" class="grid7"><i></i>虚机信息</label>
						<article class="ac-smallseven">
							<div class="ac-smallseven_space">
								<table border="1" align="center" style="width:98%" id="hostDetailTable_vm">
									<thead>
										<tr>
											<th>名称</th>
											<th>编码</th>
											<th>IP</th>
											<th>创建人</th>
											<th>创建时间</th>
											<th>状态</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</article>
					</div>
				</section>
			</div>
			</form>
	  	</div>
  </body>
</html>
